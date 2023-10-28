Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD967DA79B
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 16:54:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwkgO-00008p-TH; Sat, 28 Oct 2023 10:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qwkgM-00008W-Pm; Sat, 28 Oct 2023 10:52:58 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qwkgL-0007bV-5v; Sat, 28 Oct 2023 10:52:58 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-538e8eca9c1so4739079a12.3; 
 Sat, 28 Oct 2023 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698504775; x=1699109575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MpkMwE5qEVSJPCRgQ8HrHIGNBg3wmqYX7j23cmSH+WI=;
 b=Dng0c3O5z94RaDaVtDFpHHvzQHpYmtA+bVnpF041O7acwvCUicEP+Zcl/QW+j6CckX
 Hb+mwCsj4wQojradkrC+FQii84j3sbb00bYB38WDt5GwnKT6RVQxKrV1i4dPEAseC+sA
 MKaapKq22XfoZ/oRrQ6B99YZswXgKD3h2Tjuz0dDDf9PSgnJon9FfQwqsfqbitQZ3Nw4
 25QulhJlCReY4mtwZF8JmQq7Ve233qGXWxMjX7OVq6p1uYU9uZxY0o4ONmV+bDdbcTEz
 PcbwND8NxI29wcY1ZslvUW3b6BtwgjEnPoyzkFVPBtcw+QMYk3aG9nkVKtudJulWlWDp
 f3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698504775; x=1699109575;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MpkMwE5qEVSJPCRgQ8HrHIGNBg3wmqYX7j23cmSH+WI=;
 b=FI6ISNSyXZQ48OsyqMejDqr4McURHC2jXQDacApXpOFnNInTDCZwUbtLU/WNH+t4hJ
 zHxMYG8Ksx35bWL2cfRlxv5okMtzbLhmuOfQ+wF2D8q5v9f94J5xvMb+nVgkmI0QzzXE
 vWjQ3ki6z2fyFnpzgDJSBwL4E8BBiCjMY6CYuf1fHcCOs7oH6pT5z/8Fct+4L18Nb1CH
 Op9eqt3xj09w/+BLOx57qB2Ta7ITXG6OyQn7K9VzOjTE2Pajb2pzFMLDrJbSrrirCt3r
 cuq2tXeV37rfbMfa4obhXXK4tuJ6+DXxHLU3pjoh0/QVT6A99Hn1985SROoapM3gtAdQ
 /5PA==
X-Gm-Message-State: AOJu0YyD7Aquyf+Ny9racnd4BqV/6rdVzMpzRqKX1rmE8Lk4RJ+FIRbr
 t7wbhN48WrGyNt9r6Bt+rUc=
X-Google-Smtp-Source: AGHT+IH4upiOLnOSzY9/MtGUotZ5fVVyLgh9Ux7NugFcOfTwkcaUZX07L8w+8QpH1aFaTbw0JcqdxQ==
X-Received: by 2002:a17:906:6a24:b0:9c5:ea33:7bf9 with SMTP id
 qw36-20020a1709066a2400b009c5ea337bf9mr4273957ejc.51.1698504774552; 
 Sat, 28 Oct 2023 07:52:54 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-089-012-044-170.89.12.pool.telefonica.de.
 [89.12.44.170]) by smtp.gmail.com with ESMTPSA id
 v22-20020a170906339600b009bf94de8971sm2876456eja.70.2023.10.28.07.52.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 07:52:54 -0700 (PDT)
Date: Sat, 28 Oct 2023 14:52:48 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
CC: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH v7 0/3] Add emulation of AmigaOne XE board
In-Reply-To: <cover.1698406922.git.balaton@eik.bme.hu>
References: <cover.1698406922.git.balaton@eik.bme.hu>
Message-ID: <AB7A22F3-8EDF-4E46-965A-6194201EAC98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 27=2E Oktober 2023 11:54:48 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
me=2Ehu>:
>Changes in v7:
>- Increase default memory size to 512m to match pegasos2 and sam460ex
>and it's a better default for AmigaOS
>
>Changes in v6:
>- Dropped patch 1, now it's
>
>Based-on: <20231024224056=2E842607-1-mark=2Ecave-ayland@ilande=2Eco=2Euk>
>
>([PATCH v2 0/3] ide: implement simple legacy/native mode switching for PC=
I IDE controllers)
>- Added Tested-by from Rene
>
>Changes in v5:
>- Fixed avocado test
>
>Changes in v4:
>- Found typo in comment in patch 1 so ended up rewording it again
>trying to make it more concise=2E Also take the idea of using
>range_covers_byte from Mark's patch
>- Added RFC patch for avocado test (untested, I don't have Avocado)
>
>Changes in v3:
>- Update values, comment and commit message in patch 1 again
>
>Changes in v2:
>- Update comment and commit message in patch 1 (Mark)
>- Fix irq mapping in patch 2 (Volker)
>
>Regards,
>BALATON Zoltan
>
>BALATON Zoltan (3):
>  hw/pci-host: Add emulation of Mai Logic Articia S
>  hw/ppc: Add emulation of AmigaOne XE board
>  tests/avocado: Add test for amigaone board

Hi Zoltan,

Could you please provide some documentation on how to run Linux or some ot=
her free (as in free beer) OS on this machine? Can you provide an Avocado t=
est booting e=2Eg=2E Linux as a quality gate for the VIA south bridges?

As you know I'm trying to bring these south bridges to the PC machine and =
relying on hard to get proprietary blobs or OSes makes this very difficult=
=2E Whenever the VIA south bridges are changed we end up having endless dis=
cussions due to this situation=2E We need a solution that works for everybo=
dy woking on these south bridges=2E

Best regards,
Bernhard


>
> MAINTAINERS                             |   8 +
> configs/devices/ppc-softmmu/default=2Emak |   1 +
> hw/pci-host/Kconfig                     |   5 +
> hw/pci-host/articia=2Ec                   | 293 ++++++++++++++++++++++++
> hw/pci-host/meson=2Ebuild                 |   2 +
> hw/ppc/Kconfig                          |   7 +
> hw/ppc/amigaone=2Ec                       | 164 +++++++++++++
> hw/ppc/meson=2Ebuild                      |   2 +
> include/hw/pci-host/articia=2Eh           |  17 ++
> tests/avocado/ppc_amiga=2Epy              |  38 +++
> 10 files changed, 537 insertions(+)
> create mode 100644 hw/pci-host/articia=2Ec
> create mode 100644 hw/ppc/amigaone=2Ec
> create mode 100644 include/hw/pci-host/articia=2Eh
> create mode 100644 tests/avocado/ppc_amiga=2Epy
>

