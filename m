Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0FBB3F499
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Sep 2025 07:34:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utJdc-0002cm-5p; Tue, 02 Sep 2025 01:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org>)
 id 1utJdM-0002aI-Ko; Tue, 02 Sep 2025 01:32:46 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org>)
 id 1utJdJ-0000MR-OU; Tue, 02 Sep 2025 01:32:44 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4cGDsC5kGfz4wB0;
 Tue,  2 Sep 2025 15:32:31 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4cGDs74JrJz4w9w;
 Tue,  2 Sep 2025 15:32:27 +1000 (AEST)
Message-ID: <bc46a5e3-3166-4b17-b1a8-3099336c29d3@kaod.org>
Date: Tue, 2 Sep 2025 07:32:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v5 05/10] hw/nvram/aspeed_otp: Add OTP programming
 semantics and tracing
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com
References: <20250812094011.2617526-1-kane_chen@aspeedtech.com>
 <20250812094011.2617526-6-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250812094011.2617526-6-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 8/12/25 11:40, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> Implement correct OTP programming behavior for Aspeed OTP:
> - Support read-modify-write flow with one-way bit programming:
>    * prog_bit uses 0s as the "to-be-programmed" mask.
>    * Even-indexed words: 0->1, odd-indexed words: 1->0.
>    * Reject non-programmable requests and log conflicts.
> - Enable unaligned accesses in MemoryRegionOps.
>    Since each OTP address maps to a 1DW (4B) or 2DW (8B) block in the
>    backing store, upper-layer accesses may be unaligned to block
>    boundaries.
> 
> This matches the irreversible, word-parity-dependent programming rules
> of Aspeed SoCs and exposes changes via QEMU trace events.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/nvram/aspeed_otp.c | 80 ++++++++++++++++++++++++++++++++++++++++++-
>   hw/nvram/trace-events |  5 +++
>   2 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/nvram/aspeed_otp.c b/hw/nvram/aspeed_otp.c
> index abb3731823..66b2bfea28 100644
> --- a/hw/nvram/aspeed_otp.c
> +++ b/hw/nvram/aspeed_otp.c
> @@ -12,6 +12,7 @@
>   #include "system/block-backend.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/nvram/aspeed_otp.h"
> +#include "hw/nvram/trace.h"
>   
>   static uint64_t aspeed_otp_read(void *opaque, hwaddr offset, unsigned size)
>   {
> @@ -23,12 +24,87 @@ static uint64_t aspeed_otp_read(void *opaque, hwaddr offset, unsigned size)
>       return val;
>   }
>   
> +static bool valid_program_data(uint32_t otp_addr,
> +                                 uint32_t value, uint32_t prog_bit)
> +{
> +    uint32_t programmed_bits, has_programmable_bits;
> +    bool is_odd = otp_addr & 1;
> +
> +    /*
> +     * prog_bit uses 0s to indicate target bits to program:
> +     *   - if OTP word is even-indexed, programmed bits flip 0->1
> +     *   - if odd, bits flip 1->0
> +     * Bit programming is one-way only and irreversible.
> +     */
> +    if (is_odd) {
> +        programmed_bits = ~value & prog_bit;
> +    } else {
> +        programmed_bits = value & (~prog_bit);
> +    }
> +
> +    /* If any bit can be programmed, accept the request */
> +    has_programmable_bits = value ^ (~prog_bit);
> +
> +    if (programmed_bits) {
> +        trace_aspeed_otp_prog_conflict(otp_addr, programmed_bits);
> +        for (int i = 0; i < 32; ++i) {
> +            if (programmed_bits & (1U << i)) {
> +                trace_aspeed_otp_prog_bit(i);
> +            }
> +        }
> +    }
> +
> +    return has_programmable_bits != 0;
> +}
> +
> +static bool program_otpmem_data(void *opaque, uint32_t otp_addr,
> +                             uint32_t prog_bit, uint32_t *value)
> +{
> +    AspeedOTPState *s = opaque;
> +    bool is_odd = otp_addr & 1;
> +    uint32_t otp_offset = otp_addr << 2;
> +
> +    memcpy(value, s->storage + otp_offset, sizeof(uint32_t));
> +
> +    if (!valid_program_data(otp_addr, *value, prog_bit)) {
> +        return false;
> +    }
> +
> +    if (is_odd) {
> +        *value &= ~prog_bit;
> +    } else {
> +        *value |= ~prog_bit;
> +    }
> +
> +    return true;
> +}
> +
>   static void aspeed_otp_write(void *opaque, hwaddr otp_addr,
>                                   uint64_t val, unsigned size)
>   {
>       AspeedOTPState *s = opaque;
> +    uint32_t otp_offset, value;
>   
> -    memcpy(s->storage + otp_addr, &val, size);
> +    if (!program_otpmem_data(s, otp_addr, val, &value)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Failed to program data, value = %x, bit = %lx\n",
> +                      __func__, value, val);
> +        return;
> +    }
> +
> +    otp_offset = otp_addr << 2;
> +    memcpy(s->storage + otp_offset, &value, size);
> +
> +    if (s->blk) {
> +        if (blk_pwrite(s->blk, otp_offset, size, &value, 0) < 0) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: Failed to write %x to %x\n",
> +                          __func__, value, otp_offset);
> +
> +            return;
> +        }
> +    }
> +    trace_aspeed_otp_prog(otp_offset, val, value);
>   }
>   
>   static bool aspeed_otp_init_storage(AspeedOTPState *s, Error **errp)
> @@ -63,6 +139,8 @@ static const MemoryRegionOps aspeed_otp_ops = {
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .valid.min_access_size = 1,
>       .valid.max_access_size = 4,
> +    .valid.unaligned = true,
> +    .impl.unaligned = true
>   };
>   
>   static void aspeed_otp_realize(DeviceState *dev, Error **errp)
> diff --git a/hw/nvram/trace-events b/hw/nvram/trace-events
> index 5e33b24d47..7084bf70d3 100644
> --- a/hw/nvram/trace-events
> +++ b/hw/nvram/trace-events
> @@ -1,5 +1,10 @@
>   # See docs/devel/tracing.rst for syntax documentation.
>   
> +# aspeed_otp.c
> +aspeed_otp_prog(uint32_t addr, uint32_t prog_value, uint32_t value) "OTP Memory program: addr 0x%" PRIx32 " prog_value 0x%" PRIx32 " value 0x%" PRIx32
> +aspeed_otp_prog_conflict(uint32_t addr, uint32_t bits) "Conflict at addr=0x%x, bits=0x%08x"
> +aspeed_otp_prog_bit(int bit) "Programmed bit %d"
> +
>   # ds1225y.c
>   nvram_read(uint32_t addr, uint32_t ret) "read addr %d: 0x%02x"
>   nvram_write(uint32_t addr, uint32_t old, uint32_t val) "write addr %d: 0x%02x -> 0x%02x"


