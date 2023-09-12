Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D41979CEF3
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:55:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg126-0007Rm-KA; Tue, 12 Sep 2023 06:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qg123-0007Qv-MZ
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:54:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qg120-00057c-Tw
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694516043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/OQ9pKZzphKa6VzQJA+xgB0q/Z99sdF1gjj8ljHJ3hk=;
 b=FLswU4ZunRl/X5pRtuzo9Nw/hrzMxCJlndtdNyxqR2emQyurXNinvAojamx7IC//Dt67q0
 +ZCuTgyZ9McQi+nykAhbBBa6ZABWSu4q4/3ySYsZXOrqVuPPTKODHJSjtjD5osgHyNJlMS
 OUAYJtB9wQnrnIZXMf2LyXD1oJRIOaY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-GUK8iHE2MTGYshKiNyb5HA-1; Tue, 12 Sep 2023 06:54:01 -0400
X-MC-Unique: GUK8iHE2MTGYshKiNyb5HA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C049803C96
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 10:54:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34B7510F1BE7;
 Tue, 12 Sep 2023 10:54:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E27541800097; Tue, 12 Sep 2023 12:53:59 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 0/3] Firmware/seabios 20230912 patches
Date: Tue, 12 Sep 2023 12:53:56 +0200
Message-ID: <20230912105359.563101-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

  https://gitlab.com/kraxel/qemu.git tags/firmware/seabios-20230912-pull-request

for you to fetch changes up to a14c30fc3d38d569415259a2d877c36a0b8de058:

  seabios: update binaries to git snapshot (2023-09-11 17:32:44 +0200)

----------------------------------------------------------------
seabios: update to git snapshot

Give seabios updates some testing coverage before
tagging a new release.  Update to release code
will follow later in the 8.2 devel cycle.

----------------------------------------------------------------

Gerd Hoffmann (3):
  seabios: update submodule to git snapshot
  seabios: turn off CONFIG_APMBIOS for 128k build
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
 roms/config.seabios-128k          |   1 +
 roms/seabios                      |   2 +-
 14 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.41.0


