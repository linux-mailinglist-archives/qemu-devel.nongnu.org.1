Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2E6719C0D
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:26:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hNP-0001G6-4Y; Thu, 01 Jun 2023 08:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4hN9-00019G-Vn; Thu, 01 Jun 2023 08:25:49 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4hN5-000166-W6; Thu, 01 Jun 2023 08:25:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QX5250CQQz4x3s;
 Thu,  1 Jun 2023 22:25:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QX52334nyz4whk;
 Thu,  1 Jun 2023 22:25:31 +1000 (AEST)
Message-ID: <722073c3-cdcb-47d5-f047-eeec0b7b8a4d@kaod.org>
Date: Thu, 1 Jun 2023 14:25:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 5/5] pnv/xive2: Handle TIMA access through all ports
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230601121331.487207-1-fbarrat@linux.ibm.com>
 <20230601121331.487207-6-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230601121331.487207-6-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=vOrz=BV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.1, SPF_HELO_PASS=-0.001,
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

On 6/1/23 14:13, Frederic Barrat wrote:
> The Thread Interrupt Management Area (TIMA) can be accessed through 4
> ports, targeted by the address. The base address of a TIMA
> is using port 0 and the other ports are 0x80 apart. Using one port or
> another can be useful to balance the load on the snoop buses. With
> skiboot and linux, we currently use port 0, but as it tends to be
> busy, another hypervisor is using port 1 for TIMA access.
> 
> The port address bits fall in between the special op indication
> bits (the 2 MSBs) and the register offset bits (the 6 LSBs). They are
> "don't care" for the hardware when processing a TIMA operation. This
> patch filters out those port address bits so that a TIMA operation can
> be triggered using any port.
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
>   hw/intc/pnv_xive2.c | 4 ++++
>   hw/intc/xive.c      | 2 +-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 5fc4240216..ec1edeb385 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1666,6 +1666,8 @@ static void pnv_xive2_tm_write(void *opaque, hwaddr offset,
>       bool gen1_tima_os =
>           xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
>   
> +    offset &= TM_ADDRESS_MASK;
> +
>       /* TODO: should we switch the TM ops table instead ? */
>       if (!gen1_tima_os && offset == HV_PUSH_OS_CTX_OFFSET) {
>           xive2_tm_push_os_ctx(xptr, tctx, offset, value, size);
> @@ -1685,6 +1687,8 @@ static uint64_t pnv_xive2_tm_read(void *opaque, hwaddr offset, unsigned size)
>       bool gen1_tima_os =
>           xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
>   
> +    offset &= TM_ADDRESS_MASK;
> +
>       /* TODO: should we switch the TM ops table instead ? */
>       if (!gen1_tima_os && offset == HV_PULL_OS_CTX_OFFSET) {
>           return xive2_tm_pull_os_ctx(xptr, tctx, offset, size);
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index ebe399bc09..5204c14b87 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -500,7 +500,7 @@ static const XiveTmOp xive_tm_operations[] = {
>   static const XiveTmOp *xive_tm_find_op(hwaddr offset, unsigned size, bool write)
>   {
>       uint8_t page_offset = (offset >> TM_SHIFT) & 0x3;
> -    uint32_t op_offset = offset & 0xFFF;
> +    uint32_t op_offset = offset & TM_ADDRESS_MASK;
>       int i;
>   
>       for (i = 0; i < ARRAY_SIZE(xive_tm_operations); i++) {


