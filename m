Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F58826197
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 22:08:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMDrd-0005Y9-56; Sat, 06 Jan 2024 16:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDrb-0005XN-7T; Sat, 06 Jan 2024 16:05:51 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDrY-00017w-Mz; Sat, 06 Jan 2024 16:05:50 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50e78f1f41fso589301e87.2; 
 Sat, 06 Jan 2024 13:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704575144; x=1705179944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CZ0Cdd6CyzfWhgOzDgqAtfWGGIPl4y3eiovJukLVLhQ=;
 b=k9h/Y8JKzeh0aUaUjEpAdyJvQBYGYRE7pGPYF6B/JeInkHZ1rW+aKdNMJPhR/tA7uu
 OHDTNyNf0h12YDpU2VB2ml+vBpjbKqXq1HZNOUnqUTeOleetpBpbNyJtdTxLSdvpTc8X
 BZ9PRWzGZwOf+AWCFtGTbkeoZf/B9kXqsSk75GZGRqEL4ZeG3jMM3c4hzyD8YrcDrBTR
 DIKzKADMGDWjF5rAz8DwD1dpzMiC4p2Mt/SrRXRPUOUSNCmuQWXiM1JnRvOylX+ghQ5P
 BkuQGa6GVT2lLDgmWWLcaHwwQxb73u9CmIJbtJG1Us+QLGWZQtOKJwUFdYFFBZrl1jof
 m3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704575144; x=1705179944;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CZ0Cdd6CyzfWhgOzDgqAtfWGGIPl4y3eiovJukLVLhQ=;
 b=An32I9gplFQH+z2w5ZzFx564//FudlBwYvzHnJlGnxW1Q+ZZxWAf+rvFHL8zOr1DVn
 uZmNwZApxkWTD29pg3qG0i8usvwzh+vo4pn6/o2jUgH+8vwQ+5MTXjQusOJw0Lkll1Jg
 Cpja+IVTOGQMao7ebR+au3s54ChvMhGXT6vNxPDsRdZ5Th3rm+i7IYSPzD+uVrKThMtu
 j1JwWKGBAUI0oiBbGPKNoLrM3HI+Ua7nkZxc+w8umCV9f+A9S+vYP1ZHVEKdox8WOmjE
 4AG3NSuaSYhDCQ7pAneEglFyWXcJB/JUlosdlqkM6eR/jIKJtD6F1Pe53KbQXBIuAUTd
 a0Rw==
X-Gm-Message-State: AOJu0Yz1hWikvRXs3bcf/i6Ppwv6x7xOHXuethhkS2TT6Hr/eVKHG2MK
 rXsMP4LZuI/0kwmwIHIusbJIB3BrhGM=
X-Google-Smtp-Source: AGHT+IFTI2kTG7RQXuBBONQ2rseDn9uHE+FPevqrWjkDuqlK2/iyV8Y4v4IJ9B60fqO2atrwpXEgKQ==
X-Received: by 2002:a05:6512:2347:b0:50e:74e9:69c9 with SMTP id
 p7-20020a056512234700b0050e74e969c9mr541556lfu.25.1704575144218; 
 Sat, 06 Jan 2024 13:05:44 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-174-094.77.11.pool.telefonica.de.
 [77.11.174.94]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056402195400b005576f4471besm624922edz.42.2024.01.06.13.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 13:05:43 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Peter Xu <peterx@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v4 00/11] hw/isa/vt82c686: Implement relocation and toggling
 of SuperI/O functions
Date: Sat,  6 Jan 2024 22:05:20 +0100
Message-ID: <20240106210531.140542-1-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x130.google.com
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
v4:=0D
* Drop incomplete SuperI/O vmstate handling (Zoltan)=0D
=0D
v3:=0D
* Rework various commit messages (Zoltan)=0D
* Drop patch "hw/char/serial: Free struct SerialState from MemoryRegion"=0D
  (Zoltan)=0D
* Generalize wording in migration.rst to include portio_list API (Zoltan)=0D
=0D
v2:=0D
* Improve commit messages (Zoltan)=0D
* Split pegasos2 from vt82c686 patch (Zoltan)=0D
* Avoid poking into device internals (Zoltan)=0D
=0D
Testing done:=0D
* `make check`=0D
* `make check-avocado`=0D
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
 docs/devel/migration.rst       |  6 ++--=0D
 hw/block/fdc-internal.h        |  4 ---=0D
 include/exec/ioport.h          |  4 ++-=0D
 include/hw/block/fdc.h         |  3 ++=0D
 include/hw/char/parallel-isa.h |  5 +++=0D
 include/hw/char/parallel.h     |  2 --=0D
 include/hw/char/serial.h       |  2 ++=0D
 hw/block/fdc-isa.c             | 18 +++++++++-=0D
 hw/block/fdc-sysbus.c          |  6 ++--=0D
 hw/char/parallel-isa.c         | 14 ++++++++=0D
 hw/char/parallel.c             |  2 +-=0D
 hw/char/serial-isa.c           | 14 ++++++++=0D
 hw/isa/vt82c686.c              | 66 ++++++++++++++++++++++++++++------=0D
 hw/ppc/pegasos2.c              | 15 ++++++++=0D
 system/ioport.c                | 41 +++++++++++++++++----=0D
 15 files changed, 172 insertions(+), 30 deletions(-)=0D
=0D
-- =0D
2.43.0=0D
=0D

