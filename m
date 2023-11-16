Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDBD7EE668
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 19:07:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gku-0002V1-CC; Thu, 16 Nov 2023 13:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gke-0002Ug-9H
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:06:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkT-00044I-VF
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700157953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCWd49Yrg9RU1/fWxOi5fA4KEV6str5bow5FbHC2aA4=;
 b=XUs5ZOef1T1j+qniaMHLy0oW4+wc02F/CEl1COQuSTcLwL5H+GWbCaZCGKYWN+oDUDAIc7
 1pX2hILqyBTHJrwe5+XtBfVhDpOG1CS9DfJM0i+Ifn6t/pBTwKU6LI6gUp8uI+gFqYf9fC
 tIrBYbG6fpF9VzfVumQtnHOKslec/bY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-bivSErXhOum7yOxmhVz2BA-1; Thu, 16 Nov 2023 13:05:51 -0500
X-MC-Unique: bivSErXhOum7yOxmhVz2BA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FD90857BC2;
 Thu, 16 Nov 2023 18:05:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14CFC1121306;
 Thu, 16 Nov 2023 18:05:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 10/10] tests/avocado: Enable reverse_debugging.py tests in
 gitlab CI
Date: Thu, 16 Nov 2023 19:05:34 +0100
Message-ID: <20231116180534.566469-11-thuth@redhat.com>
In-Reply-To: <20231116180534.566469-1-thuth@redhat.com>
References: <20231116180534.566469-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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

From: Nicholas Piggin <npiggin@gmail.com>

Let's try enable reverse_debugging.py in gitlab CI.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20231116115354.228678-3-npiggin@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/reverse_debugging.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 128d85bc0e..b1410e7a69 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -205,8 +205,6 @@ def get_pc(self, g):
         return self.get_reg_le(g, self.REG_PC) \
             + self.get_reg_le(g, self.REG_CS) * 0x10
 
-    # unidentified gitlab timeout problem
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_x86_64_pc(self):
         """
         :avocado: tags=arch:x86_64
@@ -222,8 +220,6 @@ class ReverseDebugging_AArch64(ReverseDebugging):
 
     REG_PC = 32
 
-    # unidentified gitlab timeout problem
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_aarch64_virt(self):
         """
         :avocado: tags=arch:aarch64
@@ -246,8 +242,6 @@ class ReverseDebugging_ppc64(ReverseDebugging):
 
     REG_PC = 0x40
 
-    # unidentified gitlab timeout problem
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_ppc64_pseries(self):
         """
         :avocado: tags=arch:ppc64
@@ -259,7 +253,6 @@ def test_ppc64_pseries(self):
         self.endian_is_le = False
         self.reverse_debugging()
 
-    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_ppc64_powernv(self):
         """
         :avocado: tags=arch:ppc64
-- 
2.41.0


