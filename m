Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAC9773671
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 04:21:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTCLg-0005ep-Az; Mon, 07 Aug 2023 22:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qTCLe-0005dx-EF
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:21:26 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qTCLb-0001Zq-CE
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:21:26 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id F2AA511EF84;
 Tue,  8 Aug 2023 02:21:21 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Thu, 27 Jul 2023 02:25:43 +0800
Subject: [PATCH QEMU v3 2/3] tests/migration: Introduce dirty-ring-size option
 into guestperf
MIME-Version: 1.0
Message-ID: <169146128144.15119.10176158487539386358-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <169146128144.15119.10176158487539386358-0@git.sr.ht>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Maintainers: Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman <yong.huang@smartx.com>;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~hyman <yong.huang@smartx.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>

Dirty ring size configuration is not supported by guestperf tool.

Introduce dirty-ring-size (ranges in [1024, 65536]) option so
developers can play with dirty-ring and dirty-limit feature easier.

To set dirty ring size with 4096 during migration test:
$ ./tests/migration/guestperf.py --dirty-ring-size 4096 xxx

Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
Message-Id: <169073391195.19893.610675378338110324-2@git.sr.ht>
---
 tests/migration/guestperf/engine.py   | 6 +++++-
 tests/migration/guestperf/hardware.py | 8 ++++++--
 tests/migration/guestperf/shell.py    | 6 +++++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/=
engine.py
index e69d16a62c..29ebb5011b 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -325,7 +325,6 @@ class Engine(object):
             cmdline =3D "'" + cmdline + "'"
=20
         argv =3D [
-            "-accel", "kvm",
             "-cpu", "host",
             "-kernel", self._kernel,
             "-initrd", self._initrd,
@@ -333,6 +332,11 @@ class Engine(object):
             "-m", str((hardware._mem * 1024) + 512),
             "-smp", str(hardware._cpus),
         ]
+        if hardware._dirty_ring_size:
+            argv.extend(["-accel", "kvm,dirty-ring-size=3D%s" %
+                         hardware._dirty_ring_size])
+        else:
+            argv.extend(["-accel", "kvm"])
=20
         argv.extend(self._get_qemu_serial_args())
=20
diff --git a/tests/migration/guestperf/hardware.py b/tests/migration/guestper=
f/hardware.py
index 3145785ffd..f779cc050b 100644
--- a/tests/migration/guestperf/hardware.py
+++ b/tests/migration/guestperf/hardware.py
@@ -23,7 +23,8 @@ class Hardware(object):
                  src_cpu_bind=3DNone, src_mem_bind=3DNone,
                  dst_cpu_bind=3DNone, dst_mem_bind=3DNone,
                  prealloc_pages =3D False,
-                 huge_pages=3DFalse, locked_pages=3DFalse):
+                 huge_pages=3DFalse, locked_pages=3DFalse,
+                 dirty_ring_size=3D0):
         self._cpus =3D cpus
         self._mem =3D mem # GiB
         self._src_mem_bind =3D src_mem_bind # List of NUMA nodes
@@ -33,6 +34,7 @@ class Hardware(object):
         self._prealloc_pages =3D prealloc_pages
         self._huge_pages =3D huge_pages
         self._locked_pages =3D locked_pages
+        self._dirty_ring_size =3D dirty_ring_size
=20
=20
     def serialize(self):
@@ -46,6 +48,7 @@ class Hardware(object):
             "prealloc_pages": self._prealloc_pages,
             "huge_pages": self._huge_pages,
             "locked_pages": self._locked_pages,
+            "dirty_ring_size": self._dirty_ring_size,
         }
=20
     @classmethod
@@ -59,4 +62,5 @@ class Hardware(object):
             data["dst_mem_bind"],
             data["prealloc_pages"],
             data["huge_pages"],
-            data["locked_pages"])
+            data["locked_pages"],
+            data["dirty_ring_size"])
diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestperf/s=
hell.py
index 8a809e3dda..7d6b8cd7cf 100644
--- a/tests/migration/guestperf/shell.py
+++ b/tests/migration/guestperf/shell.py
@@ -60,6 +60,8 @@ class BaseShell(object):
         parser.add_argument("--prealloc-pages", dest=3D"prealloc_pages", def=
ault=3DFalse)
         parser.add_argument("--huge-pages", dest=3D"huge_pages", default=3DF=
alse)
         parser.add_argument("--locked-pages", dest=3D"locked_pages", default=
=3DFalse)
+        parser.add_argument("--dirty-ring-size", dest=3D"dirty_ring_size",
+                            default=3D0, type=3Dint)
=20
         self._parser =3D parser
=20
@@ -89,7 +91,9 @@ class BaseShell(object):
=20
                         locked_pages=3Dargs.locked_pages,
                         huge_pages=3Dargs.huge_pages,
-                        prealloc_pages=3Dargs.prealloc_pages)
+                        prealloc_pages=3Dargs.prealloc_pages,
+
+                        dirty_ring_size=3Dargs.dirty_ring_size)
=20
=20
 class Shell(BaseShell):
--=20
2.38.5


