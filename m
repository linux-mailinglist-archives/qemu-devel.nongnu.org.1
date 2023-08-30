Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 547AB78E10D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 22:57:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbSF0-0001cx-Oc; Wed, 30 Aug 2023 16:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbSEy-0001ci-PB
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:56:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbSEw-0004uZ-I2
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:56:40 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31c73c21113so920f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 13:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693428997; x=1694033797; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LsBcVBKSv9L2Rp8wcKP+/jdiVgo0kK2sENAmHDNXepk=;
 b=Ov6k9zlebhM7+rjFxk7VvDu0mpx18YEXNg3XrQAnqFWxfkRMO9Zxi6unA6ajDBccqP
 F8TwbojXCiU3JiuBnZhfUZv90mYvXPxl1jTDETVan18eQ9GvDgSPNRChQgRL4oEc0Epq
 zbay9+96GmY25YiW97JxmSH88xcy0EGGMvE/l643Qcoktz5tW37DHiaO8/7y0M1+zm7l
 PAyHwLWepyVE7zixWjMZJvvRyZoVfz/ADDSr3ZRxdNwXBbyoSkERCGn2Nbt5ZH5chZLy
 3b95RTP1Bm/cqG0XdPQ+/dKLiIYQ2p85Hp5Q/vrpyon0Yuze+CvLWwR2derHOOyjyDZH
 bAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693428997; x=1694033797;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LsBcVBKSv9L2Rp8wcKP+/jdiVgo0kK2sENAmHDNXepk=;
 b=QJ23ZxmSaSjJKK6G3aJVfAApbjsJxMLfT5A2Q0h56ByAOt65oCUq4HxJ8vUejCoShC
 OETxD0HoQOUewD24NOpPHKYUe+yrg5fAbtslgePdI5kFMuVcR/+VSenmAkq+pm/70OFk
 NioaV+VcVXWNb0e82qFsDjJ36HCH+kROdvLwAOwR95jQkuzHoGKMvdhHbXM4XXWMHnkW
 bdXV5llf2vqppH5RlipFWj+oPGLKxS27hiRxEBS3TCs7UdAXOz42vZEcQle6d/8S+45c
 xEYvFzY5R0vQ5fwFkVuBfloQxTHYb5nTEK12F2WXlARMqx+sm7phaus8ccOjjQnxyu5J
 Lg6Q==
X-Gm-Message-State: AOJu0YyxF4Dr33RrmOqDaABScHbE4Y9FLGTsfyqpa4qyCRCcNRDC6VR+
 sHLDL0d5kjV3KeV9nlD1I1vDKQ==
X-Google-Smtp-Source: AGHT+IGVNlpB66w2gS90t0V26rhYpRAiBx7TmpJOEFD8/TD1HZQyaG4uzkjdC7Mxmfsg5w4Pb93c3Q==
X-Received: by 2002:a05:6000:1101:b0:31c:e933:9593 with SMTP id
 z1-20020a056000110100b0031ce9339593mr2673146wrw.6.1693428997102; 
 Wed, 30 Aug 2023 13:56:37 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a1c7907000000b003fed8e12d62sm85517wme.27.2023.08.30.13.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 13:56:36 -0700 (PDT)
Message-ID: <e299f256-9af8-a63e-2107-f6566c623f75@linaro.org>
Date: Wed, 30 Aug 2023 22:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v5 08/20] linux-user: Load vdso image if available
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <20230829220228.928506-9-richard.henderson@linaro.org>
 <d703be2d-8131-58d4-2ed8-7104316a8e21@linaro.org>
 <e5685d29-bb2a-f0c2-5030-453dae529c03@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <e5685d29-bb2a-f0c2-5030-453dae529c03@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 30/8/23 18:17, Richard Henderson wrote:
> On 8/30/23 07:22, Philippe Mathieu-Daudé wrote:
>> Hi Richard,
>>
>> On 30/8/23 00:02, Richard Henderson wrote:
>>> The vdso image will be pre-processed into a C data array, with
>>> a simple list of relocations to perform, and identifying the
>>> location of signal trampolines.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   linux-user/elfload.c | 87 +++++++++++++++++++++++++++++++++++++++-----
>>>   1 file changed, 78 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>>> index f34fb64c0c..2a6adebb4a 100644
>>> --- a/linux-user/elfload.c
>>> +++ b/linux-user/elfload.c
>>> @@ -33,6 +33,19 @@
>>>   #undef ELF_ARCH
>>>   #endif
>>> +#ifndef TARGET_ARCH_HAS_SIGTRAMP_PAGE
>>> +#define TARGET_ARCH_HAS_SIGTRAMP_PAGE 0
>>
>> I'd rather #error here so new targets are added with
>> a clearly defined TARGET_ARCH_HAS_SIGTRAMP_PAGE.
> 
> The next step after adding vdso's is to remove 
> TARGET_ARCH_HAS_SIGTRAMP_PAGE.

Ah great.

>>> +    for (unsigned i = 0, n = vdso->reloc_count; i < n; i++) {
>>
>> Do we really need 'n'?
> 
> You should always have an loop invariant condition if possible.

vdso->reloc_count doesn't seem updated, but I get your point.


