Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0400F815DBE
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 07:14:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEkQ1-0003hf-Ib; Sun, 17 Dec 2023 01:14:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEkPz-0003XL-SE
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 01:14:27 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEkPx-0005rq-C9
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 01:14:26 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6d2ec415bf6so848806b3a.3
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 22:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702793662; x=1703398462;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7ZRgmIlGkboAPJmaOxPTJAZbAFGtGdiWl96xOkqW9CI=;
 b=BFIWJKC4DxHd/kzUl0mGIkJrlJtkZ5+Q/dnWXRQELXPRKOkGsxqQJSD4QhdkERFuhN
 wsOhmsqTrKbzxUt5qkkesS6SOmTQHIOwFph0GwksA36zKXa/dH9SFogd7q6Uys05hoUO
 YbNVC9g6MOeEuYT466c1RtdspfhEXuvcqjg0/Z3zyjq4GGKzwDegAmvvvXHQFAPENfFc
 ulaCddtp+yV9mogZXeteQNR0p5Z7GAieH3YTl3GGhwlq0T6N+KWt1QAzIyBZNsdOhdCk
 sdXCB+wY1stvlVpmthDiHoxJOOEcp8ZZse94340rHqbPYgqz+oeLqdP6lkizT0GlZZDC
 XeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702793662; x=1703398462;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ZRgmIlGkboAPJmaOxPTJAZbAFGtGdiWl96xOkqW9CI=;
 b=qevQ+IGVjm2jGFBuX2dNPPpsabbhq9bKTGY7vHDJTeLPTCvyg8xKXNatI+AJsXeZ27
 MrNf8oeMnc8XcW6TTB0/j0PZHYZrZ03jaO0Onu2pnb2AHv/+5TBDqvmgFAd8Ol6IItlQ
 Paao6KkSCOtBZY8tCgULCnozt45eFWJKus/8j9WIMNOljivvo6EcB43sm0kfhHdfeF/z
 pp/SbSDQt1G62Gsjan84CIJoDUJgqpgkEXKwWlyGmXVQa7BBUjypmR51LLz0w7Hv+kg+
 jaMmRXprlg9QZabdr49D70JelW6r+Luetqp9nv7+AB15LwGV18exZRXPrvLI6dels4sZ
 yE3A==
X-Gm-Message-State: AOJu0Ywha3O/pv8JPxpVcydds/qYZ87V6VjaUw5d+vgPtD0GTEbcrVVZ
 my0jQCtugFPWFxhbpFw17+5NkA==
X-Google-Smtp-Source: AGHT+IEGGZnKPRCQWeFfcNbnsew2ZxOp/fzD8MsNBAlg7s2/dmcAxTqbJ/n5XGvmjFzBSPuU5GTbmA==
X-Received: by 2002:a05:6a00:856:b0:6cd:f8cd:528e with SMTP id
 q22-20020a056a00085600b006cdf8cd528emr18595494pfk.5.1702793662223; 
 Sat, 16 Dec 2023 22:14:22 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a056a0010c400b006ce7344328asm15917307pfu.77.2023.12.16.22.14.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 22:14:21 -0800 (PST)
Message-ID: <d6258e35-de10-447a-87be-0a3e5c3055ed@daynix.com>
Date: Sun, 17 Dec 2023 15:14:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] Move dbus-display1 out of ui
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231216-dbus-v3-0-b4bcbed7374a@daynix.com>
 <20231216-dbus-v3-1-b4bcbed7374a@daynix.com>
 <97f0a23c-dc29-4687-af8d-388d7a63947a@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <97f0a23c-dc29-4687-af8d-388d7a63947a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
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

On 2023/12/17 1:57, Philippe Mathieu-Daudé wrote:
> On 16/12/23 08:53, Akihiko Odaki wrote:
>> Despite its name, dbus-display1 does not only provide DBus interfaces
>> for the display but also for the audio.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   MAINTAINERS                               |  1 +
>>   meson.build                               | 21 +++++++++++++++++++++
>>   ui/dbus.h                                 |  2 +-
>>   audio/dbusaudio.c                         |  2 +-
>>   tests/qtest/dbus-display-test.c           |  2 +-
>>   ui/dbus-display1.xml => dbus-display1.xml |  0
> 
> What about moving it to backends/ instead? Also could be renamed.
> "ui" means User Interface. Audio is still one. Suggestions:
> 
>   ui/dbus-backend, backends/dbus-... ?

Moved to util with v4 as I'm adding it to libqemuutil for 
dbus-display-test. (And I sent v5 since I missed to update the 
documentation; sorry for sending changes so frequently.)

The file name represents the D-Bus interface name, and renaming the 
D-Bus interface name will be a breaking change so I decided not to do 
that for now.

