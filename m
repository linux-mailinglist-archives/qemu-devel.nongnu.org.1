Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCC093BD9D
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Jul 2024 10:03:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWtR4-0007bj-Oy; Thu, 25 Jul 2024 04:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Lhbq=OZ=kaod.org=clg@ozlabs.org>)
 id 1sWtQr-0007aa-Hd; Thu, 25 Jul 2024 04:02:40 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Lhbq=OZ=kaod.org=clg@ozlabs.org>)
 id 1sWtQm-0007ex-49; Thu, 25 Jul 2024 04:02:35 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WV3JZ1mR4z4wnt;
 Thu, 25 Jul 2024 18:02:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WV3JV2ClXz4wbr;
 Thu, 25 Jul 2024 18:02:17 +1000 (AEST)
Message-ID: <1b2c1e1a-9b20-4416-b659-c2cf0eadcf7a@kaod.org>
Date: Thu, 25 Jul 2024 10:02:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/11] pnv/xive2: Refine TIMA 'info pic' output
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240724212130.26811-1-kowal@linux.ibm.com>
 <20240724212130.26811-11-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240724212130.26811-11-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Lhbq=OZ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/24/24 23:21, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
> 
> In XIVE Gen 2 there were some minor changes to the TIMA header that were
> updated when printed.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/intc/xive.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 70f11f993b..5a02dd8e02 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -692,9 +692,15 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, GString *buf)
>           }
>       }
>   
> -    g_string_append_printf(buf, "CPU[%04x]:   "
> -                           "QW   NSR CPPR IPB LSMFB ACK# INC AGE PIPR  W2\n",
> -                           cpu_index);
> +    if (xive_presenter_get_config(tctx->xptr) & XIVE_PRESENTER_GEN1_TIMA_OS) {
> +        g_string_append_printf(buf, "CPU[%04x]:   "
> +                               "QW   NSR CPPR IPB LSMFB ACK# INC AGE PIPR"
> +                               "  W2\n", cpu_index);
> +    } else {
> +        g_string_append_printf(buf, "CPU[%04x]:   "
> +                               "QW   NSR CPPR IPB LSMFB   -  LGS  T  PIPR"
> +                               "  W2\n", cpu_index);
> +    }
>   
>       for (i = 0; i < XIVE_TM_RING_COUNT; i++) {
>           char *s = xive_tctx_ring_print(&tctx->regs[i * XIVE_TM_RING_SIZE]);


