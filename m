Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0232A7FB3E0
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 09:18:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7tI4-0000ZZ-9c; Tue, 28 Nov 2023 03:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r7tI1-0000ZG-Ml
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 03:17:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r7tHz-0005ma-Tj
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 03:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701159470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SzbaAuOcnSiJXOsGaBuIa5TbOxunsjQ+DG3SdwSywDg=;
 b=XEdhDiO4idnStXXCffucHAM23wmg54bp1B+CBOfl0iUh1DMG6WtzcP65eWAxso+d4TNw1P
 O5XULJCm06ujaGWGhhIKsuMgrp5OtHjuHSba/P8tPXxgDqb5c0xB9Q9X2Es3MZK+l75Dgt
 vTIsQ9ApHhsN7bHP8WPUsh83CeKJxFk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-gWUhbrppNhuYQkZzVXNmNg-1; Tue,
 28 Nov 2023 03:17:48 -0500
X-MC-Unique: gWUhbrppNhuYQkZzVXNmNg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46AE03806072
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 08:17:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D9B0492BFA;
 Tue, 28 Nov 2023 08:17:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4549A180092D; Tue, 28 Nov 2023 09:17:43 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 0/2] Firmware/seabios 20231128 patches
Date: Tue, 28 Nov 2023 09:17:41 +0100
Message-ID: <20231128081743.2214005-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

The following changes since commit 4705fc0c8511d073bee4751c3c974aab2b10a970:

  Merge tag 'pull-for-8.2-fixes-231123-1' of https://gitlab.com/stsquad/qemu into staging (2023-11-24 08:00:18 -0500)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware/seabios-20231128-pull-request

for you to fetch changes up to eb0ce1346eca79f066e571dc5845f99f9ec730c3:

  seabios: update binaries to 1.16.3 release (2023-11-28 08:49:26 +0100)

----------------------------------------------------------------
seabios: update to 1.16.3 release

This adds one bugfix compared to the snapshot
merged during the 8.2 devel cycle.

----------------------------------------------------------------

Gerd Hoffmann (2):
  seabios: update submodule to 1.16.3 release
  seabios: update binaries to 1.16.3 release

 pc-bios/bios-256k.bin             | Bin 262144 -> 262144 bytes
 pc-bios/bios-microvm.bin          | Bin 131072 -> 131072 bytes
 pc-bios/bios.bin                  | Bin 131072 -> 131072 bytes
 pc-bios/vgabios-ati.bin           | Bin 39424 -> 39424 bytes
 pc-bios/vgabios-bochs-display.bin | Bin 28672 -> 28672 bytes
 pc-bios/vgabios-cirrus.bin        | Bin 38912 -> 38912 bytes
 pc-bios/vgabios-qxl.bin           | Bin 39424 -> 39424 bytes
 pc-bios/vgabios-ramfb.bin         | Bin 28672 -> 28672 bytes
 pc-bios/vgabios-stdvga.bin        | Bin 39424 -> 39424 bytes
 pc-bios/vgabios-virtio.bin        | Bin 39424 -> 39424 bytes
 pc-bios/vgabios-vmware.bin        | Bin 39424 -> 39424 bytes
 pc-bios/vgabios.bin               | Bin 38912 -> 38912 bytes
 roms/seabios                      |   2 +-
 13 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.43.0


