Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A35217CC1F5
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:40:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsiQ6-0003HG-M8; Tue, 17 Oct 2023 07:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qsiQ4-0003F5-R5
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:39:28 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qsiQ2-00016r-Fe
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:39:28 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-57be3d8e738so3177665eaf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 04:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1697542644; x=1698147444;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTy7noxqV1LuTlA1Rq7Lol31NdpvxYfwqN+SZtKW4VA=;
 b=Fd5UKu5pUh4rVV/XswdUneTmN1ftFd2QhZwXacrFjF1jTCmdbvLeoX8eBkuHPIVtu4
 fUi76W4qG4AYxH8+PU22ea3/wLJevHdfM0Yi1qzaPinYl76Kqhvhr2SLo/DoEN5bj6Qu
 GDUktZ8I6uSG3CpG6TvnWr6oDZI9qmwxkfrvxfngQECeGdKIxLqAyg48aZHjW+bV5HeJ
 dtFpp4KDH61nIUzhNjRjpVgMaWIKjLisrlbDd/Fl/L7SP88EVsxdeBtkmEH20cNN68PX
 U/YAsZSgtFWvAd5mH/i26Qm0SIQV6BvXijNsTd2YQmzlgTOCll3BYueLhxjXMTxy4jEh
 9dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697542644; x=1698147444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iTy7noxqV1LuTlA1Rq7Lol31NdpvxYfwqN+SZtKW4VA=;
 b=TOmnjay5y7PzhweOKa2ZMshGyoZtNdQ/EmNpoUo0L+XQ1hv+cl7nl1bYNzas7FvGI3
 H6F7AkDxWjvCOTSQ3avXQJpKaTsC5quXUPxC2fEJIW2kxlBlmuhK0XlWDhxaWYFZbwrl
 wqNwNe5a3A6eFTQzvTV2J3ukR2cHf6b9jJMtPZfyXO53sHlArUhonCbANdbbxHi58MI3
 TOfjRAKBo0S+D5uqK9VwOxT+aL3s4uIt8Z5pEDN+09FuRQqbAVHc49ipHS5DMjuP/xoa
 RqBTr15Vuz3Jc5SvqxeOa/VmwNLZp6Lf4g6HBspGffFYDZhE+nrN0m1Z0WQHzZHy6J4i
 +gGQ==
X-Gm-Message-State: AOJu0YwZOdiiyVtk/fpLLCNsh/UtR6MVFZKwRw60k+R40aUdKti91orM
 c+0vbDb8iOTK2iWD1zr5zo1qsIVCZWOLGoMI8cFDW2yB
X-Google-Smtp-Source: AGHT+IHgLuGPLW6f0+Lfha5rCb/3S5D95LPeFhmzIxpQCvrjQ8qZYvtgbnCg8v+wOEFjbxEf9z8dSQ==
X-Received: by 2002:a05:6358:7aa:b0:142:fd2b:da2e with SMTP id
 n42-20020a05635807aa00b00142fd2bda2emr1748958rwj.31.1697542644476; 
 Tue, 17 Oct 2023 04:37:24 -0700 (PDT)
Received: from localhost.localdomain ([171.216.79.181])
 by smtp.gmail.com with ESMTPSA id
 x28-20020aa79a5c000000b00692c5b1a731sm1198647pfj.186.2023.10.17.04.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 04:37:23 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH 4/6] tests/migration: Introduce dirty-ring-size option into
 guestperf
Date: Tue, 17 Oct 2023 19:36:07 +0800
Message-Id: <cea2393f3864462e27985a2c69076a3f27ed6f6f.1697502089.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1697502089.git.yong.huang@smartx.com>
References: <cover.1697502089.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c34;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc34.google.com
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


