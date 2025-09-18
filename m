Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F82B1413A
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Jul 2025 19:31:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugRgZ-0003Eb-M4; Mon, 28 Jul 2025 13:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ugRgE-0002ly-Ia
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 13:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ugRg8-00061L-KO
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 13:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753723823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=eUoKj/NKwS1Na52rnIVQy+Sv4r/p2PoH+hWl9VDYsC4=;
 b=J+37hM6hkV63nBroUJvIO8y0EsyId/P2iCZEfJtgMYauKSGa6qF4msxIU61cKFPmolWv65
 tIciQZ/7DW8zXKMfc3CsJ0sidWQxgauWpnBo0Py0IXSs3t3pBmqKhF4GGh3gDf7/tnQr6k
 NVeHLXCH5NdY6yZpPLEXl/ESiFBtY5s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-NsCFXRGlPSqY1l_d9p9Ypw-1; Mon,
 28 Jul 2025 13:30:21 -0400
X-MC-Unique: NsCFXRGlPSqY1l_d9p9Ypw-1
X-Mimecast-MFC-AGG-ID: NsCFXRGlPSqY1l_d9p9Ypw_1753723820
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 91B4E1956089; Mon, 28 Jul 2025 17:30:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8085330001B1; Mon, 28 Jul 2025 17:30:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-trivial@nongnu.org
Subject: [PATCH] qga: Fix ubsan warning
Date: Mon, 28 Jul 2025 19:30:16 +0200
Message-ID: <20250728173016.314460-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When compiling QEMU with --enable-ubsan there is a undefined behavior
warning when running "make check":

 .../qga/commands-linux.c:452:15: runtime error: applying non-zero offset 5 to null pointer
 #0 0x55ea7b89450c in build_guest_fsinfo_for_pci_dev ..../qga/commands-linux.c:452:15

Add a check to avoid incrementing the NULL pointer here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qga/commands-linux.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 9e8a934b9a6..caf7c3ca22b 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -449,7 +449,9 @@ static bool build_guest_fsinfo_for_pci_dev(char const *syspath,
         has_ata = true;
     } else {
         p = strstr(syspath, "/host");
-        q = p + 5;
+        if (p) {
+            q = p + 5;
+        }
     }
     if (p && sscanf(q, "%u", &host) == 1) {
         has_host = true;
-- 
2.50.1


