Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3760A7EAA24
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:31:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2m0M-0003IY-Fq; Tue, 14 Nov 2023 00:30:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r2m0J-0003I5-Kz
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:30:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r2m04-0008Eh-Co
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699939811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KYdz1LdDqXxrg73NymxfuIwXOLaJadgVCvKcNkIZIj8=;
 b=PtfvZl+pDw4skMZygKSuKVVtopAnoP8+eFjbjKG+FoB075D1INf5T29iXmyEAIc4d2LUjI
 E9vGQSQh1+VqQ2XazTOrmrC8PPpH+DTseefgg2d8lmD1wOkqMscl6aq75NKS/kihrj5IG4
 ONbMDIMHSYdZQs3lI2plChX+w+fynAs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-XPkRxR8yNeWgbhTgb-qWTg-1; Tue, 14 Nov 2023 00:30:09 -0500
X-MC-Unique: XPkRxR8yNeWgbhTgb-qWTg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5091368e043so5457420e87.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:30:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699939808; x=1700544608;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KYdz1LdDqXxrg73NymxfuIwXOLaJadgVCvKcNkIZIj8=;
 b=FKmzIdKorhbfk590ti2r/oNlkcDrSbZErTZq4ydYDwHefg4WL9oYX+jxGOKyPUIa0F
 LxOVFDTsgfLCQoq70gXFe90jrL9EPP7DPlwgD6ALSzPliuClB9feZR96jJeaiBy6kn23
 PcjPJRaFcszOekKhru8DXYvpSstAY9lJdKEW2dXUlQmAzM7v8CRK+i9Zahgj+VDMFQbD
 vKVHkhw6YfIs5l2NO854WnyJjxJxUj36QRo25YCDtFeikH4OyeNr8xJvFU80Wsg58I/F
 d/vGnBfxA5aasJC0GSLLuU/TxJeD9nm1AqJdFZOdLtILo2rV4SZ9acJzCKIHbArA4zd9
 DbBw==
X-Gm-Message-State: AOJu0YznfJSZx92OeZBYhejswABpFdce/gNM/6oPdAOv1o5fmzqZYvYR
 bquh2i3E6LIi7Rb6ld6u006TCeIQHuvqSwtVMYu1GVyMsSgItNdvose/Z4U2sKFI4i+2soND26r
 6Yd/FdUOL7FEaA3fvh5357q/jYqbyQCc=
X-Received: by 2002:ac2:511e:0:b0:508:1470:6168 with SMTP id
 q30-20020ac2511e000000b0050814706168mr5922315lfb.57.1699939808111; 
 Mon, 13 Nov 2023 21:30:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVzxMxMFRb/9BGu0XUCejJsg/lJk8N17qIa17Ji8ZsHjPqnEaNS9GtTK1pB5fVqnN+UCm2mLbSIvyvoP8kV/A=
X-Received: by 2002:ac2:511e:0:b0:508:1470:6168 with SMTP id
 q30-20020ac2511e000000b0050814706168mr5922308lfb.57.1699939807729; Mon, 13
 Nov 2023 21:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20230601031859.7115-1-akihiko.odaki@daynix.com>
 <a2cb6356-18b1-44d1-90a8-d137e8a25227@daynix.com>
In-Reply-To: <a2cb6356-18b1-44d1-90a8-d137e8a25227@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Nov 2023 13:29:55 +0800
Message-ID: <CACGkMEvyDitD-5d_mzK0LxjidcT7ZXfw_qzK_WbMPt6dd+McKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] net: Update MemReentrancyGuard for NIC
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mauro Matteo Cascella <mcascell@redhat.com>, P J P <pj.pandit@yahoo.co.in>,
 Alexander Bulekov <alxndr@bu.edu>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Thomas Huth <huth@tuxfamily.org>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, 
 Max Filippov <jcmvbkbc@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Greg Kurz <groug@kaod.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Sven Schnelle <svens@stackframe.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, 
 Paul Durrant <paul@xen.org>, Rob Herring <robh@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 21, 2023 at 3:16=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2023/06/01 12:18, Akihiko Odaki wrote:
> > Recently MemReentrancyGuard was added to DeviceState to record that the
> > device is engaging in I/O. The network device backend needs to update i=
t
> > when delivering a packet to a device.
> >
> > This implementation follows what bottom half does, but it does not add
> > a tracepoint for the case that the network device backend started
> > delivering a packet to a device which is already engaging in I/O. This
> > is because such reentrancy frequently happens for
> > qemu_flush_queued_packets() and is insignificant.
> >
> > This series consists of two patches. The first patch makes a bulk chang=
e to
> > add a new parameter to qemu_new_nic() and does not contain behavioral c=
hanges.
> > The second patch actually implements MemReentrancyGuard update.
> >
> > V1 -> V2: Added the 'Fixes: CVE-2023-3019' tag
> >
> > Akihiko Odaki (2):
> >    net: Provide MemReentrancyGuard * to qemu_new_nic()
> >    net: Update MemReentrancyGuard for NIC
> >
> >   include/net/net.h             |  2 ++
> >   hw/net/allwinner-sun8i-emac.c |  3 ++-
> >   hw/net/allwinner_emac.c       |  3 ++-
> >   hw/net/cadence_gem.c          |  3 ++-
> >   hw/net/dp8393x.c              |  3 ++-
> >   hw/net/e1000.c                |  3 ++-
> >   hw/net/e1000e.c               |  2 +-
> >   hw/net/eepro100.c             |  4 +++-
> >   hw/net/etraxfs_eth.c          |  3 ++-
> >   hw/net/fsl_etsec/etsec.c      |  3 ++-
> >   hw/net/ftgmac100.c            |  3 ++-
> >   hw/net/i82596.c               |  2 +-
> >   hw/net/igb.c                  |  2 +-
> >   hw/net/imx_fec.c              |  2 +-
> >   hw/net/lan9118.c              |  3 ++-
> >   hw/net/mcf_fec.c              |  3 ++-
> >   hw/net/mipsnet.c              |  3 ++-
> >   hw/net/msf2-emac.c            |  3 ++-
> >   hw/net/mv88w8618_eth.c        |  3 ++-
> >   hw/net/ne2000-isa.c           |  3 ++-
> >   hw/net/ne2000-pci.c           |  3 ++-
> >   hw/net/npcm7xx_emc.c          |  3 ++-
> >   hw/net/opencores_eth.c        |  3 ++-
> >   hw/net/pcnet.c                |  3 ++-
> >   hw/net/rocker/rocker_fp.c     |  4 ++--
> >   hw/net/rtl8139.c              |  3 ++-
> >   hw/net/smc91c111.c            |  3 ++-
> >   hw/net/spapr_llan.c           |  3 ++-
> >   hw/net/stellaris_enet.c       |  3 ++-
> >   hw/net/sungem.c               |  2 +-
> >   hw/net/sunhme.c               |  3 ++-
> >   hw/net/tulip.c                |  3 ++-
> >   hw/net/virtio-net.c           |  6 ++++--
> >   hw/net/vmxnet3.c              |  2 +-
> >   hw/net/xen_nic.c              |  4 ++--
> >   hw/net/xgmac.c                |  3 ++-
> >   hw/net/xilinx_axienet.c       |  3 ++-
> >   hw/net/xilinx_ethlite.c       |  3 ++-
> >   hw/usb/dev-network.c          |  3 ++-
> >   net/net.c                     | 15 +++++++++++++++
> >   40 files changed, 90 insertions(+), 41 deletions(-)
> >
>
> Hi Jason,
>
> Can you review this series?

For some reason it falls through the cracks.

I've queued this for rc1.

Thanks

>
> Regards,
> Akihiko Odaki
>


