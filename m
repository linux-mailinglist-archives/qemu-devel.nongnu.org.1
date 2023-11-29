Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A557E7FD00C
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 08:42:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8FBf-0008C6-SV; Wed, 29 Nov 2023 02:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1r8FBd-0008Ai-07
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 02:40:46 -0500
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1r8FBZ-0006lB-47
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 02:40:44 -0500
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7c47dd348f2so1738429241.2
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 23:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701243636; x=1701848436; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REVTlpB9wNK4CxbkzyEwSzpUySSOw51TAL422QDKWRU=;
 b=XRbhAx1nK3h0XhR21X5tny4edSdKCmp7qkF5mUoDVzlwg818IFOZbl3FUhc+Gregqw
 6NR/VP0TMkz28qx3lHYVPrixseOSina0cI/OcayGMZXtoARMrtPNRQIj8QDQXsEyhV8t
 Xfx5XBiqn2wxWpdN9ljZX1cDx+RIGZ2B8qqmTfUt3/dwPv3sezwWq+b0KV6114asxryS
 q48PCA/xLLopN46DBntC3in5okktQeg9PM+vPaBf6xcADT4JrPL7aSz1NaxBKdMWVth2
 4mRq9fbp25cPeHTzIzmUdiFbta2D6BJy79DcWG5IsGu1A4i/se1QLEeWPOAjaav9QGt7
 rmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701243636; x=1701848436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REVTlpB9wNK4CxbkzyEwSzpUySSOw51TAL422QDKWRU=;
 b=eQRzvxpUao7cV6oOfXJhNkDl+QtQaZvIWMdFgS9aIIqGR9vdCQQMUhJ72GzhDox26P
 Tjiofbac0iZAPsoXgkKmZhAhaN8k+H0Fq2HCBP/5nUPDZSKsGXMkqrgsAT1sZt7A5x1K
 cZdhLGTRHhymSilAOfrinXy4r/0kKoZFq7+pibceVAC7saJazXnDHozNZtUECnOZjVI2
 CmbRgo5lSeglJoCjSwk1EjS09LxiO/Uw0kjTU5EhzugOBr/x1OAF6jjGQHWDy+oo5XpX
 OJdLFTxgzwJEPb5ab2ZfsNVyWWdhflWs22kK8HPnUXZQNlrsVbyEdjF/Btj8VqSYz4fO
 h8QQ==
X-Gm-Message-State: AOJu0YwBuCN4reOfZWGSisFB1B4C5fgjtejJpzqsCZ0AGXzbZdhozPrq
 otjMG6mo652uRRjXs9A3DL+RDOj7jOQEYhiXN4U=
X-Google-Smtp-Source: AGHT+IHi4kJ3b1pcvGqU6/bYbY3zW3oIK3SMM8iJKZi5XR6X/fXPnMOA5oO2AgjPPLoCS7Sh9VZVJQbj/4xdguK3cLY=
X-Received: by 2002:a05:6102:558b:b0:462:e85b:b812 with SMTP id
 dc11-20020a056102558b00b00462e85bb812mr16650941vsb.24.1701243635858; Tue, 28
 Nov 2023 23:40:35 -0800 (PST)
MIME-Version: 1.0
References: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
 <20231128023052-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231128023052-mutt-send-email-mst@kernel.org>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Wed, 29 Nov 2023 16:40:24 +0900
Message-ID: <CAB=+i9Q7Px=6e6cvUmg2MZadCAYndqo2d4JnBZR6GzFMqrghww@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] A Fixup for "QEMU: CXL mailbox rework and features
 (Part 1)"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 linux-cxl@lore.kernel.org, qemu-devel@nongnu.org, 
 Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=42.hyeyoo@gmail.com; helo=mail-ua1-x930.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Nov 28, 2023 at 4:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Nov 27, 2023 at 07:58:28PM +0900, Hyeonggon Yoo wrote:
> > Hi, this is a fixup for the recent patch series "QEMU: CXL mailbox rewo=
rk and
> > features (Part 1)" [1].
>
>
> To clarify do you plan v2 of this?

Yes, I will send v2. Thanks for asking!

> > This fixes two problems:
> >
> >    1. Media Status in memory device status register not being correctly
> >       read as "Disabled" while sanitation is in progress.
> >
> >    2. QEMU assertion failure when it issues an MSI-X interrupt
> >       (indicating the completion of the sanitize command).
> >
> > [1] https://lore.kernel.org/linux-cxl/20231023160806.13206-1-Jonathan.C=
ameron@huawei.com
> >
> > Hyeonggon Yoo (2):
> >   hw/cxl/device: read from register values in mdev_reg_read()
> >   hw/mem/cxl_type3: allocate more vectors for MSI-X
> >
> >  hw/cxl/cxl-device-utils.c   | 17 +++++++++++------
> >  hw/mem/cxl_type3.c          |  2 +-
> >  include/hw/cxl/cxl_device.h |  4 +++-
> >  3 files changed, 15 insertions(+), 8 deletions(-)
> >
> > --
> > 2.39.1
>

