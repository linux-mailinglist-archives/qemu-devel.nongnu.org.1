Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6119F773672
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 04:22:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTCLf-0005e3-7V; Mon, 07 Aug 2023 22:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qTCLd-0005dh-9w
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:21:25 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qTCLb-0001Zt-7M
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:21:25 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 29AE611EFD1;
 Tue,  8 Aug 2023 02:21:22 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Thu, 27 Jul 2023 02:50:29 +0800
Subject: [PATCH QEMU v3 3/3] tests/migration: Introduce dirty-limit into
 guestperf
MIME-Version: 1.0
Message-ID: <169146128144.15119.10176158487539386358-3@git.sr.ht>
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

Currently, guestperf does not cover the dirty-limit
migration, support this feature.

Note that dirty-limit requires 'dirty-ring-size' set.

To enable dirty-limit, setting x-vcpu-dirty-limit-period
as 500ms and x-vcpu-dirty-limit as 10MB/s:
$ ./tests/migration/guestperf.py \
    --dirty-ring-size 4096 \
    --dirty-limit --x-vcpu-dirty-limit-period 500 \
    --vcpu-dirty-limit 10 --output output.json \

To run the entire standardized set of dirty-limit-enabled
comparisons, with unix migration:
$ ./tests/migration/guestperf-batch.py \
    --dirty-ring-size 4096 \
    --dst-host localhost --transport unix \
    --filter compr-dirty-limit* --output outputdir

Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
Message-Id: <169073391195.19893.610675378338110324-3@git.sr.ht>
---
 tests/migration/guestperf/comparison.py | 23 +++++++++++++++++++++++
 tests/migration/guestperf/engine.py     | 17 +++++++++++++++++
 tests/migration/guestperf/progress.py   | 16 ++++++++++++++--
 tests/migration/guestperf/scenario.py   | 11 ++++++++++-
 tests/migration/guestperf/shell.py      | 18 +++++++++++++++++-
 5 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/tests/migration/guestperf/comparison.py b/tests/migration/guestp=
erf/comparison.py
index c03b3f6d7e..42cc0372d1 100644
--- a/tests/migration/guestperf/comparison.py
+++ b/tests/migration/guestperf/comparison.py
@@ -135,4 +135,27 @@ COMPARISONS =3D [
         Scenario("compr-multifd-channels-64",
                  multifd=3DTrue, multifd_channels=3D64),
     ]),
+
+    # Looking at effect of dirty-limit with
+    # varying x_vcpu_dirty_limit_period
+    Comparison("compr-dirty-limit-period", scenarios =3D [
+        Scenario("compr-dirty-limit-period-500",
+                 dirty_limit=3DTrue, x_vcpu_dirty_limit_period=3D500),
+        Scenario("compr-dirty-limit-period-800",
+                 dirty_limit=3DTrue, x_vcpu_dirty_limit_period=3D800),
+        Scenario("compr-dirty-limit-period-1000",
+                 dirty_limit=3DTrue, x_vcpu_dirty_limit_period=3D1000),
+    ]),
+
+
+    # Looking at effect of dirty-limit with
+    # varying vcpu_dirty_limit
+    Comparison("compr-dirty-limit", scenarios =3D [
+        Scenario("compr-dirty-limit-10MB",
+                 dirty_limit=3DTrue, vcpu_dirty_limit=3D10),
+        Scenario("compr-dirty-limit-20MB",
+                 dirty_limit=3DTrue, vcpu_dirty_limit=3D20),
+        Scenario("compr-dirty-limit-50MB",
+                 dirty_limit=3DTrue, vcpu_dirty_limit=3D50),
+    ]),
 ]
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/=
engine.py
index 29ebb5011b..93a6f78e46 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -102,6 +102,8 @@ class Engine(object):
             info.get("expected-downtime", 0),
             info.get("setup-time", 0),
             info.get("cpu-throttle-percentage", 0),
+            info.get("dirty-limit-throttle-time-per-round", 0),
+            info.get("dirty-limit-ring-full-time", 0),
         )
=20
     def _migrate(self, hardware, scenario, src, dst, connect_uri):
@@ -203,6 +205,21 @@ class Engine(object):
             resp =3D dst.command("migrate-set-parameters",
                                multifd_channels=3Dscenario._multifd_channels)
=20
+        if scenario._dirty_limit:
+            if not hardware._dirty_ring_size:
+                raise Exception("dirty ring size must be configured when "
+                                "testing dirty limit migration")
+
+            resp =3D src.command("migrate-set-capabilities",
+                               capabilities =3D [
+                                   { "capability": "dirty-limit",
+                                     "state": True }
+                               ])
+            resp =3D src.command("migrate-set-parameters",
+                x_vcpu_dirty_limit_period=3Dscenario._x_vcpu_dirty_limit_per=
iod)
+            resp =3D src.command("migrate-set-parameters",
+                               vcpu_dirty_limit=3Dscenario._vcpu_dirty_limit)
+
         resp =3D src.command("migrate", uri=3Dconnect_uri)
=20
         post_copy =3D False
diff --git a/tests/migration/guestperf/progress.py b/tests/migration/guestper=
f/progress.py
index ab1ee57273..d490584217 100644
--- a/tests/migration/guestperf/progress.py
+++ b/tests/migration/guestperf/progress.py
@@ -81,7 +81,9 @@ class Progress(object):
                  downtime,
                  downtime_expected,
                  setup_time,
-                 throttle_pcent):
+                 throttle_pcent,
+                 dirty_limit_throttle_time_per_round,
+                 dirty_limit_ring_full_time):
=20
         self._status =3D status
         self._ram =3D ram
@@ -91,6 +93,10 @@ class Progress(object):
         self._downtime_expected =3D downtime_expected
         self._setup_time =3D setup_time
         self._throttle_pcent =3D throttle_pcent
+        self._dirty_limit_throttle_time_per_round =3D \
+            dirty_limit_throttle_time_per_round
+        self._dirty_limit_ring_full_time =3D \
+            dirty_limit_ring_full_time
=20
     def serialize(self):
         return {
@@ -102,6 +108,10 @@ class Progress(object):
             "downtime_expected": self._downtime_expected,
             "setup_time": self._setup_time,
             "throttle_pcent": self._throttle_pcent,
+            "dirty_limit_throttle_time_per_round":
+                self._dirty_limit_throttle_time_per_round,
+            "dirty_limit_ring_full_time":
+                self._dirty_limit_ring_full_time,
         }
=20
     @classmethod
@@ -114,4 +124,6 @@ class Progress(object):
             data["downtime"],
             data["downtime_expected"],
             data["setup_time"],
-            data["throttle_pcent"])
+            data["throttle_pcent"],
+            data["dirty_limit_throttle_time_per_round"],
+            data["dirty_limit_ring_full_time"])
diff --git a/tests/migration/guestperf/scenario.py b/tests/migration/guestper=
f/scenario.py
index de70d9b2f5..154c4f5d5f 100644
--- a/tests/migration/guestperf/scenario.py
+++ b/tests/migration/guestperf/scenario.py
@@ -30,7 +30,9 @@ class Scenario(object):
                  auto_converge=3DFalse, auto_converge_step=3D10,
                  compression_mt=3DFalse, compression_mt_threads=3D1,
                  compression_xbzrle=3DFalse, compression_xbzrle_cache=3D10,
-                 multifd=3DFalse, multifd_channels=3D2):
+                 multifd=3DFalse, multifd_channels=3D2,
+                 dirty_limit=3DFalse, x_vcpu_dirty_limit_period=3D500,
+                 vcpu_dirty_limit=3D1):
=20
         self._name =3D name
=20
@@ -60,6 +62,10 @@ class Scenario(object):
         self._multifd =3D multifd
         self._multifd_channels =3D multifd_channels
=20
+        self._dirty_limit =3D dirty_limit
+        self._x_vcpu_dirty_limit_period =3D x_vcpu_dirty_limit_period
+        self._vcpu_dirty_limit =3D vcpu_dirty_limit
+
     def serialize(self):
         return {
             "name": self._name,
@@ -79,6 +85,9 @@ class Scenario(object):
             "compression_xbzrle_cache": self._compression_xbzrle_cache,
             "multifd": self._multifd,
             "multifd_channels": self._multifd_channels,
+            "dirty_limit": self._dirty_limit,
+            "x_vcpu_dirty_limit_period": self._x_vcpu_dirty_limit_period,
+            "vcpu_dirty_limit": self._vcpu_dirty_limit,
         }
=20
     @classmethod
diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestperf/s=
hell.py
index 7d6b8cd7cf..c85d89efec 100644
--- a/tests/migration/guestperf/shell.py
+++ b/tests/migration/guestperf/shell.py
@@ -131,6 +131,17 @@ class Shell(BaseShell):
         parser.add_argument("--multifd-channels", dest=3D"multifd_channels",
                             default=3D2, type=3Dint)
=20
+        parser.add_argument("--dirty-limit", dest=3D"dirty_limit", default=
=3DFalse,
+                            action=3D"store_true")
+
+        parser.add_argument("--x-vcpu-dirty-limit-period",
+                            dest=3D"x_vcpu_dirty_limit_period",
+                            default=3D500, type=3Dint)
+
+        parser.add_argument("--vcpu-dirty-limit",
+                            dest=3D"vcpu_dirty_limit",
+                            default=3D1, type=3Dint)
+
     def get_scenario(self, args):
         return Scenario(name=3D"perfreport",
                         downtime=3Dargs.downtime,
@@ -154,7 +165,12 @@ class Shell(BaseShell):
                         compression_xbzrle_cache=3Dargs.compression_xbzrle_c=
ache,
=20
                         multifd=3Dargs.multifd,
-                        multifd_channels=3Dargs.multifd_channels)
+                        multifd_channels=3Dargs.multifd_channels,
+
+                        dirty_limit=3Dargs.dirty_limit,
+                        x_vcpu_dirty_limit_period=3D\
+                            args.x_vcpu_dirty_limit_period,
+                        vcpu_dirty_limit=3Dargs.vcpu_dirty_limit)
=20
     def run(self, argv):
         args =3D self._parser.parse_args(argv)
--=20
2.38.5

