Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A161F85B63D
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Feb 2024 09:57:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLuL-0005kt-0A; Tue, 20 Feb 2024 03:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcLuG-0005Nm-O0
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:55:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcLuE-0000BY-E1
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708419313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dYif9xIO2mh9ywAuepSn2/3QtxzSuxc/VMCW42YOAMQ=;
 b=W4spvVwQELo81KEQZCt69/xYnZeaLGORdfcWVWO815ySCngf+lf3haNJ+OjJuVj4+Qt+EW
 apyEO8YvzVTN4nZOSSxushydgAar0UnVt52M2ljuvNVriieLDGRTMlJag31skV0NnalaFS
 Y8mQJfFYoMxTUWo0fs6GXJiL13vGVh8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-zqKdoZhLM42Shd5zM_K45Q-1; Tue, 20 Feb 2024 03:55:09 -0500
X-MC-Unique: zqKdoZhLM42Shd5zM_K45Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F4B910201E9;
 Tue, 20 Feb 2024 08:55:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F6AD492BE3;
 Tue, 20 Feb 2024 08:55:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: John Snow <jsnow@redhat.com>,
	qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH v2 0/7] hw/ide: Clean up hw/ide/qdev.c and
 include/hw/ide/internal.h
Date: Tue, 20 Feb 2024 09:54:58 +0100
Message-ID: <20240220085505.30255-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

While trying to make it possible to compile-out the CompactFlash IDE device
in downstream distributions (first patch), we noticed that there are more
things in the IDE code that could use a proper clean up:

First, hw/ide/qdev.c is quite a mix between IDE BUS specific functions
and (disk) device specific functions. Thus the second patch splits qdev.c
into two new separate files to make it more obvious which part belongs
to which kind of devices.

The remaining patches unentangle include/hw/ide/internal.h, which is meant
as a header that should only be used internally to the IDE subsystem, but
which is currently exposed to the world since include/hw/ide/pci.h includes
this header, too. Thus we move the definitions that are also required for
non-IDE code to other new header files, so we can finally change pci.h to
stop including internal.h. After these changes, internal.h is only included
by files in hw/ide/ as it should be.

v2:
- Change the order of the DMA patch and move typedef struct IDEDMAOps
  and typedef struct IDEDMA IDEDMA into ide-dma.h, too
- Make sure that the headers are self-contained (i.e. #include the
  right other headers)
- Remove some more remnants of include/hw/ide.h

Thomas Huth (7):
  hw/ide: Add the possibility to disable the CompactFlash device in the
    build
  hw/ide: Split qdev.c into ide-bus.c and ide-dev.c
  hw/ide: Move IDE DMA related definitions to a separate header
    ide-dma.h
  hw/ide: Move IDE device related definitions to ide-dev.h
  hw/ide: Move IDE bus related definitions to a new header ide-bus.h
  hw/ide: Remove the include/hw/ide.h legacy file
  hw/ide: Stop exposing internal.h to non-IDE files

 MAINTAINERS                  |   1 -
 include/hw/ide.h             |   9 --
 include/hw/ide/ide-bus.h     |  42 +++++++
 include/hw/ide/ide-dev.h     | 184 ++++++++++++++++++++++++++++++
 include/hw/ide/ide-dma.h     |  37 ++++++
 include/hw/ide/internal.h    | 211 +----------------------------------
 include/hw/ide/pci.h         |   2 +-
 hw/i386/pc.c                 |   2 +-
 hw/ide/cf.c                  |  58 ++++++++++
 hw/ide/cmd646.c              |   1 +
 hw/ide/ide-bus.c             | 111 ++++++++++++++++++
 hw/ide/{qdev.c => ide-dev.c} | 137 +----------------------
 hw/ide/pci.c                 |   1 +
 hw/ide/piix.c                |   1 +
 hw/ide/sii3112.c             |   1 +
 hw/ide/via.c                 |   1 +
 hw/arm/Kconfig               |   2 +
 hw/ide/Kconfig               |  32 ++++--
 hw/ide/meson.build           |   4 +-
 19 files changed, 470 insertions(+), 367 deletions(-)
 delete mode 100644 include/hw/ide.h
 create mode 100644 include/hw/ide/ide-bus.h
 create mode 100644 include/hw/ide/ide-dev.h
 create mode 100644 include/hw/ide/ide-dma.h
 create mode 100644 hw/ide/cf.c
 create mode 100644 hw/ide/ide-bus.c
 rename hw/ide/{qdev.c => ide-dev.c} (67%)

-- 
2.43.2


