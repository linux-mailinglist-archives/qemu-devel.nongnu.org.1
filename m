Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFF0A68D9B
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Mar 2025 14:20:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tutKl-0000nw-UV; Wed, 19 Mar 2025 09:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tutKh-0000jP-AX
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:19:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tutKb-0007f9-4u
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 09:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742390376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YUXh6FLcNHw4jwGqxcDsJ91LhfYbIXwip6ISjuFNUNY=;
 b=EWxuzT/BwWPVxlHdMljiC5W1T82cJ3AnixqIgLMI6UlTCUvsoVBeuc/OSRAn3uU1SuP06x
 EIMLM/1CyhFf/4PD1hyOi9/UeyK6CTNUK8WzttiAseX7N09WmiCL8iaPtkUL/3NUGnuwob
 pDdvJzm4PjpcYOyD009wbffH6an0tzk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-xPc5kGZAPOmH2dgQpqW81w-1; Wed,
 19 Mar 2025 09:19:35 -0400
X-MC-Unique: xPc5kGZAPOmH2dgQpqW81w-1
X-Mimecast-MFC-AGG-ID: xPc5kGZAPOmH2dgQpqW81w_1742390374
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC50B1956089; Wed, 19 Mar 2025 13:19:33 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.212])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33D373001D0E; Wed, 19 Mar 2025 13:19:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 8/8] tests/functional/test_migration: Use "ncat" instead of
 "nc" in the exec test
Date: Wed, 19 Mar 2025 14:18:51 +0100
Message-ID: <20250319131851.148817-9-thuth@redhat.com>
In-Reply-To: <20250319131851.148817-1-thuth@redhat.com>
References: <20250319131851.148817-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

From: Thomas Huth <thuth@redhat.com>

"nc" can either be GNU netcat, OpenBSD netcat or NMap ncat. At
least GNU netcat currently does not work with this test anymore,
though the comment in the test says otherwise. GNU netcat seems
to be quite unmaintained nowadays, according to its website
(https://netcat.sourceforge.net/), the last public release is from
2004, so we should rather avoid that binary.
In our CI, we are only using "ncat" in the containers (it's the only
flavor that lcitool supports), thus to avoid silent regressions with
the other netcats, let's limit this test to "ncat" only now.

Reported-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Message-ID: <20250319105617.133191-1-thuth@redhat.com>
Reviewed-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_migration.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_migration.py b/tests/functional/test_migration.py
index 44804113cfe..181223a69e3 100755
--- a/tests/functional/test_migration.py
+++ b/tests/functional/test_migration.py
@@ -87,13 +87,12 @@ def test_migration_with_unix(self):
             dest_uri = 'unix:%s/qemu-test.sock' % socket_path
             self.do_migrate(dest_uri)
 
-    @skipIfMissingCommands('nc')
+    @skipIfMissingCommands('ncat')
     def test_migration_with_exec(self):
-        """The test works for both netcat-traditional and netcat-openbsd packages."""
         with Ports() as ports:
             free_port = self._get_free_port(ports)
-            dest_uri = 'exec:nc -l localhost %u' % free_port
-            src_uri = 'exec:nc localhost %u' % free_port
+            dest_uri = 'exec:ncat -l localhost %u' % free_port
+            src_uri = 'exec:ncat localhost %u' % free_port
             self.do_migrate(dest_uri, src_uri)
 
 if __name__ == '__main__':
-- 
2.48.1


