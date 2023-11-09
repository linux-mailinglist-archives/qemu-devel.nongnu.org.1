Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA257E6B6F
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:47:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Kg-0000M9-Pj; Thu, 09 Nov 2023 08:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15KW-0008G1-SQ; Thu, 09 Nov 2023 08:44:20 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15KU-000189-4a; Thu, 09 Nov 2023 08:44:20 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 91A0931B01;
 Thu,  9 Nov 2023 16:43:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9DB3E344A8;
 Thu,  9 Nov 2023 16:43:03 +0300 (MSK)
Received: (nullmailer pid 1461791 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 10/55] tracetool: avoid invalid escape in Python string
Date: Thu,  9 Nov 2023 16:42:14 +0300
Message-Id: <20231109134300.1461632-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Paolo Bonzini <pbonzini@redhat.com>

This is an error in Python 3.12; fix it by using a raw string literal.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit e6d8e5e6e366ab4c9ed7d8ed1572f98c6ad6a38e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 33cf85e2b0..b29594d75e 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -210,12 +210,12 @@ class Event(object):
 
     """
 
-    _CRE = re.compile("((?P<props>[\w\s]+)\s+)?"
-                      "(?P<name>\w+)"
-                      "\((?P<args>[^)]*)\)"
-                      "\s*"
-                      "(?:(?:(?P<fmt_trans>\".+),)?\s*(?P<fmt>\".+))?"
-                      "\s*")
+    _CRE = re.compile(r"((?P<props>[\w\s]+)\s+)?"
+                      r"(?P<name>\w+)"
+                      r"\((?P<args>[^)]*)\)"
+                      r"\s*"
+                      r"(?:(?:(?P<fmt_trans>\".+),)?\s*(?P<fmt>\".+))?"
+                      r"\s*")
 
     _VALID_PROPS = set(["disable", "vcpu"])
 
@@ -326,7 +326,7 @@ def __repr__(self):
                                           fmt)
     # Star matching on PRI is dangerous as one might have multiple
     # arguments with that format, hence the non-greedy version of it.
-    _FMT = re.compile("(%[\d\.]*\w+|%.*?PRI\S+)")
+    _FMT = re.compile(r"(%[\d\.]*\w+|%.*?PRI\S+)")
 
     def formats(self):
         """List conversion specifiers in the argument print format string."""
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/format/log_stap.py
index 0b6549d534..b49afababd 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -83,7 +83,7 @@ def c_fmt_to_stap(fmt):
     # and "%ll" is not valid at all. Similarly the size_t
     # based "%z" size qualifier is not valid. We just
     # strip all size qualifiers for sanity.
-    fmt = re.sub("%(\d*)(l+|z)(x|u|d)", "%\\1\\3", "".join(bits))
+    fmt = re.sub(r"%(\d*)(l+|z)(x|u|d)", r"%\1\3", "".join(bits))
     return fmt
 
 def generate(events, backend, group):
-- 
2.39.2


