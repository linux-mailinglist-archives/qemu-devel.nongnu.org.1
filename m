Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E22279EE1B0
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 09:44:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLeoH-0004Vn-OG; Thu, 12 Dec 2024 03:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tLeo2-0004Do-Bv
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:44:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tLeo0-0008BR-PZ
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733993059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=N/sWHCoTT6HpahA5ovqrSgS4x1vrKAscdg0Hm7rKb+Q=;
 b=dO2mOBfvM4ambOpqU+9GfagU4a3PlilZNzmJi/q6LlJdvIhDyn49Uy5oxnG7DNx2OewoQC
 ImdUnvtm9uI0HGl7RixvDxP/40vhTGgfJgDTzPyD4tTmuuXPZnZUWdKNYBDZkZsobuoI50
 PGm/hUSAHiMtywE/cybHk4YIzxHZHeo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-tq3UlQypMAWt9NIWlYUgNQ-1; Thu,
 12 Dec 2024 03:44:16 -0500
X-MC-Unique: tq3UlQypMAWt9NIWlYUgNQ-1
X-Mimecast-MFC-AGG-ID: tq3UlQypMAWt9NIWlYUgNQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6D761955E75; Thu, 12 Dec 2024 08:44:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 216F9195394B; Thu, 12 Dec 2024 08:44:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 11D1A1800080; Thu, 12 Dec 2024 09:44:08 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Liu Jaloo <liu.jaloo@gmail.com>
Subject: [PATCH] roms: re-add edk2-basetools target
Date: Thu, 12 Dec 2024 09:44:07 +0100
Message-ID: <20241212084408.1390728-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Needed to build ipxe nic roms.

Reported-by: Liu Jaloo <liu.jaloo@gmail.com>
Fixes: 22e11539e167 ("edk2: replace build scripts")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/roms/Makefile b/roms/Makefile
index dfed2b216a1e..31e4b97c983b 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -157,6 +157,11 @@ edk2-version: edk2
 		touch $@; \
 	fi
 
+edk2-basetools: edk2-version
+	$(PYTHON) edk2-build.py --config edk2-build.config \
+		--silent --no-logs \
+		--match none # build only basetools
+
 efi: edk2-version
 	$(PYTHON) edk2-build.py --config edk2-build.config \
 		--version-override "$(EDK2_STABLE)$(FIRMWARE_EXTRAVERSION)" \
-- 
2.47.1


