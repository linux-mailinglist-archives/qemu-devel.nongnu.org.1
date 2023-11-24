Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD97F71E2
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 11:44:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Tf6-00025S-GJ; Fri, 24 Nov 2023 05:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r6Tf5-00025K-9Q
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:43:51 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r6Tf3-0004vp-GH
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:43:51 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54af2498e85so698566a12.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 02:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700822627; x=1701427427; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4EQULHmYTlOaGQko4y/XFOO4jtmz+ONQ14FLjK7VbA=;
 b=AOkkOMTqey5AkOwTXVGnflhBz299lXAXTKYbIhM4t7sAt4d8m4rtje2xcZC+MVTNtF
 GLGzP8wZ1uy0hAqL5CYgxPuTjOfeeO/11rCUSgvmJpHeOJyn36RY+k1bAuGTBo26sSMZ
 pNRlNNAYoLxsf3bQwBOga3xsvOXsc9T0cYyF6HNJZHE6nb9wHR7OZ6F3BrG6viFsvDQZ
 tI9dgGRnPvmlgWjYl2c93J0CoGB6a7MOgCLWhERuhHQ7XzPicMRKw4Kk3wHLCw7lyQRW
 xjdP/GYODgjZlfXPrAoFFIAUGDMTA78gCQkJQN6xJQtVSvlZ+zla8yBMN9UdumpY185b
 MzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700822627; x=1701427427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G4EQULHmYTlOaGQko4y/XFOO4jtmz+ONQ14FLjK7VbA=;
 b=DFS9y1dLoRTIzxuwrcIsIlUPhyuIpQG0nhEG8iTmFlrW79fPcD3Zkv0cTjXIZkLAiu
 ZbWifMlkrqe099rrpGlWCklNULW69eNkiDTrO2Y2HijPzI6gUZnXcCiTalhUKDqTvZrE
 heAL0KV8b75ZNs2UwncmRGt5aIkdmJ/PqFgVEYqg1PAA0nYY2UeoxKzI+15Oah1KGpKS
 zOnNWtJqWimi3ICraUv5I/yroK3GhAYEMOYFkOdD7Z4IzAUMqNyGKz70fFGLb5lB1xxy
 vzW5fBPZZQeLm3EijPgF52GJ3krsxU9rl4GRpn09ugxr69Iek2hheDVSP8diVHgB+j+w
 IfoA==
X-Gm-Message-State: AOJu0YyoWCe7jOj0FLXVp1hTG/rslFI0WJEMBY6JimNCkn6ErzSjzM4m
 OFhtLqH5YiRbeV3tSVMNTFLCwqfr0TxXhBOjZYAeBuYmZjQp5m4J
X-Google-Smtp-Source: AGHT+IEZ8gWeDJZ0nP2PI8bIoSuH+TbjBveieTqsrbk4dPRYxCS2oKwl+j1in2IwEcqwhznWw0DE/6SaMEYyT66IVQw=
X-Received: by 2002:aa7:d34e:0:b0:540:2c48:7913 with SMTP id
 m14-20020aa7d34e000000b005402c487913mr1741584edr.38.1700822627697; Fri, 24
 Nov 2023 02:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <87r0kgeiex.fsf@draig.linaro.org> <ZV-P6M8seKmMKGCB@redhat.com>
 <20231123183245-mutt-send-email-mst@kernel.org> <ZWB4MMrW1JttcxqI@redhat.com>
 <87edgfcueq.fsf@draig.linaro.org>
 <20231124053749-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231124053749-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Nov 2023 10:43:05 +0000
Message-ID: <CAFEAcA-0Kusbm_YGo5xu7ztNxdMMe28U5+9Xp=Rp=UG+Ur6EFg@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM code
 generators
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 24 Nov 2023 at 10:42, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Nov 24, 2023 at 10:33:49AM +0000, Alex Benn=C3=A9e wrote:
> > That probably means we can never use even open source LLMs to generate
> > code for QEMU because while the source data is all open source it won't
> > necessarily be GPL compatible.
>
> I would probably wait until the dust settles before we start accepting
> LLM generated code.

I think that's pretty much my take on what this policy is:
"say no for now; we can always come back later when the legal
situation seems clearer".

-- PMM

