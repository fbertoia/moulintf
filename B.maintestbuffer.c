/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   maintestbuffer.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fbertoia <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/01/11 22:02:30 by fbertoia          #+#    #+#             */
/*   Updated: 2018/02/04 18:21:33 by fbertoia         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include "ft_printf.h"
#include <locale.h>
#include <limits.h>
#define BUFF_SIZE 10000
int main(void)
{	
	char buf[BUFF_SIZE + 1];
	int i = 0;
	int j = 0;
	
	while (i < BUFF_SIZE)
		buf[i++]= '.';
	buf[i] = 0;
	i = printf("%s\n", buf);
	i = ft_printf("%s\n", buf);
	printf(" The real printf returns %d, yours returns %d \n", i, j);
	return 0;
}
