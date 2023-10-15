Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 262FE7C9ACC
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 20:35:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs5wB-0005IV-Hs; Sun, 15 Oct 2023 14:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qs5w9-0005IM-OE
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 14:34:01 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qs5w8-0000PH-7l
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 14:34:01 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ca74e77aecso2211065ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697394838; x=1697999638; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oifn9HTrGbG3x2HBRYPnRqYMJMTJpLoXqfcRd0S1lLc=;
 b=EvYeMCZD6j4WJDv9aleC7jZQBARQbjvdnEHrO5+rxUcUx1QF373oKVeUkgcEaFGZMi
 rL+lIkwYft8R1h2lh7aF/t91TepVC1D4mKvHyjBzdb0ionlq3ajkYiZhcRqlkFYuOtyP
 bfdswtzsGjWdebwYLl0fBrgW33lJZ3O30W+N/jCcAQ1efyleS/P1Ky/XrPBFqF6Ueyrl
 SBh0XBHxEQp44DyBntRl8aYf8PBJH1JX4qnFqXh/mrxK8zBtmXeoyVi9I0+C3IUO4540
 tfpYOPlMQ/d1ceV1jIpdfD6whKSrP92b5ZyqekEthdtBwMRUtVLtNHK7C+wvFpL1EIqU
 mWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697394838; x=1697999638;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oifn9HTrGbG3x2HBRYPnRqYMJMTJpLoXqfcRd0S1lLc=;
 b=ZEHsWNa/p1ulSdBVOG8bj7BEWF1O4Heyrc4JI4r+FEp4aGZMEwTm5GO7syp8Des0wk
 OeLVJ9geqN3ujp854JiFJo/pnvs2KUBWYxKyZgDGHDrC2JbkXRl9NZz6zLeRlYIQnwC+
 NflZ2OzOHh0KZ3Lf2nihHmSdv4h9nX8HruoYWzAkRftHDSJDU9zePL73q1D0d+Oq5h4u
 qy7Zw80w/2vsUUrlCM8cf5o/CMVP70fWA0/YqzpnzuyJ3TiHel1ThiKP3cUJgveoKzrP
 3ppOvVdJG7Ufir0a2YfqmcBwfIf86nw3OoKe8pXZyRITutdMhUhVvTl1B5T4t25SiKaz
 b02Q==
X-Gm-Message-State: AOJu0YyqIsaPqRWNM0AqIGUjrKcCEwZUIOKs/pkweP1QCb30915HL7y1
 0Tasr95N/l3v/05r9MtZDFGc7w==
X-Google-Smtp-Source: AGHT+IHCaMQMAyWaynVXnIZtWcMD/vjB+wFBWG0M3IYlrMdx0G9LWhOSs8+r7GhN3X/IBmkAAHs+GA==
X-Received: by 2002:a17:90a:1cc:b0:263:f521:da3e with SMTP id
 12-20020a17090a01cc00b00263f521da3emr8253340pjd.2.1697394838295; 
 Sun, 15 Oct 2023 11:33:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 h16-20020a17090adb9000b00279060a0fccsm3242362pjv.9.2023.10.15.11.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 11:33:57 -0700 (PDT)
Message-ID: <1465d323-bec7-4e3b-b224-e28071306fb9@linaro.org>
Date: Sun, 15 Oct 2023 11:33:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: drop unused tcg_temp_free define
Content-Language: en-US
To: Mike Frysinger <vapier@gentoo.org>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
References: <20231015010046.16020-1-vapier@gentoo.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231015010046.16020-1-vapier@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 10/14/23 18:00, Mike Frysinger wrote:
> Use of the API was removed a while back, but the define wasn't.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>   include/tcg/tcg-op.h | 2 --
>   1 file changed, 2 deletions(-)

Thanks for the catch.

Queued.

r~

> 
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index 80cfcf8104b6..3ead59e4594d 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
> @@ -52,7 +52,6 @@ static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
>   typedef TCGv_i32 TCGv;
>   #define tcg_temp_new() tcg_temp_new_i32()
>   #define tcg_global_mem_new tcg_global_mem_new_i32
> -#define tcg_temp_free tcg_temp_free_i32
>   #define tcgv_tl_temp tcgv_i32_temp
>   #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i32
>   #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i32
> @@ -60,7 +59,6 @@ typedef TCGv_i32 TCGv;
>   typedef TCGv_i64 TCGv;
>   #define tcg_temp_new() tcg_temp_new_i64()
>   #define tcg_global_mem_new tcg_global_mem_new_i64
> -#define tcg_temp_free tcg_temp_free_i64
>   #define tcgv_tl_temp tcgv_i64_temp
>   #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i64
>   #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i64


