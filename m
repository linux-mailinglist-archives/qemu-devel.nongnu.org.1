Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ADC7DF8E1
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:40:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybes-0003N5-Aj; Thu, 02 Nov 2023 13:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybed-0003Eg-FL
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:51 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeY-0002jZ-SA
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40853c639abso8954725e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946725; x=1699551525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=E2aA9Ap+poLvHcptWhfJUzZe/Ew9suv4NHGXesXSWP0=;
 b=gKfoSO/uksXTd5U+zAGzh60uMQE72tXBl+aIzJof3UiVb3yniXwISP+c70HdFGWZfK
 MAWiPBWCfcAlwA3pzia5lVYJY57sLxE0z84P4AGKYTtjXMhVgCqEQcr7DLxPrurV70m7
 uMV5y1v5FZi/5p0LQzlqQIfPaBcq4NGBSZZ0FRvkp5z7pPapRSxoz3GwbvdYCj28KjmJ
 6LXGDLjiFyDW9x+ppKKST0Wrd5hYewOfYEjE8P4C2fykReH4DhYQkwCHXqk8/6IFWGwL
 L9zzRk7332DjSU/rFZmwsxSgaIGqbhoDSzConez+FOv4EI/g3UtUiNvDttg5rmNk8CbT
 EOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946725; x=1699551525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2aA9Ap+poLvHcptWhfJUzZe/Ew9suv4NHGXesXSWP0=;
 b=L4/nUIohjWLIEa8GVyClXut4n03mDT4uL+o87xhN44nWvEi8WIQYr6fTe7NMPuX1XX
 duyZC48cyvY9/0TKMjZQVh50RGfgSFeUjTSjdyFYDoJBBuCOiYzk31JjIFyK5l+2DY4I
 pil+iuIEf8C+NeMnm4QKyywlPYqY4iIFLJOvv9zyGbRBb9OdWtX22h9eoqAuhENcAsPL
 Ke01ENNNWk8DYzB3f1TCwL1xkgVNCWU8mwdblBJio01s1PXoK9NRiY2Nk7MoBOdDRMLc
 a54mZxActu6fp0Fg5qGSK7vynnn/ztrP0P6RBxFu6ZmEp5edAlwyM0Nc9TDWQryTIQYq
 6CZA==
X-Gm-Message-State: AOJu0Yz4M9TxmpVdqaBwmho/Y2JIs6MATSnAe4Yo2yneNfRgSHC3aYGI
 GyTwL2ngy9qpU87GaEmo87NUlxO7sttmvNp2ynE=
X-Google-Smtp-Source: AGHT+IGcKk4SULxrm8e1429TNMiUDdF7uO4LaTBcgECfgcVzLvCa0OCXEPMUzXfewnPeP02jrALk4Q==
X-Received: by 2002:adf:f6d0:0:b0:313:eb09:c029 with SMTP id
 y16-20020adff6d0000000b00313eb09c029mr14404237wrp.43.1698946725356; 
 Thu, 02 Nov 2023 10:38:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/33] docs/specs/vmcoreinfo: Convert to rST
Date: Thu,  2 Nov 2023 17:38:16 +0000
Message-Id: <20231102173835.609985-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Convert docs/specs/vmcoreinfo.txt to rST format.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230927151205.70930-8-peter.maydell@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS               |  1 +
 docs/specs/index.rst      |  1 +
 docs/specs/vmcoreinfo.rst | 54 +++++++++++++++++++++++++++++++++++++++
 docs/specs/vmcoreinfo.txt | 53 --------------------------------------
 4 files changed, 56 insertions(+), 53 deletions(-)
 create mode 100644 docs/specs/vmcoreinfo.rst
 delete mode 100644 docs/specs/vmcoreinfo.txt

diff --git a/MAINTAINERS b/MAINTAINERS
index 11f3bdbfa78..6d654cc1277 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2884,6 +2884,7 @@ F: include/sysemu/dump.h
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
diff --git a/docs/specs/vmcoreinfo.rst b/docs/specs/vmcoreinfo.rst
new file mode 100644
index 00000000000..6541aa116f7
--- /dev/null
+++ b/docs/specs/vmcoreinfo.rst
@@ -0,0 +1,54 @@
+=================
+VMCoreInfo device
+=================
+
+The ``-device vmcoreinfo`` will create a ``fw_cfg`` entry for a guest to
+store dump details.
+
+``etc/vmcoreinfo``
+==================
+
+A guest may use this ``fw_cfg`` entry to add information details to QEMU
+dumps.
+
+The entry of 16 bytes has the following layout, in little-endian::
+
+    #define VMCOREINFO_FORMAT_NONE 0x0
+    #define VMCOREINFO_FORMAT_ELF 0x1
+
+    struct FWCfgVMCoreInfo {
+        uint16_t host_format;  /* formats host supports */
+        uint16_t guest_format; /* format guest supplies */
+        uint32_t size;         /* size of vmcoreinfo region */
+        uint64_t paddr;        /* physical address of vmcoreinfo region */
+    };
+
+Only full write (of 16 bytes) are considered valid for further
+processing of entry values.
+
+A write of 0 in ``guest_format`` will disable further processing of
+vmcoreinfo entry values & content.
+
+You may write a ``guest_format`` that is not supported by the host, in
+which case the entry data can be ignored by QEMU (but you may still
+access it through a debugger, via ``vmcoreinfo_realize::vmcoreinfo_state``).
+
+Format & content
+================
+
+As of QEMU 2.11, only ``VMCOREINFO_FORMAT_ELF`` is supported.
+
+The entry gives location and size of an ELF note that is appended in
+qemu dumps.
+
+The note format/class must be of the target bitness and the size must
+be less than 1Mb.
+
+If the ELF note name is ``VMCOREINFO``, it is expected to be the Linux
+vmcoreinfo note (see `the kernel documentation for its format
+<https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-kernel-vmcoreinfo>`_).
+In this case, qemu dump code will read the content
+as a key=value text file, looking for ``NUMBER(phys_base)`` key
+value. The value is expected to be more accurate than architecture
+guess of the value. This is useful for KASLR-enabled guest with
+ancient tools not handling the ``VMCOREINFO`` note.
diff --git a/docs/specs/vmcoreinfo.txt b/docs/specs/vmcoreinfo.txt
deleted file mode 100644
index bcbca6fe47c..00000000000
--- a/docs/specs/vmcoreinfo.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-=================
-VMCoreInfo device
-=================
-
-The `-device vmcoreinfo` will create a fw_cfg entry for a guest to
-store dump details.
-
-etc/vmcoreinfo
-**************
-
-A guest may use this fw_cfg entry to add information details to qemu
-dumps.
-
-The entry of 16 bytes has the following layout, in little-endian::
-
-#define VMCOREINFO_FORMAT_NONE 0x0
-#define VMCOREINFO_FORMAT_ELF 0x1
-
-    struct FWCfgVMCoreInfo {
-        uint16_t host_format;  /* formats host supports */
-        uint16_t guest_format; /* format guest supplies */
-        uint32_t size;         /* size of vmcoreinfo region */
-        uint64_t paddr;        /* physical address of vmcoreinfo region */
-    };
-
-Only full write (of 16 bytes) are considered valid for further
-processing of entry values.
-
-A write of 0 in guest_format will disable further processing of
-vmcoreinfo entry values & content.
-
-You may write a guest_format that is not supported by the host, in
-which case the entry data can be ignored by qemu (but you may still
-access it through a debugger, via vmcoreinfo_realize::vmcoreinfo_state).
-
-Format & content
-****************
-
-As of qemu 2.11, only VMCOREINFO_FORMAT_ELF is supported.
-
-The entry gives location and size of an ELF note that is appended in
-qemu dumps.
-
-The note format/class must be of the target bitness and the size must
-be less than 1Mb.
-
-If the ELF note name is "VMCOREINFO", it is expected to be the Linux
-vmcoreinfo note (see Documentation/ABI/testing/sysfs-kernel-vmcoreinfo
-in Linux source). In this case, qemu dump code will read the content
-as a key=value text file, looking for "NUMBER(phys_base)" key
-value. The value is expected to be more accurate than architecture
-guess of the value. This is useful for KASLR-enabled guest with
-ancient tools not handling the VMCOREINFO note.
-- 
2.34.1


