Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 034F371699C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:32:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42Gs-0005jr-9b; Tue, 30 May 2023 12:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q42Ge-0005fP-DI
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:32:16 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q42Gc-0007yj-5P
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:32:16 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.243])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 30BFA207F5;
 Tue, 30 May 2023 16:32:12 +0000 (UTC)
Received: from kaod.org (37.59.142.103) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 30 May
 2023 18:32:11 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005d373045d-6a70-4333-8ce2-0b1db3eb68d8,
 1689548285A2663F4093CB2B261AE0EDF3FE8C9C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d561b9e1-feee-6f0f-d8a0-ad7363b1fdb5@kaod.org>
Date: Tue, 30 May 2023 18:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] pnv/xive2: Add definition for the ESB cache
 configuration register
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
References: <20230530161129.313258-1-fbarrat@linux.ibm.com>
 <20230530161129.313258-3-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230530161129.313258-3-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 7e7a0904-815b-4cd1-b56f-1f4b441dac13
X-Ovh-Tracer-Id: 2669508680668515296
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeetgeehudegieffkeeftdelffdtjeelfeeggeetlefgudejgefgfeeiveeutdffheenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtfedpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegtlhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepfhgsrghrrhgrtheslhhinhhugidrihgsmhdrtghomhdpuggrnhhivghlhhgsgedufeesghhmrghilhdrtghomhdpqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhohedvledpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/30/23 18:11, Frederic Barrat wrote:
> Add basic read/write support for the ESB cache configuration register
> on P10. We don't model the ESB cache in qemu so reading/writing the
> register won't do anything, but it avoids logging a guest error when
> skiboot configures it:
> 
> qemu-system-ppc64 -machine powernv10 ... -d guest_errors
>        ...
> XIVE[0] - VC: invalid read @240
> XIVE[0] - VC: invalid write @240
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/intc/pnv_xive2.c      | 7 +++++++
>   hw/intc/pnv_xive2_regs.h | 4 ++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 889e409929..a75ff270ac 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -955,6 +955,10 @@ static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
>           val = xive->vc_regs[reg];
>           break;
>   
> +    case VC_ESBC_CFG:
> +        val = xive->vc_regs[reg];
> +        break;
> +
>       /*
>        * EAS cache updates (not modeled)
>        */
> @@ -1046,6 +1050,9 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
>           /* ESB update */
>           break;
>   
> +    case VC_ESBC_CFG:
> +        break;
> +
>       /*
>        * EAS cache updates (not modeled)
>        */
> diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
> index 8f1e0a1fde..7165dc8704 100644
> --- a/hw/intc/pnv_xive2_regs.h
> +++ b/hw/intc/pnv_xive2_regs.h
> @@ -232,6 +232,10 @@
>   #define  VC_ESBC_FLUSH_POLL_BLOCK_ID_MASK       PPC_BITMASK(32, 35)
>   #define  VC_ESBC_FLUSH_POLL_OFFSET_MASK         PPC_BITMASK(36, 63) /* 28-bit */
>   
> +/* ESBC configuration */
> +#define X_VC_ESBC_CFG                           0x148
> +#define VC_ESBC_CFG                             0x240
> +
>   /* EASC flush control register */
>   #define X_VC_EASC_FLUSH_CTRL                    0x160
>   #define VC_EASC_FLUSH_CTRL                      0x300


