Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA8BAC08A9
	for <lists+qemu-devel@lfdr.de>; Thu, 22 May 2025 11:28:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI2Cq-0004f4-U9; Thu, 22 May 2025 05:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uI2Cn-0004eu-8y
 for qemu-devel@nongnu.org; Thu, 22 May 2025 05:27:13 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uI2Ci-0005Fn-MB
 for qemu-devel@nongnu.org; Thu, 22 May 2025 05:27:12 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-442ed8a275fso97865555e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747906026; x=1748510826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dZz1dJNsJD0vu2hmJukjMk22LukA/Pf6RQDcoto72aI=;
 b=Re8JSVa0XkkNCx63pALKeKhyF016iTRaxlDU35dNQqDkSoeUxzLyyzwECp0d1wVech
 2seiwMp1FBKmZr+Hr+FOQbF1QEtiV3Y/VvTsh1G9NpbgHBGgBqiNzyTfQEOUiXLGO6SB
 l+hAx8TzdEEEer1VwWcOXtePgvjSvb6kwNJcwLYtIgYOtX5q4WvgcQOzVTGLzYdI7N37
 F1b+RRfzaD+VnsOTg7CB2mRrnS+5nwaiKS2PugNkt9wpOTDO2ZzavskZh0sjDSa8aoy8
 LBFjc2P0BF4LlMx3Enn97dgZCB4LYBUHT2XybqeiNMVWmqj79CFhCXtyj/xJW6Hluhrz
 Rlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747906026; x=1748510826;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dZz1dJNsJD0vu2hmJukjMk22LukA/Pf6RQDcoto72aI=;
 b=RIpS8sqA5UM4MBtCEUWsuVyUQbb79y0fJ3sLU4McIm/ZVnXKO8qCLW/4mN0K/Q79Aw
 5F3HcRvmlj6FL9rJq3MwDfixeRzYyL8nv6xUj0u3w8Z9c2tpJuCKazG/2cBnRgoCRdFg
 krikK++hPkNgPTx5+JTYjJkRS5wGe5jIunySyros1nPpFjCsihmCMzGEZaVw/LdYXJc9
 HJ0yOo+S2XoGkpGVmtfmrUgFV4YbIpFBDbvgFjvUWhlrKRXmLy3bBinDm4L1vkyXrf2i
 XVqTXh22FsDrqLXrFIHQaSA82CpiulTb3ZICAOGC6chCfnweTM0vErHXnD+bZAWwm3Ge
 4VCw==
X-Gm-Message-State: AOJu0YzpFgCUf6/vV2VwjT0oagFFstlq2lX5nKr7SzttWfwVkXT1uMaD
 FTRqcjdq/mPBsGOIg7lvOCvz5GGu6pQFvqcfJ8Y9tJuWFctuAucSUuoQGDBDIdaX
X-Gm-Gg: ASbGncsR6zRoy0zTBkArDobF4tM7qcRf+7evQF3wlzh8U88eEouMyONpieGQ4DM4hff
 Af2Lcmaaeg9ui8MdFGbgLfEvF/dJe0phdkOF4yvjmfxAT59EYDDL126Yw9XsEINrg+uPJFUNSZb
 Td9i++rWkJ+mo27iekXTB2hGrVovFQqenZmXO76DBCvvgTlQe1VJwlp/H8O1LLSZOerw81doGM4
 q43UpO3qJqUSsvOttYLsBY38SUpbCeebpZJWbUASwAjwCFGeQhFWb6Nvafm6LBFUBEzyZYU4yuw
 QCDYH5MQZWdx4zaN8+4hixBWWAnCqaaA1SPqIBkbWzc72fYK2oUvfVUckzHjYrWvS1hsJjZTOU8
 yAhYRbyEQ8hUXDGWl58gj7EPyPFaeCgT3110s6csx
X-Google-Smtp-Source: AGHT+IHHWE4nZdHoiz+htO0CPQAZuL/hMo/6d/xLQ4Geqalxl828rnWlqHv5iVE5vV6gTgXVwOOvdg==
X-Received: by 2002:a05:600c:34cf:b0:43d:1b95:6d0e with SMTP id
 5b1f17b1804b1-442fd664aa5mr205840885e9.23.1747906025664; 
 Thu, 22 May 2025 02:27:05 -0700 (PDT)
Received: from localhost (mac76-h03-89-88-247-135.dsl.sta.abo.bbox.fr.
 [89.88.247.135]) by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-447f3dd9c65sm103057325e9.39.2025.05.22.02.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 02:27:05 -0700 (PDT)
From: conte.souleymane@gmail.com
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, peter.maydell@linaro.org,
 Souleymane Conte <conte.souleymane@gmail.com>
Subject: [PATCH v3] docs/interop: convert text files to restructuredText
Date: Thu, 22 May 2025 09:26:22 +0000
Message-ID: <20250522092622.40869-1-conte.souleymane@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=conte.souleymane@gmail.com; helo=mail-wm1-x32a.google.com
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

From: Souleymane Conte <conte.souleymane@gmail.com>

buglink: https://gitlab.com/qemu-project/qemu/-/issues/527

Signed-off-by: Souleymane Conte <conte.souleymane@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
Changes since v2:
- Nested table rendering in code blocks
- monospace usage for all filenames, fields name and function references
- rendering of "\0" character using `` 

 docs/interop/index.rst                |   1 +
 docs/interop/{qcow2.txt => qcow2.rst} | 187 +++++++++++++++-----------
 2 files changed, 110 insertions(+), 78 deletions(-)
 rename docs/interop/{qcow2.txt => qcow2.rst} (90%)

diff --git a/docs/interop/index.rst b/docs/interop/index.rst
index 999e44eae1..5b9b0653b5 100644
--- a/docs/interop/index.rst
+++ b/docs/interop/index.rst
@@ -16,6 +16,7 @@ are useful for making QEMU interoperate with other software.
    live-block-operations
    nbd
    parallels
+   qcow2
    prl-xml
    pr-helper
    qmp-spec
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.rst
similarity index 90%
rename from docs/interop/qcow2.txt
rename to docs/interop/qcow2.rst
index 2c4618375a..6fc99e6b9a 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.rst
@@ -1,6 +1,8 @@
-== General ==
+================
+Qcow2 Image File
+================
 
-A qcow2 image file is organized in units of constant size, which are called
+A *qcow2* image file is organized in units of constant size, which are called
 (host) clusters. A cluster is the unit in which all allocations are done,
 both for actual guest data and for image metadata.
 
@@ -9,10 +11,10 @@ clusters of the same size.
 
 All numbers in qcow2 are stored in Big Endian byte order.
 
+Header
+------
 
-== Header ==
-
-The first cluster of a qcow2 image contains the file header:
+The first cluster of a qcow2 image contains the file header::
 
     Byte  0 -  3:   magic
                     QCOW magic string ("QFI\xfb")
@@ -38,7 +40,7 @@ The first cluster of a qcow2 image contains the file header:
                     within a cluster (1 << cluster_bits is the cluster size).
                     Must not be less than 9 (i.e. 512 byte clusters).
 
-                    Note: qemu as of today has an implementation limit of 2 MB
+                    Note: QEMU as of today has an implementation limit of 2 MB
                     as the maximum cluster size and won't be able to open images
                     with larger cluster sizes.
 
@@ -48,7 +50,7 @@ The first cluster of a qcow2 image contains the file header:
          24 - 31:   size
                     Virtual disk size in bytes.
 
-                    Note: qemu has an implementation limit of 32 MB as
+                    Note: QEMU has an implementation limit of 32 MB as
                     the maximum L1 table size.  With a 2 MB cluster
                     size, it is unable to populate a virtual cluster
                     beyond 2 EB (61 bits); with a 512 byte cluster
@@ -87,7 +89,8 @@ The first cluster of a qcow2 image contains the file header:
 
 For version 2, the header is exactly 72 bytes in length, and finishes here.
 For version 3 or higher, the header length is at least 104 bytes, including
-the next fields through header_length.
+the next fields through ``header_length``.
+::
 
          72 -  79:  incompatible_features
                     Bitmask of incompatible features. An implementation must
@@ -185,7 +188,8 @@ the next fields through header_length.
                     of 8.
 
 
-=== Additional fields (version 3 and higher) ===
+Additional fields (version 3 and higher)
+----------------------------------------
 
 In general, these fields are optional and may be safely ignored by the software,
 as well as filled by zeros (which is equal to field absence), if software needs
@@ -193,21 +197,25 @@ to set field B, but does not care about field A which precedes B. More
 formally, additional fields have the following compatibility rules:
 
 1. If the value of the additional field must not be ignored for correct
-handling of the file, it will be accompanied by a corresponding incompatible
-feature bit.
+   handling of the file, it will be accompanied by a corresponding incompatible
+   feature bit.
 
 2. If there are no unrecognized incompatible feature bits set, an unknown
-additional field may be safely ignored other than preserving its value when
-rewriting the image header.
+   additional field may be safely ignored other than preserving its value when
+   rewriting the image header.
+
+.. _ref_rules_3:
 
 3. An explicit value of 0 will have the same behavior as when the field is not
-present*, if not altered by a specific incompatible bit.
+   present*, if not altered by a specific incompatible bit.
 
-*. A field is considered not present when header_length is less than or equal
+(*) A field is considered not present when ``header_length`` is less than or equal
 to the field's offset. Also, all additional fields are not present for
 version 2.
 
-              104:  compression_type
+::
+
+        104:        compression_type
 
                     Defines the compression method used for compressed clusters.
                     All compressed clusters in an image use the same compression
@@ -219,8 +227,8 @@ version 2.
                     or must be zero (which means deflate).
 
                     Available compression type values:
-                        0: deflate <https://www.ietf.org/rfc/rfc1951.txt>
-                        1: zstd <http://github.com/facebook/zstd>
+                       - 0: deflate <https://www.ietf.org/rfc/rfc1951.txt>
+                       - 1: zstd <http://github.com/facebook/zstd>
 
                     The deflate compression type is called "zlib"
                     <https://www.zlib.net/> in QEMU. However, clusters with the
@@ -228,19 +236,21 @@ version 2.
 
         105 - 111:  Padding, contents defined below.
 
-=== Header padding ===
+Header padding
+--------------
 
-@header_length must be a multiple of 8, which means that if the end of the last
+``header_length`` must be a multiple of 8, which means that if the end of the last
 additional field is not aligned, some padding is needed. This padding must be
 zeroed, so that if some existing (or future) additional field will fall into
-the padding, it will be interpreted accordingly to point [3.] of the previous
+the padding, it will be interpreted accordingly to point `[3.] <#ref_rules_3>`_ of the previous
 paragraph, i.e.  in the same manner as when this field is not present.
 
 
-=== Header extensions ===
+Header extensions
+-----------------
 
 Directly after the image header, optional sections called header extensions can
-be stored. Each extension has a structure like the following:
+be stored. Each extension has a structure like the following::
 
     Byte  0 -  3:   Header extension type:
                         0x00000000 - End of the header extension area
@@ -270,17 +280,19 @@ data of compatible features that it doesn't support. Compatible features that
 need space for additional data can use a header extension.
 
 
-== String header extensions ==
+String header extensions
+------------------------
 
 Some header extensions (such as the backing file format name and the external
 data file name) are just a single string. In this case, the header extension
-length is the string length and the string is not '\0' terminated. (The header
-extension padding can make it look like a string is '\0' terminated, but
+length is the string length and the string is not ``\0`` terminated. (The header
+extension padding can make it look like a string is ``\0`` terminated, but
 neither is padding always necessary nor is there a guarantee that zero bytes
 are used for padding.)
 
 
-== Feature name table ==
+Feature name table
+------------------
 
 The feature name table is an optional header extension that contains the name
 for features used by the image. It can be used by applications that don't know
@@ -288,7 +300,7 @@ the respective feature (e.g. because the feature was introduced only later) to
 display a useful error message.
 
 The number of entries in the feature name table is determined by the length of
-the header extension data. Each entry look like this:
+the header extension data. Each entry looks like this::
 
     Byte       0:   Type of feature (select feature bitmap)
                         0: Incompatible feature
@@ -302,7 +314,8 @@ the header extension data. Each entry look like this:
                     terminated if it has full length)
 
 
-== Bitmaps extension ==
+Bitmaps extension
+-----------------
 
 The bitmaps extension is an optional header extension. It provides the ability
 to store bitmaps related to a virtual disk. For now, there is only one bitmap
@@ -310,9 +323,9 @@ type: the dirty tracking bitmap, which tracks virtual disk changes from some
 point in time.
 
 The data of the extension should be considered consistent only if the
-corresponding auto-clear feature bit is set, see autoclear_features above.
+corresponding auto-clear feature bit is set, see ``autoclear_features`` above.
 
-The fields of the bitmaps extension are:
+The fields of the bitmaps extension are::
 
     Byte  0 -  3:  nb_bitmaps
                    The number of bitmaps contained in the image. Must be
@@ -331,15 +344,17 @@ The fields of the bitmaps extension are:
                    Offset into the image file at which the bitmap directory
                    starts. Must be aligned to a cluster boundary.
 
-== Full disk encryption header pointer ==
+Full disk encryption header pointer
+-----------------------------------
 
 The full disk encryption header must be present if, and only if, the
-'crypt_method' header requires metadata. Currently this is only true
-of the 'LUKS' crypt method. The header extension must be absent for
+``crypt_method`` header requires metadata. Currently this is only true
+of the *LUKS* crypt method. The header extension must be absent for
 other methods.
 
 This header provides the offset at which the crypt method can store
 its additional data, as well as the length of such data.
+::
 
     Byte  0 -  7:   Offset into the image file at which the encryption
                     header starts in bytes. Must be aligned to a cluster
@@ -357,10 +372,10 @@ The first 592 bytes of the header clusters will contain the LUKS
 partition header. This is then followed by the key material data areas.
 The size of the key material data areas is determined by the number of
 stripes in the key slot and key size. Refer to the LUKS format
-specification ('docs/on-disk-format.pdf' in the cryptsetup source
+specification (*docs/on-disk-format.pdf* in the cryptsetup source
 package) for details of the LUKS partition header format.
 
-In the LUKS partition header, the "payload-offset" field will be
+In the LUKS partition header, the ``payload-offset`` field will be
 calculated as normal for the LUKS spec. ie the size of the LUKS
 header, plus key material regions, plus padding, relative to the
 start of the LUKS header. This offset value is not required to be
@@ -369,11 +384,12 @@ context of qcow2, since the qcow2 file format itself defines where
 the real payload offset is, but none the less a valid payload offset
 should always be present.
 
-In the LUKS key slots header, the "key-material-offset" is relative
+In the LUKS key slots header, the ``key-material-offset`` is relative
 to the start of the LUKS header clusters in the qcow2 container,
 not the start of the qcow2 file.
 
 Logically the layout looks like
+::
 
   +-----------------------------+
   | QCow2 header                |
@@ -405,7 +421,8 @@ Logically the layout looks like
   |                             |
   +-----------------------------+
 
-== Data encryption ==
+Data encryption
+---------------
 
 When an encryption method is requested in the header, the image payload
 data must be encrypted/decrypted on every write/read. The image headers
@@ -413,7 +430,7 @@ and metadata are never encrypted.
 
 The algorithms used for encryption vary depending on the method
 
- - AES:
+ - **AES**:
 
    The AES cipher, in CBC mode, with 256 bit keys.
 
@@ -425,7 +442,7 @@ The algorithms used for encryption vary depending on the method
    supported in the command line tools for the sake of back compatibility
    and data liberation.
 
- - LUKS:
+ - **LUKS**:
 
    The algorithms are specified in the LUKS header.
 
@@ -433,7 +450,8 @@ The algorithms used for encryption vary depending on the method
    in the LUKS header, with the physical disk sector as the
    input tweak.
 
-== Host cluster management ==
+Host cluster management
+-----------------------
 
 qcow2 manages the allocation of host clusters by maintaining a reference count
 for each host cluster. A refcount of 0 means that the cluster is free, 1 means
@@ -453,14 +471,15 @@ Although a large enough refcount table can reserve clusters past 64 PB
 large), note that some qcow2 metadata such as L1/L2 tables must point
 to clusters prior to that point.
 
-Note: qemu has an implementation limit of 8 MB as the maximum refcount
-table size.  With a 2 MB cluster size and a default refcount_order of
-4, it is unable to reference host resources beyond 2 EB (61 bits); in
-the worst case, with a 512 cluster size and refcount_order of 6, it is
-unable to access beyond 32 GB (35 bits).
+.. note::
+    QEMU has an implementation limit of 8 MB as the maximum refcount
+    table size.  With a 2 MB cluster size and a default refcount_order of
+    4, it is unable to reference host resources beyond 2 EB (61 bits); in
+    the worst case, with a 512 cluster size and refcount_order of 6, it is
+    unable to access beyond 32 GB (35 bits).
 
 Given an offset into the image file, the refcount of its cluster can be
-obtained as follows:
+obtained as follows::
 
     refcount_block_entries = (cluster_size * 8 / refcount_bits)
 
@@ -470,7 +489,7 @@ obtained as follows:
     refcount_block = load_cluster(refcount_table[refcount_table_index]);
     return refcount_block[refcount_block_index];
 
-Refcount table entry:
+Refcount table entry::
 
     Bit  0 -  8:    Reserved (set to 0)
 
@@ -482,14 +501,15 @@ Refcount table entry:
                     been allocated. All refcounts managed by this refcount block
                     are 0.
 
-Refcount block entry (x = refcount_bits - 1):
+Refcount block entry ``(x = refcount_bits - 1)``::
 
     Bit  0 -  x:    Reference count of the cluster. If refcount_bits implies a
                     sub-byte width, note that bit 0 means the least significant
                     bit in this context.
 
 
-== Cluster mapping ==
+Cluster mapping
+---------------
 
 Just as for refcounts, qcow2 uses a two-level structure for the mapping of
 guest clusters to host clusters. They are called L1 and L2 table.
@@ -509,7 +529,7 @@ compressed clusters to reside below 512 TB (49 bits), and this limit
 cannot be relaxed without an incompatible layout change).
 
 Given an offset into the virtual disk, the offset into the image file can be
-obtained as follows:
+obtained as follows::
 
     l2_entries = (cluster_size / sizeof(uint64_t))        [*]
 
@@ -523,7 +543,7 @@ obtained as follows:
 
     [*] this changes if Extended L2 Entries are enabled, see next section
 
-L1 table entry:
+L1 table entry::
 
     Bit  0 -  8:    Reserved (set to 0)
 
@@ -538,7 +558,7 @@ L1 table entry:
                     refcount is exactly one. This information is only accurate
                     in the active L1 table.
 
-L2 table entry:
+L2 table entry::
 
     Bit  0 -  61:   Cluster descriptor
 
@@ -555,7 +575,7 @@ L2 table entry:
                     mapping for guest cluster offsets), so this bit should be 1
                     for all allocated clusters.
 
-Standard Cluster Descriptor:
+Standard Cluster Descriptor::
 
     Bit       0:    If set to 1, the cluster reads as all zeros. The host
                     cluster offset can be used to describe a preallocation,
@@ -577,7 +597,7 @@ Standard Cluster Descriptor:
         56 - 61:    Reserved (set to 0)
 
 
-Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
+Compressed Clusters Descriptor ``(x = 62 - (cluster_bits - 8))``::
 
     Bit  0 - x-1:   Host cluster offset. This is usually _not_ aligned to a
                     cluster or sector boundary!  If cluster_bits is
@@ -601,7 +621,8 @@ file (except if bit 0 in the Standard Cluster Descriptor is set). If there is
 no backing file or the backing file is smaller than the image, they shall read
 zeros for all parts that are not covered by the backing file.
 
-== Extended L2 Entries ==
+Extended L2 Entries
+-------------------
 
 An image uses Extended L2 Entries if bit 4 is set on the incompatible_features
 field of the header.
@@ -615,6 +636,8 @@ subclusters so they are treated the same as in images without this feature.
 The size of an extended L2 entry is 128 bits so the number of entries per table
 is calculated using this formula:
 
+.. code::
+
     l2_entries = (cluster_size / (2 * sizeof(uint64_t)))
 
 The first 64 bits have the same format as the standard L2 table entry described
@@ -623,7 +646,7 @@ descriptor.
 
 The last 64 bits contain a subcluster allocation bitmap with this format:
 
-Subcluster Allocation Bitmap (for standard clusters):
+Subcluster Allocation Bitmap (for standard clusters)::
 
     Bit  0 - 31:    Allocation status (one bit per subcluster)
 
@@ -647,13 +670,14 @@ Subcluster Allocation Bitmap (for standard clusters):
                     Bits are assigned starting from the least significant
                     one (i.e. bit x is used for subcluster x - 32).
 
-Subcluster Allocation Bitmap (for compressed clusters):
+Subcluster Allocation Bitmap (for compressed clusters)::
 
     Bit  0 - 63:    Reserved (set to 0)
                     Compressed clusters don't have subclusters,
                     so this field is not used.
 
-== Snapshots ==
+Snapshots
+---------
 
 qcow2 supports internal snapshots. Their basic principle of operation is to
 switch the active L1 table, so that a different set of host clusters are
@@ -672,7 +696,7 @@ in the image file, whose starting offset and length are given by the header
 fields snapshots_offset and nb_snapshots. The entries of the snapshot table
 have variable length, depending on the length of ID, name and extra data.
 
-Snapshot table entry:
+Snapshot table entry::
 
     Byte 0 -  7:    Offset into the image file at which the L1 table for the
                     snapshot starts. Must be aligned to a cluster boundary.
@@ -728,7 +752,8 @@ Snapshot table entry:
                     next multiple of 8.
 
 
-== Bitmaps ==
+Bitmaps
+-------
 
 As mentioned above, the bitmaps extension provides the ability to store bitmaps
 related to a virtual disk. This section describes how these bitmaps are stored.
@@ -739,20 +764,23 @@ each bitmap size is equal to the virtual disk size.
 Each bit of the bitmap is responsible for strictly defined range of the virtual
 disk. For bit number bit_nr the corresponding range (in bytes) will be:
 
+.. code::
+
     [bit_nr * bitmap_granularity .. (bit_nr + 1) * bitmap_granularity - 1]
 
 Granularity is a property of the concrete bitmap, see below.
 
 
-=== Bitmap directory ===
+Bitmap directory
+----------------
 
 Each bitmap saved in the image is described in a bitmap directory entry. The
 bitmap directory is a contiguous area in the image file, whose starting offset
-and length are given by the header extension fields bitmap_directory_offset and
-bitmap_directory_size. The entries of the bitmap directory have variable
+and length are given by the header extension fields ``bitmap_directory_offset`` and
+``bitmap_directory_size``. The entries of the bitmap directory have variable
 length, depending on the lengths of the bitmap name and extra data.
 
-Structure of a bitmap directory entry:
+Structure of a bitmap directory entry::
 
     Byte 0 -  7:    bitmap_table_offset
                     Offset into the image file at which the bitmap table
@@ -833,7 +861,8 @@ Structure of a bitmap directory entry:
                     next multiple of 8. All bytes of the padding must be zero.
 
 
-=== Bitmap table ===
+Bitmap table
+------------
 
 Each bitmap is stored using a one-level structure (as opposed to two-level
 structures like for refcounts and guest clusters mapping) for the mapping of
@@ -843,7 +872,7 @@ Each bitmap table has a variable size (stored in the bitmap directory entry)
 and may use multiple clusters, however, it must be contiguous in the image
 file.
 
-Structure of a bitmap table entry:
+Structure of a bitmap table entry::
 
     Bit       0:    Reserved and must be zero if bits 9 - 55 are non-zero.
                     If bits 9 - 55 are zero:
@@ -860,11 +889,12 @@ Structure of a bitmap table entry:
         56 - 63:    Reserved and must be zero.
 
 
-=== Bitmap data ===
+Bitmap data
+-----------
 
 As noted above, bitmap data is stored in separate clusters, described by the
 bitmap table. Given an offset (in bytes) into the bitmap data, the offset into
-the image file can be obtained as follows:
+the image file can be obtained as follows::
 
     image_offset(bitmap_data_offset) =
         bitmap_table[bitmap_data_offset / cluster_size] +
@@ -875,7 +905,7 @@ above).
 
 Given an offset byte_nr into the virtual disk and the bitmap's granularity, the
 bit offset into the image file to the corresponding bit of the bitmap can be
-calculated like this:
+calculated like this::
 
     bit_offset(byte_nr) =
         image_offset(byte_nr / granularity / 8) * 8 +
@@ -886,21 +916,22 @@ last cluster of the bitmap data contains some unused tail bits. These bits must
 be zero.
 
 
-=== Dirty tracking bitmaps ===
+Dirty tracking bitmaps
+----------------------
 
-Bitmaps with 'type' field equal to one are dirty tracking bitmaps.
+Bitmaps with *type* field equal to one are dirty tracking bitmaps.
 
-When the virtual disk is in use dirty tracking bitmap may be 'enabled' or
-'disabled'. While the bitmap is 'enabled', all writes to the virtual disk
+When the virtual disk is in use dirty tracking bitmap may be *enabled* or
+*disabled*. While the bitmap is *enabled*, all writes to the virtual disk
 should be reflected in the bitmap. A set bit in the bitmap means that the
 corresponding range of the virtual disk (see above) was written to while the
-bitmap was 'enabled'. An unset bit means that this range was not written to.
+bitmap was *enabled*. An unset bit means that this range was not written to.
 
 The software doesn't have to sync the bitmap in the image file with its
-representation in RAM after each write or metadata change. Flag 'in_use'
+representation in RAM after each write or metadata change. Flag *in_use*
 should be set while the bitmap is not synced.
 
-In the image file the 'enabled' state is reflected by the 'auto' flag. If this
-flag is set, the software must consider the bitmap as 'enabled' and start
+In the image file the *enabled* state is reflected by the *auto* flag. If this
+flag is set, the software must consider the bitmap as *enabled* and start
 tracking virtual disk changes to this bitmap from the first write to the
 virtual disk. If this flag is not set then the bitmap is disabled.
-- 
2.49.0


