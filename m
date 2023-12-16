Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FE7815854
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 08:57:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEPYF-0005sA-PE; Sat, 16 Dec 2023 02:57:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEPYD-0005rv-EJ
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 02:57:33 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEPYC-0001FQ-1X
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 02:57:33 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ba2dd905f9so1097543b6e.2
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 23:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702713451; x=1703318251;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eWadDmc3leAWS8UfgwWpIRGlfna+Op3zS/7uOlhAqK0=;
 b=xLMLyEgmgu5z1X2tbckgGLhh53ewCfs22JM3DVt9P2qtEkMcSxoL1UsmlQVUkeTCxN
 lWJjRZvsNMyEiqv2YOA1rBlXWZbtE301yIk43a+gE76iooB6kmqUWxcoXx70x7K2oih7
 88qCMg8q7bGmL5Y6dROdS1VVvuG19pGgacLleEwnvKQdA0YuU3PcKxMp5wk53iCskLQ0
 lPSwrAdzH35vTnUAcEEgGUxuW5axL2CouAU2cj1NCCaTSfn0Qg1GFsjJO8HFzqAJ44Ic
 eWNTDX8C1U4pCcM2GdP3W3UGc5wpyq+w4yVwJH6+ya0Bf7a7oQa7uEE63grlcpNB2MtN
 ETng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702713451; x=1703318251;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eWadDmc3leAWS8UfgwWpIRGlfna+Op3zS/7uOlhAqK0=;
 b=nK+uc0dm1YoiMgDwClLWcHPC9Groopam30/Cpvnh+qOi3ZBQM27cwNnjjYlxLDvSdT
 cKBOuJMYh0Xa11bJfL6oCI0ok5reli06SN+VCv7AM6vAuhQFecEIyC9J3Mm3W4+/ihuZ
 HaNddkupmnPg5+wr0ndde4MAX7jRebFJ+oWmz39zNwzVFc9cn1d2aEt3EdfZaJGzdfbr
 roWrOMXZ2xiv+4Djh2KMwyzEFeNooxe2ZgxquiM1lVPpAD1mKCHbkoZI0qYzekNgXlB5
 lfRGTIYZgQrptAupLAI9eb5nfdlno9yuwT8ePMWVOy26QoDA1RdG6Cb1E7Mxd+rYMg9H
 wf2g==
X-Gm-Message-State: AOJu0YxEUkg9vdDeaHJEN9z1q0aVNPgHMrrD73v+C+CaIi+4OiBG5DJH
 vrOL/N3tugPJGG1wGV/CaAbEyg==
X-Google-Smtp-Source: AGHT+IEHrl8UDNHqRd2am/Sa9UiJ4tdwy1D0EphGd+iwxV+H4TTt3KGwrFXkObLgOcUrCubj3x2dDA==
X-Received: by 2002:a05:6808:3308:b0:3ba:1042:aee0 with SMTP id
 ca8-20020a056808330800b003ba1042aee0mr11396033oib.47.1702713450810; 
 Fri, 15 Dec 2023 23:57:30 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 u17-20020aa78491000000b006cb98a269f1sm14610886pfn.125.2023.12.15.23.57.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 23:57:30 -0800 (PST)
Message-ID: <eee18cab-6e49-43bb-9e7f-bcd49dfd6a41@daynix.com>
Date: Sat, 16 Dec 2023 16:57:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] Move dbus-display1 out of ui
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
References: <20231215-dbus-v2-0-1e2e6aa02115@daynix.com>
 <20231215-dbus-v2-1-1e2e6aa02115@daynix.com>
 <CAJ+F1C+pvRDmZpODinFuSzVYwPdrkar-ceo1aqWwAPtKbQztiw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAJ+F1C+pvRDmZpODinFuSzVYwPdrkar-ceo1aqWwAPtKbQztiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::229;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x229.google.com
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

On 2023/12/15 21:00, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Dec 15, 2023 at 3:29 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> Despite its name, dbus-display1 does not only provide DBus interfaces
>> for the display but also for the audio.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> It can actually do a lot more, since you can arbitrarily redirect
> chardev devices.. USB, smartcard, QMP and what's not are possible.
> 
> Yet, this is a -display module, so we should leave it under ui/ for now imho

I'm making this change specifically for audio. audio/dbusaudio.c has no 
dependency on the display despite it's part of the dbus-display1 interface.

By the way, I noticed audio/dbusaudio.c includes ui/dbus.h for no reason 
so I removed the inclusion in v3. It clarifies audio/dbus is independent 
of ui/dbus.

Regards,
Akihiko Odaki

