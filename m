Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 489727E46B4
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 18:22:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Pkn-0001y6-Kc; Tue, 07 Nov 2023 12:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Pkj-0001xg-Vn; Tue, 07 Nov 2023 12:20:38 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1r0Pkh-0001Et-MK; Tue, 07 Nov 2023 12:20:37 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41cd7a3e8f8so40607841cf.0; 
 Tue, 07 Nov 2023 09:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699377632; x=1699982432; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x/Bd6YdQA2LmzpBvUNPuf0nN4MTBs5nBnF5YbhUl/Z0=;
 b=WMOi2qLayNf+Yh1rJDggDPbn9quyi/e2B27LIXf2bX4s0BU9ft2QcWMc6TISPNhrAO
 56AhHPoTE1+cHVNA+sJUoK777I1+DsSArk5ppsvp4BwlS8tpdUYxVU8OGbn65CsdUFXw
 HGDy4Cs0IsC6ZqU2gnlCVyIIdKvykHYfLF+BpErj/F8U/cf+aiUQD9TyIH/skbByL81q
 Bvx2aT+8NGWWC4kuvwmjo8tP7+uI5KlqsgHOm0F6ShPpKRG+rgGped9IZgYLp9wq0v6Z
 hvBtP6se4I1diU7Y2sbSNp/esADUAderS82ch41QOn1CeA5KsYR4MmDRC6tzP3efLlt/
 NqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699377632; x=1699982432;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x/Bd6YdQA2LmzpBvUNPuf0nN4MTBs5nBnF5YbhUl/Z0=;
 b=vq3Kh1e6Uec/pr/AST6ovNs7G9P2f7vJd/7MJoLNyb8moQbRgRcZKXDs0JL/ZPHqUf
 a7wc0ETswSPWkDskW7/QToZTjWAuFmfQGM1kcXKCS9xPbWKaIMW9Hit9vT0/MTJNVUqt
 Vq01FLnbvpCcYkaDZdEGISV1WrlSNHjVY2pDt1kASFUdlKJqgyEH/6nWKjEjYF3z3Qwe
 Kny9ZhgCXUKdf95fiBj1sSLsP/q6Kuvl2MA11G37djm8TcfqMKHgInuyOFQAnC+3TW1O
 oXut+q+AAXgmWPIO84VkZ7iCdjJY05jv07+JWXXkq6QhI87ddbK8VPvZFcEU+UqsvUzb
 eIzQ==
X-Gm-Message-State: AOJu0YwbDJvXa0lu3cQVc1fhQQmIIOhsGbCKmHtnDgOYjAF47kify/1P
 ylAxbJyRgxDfY3wlqcmxFjI=
X-Google-Smtp-Source: AGHT+IFve8y8zwjoHkbaZfLhP0xdrNeRVwwlQtB9i0DmtAI6D9o0iGubnngVxAotftwEm6iix/trMQ==
X-Received: by 2002:a05:622a:1a18:b0:41e:a64e:178b with SMTP id
 f24-20020a05622a1a1800b0041ea64e178bmr12001421qtb.19.1699377631949; 
 Tue, 07 Nov 2023 09:20:31 -0800 (PST)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 w4-20020ac87e84000000b00419cb97418bsm92471qtj.15.2023.11.07.09.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 09:20:31 -0800 (PST)
Message-ID: <697ad2e0-cb23-4efe-89e5-d1b521c0648f@gmail.com>
Date: Tue, 7 Nov 2023 14:20:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] Add emulation of AmigaOne XE board
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, clg@kaod.org, philmd@linaro.org,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
References: <cover.1698406922.git.balaton@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <cover.1698406922.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Zoltan,

Gitlab is complaining about a missing file in one of the tests:


   8/259 qemu:qtest+qtest-ppc / qtest-ppc/test-hmp                          ERROR           0.22s   killed by signal 6 SIGABRT
4324>>> G_TEST_DBUS_DAEMON=/builds/danielhb/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=./qemu-system-ppc MALLOC_PERTURB_=87 PYTHON=/builds/danielhb/qemu/build/pyvenv/bin/python3 /builds/danielhb/qemu/build/tests/qtest/test-hmp --tap -k
4325――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
4326stderr:
4327qemu-system-ppc: Could not find firmware 'u-boot-amigaone.bin'
4328Broken pipe
4329../tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
4330(test program exited with status code -6)
4331TAP parsing error: Too few tests run (expected 13, got 0)


You can reproduce it like this:

$ make -j -C build  && QTEST_QEMU_BINARY=./build/qemu-system-ppc64 ./build/tests/qtest/test-hmp

I ended up amending in-tree (downloaded the firmware, put it under pc-bios, updated pc-bios/meson.build).
My manual test now passes, but not sure if gitlab will nag about it. Let's wait and see.


I told you: code freeze is a blast! Let's see if it's still sunny for the
AmigaOne XE board emulation.



Thanks,


Daniel





On 10/27/23 08:54, BALATON Zoltan wrote:
> Changes in v7:
> - Increase default memory size to 512m to match pegasos2 and sam460ex
> and it's a better default for AmigaOS
> 
> Changes in v6:
> - Dropped patch 1, now it's
> 
> Based-on: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
> 
> ([PATCH v2 0/3] ide: implement simple legacy/native mode switching for PCI IDE controllers)
> - Added Tested-by from Rene
> 
> Changes in v5:
> - Fixed avocado test
> 
> Changes in v4:
> - Found typo in comment in patch 1 so ended up rewording it again
> trying to make it more concise. Also take the idea of using
> range_covers_byte from Mark's patch
> - Added RFC patch for avocado test (untested, I don't have Avocado)
> 
> Changes in v3:
> - Update values, comment and commit message in patch 1 again
> 
> Changes in v2:
> - Update comment and commit message in patch 1 (Mark)
> - Fix irq mapping in patch 2 (Volker)
> 
> Regards,
> BALATON Zoltan
> 
> BALATON Zoltan (3):
>    hw/pci-host: Add emulation of Mai Logic Articia S
>    hw/ppc: Add emulation of AmigaOne XE board
>    tests/avocado: Add test for amigaone board
> 
>   MAINTAINERS                             |   8 +
>   configs/devices/ppc-softmmu/default.mak |   1 +
>   hw/pci-host/Kconfig                     |   5 +
>   hw/pci-host/articia.c                   | 293 ++++++++++++++++++++++++
>   hw/pci-host/meson.build                 |   2 +
>   hw/ppc/Kconfig                          |   7 +
>   hw/ppc/amigaone.c                       | 164 +++++++++++++
>   hw/ppc/meson.build                      |   2 +
>   include/hw/pci-host/articia.h           |  17 ++
>   tests/avocado/ppc_amiga.py              |  38 +++
>   10 files changed, 537 insertions(+)
>   create mode 100644 hw/pci-host/articia.c
>   create mode 100644 hw/ppc/amigaone.c
>   create mode 100644 include/hw/pci-host/articia.h
>   create mode 100644 tests/avocado/ppc_amiga.py
> 

