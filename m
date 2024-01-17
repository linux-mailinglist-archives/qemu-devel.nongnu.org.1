Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D97C0830771
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:01:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6Sz-0003C6-56; Wed, 17 Jan 2024 09:00:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ6Su-0003BQ-7W
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:00:24 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ6Ss-0000VR-4Y
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:00:23 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e8ddebc71so576515e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 06:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705500020; x=1706104820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ON98tfpetkZfObkwgLWjrbyDFIRO2MFUFGKc0NChSyg=;
 b=nj+sA7gqBnidBMlVO4dAz0kr62TeYGbzn7alL5eD8H6f8h5SxWsFU8eV0zwP5DIKbD
 4HG9HmfNvqJeSEHeAICwYwZY0V05PF19tEHmyxE9OblrTDTJmatHBIkBX+U2B+MvYzvU
 OxFep+vREOlgAoPgZtwnkI9wydbPWZAz85xwEK4L2z2f+oDzA+uc7ph89bSC15CwiWZw
 d7STypprM1HsvMfH7xTuLtcF2NQXF7TNF9XPOIUv5SLQ4Z6Q+82sS4uzb3TCFIanPd4N
 4STIWXD81nqH3Z/vgKf9M51Ph+9KjnB3Of2A4esVO3iRPwKdhxre26HPvvP1s/6fZMK0
 UAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705500020; x=1706104820;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ON98tfpetkZfObkwgLWjrbyDFIRO2MFUFGKc0NChSyg=;
 b=SogxD/4RsZk7+HN0qBFTUk4QwOkKQaaGBq6Sd+Grx7PyamQuk+E5oJ51Zqw52vTF8t
 M9Iy0EHxL9twf6S2Ks34FM7MtTy8LumFhpaFRxFd0Krlgvf5ghYMvay3h43ZvCCI1HgJ
 nbQgm/CAOvzxeIRP6YhlTJcQhdfrTofyQhOiA/DhnZJ3AnvufRPLBjjqStKoalD6EAVP
 dzdVGABSEuY4jV8CrLWgU40zLImV34NWzMnZIYH3VwVTUeK3gzQeuWyWzMBIs6j3qpEy
 CU+RM7BBM1vjy/bNr+Am62iBXqbbB074uaeSChRotvk1x893MEkZf6v1UwPkTXtuFEz5
 HtLw==
X-Gm-Message-State: AOJu0YxT3vw3FkCKMi9QJ7NAsBmrmgTl6vRU9M3pEx9d2FTXCNlat3RV
 YsZO9igfF4v+ooYgGrVbJ2WPNXgl/Wkqrg==
X-Google-Smtp-Source: AGHT+IEdF9O3xDCUksSIG7VyO5lI0ojNjaCq01pnCTyPVYCYHrTTD/XSpcsplbBo9nyVus32VCmktA==
X-Received: by 2002:a05:600c:3510:b0:40e:4833:8141 with SMTP id
 h16-20020a05600c351000b0040e48338141mr5303772wmq.4.1705500020263; 
 Wed, 17 Jan 2024 06:00:20 -0800 (PST)
Received: from [192.168.69.100] ([176.187.212.26])
 by smtp.gmail.com with ESMTPSA id
 bi13-20020a05600c3d8d00b0040e8800fcf3sm2806132wmb.5.2024.01.17.06.00.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 06:00:19 -0800 (PST)
Message-ID: <ba353717-5654-4291-a022-beafa6ad456c@linaro.org>
Date: Wed, 17 Jan 2024 15:00:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: chacha20-s390 broken in 8.2.0 in TCG on s390x
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>
References: <d5e8f88b-1d19-4e00-8dc2-b20e0cd34931@tls.msk.ru>
 <dfc5987a-4210-4579-b9a3-1cc12fe1b909@linaro.org>
 <cc4ad254-b177-4a09-96f7-448c638ae67e@tls.msk.ru>
 <f07dfa5c-9f3c-4e22-9514-81c130b6a9ab@linaro.org>
 <764215cd-6f62-4746-b1f5-6174a158f95d@linaro.org>
 <e1f48ff4-d640-4500-9f2b-6b9db0d8ffe3@linaro.org>
 <5c3098cc-3a2f-4272-b06a-6d12d645d628@linaro.org>
 <feb272b1-4729-4acf-8feb-5aed993a5a06@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <feb272b1-4729-4acf-8feb-5aed993a5a06@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 17/1/24 12:53, Michael Tokarev wrote:
> 04.01.2024 01:51, Richard Henderson :
>> On 1/4/24 01:37, Philippe Mathieu-Daudé wrote:
>>> Finally changing the constraints on op_rotli_vec seems to fix it:
>>>
>>> ---
>>> diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
>>> index fbee43d3b0..b3456fe857 100644
>>> --- a/tcg/s390x/tcg-target.c.inc
>>> +++ b/tcg/s390x/tcg-target.c.inc
>>> @@ -3264,13 +3264,13 @@ static TCGConstraintSetIndex 
>>> tcg_target_op_def(TCGOpcode op)
>>>       case INDEX_op_ld_vec:
>>>       case INDEX_op_dupm_vec:
>>> +    case INDEX_op_rotli_vec:
>>>           return C_O1_I1(v, r);
>>>       case INDEX_op_dup_vec:
>>>           return C_O1_I1(v, vr);
>>>       case INDEX_op_abs_vec:
>>>       case INDEX_op_neg_vec:
>>>       case INDEX_op_not_vec:
>>> -    case INDEX_op_rotli_vec:
>>>       case INDEX_op_sari_vec:
>>>       case INDEX_op_shli_vec:
>>>       case INDEX_op_shri_vec:
>>>       case INDEX_op_s390_vuph_vec:
>>>       case INDEX_op_s390_vupl_vec:
>>>           return C_O1_I1(v, v);
>>
>> Definitely not correct, since VERLL requires a vector input to be 
>> rotated.
>>
>>> But I'm outside of my comfort zone so not really sure what I'm doing...
>>> (I was inspired by the "the instruction verll only allows immediates up
>>> to 32 bits." comment from
>>> https://www.mail-archive.com/gcc-patches@gcc.gnu.org/msg317099.html)
>>
>> That message is confused.  The immediate in VERLL is 12 bits (with 
>> only 6 bits ever used for MO_64).  Dunno where "32 bits" comes from.
> 
> So, what do we have here in the end?
> Should we fix this on qemu side?

Yes.

> This thread stopped quite some time ago, with problematic
> instruction found but no solution..

Be assured we are spending (too?) many hours on this...

