Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4425B791D4C
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 20:37:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdEQq-0006Na-Fc; Mon, 04 Sep 2023 14:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdEQj-0006Ls-RQ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 14:36:10 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdEQg-00030z-Qs
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 14:36:09 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9a648f9d8e3so208892766b.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 11:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693852565; x=1694457365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZZaQcp1gg5dOcTV2uoyYyCntn71E6WBjmp/X9bV/I/0=;
 b=T7h/f/r+vb6KP0X+avo0DJL+9SVFFUtZnoFRG4DplMUi27dAZ2ZLz9jSV5uZ26nBqj
 NhjXYMRcgv6C2FAwFQGEZCijHLggWFVuFeEEdUbOnE24IgMWqqz7bD3WkR1IWeC4zlJF
 9q2mF9SNIiixu9ZuAkjJT0fNmcCu5K9YQ7hugmnvgftyRJyFVkITzdUep+jxKtMEjkgr
 Sm9/TGzztHnhhIDdtvCKsToRX7XFj+qU4LQ/6UOzxkquFez1BSwWDFi6pdb7BH4t5+lW
 a9DH6p+wfp0kvifCQZUr/eZ7NH0mgTpUKjEMLpfOdmmFKRuKZojITb8e20HSMKXyhNqf
 1xVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693852565; x=1694457365;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZaQcp1gg5dOcTV2uoyYyCntn71E6WBjmp/X9bV/I/0=;
 b=U+EBuHj2Rhzy/aJYxQtZF53d8x5g++UzR44DRbXqJY1dlohauK+SHgrV3Dz7Ohffbc
 45PboewaypWmZUqv+gSn9gaU+LzemC6EkOHZchUCZRSBGpZwJLvHVFSyoCAkg9YS/VdZ
 7YAoAfVsVh2MIoKcYKG67iAqboCSfNyWkaAol2n5Qqz2H1/y33kzV7ZTokRd1OvS9sTp
 NockBbRT1qUx9ACN+WlDNE5hVyKss20S+NfR3KX9VfUJ36JfNhrI3KiomOio46N50riG
 +pKWAdusEMTX7KB/G1e81h2lq3xebKoQafYoIh/yzEgITmQZuptD2OD9J4me3NmQD7KD
 l9BQ==
X-Gm-Message-State: AOJu0YwZhRTM0I3SS1KIdQ9Q1TJkG95Q56Tm6c7vCf9vXk5B6+OxkuoI
 19Omx46TG+S3aIyWkyeynDg1Pw==
X-Google-Smtp-Source: AGHT+IH+/4NNgxbq3InTOAXYidoXidsF6NSjrvNBMxXClITpcw9VWD2f+CuZ75sSvCDr3EzVEMDA6g==
X-Received: by 2002:a17:906:2d2:b0:9a1:b7ec:c8bd with SMTP id
 18-20020a17090602d200b009a1b7ecc8bdmr8932455ejk.42.1693852564896; 
 Mon, 04 Sep 2023 11:36:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 p21-20020a170906b21500b0099bc8bd9066sm6503049ejz.150.2023.09.04.11.36.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 11:36:04 -0700 (PDT)
Message-ID: <56291b02-5474-77b6-5563-6367bf5dcb4c@linaro.org>
Date: Mon, 4 Sep 2023 20:36:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 2/2] hw/cxl: Support 4 HDM decoders at all levels of
 topology
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, linuxarm@huawei.com
References: <20230904164704.18739-1-Jonathan.Cameron@huawei.com>
 <20230904164704.18739-3-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904164704.18739-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Jonathan,

Few style comments inlined.

On 4/9/23 18:47, Jonathan Cameron wrote:
> Support these decoders in CXL host bridges (pxb-cxl), CXL Switch USP
> and CXL Type 3 end points.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> Note there is a fix in here for a wrong increment that had
> no impact when there was only one HDM decoder.
> 
>   include/hw/cxl/cxl_component.h |  7 +++
>   hw/cxl/cxl-component-utils.c   | 26 +++++----
>   hw/cxl/cxl-host.c              | 65 +++++++++++++++--------
>   hw/mem/cxl_type3.c             | 97 +++++++++++++++++++++++-----------
>   4 files changed, 133 insertions(+), 62 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index f0ad9cf7de..c5a93b2cec 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -135,6 +135,10 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
>     REG32(CXL_HDM_DECODER##n##_TARGET_LIST_LO,                                   \
>           CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x24)                          \
>     REG32(CXL_HDM_DECODER##n##_TARGET_LIST_HI,                                   \
> +        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x28)                          \
> +  REG32(CXL_HDM_DECODER##n##_DPA_SKIP_LO,                                      \
> +        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x24)                          \
> +  REG32(CXL_HDM_DECODER##n##_DPA_SKIP_HI,                                      \
>           CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x28)
>   
>   REG32(CXL_HDM_DECODER_CAPABILITY, CXL_HDM_REGISTERS_OFFSET)
> @@ -148,6 +152,9 @@ REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTERS_OFFSET + 4)
>       FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, HDM_DECODER_ENABLE, 1, 1)
>   
>   HDM_DECODER_INIT(0);
> +HDM_DECODER_INIT(1);
> +HDM_DECODER_INIT(2);
> +HDM_DECODER_INIT(3);

   #define HDM_DECODER_COUNT 4

>   /* 8.2.5.13 - CXL Extended Security Capability Structure (Root complex only) */
>   #define EXTSEC_ENTRY_MAX        256
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index e96398e8af..79b9369756 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -42,6 +42,9 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
>   
>       switch (offset) {
>       case A_CXL_HDM_DECODER0_CTRL:
> +    case A_CXL_HDM_DECODER1_CTRL:
> +    case A_CXL_HDM_DECODER2_CTRL:
> +    case A_CXL_HDM_DECODER3_CTRL:
>           should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
>           should_uncommit = !should_commit;
>           break;
> @@ -81,7 +84,7 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
>       }
>   
>       if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
> -        offset <= A_CXL_HDM_DECODER0_TARGET_LIST_HI) {
> +        offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
>           dumb_hdm_handler(cxl_cstate, offset, value);
>       } else {
>           cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)] = value;
> @@ -161,7 +164,7 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
>   static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>                               enum reg_type type)
>   {
> -    int decoder_count = 1;
> +    int decoder_count = 4;

   unsigned decoder_count = HDM_DECODER_COUNT;

>       int i;
>   
>       ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, DECODER_COUNT,
> @@ -174,19 +177,22 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>                        HDM_DECODER_ENABLE, 0);
>       write_msk[R_CXL_HDM_DECODER_GLOBAL_CONTROL] = 0x3;
>       for (i = 0; i < decoder_count; i++) {

Alternatively:

         for (i = 0; i < decoder_count; i++, write_msk += 8) {
             write_msk[R_CXL_HDM_DECODER0_BASE_LO] = 0xf0000000;

> -        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * 0x20] = 0xf0000000;
> -        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * 0x20] = 0xffffffff;
> -        write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20] = 0xf0000000;
> -        write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20] = 0xffffffff;
> -        write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20] = 0x13ff;
> +        write_msk[R_CXL_HDM_DECODER0_BASE_LO + i * 0x20 / 4] = 0xf0000000;

(this 0x20 / 4 bugs me a bit).

> +        write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * 0x20 / 4]  = 0xffffffff;
> +        write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20 / 4] = 0xf0000000;
> +        write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20 / 4] = 0xffffffff;
> +        write_msk[R_CXL_HDM_DECODER0_CTRL + i * 0x20 / 4] = 0x13ff;
>           if (type == CXL2_DEVICE ||
>               type == CXL2_TYPE3_DEVICE ||
>               type == CXL2_LOGICAL_DEVICE) {
> -            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xf0000000;
> +            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20 / 4] =
> +                0xf0000000;
>           } else {
> -            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20] = 0xffffffff;
> +            write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_LO + i * 0x20 / 4] =
> +                0xffffffff;
>           }
> -        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * 0x20] = 0xffffffff;
> +        write_msk[R_CXL_HDM_DECODER0_TARGET_LIST_HI + i * 0x20 / 4] =
> +            0xffffffff;
>       }
>   }

>   
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index f0920da956..e71b70d5b0 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -97,33 +97,56 @@ void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
>       }
>   }
>   
> -/* TODO: support, multiple hdm decoders */
>   static bool cxl_hdm_find_target(uint32_t *cache_mem, hwaddr addr,
>                                   uint8_t *target)
>   {
> -    uint32_t ctrl;
> -    uint32_t ig_enc;
> -    uint32_t iw_enc;
> -    uint32_t target_idx;
> -
> -    ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL];
> -    if (!FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
> -        return false;
> -    }
> -
> -    ig_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
> -    iw_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
> -    target_idx = (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);
> +    bool found = false;
> +    int i;
> +    uint32_t cap;
> +
> +    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);

unsigned count = cxl_decoder_count_dec(FIELD_EX32(cap,
                                              CXL_HDM_DECODER_CAPABILITY,
                                              DECODER_COUNT));

for (i = 0; i < count; ...)

> +    for (i = 0;
> +         i < cxl_decoder_count_dec(FIELD_EX32(cap, CXL_HDM_DECODER_CAPABILITY,
> +                                              DECODER_COUNT));
> +         i++) {
> +        uint32_t ctrl, ig_enc, iw_enc, target_idx;
> +        uint32_t low, high;
> +        uint64_t base, size;
> +
> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * 0x20 / 4);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * 0x20 / 4);
> +        base = (low & 0xf0000000) | ((uint64_t)high << 32);
> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20 / 4);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20 / 4);
> +        size = (low & 0xf0000000) | ((uint64_t)high << 32);
> +        if (addr < base || addr >= base + size) {
> +            continue;
> +        }
>   
> -    if (target_idx < 4) {
> -        *target = extract32(cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_LO],
> -                            target_idx * 8, 8);
> -    } else {
> -        *target = extract32(cache_mem[R_CXL_HDM_DECODER0_TARGET_LIST_HI],
> -                            (target_idx - 4) * 8, 8);
> +        ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * 0x20 / 4);
> +        if (!FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
> +            return false;
> +        }
> +        found = true;
> +        ig_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IG);
> +        iw_enc = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, IW);
> +        target_idx = (addr / cxl_decode_ig(ig_enc)) % (1 << iw_enc);
> +
> +        if (target_idx < 4) {
> +            uint32_t val = ldl_le_p(cache_mem +
> +                                    R_CXL_HDM_DECODER0_TARGET_LIST_LO +
> +                                    i * 0x20 / 4);
> +            *target = extract32(val, target_idx * 8, 8);
> +        } else {
> +            uint32_t val = ldl_le_p(cache_mem +
> +                                    R_CXL_HDM_DECODER0_TARGET_LIST_HI +
> +                                    i * 0x20 / 4);
> +            *target = extract32(val, (target_idx - 4) * 8, 8);
> +        }
> +        break;
>       }
>   
> -    return true;
> +    return found;
>   }
>   
>   static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 4e314748d3..fdfdb84813 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -381,14 +381,12 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
>       uint32_t *cache_mem = cregs->cache_mem_registers;
>       uint32_t ctrl;
>   
> -    assert(which == 0);
> -
> -    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL);
> +    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * 0x20 / 4);
>       /* TODO: Sanity checks that the decoder is possible */
>       ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
>       ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
>   
> -    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
> +    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * 0x20 / 4, ctrl);
>   }
>   
>   static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
> @@ -397,14 +395,12 @@ static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
>       uint32_t *cache_mem = cregs->cache_mem_registers;
>       uint32_t ctrl;
>   
> -    assert(which == 0);
> -
> -    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL);
> +    ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * 0x20 / 4);
>   
>       ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
>       ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
>   
> -    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL, ctrl);
> +    stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * 0x20 / 4, ctrl);
>   }
>   
>   static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
> @@ -487,6 +483,21 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
>           should_uncommit = !should_commit;
>           which_hdm = 0;
>           break;
> +    case A_CXL_HDM_DECODER1_CTRL:
> +        should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
> +        should_uncommit = !should_commit;
> +        which_hdm = 1;
> +        break;
> +    case A_CXL_HDM_DECODER2_CTRL:
> +        should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
> +        should_uncommit = !should_commit;
> +        which_hdm = 2;
> +        break;
> +    case A_CXL_HDM_DECODER3_CTRL:
> +        should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
> +        should_uncommit = !should_commit;
> +        which_hdm = 3;
> +        break;
>       case A_CXL_RAS_UNC_ERR_STATUS:
>       {
>           uint32_t capctrl = ldl_le_p(cache_mem + R_CXL_RAS_ERR_CAP_CTRL);
> @@ -758,36 +769,60 @@ static void ct3_exit(PCIDevice *pci_dev)
>       }
>   }
>   
> -/* TODO: Support multiple HDM decoders and DPA skip */
>   static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
>   {
>       uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
> -    uint64_t decoder_base, decoder_size, hpa_offset;
> -    uint32_t hdm0_ctrl;
> -    int ig, iw;
> +    uint32_t cap;
> +    uint64_t dpa_base = 0;
> +    int i;
>   
> -    decoder_base = (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI] << 32) |
> -                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO]);
> -    if ((uint64_t)host_addr < decoder_base) {
> -        return false;
> -    }
> +    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
> +    for (i = 0; i < cxl_decoder_count_dec(FIELD_EX32(cap,
> +                                                     CXL_HDM_DECODER_CAPABILITY,
> +                                                     DECODER_COUNT));
> +         i++) {
> +        uint64_t decoder_base, decoder_size, hpa_offset, skip;
> +        uint32_t hdm_ctrl, low, high;
> +        int ig, iw;
> +
> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * 0x20 / 4);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * 0x20 / 4);
> +        decoder_base = ((uint64_t)high << 32) | (low & 0xf0000000);
> +
> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * 0x20 / 4);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * 0x20 / 4);
> +        decoder_size = ((uint64_t)high << 32) | (low & 0xf0000000);
> +
> +        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO +
> +                       i * 0x20 / 4);
> +        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI +
> +                        i * 0x20 / 4);
> +        skip = ((uint64_t)high << 32) | (low & 0xf0000000);
> +        dpa_base += skip;
> +
> +        hpa_offset = (uint64_t)host_addr - decoder_base;
> +
> +        hdm_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * 0x20 / 4);
> +        iw = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IW);
> +        ig = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IG);
> +        if (!FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED)) {
> +            return false;
> +        }
> +        if (((uint64_t)host_addr < decoder_base) ||
> +            (hpa_offset >= decoder_size)) {
> +            dpa_base += decoder_size /
> +                cxl_interleave_ways_dec(iw, &error_fatal);
> +            continue;
> +        }
>   
> -    hpa_offset = (uint64_t)host_addr - decoder_base;
> +        *dpa = dpa_base +
> +            ((MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> +             ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset)
> +              >> iw));
>   
> -    decoder_size = ((uint64_t)cache_mem[R_CXL_HDM_DECODER0_SIZE_HI] << 32) |
> -        cache_mem[R_CXL_HDM_DECODER0_SIZE_LO];
> -    if (hpa_offset >= decoder_size) {
> -        return false;
> +        return true;
>       }
> -
> -    hdm0_ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL];
> -    iw = FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IW);
> -    ig = FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IG);
> -
> -    *dpa = (MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> -        ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset) >> iw);
> -
> -    return true;
> +    return false;
>   }
>   
>   static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,


