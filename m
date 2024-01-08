Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5152826F3F
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 14:07:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMpKC-0002Fr-SI; Mon, 08 Jan 2024 08:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMpK6-0002F5-BT
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 08:05:46 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMpK4-0004GS-7u
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 08:05:46 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e49447463so4114225e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 05:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704719142; x=1705323942; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8j/CsYmYI28yxTkAI/629xc1lrXr+iCODj3HzU+ggC8=;
 b=T4Zv805inag4nL4vBXr9S0S2/Ha+OO5R5rNs78m+uS77pntIFs+XqxKmpqXu363uaU
 lX29NHE+iwIDTZsdvqvQtTinrkyKiPWpNfswzlaaDnMdCiH3Sqt+niXP3znyAC+QD+QP
 NuOKA8Nc9bA2c2mgtz1TbOaIe4BdfzSBvhpz6YsINitsTi4RQMMSroUODrGk3Bdd/PUR
 MkeUWqYXWOf5Sh9C8nqL67quxdBit5ExxXAfaUzg/RO5gl7OqKEUtLHj7cJ7Ee+G0odp
 1Y6KpUdZIz+5hLhFSEdMHD1xZR/wEr7mvoPgHVr9TMFFVI3v2IuFNHWKsBGgEqOCBCt+
 D2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704719142; x=1705323942;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8j/CsYmYI28yxTkAI/629xc1lrXr+iCODj3HzU+ggC8=;
 b=Rs4hm8EUX4/Gmeqqo25eZ9fQ0ndG2m2iZLSYvm/nx4ps+0gT2yfkv76hXrU/pWCOoS
 1R2HeM6WjFoKV/YWWmKu+Zz0+YSdj0wfjzTMCXZ0ZLFJ0PHEweFF5Ul8FnVrHn3QKf4J
 r7PkjHKdFqfbXHesRynqHVDosTFdr478elQjvZiUy0w0Jvkp8HG8UO5DeENSO8x4McZM
 uakxzhKKy9MvA0ZgsQNAsG9fs3jPw/RUpAI+a8kxZ+TN7LqqGDbJ0wTsSD3aK43+oFfn
 CTeWDhcSCNMIRSMn9OaLS07CkHXd9gIq/3MJXLCh6kinLpBTUZsm+/GQbS6JckFgvHA2
 wzfA==
X-Gm-Message-State: AOJu0Yz8addHbIPHdQHz+dQQzKrsdGdfZ1LIGrZXNCx6oXYC56BFH+dA
 ZUxogbvPZk5vGiUvNMXa/mYV/MrhSzH7WA==
X-Google-Smtp-Source: AGHT+IH2vTqYgqu86MohB4cJ1OkA2adTUM9E5PIvB7+J1EgsNIr/FuI7+X1uRQxk+tr7YAyzMs3jBQ==
X-Received: by 2002:a05:600c:4fc5:b0:40d:609d:d66a with SMTP id
 o5-20020a05600c4fc500b0040d609dd66amr1885838wmq.84.1704719141763; 
 Mon, 08 Jan 2024 05:05:41 -0800 (PST)
Received: from [192.168.1.102] ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a05600c474500b0040e34835a58sm10961447wmo.22.2024.01.08.05.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 05:05:41 -0800 (PST)
Message-ID: <39ff1c41-c7ea-4cdc-ab18-b299b91cafb8@linaro.org>
Date: Mon, 8 Jan 2024 14:05:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/pflash: implement update buffer for block writes
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20240108125342.48298-1-philmd@linaro.org>
 <20240108125342.48298-3-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240108125342.48298-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Gerd,

On 8/1/24 13:53, Philippe Mathieu-Daudé wrote:
> From: Gerd Hoffmann <kraxel@redhat.com>
> 
> Add an update buffer where all block updates are staged.
> Flush or discard updates properly, so we should never see
> half-completed block writes in pflash storage.
> 
> Drop a bunch of FIXME comments ;)
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Message-ID: <20240105135855.268064-3-kraxel@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/block/pflash_cfi01.c | 106 ++++++++++++++++++++++++++++++----------
>   1 file changed, 80 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index ce63ba43b6..0120462648 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -80,16 +80,39 @@ struct PFlashCFI01 {
>       uint16_t ident3;
>       uint8_t cfi_table[0x52];
>       uint64_t counter;
> -    unsigned int writeblock_size;
> +    uint32_t writeblock_size;
>       MemoryRegion mem;
>       char *name;
>       void *storage;
>       VMChangeStateEntry *vmstate;
>       bool old_multiple_chip_handling;
> +
> +    /* block update buffer */
> +    unsigned char *blk_bytes;

I'd rather use a 'void *' type here, but then we need to
use a (uinptr_t) cast in pflash_data_write().

> +    uint32_t blk_offset;
>   };
>   
>   static int pflash_post_load(void *opaque, int version_id);
>   
> +static bool pflash_blk_write_state_needed(void *opaque)
> +{
> +    PFlashCFI01 *pfl = opaque;
> +
> +    return (pfl->blk_offset != -1);
> +}
> +
> +static const VMStateDescription vmstate_pflash_blk_write = {
> +    .name = "pflash_cfi01_blk_write",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = pflash_blk_write_state_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_VBUFFER_UINT32(blk_bytes, PFlashCFI01, 0, NULL, writeblock_size),

I don't get the difference with VMSTATE_VBUFFER_ALLOC_UINT32() which
sets VMS_ALLOC. In this case pflash_cfi01_realize() does the alloc so
we don't need VMS_ALLOC?

> +        VMSTATE_UINT32(blk_offset, PFlashCFI01),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>   static const VMStateDescription vmstate_pflash = {
>       .name = "pflash_cfi01",
>       .version_id = 1,
> @@ -101,6 +124,10 @@ static const VMStateDescription vmstate_pflash = {
>           VMSTATE_UINT8(status, PFlashCFI01),
>           VMSTATE_UINT64(counter, PFlashCFI01),
>           VMSTATE_END_OF_LIST()
> +    },
> +    .subsections = (const VMStateDescription * const []) {
> +        &vmstate_pflash_blk_write,
> +        NULL
>       }
>   };
>   
> @@ -376,12 +403,51 @@ static void pflash_update(PFlashCFI01 *pfl, int offset,
>       }
>   }
>   
> +/* copy current flash content to block update buffer */
> +static void pflash_blk_write_start(PFlashCFI01 *pfl, hwaddr offset)
> +{
> +    hwaddr mask = ~(pfl->writeblock_size - 1);
> +
> +    pfl->blk_offset = offset & mask;
> +    memcpy(pfl->blk_bytes, pfl->storage + pfl->blk_offset,
> +           pfl->writeblock_size);
> +}
> +
> +/* commit block update buffer changes */
> +static void pflash_blk_write_flush(PFlashCFI01 *pfl)
> +{
> +    g_assert(pfl->blk_offset != -1);
> +    memcpy(pfl->storage + pfl->blk_offset, pfl->blk_bytes,
> +           pfl->writeblock_size);
> +    pflash_update(pfl, pfl->blk_offset, pfl->writeblock_size);
> +    pfl->blk_offset = -1;
> +}
> +
> +/* discard block update buffer changes */
> +static void pflash_blk_write_abort(PFlashCFI01 *pfl)
> +{
> +    pfl->blk_offset = -1;
> +}
> +
>   static inline void pflash_data_write(PFlashCFI01 *pfl, hwaddr offset,
>                                        uint32_t value, int width, int be)
>   {
> -    uint8_t *p = pfl->storage;
> +    uint8_t *p;
> +
> +    if (pfl->blk_offset != -1) {

I'd rather have a trace event in this if() ladder.

> +        /* block write: redirect writes to block update buffer */
> +        if ((offset < pfl->blk_offset) ||
> +            (offset + width > pfl->blk_offset + pfl->writeblock_size)) {
> +            pfl->status |= 0x10; /* Programming error */
> +            return;
> +        }
> +        p = pfl->blk_bytes + (offset - pfl->blk_offset);
> +    } else {
> +        /* write directly to storage */
> +        trace_pflash_data_write(pfl->name, offset, width, value, pfl->counter);
> +        p = pfl->storage + offset;
> +    }
>   
> -    trace_pflash_data_write(pfl->name, offset, width, value, pfl->counter);
>       if (be) {
>           stn_be_p(p, width, value);
>       } else {
> @@ -504,6 +570,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>               trace_pflash_write_block(pfl->name, value);
>               pfl->counter = value;
>               pfl->wcycle++;
> +            pflash_blk_write_start(pfl, offset);
>               break;
>           case 0x60:
>               if (cmd == 0xd0) {
> @@ -534,12 +601,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>           switch (pfl->cmd) {
>           case 0xe8: /* Block write */
>               /* FIXME check @offset, @width */
> -            if (!pfl->ro) {
> -                /*
> -                 * FIXME writing straight to memory is *wrong*.  We
> -                 * should write to a buffer, and flush it to memory
> -                 * only on confirm command (see below).
> -                 */
> +            if (!pfl->ro && (pfl->blk_offset != -1)) {
>                   pflash_data_write(pfl, offset, value, width, be);
>               } else {
>                   pfl->status |= 0x10; /* Programming error */
> @@ -548,18 +610,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>               pfl->status |= 0x80;
>   
>               if (!pfl->counter) {
> -                hwaddr mask = pfl->writeblock_size - 1;
> -                mask = ~mask;
> -
>                   trace_pflash_write(pfl->name, "block write finished");
>                   pfl->wcycle++;
> -                if (!pfl->ro) {
> -                    /* Flush the entire write buffer onto backing storage.  */
> -                    /* FIXME premature! */
> -                    pflash_update(pfl, offset & mask, pfl->writeblock_size);
> -                } else {
> -                    pfl->status |= 0x10; /* Programming error */
> -                }
>               }
>   
>               pfl->counter--;
> @@ -571,20 +623,17 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>       case 3: /* Confirm mode */
>           switch (pfl->cmd) {
>           case 0xe8: /* Block write */
> -            if (cmd == 0xd0) {
> -                /* FIXME this is where we should write out the buffer */
> +            if ((cmd == 0xd0) && !(pfl->status & 0x10)) {
> +                pflash_blk_write_flush(pfl);
>                   pfl->wcycle = 0;
>                   pfl->status |= 0x80;
>               } else {
> -                qemu_log_mask(LOG_UNIMP,
> -                    "%s: Aborting write to buffer not implemented,"
> -                    " the data is already written to storage!\n"
> -                    "Flash device reset into READ mode.\n",
> -                    __func__);
> +                pflash_blk_write_abort(pfl);
>                   goto mode_read_array;
>               }
>               break;
>           default:
> +            pflash_blk_write_abort(pfl);
>               goto error_flash;
>           }
>           break;
> @@ -818,6 +867,9 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>       pfl->cmd = 0x00;
>       pfl->status = 0x80; /* WSM ready */
>       pflash_cfi01_fill_cfi_table(pfl);
> +
> +    pfl->blk_bytes = g_malloc(pfl->writeblock_size);
> +    pfl->blk_offset = -1;
>   }
>   
>   static void pflash_cfi01_system_reset(DeviceState *dev)
> @@ -837,6 +889,8 @@ static void pflash_cfi01_system_reset(DeviceState *dev)
>        * This model deliberately ignores this delay.
>        */
>       pfl->status = 0x80;
> +
> +    pfl->blk_offset = -1;
>   }
>   
>   static Property pflash_cfi01_properties[] = {

Patch LGTM. If you want I can apply the changes suggested
and post a v3/queue.

Regards,

Phil.

