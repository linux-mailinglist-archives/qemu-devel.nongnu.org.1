Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DDC8320C0
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 22:13:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQZgf-0007pG-5K; Thu, 18 Jan 2024 16:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQZgb-0007oN-Rc
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 16:12:29 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQZga-00054M-5I
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 16:12:29 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5cfaf7ef393so67573a12.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 13:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705612346; x=1706217146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xxl1R0nHC9E48b3Yhe/L2m2Hm4QPM1/RyLMfsET8jHg=;
 b=XNkz7LUEG+OPqyX50pzo722dKbsqHbc6Rhi2zuUL/ptaWFJcOX0R7iA6XDPgKyrf+O
 du++rlmXmn/L5yVEcHnRAOWgfvg9WMfuaTMdM6PsyrNc3VJxnaH7fpfKGYEsUeQJPUls
 NasV+W2WOAhijfv8xbC0zBrldtn/TMYUEudRzS0644nvOpiZ5SCqrdeTU6GukmmsOqG6
 5xEnWfsqDPtgeBToqLRR6GFrVd8oqKlSw0ti8brwJX+Fr5mGvAZdHkV0JDfGvIQb+/sB
 k36C7cvB40aIoJhoAJTLsICo8GwXBDE0Q/as/E0PuP3uF2wPty8GI8O+ZikkHB5DL86+
 /BTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705612346; x=1706217146;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xxl1R0nHC9E48b3Yhe/L2m2Hm4QPM1/RyLMfsET8jHg=;
 b=HSc0jpqQf9U9frQeg8IuFgjKRmmOWeDyI7pGGOlFyDKfCsmF5e+VZxm3oao53zI23v
 BFwmFq1jVw+uGOYQphfMfiZaGywphZhTMpUkZiDEvp0L2zcXx75vOCKJOQS74CDFQ2hU
 /MyjJrOa9dUSN8szIw6N/NasD4GWZeCpcDGMOeYnF0lSCNV2n3kyNF7GA+QfHx/uMi5c
 Wp/QzeXvT8/dhVyz/qYreov7t323L+3WJfAyaWNNYk1jHmgWhdKvBIcRz4F+6jynMGQz
 VdgRcLPXZFelbJPcy59lvyAHYArPr2LWlk263OliMaGj16ODrgcLliLkWfSkP154JuT2
 TIwQ==
X-Gm-Message-State: AOJu0YzdQLX3KHA8rL+HIV3kIHrsTIdPgn7Dqlyo4HHpPLGck5AZGv1p
 nudU4F9DobJ/dmJJGEBliEY8kEfPUaLuLes5dHsp/xAqvIC7G25pQqFV8pp8Ykg=
X-Google-Smtp-Source: AGHT+IH2BRzV0x30KZOpSNu2azYx1KXjz3cQZ3dFBDsqGCZ1jyxcSSRBVznPiVGEpxRRuU41g1VOsQ==
X-Received: by 2002:a17:90a:e014:b0:28c:bc02:6df8 with SMTP id
 u20-20020a17090ae01400b0028cbc026df8mr1264887pjy.86.1705612346512; 
 Thu, 18 Jan 2024 13:12:26 -0800 (PST)
Received: from ?IPV6:2001:8004:2728:321b:4bd7:3071:22d6:a756?
 ([2001:8004:2728:321b:4bd7:3071:22d6:a756])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a17090ad40500b0029004b9df9fsm2331348pju.36.2024.01.18.13.12.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 13:12:26 -0800 (PST)
Message-ID: <6d82413f-3729-4e6e-837b-996038ebaa63@linaro.org>
Date: Fri, 19 Jan 2024 08:12:18 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/s390x: Emulate CVDG
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Ido Plat <Ido.Plat@ibm.com>
References: <20240115202308.1930675-1-iii@linux.ibm.com>
 <20240115202308.1930675-2-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240115202308.1930675-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 1/16/24 07:21, Ilya Leoshkevich wrote:
> CVDG is the same as CVD, except that it converts 64 bits into 128,
> rather than 32 into 64. Use larger data types in the CVD helper and
> reuse it.
> 
> Reported-by: Ido Plat <Ido.Plat@ibm.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/helper.h            |  1 +
>   target/s390x/tcg/insn-data.h.inc |  1 +
>   target/s390x/tcg/int_helper.c    | 11 ++++++++---
>   target/s390x/tcg/translate.c     |  8 ++++++++
>   4 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 05102578fc9..332a9a9c632 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -89,6 +89,7 @@ DEF_HELPER_FLAGS_2(sqeb, TCG_CALL_NO_WG, i64, env, i64)
>   DEF_HELPER_FLAGS_2(sqdb, TCG_CALL_NO_WG, i64, env, i64)
>   DEF_HELPER_FLAGS_2(sqxb, TCG_CALL_NO_WG, i128, env, i128)
>   DEF_HELPER_FLAGS_1(cvd, TCG_CALL_NO_RWG_SE, i64, s32)
> +DEF_HELPER_FLAGS_1(cvdg, TCG_CALL_NO_RWG_SE, i128, s64)
>   DEF_HELPER_FLAGS_4(pack, TCG_CALL_NO_WG, void, env, i32, i64, i64)
>   DEF_HELPER_FLAGS_4(pka, TCG_CALL_NO_WG, void, env, i64, i64, i32)
>   DEF_HELPER_FLAGS_4(pku, TCG_CALL_NO_WG, void, env, i64, i64, i32)
> diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
> index 2f07f39d9cb..388dcb8dbbc 100644
> --- a/target/s390x/tcg/insn-data.h.inc
> +++ b/target/s390x/tcg/insn-data.h.inc
> @@ -296,6 +296,7 @@
>   /* CONVERT TO DECIMAL */
>       C(0x4e00, CVD,     RX_a,  Z,   r1_o, a2, 0, 0, cvd, 0)
>       C(0xe326, CVDY,    RXY_a, LD,  r1_o, a2, 0, 0, cvd, 0)
> +    C(0xe32e, CVDG,    RXY_a, Z,   r1_o, a2, 0, 0, cvdg, 0)
>   /* CONVERT TO FIXED */
>       F(0xb398, CFEBR,   RRF_e, Z,   0, e2, new, r1_32, cfeb, 0, IF_BFP)
>       F(0xb399, CFDBR,   RRF_e, Z,   0, f2, new, r1_32, cfdb, 0, IF_BFP)
> diff --git a/target/s390x/tcg/int_helper.c b/target/s390x/tcg/int_helper.c
> index eb8e6dd1b57..defb8fc7681 100644
> --- a/target/s390x/tcg/int_helper.c
> +++ b/target/s390x/tcg/int_helper.c
> @@ -99,10 +99,15 @@ Int128 HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al, uint64_t b)
>   }
>   
>   uint64_t HELPER(cvd)(int32_t reg)
> +{
> +    return helper_cvdg(reg);
> +}
> +
> +Int128 HELPER(cvdg)(int64_t reg)
>   {
>       /* positive 0 */
> -    uint64_t dec = 0x0c;
> -    int64_t bin = reg;
> +    Int128 dec = 0x0c;
> +    Int128 bin = reg;
>       int shift;
>   
>       if (bin < 0) {
> @@ -110,7 +115,7 @@ uint64_t HELPER(cvd)(int32_t reg)
>           dec = 0x0d;
>       }
>   
> -    for (shift = 4; (shift < 64) && bin; shift += 4) {
> +    for (shift = 4; (shift < 128) && bin; shift += 4) {
>           dec |= (bin % 10) << shift;
>           bin /= 10;
>       }

None of this will work with the struct version of Int128 -- you need to use the int128_* 
functions for initialization and arithmetic.

I suggest you don't try to share code with CVD.


r~

