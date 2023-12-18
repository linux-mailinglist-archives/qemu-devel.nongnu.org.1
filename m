Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7475817A19
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:52:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIiC-00066n-OU; Mon, 18 Dec 2023 13:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIi8-00065L-Km; Mon, 18 Dec 2023 13:51:28 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIi6-0008OD-T0; Mon, 18 Dec 2023 13:51:28 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c339d2b88so39001705e9.3; 
 Mon, 18 Dec 2023 10:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702925483; x=1703530283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PGfR2rUZQH8rvHFF8hE4gA3EaA+C8KFkhf4byw46hXo=;
 b=SSEfTfZiDT0CbzKZeaFR3xxwaessTisF+RWnYOGza41BKDi0liCz9Wk2sKxXL0xalp
 ry0FHOPZsmw7tE6CLaTbs2XgiuFe11eWrILzfqtVuOQAsFLGExoU48ufzCC/xf7xb0up
 xkDL6TYUzviRB1t877D57EuS8DbXXmLe8KPUih5fltWx90wEkY/tEmuUDFE4uFQOwJm8
 b4fOLmLbgEfLBGA1YwdWYwJGkoSb6ifPzrHn6Ehx7NDkhk7Dmy7ssvimldRp+ZtSmazx
 AalD9emhUUQw0gpMZiuW+VklbDyB0B/GvPuqbOm0B7u6UIROSRJ8zSOXn9vKUW+R8HfJ
 xgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702925483; x=1703530283;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PGfR2rUZQH8rvHFF8hE4gA3EaA+C8KFkhf4byw46hXo=;
 b=MeJjTuiOlLhjHEBRjmr8dGA6c198OweAhS+TL2onBUavmy8trFo1jP97N1fz/Oge7T
 nKKMmirSlwyBTLjXHFZYBmY3fVfeiuUAY2k+ZW95cd4mU/z5YwHJlxyHWiPosseIcmjc
 8BWYR6d4pwZPi3X1Eb2vO8myhfIP3cqx5USGd5N0JAWL1+zRNUO7WKEHvFZkMP4FA9a/
 QBva6mWZG2DcL/36muA4cZDYKtrsSAlbAevdWbglvz5kG8faROZlZhcTjIRlpHPHOQbB
 aUn/dOPPYxcibmhg5r9ZGU9kVo9P8pHqE9h98q2EVYhAAG3/Y1txgIg9yOnC2X7tMh2o
 KX6w==
X-Gm-Message-State: AOJu0Yy93Vbr/Ux4xPVnJCMmyfNGVl20CuJX3ZFpGKS32nGgYrxxVyJd
 eCQRJfwelZhwoGJigwmqh6XWveSugd4=
X-Google-Smtp-Source: AGHT+IHQdd9GtpVjZUBd1dqT7C7WYxxXVGEJjULPWK8SGJN44VeBydO/ZtENahg3kcTpeOzH6iC2Vw==
X-Received: by 2002:a05:600c:3b06:b0:40b:2a15:9b30 with SMTP id
 m6-20020a05600c3b0600b0040b2a159b30mr8576755wms.1.1702925482671; 
 Mon, 18 Dec 2023 10:51:22 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-092-224-039-156.92.224.pool.telefonica.de. [92.224.39.156])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c45c700b0040c45071c18sm35134091wmo.39.2023.12.18.10.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:51:22 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 00/12] hw/isa/vt82c686: Implement relocation and toggling
 of SuperI/O functions
Date: Mon, 18 Dec 2023 19:51:02 +0100
Message-ID: <20231218185114.119736-1-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
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
The series is structured as follows: Patches 1-4 prepare the TYPE_ISA_FDC,=
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
Inspired by the memory API patches 5-7 add two convenience functions to the=
=0D
portio_list API to toggle and relocate portio lists. Patch 5 is a preparati=
on=0D
for that which removes some redundancies which otherwise had to be dealt wi=
th=0D
during relocation.=0D
=0D
Patches 8-10 implement toggling and relocation for types TYPE_ISA_FDC,=0D
TYPE_ISA_PARALLEL and TYPE_ISA_SERIAL. Patch 11 prepares the pegasos2 machi=
ne=0D
which would end up with all SuperI/O functions disabled if no -bios argumen=
t is=0D
given. Patch 12 finally implements the main feature which now relies on=0D
firmware to configure the SuperI/O functions accordingly (except for pegaso=
s2).=0D
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
Bernhard Beschow (12):=0D
  hw/block/fdc-isa: Free struct FDCtrl from PortioList=0D
  hw/block/fdc-sysbus: Free struct FDCtrl from MemoryRegion=0D
  hw/char/serial: Free struct SerialState from MemoryRegion=0D
  hw/char/parallel: Free struct ParallelState from PortioList=0D
  exec/ioport: Resolve redundant .base attribute in struct=0D
    MemoryRegionPortio=0D
  exec/ioport: Add portio_list_set_address()=0D
  exec/ioport: Add portio_list_set_enabled()=0D
  hw/block/fdc-isa: Implement relocation and toggling for TYPE_ISA_FDC=0D
  hw/char/serial-isa: Implement relocation and toggling for=0D
    TYPE_ISA_SERIAL=0D
  hw/char/parallel-isa: Implement relocation and toggling for=0D
    TYPE_ISA_PARALLEL=0D
  hw/ppc/pegasos2: Let pegasos2 machine configure SuperI/O functions=0D
  hw/isa/vt82c686: Implement relocation and toggling of SuperI/O=0D
    functions=0D
=0D
 docs/devel/migration.rst       |   2 +=0D
 hw/block/fdc-internal.h        |   4 --=0D
 include/exec/ioport.h          |   4 +-=0D
 include/hw/block/fdc.h         |   3 +=0D
 include/hw/char/parallel-isa.h |   5 ++=0D
 include/hw/char/parallel.h     |   2 -=0D
 include/hw/char/serial.h       |   4 +-=0D
 hw/block/fdc-isa.c             |  18 ++++-=0D
 hw/block/fdc-sysbus.c          |   6 +-=0D
 hw/char/parallel-isa.c         |  14 ++++=0D
 hw/char/parallel.c             |   2 +-=0D
 hw/char/serial-isa.c           |  21 +++++-=0D
 hw/char/serial-pci-multi.c     |   7 +-=0D
 hw/char/serial-pci.c           |   7 +-=0D
 hw/char/serial.c               |   4 +-=0D
 hw/isa/vt82c686.c              | 121 ++++++++++++++++++++++++---------=0D
 hw/ppc/pegasos2.c              |  15 ++++=0D
 system/ioport.c                |  41 +++++++++--=0D
 18 files changed, 221 insertions(+), 59 deletions(-)=0D
=0D
-- =0D
2.43.0=0D
=0D

