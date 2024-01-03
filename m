Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A906823764
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 23:00:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL9G6-0006N8-8C; Wed, 03 Jan 2024 16:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rL9G4-0006Me-Lw
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 16:58:40 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rL9G2-0005la-NQ
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 16:58:40 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d408c2908cso28052625ad.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 13:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704319116; x=1704923916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=opKxbXQuYffQjWUNzILHPw6iSGXqTzk5hotfxbKQvoI=;
 b=ZIlEF2DDRSawbDVHjIqforzJRgNjtFrDSco8IGmhXxOztsPP6sI4bwlyDg5CSwamES
 iWI2/LEV0Rr+Inu+Hszip1cpFn7VKcLHIM2xKEUaw1xRLeW/QuMWtN9iJ9MaqN/K+Qdl
 iM/q5Tman9eTk7JwbsKTaKBp2sD7QRRySvr2xdNe+yW74LZVwsIxatA1Byeq8ew2uZZm
 IgK8XUJXBvsH0atzU4gcRYQe1+YrPw9qNiz9Oil7o/8DttccoKnoOBzxaRsSnN4NEaWd
 giUXpASsqsR1XXsuDRMF4vflA8RkIn7GfxWzvLJxr0Lj/dSw/F5IZNUZCzs9CxcWzqsd
 Y8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704319116; x=1704923916;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=opKxbXQuYffQjWUNzILHPw6iSGXqTzk5hotfxbKQvoI=;
 b=qG0xPdg+oXHLty7UM8vpQteSDWOMWcvM1/0s97yx4B++tRE8scr8CzxV4UeITbO7MH
 6BxCTZ7rGLDEK6Xb3Ek+5KyK+yTfDSmcw2oLeD8zC65AhBfAk2kuo9VPtOI1Mo6DzD9x
 XM9C9v5f57kVuy4IhqJS13B5bGO+KczWzvJ9phxP81Ek09UX51PypOFNjapup67YKH8O
 zLnaaQnnNSBd5e7sR0wNs4hJOIAyjHbUKYuNHwmCC2MbcBVXUJ6Gc9fIfB06ePASyECR
 6SW3gmD+LFJXFC4/ZPP/fpC8cyOtptz0qAdJawkf6FOPU4fTeptzWHv2IJVO+3AA7Rxk
 2HPQ==
X-Gm-Message-State: AOJu0Yx3kMjG9gfVaKqA3eDPkBm811XT+aglwf9UXPKAHe3B60L6I/2j
 gG9mgj0X1ActlHK10YYJShC6jmAWixpOMw==
X-Google-Smtp-Source: AGHT+IGScWEgQ8yWjIjMObry65Mo+Pp5K/Vv97mDvFQA6VygP15L+qyegpEPOILtSDTXVwARWZaiNQ==
X-Received: by 2002:a17:903:444:b0:1d4:b881:2e79 with SMTP id
 iw4-20020a170903044400b001d4b8812e79mr2543886plb.2.1704319115683; 
 Wed, 03 Jan 2024 13:58:35 -0800 (PST)
Received: from [192.168.50.95] (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 d19-20020a170902b71300b001d4c98c7439sm3505346pls.276.2024.01.03.13.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 13:58:34 -0800 (PST)
Message-ID: <a0a5cfd7-6889-4fa0-982c-47dfec8c857a@linaro.org>
Date: Thu, 4 Jan 2024 08:58:28 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/20] tcg/s390x: Implement vector NAND, NOR, EQV
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x <qemu-s390x@nongnu.org>
References: <20211218194250.247633-1-richard.henderson@linaro.org>
 <20211218194250.247633-5-richard.henderson@linaro.org>
 <b962d769-ed44-4620-bcf2-4fcc7658db1a@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b962d769-ed44-4620-bcf2-4fcc7658db1a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 1/4/24 00:21, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> (revisiting this old patch which is now commit 21eab5bfae)
> 
> On 18/12/21 20:42, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/s390x/tcg-target.h     |  6 +++---
>>   tcg/s390x/tcg-target.c.inc | 17 +++++++++++++++++
>>   2 files changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
>> index ad29e62b16..fef227b0fe 100644
>> --- a/tcg/s390x/tcg-target.h
>> +++ b/tcg/s390x/tcg-target.h
>> @@ -145,9 +145,9 @@ extern uint64_t s390_facilities[3];
>>   #define TCG_TARGET_HAS_andc_vec       1
>>   #define TCG_TARGET_HAS_orc_vec        HAVE_FACILITY(VECTOR_ENH1)
>> -#define TCG_TARGET_HAS_nand_vec       0
>> -#define TCG_TARGET_HAS_nor_vec        0
>> -#define TCG_TARGET_HAS_eqv_vec        0
>> +#define TCG_TARGET_HAS_nand_vec       HAVE_FACILITY(VECTOR_ENH1)
>> +#define TCG_TARGET_HAS_nor_vec        1
>> +#define TCG_TARGET_HAS_eqv_vec        HAVE_FACILITY(VECTOR_ENH1)
> 
> Here some opcodes are conditional, ...
> 
>>   #define TCG_TARGET_HAS_not_vec        1
>>   #define TCG_TARGET_HAS_neg_vec        1
>>   #define TCG_TARGET_HAS_abs_vec        1
>> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
>> index 57e803e339..5a90b892cb 100644
>> --- a/tcg/s390x/tcg-target.c.inc
>> +++ b/tcg/s390x/tcg-target.c.inc
>> @@ -288,7 +288,9 @@ typedef enum S390Opcode {
>>       VRRc_VMXL   = 0xe7fd,
>>       VRRc_VN     = 0xe768,
>>       VRRc_VNC    = 0xe769,
>> +    VRRc_VNN    = 0xe76e,
>>       VRRc_VNO    = 0xe76b,
>> +    VRRc_VNX    = 0xe76c,
>>       VRRc_VO     = 0xe76a,
>>       VRRc_VOC    = 0xe76f,
>>       VRRc_VPKS   = 0xe797,   /* we leave the m5 cs field 0 */
>> @@ -2750,6 +2752,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>>       case INDEX_op_xor_vec:
>>           tcg_out_insn(s, VRRc, VX, a0, a1, a2, 0);
>>           break;
>> +    case INDEX_op_nand_vec:
>> +        tcg_out_insn(s, VRRc, VNN, a0, a1, a2, 0);
>> +        break;
>> +    case INDEX_op_nor_vec:
>> +        tcg_out_insn(s, VRRc, VNO, a0, a1, a2, 0);
>> +        break;
>> +    case INDEX_op_eqv_vec:
>> +        tcg_out_insn(s, VRRc, VNX, a0, a1, a2, 0);
>> +        break;
>>       case INDEX_op_shli_vec:
>>           tcg_out_insn(s, VRSa, VESL, a0, a2, TCG_REG_NONE, a1, vece);
>> @@ -2846,7 +2857,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
>>       case INDEX_op_and_vec:
>>       case INDEX_op_andc_vec:
>>       case INDEX_op_bitsel_vec:
>> +    case INDEX_op_eqv_vec:
>> +    case INDEX_op_nand_vec:
> 
> ... but here we unconditionally return 1 for them.
> 
> Shouldn't we return TCG_TARGET_HAS_opcode instead?

Yes, you're right.  There's some logical overlap between tcg_gen_emit_vec_op and 
tcg_op_supported, and I think I confused myself a bit there.


r~

