Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 320AE9D4FFA
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Nov 2024 16:44:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE9LS-0000cZ-5V; Thu, 21 Nov 2024 10:43:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE9L8-0000Th-9E
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:43:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tE9L4-0000mN-MP
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 10:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732203802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMvcOztfLXHUpbwvz/8L1h5YFMWeNJ73YUWalXKVu2A=;
 b=I0MFvGoEEiGQfgEgxil2ukNyOwauMFW+yWq2hlZzF+45M45Ci6H/4gHlOoAr6y31WtIaFI
 l7rUb0i1DlQyIEswIathl1cvD4kyEBgdGeC4fkm41BTBwhqzjDrp2UYFyodcCWFPKkrGrF
 4T6IXEkLirxdF5RLn3lcVb3CMHu7tc4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-K0tr_tqxMIKDnzzptLyGRg-1; Thu,
 21 Nov 2024 10:43:21 -0500
X-MC-Unique: K0tr_tqxMIKDnzzptLyGRg-1
X-Mimecast-MFC-AGG-ID: K0tr_tqxMIKDnzzptLyGRg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0192D19560A3; Thu, 21 Nov 2024 15:43:20 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.5])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3BC6F1956086; Thu, 21 Nov 2024 15:43:13 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 09/18] tests/functional: put QEMUMachine logs in testcase
 log directory
Date: Thu, 21 Nov 2024 15:42:09 +0000
Message-ID: <20241121154218.1423005-10-berrange@redhat.com>
In-Reply-To: <20241121154218.1423005-1-berrange@redhat.com>
References: <20241121154218.1423005-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We are not passing the 'log_dir' parameter to QEMUMachine, so the
QEMU stdout/err logs are being placed in a temp directory and thus
deleted after execution. This makes them inaccessible as gitlab
CI artifacts.

Pass the testcase log directory path into QEMUMachine to make the
logs persistent.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/testcase.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
index b9418e2ac0..ca13af244b 100644
--- a/tests/functional/qemu_test/testcase.py
+++ b/tests/functional/qemu_test/testcase.py
@@ -163,10 +163,11 @@ def require_device(self, devicename):
             self.skipTest('no support for device ' + devicename)
 
     def _new_vm(self, name, *args):
-        vm = QEMUMachine(self.qemu_bin, base_temp_dir=self.workdir)
+        vm = QEMUMachine(self.qemu_bin,
+                         base_temp_dir=self.workdir,
+                         log_dir=self.logdir)
         self.log.debug('QEMUMachine "%s" created', name)
         self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
-        self.log.debug('QEMUMachine "%s" log_dir: %s', name, vm.log_dir)
         if args:
             vm.add_args(*args)
         return vm
-- 
2.46.0


