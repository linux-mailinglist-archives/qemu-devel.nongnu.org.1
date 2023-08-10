Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97192777AA4
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 16:24:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU6aF-00027w-Eh; Thu, 10 Aug 2023 10:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU6aC-000278-UB
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 10:24:12 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU6aB-0005uQ-6r
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 10:24:12 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so1219585a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691677449; x=1692282249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8cIROWgM81ULThBkGHmsA3T76gE+Z0o8J/hwau0oBOk=;
 b=QJIQt/OiZ0JNpvXTD9Trc73kzlz1FMnspf0w9JPcUCmitH/XqGV6nIRqEvhzOVlNbu
 NQcXWJxzoBlA1C2F3asUYqvvMyJEo3BXSW0dPEQUhOiqkKVJ4tGUh/2lA4TpOzQhHhkd
 WgeQCKxxGopiViR8xNI0wEB9GTr2plQGDdoSDID9SlXKMvqddTLIFkTDHpLR3lzCZnLf
 1GPXlmHXJOEhYApapEJdPQW3lnoXMyba0TRcJLoLGaTp4vf9Gc7E4dIQsh8F2elG8nQA
 qH0mLAgpx/5BA41o6vBlfnC+WSaFf8/G29Dj6+wwdIXnbI+WsocaK5l1jTu+dT8Gy+hc
 5J2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691677449; x=1692282249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8cIROWgM81ULThBkGHmsA3T76gE+Z0o8J/hwau0oBOk=;
 b=KXUSq8we5oezegDWQH5nkLgoBvzfoVR3ZXiMToJzIcb7b17bVt2q7gGeUk6fGl331P
 C9fWllyT86EdIlXtWfR2erMdfWPgBzpHCwcjmu+Rwo0To2siKFADkfuSlsuSfC49btlJ
 N/P0Ua4WpnRJH+dprsWqvPwz5umUMeFviJm+E1atsHYqU5Q3yPQ6UK+cZrFW2HDXNNIW
 8F1N708lhCp5QZahONERMq7kYJ29KsHCai8EoJZXfW4rZGOZfCRRoi3iRcEwY6ESvd5w
 LgeYsyVQDbeDyJB1KHGpwi7fiTlkw0A90Yimp3tD5pHMsjzLKaoZU3C/1/m1DwMDhCjP
 6dWA==
X-Gm-Message-State: AOJu0YwWKH67zTUlBSGgEHCUdneiIt5KWGlRwyCqtG5zLGsb0xHgwnMk
 hyc1G9W1LA8ydma5k3/cqa/1uqkWMnhCn66ahxFmIQ==
X-Google-Smtp-Source: AGHT+IF1JooI85EdEtJNHJK+QWe1OTU9NI3oBpMU2Xr/9572xDg2W2+53S+W1sqNQJPG1Yd73Z7AbQ5jfrd1F4m5nL0=
X-Received: by 2002:a50:fb81:0:b0:523:47b0:9077 with SMTP id
 e1-20020a50fb81000000b0052347b09077mr2322442edq.38.1691677449363; Thu, 10 Aug
 2023 07:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230810023548.412310-1-richard.henderson@linaro.org>
 <20230810023548.412310-5-richard.henderson@linaro.org>
In-Reply-To: <20230810023548.412310-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 15:23:58 +0100
Message-ID: <CAFEAcA8YcX0qq392chnpVdB2-qjk7Jb-4gBEu-e2uDGka3Ccvg@mail.gmail.com>
Subject: Re: [PATCH 4/5] target/arm: Support more GM blocksizes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 10 Aug 2023 at 03:36, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Support all of the easy GM block sizes.
> Use direct memory operations, since the pointers are aligned.
>
> While BS=2 (16 bytes, 1 tag) is a legal setting, that requires
> an atomic store of one nibble.  This is not difficult, but there
> is also no point in supporting it until required.
>
> Note that cortex-a710 sets GM blocksize to match its cacheline
> size of 64 bytes.  I expect many implementations will also
> match the cacheline, which makes 16 bytes very unlikely.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/mte_helper.c | 61 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 53 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index 3640c6e57f..6faf4e42d5 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -428,6 +428,8 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
>      int gm_bs = env_archcpu(env)->gm_blocksize;
>      int gm_bs_bytes = 4 << gm_bs;
>      void *tag_mem;
> +    uint64_t ret;
> +    int shift;
>
>      ptr = QEMU_ALIGN_DOWN(ptr, gm_bs_bytes);
>
> @@ -443,16 +445,39 @@ uint64_t HELPER(ldgm)(CPUARMState *env, uint64_t ptr)
>
>      /*
>       * The ordering of elements within the word corresponds to
> -     * a little-endian operation.
> +     * a little-endian operation.  Computation of shift comes from
> +     *
> +     *     index = address<LOG2_TAG_GRANULE+3:LOG2_TAG_GRANULE>
> +     *     data<index*4+3:index*4> = tag
> +     *
> +     * Because of the alignment of ptr above, BS=6 has shift=0.
> +     * All memory operations are aligned.
>       */
>      switch (gm_bs) {
> -    case 6:
> -        /* 256 bytes -> 16 tags -> 64 result bits */
> -        return ldq_le_p(tag_mem);
> -    default:
> +    case 2:
>          /* cpu configured with unsupported gm blocksize. */
>          g_assert_not_reached();
> +    case 3:
> +        /* 32 bytes -> 2 tags -> 8 result bits */
> +        ret = *(uint8_t *)tag_mem;
> +        break;
> +    case 4:
> +        /* 64 bytes -> 4 tags -> 16 result bits */
> +        ret = cpu_to_le16(*(uint16_t *)tag_mem);

Does this really make a difference compared to ldw_le_p() ?

> +        break;
> +    case 5:
> +        /* 128 bytes -> 8 tags -> 32 result bits */
> +        ret = cpu_to_le32(*(uint32_t *)tag_mem);
> +        break;
> +    case 6:
> +        /* 256 bytes -> 16 tags -> 64 result bits */
> +        return cpu_to_le64(*(uint64_t *)tag_mem);
> +    default:
> +        /* cpu configured with invalid gm blocksize. */
> +        g_assert_not_reached();

Is it worth having an assert in CPU realize for an invalid
blocksize, so that we can catch duff ID register values
without having to rely on there being a test run that
uses ldgm/stgm ?

>      }
> +    shift = extract64(ptr, LOG2_TAG_GRANULE, 4) * 4;
> +    return ret << shift;
>  }
>
>  void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
> @@ -462,6 +487,7 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
>      int gm_bs = env_archcpu(env)->gm_blocksize;
>      int gm_bs_bytes = 4 << gm_bs;
>      void *tag_mem;
> +    int shift;
>
>      ptr = QEMU_ALIGN_DOWN(ptr, gm_bs_bytes);
>
> @@ -480,14 +506,33 @@ void HELPER(stgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
>
>      /*
>       * The ordering of elements within the word corresponds to
> -     * a little-endian operation.
> +     * a little-endian operation.  See LDGM for comments on shift.
> +     * All memory operations are aligned.
>       */
> +    shift = extract64(ptr, LOG2_TAG_GRANULE, 4) * 4;
> +    val >>= shift;
>      switch (gm_bs) {
> +    case 2:
> +        /* cpu configured with unsupported gm blocksize. */
> +        g_assert_not_reached();
> +    case 3:
> +        /* 32 bytes -> 2 tags -> 8 result bits */
> +        *(uint8_t *)tag_mem = val;
> +        break;
> +    case 4:
> +        /* 64 bytes -> 4 tags -> 16 result bits */
> +        *(uint16_t *)tag_mem = cpu_to_le16(val);
> +        break;
> +    case 5:
> +        /* 128 bytes -> 8 tags -> 32 result bits */
> +        *(uint32_t *)tag_mem = cpu_to_le32(val);
> +        break;
>      case 6:
> -        stq_le_p(tag_mem, val);
> +        /* 256 bytes -> 16 tags -> 64 result bits */
> +        *(uint64_t *)tag_mem = cpu_to_le64(val);
>          break;
>      default:
> -        /* cpu configured with unsupported gm blocksize. */
> +        /* cpu configured with invalid gm blocksize. */
>          g_assert_not_reached();
>      }
>  }
> --
> 2.34.1

thanks
-- PMM

