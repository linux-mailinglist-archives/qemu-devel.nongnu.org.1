Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82691B53558
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Sep 2025 16:31:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwiIr-0002U3-UD; Thu, 11 Sep 2025 10:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwiIp-0002TQ-7i
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:29:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uwiIn-0001yT-Bp
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757600971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/v/BKw/gnPDw+GvWcYlw+Ouyjli0Zhl6DGfiu+yxehk=;
 b=WHxytmznmkB8WGMrlxYR/U37GeSQDZDapsTt7S8W8Q8u3y+205egVTa2zvz5ujQQiIagjH
 nFOF9YVz7u6mDc5uhIRXNOTI3bYn9tS2GOnA/hAYZnxjek5VZF8la2a2R1HcyWAN6xMs4H
 TadfxKvG4s+evoatUlbj/7Lm8IYQTWc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-VsUDQAuMNyO-x_XdCdBPCg-1; Thu,
 11 Sep 2025 10:29:29 -0400
X-MC-Unique: VsUDQAuMNyO-x_XdCdBPCg-1
X-Mimecast-MFC-AGG-ID: VsUDQAuMNyO-x_XdCdBPCg_1757600969
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81E4D1800365; Thu, 11 Sep 2025 14:29:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.206])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 051AE1800446; Thu, 11 Sep 2025 14:29:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org,
	Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH] tests/qemu-iotests: Mark the 'inactive-node-nbd' as
 unsupported with -luks
Date: Thu, 11 Sep 2025 16:29:22 +0200
Message-ID: <20250911142922.222365-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When running "./check -luks inactive-node-nbd", the test currently fails
because QEMU terminates immediately. The reason can be seen with the
"-p" parameter of the "check" script:

 qemu-system-x86_64: -blockdev luks,file=disk-file,node-name=disk-fmt,active=off:
  Parameter 'key-secret' is required for cipher

Quoting Kevin: "The test case just isn't made for luks. iotests.py has
special code for luks in VM.add_drive(), but not in VM.add_blockdev()."

Thus let's mark it as unsupported on luks to avoid the failure.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/tests/inactive-node-nbd | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qemu-iotests/tests/inactive-node-nbd b/tests/qemu-iotests/tests/inactive-node-nbd
index a95b37e7962..664157bfd04 100755
--- a/tests/qemu-iotests/tests/inactive-node-nbd
+++ b/tests/qemu-iotests/tests/inactive-node-nbd
@@ -24,6 +24,7 @@ from iotests import QemuIoInteractive
 from iotests import filter_qemu_io, filter_qtest, filter_qmp_testfiles
 
 iotests.script_initialize(supported_fmts=['generic'],
+                          unsupported_fmts=['luks'],
                           supported_protocols=['file'],
                           supported_platforms=['linux'])
 
-- 
2.51.0


