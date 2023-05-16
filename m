Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2564F7051B1
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 17:09:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pywIQ-0003db-7q; Tue, 16 May 2023 11:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1pywIN-0003ck-Vk
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:09:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1pywIH-0003Ah-Bz
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:08:59 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f435658d23so78847505e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684249732; x=1686841732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=67Br9d/1An09GEndRs9p42NHKAUJOjrjPs+uoq8rSpA=;
 b=O+/6jO/fGrcyKD6pB4bAo9fmk0VxIiBc8YVYVrddDaxn5vTMwnSt9FYh4bquAHt26b
 cg4qQ9NmiWJvoRCDVIDWT5nvm2aOqZeWkrHZDc6Yh+vW207SmG947y+SuWPQn+6yW4OA
 h/ml7vboawCf2CgsUQ/MenHfnxidMST8B5D9GM4ytRYRDkAK2WmcYHK/CZUmCtzGO2DY
 u1MbccApP2ivXmCDRps9nryrSgDQJedNhFksMkcGXZyhWpoFiXpKtjEasQwDNSXpcCpc
 bw8HwydyBOSQFnvQgCuh06SATLgBjpMOCCaGfWtQuSE3IjOFvA/V4zIIG9IU6RD4mhKD
 m1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684249732; x=1686841732;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=67Br9d/1An09GEndRs9p42NHKAUJOjrjPs+uoq8rSpA=;
 b=SQ6TMCRltLUQ9cLVBGhof4xIZvVHDqIe8ltV57hX+hsUZJQ9cpJrcXWg8CKu7NrgAK
 T/9wh127HnamhnxFdUklTNym16JtJOfaZM28QlA/j11BcXJjcfykTKqkHS1zmvEqCXXl
 5WXISrLolc2/aPHpbh26umxtY2Dd2F3/3LxVbqEA5yV0VdA3xhhOmmaMBPe1es11MfEi
 RYu8nVaK4moP3ApDLRKJ4Aiw23YjH7sKDPLzcIbB9VxKwWZTyGUUQxTaU8+FKS4pgrbj
 bpmHMcTgHZdLQTtQyZnaw/+dsvwKPdTSbrFhJiuZ0G/+O+HXM7iAZpsxptiW1+SAIKdy
 b+/A==
X-Gm-Message-State: AC+VfDwEjmAEL5yl5DqFXOlgzpqyO1gd+17skZTLb7pafbzUR85kDcVu
 aOcIOySG+fIm+KMvs8SbnmgoYg==
X-Google-Smtp-Source: ACHHUZ6Rv3PopI/RHFWnGHDgwXjiNMk39whFlXBPsXUJ6/7oTNo6ffOz2Jw4vGc8CGq7SORqd8ppPg==
X-Received: by 2002:a5d:5960:0:b0:309:839:be3e with SMTP id
 e32-20020a5d5960000000b003090839be3emr8163274wri.33.1684249731872; 
 Tue, 16 May 2023 08:08:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.175.66])
 by smtp.gmail.com with ESMTPSA id
 d4-20020adffd84000000b003062b6a522bsm2839016wrr.96.2023.05.16.08.08.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 08:08:51 -0700 (PDT)
Message-ID: <7b587b78-c37c-cc3c-bf49-a68d56f45347@linaro.org>
Date: Tue, 16 May 2023 17:08:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] Revert "hw/sparc64/niagara: Use blk_name() instead of
 open-coding it"
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, atar4qemu@gmail.com, =?UTF-8?Q?Jakub_Jerm=c3=a1?=
 =?UTF-8?B?xZk=?= <jakub@jermar.eu>, qemu-stable@nongnu.org
References: <20230515151104.1350155-1-armbru@redhat.com>
 <3334226e-f96e-5f17-2b67-f29bb9f0256a@ilande.co.uk>
 <87ilcsvh17.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <87ilcsvh17.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 16/5/23 10:04, Markus Armbruster wrote:
> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
> 
>> On 15/05/2023 16:11, Markus Armbruster wrote:
>>
>>> This reverts commit 1881f336a33a8a99cb17ab1c57ed953682e8e107.
>>> This commit breaks "-drive if=pflash,readonly=on,file=image.iso".  It
>>> claims to merely replace an open-coded version of blk_name() by a
>>> call, but that's not the case.  Sorry for the inconvenience!
>>
>> Ah so was this a case of replacing something that shouldn't have been replaced in the first place, or does it require a follow-up patch?
> 
> I was looking at inclusions of block/block_int*.h outside the block
> subsystem, and went "Oh, I can get rid of this one!"  Nope, brain
> malfunction.

x2, sorry :/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Reducing such inclusions is always nice, but the code this patch
> restores isn't broken, and no follow-up fix is required.
> 
>>> Reported-by: Jakub Jermář <jakub@jermar.eu>
>>> Cc: qemu-stable@nongnu.org
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> 
> [...]
> 
>> Regardless of the above:
>>
>> Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Thanks!
> 
> 


