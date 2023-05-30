Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4AB7169D3
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:38:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42MB-0002L7-6Z; Tue, 30 May 2023 12:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q42Ld-0002D2-Ku
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:37:25 -0400
Received: from 4.mo548.mail-out.ovh.net ([188.165.42.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q42Lb-00013j-R8
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:37:25 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.51])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 5F6842043D;
 Tue, 30 May 2023 16:37:21 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 30 May
 2023 18:37:20 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G0048ba3c12b-60dd-40e8-9362-5af7120780b3,
 1689548285A2663F4093CB2B261AE0EDF3FE8C9C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <4b18e320-f167-a2e7-08dd-741de652d573@kaod.org>
Date: Tue, 30 May 2023 18:37:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/4] pnv/xive2: Allow writes to the Physical Thread Enable
 registers
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
References: <20230530161129.313258-1-fbarrat@linux.ibm.com>
 <20230530161129.313258-4-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230530161129.313258-4-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 25776657-20da-48e3-908d-2bdea96ee64b
X-Ovh-Tracer-Id: 2756484450345651168
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedguddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeetgeehudegieffkeeftdelffdtjeelfeeggeetlefgudejgefgfeeiveeutdffheenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtuddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegtlhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepfhgsrghrrhgrtheslhhinhhugidrihgsmhdrtghomhdpuggrnhhivghlhhgsgedufeesghhmrghilhdrtghomhdpqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhoheegkedpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=188.165.42.229; envelope-from=clg@kaod.org;
 helo=4.mo548.mail-out.ovh.net
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
> Fix what was probably a silly mistake and allow to write the Physical
> Thread enable registers 0 and 1. Skiboot prefers to use the ENx_SET
> variant so it went unnoticed, but there's no reason to discard a write
> to the full register, it is Read-Write.

Indeed.


> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>

Fixes: da71b7e3ed45 ("ppc/pnv: Add a XIVE2 controller to the POWER10 chip")

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.



> ---
>   hw/intc/pnv_xive2.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index a75ff270ac..132f82a035 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1294,6 +1294,7 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
>        */
>       case TCTXT_EN0: /* Physical Thread Enable */
>       case TCTXT_EN1: /* Physical Thread Enable (fused core) */
> +        xive->tctxt_regs[reg] = val;
>           break;
>   
>       case TCTXT_EN0_SET:


