Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2355F7D129F
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:27:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtrOF-0003MI-Fk; Fri, 20 Oct 2023 11:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qtrOC-0003Ax-GR
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:26:16 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qtrOA-00068G-Q0
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:26:16 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c9e06f058bso15817805ad.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1697815453; x=1698420253;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTy7noxqV1LuTlA1Rq7Lol31NdpvxYfwqN+SZtKW4VA=;
 b=1P21k5waJEqibW2FSJpaQWJp+/nsWfUwPVvKGS4V42q3ENt0pWpaYzeyo8CP245W5b
 NSChzY8mVfvU8vCmMefiPaAoNOeTQ++Pmerco7L4RAXXagY3pPCte3G/F920Li8oVTGm
 PXJvwDnFnze+VSUykQ9jzPjs+mQP1Ub1qa9HDz3/AfSLq+ZYIE3N56a248qSpoxO802u
 abvaI03VVAyQl+HjThYrCPYPXklJJHo/RDYKIdgUhSSFV9rd/vR+DTDQZKPZu5mPuI52
 DnydZoydjvGkjN+LVGlibxRBdoH5ASx1Nf5PwGXp+0Lnuy0UhVtlb5qrbTL7ii3q5HKa
 owag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697815453; x=1698420253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iTy7noxqV1LuTlA1Rq7Lol31NdpvxYfwqN+SZtKW4VA=;
 b=QqErz2kazuI5/9hAclYQv2EBWiJP8CIvlBviOsRhgtI57fDHaduerrUzj2VvZoUppE
 r81NwprMN+z8BPXkR/JaiSz9mWvjTGReTM2zLAmJYxbfAuooQ0iVJVedgAgcBQkUZGVG
 X4C90rcvd4VqoIfcZpuguS240e15pc2wd+mwkc9wDXaiQOXA/O7LZtazqhyMHY9kaxUu
 zVYc1JjZxopm+2OvOMU4aOEX8nzrsct7LjV6ygb+sNxsPcUviXXTYL/c0vFzQzr+Sknl
 Rsp1rXW5Nk1cVplvoDAOjYOml/cdujaSxvgnW0onlCqK6D2UyfbXf2LQOQiKNrGFupLO
 JhmA==
X-Gm-Message-State: AOJu0YyuZCxN0I56Jnoboc9g2wOOcdlsjNP4Ekw8LtSVIfNJHS8/IOmh
 1ii0KkFs76Le1DUe8U9GtOFIyjzjk8NTGYcnFdyS3WEL
X-Google-Smtp-Source: AGHT+IFKR0KcSeAjgEA1w25Wup+FuDvZxM19b+1AlOTFKX7x4HK04U3sEOTuSn1RJZqQuTqczWFZ3g==
X-Received: by 2002:a17:902:d4c7:b0:1ca:3cd7:eadb with SMTP id
 o7-20020a170902d4c700b001ca3cd7eadbmr2558355plg.9.1697815453082; 
 Fri, 20 Oct 2023 08:24:13 -0700 (PDT)
Received: from localhost.localdomain ([171.216.79.181])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170902cec400b001c60d0a6d84sm1644824plg.127.2023.10.20.08.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 08:24:12 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v2 4/6] tests/migration: Introduce dirty-ring-size option into
 guestperf
Date: Fri, 20 Oct 2023 23:23:46 +0800
Message-Id: <bd9f195883fb5081f67f680bd2972a4b0a5b3520.1697815117.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1697815117.git.yong.huang@smartx.com>
References: <cover.1697815117.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Dirty ring size configuration is not supported by guestperf tool.

Introduce dirty-ring-size (ranges in [1024, 65536]) option so
developers can play with dirty-ring and dirty-limit feature easier.

To set dirty ring size with 4096 during migration test:
$ ./tests/migration/guestperf.py --dirty-ring-size 4096 xxx

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 tests/migration/guestperf/engine.py   | 6 +++++-
 tests/migration/guestperf/hardware.py | 8 ++++++--
 tests/migration/guestperf/shell.py    | 6 +++++-
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guestperf/engine.py
index da96ca034a..aabf6de4d9 100644
--- a/tests/migration/guestperf/engine.py
+++ b/tests/migration/guestperf/engine.py
@@ -325,7 +325,6 @@ def _get_common_args(self, hardware, tunnelled=False):
             cmdline = "'" + cmdline + "'"
 
         argv = [
-            "-accel", "kvm",
             "-cpu", "host",
             "-kernel", self._kernel,
             "-initrd", self._initrd,
@@ -333,6 +332,11 @@ def _get_common_args(self, hardware, tunnelled=False):
             "-m", str((hardware._mem * 1024) + 512),
             "-smp", str(hardware._cpus),
         ]
+        if hardware._dirty_ring_size:
+            argv.extend(["-accel", "kvm,dirty-ring-size=%s" %
+                         hardware._dirty_ring_size])
+        else:
+            argv.extend(["-accel", "kvm"])
 
         argv.extend(self._get_qemu_serial_args())
 
diff --git a/tests/migration/guestperf/hardware.py b/tests/migration/guestperf/hardware.py
index 3145785ffd..f779cc050b 100644
--- a/tests/migration/guestperf/hardware.py
+++ b/tests/migration/guestperf/hardware.py
@@ -23,7 +23,8 @@ def __init__(self, cpus=1, mem=1,
                  src_cpu_bind=None, src_mem_bind=None,
                  dst_cpu_bind=None, dst_mem_bind=None,
                  prealloc_pages = False,
-                 huge_pages=False, locked_pages=False):
+                 huge_pages=False, locked_pages=False,
+                 dirty_ring_size=0):
         self._cpus = cpus
         self._mem = mem # GiB
         self._src_mem_bind = src_mem_bind # List of NUMA nodes
@@ -33,6 +34,7 @@ def __init__(self, cpus=1, mem=1,
         self._prealloc_pages = prealloc_pages
         self._huge_pages = huge_pages
         self._locked_pages = locked_pages
+        self._dirty_ring_size = dirty_ring_size
 
 
     def serialize(self):
@@ -46,6 +48,7 @@ def serialize(self):
             "prealloc_pages": self._prealloc_pages,
             "huge_pages": self._huge_pages,
             "locked_pages": self._locked_pages,
+            "dirty_ring_size": self._dirty_ring_size,
         }
 
     @classmethod
@@ -59,4 +62,5 @@ def deserialize(cls, data):
             data["dst_mem_bind"],
             data["prealloc_pages"],
             data["huge_pages"],
-            data["locked_pages"])
+            data["locked_pages"],
+            data["dirty_ring_size"])
diff --git a/tests/migration/guestperf/shell.py b/tests/migration/guestperf/shell.py
index 8a809e3dda..7d6b8cd7cf 100644
--- a/tests/migration/guestperf/shell.py
+++ b/tests/migration/guestperf/shell.py
@@ -60,6 +60,8 @@ def __init__(self):
         parser.add_argument("--prealloc-pages", dest="prealloc_pages", default=False)
         parser.add_argument("--huge-pages", dest="huge_pages", default=False)
         parser.add_argument("--locked-pages", dest="locked_pages", default=False)
+        parser.add_argument("--dirty-ring-size", dest="dirty_ring_size",
+                            default=0, type=int)
 
         self._parser = parser
 
@@ -89,7 +91,9 @@ def split_map(value):
 
                         locked_pages=args.locked_pages,
                         huge_pages=args.huge_pages,
-                        prealloc_pages=args.prealloc_pages)
+                        prealloc_pages=args.prealloc_pages,
+
+                        dirty_ring_size=args.dirty_ring_size)
 
 
 class Shell(BaseShell):
-- 
2.39.1


