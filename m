Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9083AA55A3
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Apr 2025 22:39:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAEBj-0003rw-5D; Wed, 30 Apr 2025 16:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uAEBL-0003oP-QJ; Wed, 30 Apr 2025 16:37:28 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uAEBJ-00058o-E7; Wed, 30 Apr 2025 16:37:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso1635655e9.1; 
 Wed, 30 Apr 2025 13:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746045443; x=1746650243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZPHWbItOLLq7oJWYfhj5ZI7u0pe6utxrcw6MOXrzxsU=;
 b=NwKecXDke0ZLTAYm6FlhGKStgkUn9gPVFKsz+rM1+5WyQkdpZc7AihcZ1OnR+fsUTj
 wp10I0Iuxg47WnkkTHk6W5ve5Rq2auupenR9PMN+cVXo3tVCfEaPEvv4x0S8ijKD/zWL
 DI/869yC8tVL2Ulaj2C7AXb5SSG9ykWbmmimYWE9UlFdkvHka5AdF7FCTY66Y1PLvEs2
 KS+pNdc4k7iovZbJ1GFDN+byOyqoZf+/6vJlg/dRXb5eGPU0+o7Lkcv051KjatP3NrE8
 Zmt5+KX1h7SMigYxAyZQyXaBVmaVeDx/bBCanF7R4eXN0uwQ+9ESP9yU6+UuqESv0Kvs
 q1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746045443; x=1746650243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZPHWbItOLLq7oJWYfhj5ZI7u0pe6utxrcw6MOXrzxsU=;
 b=sGXB2je/vO5OwKx+QKiTofAkdc6PHLkzPknO7BUsgpO/PQWI43mBN2iwphv7pSZ2Xv
 rOhBnlQtG2+mjTh+fW6NPf6BBDGqB7zbIJiugoxuo1NrHRXUD5NlfQNcVI15c0kTWTRm
 PTtW7mqIYiHZsmz7N/ojsKxbr+HiXb4vwM4evuQSAca6DHY18kPmpEo/j5ThkRb9ZK5j
 gYa8YY7eD2RxVDsPpp6aYd4zbH2hqItha3Si2WweUWISmmzdnPddZ27sNh/W3VxR6IwD
 BVgZ/jkU2kaVNOqLPa12LqFZ6BiKG4mo33deqQ/LruHY1bCjjlCmouS2t08t6ucRSoa3
 jS6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVraH67AkrbkSdMlBLnD/bRP4Q+vHcb9xdok5MBV5yU8wBAMZegU2Yupulkb4ofG+QcRaaUMihBDIQi@nongnu.org
X-Gm-Message-State: AOJu0Yw5KG160o7LcxQ4Kag3e7az5ETs8uhp4tXg4ifAc9e7+zgHJL4K
 NevVtxgsBElFGXm5PX223oSMy5bZDfTI4RITFA6lZiZ0ovmyr0kr9oer56Eh
X-Gm-Gg: ASbGncsmENLvjEmM/gB6433GSEzmaZMJXWfMxdWJvqjOvFTVCG5GJHadoso2QidHTh5
 3vcdJ8SjnykThC4vUiLIB79CEaBfUHun10+vO2MPT4XhL7wuKbRS2RWvVv2f3RxFp2iA+mrtbW7
 7Ws0kJeGJ2D4qXaN+jUJDecTMgIsbwdfED/MdohwQ/T6XfTYCVg5wBaUG942/srD88AkKr54T6e
 Lzgg46YL73p7iogXgmglG4YJuGpBbBagjAehJFEClJMNxDTm2jJdRtOk4aNHKjbB4NJSLxRWt7z
 gyNmSrDwGmCHXEROKInnYHGdWXYp3Ctt4joBlhwHip6tXHzeDImEui3eKMdJVaKwaWpuVhG8RpA
 rikLJawthUBRpubYtfm/teUw=
X-Google-Smtp-Source: AGHT+IH1x65/ykbFbDmUhF4IXKiBRLdogEYGQqrn378SFsXrAXoYh44RxdjgZJ79wOwjxT8en+WxFg==
X-Received: by 2002:a05:600c:ccc:b0:43c:e2dd:98f3 with SMTP id
 5b1f17b1804b1-441b652f32amr3790715e9.21.1746045442968; 
 Wed, 30 Apr 2025 13:37:22 -0700 (PDT)
Received: from localhost.localdomain (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2bb3f72sm35455665e9.21.2025.04.30.13.37.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Apr 2025 13:37:22 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Nir Soffer <nirsof@gmail.com>
Subject: [PATCH v2 2/2] block/null: Add read-pattern option
Date: Wed, 30 Apr 2025 23:37:17 +0300
Message-Id: <20250430203717.16359-3-nirsof@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250430203717.16359-1-nirsof@gmail.com>
References: <20250430203717.16359-1-nirsof@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the `read-zeroes` is set, reads produce zeroes, and block status
return BDRV_BLOCK_ZERO, emulating a sparse image.

If we don't set `read-zeros` we report BDRV_BLOCK_DATA, but image data
is undefined; posix_memalign, _aligned_malloc, valloc, or memalign do
not promise to zero allocated memory.

When computing a blkhash of an image via qemu-nbd, we want to test 3
cases:

1. Sparse image: skip reading the entire image based on block status
   result, and use a pre-computed zero block hash.
2. Image full of zeroes: read the entire image, detect block full of
   zeroes and skip block hash computation.
3. Image full of data: read the entire image and compute a hash of all
   blocks.

This change adds `read-pattern` option. If the option is set, reads
produce the specified pattern. With this option we can emulate an image
full of zeroes or full of non-zeroes.

The following examples shows how the new option can be used with blksum
(or nbdcopy --blkhash) to compute a blkhash of an image using the
null-co driver.

Sparse image - the very fast path:

    % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/sparse.sock \
        "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '100g', 'read-zeroes': true}}" &

    % time blksum 'nbd+unix:///?socket=/tmp/sparse.sock'
    300ad1efddb063822fea65ae3174cd35320939d4d0b050613628c6e1e876f8f6  nbd+unix:///?socket=/tmp/sparse.sock
    blksum 'nbd+unix:///?socket=/tmp/sparse.sock'  0.05s user 0.01s system 92% cpu 0.061 total

Image full of zeros - same hash, 268 times slower:

    % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/zero.sock \
        "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '100g', 'read-pattern': 0}}" &

    % time blksum 'nbd+unix:///?socket=/tmp/zero.sock'
    300ad1efddb063822fea65ae3174cd35320939d4d0b050613628c6e1e876f8f6  nbd+unix:///?socket=/tmp/zero.sock
    blksum 'nbd+unix:///?socket=/tmp/zero.sock'  7.45s user 22.57s system 183% cpu 16.347 total

Image full of data - difference hash, heavy cpu usage:

    % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/data.sock \
        "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': '100g', 'read-pattern': 255}}" &

    % time blksum 'nbd+unix:///?socket=/tmp/data.sock'
    2c122b3ed28c83ede3c08485659fa9b56ee54ba1751db74d8ba9aa13d9866432  nbd+unix:///?socket=/tmp/data.sock
    blksum 'nbd+unix:///?socket=/tmp/data.sock'  46.05s user 14.15s system 448% cpu 13.414 total

Specifying both `read-zeroes` and `read-pattern` is an error since
`read-zeroes` implies a sparse image. Example errors:

    % ./qemu-img map --output json \
        "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'read-pattern': -1}}"
    qemu-img: Could not open 'json:{...}': read_pattern is out of range (0-255)

    % ./qemu-img map --output json \
        "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'read-pattern': 0, 'read-zeroes': true}}"
    qemu-img: Could not open 'json:{...}': The parameters read-zeroes and read-pattern are in conflict

Tested on top of
https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg05096.html.

Signed-off-by: Nir Soffer <nirsof@gmail.com>
---
 block/null.c                           | 34 +++++++++++++++++++++++++-
 docs/devel/secure-coding-practices.rst |  3 ++-
 qapi/block-core.json                   | 14 +++++++++--
 3 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/block/null.c b/block/null.c
index 7ba87bd9a9..62c1da2b07 100644
--- a/block/null.c
+++ b/block/null.c
@@ -22,11 +22,14 @@
 
 #define NULL_OPT_LATENCY "latency-ns"
 #define NULL_OPT_ZEROES  "read-zeroes"
+#define NULL_OPT_PATTERN  "read-pattern"
 
 typedef struct {
     int64_t length;
     int64_t latency_ns;
     bool read_zeroes;
+    bool has_read_pattern;
+    int read_pattern;
 } BDRVNullState;
 
 static QemuOptsList runtime_opts = {
@@ -49,6 +52,11 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_BOOL,
             .help = "return zeroes when read",
         },
+        {
+            .name = NULL_OPT_PATTERN,
+            .type = QEMU_OPT_NUMBER,
+            .help = "return pattern when read",
+        },
         { /* end of list */ }
     },
 };
@@ -85,6 +93,7 @@ static int null_open(BlockDriverState *bs, QDict *options, int flags,
     int ret = 0;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
+
     qemu_opts_absorb_qdict(opts, options, &error_abort);
     s->length =
         qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 1 << 30);
@@ -93,10 +102,28 @@ static int null_open(BlockDriverState *bs, QDict *options, int flags,
     if (s->latency_ns < 0) {
         error_setg(errp, "latency-ns is invalid");
         ret = -EINVAL;
+        goto out;
     }
     s->read_zeroes = qemu_opt_get_bool(opts, NULL_OPT_ZEROES, false);
-    qemu_opts_del(opts);
+    s->has_read_pattern = qemu_opt_find(opts, NULL_OPT_PATTERN) != NULL;
+    if (s->has_read_pattern) {
+        if (s->read_zeroes) {
+            error_setg(errp, "The parameters read-zeroes and read-pattern "
+                             "are in conflict");
+            ret = -EINVAL;
+            goto out;
+        }
+        s->read_pattern = qemu_opt_get_number(opts, NULL_OPT_PATTERN, 0);
+        if (s->read_pattern < 0 || s->read_pattern > UINT8_MAX) {
+            error_setg(errp, "read_pattern is out of range (0-%d)", UINT8_MAX);
+            ret = -EINVAL;
+            goto out;
+        }
+    }
     bs->supported_write_flags = BDRV_REQ_FUA;
+
+out:
+    qemu_opts_del(opts);
     return ret;
 }
 
@@ -125,6 +152,8 @@ static coroutine_fn int null_co_preadv(BlockDriverState *bs,
 
     if (s->read_zeroes) {
         qemu_iovec_memset(qiov, 0, 0, bytes);
+    } else if (s->has_read_pattern) {
+        qemu_iovec_memset(qiov, 0, s->read_pattern, bytes);
     }
 
     return null_co_common(bs);
@@ -199,6 +228,8 @@ static BlockAIOCB *null_aio_preadv(BlockDriverState *bs,
 
     if (s->read_zeroes) {
         qemu_iovec_memset(qiov, 0, 0, bytes);
+    } else if (s->has_read_pattern) {
+        qemu_iovec_memset(qiov, 0, s->read_pattern, bytes);
     }
 
     return null_aio_common(bs, cb, opaque);
@@ -272,6 +303,7 @@ null_co_get_allocated_file_size(BlockDriverState *bs)
 static const char *const null_strong_runtime_opts[] = {
     BLOCK_OPT_SIZE,
     NULL_OPT_ZEROES,
+    NULL_OPT_PATTERN,
 
     NULL
 };
diff --git a/docs/devel/secure-coding-practices.rst b/docs/devel/secure-coding-practices.rst
index 0454cc527e..73830684ea 100644
--- a/docs/devel/secure-coding-practices.rst
+++ b/docs/devel/secure-coding-practices.rst
@@ -111,5 +111,6 @@ Use of null-co block drivers
 The ``null-co`` block driver is designed for performance: its read accesses are
 not initialized by default. In case this driver has to be used for security
 research, it must be used with the ``read-zeroes=on`` option which fills read
-buffers with zeroes. Security issues reported with the default
+buffers with zeroes, or with the ``read-pattern=N`` option which fills read
+buffers with pattern. Security issues reported with the default
 (``read-zeroes=off``) will be discarded.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7c95c9e36a..2205ac9758 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3295,13 +3295,23 @@
 #
 # @read-zeroes: if true, emulate a sparse image, and reads from the
 #     device produce zeroes; if false, emulate an allocated image but
-#     reads from the device leave the buffer unchanged.
+#     reads from the device leave the buffer unchanged. Mutually
+#     exclusive with @read-pattern.
 #     (default: false; since: 4.1)
 #
+# @read-pattern: if set, emulate an allocated image, and reads from the
+#     device produce the specified byte value; if unset, reads from the
+#     device leave the buffer unchanged. Mutually exclusive with
+#     @read-zeroes.
+#     (since: 10.1)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsNull',
-  'data': { '*size': 'int', '*latency-ns': 'uint64', '*read-zeroes': 'bool' } }
+  'data': { '*size': 'int',
+            '*latency-ns': 'uint64',
+            '*read-zeroes': 'bool',
+            '*read-pattern': 'uint8' } }
 
 ##
 # @BlockdevOptionsNVMe:
-- 
2.39.5 (Apple Git-154)


