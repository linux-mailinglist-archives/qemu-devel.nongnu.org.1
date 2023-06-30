Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E875D743E24
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 17:00:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFFbZ-0007BX-WE; Fri, 30 Jun 2023 11:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Okcj=CS=kaod.org=clg@ozlabs.org>)
 id 1qFFbE-0007B3-GO; Fri, 30 Jun 2023 10:59:55 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Okcj=CS=kaod.org=clg@ozlabs.org>)
 id 1qFFb8-0003yz-KA; Fri, 30 Jun 2023 10:59:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qsz4X5bTLz4wbg;
 Sat,  1 Jul 2023 00:59:40 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qsz4W2wLmz4wZn;
 Sat,  1 Jul 2023 00:59:39 +1000 (AEST)
Message-ID: <6d5856ae-101c-036a-e2b9-fa0d02d846d4@kaod.org>
Date: Fri, 30 Jun 2023 16:59:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] pnv/psi: Initialize the PSIHB interrupts to match
 hardware
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230630144243.214976-1-fbarrat@linux.ibm.com>
 <20230630144243.214976-3-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230630144243.214976-3-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Okcj=CS=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/30/23 16:42, Frederic Barrat wrote:
> On P9/P10, the PSIHB interrupts are initialized with a PQ state of
> 0b01, i.e. interrupts are disabled. However the real hardware
> initializes them to 0b00 for the PSIHB. This patch updates it, in case
> an hypervisor is in the mood of checking it.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/ppc/pnv_psi.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 46da58dff8..f232935d27 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -863,6 +863,8 @@ static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
>       object_property_set_int(OBJECT(xsrc), "nr-irqs", PSIHB9_NUM_IRQS,
>                               &error_fatal);
>       object_property_set_link(OBJECT(xsrc), "xive", OBJECT(psi), &error_abort);
> +    object_property_set_int(OBJECT(xsrc), "pq-init", XIVE_ESB_RESET,
> +                            &error_abort);
>       if (!qdev_realize(DEVICE(xsrc), NULL, errp)) {
>           return;
>       }


