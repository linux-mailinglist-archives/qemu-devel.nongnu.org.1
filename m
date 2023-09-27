Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FE77B07E6
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:14:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWD7-0003DF-Om; Wed, 27 Sep 2023 11:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWD2-0003AZ-KM
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:12:16 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWD0-0005kv-2c
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:12:16 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32320381a07so7121527f8f.0
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 08:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695827531; x=1696432331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UISaehvY3Zuvf6THCkTxk/dIC8QLdbJZ/PWTHGaPP6k=;
 b=pUHJlE2cK2QWlNpgDLC0VTDF1+JqXFOBCJ5ZeGkQdFYdRWY6Zf4CjxjJLKRh4Z6Mz9
 1g56W6hDDJhAaWjWmQQS+5zaZQUd0HEPcXzyblxeqNRW1qINzpQcaoGV4pdd2HxpIXRz
 ie3hSxo1AnmT31h8QoDhIkumAXQ5Drfcrxcr91i5bht+SDN9RC7CN38WRR/b9mz8cU/I
 3xX+CznHj4a5TnjizXq0D+gIoZr6xeraBaNd1y/++mAj5IrJHv2co+kQgkKnB5aeIkJj
 qmxRqI683mrSat6cWRRWB0K3uglOcYqodGLCjlZXN7Rpu5b0NbnBeIB1rIOPyA2u2LhJ
 rfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695827531; x=1696432331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UISaehvY3Zuvf6THCkTxk/dIC8QLdbJZ/PWTHGaPP6k=;
 b=MVE72eLyPWn+RdyrebljlppnI8a3+T8+qMua7qNSCfUPgyTHGm+HknzxfXY1c9V943
 9EA96JnYTh6DGlCpG8byvTltHkNhboLBq3eD99Kkn4U99ULzP9LSSRP3VcCADUlWy98L
 hPMOMeRu7qTRT3PDQdx+y47vkVIS6Y9fLCB29wQctGl2ZvwTjD3DPC/u+R/cHn1mdFbj
 I/yUsbD5FyZBmzIVzwVy7pIL4zVvhDpkf08W0GSmWG1GIIyNrEJhR81kRUIrl/Se4r/c
 Ez7n9MlTQVXx+kCHVx+4MJhwSVbf6dn+2g/4ngZrGxOAtFzPrf8qWhrJy3KWSvaY/1BA
 bPmw==
X-Gm-Message-State: AOJu0YyGtfMZjNEAJfzl84FeYzsH3VbjgM+SIz5WhLtJpef83V2pMp+B
 wZ2xktVVi6h9saNzp5WjHRjkTbcEyVnwPMq16hw=
X-Google-Smtp-Source: AGHT+IGjTvIQFdwcsedxjHsfgof/xSI5zk2PSW1CeSf5eGb4HS+7er3u+TZnBa7s01wlvw0UF5LZpw==
X-Received: by 2002:adf:e3c6:0:b0:321:6dc9:14d4 with SMTP id
 k6-20020adfe3c6000000b003216dc914d4mr2157913wrm.19.1695827530818; 
 Wed, 27 Sep 2023 08:12:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a1c7209000000b00401bbfb9b2bsm467474wmc.0.2023.09.27.08.12.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 08:12:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/8] docs/specs/vmcoreinfo: Convert to rST
Date: Wed, 27 Sep 2023 16:12:04 +0100
Message-Id: <20230927151205.70930-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927151205.70930-1-peter.maydell@linaro.org>
References: <20230927151205.70930-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Convert docs/specs/vmcoreinfo.txt to rST format.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                                   |  1 +
 docs/specs/index.rst                          |  1 +
 docs/specs/{vmcoreinfo.txt => vmcoreinfo.rst} | 33 ++++++++++---------
 3 files changed, 19 insertions(+), 16 deletions(-)
 rename docs/specs/{vmcoreinfo.txt => vmcoreinfo.rst} (50%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e27cad11c3..23ee617acaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2805,6 +2805,7 @@ F: include/sysemu/dump.h
 F: qapi/dump.json
 F: scripts/dump-guest-memory.py
 F: stubs/dump.c
+F: docs/specs/vmcoreinfo.rst
 
 Error reporting
 M: Markus Armbruster <armbru@redhat.com>
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 8d30968650b..7a56ccb2155 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -30,3 +30,4 @@ guest hardware that is specific to QEMU.
    pvpanic
    standard-vga
    virt-ctlr
+   vmcoreinfo
diff --git a/docs/specs/vmcoreinfo.txt b/docs/specs/vmcoreinfo.rst
similarity index 50%
rename from docs/specs/vmcoreinfo.txt
rename to docs/specs/vmcoreinfo.rst
index bcbca6fe47c..462b04474d3 100644
--- a/docs/specs/vmcoreinfo.txt
+++ b/docs/specs/vmcoreinfo.rst
@@ -2,19 +2,19 @@
 VMCoreInfo device
 =================
 
-The `-device vmcoreinfo` will create a fw_cfg entry for a guest to
+The ``-device vmcoreinfo`` will create a ``fw_cfg`` entry for a guest to
 store dump details.
 
-etc/vmcoreinfo
-**************
+``etc/vmcoreinfo``
+==================
 
-A guest may use this fw_cfg entry to add information details to qemu
+A guest may use this ``fw_cfg`` entry to add information details to qemu
 dumps.
 
 The entry of 16 bytes has the following layout, in little-endian::
 
-#define VMCOREINFO_FORMAT_NONE 0x0
-#define VMCOREINFO_FORMAT_ELF 0x1
+    #define VMCOREINFO_FORMAT_NONE 0x0
+    #define VMCOREINFO_FORMAT_ELF 0x1
 
     struct FWCfgVMCoreInfo {
         uint16_t host_format;  /* formats host supports */
@@ -26,17 +26,17 @@ The entry of 16 bytes has the following layout, in little-endian::
 Only full write (of 16 bytes) are considered valid for further
 processing of entry values.
 
-A write of 0 in guest_format will disable further processing of
+A write of 0 in ``guest_format`` will disable further processing of
 vmcoreinfo entry values & content.
 
-You may write a guest_format that is not supported by the host, in
+You may write a ``guest_format`` that is not supported by the host, in
 which case the entry data can be ignored by qemu (but you may still
-access it through a debugger, via vmcoreinfo_realize::vmcoreinfo_state).
+access it through a debugger, via ``vmcoreinfo_realize::vmcoreinfo_state``).
 
 Format & content
-****************
+================
 
-As of qemu 2.11, only VMCOREINFO_FORMAT_ELF is supported.
+As of qemu 2.11, only ``VMCOREINFO_FORMAT_ELF`` is supported.
 
 The entry gives location and size of an ELF note that is appended in
 qemu dumps.
@@ -44,10 +44,11 @@ qemu dumps.
 The note format/class must be of the target bitness and the size must
 be less than 1Mb.
 
-If the ELF note name is "VMCOREINFO", it is expected to be the Linux
-vmcoreinfo note (see Documentation/ABI/testing/sysfs-kernel-vmcoreinfo
-in Linux source). In this case, qemu dump code will read the content
-as a key=value text file, looking for "NUMBER(phys_base)" key
+If the ELF note name is ``VMCOREINFO``, it is expected to be the Linux
+vmcoreinfo note (see `the kernel documentation for its format
+<https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-kernel-vmcoreinfo>`_).
+In this case, qemu dump code will read the content
+as a key=value text file, looking for ``NUMBER(phys_base)`` key
 value. The value is expected to be more accurate than architecture
 guess of the value. This is useful for KASLR-enabled guest with
-ancient tools not handling the VMCOREINFO note.
+ancient tools not handling the ``VMCOREINFO`` note.
-- 
2.34.1


