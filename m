Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2ED810EEF
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 11:52:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDMpF-0004uz-2i; Wed, 13 Dec 2023 05:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rDMp2-0004q7-9W
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 05:50:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rDMoy-0003zY-3v
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 05:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702464629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aS2Q9AuNhj5DlvHBIjqWa+Ucu1meJHSwnhpevJzndnA=;
 b=h0q0Uu86J91FBJcmMzG+QUfIyQBd6WM+zaiEOLwyeOWwlfn4B8EmyIlzbXqc9DVb7F1O+4
 JdRHFE9A+xItaSYQMMlGNZQSyY3YZ3EAOGtkmam6QWEEISbOhF8nuppJBH92HoXCC4l7PN
 A5eI1kjm7wSWo8ZMDz4Inesi3ZqAz/U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-Oi4Vg0xNOQmBNcpqtk7d9Q-1; Wed,
 13 Dec 2023 05:50:28 -0500
X-MC-Unique: Oi4Vg0xNOQmBNcpqtk7d9Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1AF238425BA;
 Wed, 13 Dec 2023 10:50:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B737551E3;
 Wed, 13 Dec 2023 10:50:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 503E71800990; Wed, 13 Dec 2023 11:50:26 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 0/6] Firmware/edk2 20231213 patches
Date: Wed, 13 Dec 2023 11:50:12 +0100
Message-ID: <20231213105026.1944656-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit 9c74490bff6c8886a922008d0c9ce6cae70dd17e:

  Update version for v8.2.0-rc3 release (2023-12-06 14:34:20 -0500)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware/edk2-20231213-pull-request

for you to fetch changes up to 704f7cad5105246822686f65765ab92045f71a3b:

  tests/acpi: disallow tests/data/acpi/virt/SSDT.memhp changes (2023-12-13 11:23:11 +0100)

----------------------------------------------------------------
edk2: update to git snapshot (maybe for-8.2)

This updates edk2 to git master as of today.  This picks up a patch
(merged only yesterday, that's why this last-minute PR) which allows to
work around a bug in shim, and enables that workaround in the qemu
firmware builds.

This solves a real-world problem on arm hardware, walk over to
https://gitlab.com/qemu-project/qemu/-/issues/1990 to see the details.

Merging this firmware update that close to the 8.2 release clearly is
not without risks.  If I get a 'no', I'm not going to complain.

That said I'm not aware of any bugs, and landing this in 8.2.0 would
make a bunch of folks hanging around in issue 1990 very happy.

Alternative plan would be to merge this after the release, give it some
time for testing, and assuming everything goes well schedule a backport
for 8.2.1

----------------------------------------------------------------

Gerd Hoffmann (6):
  tests/acpi: allow tests/data/acpi/virt/SSDT.memhp changes
  edk2: update to git snapshot
  edk2: update build config, set PcdUninstallMemAttrProtocol = TRUE.
  edk2: update binaries to git snapshot
  tests/acpi: update expected data files
  tests/acpi: disallow tests/data/acpi/virt/SSDT.memhp changes

 pc-bios/edk2-aarch64-code.fd.bz2       | Bin 1573561 -> 1587761 bytes
 pc-bios/edk2-arm-code.fd.bz2           | Bin 1560966 -> 1569509 bytes
 pc-bios/edk2-i386-code.fd.bz2          | Bin 1770410 -> 1773520 bytes
 pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 2121818 -> 2127480 bytes
 pc-bios/edk2-riscv-code.fd.bz2         | Bin 1177402 -> 1180314 bytes
 pc-bios/edk2-x86_64-code.fd.bz2        | Bin 1887921 -> 1891942 bytes
 pc-bios/edk2-x86_64-microvm.fd.bz2     | Bin 1782629 -> 1783951 bytes
 pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 2200701 -> 2212258 bytes
 roms/edk2                              |   2 +-
 roms/edk2-build.config                 |  12 +++++++++---
 tests/data/acpi/virt/SSDT.memhp        | Bin 1817 -> 1817 bytes
 11 files changed, 10 insertions(+), 4 deletions(-)

-- 
2.43.0


