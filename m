Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B3578E12B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 23:08:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbSQB-0006K6-FB; Wed, 30 Aug 2023 17:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbSQ8-0006Jk-LP
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 17:08:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbSQ6-0007BV-B4
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 17:08:12 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401b393ddd2so1221625e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 14:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693429688; x=1694034488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qaaWiNaP0sZ2GMs7igiiBycj+HXS+zJPePSi/6kKDcg=;
 b=SZbY+WeVXQoOpvwuwbGx98zOFfC7RK8ub3ysV9fgS8vy4xgKyjedIu1uY3yp5+1a8p
 mtzLg3X0MfXh4asPTjKFoHaGNPlQSgnJq+8zKSnn69U8v4j+OYO7MXc0mAAndacVERXS
 sb4CUJ6L7GvTs3gaOeYV6OTA7g7deuj4TrUA9WETGvmh9GKTZz4Fiji5ZFmw4v1SZrkK
 DAqcWISu7FfeEcur2HQCqfRQ3CjCdEVi8NB8oE7Ld3OPwhy+5VcJZTYkqlxHgsUCTACH
 andafrL3S6YTVZncSC/ewmHYGUArszEn3T8pEd8G/yRs5oLuFf7XnRPIBKc071hnpJlS
 yroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693429688; x=1694034488;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qaaWiNaP0sZ2GMs7igiiBycj+HXS+zJPePSi/6kKDcg=;
 b=Dlcp5piOc2codFCnaeNXb4qG6Mn3JQWmHqD+75/dmeAv3bblRWruliiw787Edl35RP
 jsIpNjeqHN5xM1LAF0RJ+J73rubM4Xb0Sc2W0L7Fa4PWoElaDTQAXfOZygTky1IsQNrJ
 luw+kdH1hOatmtzNbNHlJFo/3APMBdB7SoC56WAUq1+tvXRU2eRTRxYalzToz6S9/a01
 H/VpYAcRt3Tt+4c3fiAxM7jTyb8KwPenjDhpmDhQcA3TVd3Lhkl3RmCztXC1OzLrJXqu
 xtRI/g/RMc8Rxpmoq/TM1KskwoghvfXGZFrbCxgw9gVL78ItQyJvKhQrHWuvtnd54gvM
 9aaA==
X-Gm-Message-State: AOJu0YxGAIJy/PqUtmqIuofaeeTvgbB8sjRSofk0zjs5EJAtInBXyWcx
 gTxVcrDsKXcPniConzbOv0VD484l5BmtIB/rYjfgFl79
X-Google-Smtp-Source: AGHT+IGBLK9Yy02WmAT5bhhcs9ZTmM+GFzkTkz099Qjxw7M3aluNVdMocfXoEGUoXs2Cg9LcxnEVQg==
X-Received: by 2002:a05:600c:cb:b0:3f9:b430:199b with SMTP id
 u11-20020a05600c00cb00b003f9b430199bmr2685690wmm.15.1693429688486; 
 Wed, 30 Aug 2023 14:08:08 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 z23-20020a1c4c17000000b00401d8181f8bsm3264696wmf.25.2023.08.30.14.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 14:08:08 -0700 (PDT)
Message-ID: <bbecffd8-f485-ce75-85da-fe31628b7ac2@linaro.org>
Date: Wed, 30 Aug 2023 23:08:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 07/10] accel/tcg: Merge io_readx into do_ld_mmio_beN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20230828185550.573653-1-richard.henderson@linaro.org>
 <20230828185550.573653-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230828185550.573653-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 28/8/23 20:55, Richard Henderson wrote:
> Avoid multiple calls to io_prepare for unaligned acceses.
> One call to do_ld_mmio_beN will never cross pages.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 84 +++++++++++++++++-----------------------------
>   1 file changed, 30 insertions(+), 54 deletions(-)


> @@ -2059,40 +2033,42 @@ static uint64_t do_ld_mmio_beN(CPUArchState *env, CPUTLBEntryFull *full,
>                                  uint64_t ret_be, vaddr addr, int size,
>                                  int mmu_idx, MMUAccessType type, uintptr_t ra)
>   {
> -    uint64_t t;
> +    MemoryRegionSection *section;
> +    hwaddr mr_offset;
> +    MemoryRegion *mr;
> +    MemTxAttrs attrs;
>   
>       tcg_debug_assert(size > 0 && size <= 8);
> +
> +    attrs = full->attrs;
> +    section = io_prepare(&mr_offset, env, full->xlat_section, attrs, addr, ra);
> +    mr = section->mr;
> +
>       do {
> +        MemOp this_mop;
> +        unsigned this_size;
> +        uint64_t val;
> +        MemTxResult r;
> +
>           /* Read aligned pieces up to 8 bytes. */
> -        switch ((size | (int)addr) & 7) {
> -        case 1:
> -        case 3:
> -        case 5:
> -        case 7:
> -            t = io_readx(env, full, mmu_idx, addr, ra, type, MO_UB);
> -            ret_be = (ret_be << 8) | t;
> -            size -= 1;
> -            addr += 1;
> -            break;
> -        case 2:
> -        case 6:
> -            t = io_readx(env, full, mmu_idx, addr, ra, type, MO_BEUW);
> -            ret_be = (ret_be << 16) | t;
> -            size -= 2;
> -            addr += 2;
> -            break;
> -        case 4:
> -            t = io_readx(env, full, mmu_idx, addr, ra, type, MO_BEUL);
> -            ret_be = (ret_be << 32) | t;
> -            size -= 4;
> -            addr += 4;
> -            break;
> -        case 0:
> -            return io_readx(env, full, mmu_idx, addr, ra, type, MO_BEUQ);
> -        default:
> -            qemu_build_not_reached();
> +        this_mop = ctz32(size | (int)addr | 8);
> +        this_size = 1 << this_mop;

So far:

   memop_size()

But I'll review this patch again after some rest.

> +        this_mop |= MO_BE;
> +
> +        r = memory_region_dispatch_read(mr, mr_offset, &val, this_mop, attrs);
> +        if (unlikely(r != MEMTX_OK)) {
> +            io_failed(env, full, addr, this_size, type, mmu_idx, r, ra);
>           }
> +        if (this_size == 8) {
> +            return val;
> +        }
> +
> +        ret_be = (ret_be << (this_size * 8)) | val;
> +        addr += this_size;
> +        mr_offset += this_size;
> +        size -= this_size;
>       } while (size);
> +
>       return ret_be;
>   }
>   


