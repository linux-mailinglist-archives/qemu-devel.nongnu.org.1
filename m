Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A65A7DE1E2
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 15:08:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyBsR-000712-Ei; Wed, 01 Nov 2023 10:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qyBsF-0006kL-6d
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:07:15 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qyBsD-00051V-EZ
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:07:10 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5b8f68ba4e5so5140786a12.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 07:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1698847507; x=1699452307;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cc8ZFmhuIWug9407LFYZb+0PYqyjOubXmvaa6UFG79Y=;
 b=AgkV5A5ih2bHeZRTB+BuGjTeSU8JLkYhwYIDMs4iLGfna9j4yes+M9Rx1iluSVEuCL
 tvjQmCKcRUGBLx3Y23k1cws5OBd0VE4hPHV0lpsqlE564RcNSe+v9/iwklYiY2sfUE0R
 fFx2QozDiiD9mkxQLlBdYwVRDnxByN6vLx7RK2t5nTjf+pSUvHB8Ph9KEClwLfFgv/FR
 diXA1fJckpwXhe4m8kzOlVn/sLvNKtDsZ/1mOsgbgj2drnJzT+DEavvl+SHpP+082qt8
 xuPlHABQuB533ldBt3N5/rAL7jnkprLZpBmQKgZJZNLYzvd4v5XdTyKUhLEzsHBSE7hK
 5lnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698847507; x=1699452307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cc8ZFmhuIWug9407LFYZb+0PYqyjOubXmvaa6UFG79Y=;
 b=OzDpRZTZwu4VpXHVakZGQc9RVUdh5bayq4W7c7QRpvtBMOyc2GR+W+Rayavvn0xceZ
 TCRkSLV3xEOIpbwWCA0464Uc9aTlsU2y9Vqv5D/CtEq7ApdoBZQ0skKXe84Mcp8sgIJT
 C5zncYe4brDzpqpJxE16zSWkpmSMVR4b/1nFvNk7wN1GEpUvl85SusRbShgvDFems3ZD
 9znSFVIG7y+ZLbt46rJyHiiIiG3HTCk+EOtncmAyN5XJ84c5Az4QhnXNhs26TU8FLfBP
 lx6hw9lK8k3FBx8tG7C72iXhH1m63APMBIU5u8QsKoVKDIDG2PhWJB9ZVXKBQt667Mkl
 sxqg==
X-Gm-Message-State: AOJu0YzmDkD9IDNUCmA44QO5Syg9TRyqhTPqSyhCuiwxmOxOjB1/PIMv
 U8aOpLOYTD6AK3kCmTJh3OMePVC2igNqk4jaY3fmDB89
X-Google-Smtp-Source: AGHT+IEdqzDVcAXevULPFVQ3VAO7/KBnNOXKyBhXRn9kqL9hcN4w8LMSoS94fCH7f0d37n3NYmGMQA==
X-Received: by 2002:a17:903:2291:b0:1cc:4fe8:c6c8 with SMTP id
 b17-20020a170903229100b001cc4fe8c6c8mr8784720plh.6.1698847506737; 
 Wed, 01 Nov 2023 07:05:06 -0700 (PDT)
Received: from localhost.localdomain ([125.71.94.114])
 by smtp.gmail.com with ESMTPSA id
 jn7-20020a170903050700b001cc32261bdcsm1396118plb.248.2023.11.01.07.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 07:05:06 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 4/6] tests/migration: Introduce dirty-ring-size option into
 guestperf
Date: Wed,  1 Nov 2023 22:04:07 +0800
Message-Id: <8a388cec5c1f73a34d42515bbc43837e97ee3839.1698847223.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1698847223.git.yong.huang@smartx.com>
References: <cover.1698847223.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x529.google.com
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

Dirty ring size configuration is not supported by guestperf tool.

Introduce dirty-ring-size (ranges in [1024, 65536]) option so
developers can play with dirty-ring and dirty-limit feature easier.

To set dirty ring size with 4096 during migration test:
$ ./tests/migration/guestperf.py --dirty-ring-size 4096 xxx

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <bd9f195883fb5081f67f680bd2972a4b0a5b3520.1697815117.git.yong.huang@smartx.com>
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


