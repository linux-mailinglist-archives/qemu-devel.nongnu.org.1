Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 210427CB979
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 06:00:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsbEz-0002xK-1b; Mon, 16 Oct 2023 23:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qsbEw-0002x8-B6; Mon, 16 Oct 2023 23:59:30 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qsbEu-0001Zn-IG; Mon, 16 Oct 2023 23:59:30 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b20a48522fso2997118b3a.1; 
 Mon, 16 Oct 2023 20:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697515166; x=1698119966; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/24RlqE5h4heeejIEC6CmucFf6JQcNHa4+NOqFK1tSg=;
 b=N2D0VlAzU5YQkQOXW+F/DjBhiGhtWAs0GPZtdVoFUwo+7B5T5EUV26vwTQMVnAsRpI
 ZpBK2JzBPvTnQTjQ4Uzl/koR15ALukKGqt4YK6FTDnL7yndiMIpSQ9OLjKTYDndKxi73
 yce0ZCTz/7vaToch6F+fNSZ/vq5LS8oFFOnBxN9MFV4eUi3mH498TVqMnXC2/uqcVqT4
 mrPqeOdiZjdwjE4phkcqcs04Z+gvWytMGECemuCr2eRVx8FyH08PMGOvH+CLhx3HtzIb
 MwfBcyPzHXW0F5+80tvSGcndnzFSsxhrf+sWY4OstxstJ4TycAx54feFddZ6nFQpGirs
 6JpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697515166; x=1698119966;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/24RlqE5h4heeejIEC6CmucFf6JQcNHa4+NOqFK1tSg=;
 b=ZPWSNxzdwnj5GP0aq+hdqtf4RDmMqIQSSDr22ayOnNwclINEX3TFFqKs2CzHFCs5n0
 Lki5TGq9J/hFFHzIQ6Nal+cTqAqEn1PyraUE0rIBQ5VOXVbVdXsiHJikFyhbaDYYOJ6B
 b1DHNCuxOwFZGv7cWoraG+RHi+czxChDPlIF47Tgb3GKNmODS9B15TWGgyoYN6Kj9j4h
 icleBs5+OFa6cRtJefNlMWk4cm9Cms+/d2Mbooyhl5Ncvfs0KeD9r/uCBmCYv/N8T/MK
 /qgqUPjccV0gmQq6gxHew5nDHpR0YnyChWxso6snZvHwO57oAfIuYzg+ScHTTGQH/UAQ
 eXvA==
X-Gm-Message-State: AOJu0YwbaXpbJNfzsrlAA9rFxVwdrCYBZD/v9ROQ5GCiLelmIq4OXdpR
 16IEeU4dXwhUutVbFXJQaIY=
X-Google-Smtp-Source: AGHT+IGHe2dCMsxG+vsdBVCjsGh/D9YiNT9L64AB1ERuyJgJIi3V/msQDFTiUQdeyzflVsQZD9k8ZQ==
X-Received: by 2002:a05:6a00:a29:b0:6be:62e:d5a8 with SMTP id
 p41-20020a056a000a2900b006be062ed5a8mr1199766pfh.0.1697515166098; 
 Mon, 16 Oct 2023 20:59:26 -0700 (PDT)
Received: from localhost ([1.146.38.123]) by smtp.gmail.com with ESMTPSA id
 f186-20020a6251c3000000b00692754580f0sm354567pfb.187.2023.10.16.20.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 20:59:25 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Oct 2023 13:59:18 +1000
Message-Id: <CWAEWI5YNWTD.11GO4ENF2OC5M@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, <clg@kaod.org>,
 <philmd@linaro.org>, "Bernhard Beschow" <shentey@gmail.com>, "Mark
 Cave-Ayland" <mark.cave-ayland@ilande.co.uk>, "Rene Engel"
 <ReneEngel80@emailn.de>, <vr_qemu@t-online.de>
Subject: Re: [PATCH v3 0/3] Add emulation of AmigaOne XE board
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <cover.1697311794.git.balaton@eik.bme.hu>
 <81c6d451-a457-16ad-2f5d-5764bd32b4d5@eik.bme.hu>
In-Reply-To: <81c6d451-a457-16ad-2f5d-5764bd32b4d5@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

On Tue Oct 17, 2023 at 8:25 AM AEST, BALATON Zoltan wrote:
> On Sat, 14 Oct 2023, BALATON Zoltan wrote:
> > Changes in v3:
> > - Update values, comment and commit message in patch 1 again
> >
> > Changes in v2:
> > - Update comment and commit message in patch 1 (Mark)
> > - Fix irq mapping in patch 2 (Volker)
> >
> > Regards,
> > BALATON Zoltan
> >
> > BALATON Zoltan (3):
> >  via-ide: Fix legacy mode emulation
> >  hw/pci-host: Add emulation of Mai Logic Articia S
> >  hw/ppc: Add emulation of AmigaOne XE board
>
> Nick, Daniel, C=C3=A9dric,
>
> Patch 1 is not related to PPC and is still debated but just to make sure=
=20
> we don't get too close to freeze again I ask about patch 2 and 3 in the=
=20
> maintime. Not sure who will merge this series at the end but if you can=
=20
> give an Acked-by for the last two patches maybe Philippe can take care of=
=20
> the series or is any of you plan to take it via ppc?

Hey,

I could take patch 2/3 via ppc tree, although I don't know much about
platform and pci so some review/ack would be good.

I guess you could submit the Amiga stuff yourself too if you wanted,
you have much better understanding of it and I don't really know how to
test either (other than a few of the free to download installer images
for one or two of those OSes).

Thanks,
Nick

>
> Regards,
> BALATON Zoltan
>
> > MAINTAINERS                             |   8 +
> > configs/devices/ppc-softmmu/default.mak |   1 +
> > hw/ide/via.c                            |  41 +++-
> > hw/pci-host/Kconfig                     |   5 +
> > hw/pci-host/articia.c                   | 293 ++++++++++++++++++++++++
> > hw/pci-host/meson.build                 |   2 +
> > hw/ppc/Kconfig                          |   7 +
> > hw/ppc/amigaone.c                       | 164 +++++++++++++
> > hw/ppc/meson.build                      |   2 +
> > include/hw/pci-host/articia.h           |  17 ++
> > 10 files changed, 535 insertions(+), 5 deletions(-)
> > create mode 100644 hw/pci-host/articia.c
> > create mode 100644 hw/ppc/amigaone.c
> > create mode 100644 include/hw/pci-host/articia.h
> >
> >


