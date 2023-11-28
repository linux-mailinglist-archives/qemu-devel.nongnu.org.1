Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 763F27FBB86
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 14:27:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7y6P-0007KA-M2; Tue, 28 Nov 2023 08:26:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7y6N-0007Iv-9N
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:26:11 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7y6L-0005HB-J5
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:26:11 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40b474c925bso12966425e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 05:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701177968; x=1701782768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7tzOBVS6gtiBUB+4PJSR3PCZgwxh4HMdBgzKXdr2vbk=;
 b=ToELTGBtLH/z7NpOg5m0UgQVDoc9um6/OlBf5cQBg3Orp7ryYSDu79xKAYPqQxy3oj
 HxEMQCe5mz3dWK6l38Ab3jPX9Tm4lTWZ2BC3md0gQ4AzAW0JNQq+KefaS295Qj33jKRA
 Id3J8zh/tIylP55T9ZKnFQy+6XA3xagFTeMdHGDucOuYi8zq7oY+MHIh+SNWrI/a/WoA
 Z2fw55Rnjs/v1cMyJpXYbkW1hrh1LqybY+fzdRQm4on7NdO7zVtmhZjxYGphwgljQEV2
 mWAZ8ROcvrW2Fljs388WYM1087eAgXafc07/GsOZ/GSM+JyBN5YSW//v3Gdy6HpQsWOz
 Hb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701177968; x=1701782768;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7tzOBVS6gtiBUB+4PJSR3PCZgwxh4HMdBgzKXdr2vbk=;
 b=Ur6v6cG9qBQDDlkwjs7iuzNAA8xtRz4mSxwYxgocirO1+o7QAe0Fwhfad8XgYJdeAo
 oMZztJUzuu+BWPRqhHaTt/BRzrFQwIFfh57wYKRWHd/Zix1qtrojwmMNmtLtLzGSBSKC
 Z0xANiZLQFzIRVVBYXFH1wt1x8qFn/Wv+kat538mNNoAmG+rXSIwp+cnI0PfUEbzFnIj
 X+uwBZm1Ftc/n4ZH3x0mvOe8s5NEDE6YsubUijYib0hDMfR1ITu3gzR1CP8bPDSoopxK
 c0n0GOGjXaOerh6i/hpfF+Z9Dq97q0Xjxz1z97kd2rwT2mQHXYJJ/MKcd5nIviU+B4wT
 Rmhw==
X-Gm-Message-State: AOJu0YxHFnkgstJkbOCPd5RKSoELgYZCrTYXMi6nxc9/zPSpjY2fwuly
 L5zQO/W8vzMfiP2K0ZLKEpfC6A==
X-Google-Smtp-Source: AGHT+IHGtg33/NopFmer5n0z1ifBfrthXd0wKU525XwIMabDbnV12Tf5VBvtIdXGg0HQYQTn9rmjEQ==
X-Received: by 2002:a05:600c:5118:b0:40b:32fa:d8a3 with SMTP id
 o24-20020a05600c511800b0040b32fad8a3mr11022769wms.18.1701177967786; 
 Tue, 28 Nov 2023 05:26:07 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b004064cd71aa8sm17624558wmq.34.2023.11.28.05.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 05:26:07 -0800 (PST)
Message-ID: <2b8e0424-1b93-4ae1-9d66-aeeaf7afc313@linaro.org>
Date: Tue, 28 Nov 2023 14:26:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Fix IRQ routing in via south bridge
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, vr_qemu@t-online.de
References: <cover.1701035944.git.balaton@eik.bme.hu>
 <cc64f407-9a5a-d0b7-33b7-0f142a9ec6a1@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cc64f407-9a5a-d0b7-33b7-0f142a9ec6a1@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi Zoltan,

On 28/11/23 13:47, BALATON Zoltan wrote:
> On Sun, 26 Nov 2023, BALATON Zoltan wrote:
>> Philippe,
>>
>> Could this be merged for 8.2 as it fixes USB on the amigaone machine?
>> This would be useful as usb-storage is the simplest way to share data
>> with the host with these machines.
> 
> Philippe, do you have some time to look at this now for 8.2 please? I 
> still hope this could be fixed for the amigaone machine on release and 
> dont' have to wait until the next one for USB to work on that machine.

Thanks for your detailed cover and patch descriptions.

I just finished to run my tests and they all passed.

I couldn't spend much time reviewing the patches, but having a quick
look I don't think the way you model it is correct. This is a tricky
setup and apparently we don't fully understand it (I understand what
you explained, but some pieces don't make sense to me). That said,
I understand it help you and the AmigaOne users, and nobody objected.
So, while being a bit reluctant, I am queuing this series; and will
send a PR in a few. We'll have time to improve this model later.

Regards,

Phil.


