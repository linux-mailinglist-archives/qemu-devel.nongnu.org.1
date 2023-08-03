Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5BF76E7A0
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 14:03:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRWDF-0006LH-Qf; Thu, 03 Aug 2023 07:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRWDD-0006Kf-Ae
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 07:09:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qRWDB-0007UW-9l
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 07:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691060984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lCRIRcbDFRFNFxEXw2YhOhdhIiknWUHswC46GhMp6zw=;
 b=DzH3Xf042LG5r/Q88p9d3nvE9QRJQ0LRiQcwlHqMJGebQ3BTIB5PzNrKfHnmUGgZcG4TZB
 qKfvd0haPpFs5vWQyFISveOdAv+xXyBvn1y8JQUyBBNwjBdi0yAiTikS8nF89Tc8UHuqQs
 HU9LdVgt1bABEbGlRfgDDGkd+gH8DoM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-m_jDE7syM5qrHngIultLjw-1; Thu, 03 Aug 2023 07:09:41 -0400
X-MC-Unique: m_jDE7syM5qrHngIultLjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1C813C10146;
 Thu,  3 Aug 2023 11:09:40 +0000 (UTC)
Received: from thuth.com (unknown [10.45.226.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 095701121325;
 Thu,  3 Aug 2023 11:09:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 4/9] gitlab: always use updated msys installer
Date: Thu,  3 Aug 2023 13:09:27 +0200
Message-Id: <20230803110932.341091-5-thuth@redhat.com>
In-Reply-To: <20230803110932.341091-1-thuth@redhat.com>
References: <20230803110932.341091-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

We current reference an msys installer binary from mid-2022, which means
after installation, it immediately has to re-download a bunch of newer
content. This wastes precious CI time.

The msys project publishes an installer binary with a fixed URL that
always references the latest content. We cache the downloads in gitlab
though and so once downloaded we would never re-fetch the installer
leading back to the same problem.

To deal with this we also fetch the pgp signature for the installer
on every run, and compare that to the previously cached signature. If
the signature changes, we re-download the full installer.

This ensures we always have the latest installer for msys, while also
maximising use of the gitlab cache.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230801130403.164060-4-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/windows.yml | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
index 831b080d12..0bc04ad068 100644
--- a/.gitlab-ci.d/windows.yml
+++ b/.gitlab-ci.d/windows.yml
@@ -23,10 +23,34 @@
   - If ( !(Test-Path -Path msys64\var\cache ) ) {
       mkdir msys64\var\cache
     }
-  - If ( !(Test-Path -Path msys64\var\cache\msys2.exe ) ) {
+  - Invoke-WebRequest
+    "https://repo.msys2.org/distrib/msys2-x86_64-latest.sfx.exe.sig"
+    -outfile "msys2.exe.sig"
+  - if ( Test-Path -Path msys64\var\cache\msys2.exe.sig ) {
+      Write-Output "Cached installer sig" ;
+      if ( ((Get-FileHash msys2.exe.sig).Hash -ne (Get-FileHash msys64\var\cache\msys2.exe.sig).Hash) ) {
+        Write-Output "Mis-matched installer sig, new installer download required" ;
+        Remove-Item -Path msys64\var\cache\msys2.exe.sig ;
+        if ( Test-Path -Path msys64\var\cache\msys2.exe ) {
+          Remove-Item -Path msys64\var\cache\msys2.exe
+        }
+      } else {
+        Write-Output "Matched installer sig, cached installer still valid"
+      }
+    } else {
+      Write-Output "No cached installer sig, new installer download required" ;
+      if ( Test-Path -Path msys64\var\cache\msys2.exe ) {
+        Remove-Item -Path msys64\var\cache\msys2.exe
+      }
+    }
+  - if ( !(Test-Path -Path msys64\var\cache\msys2.exe ) ) {
+      Write-Output "Fetching latest installer" ;
       Invoke-WebRequest
-      "https://github.com/msys2/msys2-installer/releases/download/2022-06-03/msys2-base-x86_64-20220603.sfx.exe"
-      -outfile "msys64\var\cache\msys2.exe"
+      "https://repo.msys2.org/distrib/msys2-x86_64-latest.sfx.exe"
+      -outfile "msys64\var\cache\msys2.exe" ;
+      Copy-Item -Path msys2.exe.sig -Destination msys64\var\cache\msys2.exe.sig
+    } else {
+      Write-Output "Using cached installer"
     }
   - Write-Output "Invoking msys2.exe installer at $(Get-Date -Format u)"
   - msys64\var\cache\msys2.exe -y
-- 
2.39.3


