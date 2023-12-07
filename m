Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE4B8088E5
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 14:08:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBE5K-0006MF-Ey; Thu, 07 Dec 2023 08:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rBE5I-0006M5-0T
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 08:06:32 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rBE5F-0003sB-VG
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 08:06:31 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33340c50af9so901532f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 05:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701954387; x=1702559187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vKGjWlnpBVSX7oVDSIBeqFlCx7Twdo+o3crrgns5YSo=;
 b=hqyk479rEILGMQqy8HkIdh4QBgc37hfHMQiDCbTuYZ8n1yYPPU2BU2E+k5dVaHUSTD
 iGk4p2FW/g5yDCEKEXep0rDmLwEqFGfYlmouvz0CZrwP5eFSHl5OnKNhYTdZdOFhw6fV
 SiYTSaLGZRgcAJ4VaAaz1id79U9oyJPgLuoJCtVov89xuhuOVHurR6V+nCu7RHVjQvOh
 c/tGY2AhIX6PxjVrl9Mk1BKp6XhwfOmxqurayuopchFVSCcDc9HbgTHVjhW0p7aHuLWz
 SycEd1Ox/mkbm2fTDgflitC7Y1KMnFmq6OjbYu8yduQrKbuj1R7NqOo5p71dVMl5DTYc
 DJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701954387; x=1702559187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vKGjWlnpBVSX7oVDSIBeqFlCx7Twdo+o3crrgns5YSo=;
 b=wikSialCIXuVzuiaWVpRALlvXVC0316lal+6waSGn/f/lztTo6kjJrhUNOzFFwEd/A
 nHXB8F9xa9qO5mLwYIehUikQYIjIHPwPABytxIO8KlWvdOq/jTsrTStOmKZxDLZ5imhE
 +0et3vCLO0lSExTcutK456iUbHLvlAFK4pPhaD/O6/PmQYKpxQXMbCYcZQgII2loHrhA
 wreH/Fp8+Xl0m3ql4q0uxHIpBCeFyb0+fWFmmhP3IGJ4FuYv0n1IXRDhm7L8s9eARTPn
 HtzcOf8Rh6lDIGC3YennMszYnFTDAD5j7G+UlNX6jdCHiM9Fc1kjbyi4MzVXDW2yedj/
 KgPg==
X-Gm-Message-State: AOJu0YyIauMsXEJyRAcWAeQ6ZXgPQHIa+l3kb+W2128Qi8KAz4IUdqeW
 12Kj1hayaaxmVShQjdewll0Pmg==
X-Google-Smtp-Source: AGHT+IFkDtqD3bdKSAGNmwxbGnSe0A/1yU1pgeve+KCe948iCUA1CRBni7MR2Wod6bfS1qgBhVot1g==
X-Received: by 2002:a05:6000:25c:b0:333:3983:61a0 with SMTP id
 m28-20020a056000025c00b00333398361a0mr987271wrz.4.1701954386829; 
 Thu, 07 Dec 2023 05:06:26 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n11-20020adfe78b000000b003332febec90sm1419439wrm.7.2023.12.07.05.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 05:06:26 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 02E8B5F7AF;
 Thu,  7 Dec 2023 13:06:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: vikram.garhwal@amd.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH for 8.2] docs: clean-up the xenpvh documentation
Date: Thu,  7 Dec 2023 13:06:23 +0000
Message-Id: <20231207130623.360473-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

I noticed the code blocks where not rendering properly so thought I'd
better fix things up. So:

  - Use better title for the machine type
  - Explain why Xen is a little different
  - Add a proper anchor to the tpm-device link
  - add newline so code block properly renders
  - add some indentation to make continuation clearer

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/specs/tpm.rst         |  2 ++
 docs/system/arm/xenpvh.rst | 39 +++++++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
index efe124a148..c96776a369 100644
--- a/docs/specs/tpm.rst
+++ b/docs/specs/tpm.rst
@@ -1,3 +1,5 @@
+.. _tpm-device:
+
 ===============
 QEMU TPM Device
 ===============
diff --git a/docs/system/arm/xenpvh.rst b/docs/system/arm/xenpvh.rst
index e1655c7ab8..430ac2c02e 100644
--- a/docs/system/arm/xenpvh.rst
+++ b/docs/system/arm/xenpvh.rst
@@ -1,34 +1,39 @@
-XENPVH (``xenpvh``)
+Xen Device Emulation Backend (``xenpvh``)
 =========================================
-This machine creates a IOREQ server to register/connect with Xen Hypervisor.
 
-When TPM is enabled, this machine also creates a tpm-tis-device at a user input
-tpm base address, adds a TPM emulator and connects to a swtpm application
-running on host machine via chardev socket. This enables xenpvh to support TPM
-functionalities for a guest domain.
+This machine is a little unusual compared to others as QEMU just acts
+as an IOREQ server to register/connect with Xen Hypervisor. Control of
+the VMs themselves is left to the Xen tooling.
 
-More information about TPM use and installing swtpm linux application can be
-found at: docs/specs/tpm.rst.
+When TPM is enabled, this machine also creates a tpm-tis-device at a
+user input tpm base address, adds a TPM emulator and connects to a
+swtpm application running on host machine via chardev socket. This
+enables xenpvh to support TPM functionalities for a guest domain.
+
+More information about TPM use and installing swtpm linux application
+can be found in the :ref:`tpm-device` section.
 
 Example for starting swtpm on host machine:
+
 .. code-block:: console
 
     mkdir /tmp/vtpm2
     swtpm socket --tpmstate dir=/tmp/vtpm2 \
-    --ctrl type=unixio,path=/tmp/vtpm2/swtpm-sock &
+      --ctrl type=unixio,path=/tmp/vtpm2/swtpm-sock &
 
 Sample QEMU xenpvh commands for running and connecting with Xen:
+
 .. code-block:: console
 
     qemu-system-aarch64 -xen-domid 1 \
-    -chardev socket,id=libxl-cmd,path=qmp-libxl-1,server=on,wait=off \
-    -mon chardev=libxl-cmd,mode=control \
-    -chardev socket,id=libxenstat-cmd,path=qmp-libxenstat-1,server=on,wait=off \
-    -mon chardev=libxenstat-cmd,mode=control \
-    -xen-attach -name guest0 -vnc none -display none -nographic \
-    -machine xenpvh -m 1301 \
-    -chardev socket,id=chrtpm,path=tmp/vtpm2/swtpm-sock \
-    -tpmdev emulator,id=tpm0,chardev=chrtpm -machine tpm-base-addr=0x0C000000
+      -chardev socket,id=libxl-cmd,path=qmp-libxl-1,server=on,wait=off \
+      -mon chardev=libxl-cmd,mode=control \
+      -chardev socket,id=libxenstat-cmd,path=qmp-libxenstat-1,server=on,wait=off \
+      -mon chardev=libxenstat-cmd,mode=control \
+      -xen-attach -name guest0 -vnc none -display none -nographic \
+      -machine xenpvh -m 1301 \
+      -chardev socket,id=chrtpm,path=tmp/vtpm2/swtpm-sock \
+      -tpmdev emulator,id=tpm0,chardev=chrtpm -machine tpm-base-addr=0x0C000000
 
 In above QEMU command, last two lines are for connecting xenpvh QEMU to swtpm
 via chardev socket.
-- 
2.39.2


