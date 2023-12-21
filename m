Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2D281BA42
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:10:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGKf2-0008H3-01; Thu, 21 Dec 2023 10:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKel-00089L-71; Thu, 21 Dec 2023 10:08:15 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKea-0004I4-0v; Thu, 21 Dec 2023 10:08:13 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-553729ee917so1044326a12.1; 
 Thu, 21 Dec 2023 07:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703171281; x=1703776081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MWGJZ0Gsl+PYUoTMm4hN3Tlx09gBayWoo98VZLx9eew=;
 b=hxXMYZB4TMNw820KAnqs8clXAKu5RtsjTnJkb74KMu5P94uPMC/2qb3I5bu38rQm1+
 G2Lwo+AOQhZ/sGfIfwcVXOxeHKQcXmJdHSVjYJrgdl3oD2dvl107LOTt7oukdI8RUJu/
 K4lf6hUZ0l1oZ5CdwCby6mq2HFTSm5wTjcdm0XT/OREliL6fQphEdSqVE/HcqotDjGWk
 t6Bkeoue9wmycqEtVPe1DQRecw/PkMaZxCBMIborkcWHNr2+x3dImAaciksmn52SWYgq
 mvHrGHAMChsBaH3WN4hu60MJ/1OJdKs3/FIc+j9CjcJcU/jmIMX5c8MIww/dqE7QK3JF
 1JtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171281; x=1703776081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MWGJZ0Gsl+PYUoTMm4hN3Tlx09gBayWoo98VZLx9eew=;
 b=xFzCAGgj3h35bOd0HE6gOEvPIDZ1Y0Mx8nx4FG9C5U67hYVoUaCOZaKsxte3LOggqE
 jhoWl6vp+MF7VFSxpZ9Dy5IY1/yerjB+cuvkLl1eMLA7p8Z/2CxAWKRZBOQVw619/jZT
 wtd1CXQ5g1ge+Gx4m2EEIeOM9UUXBky0klIo4c41fSfTR6uA61n2aUXO/DPPi3m2nZ6T
 kEPpvR41z/C3Wz/W0d1HD2iMLo92QImRFJpB1GNHcaf4KK6cEssH/eTV4qVGbOPndSp2
 YDNvt9deRQPTuRC//S6rzmhryx7VQnXycsx1S9ALQhVqSq9v6KSN02ILi8aLp731GzhR
 OuHg==
X-Gm-Message-State: AOJu0YxSQoNhOSKPlR3Pu6w6NvsSWjWx82mSCHaiv/nM0aGw/Q3l3LVn
 yyEN4Bze2k1Oiwtg0K8y3JId6J7SGjg=
X-Google-Smtp-Source: AGHT+IHRBMBufEku5BHMb1lY3bU9Xh+3rohcmaTON3R8ykmyf7polaItQmpBPgtXLHvdoUzij57QYA==
X-Received: by 2002:a50:8dc5:0:b0:54c:f1cd:1a9 with SMTP id
 s5-20020a508dc5000000b0054cf1cd01a9mr11205051edh.39.1703171280768; 
 Thu, 21 Dec 2023 07:08:00 -0800 (PST)
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a056402241900b00553b6b5bb44sm1264264eda.67.2023.12.21.07.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 07:08:00 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Sergio Lopez <slp@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Hildenbrand <david@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 00/11] hw/isa/vt82c686: Implement relocation and toggling
 of SuperI/O functions
Date: Thu, 21 Dec 2023 16:07:39 +0100
Message-ID: <20231221150750.5435-1-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
The series is structured as follows: Patches 1-3 prepare the TYPE_ISA_FDC,=
=0D
TYPE_ISA_PARALLEL and TYPE_ISA_SERIAL to relocate and toggle (enable/disabl=
e)=0D
themselves without breaking encapsulation of their respective device states=
.=0D
This is achieved by moving the MemoryRegions and PortioLists from the devic=
e=0D
states into the encapsulating ISA devices since they will be relocated and=
=0D
toggled.=0D
=0D
Inspired by the memory API patches 4-6 add two convenience functions to the=
=0D
portio_list API to toggle and relocate portio lists. Patch 5 is a preparati=
on=0D
for that which removes some redundancies which otherwise had to be dealt wi=
th=0D
during relocation.=0D
=0D
Patches 7-9 implement toggling and relocation for types TYPE_ISA_FDC,=0D
TYPE_ISA_PARALLEL and TYPE_ISA_SERIAL. Patch 10 prepares the pegasos2 machi=
ne=0D
which would end up with all SuperI/O functions disabled if no -bios argumen=
t is=0D
given. Patch 11 finally implements the main feature which now relies on=0D
firmware to configure the SuperI/O functions accordingly (except for pegaso=
s2).=0D
=0D
v3:=0D
* Rework various commit messages (Zoltan)=0D
* Drop patch "hw/char/serial: Free struct SerialState from MemoryRegion"=0D
  (Zoltan)=0D
* Generalize wording in migration.rst to include portio_list API (Zoltan)=0D
=0D
v2:=0D
* Improve commit message (Zoltan)=0D
* Split pegasos2 from vt82c686 patch (Zoltan)=0D
* Avoid poking into device internals (Zoltan)=0D
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
Bernhard Beschow (11):=0D
  hw/block/fdc-isa: Move portio_list from FDCtrl to FDCtrlISABus=0D
  hw/block/fdc-sysbus: Move iomem from FDCtrl to FDCtrlSysBus=0D
  hw/char/parallel: Move portio_list from ParallelState to=0D
    ISAParallelState=0D
  exec/ioport: Resolve redundant .base attribute in struct=0D
    MemoryRegionPortio=0D
  exec/ioport: Add portio_list_set_address()=0D
  exec/ioport: Add portio_list_set_enabled()=0D
  hw/block/fdc-isa: Implement relocation and enabling/disabling for=0D
    TYPE_ISA_FDC=0D
  hw/char/serial-isa: Implement relocation and enabling/disabling for=0D
    TYPE_ISA_SERIAL=0D
  hw/char/parallel-isa: Implement relocation and enabling/disabling for=0D
    TYPE_ISA_PARALLEL=0D
  hw/ppc/pegasos2: Let pegasos2 machine configure SuperI/O functions=0D
  hw/isa/vt82c686: Implement relocation and toggling of SuperI/O=0D
    functions=0D
=0D
 docs/devel/migration.rst       |   6 +-=0D
 hw/block/fdc-internal.h        |   4 --=0D
 include/exec/ioport.h          |   4 +-=0D
 include/hw/block/fdc.h         |   3 +=0D
 include/hw/char/parallel-isa.h |   5 ++=0D
 include/hw/char/parallel.h     |   2 -=0D
 include/hw/char/serial.h       |   2 +=0D
 hw/block/fdc-isa.c             |  18 +++++-=0D
 hw/block/fdc-sysbus.c          |   6 +-=0D
 hw/char/parallel-isa.c         |  14 ++++=0D
 hw/char/parallel.c             |   2 +-=0D
 hw/char/serial-isa.c           |  14 ++++=0D
 hw/isa/vt82c686.c              | 115 ++++++++++++++++++++++++---------=0D
 hw/ppc/pegasos2.c              |  15 +++++=0D
 system/ioport.c                |  41 ++++++++++--=0D
 15 files changed, 200 insertions(+), 51 deletions(-)=0D
=0D
-- =0D
2.43.0=0D
=0D

