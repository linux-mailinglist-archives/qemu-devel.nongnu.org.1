Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFD47E91BA
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 17:57:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Dla-0006aK-HL; Sun, 12 Nov 2023 11:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2DlX-0006a4-AS
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 11:56:55 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2DlV-0001yT-KF
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 11:56:55 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-27ff7fe7fbcso3263801a91.1
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 08:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699808212; x=1700413012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/M3vlIiRCfy1X+WNgegJnKj0hvaZ9nQNwOF3IrsNwjg=;
 b=WUzC1CtDazkyFdM36QR6eWZgj/UAVLA02fmHQ2eyHfCeywOjmV2Hcw/9ReG/mIlUaY
 RLRrNKT9b+OvPfjvBx+pNi74gxIg53oZxQ73ZBa8SNHp6uWOrinYuJ5bH3I9WxIn4HPZ
 H5EW1VR1Y/oH2xnpgTSW+Z5aCw9Ppjjnr0H5i2VAmjlYm/dSd0W9gDQkCwL1y/Xb9ks4
 oN3Oe/nZp7IgzAUyA1EMlPitgWfsYNlMf/Us5IucTfbpqPR/NEx+dxZi3QAJ+c9gQLBh
 E+guPfEBU+ctno9oR918ae66JoYG5OYMburrvG1PnD9uyuelmTeTr7ubPguCVD0MQQF3
 vkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699808212; x=1700413012;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/M3vlIiRCfy1X+WNgegJnKj0hvaZ9nQNwOF3IrsNwjg=;
 b=WCBXPoIp1eCkM1C6v02pf2NWdL5uRAB0zQX0/ppc6CKrwrx1MPAWojKjGGUM2rZ7c3
 Pv/272bjd8Esoh06WNlZftG86dTvmEhwnG4/feBAhPgDgBURXkwgLB0/d3CN8Dh7BsIA
 B1xJeL9jin8QRYXzf0Iw7uAFf8x/MK8n11+N4RRr9LH9rxW8fNzPuR30+tkBMzESBheG
 pIqy+9+y1ihB/398rIdlU9OyBKyoB9MkeIzTzCxue60H/AarMBckgdOBEYhomeR25ktY
 2SfonOEXxy1WPs864V5y4KroRVPakE6IsbcCodrqdMAAVvB3ncplh/SH29k0fbKSrXHy
 mExg==
X-Gm-Message-State: AOJu0YynHgJ/WDvGYrNXwWNQYc9Au8FuX44FCUwI82BOt7w4kC3Nxwen
 NfeX0DcGkxfKqEyebaiGZq8iPA==
X-Google-Smtp-Source: AGHT+IGuCTIpquEtzYU4ehs9qsyhBS70UM+a5U5H52wF4+DmS4w3NZdvdZEFKcujWoYoERPuLOrffw==
X-Received: by 2002:a17:90a:34b:b0:27d:880d:8645 with SMTP id
 11-20020a17090a034b00b0027d880d8645mr3515132pjf.49.1699808212101; 
 Sun, 12 Nov 2023 08:56:52 -0800 (PST)
Received: from [192.168.114.227] (c-24-20-177-206.hsd1.or.comcast.net.
 [24.20.177.206]) by smtp.gmail.com with ESMTPSA id
 20-20020a17090a199400b0028028560c4bsm4954260pji.57.2023.11.12.08.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Nov 2023 08:56:51 -0800 (PST)
Message-ID: <670db88c-20ad-4e59-95dd-6e8d9c0bfdef@linaro.org>
Date: Sun, 12 Nov 2023 08:56:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 John Platts <john_platts@hotmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "danielhb413@gmail.com" <danielhb413@gmail.com>
References: <SN6PR05MB5837524077F6C8A2A482B41A9DAEA@SN6PR05MB5837.namprd05.prod.outlook.com>
 <f25aa178-450f-4a62-9b7d-50fcbc7e195a@kaod.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f25aa178-450f-4a62-9b7d-50fcbc7e195a@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 11/11/23 09:36, Cédric Le Goater wrote:
> Adding Richard,
> 
> Thanks,
> 
> C.
> 
> 
> On 11/10/23 19:41, John Platts wrote:
>> The patch below fixes a bug in the VSX_CVT_FP_TO_INT and VSX_CVT_FP_TO_INT2
>> macros in target/ppc/fpu_helper.c where a non-NaN floating point value from the
>> source vector is incorrectly converted to 0, 0x80000000, or 0x8000000000000000
>> instead of the expected value if a preceding source floating point value from
>> the same source vector was a NaN.
>>
>> The bug in the VSX_CVT_FP_TO_INT and VSX_CVT_FP_TO_INT2 macros in
>> target/ppc/fpu_helper.c was introduced with commit c3f24257e3c0.
>>
>> This patch also adds a new vsx_f2i_nan test in tests/tcg/ppc64 that checks that
>> the VSX xvcvspsxws, xvcvspuxws, xvcvspsxds, xvcvspuxds, xvcvdpsxws, xvcvdpuxws,
>> xvcvdpsxds, and xvcvdpuxds instructions correctly convert non-NaN floating point
>> values to integer values if the source vector contains NaN floating point values.
>>
>> Fixes: c3f24257e3c0 ("target/ppc: Clear fpstatus flags on helpers missing it")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1941
>> Signed-off-by: John Platts <john_platts@hotmail.com>
>> ---
>>   target/ppc/fpu_helper.c         |  12 +-
>>   tests/tcg/ppc64/Makefile.target |   5 +
>>   tests/tcg/ppc64/vsx_f2i_nan.c   | 300 ++++++++++++++++++++++++++++++++
>>   3 files changed, 313 insertions(+), 4 deletions(-)
>>   create mode 100644 tests/tcg/ppc64/vsx_f2i_nan.c
>>
>> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
>> index 03150a0f10..4b3dcad5d1 100644
>> --- a/target/ppc/fpu_helper.c
>> +++ b/target/ppc/fpu_helper.c
>> @@ -2880,20 +2880,22 @@ uint64_t helper_XSCVSPDPN(uint64_t xb)
>>   #define VSX_CVT_FP_TO_INT(op, nels, stp, ttp, sfld, tfld, sfi, rnan)         \
>>   void helper_##op(CPUPPCState *env, ppc_vsr_t *xt, ppc_vsr_t *xb)             \
>>   {                                                                            \
>> +    int all_flags = 0;                                                       \
>>       ppc_vsr_t t = { };                                                       \
>>       int i, flags;                                                            \
>>                                                                                \
>> -    helper_reset_fpstatus(env);                                              \
>> -                                                                             \
>>       for (i = 0; i < nels; i++) {                                             \
>> +        helper_reset_fpstatus(env);                                          \
>>           t.tfld = stp##_to_##ttp##_round_to_zero(xb->sfld, &env->fp_status);  \
>>           flags = env->fp_status.float_exception_flags;                        \
>> +        all_flags |= flags;                                                  \
>>           if (unlikely(flags & float_flag_invalid)) {                          \
>>               t.tfld = float_invalid_cvt(env, flags, t.tfld, rnan, 0, GETPC());\
>>           }                                                                    \
>>       }                                                                        \
>>                                                                                \
>>       *xt = t;                                                                 \
>> +    env->fp_status.float_exception_flags = all_flags;                        \
>>       do_float_check_status(env, sfi, GETPC());    


Looks reasonable.  Each lane wants to check for snan, and it needs a clean set of flags to 
do that.  Merge all lane flags to pass to do_float_check_status.  So,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

