Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6496B705005
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 15:57:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyv9v-0007vy-Oj; Tue, 16 May 2023 09:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyv9u-0007vZ-3t
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:56:10 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyv9s-0005mv-Jm
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:56:09 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ae40dcdc18so3698115ad.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684245367; x=1686837367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3WEaHI/gSVlHRgjCVBRB8TQJX49+OkP7QQkY6jMPBx4=;
 b=UlcpUed+Wc4DDTNR0zURqrcjU5tVclkRE9ynsXPKgbI8AlVV2n3m1eWoCpIhkO5En1
 32QjoxRtGqJ9TUVKtYgkyaOk4WRYOGxMfYqnqC4ufF85UAqMkRtC5OQrgyTS6A53/5l1
 YS+yTugobTtFoD+2xRkXL4pfIKfpBIfTAltgf3FEfrw27rwF6XLtLLITJyp4g5d+O/Qf
 oJLpX5oQFumuMvpAS+KxO+kqBaDgAWc6rpk8u937oLkohKH01hF0QUQY1s3IE4xpcqJl
 FLtUY1FcL76nC+xSnn1lvU9g4toQgstNPB/gl8NLLcvflhBJM5Bo4F7S3oWpCxr48Ttt
 UbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684245367; x=1686837367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3WEaHI/gSVlHRgjCVBRB8TQJX49+OkP7QQkY6jMPBx4=;
 b=G4LY638jwV0ZrhSZphisTUnwoFCu4iY4tBQhztNhREtTGRE+P3awEJatVubpIK6HIS
 rzqoWWbjOg7MRVQL1hzzvwHIXoeZkz13uMRsUJBTZCzbVmwGlQk4eN1MsrZq47qpxAcD
 OsxF5tSYXcE2PJ1cmGC7UbYuLqLBGQ4E1OIJPO3vauMmqF1nXmhPxzcmHjLC9LLrZq+/
 OQ97YInf4OvqlcST4vNQcZzmGQ5ev1d5LLVvcBkdHlRLrLru256R4ytngESGkn1N2Bkd
 bHGJF1/Vd4yascdwyVcP6S6IfTrE4nnTXiERykVQqFsAJ7q7qPMjoglWoNKB+icVJGTT
 CurQ==
X-Gm-Message-State: AC+VfDwQhtniaSknUsrz9cOUJE7VZ9BebPOTBo935k0V0dwehi59JpOp
 PsfeJPyG4GuptHEhCuaNDOOQOA==
X-Google-Smtp-Source: ACHHUZ6DRhK69QyhU3BsfUsJW5y49kbd4pw0pQ1ZoOXU4P47n2oKGIu6Lu2sl2RnVhXTZIVkgdGMiw==
X-Received: by 2002:a17:903:2292:b0:1a2:3108:5cc9 with SMTP id
 b18-20020a170903229200b001a231085cc9mr50401700plh.40.1684245367236; 
 Tue, 16 May 2023 06:56:07 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:ec81:440e:33a4:40b9?
 ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a170902b60f00b001aafe232bcfsm15523274pls.44.2023.05.16.06.56.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 06:56:06 -0700 (PDT)
Message-ID: <847c896d-76cc-73c2-e147-da78c4a0b38b@linaro.org>
Date: Tue, 16 May 2023 06:56:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 36/54] tcg: Introduce tcg_out_movext3
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-37-richard.henderson@linaro.org>
 <CAFEAcA9QxgOuzhQn7=9rXcMTtFiyL2vXtUni0ypSzMy+a2BuzA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9QxgOuzhQn7=9rXcMTtFiyL2vXtUni0ypSzMy+a2BuzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.666,
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

On 5/16/23 03:03, Peter Maydell wrote:
> On Mon, 15 May 2023 at 15:43, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> With x86_64 as host, we do not have any temporaries with which to
>> resolve cycles, but we do have xchg.   As a side bonus, the set of
>> graphs that can be made with 3 nodes and all nodes conflicting is
>> small: two.  We can solve the cycle with a single temp.
>>
>> This is required for x86_64 to handle stores of i128: 1 address
>> register and 2 data registers.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> 
>>   static void tcg_out_helper_load_regs(TCGContext *s,
>>                                        unsigned nmov, TCGMovExtend *mov,
>> -                                     unsigned ntmp, const int *tmp)
>> +                                     const TCGLdstHelperParam *parm)
>>   {
>> +    TCGReg dst3;
>> +
>>       switch (nmov) {
>> -    default:
>> +    case 4:
>>           /* The backend must have provided enough temps for the worst case. */
>> -        tcg_debug_assert(ntmp + 1 >= nmov);
>> +        tcg_debug_assert(parm->ntmp >= 2);
>>
>> -        for (unsigned i = nmov - 1; i >= 2; --i) {
>> -            TCGReg dst = mov[i].dst;
>> -
>> -            for (unsigned j = 0; j < i; ++j) {
>> -                if (dst == mov[j].src) {
>> -                    /*
>> -                     * Conflict.
>> -                     * Copy the source to a temporary, recurse for the
>> -                     * remaining moves, perform the extension from our
>> -                     * scratch on the way out.
>> -                     */
>> -                    TCGReg scratch = tmp[--ntmp];
>> -                    tcg_out_mov(s, mov[i].src_type, scratch, mov[i].src);
>> -                    mov[i].src = scratch;
>> -
>> -                    tcg_out_helper_load_regs(s, i, mov, ntmp, tmp);
>> -                    tcg_out_movext1(s, &mov[i]);
>> -                    return;
>> -                }
>> +        dst3 = mov[3].dst;
>> +        for (unsigned j = 0; j < 3; ++j) {
>> +            if (dst3 == mov[j].src) {
>> +                /*
>> +                 * Conflict. Copy the source to a temporary, perform the
>> +                 * remaining moves, then the extension from our scratch
>> +                 * on the way out.
>> +                 */
>> +                TCGReg scratch = parm->tmp[1];
>> +                tcg_out_movext3(s, mov, mov + 1, mov + 2, parm->tmp[0]);
>> +                tcg_out_movext1_new_src(s, &mov[3], scratch);
> 
> Isn't this missing the "copy the source to a temporary" part?
> I was expecting an initial tcg_out_mov() like the old code has.

It is.  Sloppy of me, and I haven't re-tested ppc32 this week.


r~

