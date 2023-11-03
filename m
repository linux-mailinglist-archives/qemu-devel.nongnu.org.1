Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7F77E0286
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 13:06:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qysvn-0007mk-Ak; Fri, 03 Nov 2023 08:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qysvB-0007R8-9C
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 08:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qysv9-0001X3-9P
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 08:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699013102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hRSHHwPnC2Z9YXzFyuFgbzYTpRZn4iKICC8SMLYuLFE=;
 b=YstK15IvBPuK0BrcjPYg0RhNukUjzYmacLPfpjrgEoPUX0Qm2NP3qp48Qwsohe0K2uWGXs
 rvyJ0nIDMtzxATb35ievpDoh2CWYgRQGrTXJW7rbNziydU6qakgwGiwK2yq+i8z+3r2GoI
 qhnuTOqyEnwQH3ICoki5Z8mUgFFE5dU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-mOSR6qidO6in4LrJJQIJmQ-1; Fri, 03 Nov 2023 08:05:01 -0400
X-MC-Unique: mOSR6qidO6in4LrJJQIJmQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12D8F828AC0;
 Fri,  3 Nov 2023 12:05:01 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64401492BE0;
 Fri,  3 Nov 2023 12:04:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>, Thomas Huth <thuth@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PULL 5/7] tests/migration: Introduce dirty-limit into guestperf
Date: Fri,  3 Nov 2023 13:04:46 +0100
Message-ID: <20231103120448.58428-6-quintela@redhat.com>
In-Reply-To: <20231103120448.58428-1-quintela@redhat.com>
References: <20231103120448.58428-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
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

From: Hyman Huang <yong.huang@smartx.com>

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

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <516e7a55dfc6e33d33510be37eb24223de5dc072.1697815117.git.yong.huang@smartx.com>
Message-ID: <e1283565b00b34b0377bbd27bee4bb8fc7c255a8.1698847223.git.yong.huang@smartx.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tests/migration/guestperf/comparison.py | 23 +++++++++++++++++++++++
 tests/migration/guestperf/engine.py     | 17 +++++++++++++++++
 tests/migration/guestperf/progress.py   | 16 ++++++++++++++--
 tests/migration/guestperf/scenario.py   | 11 ++++++++++-
 tests/migration/guestperf/shell.py      | 18 +++++++++++++++++-
 5 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/tests/migration/guestperf/comparison.py b/tests/migration/guestperf/comparison.py
index c03b3f6d7e..42cc0372d1 100644
--- a/tests/migration/guestperf/comparison.py
+++ b/tests/migration/guestperf/comparison.py
@@ -135,4 +135,27 @@ def __init__(self, name, scenarios):
         Scenario("compr-multifd-channels-64",
                  multifd=True, multifd_channels=64),
     ]),
+
+    # Looking at effect of dirty-limit with
+    # varying x_vcpu_dirty_limit_period
+    Comparison("compr-dirty-limit-period", scenarios = [
+        Scenario("compr-dirty-limit-period-500",
+                 dirty_limit=True, x_vcpu_dirty_limit_period=500),
+        Scenario("compr-dirty-limit-period-800",
+                 dirty_limit=True, x_vcpu_dirty_limit_period=800),
+        Scenario("compr-dirty-limit-period-1000",
+                 dirty_limit=True, x_vcpu_dirty_limit_period=1000),
+    ]),
+
+
+    # Looking at effect of dirty-limit with
+    # varying vcpu_dirty_limit
+    Comparison("compr-dirty-limit", scenarios = [
+        Scenario("compr-dirty-limit-10MB",
+                 dirty_limit=True, vcpu_dirty_limit=10),
+        Scenario("compr-dirty-limit-20MB",
+                 dirty_limit=True, vcpu_dirty_limit=20),
+        Scenario("compr-dirty-limit-50MB",
+                 dirty_limit=True, vcpu_dirty_limit=50),
+    ]),
 ]
diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
index aabf6de4d9..608d7270f6 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -102,6 +102,8 @@ def _migrate_progress(self, vm):
             info.get("expected-downtime", 0),
             info.get("setup-time", 0),
             info.get("cpu-throttle-percentage", 0),
+            info.get("dirty-limit-throttle-time-per-round", 0),
+            info.get("dirty-limit-ring-full-time", 0),
         )
 
     def _migrate(self, hardware, scenario, src, dst, connect_uri):
@@ -203,6 +205,21 @@ def _migrate(self, hardware, scenario, src, dst, connect_uri):
             resp = dst.cmd("migrate-set-parameters",
                            multifd_channels=scenario._multifd_channels)
 
+        if scenario._dirty_limit:
+            if not hardware._dirty_ring_size:
+                raise Exception("dirty ring size must be configured when "
+                                "testing dirty limit migration")
+
+            resp = src.cmd("migrate-set-capabilities",
+                           capabilities = [
+                               { "capability": "dirty-limit",
+                                 "state": True }
+                           ])
+            resp = src.cmd("migrate-set-parameters",
+                x_vcpu_dirty_limit_period=scenario._x_vcpu_dirty_limit_period)
+            resp = src.cmd("migrate-set-parameters",
+                           vcpu_dirty_limit=scenario._vcpu_dirty_limit)
+
         resp = src.cmd("migrate", uri=connect_uri)
 
         post_copy = False
diff --git a/tests/migration/guestperf/progress.py b/tests/migration/guestperf/progress.py
index ab1ee57273..d490584217 100644
--- a/tests/migration/guestperf/progress.py
+++ b/tests/migration/guestperf/progress.py
@@ -81,7 +81,9 @@ def __init__(self,
                  downtime,
                  downtime_expected,
                  setup_time,
-                 throttle_pcent):
+                 throttle_pcent,
+                 dirty_limit_throttle_time_per_round,
+                 dirty_limit_ring_full_time):
 
         self._status = status
         self._ram = ram
@@ -91,6 +93,10 @@ def __init__(self,
         self._downtime_expected = downtime_expected
         self._setup_time = setup_time
         self._throttle_pcent = throttle_pcent
+        self._dirty_limit_throttle_time_per_round = \
+            dirty_limit_throttle_time_per_round
+        self._dirty_limit_ring_full_time = \
+            dirty_limit_ring_full_time
 
     def serialize(self):
         return {
@@ -102,6 +108,10 @@ def serialize(self):
             "downtime_expected": self._downtime_expected,
             "setup_time": self._setup_time,
             "throttle_pcent": self._throttle_pcent,
+            "dirty_limit_throttle_time_per_round":
+                self._dirty_limit_throttle_time_per_round,
+            "dirty_limit_ring_full_time":
+                self._dirty_limit_ring_full_time,
         }
 
     @classmethod
@@ -114,4 +124,6 @@ def deserialize(cls, data):
             data["downtime"],
             data["downtime_expected"],
             data["setup_time"],
-            data["throttle_pcent"])
+            data["throttle_pcent"],
+            data["dirty_limit_throttle_time_per_round"],
+            data["dirty_limit_ring_full_time"])
diff --git a/tests/migration/guestperf/scenario.py b/tests/migration/guestperf/scenario.py
index de70d9b2f5..154c4f5d5f 100644
--- a/tests/migration/guestperf/scenario.py
+++ b/tests/migration/guestperf/scenario.py
@@ -30,7 +30,9 @@ def __init__(self, name,
                  auto_converge=False, auto_converge_step=10,
                  compression_mt=False, compression_mt_threads=1,
                  compression_xbzrle=False, compression_xbzrle_cache=10,
-                 multifd=False, multifd_channels=2):
+                 multifd=False, multifd_channels=2,
+                 dirty_limit=False, x_vcpu_dirty_limit_period=500,
+                 vcpu_dirty_limit=1):
 
         self._name = name
 
@@ -60,6 +62,10 @@ def __init__(self, name,
         self._multifd = multifd
         self._multifd_channels = multifd_channels
 
+        self._dirty_limit = dirty_limit
+        self._x_vcpu_dirty_limit_period = x_vcpu_dirty_limit_period
+        self._vcpu_dirty_limit = vcpu_dirty_limit
+
     def serialize(self):
         return {
             "name": self._name,
@@ -79,6 +85,9 @@ def serialize(self):
             "compression_xbzrle_cache": self._compression_xbzrle_cache,
             "multifd": self._multifd,
             "multifd_channels": self._multifd_channels,
+            "dirty_limit": self._dirty_limit,
+            "x_vcpu_dirty_limit_period": self._x_vcpu_dirty_limit_period,
+            "vcpu_dirty_limit": self._vcpu_dirty_limit,
         }
 
     @classmethod
diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestperf/shell.py
index 7d6b8cd7cf..c85d89efec 100644
--- a/tests/migration/guestperf/shell.py
+++ b/tests/migration/guestperf/shell.py
@@ -131,6 +131,17 @@ def __init__(self):
         parser.add_argument("--multifd-channels", dest="multifd_channels",
                             default=2, type=int)
 
+        parser.add_argument("--dirty-limit", dest="dirty_limit", default=False,
+                            action="store_true")
+
+        parser.add_argument("--x-vcpu-dirty-limit-period",
+                            dest="x_vcpu_dirty_limit_period",
+                            default=500, type=int)
+
+        parser.add_argument("--vcpu-dirty-limit",
+                            dest="vcpu_dirty_limit",
+                            default=1, type=int)
+
     def get_scenario(self, args):
         return Scenario(name="perfreport",
                         downtime=args.downtime,
@@ -154,7 +165,12 @@ def get_scenario(self, args):
                         compression_xbzrle_cache=args.compression_xbzrle_cache,
 
                         multifd=args.multifd,
-                        multifd_channels=args.multifd_channels)
+                        multifd_channels=args.multifd_channels,
+
+                        dirty_limit=args.dirty_limit,
+                        x_vcpu_dirty_limit_period=\
+                            args.x_vcpu_dirty_limit_period,
+                        vcpu_dirty_limit=args.vcpu_dirty_limit)
 
     def run(self, argv):
         args = self._parser.parse_args(argv)
-- 
2.41.0


