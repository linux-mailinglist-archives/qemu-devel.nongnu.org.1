Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E42997842CC
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 16:03:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYRxa-0006BY-VV; Tue, 22 Aug 2023 10:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYRxX-0006AU-Nh
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:02:15 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYRxU-0002pc-IV
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:02:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fee51329feso19095415e9.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692712930; x=1693317730;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pmrh/JYby1gOJhbqUseCVLB+diM8gTd+bJFNxULNKno=;
 b=qYCCeMtV4DdSfADYrTgJih+l9LbwFtnimAaCWUSfgDXtNXSSckvsHlq/Hq+T2vzxat
 1l2ShQNBzSoxc7xRmzjwCyiUQxtdl7i8bSq7kIvcWN8lvvDJlWedmzCV4aLqgezENt+R
 TlfHR72++OLmJ6DMhEj7d51QInIbP0820Y0xC0e060rXIH+gRkNkm40hhJwx5Ha2z6GM
 NdAM+hSGxHtORD9z3rCgn+zF7wLD4sZzoLXek3R9/bZPMVobjMVRY2BX9V0FlHSVyNi5
 i5MnDX6GYTYNljD2wlggCmQB8NRg/k/3IK7kBPlx74D8liz56O5UzccUpCxsSvGMLY/4
 giJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692712930; x=1693317730;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pmrh/JYby1gOJhbqUseCVLB+diM8gTd+bJFNxULNKno=;
 b=lBx6hYh+8FTJ0rs56SlL2wPsNiezOabNPNFe3Y5vPyncHoLXrLj7JouW55T1YkDgNQ
 zNNBVVrB8jeJSmeaJAFsiodzN7O3m9dkH712r90Rg+sk+hAJk5jwdYEju+rnHdN+DgLF
 QB+vBhGCjDaSXPVvyu2NEufw6j36MPfns3wYSLgo3MEhPz1h3rt1tOfbBCc+u25FUwRL
 /I0OkEf9c02v4J2+3rCuO16j34kUOMdJasBmY2MfxWDoeFnZag6DOze4542JU1xSHB06
 krEJn+uQDJF7y9AOz5eVjzsXyr8RNxw94GXB9XzCdhcTq4fpIotiX/iTdrVVQsGQB+J8
 pOLQ==
X-Gm-Message-State: AOJu0YzcX/BwdPS1X/Rh7J81ZfKN+6D2kD+dbhoJC1BpNgx770QE2BSB
 9qGhRCFcXE+h/V1sb/7eSmjrh0zntTAE15cX9JYmvw==
X-Google-Smtp-Source: AGHT+IHEBDerflUxZLEJYMfWVc3DTsATG/jcvqnAZKucrSCmDMM7zMtG4ZIqM3hvWqMBRFnrQsO+nA==
X-Received: by 2002:a05:600c:1da1:b0:3fe:3389:122f with SMTP id
 p33-20020a05600c1da100b003fe3389122fmr7022527wms.1.1692712930322; 
 Tue, 22 Aug 2023 07:02:10 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 a19-20020a05600c225300b003fee83ae4a3sm10512101wmm.9.2023.08.22.07.02.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 07:02:09 -0700 (PDT)
Message-ID: <bbdf0c7b-8cf2-872a-88bb-26117753e41a@linaro.org>
Date: Tue, 22 Aug 2023 16:02:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 08/12] target/loongarch: Use generic hrev64_i64() in
 REVB.4H opcode
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Greg Kurz
 <groug@kaod.org>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org
References: <20230822124042.54739-1-philmd@linaro.org>
 <20230822125122.54991-1-philmd@linaro.org>
 <8d7b2863-c5e1-4222-3011-1d58157b62a8@linaro.org>
In-Reply-To: <8d7b2863-c5e1-4222-3011-1d58157b62a8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 22/8/23 15:28, Philippe Mathieu-Daudé wrote:
> On 22/8/23 14:51, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/loongarch/insn_trans/trans_bit.c.inc | 15 +--------------
>>   1 file changed, 1 insertion(+), 14 deletions(-)
>>
>> diff --git a/target/loongarch/insn_trans/trans_bit.c.inc 
>> b/target/loongarch/insn_trans/trans_bit.c.inc
>> index 95b4ee5bc8..c04806dc21 100644
>> --- a/target/loongarch/insn_trans/trans_bit.c.inc
>> +++ b/target/loongarch/insn_trans/trans_bit.c.inc
>> @@ -124,19 +124,6 @@ static void gen_revb_2h(TCGv dest, TCGv src1)
>>       tcg_gen_or_tl(dest, t0, t1);
>>   }
>> -static void gen_revb_4h(TCGv dest, TCGv src1)
>> -{
>> -    TCGv mask = tcg_constant_tl(0x00FF00FF00FF00FFULL);
>> -    TCGv t0 = tcg_temp_new();
>> -    TCGv t1 = tcg_temp_new();
>> -
>> -    tcg_gen_shri_tl(t0, src1, 8);
>> -    tcg_gen_and_tl(t0, t0, mask);
>> -    tcg_gen_and_tl(t1, src1, mask);
>> -    tcg_gen_shli_tl(t1, t1, 8);
>> -    tcg_gen_or_tl(dest, t0, t1);
>> -}
>> -
>>   static void gen_revh_2w(TCGv dest, TCGv src1)
>>   {
>>       TCGv_i64 t0 = tcg_temp_new_i64();
>> @@ -175,7 +162,7 @@ TRANS(clz_d, gen_rr, EXT_NONE, EXT_NONE, gen_clz_d)
>>   TRANS(cto_d, gen_rr, EXT_NONE, EXT_NONE, gen_cto_d)
>>   TRANS(ctz_d, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_d)
>>   TRANS(revb_2h, gen_rr, EXT_NONE, EXT_SIGN, gen_revb_2h)
>> -TRANS(revb_4h, gen_rr, EXT_NONE, EXT_NONE, gen_revb_4h)
>> +TRANS(revb_4h, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_hrev64_i64)
> 
> We should use tcg_gen_hrev64_tl() instead.

Although due to the 0x00FF00FF00FF00FFULL constant it
seems gen_revb_4h() really expects i64 registers...
(see gen_revh_2w which uses TCGv_i64).

I suppose gen_revb_4h() ended that way as a copy/paste of
gen_revb_2h().

