Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 778CA7F29D0
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:09:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Nge-0006fY-KM; Tue, 21 Nov 2023 05:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r5Ngc-0006ey-Ke
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:08:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r5Nga-0003nJ-Tt
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700561331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uOSg8tyuIX06wNIumnVvRblI+PSnI/GMXvr8iejq/Tg=;
 b=RkLG6hUcXbMmWVAoW0/s4ftopGWVPPBTO7Sfj7RKIVAlX1uVHwCW/rX+GkhlDzxEkgltb4
 o1Oj6WjcQy3WA6NCDQIWXh/I4Vo3V/jZnwzHLkt4DrNj76Oo2GZSGwWIsKofr5C34nszfD
 HTy1AkHowlHVCTOmw/qyjYsNiLpG/Qs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-yVk2SPamOm-czUxQmr2NHw-1; Tue,
 21 Nov 2023 05:08:48 -0500
X-MC-Unique: yVk2SPamOm-czUxQmr2NHw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94F3438049FB;
 Tue, 21 Nov 2023 10:08:47 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 27207492BE0;
 Tue, 21 Nov 2023 10:08:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH] Revert "tests/avocado: Enable reverse_debugging.py tests in
 gitlab CI"
Date: Tue, 21 Nov 2023 11:08:42 +0100
Message-ID: <20231121100842.677363-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This reverts commit c4d74ab24a02c90b7a3240510b3dd4e1bec536dd.

The reverse debugging test is sometimes still failing. See:
 https://gitlab.com/qemu-project/qemu/-/issues/1992

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/reverse_debugging.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index b1410e7a69..ed04e92bb4 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -205,6 +205,8 @@ def get_pc(self, g):
         return self.get_reg_le(g, self.REG_PC) \
             + self.get_reg_le(g, self.REG_CS) * 0x10
 
+    # unidentified gitlab timeout problem
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_x86_64_pc(self):
         """
         :avocado: tags=arch:x86_64
@@ -220,6 +222,8 @@ class ReverseDebugging_AArch64(ReverseDebugging):
 
     REG_PC = 32
 
+    # unidentified gitlab timeout problem
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_aarch64_virt(self):
         """
         :avocado: tags=arch:aarch64
@@ -242,6 +246,8 @@ class ReverseDebugging_ppc64(ReverseDebugging):
 
     REG_PC = 0x40
 
+    # unidentified gitlab timeout problem
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_ppc64_pseries(self):
         """
         :avocado: tags=arch:ppc64
@@ -253,6 +259,8 @@ def test_ppc64_pseries(self):
         self.endian_is_le = False
         self.reverse_debugging()
 
+    # See https://gitlab.com/qemu-project/qemu/-/issues/1992
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_ppc64_powernv(self):
         """
         :avocado: tags=arch:ppc64
-- 
2.42.0


