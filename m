Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B7C88A4FC
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Mar 2024 15:45:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rolZJ-0004P2-KA; Mon, 25 Mar 2024 10:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rolZE-0004NZ-6k
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:44:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rolZC-000246-QR
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711377888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tu060wRoHf0d64nLw6OJxp+TUP1vUeHXNG878GSNAis=;
 b=KapxrGLoteuXlKdm4/7LSuih02zL3dwRjIx0SwZJabg271Q//jJtG4rtHF9bNR64F9NxIm
 fF2t57v+hPr4lA6O13eN26b/fsYHdvmVoSHVS6Rz+VlirTWapUTauDvUubrY5Q3zRbN9Qx
 px3VYE42kmtW3aHavyg+jgpW2eVNIhQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-A2lu5rajPJSWaUS0qrU8Jg-1; Mon,
 25 Mar 2024 10:44:46 -0400
X-MC-Unique: A2lu5rajPJSWaUS0qrU8Jg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCDB4280480C
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 14:44:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DC411C060A4;
 Mon, 25 Mar 2024 14:44:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 383541801497; Mon, 25 Mar 2024 15:44:40 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] edk2: get version + date from git submodule
Date: Mon, 25 Mar 2024 15:44:40 +0100
Message-ID: <20240325144440.1069662-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

Turned out hard-coding version and date in the Makefile wasn't a bright
idea.  Updating it on edk2 updates is easily forgotten.  Fetch the info
from git instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index edc234a0e886..534eba17ebd0 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -51,6 +51,8 @@ SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
 # efi ia32, efi x64) into a single rom binary.
 #
 EDK2_EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
+EDK2_STABLE = $(shell cd edk2; git describe --tags --match 'edk2-stable*')
+EDK2_DATE = $(shell cd edk2; git show --pretty='format:%cd' --date='format:%m/%d/%Y'| head -1)
 
 default help:
 	@echo "nothing is build by default"
@@ -149,8 +151,9 @@ skiboot:
 
 efi:
 	$(PYTHON) edk2-build.py --config edk2-build.config \
-		--version-override "edk2-stable202302-for-qemu" \
-		--release-date "03/01/2023"
+		--version-override "$(EDK2_STABLE)-for-qemu" \
+		--release-date "$(EDK2_DATE)" \
+		--silent --no-logs
 	rm -f ../pc-bios/edk2-*.fd.bz2
 	bzip2 --verbose ../pc-bios/edk2-*.fd
 
-- 
2.44.0


