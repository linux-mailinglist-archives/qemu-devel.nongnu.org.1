Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7967169E1
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:40:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42OP-00005F-DC; Tue, 30 May 2023 12:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q42OF-0008Nm-7t
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:40:10 -0400
Received: from 1.mo548.mail-out.ovh.net ([178.32.121.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q42OD-0001ct-0E
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:40:06 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.128])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 3161320FB5;
 Tue, 30 May 2023 16:40:02 +0000 (UTC)
Received: from kaod.org (37.59.142.103) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 30 May
 2023 18:40:01 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00520eb9c49-1418-440f-a584-997e46d1b8e7,
 1689548285A2663F4093CB2B261AE0EDF3FE8C9C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <be9a5a3a-a46a-6317-dd2b-cd442f019158@kaod.org>
Date: Tue, 30 May 2023 18:40:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/4] pnv/xive2: Handle TIMA access through all ports
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
References: <20230530161129.313258-1-fbarrat@linux.ibm.com>
 <20230530161129.313258-5-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230530161129.313258-5-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG7EX1.mxp5.local (172.16.2.61) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: c8f5bb2a-d6c1-4600-91ff-2b1a02aafe9d
X-Ovh-Tracer-Id: 2801801922232749024
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedguddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfgjtgfgihesthekredttdefjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeetgeehudegieffkeeftdelffdtjeelfeeggeetlefgudejgefgfeeiveeutdffheenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtfedpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegtlhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepfhgsrghrrhgrtheslhhinhhugidrihgsmhdrtghomhdpuggrnhhivghlhhgsgedufeesghhmrghilhdrtghomhdpqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhoheegkedpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=178.32.121.110; envelope-from=clg@kaod.org;
 helo=1.mo548.mail-out.ovh.net
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
> The Thread Interrupt Management Area (TIMA) can be accessed through 4
> ports/snoop buses, targeted by the address. The base address of a TIMA
> is using port 0 and the other ports are 0x80 apart. Using one port or
> another can be useful to balance the load on the snoop buses.

and can we have some nice examples of how these ports are used ? only for
snooping or also for balancing operations ? which ones ?

> The TIMA registers are in the 0x0 -> 0x3F range and there are 2
> indication bits for special operations (bits 10 and 11; everything
> fits on a 4k page). So the port address bits fall in between and are
> "don't care" for the hardware when processing the TIMA operation. So
> this patch filters out those port address bits so that a TIMA
> operation can be triggered using any port.
> 
> It is also true for indirect access (through the IC BAR) and it's
> actually nothing new, it was already the case on P9. Which helps here,
> as the TIMA handling code is common between P9 (xive) and P10 (xive2).
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>   hw/intc/pnv_xive2.c |  4 ++++
>   hw/intc/xive.c      | 18 ++++++++++++++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 132f82a035..c80316657a 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1662,6 +1662,8 @@ static void pnv_xive2_tm_write(void *opaque, hwaddr offset,
>       bool gen1_tima_os =
>           xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
>   
> +    offset &= 0xC3F; /* See comment in xive_tctx_tm_write() */
> +
>       /* TODO: should we switch the TM ops table instead ? */
>       if (!gen1_tima_os && offset == HV_PUSH_OS_CTX_OFFSET) {
>           xive2_tm_push_os_ctx(xptr, tctx, offset, value, size);
> @@ -1681,6 +1683,8 @@ static uint64_t pnv_xive2_tm_read(void *opaque, hwaddr offset, unsigned size)
>       bool gen1_tima_os =
>           xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
>   
> +    offset &= 0xC3F; /* See comment in xive_tctx_tm_read() */
> +
>       /* TODO: should we switch the TM ops table instead ? */
>       if (!gen1_tima_os && offset == HV_PULL_OS_CTX_OFFSET) {
>           return xive2_tm_pull_os_ctx(xptr, tctx, offset, size);
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index a986b96843..c1abfae31d 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -527,6 +527,15 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>   
>       trace_xive_tctx_tm_write(offset, size, value);
>   
> +    /*
> +     * The TIMA can be accessed through 4 ports/snoop buses, with
> +     * addresses 0x80 apart.
> +     * However, the offset bits between the "special op" bits and the
> +     * MSB of the range used for the TIMA registers are "don't care"
> +     * for the hardware, so we filter them out.
> +     */
> +    offset &= 0xC3F;
> +
>       /*
>        * TODO: check V bit in Q[0-3]W2
>        */
> @@ -566,6 +575,15 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>       const XiveTmOp *xto;
>       uint64_t ret;
>   
> +    /*
> +     * The TIMA can be accessed through 4 ports/snoop buses, with
> +     * addresses 0x80 apart.
> +     * However, the offset bits between the "special op" bits and the
> +     * MSB of the range used for the TIMA registers are "don't care"
> +     * for the hardware, so we filter them out.
> +     */
> +    offset &= 0xC3F;
> +
>       /*
>        * TODO: check V bit in Q[0-3]W2
>        */


