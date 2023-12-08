Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27680ACB8
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 20:12:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBgFt-0000lF-3z; Fri, 08 Dec 2023 14:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1rBgFm-0000h3-BI
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 14:11:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1rBgFW-0003dd-2R
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 14:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702062657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6KemJUkWyU9r+J/jwN6os/ZXFpgsYC5/aEWfNA4odDs=;
 b=XuayzAIVS5fRfIJp81gQ39a8WIO0kwecqZ9uiWFsDiFEF8Ck1skmQ5h0yKInqz7M8S0Vnu
 7RZx2aQvFlFk3v0NvzM/fb28fAdakC+mP0dDaCY5KpCERbkx9rPY/Eh82s2E4amIyzhP9T
 sh4LvIpxNtDbLxbYIRQUOEHYUeG0FcU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-blH1v5GyMemL3aM-9qkpaw-1; Fri,
 08 Dec 2023 14:09:48 -0500
X-MC-Unique: blH1v5GyMemL3aM-9qkpaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C15A11C05AD8;
 Fri,  8 Dec 2023 19:09:47 +0000 (UTC)
Received: from p1.localdomain.com (ovpn-114-104.gru2.redhat.com
 [10.97.114.104])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD471111E406;
 Fri,  8 Dec 2023 19:09:44 +0000 (UTC)
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
Subject: [PATCH 08/10] tests/avocado/boot_xen.py: merge base classes
Date: Fri,  8 Dec 2023 14:09:09 -0500
Message-ID: <20231208190911.102879-9-crosa@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

While it's a good practice to have reusable base classes, in this
specific case there's no other user of the BootXenBase class.

By unifying the class used in this test, we can improve readability
and have the opportunity to add some future improvements in a clearer
fashion.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/avocado/boot_xen.py | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tests/avocado/boot_xen.py b/tests/avocado/boot_xen.py
index fc2faeedb5..f80cbcb8fb 100644
--- a/tests/avocado/boot_xen.py
+++ b/tests/avocado/boot_xen.py
@@ -17,7 +17,7 @@
 from boot_linux_console import LinuxKernelTest
 
 
-class BootXenBase(LinuxKernelTest):
+class BootXen(LinuxKernelTest):
     """
     Boots a Xen hypervisor with a Linux DomU kernel.
     """
@@ -59,9 +59,6 @@ def launch_xen(self, xen_path):
         console_pattern = 'VFS: Cannot open root device'
         wait_for_console_pattern(self, console_pattern, "Panic on CPU 0:")
 
-
-class BootXen(BootXenBase):
-
     def test_arm64_xen_411_and_dom0(self):
         """
         :avocado: tags=arch:aarch64
-- 
2.43.0


