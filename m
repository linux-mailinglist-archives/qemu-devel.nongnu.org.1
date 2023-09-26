Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C177E7AE762
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 10:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql35G-0001dJ-PQ; Tue, 26 Sep 2023 04:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql358-0001c0-Is
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:06:16 -0400
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1ql357-0008DI-0L
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:06:10 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MtOSu-1reXZp0Md4-00utxp; Tue, 26 Sep 2023 10:06:07 +0200
Message-ID: <43380b39-28f1-c8c8-01fd-7c08e6470488@vivier.eu>
Date: Tue, 26 Sep 2023 10:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 17/20] mac_via: always clear ADB interrupt when
 switching to A/UX mode
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-18-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230909094827.33871-18-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lyBZOlUVCwRQghk6hpnv6sTsU9IwzftOKJp4nTd/4VziQOJOwXT
 jd5V13QrX79FSW10ZazkSEB+BC90pyhG6KE6Id4phCLaJNN0PFOsp956nzA1/abZjDMYIpj
 VUbWgvtnixZThvEDZsIZLV544bRMGfZ17BH4PRTo9q3ZcHakVElbBOsR/5/nwCa0oXak1qI
 1l0kMv4OlT1jlkB57s1Iw==
UI-OutboundReport: notjunk:1;M01:P0:9oXDt9Bh4Z8=;RsElmPrQbNEU2dAlU6crl7H8wGH
 ynFCyjGA+vNXMKnqcaEyu6Zm10MCxvHwXshmrYrHrZUvi3vR39HMGr+6YME2vfF2ANjv8GleU
 XYFsXRd30F59OqBwR9GHDELPPn8LhP2EtqrYXntLhaDjbdT0psxkfXEud96nDGFlrEjGZRLuH
 cELwCiKXzM62WN2tYgExXnsrcAhwsE3COQgdLHGC0IrTO0PvIKZRwyBC8nKl66rxB/r2jv0GX
 dFPxGiteuUlOjfEE1ukZoZflxDt1sMhgD6sN18qV4YXmUNN+ehmprd7tNp6957CBcwe1JW48D
 OObzDyzNcjr+uzOA/LeA/ePpnC0cUJS/eSbrtT6LDnSSEJdivF+SGywTv/0IpCKvVtEIEgb8Z
 qKAgjJytBhMoGUTVVhdIs/NUJ7UqsewEc0yEgblzdEy1vet3cHtifrSUWtY2owcEJpaEh8Yea
 u4rJMBsvabffmN1dQBYExvAHucs41c0davvlURHNN+HebY+EIswe/tkbbgANPjYjq9GC0HQ/6
 a3UU5Mh7lM80OdyBzABUmJ9anMnR/SHtO6B+/yaJ8lWnPw9hyusIR7t8bl/kq/wOAi6dXqeFh
 4icaFc4Ju21/hVlxlK/tb+2mFlMu1vFhTKH9+pnXPcP96D2WAE2hGIyJ7gs6xhWfcfAB3zZEA
 PPMyj2/b2hNd5w5mOfR9VG0WyU20bGIouYR7kZbrphaI/FCH55zhOU8dwb8R3T6SKgY/guV4K
 +fyFzP9Uf7vMxQ9wTLxNy6/6BMLJ8bZ6Rl9RSc+KyrWh1KU/mZEnWuqKQks+/i9ItUP5D/dnP
 az7/0gMcfwN8FGLBfMhcH5U/wc0zJ6mqmf4K2qTR90eqsXcBe6Z3SRUKTZufcOdYxsE5KsL9W
 RQEXslWjvfLyN8g==
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Le 09/09/2023 à 11:48, Mark Cave-Ayland a écrit :
> When the NetBSD kernel initialises it can leave the ADB interrupt asserted
> depending upon where in the ADB poll cycle the MacOS ADB interrupt handler
> is when the NetBSD kernel disables interrupts.
> 
> The NetBSD ADB driver uses the ADB interrupt state to determine if the ADB
> is busy and refuses to send ADB commands unless it is clear. To ensure that
> this doesn't happen, always clear the ADB interrupt when switching to A/UX
> mode to ensure that the bus enumeration always occurs.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/misc/mac_via.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
> index 398e8d1967..5d1adf5863 100644
> --- a/hw/misc/mac_via.c
> +++ b/hw/misc/mac_via.c
> @@ -875,6 +875,15 @@ static void via1_auxmode_update(MOS6522Q800VIA1State *v1s)
>       if (irq != oldirq) {
>           trace_via1_auxmode(irq);
>           qemu_set_irq(v1s->auxmode_irq, irq);
> +
> +        /*
> +         * Clear the ADB interrupt. MacOS can leave VIA1B_vADBInt asserted
> +         * (low) if a poll sequence doesn't complete before NetBSD disables
> +         * interrupts upon boot. Fortunately NetBSD switches to the so-called
> +         * "A/UX" interrupt mode after it initialises, so we can use this as
> +         * a convenient place to clear the ADB interrupt for now.
> +         */
> +        s->b |= VIA1B_vADBInt;
>       }
>   }
>   

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


