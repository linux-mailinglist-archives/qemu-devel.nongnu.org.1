Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 044C6822E27
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 14:23:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL1C6-0006gu-EH; Wed, 03 Jan 2024 08:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL1C3-0006gP-KO
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 08:21:59 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL1C1-0001Nz-Uc
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 08:21:59 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d2376db79so93994725e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 05:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704288115; x=1704892915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ImRCU49+H0fx7XhDhJ2pDu5iKWo5h6tenHk37rX1Xs=;
 b=CHhShSJFxrimvTF+3qLNoDql1Log0/y++EUFgvzto+UcYz8gAiPr6zGN3o3HpiZYtQ
 c+KN7DDFfncPlQ4YWsKZW5EQY0/uiVyjo/tSWzE2VuDdUh3UkYVQuJGB9HtHvLFDSAqr
 mLMtdNnW4I3rf7kaCNJOoCHkQLI+EoJZC6bDR63Vat2zjq4tVJQcJJzRne1Zu8EsOtJ7
 FQv+SvR+9nZqozFQLrNv4HCcX2Ekaao9XcqjoBQieBqT3saOWSTo945e5U6j5lYuhZfQ
 AKv6K6od+o3gzSaphUcDWQ46Jp9/kpiUPl6jFFXYEifKDkPmzbxmoDHKCOA7bPxsbPgd
 h0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704288115; x=1704892915;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ImRCU49+H0fx7XhDhJ2pDu5iKWo5h6tenHk37rX1Xs=;
 b=FdB5KNeBZP1OMhVGn4H30pXag3mEBuKOwif3G1UX1rSEvXPyCJPKcj1ckR7yFpHBvz
 7WuC7vRU0nE+pCGIZAoA07vJdPT9ar7C43RTnlhkbHmQn+FTcwCFI+mprCOG4TO2tyE5
 Eshsp4R+RGU0U7nEAJ1FlstB4TzRhMertdmQGxEXbb974G07GcDtMSLaTT3hitzR9FXK
 SukUUBUfiGgYzhkMyliodpBKq3V0o5BplV8PMJVhagt1dR5U0/fBsg/kbfh0PB5DsYeB
 msMqNw7UFgj6Mz9gSc5WCP4kJ452TQyy/RKjB5p7X8GmQ42u6qkHCUuyy6Ue+CgLuycp
 fqTA==
X-Gm-Message-State: AOJu0YzOjKvwQOYUwAVlcgCDrGiFYdoTc/oa7oVPA4zwS91sV0chSbVI
 R/JMHdJ10yM1LPgGs901CPgaXfGUc07ALw==
X-Google-Smtp-Source: AGHT+IFFlV6iuVGpXe4U/L97EOesVFkkP6TrMqjxHNji0hfbesPH6ZvkdBNepRB6zX7+pbUAQQXEHA==
X-Received: by 2002:a05:600c:1f88:b0:40d:62c4:3f3 with SMTP id
 je8-20020a05600c1f8800b0040d62c403f3mr4630846wmb.106.1704288115092; 
 Wed, 03 Jan 2024 05:21:55 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 g3-20020a5d4883000000b00336e32338f3sm19625625wrq.70.2024.01.03.05.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 05:21:54 -0800 (PST)
Message-ID: <b962d769-ed44-4620-bcf2-4fcc7658db1a@linaro.org>
Date: Wed, 3 Jan 2024 14:21:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/20] tcg/s390x: Implement vector NAND, NOR, EQV
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20211218194250.247633-1-richard.henderson@linaro.org>
 <20211218194250.247633-5-richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x <qemu-s390x@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20211218194250.247633-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Richard,

(revisiting this old patch which is now commit 21eab5bfae)

On 18/12/21 20:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/s390x/tcg-target.h     |  6 +++---
>   tcg/s390x/tcg-target.c.inc | 17 +++++++++++++++++
>   2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
> index ad29e62b16..fef227b0fe 100644
> --- a/tcg/s390x/tcg-target.h
> +++ b/tcg/s390x/tcg-target.h
> @@ -145,9 +145,9 @@ extern uint64_t s390_facilities[3];
>   
>   #define TCG_TARGET_HAS_andc_vec       1
>   #define TCG_TARGET_HAS_orc_vec        HAVE_FACILITY(VECTOR_ENH1)
> -#define TCG_TARGET_HAS_nand_vec       0
> -#define TCG_TARGET_HAS_nor_vec        0
> -#define TCG_TARGET_HAS_eqv_vec        0
> +#define TCG_TARGET_HAS_nand_vec       HAVE_FACILITY(VECTOR_ENH1)
> +#define TCG_TARGET_HAS_nor_vec        1
> +#define TCG_TARGET_HAS_eqv_vec        HAVE_FACILITY(VECTOR_ENH1)

Here some opcodes are conditional, ...

>   #define TCG_TARGET_HAS_not_vec        1
>   #define TCG_TARGET_HAS_neg_vec        1
>   #define TCG_TARGET_HAS_abs_vec        1
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index 57e803e339..5a90b892cb 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -288,7 +288,9 @@ typedef enum S390Opcode {
>       VRRc_VMXL   = 0xe7fd,
>       VRRc_VN     = 0xe768,
>       VRRc_VNC    = 0xe769,
> +    VRRc_VNN    = 0xe76e,
>       VRRc_VNO    = 0xe76b,
> +    VRRc_VNX    = 0xe76c,
>       VRRc_VO     = 0xe76a,
>       VRRc_VOC    = 0xe76f,
>       VRRc_VPKS   = 0xe797,   /* we leave the m5 cs field 0 */
> @@ -2750,6 +2752,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>       case INDEX_op_xor_vec:
>           tcg_out_insn(s, VRRc, VX, a0, a1, a2, 0);
>           break;
> +    case INDEX_op_nand_vec:
> +        tcg_out_insn(s, VRRc, VNN, a0, a1, a2, 0);
> +        break;
> +    case INDEX_op_nor_vec:
> +        tcg_out_insn(s, VRRc, VNO, a0, a1, a2, 0);
> +        break;
> +    case INDEX_op_eqv_vec:
> +        tcg_out_insn(s, VRRc, VNX, a0, a1, a2, 0);
> +        break;
>   
>       case INDEX_op_shli_vec:
>           tcg_out_insn(s, VRSa, VESL, a0, a2, TCG_REG_NONE, a1, vece);
> @@ -2846,7 +2857,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
>       case INDEX_op_and_vec:
>       case INDEX_op_andc_vec:
>       case INDEX_op_bitsel_vec:
> +    case INDEX_op_eqv_vec:
> +    case INDEX_op_nand_vec:

... but here we unconditionally return 1 for them.

Shouldn't we return TCG_TARGET_HAS_opcode instead?

>       case INDEX_op_neg_vec:
> +    case INDEX_op_nor_vec:
>       case INDEX_op_not_vec:
>       case INDEX_op_or_vec:
>       case INDEX_op_orc_vec:

(expanding context)

             return 1;

> @@ -3191,6 +3205,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
>       case INDEX_op_or_vec:
>       case INDEX_op_orc_vec:
>       case INDEX_op_xor_vec:
> +    case INDEX_op_nand_vec:
> +    case INDEX_op_nor_vec:
> +    case INDEX_op_eqv_vec:
>       case INDEX_op_cmp_vec:
>       case INDEX_op_mul_vec:
>       case INDEX_op_rotlv_vec:


