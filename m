Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 553CC7BF9B7
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:28:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqAt3-0002UN-VJ; Tue, 10 Oct 2023 07:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qqAsb-0002KV-Cs
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:26:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qqAsZ-0007w0-NO
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696937183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8GoGg6hc5J++myD1czNuEMRCQZpHDrbPadiGQXzXnwA=;
 b=OVRqy4qkwBcGAt4Zg6ihlEE19lLv5o9BzHcChN7GSXPYVbSAAE61cvzQJVJwemj2SmSyb0
 jf9gpX5OB4KetPBjo8Lx/IAnHKz+6tvuMqJ2BPE7B8YTfMLVMAx4wwU5FTzW/c1Yir/hgM
 D3Iag+6z+RgDJ+sN3+j+RbLxfvnJb0c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-k6fYLxGFMd2A2R9KcxpIIA-1; Tue, 10 Oct 2023 07:26:12 -0400
X-MC-Unique: k6fYLxGFMd2A2R9KcxpIIA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0ED6858F1C
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 11:26:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9DDF401E6A;
 Tue, 10 Oct 2023 11:26:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 7220B18009A1; Tue, 10 Oct 2023 13:26:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 0/6] Firmware/seabios 20231010 patches
Date: Tue, 10 Oct 2023 13:26:04 +0200
Message-ID: <20231010112610.2618091-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

The following changes since commit 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2023-10-05 09:01:01 -0400)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware/seabios-20231010-pull-request

for you to fetch changes up to e83f3600f9ff7d9e0d014f328e64c49bb81b945c:

  tests/acpi: disable tests/data/acpi/q35/DSDT.mmio64 updates (2023-10-10 11:11:55 +0200)

----------------------------------------------------------------
seabios: update to git snapshot

Give seabios a bit real world testing before tagging a release.
Update to release will follow later in the devel cycle.

v3: update mmio64 acpi test.

----------------------------------------------------------------

Gerd Hoffmann (6):
  tests/bios-tables-test: tcg-emulate opteron for mmio64 test
  tests/acpi: enable tests/data/acpi/q35/DSDT.mmio64 updates
  seabios: update submodule to git snapshot
  seabios: update binaries to git snapshot
  tests/acpi: update expected data files
  tests/acpi: disable tests/data/acpi/q35/DSDT.mmio64 updates

 tests/qtest/bios-tables-test.c    |   2 ++
 pc-bios/bios-256k.bin             | Bin 262144 -> 262144 bytes
 pc-bios/bios-microvm.bin          | Bin 131072 -> 131072 bytes
 pc-bios/bios.bin                  | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-ati.bin           | Bin 39936 -> 39424 bytes
 pc-bios/vgabios-bochs-display.bin | Bin 28672 -> 28672 bytes
 pc-bios/vgabios-cirrus.bin        | Bin 39424 -> 38912 bytes
 pc-bios/vgabios-qxl.bin           | Bin 39936 -> 39424 bytes
 pc-bios/vgabios-ramfb.bin         | Bin 29184 -> 28672 bytes
 pc-bios/vgabios-stdvga.bin        | Bin 39936 -> 39424 bytes
 pc-bios/vgabios-virtio.bin        | Bin 39936 -> 39424 bytes
 pc-bios/vgabios-vmware.bin        | Bin 39936 -> 39424 bytes
 pc-bios/vgabios.bin               | Bin 39424 -> 38912 bytes
 roms/seabios                      |   2 +-
 tests/data/acpi/q35/DSDT.mmio64   | Bin 9485 -> 9485 bytes
 15 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.41.0


