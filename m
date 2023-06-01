Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F91A719C00
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:23:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hL0-0005fp-KR; Thu, 01 Jun 2023 08:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4hKn-0005Oq-9p; Thu, 01 Jun 2023 08:23:17 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4hKk-0000Hc-N5; Thu, 01 Jun 2023 08:23:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QX4zD2Mpwz4x4L;
 Thu,  1 Jun 2023 22:23:04 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QX4zB5C2jz4x3y;
 Thu,  1 Jun 2023 22:23:02 +1000 (AEST)
Message-ID: <a82e948c-e53e-edf5-e697-112b046866a5@kaod.org>
Date: Thu, 1 Jun 2023 14:22:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 4/5] pnv/xive2: Introduce macros to manipulate TIMA
 addresses
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230601121331.487207-1-fbarrat@linux.ibm.com>
 <20230601121331.487207-5-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230601121331.487207-5-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=vOrz=BV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/1/23 14:13, Frederic Barrat wrote:
> TIMA addresses are somewhat special and are split in several bit
> fields with different meanings. This patch describes it and introduce
> macros to more easily access the various fields.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/intc/xive.c             | 14 +++++++-------
>   include/hw/ppc/xive_regs.h | 16 ++++++++++++++++
>   2 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index a986b96843..ebe399bc09 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -249,7 +249,7 @@ static const uint8_t *xive_tm_views[] = {
>   static uint64_t xive_tm_mask(hwaddr offset, unsigned size, bool write)
>   {
>       uint8_t page_offset = (offset >> TM_SHIFT) & 0x3;
> -    uint8_t reg_offset = offset & 0x3F;
> +    uint8_t reg_offset = offset & TM_REG_OFFSET;
>       uint8_t reg_mask = write ? 0x1 : 0x2;
>       uint64_t mask = 0x0;
>       int i;
> @@ -266,8 +266,8 @@ static uint64_t xive_tm_mask(hwaddr offset, unsigned size, bool write)
>   static void xive_tm_raw_write(XiveTCTX *tctx, hwaddr offset, uint64_t value,
>                                 unsigned size)
>   {
> -    uint8_t ring_offset = offset & 0x30;
> -    uint8_t reg_offset = offset & 0x3F;
> +    uint8_t ring_offset = offset & TM_RING_OFFSET;
> +    uint8_t reg_offset = offset & TM_REG_OFFSET;
>       uint64_t mask = xive_tm_mask(offset, size, true);
>       int i;
>   
> @@ -296,8 +296,8 @@ static void xive_tm_raw_write(XiveTCTX *tctx, hwaddr offset, uint64_t value,
>   
>   static uint64_t xive_tm_raw_read(XiveTCTX *tctx, hwaddr offset, unsigned size)
>   {
> -    uint8_t ring_offset = offset & 0x30;
> -    uint8_t reg_offset = offset & 0x3F;
> +    uint8_t ring_offset = offset & TM_RING_OFFSET;
> +    uint8_t reg_offset = offset & TM_REG_OFFSET;
>       uint64_t mask = xive_tm_mask(offset, size, false);
>       uint64_t ret;
>       int i;
> @@ -534,7 +534,7 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>       /*
>        * First, check for special operations in the 2K region
>        */
> -    if (offset & 0x800) {
> +    if (offset & TM_SPECIAL_OP) {
>           xto = xive_tm_find_op(offset, size, true);
>           if (!xto) {
>               qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access at TIMA "
> @@ -573,7 +573,7 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
>       /*
>        * First, check for special operations in the 2K region
>        */
> -    if (offset & 0x800) {
> +    if (offset & TM_SPECIAL_OP) {
>           xto = xive_tm_find_op(offset, size, false);
>           if (!xto) {
>               qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access to TIMA"
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index b7fde2354e..4a3c9badd3 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -48,6 +48,22 @@
>   
>   #define TM_SHIFT                16
>   
> +/*
> + * TIMA addresses are 12-bits (4k page).
> + * The MSB indicates a special op with side effect, which can be
> + * refined with bit 10 (see below).
> + * The registers, logically grouped in 4 rings (a quad-word each), are
> + * defined on the 6 LSBs (offset below 0x40)
> + * In between, we can add a cache line index from 0...3 (ie, 0, 0x80,
> + * 0x100, 0x180) to select a specific snooper. Those 'snoop port
> + * address' bits should be dropped when processing the operations as
> + * they are all equivalent.
> + */
> +#define TM_ADDRESS_MASK         0xC3F
> +#define TM_SPECIAL_OP           0x800
> +#define TM_RING_OFFSET          0x30
> +#define TM_REG_OFFSET           0x3F
> +
>   /* TM register offsets */
>   #define TM_QW0_USER             0x000 /* All rings */
>   #define TM_QW1_OS               0x010 /* Ring 0..2 */


