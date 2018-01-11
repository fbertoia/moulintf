/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fbertoia <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/01/06 11:47:04 by fbertoia          #+#    #+#             */
/*   Updated: 2018/01/06 11:47:06 by fbertoia         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include "ft_printf.h"
#include <locale.h>
#include <limits.h>

int main(void)
{	
	int			*or;
	int			*mr;
	char		**test;
	char*		l;
	int			dec;
	long int	ldec;
	char		c;
	int			i;

	c = 0;
	l = setlocale(LC_ALL, "");
	test = (char **)(long)0x7fff5f17ba14;
	or = (int*)(long)0x7fff56200a08;
	mr = (int*)(long)0x7fff5ece1a18;
	ldec = 3659855789;
	dec = 654321;

	i = 0;
	i = ft_printf( TEST_PRINTF );
	printf(" i = %d ", i);
	return 0;
}
