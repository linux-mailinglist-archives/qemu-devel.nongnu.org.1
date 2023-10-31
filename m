Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B83997DD8AC
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 23:58:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxxg3-0000r6-3x; Tue, 31 Oct 2023 18:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxxg0-0000q1-TR
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:57:37 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxxfz-0005IP-5R
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:57:36 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc5916d578so20669195ad.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 15:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698793053; x=1699397853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BhGNGdxa4/d8ZDlpnCZwy/mHJAyLq0uREVqTdRISnwc=;
 b=m2PYcqJw7S5IduoJRrFvRdg4DHYmaVLKLxRL8AvtwcLhMsP0gGvbJQ9tbVUf6Jp+1J
 DH4nVAwAmbtmA5f3cxi0TerCF2mLSVde/8gpAZTXKOdP/OMnmucI15DXbkpxZj7drOO1
 +r7SMd4DN27tIZRcFLeMWlcUHwZSNlTHAMchnhwfuIQ/g6aB5fwcvUsNRHHINfSYRirh
 wfjDw9gd6Mj0+kCL1oyJ8JwiekOKeud4tWKxGhu/eQzVrc2zRzMLDAapP0HCt2AwTr5L
 dz177xNulbt1gDE/4d/nrAh0A/dA09ujSgmrbFiCTG0MkG7itU8tIIhPhDSsfq/71uaU
 6jOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698793053; x=1699397853;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BhGNGdxa4/d8ZDlpnCZwy/mHJAyLq0uREVqTdRISnwc=;
 b=RVVGz7pVHZofW0i/F4FeTfcoW3Hoi8/HLxWlfXeeW+cZZelmJRNSzBmYe9+/ENoYWL
 pLeubpInb+B23QRu1v4GIzstH95nO/Y2B/eM2IiFizNPYjUH7XL26kEGNHUPhNIyGPwb
 u/TUgpVSU92OG3uq60DQVcGSqvTlAgxHpmhCXYZxUzyocyUA2BjqU55XUoplW/D0AFkk
 qbbDGpYL8T530v7HKdkgeoc9mI5NKRTOZe8BDF+8depEuOoVa6onkhkwKbjFO8zNQvAW
 Nwe7BSIZya2fmO37C64UxzxbbJ5rgZSR4l1WzOYrTQKNRjkd6Ea/ofEyp/nS57UCZISo
 x8HQ==
X-Gm-Message-State: AOJu0YwPyJYVk0RozNyVb0I8Y0RmMd2hycZtv3XpRdDIyrzoL3e/R/6n
 U8w+uJWkoTJzdzvVuX7HDkOFUQ==
X-Google-Smtp-Source: AGHT+IHwGWzDs2t/962YqGxETiqfb7zkJXUk2JemiZdg1SHegqDZ8Zmd32kPMcpsFRlhr1JsP5d0Rg==
X-Received: by 2002:a17:903:60c:b0:1cc:617e:9c25 with SMTP id
 kg12-20020a170903060c00b001cc617e9c25mr3754215plb.53.1698793053599; 
 Tue, 31 Oct 2023 15:57:33 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a170902da8100b001cc50146b43sm76372plx.202.2023.10.31.15.57.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 15:57:33 -0700 (PDT)
Message-ID: <726a332a-ddca-4788-a9f9-abe6033601a2@linaro.org>
Date: Tue, 31 Oct 2023 15:57:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/s390x: Fix LAALG not updating cc_src
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-stable@nongnu.org
References: <20231031053718.347100-1-iii@linux.ibm.com>
 <20231031053718.347100-4-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231031053718.347100-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 10/30/23 22:32, Ilya Leoshkevich wrote:
> LAALG uses op_laa() and cout_addu64(). The latter expects cc_src to be
> set, but the former does not do it. This can lead to assertion failures
> if something sets cc_src to neither 0 nor 1 before.
> 
> Fix by setting cc_src in op_laa().
> 
> Fixes: 4dba4d6fef61 ("target/s390x: Use atomic operations for LOAD AND OP")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/translate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index a0d6a2a35dd..db386ea94d8 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -2684,7 +2684,8 @@ static DisasJumpType op_laa(DisasContext *s, DisasOps *o)
>       tcg_gen_atomic_fetch_add_i64(o->in2, o->in2, o->in1, get_mem_index(s),
>                                    s->insn->data | MO_ALIGN);
>       /* However, we need to recompute the addition for setting CC.  */
> -    tcg_gen_add_i64(o->out, o->in1, o->in2);
> +    tcg_gen_movi_i64(cc_src, 0);
> +    tcg_gen_add2_i64(o->out, cc_src, o->in1, cc_src, o->in2, cc_src);
>       return DISAS_NEXT;
>   }
>   

This is wrong, or at least not ideal -- op_laa is not *only* used with cout_addu64.
I think this would be better with a second version of op_laa.


r~


