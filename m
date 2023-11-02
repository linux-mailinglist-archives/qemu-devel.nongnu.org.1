Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E3A7DF91A
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:47:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyber-0003N4-QK; Thu, 02 Nov 2023 13:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybec-0003Cv-2c
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:50 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeY-0002iv-BI
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:49 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so10614305e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946723; x=1699551523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aAmwaZNtOH8AIV/DW/ygJqJkEO7JRdKRbd+n00OE3V8=;
 b=WqaB/LXLGLyqNjEHK+vvY3BNZa1q+pfZkdU8HumCad1l+Y0Aq6kw8mr0rJL2Ddb0Jx
 Rd4s9di+rx04xFhZ0TrtNyBBlY9xZnDlup4vVXJnf7iCLHB63DN8IKp9/WeYaVqkTN/U
 vi91phuxsZ96HwgWEjoWvizwvT6a/gvBFtV0dZg1d1EQHAP9YTlk8K1rU2f27SlzNvSv
 F/nkJC3bn4RfM9R2NZssBjIgQqoJaxJBbge0sTLwDdvP/+xpAOQ5QkT+f2k16k6Gkj4/
 flbZahJAdQ7KEGawtHmvxeB/9yDVF8+hVTuPZug/TECsuzwEsSdCH+2QxzCh5XEWYK2N
 oN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946723; x=1699551523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aAmwaZNtOH8AIV/DW/ygJqJkEO7JRdKRbd+n00OE3V8=;
 b=UZuqtacQNm+e0UnSCQVAJl6mEfgeJN6JVtdedaCgNuJTFQ1Q9gIzUG/S50/qCs1pJJ
 NvEMU7h310zA2i8Fjf3Sb6od9z9crfU8lr0OkUYVrCl3YfaD9WvVL9BwjUx0Q0EEkK6G
 xzref6qBTzDvpSnIqX1pqGOtXUqFBNgIu7UDAMM1kS0ADz1sYMmMutRrZ5bsHvseVXUo
 Qs+4DCA9zOmRlkO/lW23jwInjRPwgQcZJZ7oAkE1L4lGoqId1k/jV1TyuaD+JzZZqqpT
 4YNsX9MzqNhMTAtiPBLDmSqJjvuFEmT8eCpgQqv6YZJLciFrGByjIBZwb2ncKLksrXjZ
 AwIA==
X-Gm-Message-State: AOJu0YylIC5Tu2jnIH4djSChp4IvdFsZE+AxXRPezcDTuzq9ZXtulBAs
 lRXiav2gZ3TQQLaDuilrvo0Tn+cHohiW1guG2Jw=
X-Google-Smtp-Source: AGHT+IERH1P0uSN/Lue4eveXRMh/stwaXOe7H8XqcwPeprKfHycKYdd6aeojunTFVWhHXruysnUvjQ==
X-Received: by 2002:adf:f946:0:b0:319:8a66:f695 with SMTP id
 q6-20020adff946000000b003198a66f695mr13010026wrr.55.1698946723142; 
 Thu, 02 Nov 2023 10:38:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/33] docs/specs/ivshmem-spec: Convert to rST
Date: Thu,  2 Nov 2023 17:38:12 +0000
Message-Id: <20231102173835.609985-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Convert docs/specs/ivshmem-spec.txt to rST format.

In converting, I have dropped the sections on the device's command
line interface and usage, as they are already covered by the
user-facing docs in system/devices/ivshmem.rst.

I have also removed the reference to Memnic, because the URL is dead
and a web search suggests that whatever this was it's pretty much
sunk without trace.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230927151205.70930-4-peter.maydell@linaro.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


