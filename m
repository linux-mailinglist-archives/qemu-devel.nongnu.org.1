Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EED64A45AFE
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Feb 2025 10:59:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEAs-0003MC-9o; Wed, 26 Feb 2025 04:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEAp-0003LX-PN
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:57:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEAk-00084p-Hx
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740563865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FY85KWLA+uDtBar9JEGWpfQ11qn5Sf48ics/ljArYKU=;
 b=fZzj5l2dc7Ix/lJC2QGUawXDWKuyFANURYFBzD3EvK251qgOJEvlmkQjs/hGYmkYTOiSXm
 bF5LBBdeeAUZQf1aKCUYRJgRo3l8eJwtw5vp4+Ix/7DARrxAkMIfcwgP+gya2wZQ4vdi4t
 dyc2nVo7RS6iensikgL0U9YUpf66HbU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-NbiCSzKIPdGc6NEblqM32w-1; Wed,
 26 Feb 2025 04:57:43 -0500
X-MC-Unique: NbiCSzKIPdGc6NEblqM32w-1
X-Mimecast-MFC-AGG-ID: NbiCSzKIPdGc6NEblqM32w_1740563863
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2853180087A
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 09:57:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.144])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21549180035E; Wed, 26 Feb 2025 09:57:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 03/18] tests/functional: Provide a proper name for the VMs in
 the replay tests
Date: Wed, 26 Feb 2025 10:57:16 +0100
Message-ID: <20250226095731.1172375-4-thuth@redhat.com>
In-Reply-To: <20250226095731.1172375-1-thuth@redhat.com>
References: <20250226095731.1172375-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

With a proper name the log files get a more meaningful name.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250218152744.228335-2-thuth@redhat.com>
---
 tests/functional/replay_kernel.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/replay_kernel.py b/tests/functional/replay_kernel.py
index 8e8ac7d052f..80795eb0520 100644
--- a/tests/functional/replay_kernel.py
+++ b/tests/functional/replay_kernel.py
@@ -34,7 +34,7 @@ def run_vm(self, kernel_path, kernel_command_line, console_pattern,
 
         logger = logging.getLogger('replay')
         start_time = time.time()
-        vm = self.get_vm()
+        vm = self.get_vm(name='recording' if record else 'replay')
         vm.set_console()
         if record:
             logger.info('recording the execution...')
-- 
2.48.1


