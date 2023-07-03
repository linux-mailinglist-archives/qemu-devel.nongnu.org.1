Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D72F745747
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 10:24:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGEqt-0005at-AE; Mon, 03 Jul 2023 04:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGEqg-0005Tu-9b; Mon, 03 Jul 2023 04:23:56 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGEqe-0006ja-Et; Mon, 03 Jul 2023 04:23:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qvf8Q12kqz4wqZ;
 Mon,  3 Jul 2023 18:23:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qvf8N4trcz4wZJ;
 Mon,  3 Jul 2023 18:23:48 +1000 (AEST)
Message-ID: <420852b1-32e9-84b0-7674-c0e0bf98ee71@kaod.org>
Date: Mon, 3 Jul 2023 10:23:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] pnv/xive: Add property on xive sources to define
 PQ state on reset
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230703081215.55252-1-fbarrat@linux.ibm.com>
 <20230703081215.55252-2-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230703081215.55252-2-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=mKPa=CV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 7/3/23 10:12, Frederic Barrat wrote:
> The PQ state of a xive interrupt is always initialized to Q=1, which
> means the interrupt is disabled. Since a xive source can be embedded
> in many objects, this patch adds a property to allow that behavior to
> be refined if needed.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/intc/xive.c        | 8 ++++++--
>   include/hw/ppc/xive.h | 1 +
>   2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 84c079b034..f60c878345 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1232,8 +1232,7 @@ static void xive_source_reset(void *dev)
>   
>       /* Do not clear the LSI bitmap */
>   
> -    /* PQs are initialized to 0b01 (Q=1) which corresponds to "ints off" */
> -    memset(xsrc->status, XIVE_ESB_OFF, xsrc->nr_irqs);
> +    memset(xsrc->status, xsrc->reset_pq, xsrc->nr_irqs);
>   }
>   
>   static void xive_source_realize(DeviceState *dev, Error **errp)
> @@ -1287,6 +1286,11 @@ static Property xive_source_properties[] = {
>       DEFINE_PROP_UINT64("flags", XiveSource, esb_flags, 0),
>       DEFINE_PROP_UINT32("nr-irqs", XiveSource, nr_irqs, 0),
>       DEFINE_PROP_UINT32("shift", XiveSource, esb_shift, XIVE_ESB_64K_2PAGE),
> +    /*
> +     * By default, PQs are initialized to 0b01 (Q=1) which corresponds
> +     * to "ints off"
> +     */
> +    DEFINE_PROP_UINT8("reset-pq", XiveSource, reset_pq, XIVE_ESB_OFF),
>       DEFINE_PROP_LINK("xive", XiveSource, xive, TYPE_XIVE_NOTIFIER,
>                        XiveNotifier *),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 3dfb06e002..9f580a2699 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -187,6 +187,7 @@ struct XiveSource {
>   
>       /* PQ bits and LSI assertion bit */
>       uint8_t         *status;
> +    uint8_t         reset_pq; /* PQ state on reset */
>   
>       /* ESB memory region */
>       uint64_t        esb_flags;


