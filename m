Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3987B3167
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 13:30:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmBgo-0001OD-VU; Fri, 29 Sep 2023 07:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qmBgm-0001N4-AP
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 07:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qmBgk-0001Dc-Lv
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 07:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695986980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NCEEMTqaFg6NSI3a281/YGktBuDQo8PU6waAVDE0EEQ=;
 b=ZW+oI4+1i4pNma8erDFbrVUXD1tLhejM2OPRC8AqtiCWZM5M9aMaz17kvLTDNxeEIY2Rz8
 FitjVnmQVbWTABMRCC+OdFugBdNJEqgTT3QHWtcA17hwrcViDTilOyJhbDrN18whOf0f8W
 KuwwG+LYi5zlV6TnF49GM26MYmO49h0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-XNhb6fz_MRyqQ9ILFFLXXQ-1; Fri, 29 Sep 2023 07:29:38 -0400
X-MC-Unique: XNhb6fz_MRyqQ9ILFFLXXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48B343C1CC2A
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 11:29:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 127F510F1BE7;
 Fri, 29 Sep 2023 11:29:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8B5321800638; Fri, 29 Sep 2023 13:29:36 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 0/2] Firmware/seabios 20230929 patches
Date: Fri, 29 Sep 2023 13:29:34 +0200
Message-ID: <20230929112936.2852930-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 36e9aab3c569d4c9ad780473596e18479838d1aa:

  migration: Move return path cleanup to main migration thread (2023-09-27 13:58:02 -0400)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware/seabios-20230929-pull-request

for you to fetch changes up to 1f75b1beeb8d958cc56113ba229348d6a0be9d9d:

  seabios: update binaries to git snapshot (2023-09-29 13:15:44 +0200)

----------------------------------------------------------------
seabios: update to git snapshot

Give seabios a bit real world testing before tagging a release.
Update to release will follow later in the devel cycle.

----------------------------------------------------------------

Gerd Hoffmann (2):
  seabios: update submodule to git snapshot
  seabios: update binaries to git snapshot

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
 13 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.41.0


