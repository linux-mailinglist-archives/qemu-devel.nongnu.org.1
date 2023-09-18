Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E957A4AA3
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:36:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEOI-0000es-R1; Mon, 18 Sep 2023 09:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qiENo-0000Bd-26
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:33:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qiENl-0004gC-Em
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695044022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3cgpE7mwGmbxQcUeDYqcbO7NIOX8pQQvYOjTdUxi0EQ=;
 b=ijmEBfFzJF5Z1pfuz17KbMkLZP9UK5d2XDBauThPuOmPsWhrblJVFiwR03eaTMmhQZuebA
 s9MuMwMqvemDt1OHMt09c7qxBuLA8cKfWZyDU4w1eBfVBQAxosu58JO8tLvjp+HLcFgRb5
 9A/SddqL6kS/sIuh4K3c4FLohNTFz0Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-12WjOsrPOKeNSLygrniCuQ-1; Mon, 18 Sep 2023 09:33:40 -0400
X-MC-Unique: 12WjOsrPOKeNSLygrniCuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5174D85A5A8;
 Mon, 18 Sep 2023 13:33:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1071840C6EA8;
 Mon, 18 Sep 2023 13:33:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CF94518007A1; Mon, 18 Sep 2023 15:33:38 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 0/8] Firmware/edk2 20230918 patches
Date: Mon, 18 Sep 2023 15:33:22 +0200
Message-ID: <20230918133338.2399701-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit c5ea91da443b458352c1b629b490ee6631775cb4:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2023-09-08 10:06:25 -0400)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware/edk2-20230918-pull-request

for you to fetch changes up to 0ec0767e59261b7a1f59e904020cf52b45380e54:

  tests/acpi: disallow virt/SSDT.memhp updates (2023-09-18 15:27:27 +0200)

----------------------------------------------------------------
edk2: update to edk2-stable202308

v2: include acpi test data updates

----------------------------------------------------------------

Gerd Hoffmann (8):
  tests/acpi: allow virt/SSDT.memhp updates
  edk2: update build script
  edk2: update build config
  edk2: workaround edk-stable202308 bug
  edk2: update submodule to edk2-stable202308
  edk2: update binaries to edk2-stable202308
  tests/acpi: update virt/SSDT.memhp
  tests/acpi: disallow virt/SSDT.memhp updates

 roms/edk2-build.py                     | 202 ++++++++++++++++---------
 pc-bios/edk2-aarch64-code.fd.bz2       | Bin 1508184 -> 1573561 bytes
 pc-bios/edk2-arm-code.fd.bz2           | Bin 1483149 -> 1560966 bytes
 pc-bios/edk2-i386-code.fd.bz2          | Bin 1695318 -> 1770410 bytes
 pc-bios/edk2-i386-secure-code.fd.bz2   | Bin 1922002 -> 2121818 bytes
 pc-bios/edk2-riscv-code.fd.bz2         | Bin 0 -> 1177402 bytes
 pc-bios/edk2-riscv-vars.fd.bz2         | Bin 0 -> 231 bytes
 pc-bios/edk2-riscv.fd.bz2              | Bin 1096418 -> 0 bytes
 pc-bios/edk2-x86_64-code.fd.bz2        | Bin 1796544 -> 1887921 bytes
 pc-bios/edk2-x86_64-microvm.fd.bz2     | Bin 1697788 -> 1782629 bytes
 pc-bios/edk2-x86_64-secure-code.fd.bz2 | Bin 1999841 -> 2200701 bytes
 roms/edk2                              |   2 +-
 roms/edk2-build.config                 |  12 +-
 tests/data/acpi/virt/SSDT.memhp        | Bin 1817 -> 1817 bytes
 14 files changed, 139 insertions(+), 77 deletions(-)
 create mode 100644 pc-bios/edk2-riscv-code.fd.bz2
 create mode 100644 pc-bios/edk2-riscv-vars.fd.bz2
 delete mode 100644 pc-bios/edk2-riscv.fd.bz2

-- 
2.41.0


