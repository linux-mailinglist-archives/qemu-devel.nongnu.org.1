Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ACD70BC6C
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:54:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q144L-0005hQ-Br; Mon, 22 May 2023 07:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143n-0005GN-DS
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143k-0007dI-Nq
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684756240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7RccDGRErIJs5vNwrUAogX4sU2ut3n2RLxqApFssBAg=;
 b=JvoVTsV3BOU7PrkmobEdkip5YvMgdgIK3FhOcydTKONdD4V5ZnfaypgAn+eRU6p+xY03zA
 NSXirNjYTREjLht2prILrbDGgxHhzPtjBwgBKc5LtwB5r7H+mSFse4MecQH8pUIoIWGsW8
 MKO/AHlz9lvd1tkjOrYIW98E2SEIJkE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-Y9qtrc5qOTmFwoPz_2DFpw-1; Mon, 22 May 2023 07:50:38 -0400
X-MC-Unique: Y9qtrc5qOTmFwoPz_2DFpw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F99B185A791;
 Mon, 22 May 2023 11:50:38 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A54782166B26;
 Mon, 22 May 2023 11:50:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 19/20] acpi/tests/avocado/bits: enable bios bits avocado tests
 on gitlab CI pipeline
Date: Mon, 22 May 2023 13:50:13 +0200
Message-Id: <20230522115014.1110840-20-thuth@redhat.com>
In-Reply-To: <20230522115014.1110840-1-thuth@redhat.com>
References: <20230522115014.1110840-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Ani Sinha <anisinha@redhat.com>

Biosbits avocado tests on gitlab has thus far been disabled because some
packages needed by this test was missing in the container images used by gitlab
CI. These packages have now been added with the commit:

da9000784c90d ("tests/lcitool: Add mtools and xorriso and remove genisoimage as dependencies")

Therefore, this change enables bits avocado test on gitlab.
At the same time, the bits cleanup code has also been made more robust with
this change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20230517065357.5614-1-anisinha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/acpi-bits.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/avocado/acpi-bits.py b/tests/avocado/acpi-bits.py
index 14038fa3c4..3ed286dcbd 100644
--- a/tests/avocado/acpi-bits.py
+++ b/tests/avocado/acpi-bits.py
@@ -123,9 +123,9 @@ def base_args(self):
         """return the base argument to QEMU binary"""
         return self._base_args
 
-@skipIf(not supported_platform() or missing_deps() or os.getenv('GITLAB_CI'),
-        'incorrect platform or dependencies (%s) not installed ' \
-        'or running on GitLab' % ','.join(deps))
+@skipIf(not supported_platform() or missing_deps(),
+        'unsupported platform or dependencies (%s) not installed' \
+        % ','.join(deps))
 class AcpiBitsTest(QemuBaseTest): #pylint: disable=too-many-instance-attributes
     """
     ACPI and SMBIOS tests using biosbits.
@@ -356,7 +356,7 @@ def tearDown(self):
         """
         if self._vm:
             self.assertFalse(not self._vm.is_running)
-        if not os.getenv('BITS_DEBUG'):
+        if not os.getenv('BITS_DEBUG') and self._workDir:
             self.logger.info('removing the work directory %s', self._workDir)
             shutil.rmtree(self._workDir)
         else:
-- 
2.31.1


