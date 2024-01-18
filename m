Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 218708312DD
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 07:50:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQMEC-0006gc-1t; Thu, 18 Jan 2024 01:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQME6-0006fg-0D
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 01:50:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQME4-0006C4-Ha
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 01:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705560607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+q9UYr5HO0+DSYIXJpM1CdTnyWPdZGdg1J3mSWLIHo8=;
 b=BWRLB5SqAYfm7P92/HWmfapwIxAPdLOfmy+tndynOfmgqAYJIQA/J6CS3qW6UKGvwvSuBp
 0IPx0iHW7UxxI/osJqalAhypLRXh6HPrYL+M8uNcWw62O6ujucTmBNK8oiXLuVIJDRNuDY
 q5tXvrbv+TI6i73AvCpUIjOOuCNZH5Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-N969WygjM1GNyX3ZinmCdA-1; Thu, 18 Jan 2024 01:50:05 -0500
X-MC-Unique: N969WygjM1GNyX3ZinmCdA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-42a08954c4fso42952521cf.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 22:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705560605; x=1706165405;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+q9UYr5HO0+DSYIXJpM1CdTnyWPdZGdg1J3mSWLIHo8=;
 b=LzIOPi4kDvhIcct+vgCIRG3S5FUJA5JYIHIuP5bxuu0w+EBzlmrP6RiWTiKdIDlH1g
 RyJKwZxwvQAqzGLPJaIB0K6IrhUOKTSsPF0O4uCD0a7Pe+E71Nc8PoGcwq7GqZQx2jhV
 jp1hlp3pad5vzw3mpvHAVCcRUtLyNftDkSX5YhBWUAKOlTuQXOnRW8Y4m5pNK8IkNoNm
 CJJNlMcShLyf28Qy0IKdGbdRxPhyxsEWbRSRzIJSx2EnFpzCagWCrlrbvcVBwyKbFP4s
 OHKk9LCYxGvSTGsbS/TEsn2pFZgjZb/M2S4xUpmXEaOc7hBJRnXsxQmX9AAzqpSUwCLa
 xMCw==
X-Gm-Message-State: AOJu0YxQh6+oWeNXEBe8xOSbm/FDYnX11yDJxk+LTOhiEyKnKuRtTZ/Y
 MNfKPS4OkEMBzcgguPqP5EHBBdsCnjknlEPAZde/4Aeb6oJSe6bryaPTejnOmSwHhiHck0Sj8tV
 XT96IgEKbJi8Fu484c3XMlU04KU1cJJk2qzmB+7Xde1j9PzwaUlTi
X-Received: by 2002:ac8:7c44:0:b0:42a:4e8:e2cf with SMTP id
 o4-20020ac87c44000000b0042a04e8e2cfmr457181qtv.45.1705560603749; 
 Wed, 17 Jan 2024 22:50:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF761B2bPlJh08VmY5GJ6ztQvO432aUEYACZO39tUtb3UpSiAORRgLOyYBXbcMDM7vtmvZGSQ==
X-Received: by 2002:ac8:7c44:0:b0:42a:4e8:e2cf with SMTP id
 o4-20020ac87c44000000b0042a04e8e2cfmr457176qtv.45.1705560603373; 
 Wed, 17 Jan 2024 22:50:03 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-179-227.web.vodafone.de.
 [109.43.179.227]) by smtp.gmail.com with ESMTPSA id
 t13-20020a05620a004d00b00783749b0d2fsm933238qkt.94.2024.01.17.22.50.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 22:50:03 -0800 (PST)
Message-ID: <463db12c-cb2c-495c-8dc8-5b0d2085c4bc@redhat.com>
Date: Thu, 18 Jan 2024 07:50:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tcg/s390x: Fix encoding of VRIc, VRSa, VRSc insns
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, david@redhat.com, philmd@linaro.org,
 mjt@tls.msk.ru, qemu-stable@nongnu.org
References: <20240117213646.159697-1-richard.henderson@linaro.org>
 <20240117213646.159697-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240117213646.159697-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 17/01/2024 22.36, Richard Henderson wrote:
> While the format names the second vector register 'v3',
> it is still in the second position (bits 12-15) and
> the argument to RXB must match.
> 
> Example error:
>   -   e7 00 00 10 2a 33       verllf  %v16,%v0,16
>   +   e7 00 00 10 2c 33       verllf  %v16,%v16,16
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Fixes: 22cb37b4172 ("tcg/s390x: Implement vector shift operations")
> Fixes: 79cada8693d ("tcg/s390x: Implement tcg_out_dup*_vec")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/s390x/tcg-target.c.inc | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
> index fbee43d3b0..7f6b84aa2c 100644
> --- a/tcg/s390x/tcg-target.c.inc
> +++ b/tcg/s390x/tcg-target.c.inc
> @@ -683,7 +683,7 @@ static void tcg_out_insn_VRIc(TCGContext *s, S390Opcode op,
>       tcg_debug_assert(is_vector_reg(v3));
>       tcg_out16(s, (op & 0xff00) | ((v1 & 0xf) << 4) | (v3 & 0xf));
>       tcg_out16(s, i2);
> -    tcg_out16(s, (op & 0x00ff) | RXB(v1, 0, v3, 0) | (m4 << 12));
> +    tcg_out16(s, (op & 0x00ff) | RXB(v1, v3, 0, 0) | (m4 << 12));
>   }
>   
>   static void tcg_out_insn_VRRa(TCGContext *s, S390Opcode op,
> @@ -738,7 +738,7 @@ static void tcg_out_insn_VRSa(TCGContext *s, S390Opcode op, TCGReg v1,
>       tcg_debug_assert(is_vector_reg(v3));
>       tcg_out16(s, (op & 0xff00) | ((v1 & 0xf) << 4) | (v3 & 0xf));
>       tcg_out16(s, b2 << 12 | d2);
> -    tcg_out16(s, (op & 0x00ff) | RXB(v1, 0, v3, 0) | (m4 << 12));
> +    tcg_out16(s, (op & 0x00ff) | RXB(v1, v3, 0, 0) | (m4 << 12));
>   }
>   
>   static void tcg_out_insn_VRSb(TCGContext *s, S390Opcode op, TCGReg v1,
> @@ -762,7 +762,7 @@ static void tcg_out_insn_VRSc(TCGContext *s, S390Opcode op, TCGReg r1,
>       tcg_debug_assert(is_vector_reg(v3));
>       tcg_out16(s, (op & 0xff00) | (r1 << 4) | (v3 & 0xf));
>       tcg_out16(s, b2 << 12 | d2);
> -    tcg_out16(s, (op & 0x00ff) | RXB(0, 0, v3, 0) | (m4 << 12));
> +    tcg_out16(s, (op & 0x00ff) | RXB(0, v3, 0, 0) | (m4 << 12));
>   }
>   
>   static void tcg_out_insn_VRX(TCGContext *s, S390Opcode op, TCGReg v1,

I double-checked the Principles of Operation that VRI-c, VRS-a and VRS-c are 
the only encodings where this could happen, and yes, your modification looks 
right to me:

Reviewed-by: Thomas Huth <thuth@redhat.com>

Do you want to take it through our TCG branch or shall I pick it up for my 
s390x branch?


