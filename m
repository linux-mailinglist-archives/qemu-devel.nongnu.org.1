Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5E87DE1E1
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 15:07:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyBsS-0007D8-TU; Wed, 01 Nov 2023 10:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qyBsP-00071F-Oq
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:07:22 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qyBsN-000531-Ln
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:07:21 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c9c5a1b87bso51236165ad.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 07:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1698847518; x=1699452318;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7oME3KOEZb3McazAQWqDny2CHSNqPtjniUl7qYB5jbg=;
 b=Mn3hiMl5uzvKnlSTGjiX39IkTYf8gI0+OfBExo8USMiYCb/Jlj2haGb+J0QpsmafmF
 Q+pqzWiUe5XvgMsrCue/sqlTlswwfbchQfDQlZ7/w/h05zg5jKykvy1GilD3PX9gX3Wr
 /Z1vEH8a8bxY35U+8qJgRhNT3/r9sUWacR5MSePK0awU8x0Wc+3AW7kWnqzWnGsvCeTy
 mX9pMZL5v4FOhGsDiwepP6yrmxXOLxF1bLGa0cFXI3WIhZNT2Fp1zDg/VPhK/p+10HsR
 ud9TPETJWfjYTOrzgZKPx/KZRL1IzDsQmojmQeUVmsnLMMUlTUnrvkSzfHLaDFypfsAn
 GxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698847518; x=1699452318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7oME3KOEZb3McazAQWqDny2CHSNqPtjniUl7qYB5jbg=;
 b=QxIdcqAkcFi47Fm5Kb4bAkDwnh//IeTFXlk1aElrXPd1GaJ4ZToY4XGfC32tJ0GjpA
 KBU8QnwU122BNBAQCDeUPFj6W1CYIu0KzrCf3NzBKEw61jJPRAXCstTbSQdyy2T22bFG
 dWlTjGR7SbC3PftvLt0nmgPbXBFO9ZVvDuH9ZxJkuhMSi3o8vd56nvuo+MfjcQHgOEfx
 4H5wlgGf/FMekK2X0ExHkvM3ta2BWk4yCifG8sSiUaOhC7JrFSBkuzZM4GYz85o+XAr+
 +UByfouijQAZrhWPgz9I2j3MhNtQ+1JdRBM8hJff7gONP36nw6+JUuRnNY4XAqAZELCh
 vpeA==
X-Gm-Message-State: AOJu0YyTpAxZJxluSPrhotfOl8xvavSIdngpK2SpO01s8ypUxSiHWewC
 3Sm7PdSlhJnu36yP/wmkt6xqP2564G5ljrwKcxgMrIDQ
X-Google-Smtp-Source: AGHT+IHj7oL1DL8SiSBV0sDH6Nd9z8kFtB4vHXqxgJSov4Kkm9vqjRDV2wj9yDC9UbQD4gFa2BWjaw==
X-Received: by 2002:a17:902:d50d:b0:1cc:3875:e654 with SMTP id
 b13-20020a170902d50d00b001cc3875e654mr9831592plg.26.1698847517750; 
 Wed, 01 Nov 2023 07:05:17 -0700 (PDT)
Received: from localhost.localdomain ([125.71.94.114])
 by smtp.gmail.com with ESMTPSA id
 jn7-20020a170903050700b001cc32261bdcsm1396118plb.248.2023.11.01.07.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 07:05:16 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 5/6] tests/migration: Introduce dirty-limit into guestperf
Date: Wed,  1 Nov 2023 22:04:08 +0800
Message-Id: <e1283565b00b34b0377bbd27bee4bb8fc7c255a8.1698847223.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1698847223.git.yong.huang@smartx.com>
References: <cover.1698847223.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
2.39.1


