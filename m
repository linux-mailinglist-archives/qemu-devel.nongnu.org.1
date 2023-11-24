Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 174C97F71B6
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 11:40:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6TbS-00080Y-Oj; Fri, 24 Nov 2023 05:40:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6TbQ-000806-R3; Fri, 24 Nov 2023 05:40:04 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r6TbO-0004Bn-W8; Fri, 24 Nov 2023 05:40:04 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cfa9203c14so1347355ad.3; 
 Fri, 24 Nov 2023 02:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700822401; x=1701427201; darn=nongnu.org;
 h=in-reply-to:references:message-id:to:from:subject:cc:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mT4E0yx9p7rccLCA3kxOmHodeuMBWc8P4sYPg1i3/24=;
 b=S39HU/ZpyMRAtuKzAtEI5zFTdiqKGnSlxYom+yv2t9vB4Ig6RAtmsU285WxViEo+vP
 dZ/fNpoaCyxDxl8/whwvk7C5n8umkr2VirKJ5rU+6yPEsyZ3od0uNagJasK3WNIxYY31
 UAcei+XN4SzN1OZVcNLnuGK9gzmqt6UuEKp1ZEQbDafPmanrM61zGhfCJjrT8m8PGeFx
 9iJQLrkBW7+nNbqPPQ6O+Se8A0Y4AA3PeBD9cKm9NeMmQxkRLmZiLsaXpjTv6eVshTYp
 TZKPvvar/9JXAskE1iKuuAR6cuFhH0oqYgKlrrfvQwKQQtVHcJ7BYRuMdVKwwE5CDPV0
 H93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700822401; x=1701427201;
 h=in-reply-to:references:message-id:to:from:subject:cc:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mT4E0yx9p7rccLCA3kxOmHodeuMBWc8P4sYPg1i3/24=;
 b=t5GzypN+3Egr7DeMlhu6RdFHrMHu2RQGTKRJ+PAMyH6uvtVNSTZfcFeh+br//pjGWo
 /rFQ3wx4f2YjTpqfYUvu34A7mXUa1j5I/51c7o9afkD4+qyNpVL7pJTVjtMiC1zNX1Hb
 0ycMQNTfmRu0+isE7zYlFcel6+BcisWadKv3oTLEXPMIUyg1syuPRNaQOeNR6Wk7meAw
 fprkolppkJfWH1a/1ErM1f6Lntl4r7gkUU5QtUzbwr495npRkI6l2zx9mVhX4fjwnTjO
 ceEOyuvWRDBOmydTIJppuA8VQBwJS6e0Z34xez/tQKJDxxpqviB2A7NmnFrSPOYKjwUz
 DVLw==
X-Gm-Message-State: AOJu0YxVXHRaizOKW1n6BkxPO9TRN3b4OnbRqt2wd5dOME8z/tl9h/6B
 kscyPvyt6cf7Ex1Hv5lyECo=
X-Google-Smtp-Source: AGHT+IHs7mk7jP2Oo4p9KPq2wkOqpsZNzuODw2fKjqH49qhd2QNTzOOHTSBbTZ8CiPgw/ud9oV+9eQ==
X-Received: by 2002:a17:902:c950:b0:1cc:345b:c7e1 with SMTP id
 i16-20020a170902c95000b001cc345bc7e1mr2712097pla.60.1700822401098; 
 Fri, 24 Nov 2023 02:40:01 -0800 (PST)
Received: from localhost (121-44-66-27.tpgi.com.au. [121.44.66.27])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a170902d31500b001bc930d4517sm2865565plc.42.2023.11.24.02.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 02:40:00 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Nov 2023 20:39:54 +1000
Cc: =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>
Subject: Re: [PATCH v5 0/9] Add powernv10 I2C devices and tests
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Glenn Miles"
 <milesg@linux.vnet.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>, "Andrew Jeffery" <andrew@codeconstruct.com.au>
Message-Id: <CX6Z7AI6T2YY.CMHUGU3CYCJE@wheely>
X-Mailer: aerc 0.15.2
References: <20231121190945.3140221-1-milesg@linux.vnet.ibm.com>
 <ff4eb381-4b9f-431f-ba79-68afa8c75859@kaod.org>
In-Reply-To: <ff4eb381-4b9f-431f-ba79-68afa8c75859@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Nov 24, 2023 at 6:36 PM AEST, C=C3=A9dric Le Goater wrote:
> On 11/21/23 20:09, Glenn Miles wrote:
> > This series of patches includes support, tests and fixes for
> > adding PCA9552 and PCA9554 I2C devices to the powernv10 chip.
> >=20
> > The PCA9552 device is used for PCIe slot hotplug power control
> > and monitoring, while the PCA9554 device is used for presence
> > detection of IBM CableCard devices.  Both devices are required
> > by the Power Hypervisor Firmware on the Power10 Ranier platform.
> >=20
> > Changes from previous version:
> >    - Removed two already merged patches
> >    - Various formatting changes
> >    - Capitalized "Rainier" in machine description string
> >    - Changed powernv10-rainier parent to MACHINE_TYPE_NAME("powernv10")
>
>
> Nick,
>
> could this series go through the ppc-next queue ?

Sure, for after 8.2. I'll start gathering up patches and push out
a test tree before then.

Are patches 1/2 okay with that? Patch 1 looks a bit like a bug
fix...

Thanks,
Nick

>
>
> Thanks,
>
> C.
>
>
>
>
> >=20
> > Glenn Miles (9):
> >    misc/pca9552: Fix inverted input status
> >    misc/pca9552: Let external devices set pca9552 inputs
> >    ppc/pnv: New powernv10-rainier machine type
> >    ppc/pnv: Add pca9552 to powernv10-rainier for PCIe hotplug power
> >      control
> >    ppc/pnv: Wire up pca9552 GPIO pins for PCIe hotplug power control
> >    ppc/pnv: Use resettable interface to reset child I2C buses
> >    misc: Add a pca9554 GPIO device model
> >    ppc/pnv: Add a pca9554 I2C device to powernv10-rainier
> >    ppc/pnv: Test pnv i2c master and connected devices
> >=20
> >   MAINTAINERS                     |  10 +-
> >   hw/misc/Kconfig                 |   4 +
> >   hw/misc/meson.build             |   1 +
> >   hw/misc/pca9552.c               |  58 ++-
> >   hw/misc/pca9554.c               | 328 ++++++++++++++++
> >   hw/ppc/Kconfig                  |   2 +
> >   hw/ppc/pnv.c                    |  72 +++-
> >   hw/ppc/pnv_i2c.c                |  15 +-
> >   include/hw/misc/pca9552.h       |   3 +-
> >   include/hw/misc/pca9554.h       |  36 ++
> >   include/hw/misc/pca9554_regs.h  |  19 +
> >   include/hw/ppc/pnv.h            |   1 +
> >   tests/qtest/meson.build         |   1 +
> >   tests/qtest/pca9552-test.c      |   6 +-
> >   tests/qtest/pnv-host-i2c-test.c | 650 +++++++++++++++++++++++++++++++=
+
> >   15 files changed, 1190 insertions(+), 16 deletions(-)
> >   create mode 100644 hw/misc/pca9554.c
> >   create mode 100644 include/hw/misc/pca9554.h
> >   create mode 100644 include/hw/misc/pca9554_regs.h
> >   create mode 100644 tests/qtest/pnv-host-i2c-test.c
> >=20


