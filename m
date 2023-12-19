Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC00581872A
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 13:13:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFYy9-0005sd-Uo; Tue, 19 Dec 2023 07:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rFYy6-0005sS-JC
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 07:13:02 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rFYy3-0007hm-9f
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 07:13:01 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5cda3e35b26so970420a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 04:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702987974; x=1703592774;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b1HHz7qj+W79M1M+maoUYoLIYJEA2glgon4UobUhGys=;
 b=K1ftGMCVVY0cfFQvUIMOKzNcC5JMixm0v89MMQcp6bMihC2LGGC+U4J2nXOjyUFETe
 7uBbxqHdObtaLiazCZpz//c5B/8f5ilHbJGgWWepz7wNtegj5OqiuAQTl9wZtrM+gDJU
 ECWCFtLK43QntCtqcigs1KVHItbFElYyKq7HQZ+aeqOSl1MprTCcsa8yun0QfiKKg2rT
 NFmCY1PyzcG/YyCrLnL0hyCEHahnHAyl4NKNieExQvDkNBzoIdXE7NfuynnIPUPCrz6v
 VQzTDPxvvAs/3SAalRDcllmG0FQIHuQF2yhaDGMMAq+sFOOLFGDs4V9GlawfpKrcv7ze
 8EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702987974; x=1703592774;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b1HHz7qj+W79M1M+maoUYoLIYJEA2glgon4UobUhGys=;
 b=X93kUL9tQAkCoYC5/diKWRlOL1e1ZuH1XOdwpUGjcxm0vU7800da4WfGTnM+mpQQmS
 f3nP98rjPlHhc2K6CVrckSM8w4QZb3UIPJKfO+KtClN2CvPTHaLEg86fgRcqJcdW/1qp
 DPqJJMi3ySuBflMrpPbCZnsJcsXQ/+u+dt+tqcPzYq0f6hlyxbNj8reOTqgG4oxNm8cQ
 PlkVFcQ+5lfRDNDLLwmxsO49k+ER2lgD95v4g6YPYyw4qoFM5r2omZ9jKZN052RHGAXT
 HOBp7JSJuseOYXsk+PXVC0D44BH8b1MTKtv+sgTnAl42Rkf8VEK9DO0GcXwXnZUPaHzG
 nOLg==
X-Gm-Message-State: AOJu0YxAUvNmRk18uMC0lu0GYAo2Nbfm3WKDXUz6TGn/OH5Ep0xefaTE
 0cT6EYzcBI5+Kipxzfuga0OPRA==
X-Google-Smtp-Source: AGHT+IFwol6gHtAaAVcgXdnJD6JCc5H3/v3uqRi5pz9Ydq1LySrj+IGP5qn+PsT9yZy78wInbLb9aw==
X-Received: by 2002:a05:6a21:350d:b0:18c:570d:c5b4 with SMTP id
 zc13-20020a056a21350d00b0018c570dc5b4mr13230126pzb.35.1702987974303; 
 Tue, 19 Dec 2023 04:12:54 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 x16-20020aa784d0000000b006ce5bb61a60sm3214382pfn.35.2023.12.19.04.12.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 04:12:53 -0800 (PST)
Message-ID: <2a775be4-363a-4e85-ae32-97ceb5927e11@daynix.com>
Date: Tue, 19 Dec 2023 21:12:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] ui/cocoa: Use NSWindow's ability to resize
Content-Language: en-US
To: Rene Engel <ReneEngel80@emailn.de>
Cc: peter.maydell@linaro.org, philmd@linaro.org, kraxel@redhat.com,
 marcandre.lureau@redhat.com, smarkusg@gmail.com, qemu-devel@nongnu.org
References: <20231217-cocoa-v7-1-6af21ef75680@daynix.com>
 <ad45a3b3201a6c9b24138abf2174946b@mail.emailn.de>
 <d73b8c8e-fde3-49e6-88b8-8f9bfa248509@daynix.com>
 <71895f08af8ba9f01dd78da158005229@mail.emailn.de>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <71895f08af8ba9f01dd78da158005229@mail.emailn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/19 0:07, Rene Engel wrote:
> 
> --- Ursprüngliche Nachricht ---
> Von: Akihiko Odaki <akihiko.odaki@daynix.com>
> Datum: 18.12.2023 08:59:41
> An: Rene Engel <ReneEngel80@emailn.de>
> Betreff: Re: [PATCH v7] ui/cocoa: Use NSWindow's ability to resize
> 
>> On 2023/12/17 18:46, Rene Engel wrote:
>>>
>>> --- Ursprüngliche Nachricht ---
>>> Von: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Datum: 17.12.2023 07:25:52
>>> An: Peter Maydell <peter.maydell@linaro.org>,  Philippe Mathieu-Daudé
>> <philmd@linaro.org>,  Gerd Hoffmann <kraxel@redhat.com>,  Marc-André
>> Lureau <marcandre.lureau@redhat.com>,  Marek Glogowski <smarkusg@gmail.com>
>>
>>> Betreff: [PATCH v7] ui/cocoa: Use NSWindow's ability to resize
>>>
>>> Tested-by: Rene Engel <ReneEngel80@emailn.de>
>>>
>>> This patch now works with the "option zoom-to-fit=on/off"
>> thank you very much.
>>>
>>> But there is severe mouse lag within Cocoa output in full screen. You
>> can reproduce the problem by using the mouse very slowly inside the machine
>> where the mouse pointer no longer moves (guest). This issue only occurs with
>> Cocoa edition SDL/GTK works without mouse lag within the machine.
>>
>> I can't reproduce the issue. Is it a regression caused by this change or
>>
>> an existing bug?
>>
> 
> I'm not sure how to reproduce it, but when I compile Qemu from master source, zoom-to-fit for cocoa output is always active without using your patch and cannot be enabled or disabled in full screen. Here the mouse speed is about the same as under the MacOs host system.
> 
> When using their latest patch series v8 for cocoa I can enable and disable zoom-to-fit with "-display cocoa,zoom-to-fit=on/off -full-screen" but the mouse speed then becomes slower. I'm not sure what changes there were from Qemu Master where part of their patch must be included, unless someone else has added something similar for Qemu Master.

Can you tell me your whole command line and guest operating system?

Regards,
Akihiko Odaki

