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
#define BUFF_SIZE 500000
int main(void)
{
	char buf[BUFF_SIZE + 1];
	int i = 0;
	int j = 0;

	while (i < BUFF_SIZE)
		buf[i++]= '.';
	buf[i] = 0;
	// printf("TEST OF A BIG STRING\n");
	// i = printf("printf :    |%s|\n", buf);
	// j = ft_printf("ft_printf : |%s|\n", buf);
	// printf(" The real printf returns %d, yours returns %d \n", i, j);
	// printf("TEST OF A BIG FORMAT\n");
	// i = printf(buf);
	// j = ft_printf(buf);
	// printf(" The real printf returns %d, yours returns %d \n", i, j);
	buf[0] = 0;
	printf("TEST OF A WIDTH/PRECISION = INT_MIN\n");
	i = printf("printf :    |%2147483648.2147483648s|\n", buf);
	j = ft_printf("ft_printf : |%2147483648.2147483648s|\n", buf);
	printf(" The real printf returns %d, yours returns %d \n", i, j);
	printf("TEST OF A WIDTH/PRECISION = INT_MAX\n");
	i = printf("printf :    |%2147483647.2147483647s|\n", buf);
	printf(" The real printf returns %d\n", i);
	j = ft_printf("ft_printf : |%2147483647.2147483647s|\n", buf);
	printf(" Yours returns %d \n", j);
	printf("TEST OF A WIDTH/PRECISION = INT_MAX\n");
	i = printf("printf :    |%2147483647.2147483647s|\n", buf);
	printf(" The real printf returns %d\n", i);
	j = ft_printf("ft_printf : |%2147483647.2147483647s|\n", buf);
	printf(" Yours returns %d \n", j);
	return 0;
}
