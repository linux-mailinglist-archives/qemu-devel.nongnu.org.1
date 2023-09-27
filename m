Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D727B07DE
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:13:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWD3-0003Ao-7g; Wed, 27 Sep 2023 11:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWD1-00036n-2u
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:12:15 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlWCw-0005kY-Ab
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:12:14 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-405e48d8cfdso52351675e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695827529; x=1696432329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s5DPTjMu0+4Bk3yruDyc6XSzg1YD1XJ0PlVkpHAUkmA=;
 b=QDa7o6GZxswE6biF+UDJj4YUJQ27CBxzOu4ABNiq9+fMmzouOyObQ4lFiNHXrL02i+
 rRh1UdR6Ct80pQhj+UejLPXtyH3XxY2oxQVfR6ASWPBbd1eNHO7cKnmbES5WK6YuGHys
 MJ7k3llJ0CWFX6t/3cbzN7DruvGlgQF9iSGEQZdZsakJK0rAInYIUVBLAnz7ht3x9QbV
 N2GqYXyy+IaxLDtYpmxkZxk7Twf+JRcYOdKwSrsBo5EBwfEsQWiwQIrDbzQx8ZUb7PTW
 RKdakQTHIoq3Nx797MAQlIQCMTGxOve7D0lRqK2K4m08qy1aYhjCy8DZf5TXCOJ1SI6E
 T28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695827529; x=1696432329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s5DPTjMu0+4Bk3yruDyc6XSzg1YD1XJ0PlVkpHAUkmA=;
 b=AYCnoHyuj2sIJhIsyaahunxrRBZlpA7USHRov3PUIqvkSUFj2JnIE4++xsG7HKdmGd
 ZhpUsjC5p/aHKy5tTX0x7CZ+RHPw3v+mNq3fP++BX9SsCrUBW147ORUZMEtx5eJoNpHy
 hjh++JFIW2/cQDZwyscY8u3tgrN8pIhtWiG4U4gLy6OMeYCeMs8tJrimNC6xoogMC1rV
 3AHZXyglc+istdh4QrVDMc50isdHSL9MJQNhPGHmZ49PZvjm/225bU3DSRraLXwyMW6f
 x6SYddGR+k6NsK7QCY6HJ6tD/AUyPqhhgBU60U1DmwBhVqDr5K4IMP/mvthRWrp/rYnI
 GvsA==
X-Gm-Message-State: AOJu0Yz1pww4s4rLF5iy0VUl+P9pDHNGyCRog7juH3YwssLpXTsMElzH
 wF/hfOsqFg0bko8T6BdRxy2riMrxoSV6ysaifWI=
X-Google-Smtp-Source: AGHT+IFuAZYFcmSBK7vuiqMKZyCdk4oSWVklftyzbTErEpg/TjjXywJrvfelshOnwkBFjh5KIuaviw==
X-Received: by 2002:a7b:c4d9:0:b0:3fb:a102:6d7a with SMTP id
 g25-20020a7bc4d9000000b003fba1026d7amr2096154wmk.28.1695827528681; 
 Wed, 27 Sep 2023 08:12:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a1c7209000000b00401bbfb9b2bsm467474wmc.0.2023.09.27.08.12.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 08:12:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/8] docs/specs/ivshmem-spec: Convert to rST
Date: Wed, 27 Sep 2023 16:12:00 +0100
Message-Id: <20230927151205.70930-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927151205.70930-1-peter.maydell@linaro.org>
References: <20230927151205.70930-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Convert docs/specs/ivshmem-spec.txt to rST format.

In converting, I have dropped the sections on the device's command
line interface and usage, as they are already covered by the
user-facing docs in system/devices/ivshmem.rst.

I have also removed the reference to Memnic, because the URL is dead
and a web search suggests that whatever this was it's pretty much
sunk without trace.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/specs/index.rst                          |  1 +
 .../{ivshmem-spec.txt => ivshmem-spec.rst}    | 63 +++++++------------
 docs/specs/pci-ids.rst                        |  2 +-
 docs/system/devices/ivshmem.rst               |  2 +-
 4 files changed, 26 insertions(+), 42 deletions(-)
 rename docs/specs/{ivshmem-spec.txt => ivshmem-spec.rst} (88%)

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 30a0cf3d47e..e60c8377541 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -26,3 +26,4 @@ guest hardware that is specific to QEMU.
    fw_cfg
    vmw_pvscsi-spec
    edu
+   ivshmem-spec
diff --git a/docs/specs/ivshmem-spec.txt b/docs/specs/ivshmem-spec.rst
similarity index 88%
rename from docs/specs/ivshmem-spec.txt
rename to docs/specs/ivshmem-spec.rst
index 1beb3a01ec3..2d8e80055b0 100644
--- a/docs/specs/ivshmem-spec.txt
+++ b/docs/specs/ivshmem-spec.rst
@@ -1,4 +1,6 @@
-= Device Specification for Inter-VM shared memory device =
+======================================================
+Device Specification for Inter-VM shared memory device
+======================================================
 
 The Inter-VM shared memory device (ivshmem) is designed to share a
 memory region between multiple QEMU processes running different guests
@@ -12,42 +14,17 @@ can obtain one from an ivshmem server.
 In the latter case, the device can additionally interrupt its peers, and
 get interrupted by its peers.
 
+For information on configuring the ivshmem device on the QEMU
+command line, see :doc:`../system/devices/ivshmem`.
 
-== Configuring the ivshmem PCI device ==
-
-There are two basic configurations:
-
-- Just shared memory:
-
-      -device ivshmem-plain,memdev=HMB,...
-
-  This uses host memory backend HMB.  It should have option "share"
-  set.
-
-- Shared memory plus interrupts:
-
-      -device ivshmem-doorbell,chardev=CHR,vectors=N,...
-
-  An ivshmem server must already be running on the host.  The device
-  connects to the server's UNIX domain socket via character device
-  CHR.
-
-  Each peer gets assigned a unique ID by the server.  IDs must be
-  between 0 and 65535.
-
-  Interrupts are message-signaled (MSI-X).  vectors=N configures the
-  number of vectors to use.
-
-For more details on ivshmem device properties, see the QEMU Emulator
-user documentation.
-
-
-== The ivshmem PCI device's guest interface ==
+The ivshmem PCI device's guest interface
+========================================
 
 The device has vendor ID 1af4, device ID 1110, revision 1.  Before
 QEMU 2.6.0, it had revision 0.
 
-=== PCI BARs ===
+PCI BARs
+--------
 
 The ivshmem PCI device has two or three BARs:
 
@@ -59,8 +36,7 @@ There are two ways to use this device:
 
 - If you only need the shared memory part, BAR2 suffices.  This way,
   you have access to the shared memory in the guest and can use it as
-  you see fit.  Memnic, for example, uses ivshmem this way from guest
-  user space (see http://dpdk.org/browse/memnic).
+  you see fit.
 
 - If you additionally need the capability for peers to interrupt each
   other, you need BAR0 and BAR1.  You will most likely want to write a
@@ -77,10 +53,13 @@ accessing BAR2.
 Revision 0 of the device is not capable to tell guest software whether
 it is configured for interrupts.
 
-=== PCI device registers ===
+PCI device registers
+--------------------
 
 BAR 0 contains the following registers:
 
+::
+
     Offset  Size  Access      On reset  Function
         0     4   read/write        0   Interrupt Mask
                                         bit 0: peer interrupt (rev 0)
@@ -145,18 +124,20 @@ With multiple MSI-X vectors, different vectors can be used to indicate
 different events have occurred.  The semantics of interrupt vectors
 are left to the application.
 
-
-== Interrupt infrastructure ==
+Interrupt infrastructure
+========================
 
 When configured for interrupts, the peers share eventfd objects in
 addition to shared memory.  The shared resources are managed by an
 ivshmem server.
 
-=== The ivshmem server ===
+The ivshmem server
+------------------
 
 The server listens on a UNIX domain socket.
 
 For each new client that connects to the server, the server
+
 - picks an ID,
 - creates eventfd file descriptors for the interrupt vectors,
 - sends the ID and the file descriptor for the shared memory to the
@@ -189,7 +170,8 @@ vectors.
 A standalone client is in contrib/ivshmem-client/.  It can be useful
 for debugging.
 
-=== The ivshmem Client-Server Protocol ===
+The ivshmem Client-Server Protocol
+----------------------------------
 
 An ivshmem device configured for interrupts connects to an ivshmem
 server.  This section details the protocol between the two.
@@ -245,7 +227,8 @@ Known bugs:
 
 * The protocol is poorly designed.
 
-=== The ivshmem Client-Client Protocol ===
+The ivshmem Client-Client Protocol
+----------------------------------
 
 An ivshmem device configured for interrupts receives eventfd file
 descriptors for interrupting peers and getting interrupted by peers
diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index d6707fa069a..c0a3dec2e7a 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -50,7 +50,7 @@ maintained as part of the virtio specification.
   by QEMU.
 
 1af4:1110
-  ivshmem device (shared memory, ``docs/specs/ivshmem-spec.txt``)
+  ivshmem device (:doc:`ivshmem-spec`)
 
 All other device IDs are reserved.
 
diff --git a/docs/system/devices/ivshmem.rst b/docs/system/devices/ivshmem.rst
index e7aaf34c200..ce71e256630 100644
--- a/docs/system/devices/ivshmem.rst
+++ b/docs/system/devices/ivshmem.rst
@@ -33,7 +33,7 @@ syntax when using the shared memory server is:
 When using the server, the guest will be assigned a VM ID (>=0) that
 allows guests using the same server to communicate via interrupts.
 Guests can read their VM ID from a device register (see
-ivshmem-spec.txt).
+:doc:`../../specs/ivshmem-spec`).
 
 Migration with ivshmem
 ~~~~~~~~~~~~~~~~~~~~~~
-- 
2.34.1


