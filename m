Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 541FF80ACBE
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 20:12:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBgFq-0000jE-Md; Fri, 08 Dec 2023 14:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1rBgFh-0000fe-40
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 14:11:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1rBgFb-0003fI-Ja
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 14:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702062661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aONzR2W5AGaoRzocN4fiH9lBklHZJB74jzBc5TX6OPU=;
 b=R+vuot0O/Bx4mwdfk06b9RwvIAwseAAfqW3YgA61xxn424EiilrPSyci59Bxknft7hIHPL
 +d+nZiz/FUwHFG3Yv+f4CZnX4VGcG58SN2Bf05l9Vn0p/bUn1gwRkAMceBuLPyhfpG5B2r
 Hxv3CIMdOfJVi+D9pdm6FzqeMwm+PvM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-JwBPCelKNQqVsZnDr9QaLA-1; Fri, 08 Dec 2023 14:09:52 -0500
X-MC-Unique: JwBPCelKNQqVsZnDr9QaLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18824185A781;
 Fri,  8 Dec 2023 19:09:51 +0000 (UTC)
Received: from p1.localdomain.com (ovpn-114-104.gru2.redhat.com
 [10.97.114.104])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14AD0112131D;
 Fri,  8 Dec 2023 19:09:47 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 09/10] tests/avocado/boot_xen.py: unify tags
Date: Fri,  8 Dec 2023 14:09:10 -0500
Message-ID: <20231208190911.102879-10-crosa@redhat.com>
In-Reply-To: <20231208190911.102879-1-crosa@redhat.com>
References: <20231208190911.102879-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Because all tests share the same tags, it's possible to have all of
them at the class level.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/avocado/boot_xen.py | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/tests/avocado/boot_xen.py b/tests/avocado/boot_xen.py
index f80cbcb8fb..f4b63c1ef2 100644
--- a/tests/avocado/boot_xen.py
+++ b/tests/avocado/boot_xen.py
@@ -20,6 +20,11 @@
 class BootXen(LinuxKernelTest):
     """
     Boots a Xen hypervisor with a Linux DomU kernel.
+
+    :avocado: tags=arch:aarch64
+    :avocado: tags=accel:tcg
+    :avocado: tags=cpu:cortex-a57
+    :avocado: tags=machine:virt
     """
 
     timeout = 90
@@ -60,13 +65,6 @@ def launch_xen(self, xen_path):
         wait_for_console_pattern(self, console_pattern, "Panic on CPU 0:")
 
     def test_arm64_xen_411_and_dom0(self):
-        """
-        :avocado: tags=arch:aarch64
-        :avocado: tags=accel:tcg
-        :avocado: tags=cpu:cortex-a57
-        :avocado: tags=machine:virt
-        """
-
         # archive of file from https://deb.debian.org/debian/pool/main/x/xen/
         xen_url = ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/'
                    'download?path=%2F&files='
@@ -78,13 +76,6 @@ def test_arm64_xen_411_and_dom0(self):
         self.launch_xen(xen_path)
 
     def test_arm64_xen_414_and_dom0(self):
-        """
-        :avocado: tags=arch:aarch64
-        :avocado: tags=accel:tcg
-        :avocado: tags=cpu:cortex-a57
-        :avocado: tags=machine:virt
-        """
-
         # archive of file from https://deb.debian.org/debian/pool/main/x/xen/
         xen_url = ('https://fileserver.linaro.org/s/JSsewXGZ6mqxPr5/'
                    'download?path=%2F&files='
@@ -96,13 +87,6 @@ def test_arm64_xen_414_and_dom0(self):
         self.launch_xen(xen_path)
 
     def test_arm64_xen_415_and_dom0(self):
-        """
-        :avocado: tags=arch:aarch64
-        :avocado: tags=accel:tcg
-        :avocado: tags=cpu:cortex-a57
-        :avocado: tags=machine:virt
-        """
-
         xen_url = ('https://fileserver.linaro.org/'
                    's/JSsewXGZ6mqxPr5/download'
                    '?path=%2F&files=xen-upstream-4.15-unstable.deb')
-- 
2.43.0


