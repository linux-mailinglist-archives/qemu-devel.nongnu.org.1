Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 950D77DE8B7
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 00:00:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyKAx-0003Eb-By; Wed, 01 Nov 2023 18:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qyKAv-0003E3-EA; Wed, 01 Nov 2023 18:59:01 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qyKAt-0002pj-Du; Wed, 01 Nov 2023 18:59:01 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so491189a12.0; 
 Wed, 01 Nov 2023 15:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698879536; x=1699484336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CckwcfZjnx8OWAA1F6cuamHaIQgScmGzNHu0wkEZzow=;
 b=Bw76+vOHZc7lIAMeUgKaKbUhoBzlAfgOv5wtgiaugbuz/lg64Ckib1ow93RjLh/GgL
 GnUn330nqTV6mhqmvelLPNJ/UfP6fXBrlChfdXdG08GWDrBWhO34DqRvuTs+4qXvkzOq
 CYc+CfxfuiunSJ/1Q+IttiFA1j42ESnXyq6U8zACeF+ugvumKpPFe/Oa3vZ5ajFcI+EM
 fjBZQxKl9h3oYwwDniq/G0jwb8OqQ4B2HcZ/ed1GeYwGWV4q0bTZIEoXZHWVlgYG1Ahp
 FZiwdX7uiFBrjQjoMddifPKXKzEc2As2KoOjVQHzQOmhWhQi7j2z2DZjZNPn4U20Mi9T
 7rpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698879536; x=1699484336;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CckwcfZjnx8OWAA1F6cuamHaIQgScmGzNHu0wkEZzow=;
 b=YIe6+yk8xIFy+yrwkqYF+Kd19qv4dPI58db4bPDUtcL/wIJ8QCpWrD3+a2IClOLgGw
 rsv9a8bvwcfelZQADd3BPIwE5JYX1ByBPZIjv9hCwtkpt3tZEQKdMT/Lmr3bRi1GOIK3
 3KGHkHWbu9mKzsA3Y/7XBS/aQmAoHsBmqgkw6Zo9aKeIWn48MOTxhf2ayRBvXgGzXET2
 4y+yHwFzfnsTBuLzgdHUYD9E8FbFf15T9+ZjVvb8CnmrINW1pH1H5QOp066NKZQPuBWR
 9qD3WtNQOd0o1/U768qzi6wD13+FWi1h560HJAR8HXijQ3t24jbhpU4ptMYe9EyIiDkw
 YIfw==
X-Gm-Message-State: AOJu0Yz6V37PFRpgNMYXAhEXafsPoN2R80wiD1tfWL0gWBpsLer6o31F
 ldSdOh9jECUyOifa+eUrOlA=
X-Google-Smtp-Source: AGHT+IHtNePqsrLx7EeDpQhlqRdFZ4xx6jVZ5043Yc41a+qzaeg0/tjo/vvwpV6Lg/bFT4Ur6gHziw==
X-Received: by 2002:a17:906:806:b0:9a2:26d8:f184 with SMTP id
 e6-20020a170906080600b009a226d8f184mr2497994ejd.51.1698879536323; 
 Wed, 01 Nov 2023 15:58:56 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-047-044.77.191.pool.telefonica.de.
 [77.191.47.44]) by smtp.gmail.com with ESMTPSA id
 gz6-20020a170906f2c600b009c758b6cdefsm433113ejb.128.2023.11.01.15.58.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 15:58:55 -0700 (PDT)
Date: Wed, 01 Nov 2023 17:37:33 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 0/6] Various tracing patches
In-Reply-To: <CAFEAcA8XE3xUcc0kmN-1ki6eKZmGiTFM7Xavsvmc3+rMCJk7QQ@mail.gmail.com>
References: <20231028122415.14869-1-shentey@gmail.com>
 <CAFEAcA8XE3xUcc0kmN-1ki6eKZmGiTFM7Xavsvmc3+rMCJk7QQ@mail.gmail.com>
Message-ID: <692B785D-C756-4279-BA7C-D41AAE536001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



Am 31=2E Oktober 2023 16:17:32 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Sat, 28 Oct 2023 at 13:24, Bernhard Beschow <shentey@gmail=2Ecom> wrot=
e:
>>
>> This series enhances the tracing experience of some i=2EMX devices by a=
dding new
>> trace events and by converting from DPRINTF=2E SMBus gets also converte=
d from
>> DPRINTF to trace events=2E Finally, when tracing memory region operatio=
ns, host
>> pointers aren't traced any longer and are substituted by their memory r=
egion
>> names=2E
>>
>> Bernhard Beschow (6):
>>   hw/watchdog/wdt_imx2: Trace MMIO access
>>   hw/watchdog/wdt_imx2: Trace timer activity
>>   hw/misc/imx7_snvs: Trace MMIO access
>>   hw/misc/imx6_ccm: Convert DPRINTF to trace events
>>   hw/i2c/pm_smbus: Convert DPRINTF to trace events
>>   system/memory: Trace names of MemoryRegions rather than host pointers
>
>Since these are mostly arm devices I've taken patches 1-5
>into target-arm=2Enext (with the addition of "Hz" to the
>frequency traces in patch 4)=2E

Excellent=2E Thanks!

Best regards,
Bernhard

> Patch 6 looks like it needs
>further discussion=2E
>
>thanks
>-- PMM

