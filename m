Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D36D815FEA
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 15:43:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEsLL-0005Lx-Ub; Sun, 17 Dec 2023 09:42:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLI-0005Lg-Hn; Sun, 17 Dec 2023 09:42:08 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLG-0003J9-Iw; Sun, 17 Dec 2023 09:42:08 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-54c70c70952so2600241a12.3; 
 Sun, 17 Dec 2023 06:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702824123; x=1703428923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ImRdEJ2s1CPU/zja2PDSv05N4zE1GjmhfZzXX0+BJtA=;
 b=CtIFBOZ516E0NY+Zj8oBM/nQHmTtqOAd3VbhWzNI9ObeH6BtKgy2l4JNExUTgIn7s/
 3OGDMWjick0Kta8j41oWE5JSyclmO1lGhSW45z534RfPPQCPILa0gedZ9VsMKo2JsLSt
 LWcS6f3DUTVBxgRzwooGU9bkynZ2gc3Wcj3Kl9RI41sfaiETCTHn//XgIu2reNCmDIZ3
 SrGtrT1nv95HplL1b0JMGlnWs4NiH08jr6egsM7j2cHpGr8yWYpoKN1UfQKKxwmsjSTy
 eyhYZX3ufxdpSRg3xWeJjdO2kair43I+ubkNKmHxg+Rzz6tLNCNQ4zxAPW5H8XWt+edq
 U6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702824123; x=1703428923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ImRdEJ2s1CPU/zja2PDSv05N4zE1GjmhfZzXX0+BJtA=;
 b=b7U3+iQEno+mDQeeWoN07M4Mr4BFsylxnSVdyjAy/6CsuQMg4FcJoZrCrq0hWkijGu
 Tm1y5Jz5jljlouM71y6NYrsQI3+f0ofi/SJFtbnoNhGAKddsnD1aT1ZvZnJ8JM26vy++
 NWNuKsVACFnjRko5qb8Emzfo+EOtTYdQXWKV1CrvnOkaTev8DGJmkjHdiMgjh5dZpT1g
 dTPuoXFi5/kvJk4+I8m+WskiA7aAZ6Eu7T7Qmy9QTIY/zQRXUmmeLwtXjwhT3VEtbG5o
 Q5FMz9R+cXrAYi+dSrZ8nRJ/kSFkA/HortuPqHORrU9mIq+/M297QWSXvImmiZi71IYh
 ByIA==
X-Gm-Message-State: AOJu0Yy8AXXbA5ZH4lJIWOM3KVfuj7mBK29YucACoOlh8csXu2m8W3Xp
 FcDNq2kbiqPFiPHmInJ3Lo+Z2sy/qxo=
X-Google-Smtp-Source: AGHT+IH+QUQfDdlRexe23+jgS8M62pxCiSHHNFSL4w3tCx45xctLo2lt+LHLmCojQPybR27qQ18Shw==
X-Received: by 2002:a17:906:c44b:b0:a19:720c:ed71 with SMTP id
 ck11-20020a170906c44b00b00a19720ced71mr4508604ejb.58.1702824122862; 
 Sun, 17 Dec 2023 06:42:02 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-162-117.77.11.pool.telefonica.de.
 [77.11.162.117]) by smtp.gmail.com with ESMTPSA id
 vv6-20020a170907a68600b00a1dff479037sm12996632ejc.127.2023.12.17.06.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 06:42:02 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 00/12] hw/isa/vt82c686: Implement relocation and toggling of
 SuperI/O functions
Date: Sun, 17 Dec 2023 15:41:36 +0100
Message-ID: <20231217144148.15511-1-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
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

This series implements relocation of the SuperI/O functions of the VIA sout=
h=0D
bridges which resolves some FIXME's. It is part of my via-apollo-pro-133t=0D
branch [1] which is an extension of bringing the VIA south bridges to the P=
C=0D
machine [2]. This branch is able to run some real-world X86 BIOSes in the h=
ope=0D
that it allows us to form a better understanding of the real vt82c686b devi=
ces.=0D
Implementing relocation and toggling of the SuperI/O functions is one step =
to=0D
make these BIOSes run without error messages, so here we go.=0D
=0D
The series is structured as follows: Patches 1-8 export the device structs =
of=0D
the ISA serial and FDC devices. This is used later in the series to access =
the=0D
I/O regions for relocation and toggling. As part of the exposal the MAINTAI=
NERS=0D
file gets a fix for the serial headers.=0D
=0D
Inspired by the memory API patches 9-11 add two convenience functions to th=
e=0D
portio_list API to toggle and relocate portio lists. Patch 9 is a preparati=
on=0D
for that which removes some redundancies which otherwise had to be dealt wi=
th=0D
during relocation.=0D
=0D
Patch 12 finally implements the main feature which required adaption of the=
=0D
pegasos2 sources, otherwise the machine wouldn't boot when given no bios.=0D
=0D
Testing done:=0D
* make check=0D
* make check-avocado=0D
* Run MorphOS on pegasos2 with and without pegasos2.rom=0D
* Run Linux on amigaone=0D
* Run real-world BIOSes on via-apollo-pro-133t branch=0D
* Start rescue-yl on fuloong2e=0D
=0D
[1] https://github.com/shentok/qemu/tree/via-apollo-pro-133t=0D
[2] https://github.com/shentok/qemu/tree/pc-via=0D
=0D
Bernhard Beschow (12):=0D
  hw: Remove unused includes of hw/block/fdc.h=0D
  hw/i386/pc: No need to include hw/block/fdc.h in header=0D
  hw/block/fdc-isa: Rename header to match source file=0D
  hw/block/fdc: Expose internal header=0D
  hw/block/fdc: Move constant #define to where it is imposed=0D
  hw/block/fdc-isa: Expose struct FDCtrlISABus=0D
  MAINTAINERS: Add include/hw/char/serial*.h to the "PC Chipset" section=0D
  hw/char/serial-isa: Export struct ISASerialState=0D
  exec/ioport: Resolve redundant .base attribute in struct=0D
    MemoryRegionPortio=0D
  exec/ioport: Add portio_list_set_address()=0D
  exec/ioport: Add portio_list_set_enabled()=0D
  hw/isa/vt82c686: Implement relocation of SuperI/O functions=0D
=0D
 MAINTAINERS                  |   3 +-=0D
 docs/devel/migration.rst     |   2 +=0D
 hw/block/fdc-internal.h      | 158 ----------------------------------=0D
 include/exec/ioport.h        |   4 +-=0D
 include/hw/block/fdc-isa.h   |  32 +++++++=0D
 include/hw/block/fdc.h       | 161 ++++++++++++++++++++++++++++++++---=0D
 include/hw/char/serial-isa.h |  50 +++++++++++=0D
 include/hw/char/serial.h     |   7 --=0D
 include/hw/i386/pc.h         |   1 -=0D
 hw/block/fdc-isa.c           |  19 +----=0D
 hw/block/fdc-sysbus.c        |   2 +-=0D
 hw/block/fdc.c               |   3 +-=0D
 hw/char/serial-isa.c         |  14 +--=0D
 hw/i386/microvm-dt.c         |   2 +-=0D
 hw/i386/microvm.c            |   2 +-=0D
 hw/i386/pc.c                 |   4 +-=0D
 hw/isa/isa-superio.c         |   3 +-=0D
 hw/isa/vt82c686.c            | 140 +++++++++++++++++++++++-------=0D
 hw/m68k/next-cube.c          |   1 -=0D
 hw/mips/jazz.c               |   1 +=0D
 hw/ppc/pegasos2.c            |  15 ++++=0D
 hw/ppc/pnv.c                 |   2 +-=0D
 hw/ppc/prep.c                |   1 -=0D
 hw/sparc/sun4m.c             |   2 +-=0D
 hw/sparc64/sun4u.c           |   2 +=0D
 stubs/cmos.c                 |   2 +-=0D
 system/ioport.c              |  41 +++++++--=0D
 27 files changed, 414 insertions(+), 260 deletions(-)=0D
 delete mode 100644 hw/block/fdc-internal.h=0D
 create mode 100644 include/hw/block/fdc-isa.h=0D
 create mode 100644 include/hw/char/serial-isa.h=0D
=0D
-- =0D
2.43.0=0D
=0D

