Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A10805CA9
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 18:56:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAZdJ-0003QT-KE; Tue, 05 Dec 2023 12:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1rAZdH-0003Px-OL
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 12:54:55 -0500
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1rAZdG-0003sl-43
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 12:54:55 -0500
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-58d9dcdf201so3771336eaf.2
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 09:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701798891; x=1702403691; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ah8a11d2I6vEhBdY+zb9gYIMyM45JmQk4Nwqq58ChyI=;
 b=hKVf91iHt73TQtvlv76Z6B3vAZtSvO91NK85LJ67+HHXlrvuQP9SC11TVojhrIblxc
 wP5GPkILP9uoHERM9uE+9Jx1Lul5dUYe+MhOk/UZIOGA1Ms72ujGSdR/xBXwK+Te86cD
 bdMZ66jvsP6ui+XQNezKnt3iTU/4hxTP9XtejJwGBXMhsLgD+XMPneZvyZCvXG6ZrPuq
 qps5asRZF76BEYFiePblsRClbbWPaGyQ0IohixHYcd+kJ+ZVeKG8PGy5z37KxZHS3Q14
 6RIBdp1n+Tu8rfzWT4EMrx0vpum6CDnmJUwMX2ow3E6WfIazg727kzmeutwB/TH562H6
 Nlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701798891; x=1702403691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ah8a11d2I6vEhBdY+zb9gYIMyM45JmQk4Nwqq58ChyI=;
 b=K7TzKUAhGsqarRANXBdvXCzVkQHLHyKkHAJ9Vw7PHI4ORQF9+vrFTbI78KZbTzgn5n
 fCWYUTDumpvKwLbrJCNU3bt5K1XpdtUleid4ik2Np/unAms1gpeO3RK6ApFeiHua0lSl
 iKW9AvH0tva8WAXowBNK6QfYfIQMq2RtSqbD5BwpxkuEklqjCKbrXdIb6eDlR2KUrTfc
 ZpQkw/c7iA4W0hVPgVKQKUyqAG+3ADpIK1hF1txkmuHrADaErUmup1FLxiUdWOq0pe2p
 Q3/GJKloJ5OG8W3ZzEBpz7ADecDUgHy1Tgs6dM2rJYO4V0JnrmNW7pjvlKvJ7jD1pVUA
 /MkQ==
X-Gm-Message-State: AOJu0Yzw7nFtrUJKgj4a6CqiwNBbrn2USBS+65GSwlhHOh9EspnchQ95
 izuah056E0c4jZVfuQmNuOG41SRKPPsXX+Nb6chtSQ==
X-Google-Smtp-Source: AGHT+IHk3c6IHgFHtJuCLf5ZCCZsAPeC0Zu6yB87JUdASjQ9aiWRLhJ+cC4JKfa3Pd3JiD6TMu+btoABBbG+lZU/IiM=
X-Received: by 2002:a05:6870:ed95:b0:1fb:75a:de75 with SMTP id
 fz21-20020a056870ed9500b001fb075ade75mr8710445oab.99.1701798891531; Tue, 05
 Dec 2023 09:54:51 -0800 (PST)
MIME-Version: 1.0
References: <20231027175532.3601297-1-nabihestefan@google.com>
In-Reply-To: <20231027175532.3601297-1-nabihestefan@google.com>
From: Nabih Estefan <nabihestefan@google.com>
Date: Tue, 5 Dec 2023 09:54:40 -0800
Message-ID: <CA+QoejW--t61WoJm8-gz2WV25owoKHg4dbOm2+_+Zrdu1DuFnA@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] Implementation of NPI Mailbox and GMAC
 Networking Module
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=nabihestefan@google.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hello,

Since all patches for this change have been reviewed, is it possible
to apply it to the current branch so it can be fully upstreamed?

Thank you!
Nabih Estefan (he/him) |  Software Engineer |
nabihestefan@google.com |  857-308-9574

Nabih Estefan (he/him) |  Software Engineer |
nabihestefan@google.com |  857-308-9574



On Fri, Oct 27, 2023 at 10:55=E2=80=AFAM Nabih Estefan <nabihestefan@google=
.com> wrote:
>
> From: Nabih Estefan Diaz <nabihestefan@google.com>
>
> [Changes since v4]
> Added Signed-off-by tag and fixed patch 4 commit message as suggested by
> Peter Maydell (peter.maydell@linaro.org)
>
> [Changes since v3]
> Fixed comments from Hao Wu (wuhaotsh@google.com)
>
> [Changes since v2]
> Fixed bugs related to the RC functionality of the GMAC. Added and
> squashed patches related to that.
>
> [Changes since v1]
> Fixed some errors in formatting.
> Fixed a merge error that I didn't see in v1.
> Removed Nuvoton 8xx references since that is a separate patch set.
>
> [Original Cover]
> Creates NPI Mailbox Module with data verification for read and write (int=
ernal and external),
> wiring to the Nuvoton SoC, and QTests.
>
> Also creates the GMAC Networking Module. Implements read and write functi=
onalities with cooresponding descriptors
> and registers. Also includes QTests for the different functionalities.
>
> Hao Wu (5):
>   hw/misc: Add Nuvoton's PCI Mailbox Module
>   hw/arm: Add PCI mailbox module to Nuvoton SoC
>   hw/misc: Add qtest for NPCM7xx PCI Mailbox
>   hw/net: Add NPCMXXX GMAC device
>   hw/arm: Add GMAC devices to NPCM7XX SoC
>
> Nabih Estefan Diaz (6):
>   tests/qtest: Creating qtest for GMAC Module
>   include/hw/net: Implemented Classes and Masks for GMAC Descriptors
>   hw/net: General GMAC Implementation
>   hw/net: GMAC Rx Implementation
>   hw/net: GMAC Tx Implementation
>   tests/qtest: Adding PCS Module test to GMAC Qtest
>
>  docs/system/arm/nuvoton.rst         |   2 +
>  hw/arm/npcm7xx.c                    |  53 +-
>  hw/misc/meson.build                 |   1 +
>  hw/misc/npcm7xx_pci_mbox.c          | 324 ++++++++++
>  hw/misc/trace-events                |   5 +
>  hw/net/meson.build                  |   2 +-
>  hw/net/npcm_gmac.c                  | 942 ++++++++++++++++++++++++++++
>  hw/net/trace-events                 |  19 +
>  include/hw/arm/npcm7xx.h            |   4 +
>  include/hw/misc/npcm7xx_pci_mbox.h  |  81 +++
>  include/hw/net/npcm_gmac.h          | 340 ++++++++++
>  tests/qtest/meson.build             |   8 +-
>  tests/qtest/npcm7xx_pci_mbox-test.c | 238 +++++++
>  tests/qtest/npcm_gmac-test.c        | 341 ++++++++++
>  14 files changed, 2351 insertions(+), 9 deletions(-)
>  create mode 100644 hw/misc/npcm7xx_pci_mbox.c
>  create mode 100644 hw/net/npcm_gmac.c
>  create mode 100644 include/hw/misc/npcm7xx_pci_mbox.h
>  create mode 100644 include/hw/net/npcm_gmac.h
>  create mode 100644 tests/qtest/npcm7xx_pci_mbox-test.c
>  create mode 100644 tests/qtest/npcm_gmac-test.c
>
> --
> 2.42.0.820.g83a721a137-goog
>

