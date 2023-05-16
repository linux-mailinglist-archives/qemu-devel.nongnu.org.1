Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 328BD704818
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 10:46:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyqIq-00024Q-Oa; Tue, 16 May 2023 04:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1pyqIm-00023Y-6e
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:45:00 -0400
Received: from 1.mo552.mail-out.ovh.net ([178.32.96.117])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1pyqIk-0000JR-2F
 for qemu-devel@nongnu.org; Tue, 16 May 2023 04:44:59 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.132])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4C093214C1;
 Tue, 16 May 2023 08:44:55 +0000 (UTC)
Received: from kaod.org (37.59.142.109) by DAG4EX2.mxp5.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 16 May
 2023 10:44:54 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003cfd1366f-3c79-4de2-b927-bee35df049cf,
 2678E99B74C30C5B30CC52F7B2AE97E44E35CB91) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <d49a6ddd-9c45-ca3a-7573-de2d39f518ce@kaod.org>
Date: Tue, 16 May 2023 10:44:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] target/ppc: Use SMT4 small core chip type in POWER9/10
 PVRs
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
CC: <qemu-devel@nongnu.org>, Harsh Prateek Bora <harsh@linux.vnet.ibm.com>
References: <20230515160131.394562-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230515160131.394562-1-npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.109]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG4EX2.mxp5.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: 572c543d-cc32-49fd-b4ef-cb6e7cf9fe31
X-Ovh-Tracer-Id: 4793800332277550048
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledgtdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthejredttdefjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpefhffdvffeltefgvdelleetffefvdfhgffgtdfhheejheelteetieeuhefhjedvtdenucffohhmrghinhepghhnuhdrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtledpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegtlhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhhpihhgghhinhesghhmrghilhdrtghomhdpqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdphhgrrhhshheslhhinhhugidrvhhnvghtrdhisghmrdgtohhmpdfovfetjfhoshhtpehmohehhedvpdhmohguvgepshhmthhpohhuth
Received-SPF: pass client-ip=178.32.96.117; envelope-from=clg@kaod.org;
 helo=1.mo552.mail-out.ovh.net
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.811,
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

On 5/15/23 18:01, Nicholas Piggin wrote:
> QEMU's PVR value for POWER9 DD2.0 has chip type 1, which is the SMT4
> "small core" type that OpenPOWER processors use. QEMU's PVR for all
> other POWER9/10 have chip type 0, which "enterprise" systems use.
> 
> The difference does not really matter to QEMU (because it does not care
> about SMT mode in the target), but for consistency all PVRs should use
> the same chip type. We'll go with the SMT4 OpenPOWER type.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> This is a replacement for
> 
> https://lists.gnu.org/archive/html/qemu-ppc/2022-03/msg00227.html
> 
> But the chip type is changed to 1 instead of 0, because that's the
> more familiar SM4 / small core CPU.

Will small cores POWER10 CPU be available ?

Thanks,

C.


> 
> Thanks,
> Nick
> 
>   target/ppc/cpu-models.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
> index 1326493a9a..a77e036b3a 100644
> --- a/target/ppc/cpu-models.h
> +++ b/target/ppc/cpu-models.h
> @@ -348,11 +348,11 @@ enum {
>       CPU_POWERPC_POWER8NVL_BASE     = 0x004C0000,
>       CPU_POWERPC_POWER8NVL_v10      = 0x004C0100,
>       CPU_POWERPC_POWER9_BASE        = 0x004E0000,
> -    CPU_POWERPC_POWER9_DD1         = 0x004E0100,
> +    CPU_POWERPC_POWER9_DD1         = 0x004E1100,
>       CPU_POWERPC_POWER9_DD20        = 0x004E1200,
>       CPU_POWERPC_POWER10_BASE       = 0x00800000,
> -    CPU_POWERPC_POWER10_DD1        = 0x00800100,
> -    CPU_POWERPC_POWER10_DD20       = 0x00800200,
> +    CPU_POWERPC_POWER10_DD1        = 0x00801100,
> +    CPU_POWERPC_POWER10_DD20       = 0x00801200,
>       CPU_POWERPC_970_v22            = 0x00390202,
>       CPU_POWERPC_970FX_v10          = 0x00391100,
>       CPU_POWERPC_970FX_v20          = 0x003C0200,


