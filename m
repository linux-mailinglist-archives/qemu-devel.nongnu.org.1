Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF0F71699D
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:32:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42GR-0005bv-7d; Tue, 30 May 2023 12:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1q42GO-0005bT-Ul; Tue, 30 May 2023 12:32:00 -0400
Received: from smtpout3.mo529.mail-out.ovh.net ([46.105.54.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1q42GM-0007vI-9Y; Tue, 30 May 2023 12:32:00 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.83])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 6568420827;
 Tue, 30 May 2023 16:31:54 +0000 (UTC)
Received: from kaod.org (37.59.142.105) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 30 May
 2023 18:31:51 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006c0f52339-5dd5-434c-80e0-83efea0cad05,
 1689548285A2663F4093CB2B261AE0EDF3FE8C9C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <c46dd69a-4f7f-ac7c-67fc-2aad07e4c1ab@kaod.org>
Date: Tue, 30 May 2023 18:31:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/4] pnv/xive2: Add definition for TCTXT Config register
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
References: <20230530161129.313258-1-fbarrat@linux.ibm.com>
 <20230530161129.313258-2-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230530161129.313258-2-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: b474501c-6d15-4cd9-a622-2793adeaa154
X-Ovh-Tracer-Id: 2663879183568112608
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeetgeehudegieffkeeftdelffdtjeelfeeggeetlefgudejgefgfeeiveeutdffheenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddthedpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegtlhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepfhgsrghrrhgrtheslhhinhhugidrihgsmhdrtghomhdpuggrnhhivghlhhgsgedufeesghhmrghilhdrtghomhdpqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhohedvledpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=46.105.54.81; envelope-from=clg@kaod.org;
 helo=smtpout3.mo529.mail-out.ovh.net
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
> Add basic read/write support for the TCTXT Config register on P10. qemu
> doesn't do anything with it yet, but it avoids logging a guest error
> when skiboot configures the fused-core state:
>
> qemu-system-ppc64 -machine powernv10 ... -d guest_errors
>    ...
> [    0.131670000,5] XIVE: [ IC 00  ] Initializing XIVE block ID 0...
> XIVE[0] - TCTXT: invalid read @140
> XIVE[0] - TCTXT: invalid write @140

Reviewed-by: Cédric Le Goater <clg@kaod.org>

If you respin, please add the same kind of support to POWER9.

Thanks,

C.


> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---
>   hw/intc/pnv_xive2.c      | 8 +++++++-
>   hw/intc/pnv_xive2_regs.h | 4 ++++
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 7176d70234..889e409929 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1265,6 +1265,9 @@ static uint64_t pnv_xive2_ic_tctxt_read(void *opaque, hwaddr offset,
>       case TCTXT_EN1_RESET:
>           val = xive->tctxt_regs[TCTXT_EN1 >> 3];
>           break;
> +    case TCTXT_CFG:
> +        val = xive->tctxt_regs[reg];
> +        break;
>       default:
>           xive2_error(xive, "TCTXT: invalid read @%"HWADDR_PRIx, offset);
>       }
> @@ -1276,6 +1279,7 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
>                                        uint64_t val, unsigned size)
>   {
>       PnvXive2 *xive = PNV_XIVE2(opaque);
> +    uint32_t reg = offset >> 3;
>   
>       switch (offset) {
>       /*
> @@ -1297,7 +1301,9 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
>       case TCTXT_EN1_RESET:
>           xive->tctxt_regs[TCTXT_EN1 >> 3] &= ~val;
>           break;
> -
> +    case TCTXT_CFG:
> +        xive->tctxt_regs[reg] = val;
> +        break;
>       default:
>           xive2_error(xive, "TCTXT: invalid write @%"HWADDR_PRIx, offset);
>           return;
> diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
> index 0c096e4adb..8f1e0a1fde 100644
> --- a/hw/intc/pnv_xive2_regs.h
> +++ b/hw/intc/pnv_xive2_regs.h
> @@ -405,6 +405,10 @@
>   #define X_TCTXT_EN1_RESET                       0x307
>   #define TCTXT_EN1_RESET                         0x038
>   
> +/* TCTXT Config register */
> +#define X_TCTXT_CFG                             0x328
> +#define TCTXT_CFG                               0x140
> +
>   /*
>    * VSD Tables
>    */


