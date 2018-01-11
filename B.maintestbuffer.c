/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   maintestbuffer.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: fbertoia <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/01/11 22:02:30 by fbertoia          #+#    #+#             */
/*   Updated: 2018/01/11 22:02:31 by fbertoia         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>
#include "ft_printf.h"
#include <locale.h>
#include <limits.h>

int main(void)
{	
	char buf[10000000];
	int i = 0;
	
	while (i < 9999998)
		buf[i]= ' ';
	buf[i] = 0;
	i = printf("%s", buf);
	printf(" i = %d ", i);
	return 0;
}
