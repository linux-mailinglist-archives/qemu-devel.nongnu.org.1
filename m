Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3646815A8B
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 17:59:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEXzF-0003I7-I5; Sat, 16 Dec 2023 11:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rEXzE-0003Hs-8l
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 11:58:00 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rEXzC-0006vM-OU
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 11:58:00 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c3ceded81so16035755e9.1
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 08:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702745876; x=1703350676; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rm74z/Ourki2GutkkDEJ4YbWirJvb+CZrqIxNzQokWY=;
 b=dqt8wYsNoOiVJF+wC02TpONgFY4+3jmOmtB40fh4cvGH77dQd9EFrcfznI+GFWe6LB
 ueyO6AXr9f65Blb5riB05B3NHev9NsYS1iQ0bDtegbHuhZF1ZhoUddN1sVf8/va9TCKY
 0i9nDRdoHgkNWhJK9kM5ePigMr3D/N+RceY1OP1+b03+/gVV5Da4KJFRWioSoQy6N3z6
 ucUoslaSh8npnyNvelFUQD1HuO3MC7gpVq4yYRFZoVJWLyqDa+S1MGX00i4Xnf1nrzdS
 Tgm+9cCuJ+444CVXQWY5vfT3Wf4rNziULC91nY43AG39NAudH7j0ds65vV3X1GhF7PrY
 t+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702745876; x=1703350676;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rm74z/Ourki2GutkkDEJ4YbWirJvb+CZrqIxNzQokWY=;
 b=T2bsCCWgAfeUPiQ+Vex2c3BucpucuMzj353dKk2YOWIhVhzhO+8A9nbSLFoJLSyf6w
 BK7rmSsL5F/6NA+Brc4VkhX4NcrYmFItOCJ8by+IcRiRSCq9OD1jssTqpRQGqinm7bhb
 jP60JmDwiwIHthmDJ/nugmwoD/yuFtnF1QWnQ0lKEj7IqQJyV/geqhPjgcirrYCE4h0j
 /qWgU/P99PVDYnvI9o/jFr58itH+3UPGb2HqcuWccanHZ3vEnIcPex05/vxChdRdAVPQ
 iNwJrD1WZp2NP8b+JcD1bB5fRZdnKb/hjoseXTAspQk34bIZ595sovKtLxu2cGTX35QB
 PFRQ==
X-Gm-Message-State: AOJu0YxjGKvpNc3eaPCEbqxM7Q3sBaDzXosvyK34Y+j/g1lvSeBcLG4O
 1Yfae8QoVbtHGPIAhA2L/hWpWw==
X-Google-Smtp-Source: AGHT+IFH09gS1YZPJ8iBV1xuZyCBCFwh7qIKFlVFZXPQQyx4k3hXJFpeqKlHaL13uCoRicmg1NXn0g==
X-Received: by 2002:a05:600c:3107:b0:40b:5e21:ec14 with SMTP id
 g7-20020a05600c310700b0040b5e21ec14mr7300033wmo.70.1702745876434; 
 Sat, 16 Dec 2023 08:57:56 -0800 (PST)
Received: from [172.18.196.110] (ip-185-104-138-35.ptr.icomera.net.
 [185.104.138.35]) by smtp.gmail.com with ESMTPSA id
 fa17-20020a05600c519100b0040c46719966sm25154363wmb.25.2023.12.16.08.57.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 08:57:56 -0800 (PST)
Message-ID: <97f0a23c-dc29-4687-af8d-388d7a63947a@linaro.org>
Date: Sat, 16 Dec 2023 17:57:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] Move dbus-display1 out of ui
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231216-dbus-v3-0-b4bcbed7374a@daynix.com>
 <20231216-dbus-v3-1-b4bcbed7374a@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231216-dbus-v3-1-b4bcbed7374a@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 16/12/23 08:53, Akihiko Odaki wrote:
> Despite its name, dbus-display1 does not only provide DBus interfaces
> for the display but also for the audio.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   MAINTAINERS                               |  1 +
>   meson.build                               | 21 +++++++++++++++++++++
>   ui/dbus.h                                 |  2 +-
>   audio/dbusaudio.c                         |  2 +-
>   tests/qtest/dbus-display-test.c           |  2 +-
>   ui/dbus-display1.xml => dbus-display1.xml |  0

What about moving it to backends/ instead? Also could be renamed.
"ui" means User Interface. Audio is still one. Suggestions:

  ui/dbus-backend, backends/dbus-... ?

>   ui/meson.build                            | 18 ------------------
>   7 files changed, 25 insertions(+), 21 deletions(-)


