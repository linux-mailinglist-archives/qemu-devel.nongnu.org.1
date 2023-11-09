Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D7A7E6560
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 09:36:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r10VP-0006WK-VI; Thu, 09 Nov 2023 03:35:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r10VM-0006W8-Uo
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 03:35:12 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r10VK-00025y-5M
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 03:35:12 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507ad511315so842683e87.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 00:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699518908; x=1700123708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0LxvugNXwkUpAUDZPlbvl2A6/oB62IkdOSEbKPmdUK0=;
 b=w0kq+IvOIbKcEu+chIC+o+U0g6cqIEmlF7OcNQEAf3mo/BiIx38rgfEdF2ZWnKIbfA
 6oU2VltKggtiSvqK3rADwrncmtvU4Jyz8Dr3IzyUxOLdjrJF3/IUbixKSgWSiPsHvP9n
 TMfyehlC2WRUGLHZBG9hbvHpbYiMBCdxeVaF3GU8uSq9CRmYMB6jDlVsPL4uXgPP/R8n
 8P+VrIbHiLjK8M1VmwUJQUgluL5qMXIY55VVLVdmVtOpG9iXGLKFl3A0GJNyN9h5GJUQ
 yMEkdnxxIcSQkIpZDYtDSW9hDT87iiGsB0YDn7rVsLwJ5d/+kGlppVi0lPnO0xpuHrOu
 pgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699518908; x=1700123708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0LxvugNXwkUpAUDZPlbvl2A6/oB62IkdOSEbKPmdUK0=;
 b=Exqxjeu7l9F6VkbxYW/J/YYjCkTdzenxqxXomqDG8ofN3RomJBINYFGImWUBPWcbPZ
 1ABgQQHoTVxl/IKthCtaP91rZ3FvmNS69v4YR3Y97FnxrIqdw3/h6UPIvY1H9t5h8pFq
 ZjRPmK6z1JR/aobXokc49XP0Khs/Wtm4B+r+ZV6Csi/XjzX4+P4uo6lqhX9s2Hl+my8+
 gIaDdRhCQfDouK74Wv7UTzTkX5//YMynzrgNi3udE5CPH+YAgnF/8e6+HvoyJyPAkMs9
 FXl9IJ6wb4xsNmp2Yd8JDTv7iAxlx64kJKsubccYcrJ6EYA2MPl3V6e22HuSPshebLrM
 kb7Q==
X-Gm-Message-State: AOJu0YzNKLny8eq9rC5noMUBqZuMkPenbutZsHhhPiZ42tGmfLsxai+W
 prLzXdR7JuLlheo8a505MidPEQ==
X-Google-Smtp-Source: AGHT+IFb1AqnGxmBHi+4CBFFse/iEjZqIn7Z9lzcyoNVcW+9iYEg9qUkYlr8Ygy3zojhhxEYLX8eSA==
X-Received: by 2002:a05:651c:19ab:b0:2b6:fa3f:9230 with SMTP id
 bx43-20020a05651c19ab00b002b6fa3f9230mr4421866ljb.46.1699518908235; 
 Thu, 09 Nov 2023 00:35:08 -0800 (PST)
Received: from [192.168.23.175] (226.red-88-28-2.dynamicip.rima-tde.net.
 [88.28.2.226]) by smtp.gmail.com with ESMTPSA id
 fl14-20020a05600c0b8e00b004094d4292aesm1368255wmb.18.2023.11.09.00.35.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 00:35:07 -0800 (PST)
Message-ID: <e3c33151-f0f7-4929-b93c-960428f55894@linaro.org>
Date: Thu, 9 Nov 2023 09:35:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/35] tcg/sparc64: Hoist read of tcg_cond_to_rcond
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-21-richard.henderson@linaro.org>
 <d5e502b0-2175-4c66-87f6-1e581b4612fb@linaro.org>
 <88ca96c2-36d0-4183-b17a-c472b167d74a@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <88ca96c2-36d0-4183-b17a-c472b167d74a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
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

On 8/11/23 21:57, Richard Henderson wrote:
> On 11/6/23 13:02, Philippe Mathieu-Daudé wrote:
>> On 28/10/23 21:45, Richard Henderson wrote:
>>> Use a non-zero value here (an illegal encoding) as a better
>>> condition than is_unsigned_cond for when MOVR/BPR is usable.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   tcg/sparc64/tcg-target.c.inc | 25 ++++++++++++++-----------
>>>   1 file changed, 14 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
>>> index ac86b92b75..e16b25e309 100644
>>> --- a/tcg/sparc64/tcg-target.c.inc
>>> +++ b/tcg/sparc64/tcg-target.c.inc
>>> @@ -620,7 +620,7 @@ static const uint8_t tcg_cond_to_bcond[] = {
>>>       [TCG_COND_GTU] = COND_GU,
>>>   };
>>> -static const uint8_t tcg_cond_to_rcond[] = {
>>> +static const uint8_t tcg_cond_to_rcond[16] = {
>>
>>
>>> -static void tcg_out_movr(TCGContext *s, TCGCond cond, TCGReg ret, 
>>> TCGReg c1,
>>> +static void tcg_out_movr(TCGContext *s, int rcond, TCGReg ret, 
>>> TCGReg c1,
>>
>> Isn't rcond unsigned?
> 
> Yes, though it is in [0-7], so it doesn't matter.

Maybe using 'uint8_t' would be clearer. Just suggesting, not a blocker.


