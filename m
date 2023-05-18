Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F23897081D9
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:53:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6b-0004K1-RI; Thu, 18 May 2023 08:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6X-0004I3-Op
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:37 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6N-00082j-Vj
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:37 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f42ba32e24so12946835e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414282; x=1687006282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pHx/qDMr99009RmTPyKS5C1hjjUNzbGI5QhnCleSJHE=;
 b=BGBWoasgAU0gIcH/a5lo811QZntbcd6zpMkG2kJS8cininddc4nA5yikXyvEAXc1AD
 awMn31bVmNcFj6YcoIIe11S/e5aFfTbQMQKBRCIHV1y/s3zVSIBXrwGWDlMDD9VKSbIR
 yHZI7bD2HanfjPPlJCxF/SwEhgODDV1IWW5i/9PFAEKs3/JyhON5X/s0gSftdr9bbH5e
 KI/Lh26b91ZJttqy1HSIaFC95Vmi8NdYDiE8n3YOKqref4rT4SScSXgmuofKIIJ0w9l7
 UTP61vD3JEh7L1/sFvW8ijT+Jk3/lOy+M/89590th/VnWGcMMZFOdHxdpj85vCy90kFv
 lQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414282; x=1687006282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pHx/qDMr99009RmTPyKS5C1hjjUNzbGI5QhnCleSJHE=;
 b=DcCFYP+oU8q+2jQaU9xuw61PO8yGBTSwU8iamNfUydFnY/lh7QIBYJFEo0qE/9fKiK
 ZjZ2paHCSgtjDgjXy41N052F+IynM7dfBqCb0lFUoSp/uGVK3FRnUdpku6/IEpxWcatH
 gdraQ48uQHqsohaAtSbxEW2Hqg8uR+Ho65135ZxuTsyenibW6ythDTmbcIZKSyZcVNO/
 nzT5eR/SK0++BXTwl4vx6lnEZmugIsbZkhPEFIxNOPZ6EoiTf1LhMv8F+Zr1xkT4pAv3
 pl1C99mQt7ZntDqmNdUERglVkAnSLnJe8dIBc69hP0bTkk4fNn2960uR/dLzqUPZrsmW
 eg3w==
X-Gm-Message-State: AC+VfDz8RTDimMbbXzbGvwjDtMd6XnauOqtnLI7JxROvKBaXC4QX5Hv/
 ioMGGVJXhi6sR6Q7rNCkpFGhbOoReU0s9OTujUA=
X-Google-Smtp-Source: ACHHUZ7VXOul+nMYdizgeG/dGx33k8KQ7BBkmUhsvDaI14wD1k5d2tf45V96iM6YnxC9sa1ffncJHw==
X-Received: by 2002:a05:600c:2288:b0:3f4:3562:f799 with SMTP id
 8-20020a05600c228800b003f43562f799mr1385553wmf.28.1684414282087; 
 Thu, 18 May 2023 05:51:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/29] docs: Convert u2f.txt to rST
Date: Thu, 18 May 2023 13:51:07 +0100
Message-Id: <20230518125107.146421-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Convert the u2f.txt file to rST, and place it in the right place
in our manual layout. The old text didn't fit very well into our
manual style, so the new version ends up looking like a rewrite,
although some of the original text is preserved:

 * the 'building' section of the old file is removed, since we
   generally assume that users have already built QEMU
 * some rather verbose text has been cut back
 * document the passthrough device first, on the assumption
   that's most likely to be of interest to users
 * cut back on the duplication of text between sections
 * format example command lines etc with rST

As it's a short document it seemed simplest to do this all
in one go rather than try to do a minimal syntactic conversion
and then clean up the wording and layout.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20230421163734.1152076-1-peter.maydell@linaro.org
---
 docs/system/device-emulation.rst |   1 +
 docs/system/devices/usb-u2f.rst  |  93 ++++++++++++++++++++++++++
 docs/system/devices/usb.rst      |   2 +-
 docs/u2f.txt                     | 110 -------------------------------
 4 files changed, 95 insertions(+), 111 deletions(-)
 create mode 100644 docs/system/devices/usb-u2f.rst
 delete mode 100644 docs/u2f.txt

diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index c1b1934e3d3..8d4a1821fa7 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -93,4 +93,5 @@ Emulated Devices
    devices/virtio-pmem.rst
    devices/vhost-user-rng.rst
    devices/canokey.rst
+   devices/usb-u2f.rst
    devices/igb.rst
diff --git a/docs/system/devices/usb-u2f.rst b/docs/system/devices/usb-u2f.rst
new file mode 100644
index 00000000000..4f57d5c8c34
--- /dev/null
+++ b/docs/system/devices/usb-u2f.rst
@@ -0,0 +1,93 @@
+Universal Second Factor (U2F) USB Key Device
+============================================
+
+U2F is an open authentication standard that enables relying parties
+exposed to the internet to offer a strong second factor option for end
+user authentication.
+
+The second factor is provided by a device implementing the U2F
+protocol. In case of a USB U2F security key, it is a USB HID device
+that implements the U2F protocol.
+
+QEMU supports both pass-through of a host U2F key device to a VM,
+and software emulation of a U2F key.
+
+``u2f-passthru``
+----------------
+
+The ``u2f-passthru`` device allows you to connect a real hardware
+U2F key on your host to a guest VM. All requests made from the guest
+are passed through to the physical security key connected to the
+host machine and vice versa.
+
+In addition, the dedicated pass-through allows you to share a single
+U2F security key with several guest VMs, which is not possible with a
+simple host device assignment pass-through.
+
+You can specify the host U2F key to use with the ``hidraw``
+option, which takes the host path to a Linux ``/dev/hidrawN`` device:
+
+.. parsed-literal::
+   |qemu_system| -usb -device u2f-passthru,hidraw=/dev/hidraw0
+
+If you don't specify the device, the ``u2f-passthru`` device will
+autoscan to take the first U2F device it finds on the host (this
+requires a working libudev):
+
+.. parsed-literal::
+   |qemu_system| -usb -device u2f-passthru
+
+``u2f-emulated``
+----------------
+
+``u2f-emulated`` is a completely software emulated U2F device.
+It uses `libu2f-emu <https://github.com/MattGorko/libu2f-emu>`__
+for the U2F key emulation. libu2f-emu
+provides a complete implementation of the U2F protocol device part for
+all specified transports given by the FIDO Alliance.
+
+To work, an emulated U2F device must have four elements:
+
+ * ec x509 certificate
+ * ec private key
+ * counter (four bytes value)
+ * 48 bytes of entropy (random bits)
+
+To use this type of device, these have to be configured, and these
+four elements must be passed one way or another.
+
+Assuming that you have a working libu2f-emu installed on the host,
+there are three possible ways to configure the ``u2f-emulated`` device:
+
+ * ephemeral
+ * setup directory
+ * manual
+
+Ephemeral is the simplest way to configure; it lets the device generate
+all the elements it needs for a single use of the lifetime of the device.
+It is the default if you do not pass any other options to the device.
+
+.. parsed-literal::
+   |qemu_system| -usb -device u2f-emulated
+
+You can pass the device the path of a setup directory on the host
+using the ``dir`` option; the directory must contain these four files:
+
+ * ``certificate.pem``: ec x509 certificate
+ * ``private-key.pem``: ec private key
+ * ``counter``: counter value
+ * ``entropy``: 48 bytes of entropy
+
+.. parsed-literal::
+   |qemu_system| -usb -device u2f-emulated,dir=$dir
+
+You can also manually pass the device the paths to each of these files,
+if you don't want them all to be in the same directory, using the options
+
+ * ``cert``
+ * ``priv``
+ * ``counter``
+ * ``entropy``
+
+.. parsed-literal::
+   |qemu_system| -usb -device u2f-emulated,cert=$DIR1/$FILE1,priv=$DIR2/$FILE2,counter=$DIR3/$FILE3,entropy=$DIR4/$FILE4
diff --git a/docs/system/devices/usb.rst b/docs/system/devices/usb.rst
index 74166810731..a6ca7b0c375 100644
--- a/docs/system/devices/usb.rst
+++ b/docs/system/devices/usb.rst
@@ -207,7 +207,7 @@ option or the ``device_add`` monitor command. Available devices are:
    USB audio device
 
 ``u2f-{emulated,passthru}``
-   Universal Second Factor device
+   :doc:`usb-u2f`
 
 ``canokey``
    An Open-source Secure Key implementing FIDO2, OpenPGP, PIV and more.
diff --git a/docs/u2f.txt b/docs/u2f.txt
deleted file mode 100644
index 7f5813a0b72..00000000000
--- a/docs/u2f.txt
+++ /dev/null
@@ -1,110 +0,0 @@
-QEMU U2F Key Device Documentation.
-
-Contents
-1. USB U2F key device
-2. Building
-3. Using u2f-emulated
-4. Using u2f-passthru
-5. Libu2f-emu
-
-1. USB U2F key device
-
-U2F is an open authentication standard that enables relying parties
-exposed to the internet to offer a strong second factor option for end
-user authentication.
-
-The standard brings many advantages to both parties, client and server,
-allowing to reduce over-reliance on passwords, it increases authentication
-security and simplifies passwords.
-
-The second factor is materialized by a device implementing the U2F
-protocol. In case of a USB U2F security key, it is a USB HID device
-that implements the U2F protocol.
-
-In QEMU, the USB U2F key device offers a dedicated support of U2F, allowing
-guest USB FIDO/U2F security keys operating in two possible modes:
-pass-through and emulated.
-
-The pass-through mode consists of passing all requests made from the guest
-to the physical security key connected to the host machine and vice versa.
-In addition, the dedicated pass-through allows to have a U2F security key
-shared on several guests which is not possible with a simple host device
-assignment pass-through.
-
-The emulated mode consists of completely emulating the behavior of an
-U2F device through software part. Libu2f-emu is used for that.
-
-
-2. Building
-
-To ensure the build of the u2f-emulated device variant which depends
-on libu2f-emu: configuring and building:
-
-    ./configure --enable-u2f && make
-
-The pass-through mode is built by default on Linux. To take advantage
-of the autoscan option it provides, make sure you have a working libudev
-installed on the host.
-
-
-3. Using u2f-emulated
-
-To work, an emulated U2F device must have four elements:
- * ec x509 certificate
- * ec private key
- * counter (four bytes value)
- * 48 bytes of entropy (random bits)
-
-To use this type of device, this one has to be configured, and these
-four elements must be passed one way or another.
-
-Assuming that you have a working libu2f-emu installed on the host.
-There are three possible ways of configurations:
- * ephemeral
- * setup directory
- * manual
-
-Ephemeral is the simplest way to configure, it lets the device generate
-all the elements it needs for a single use of the lifetime of the device.
-
-    qemu -usb -device u2f-emulated
-
-Setup directory allows to configure the device from a directory containing
-four files:
- * certificate.pem: ec x509 certificate
- * private-key.pem: ec private key
- * counter: counter value
- * entropy: 48 bytes of entropy
-
-    qemu -usb -device u2f-emulated,dir=$dir
-
-Manual allows to configure the device more finely by specifying each
-of the elements necessary for the device:
- * cert
- * priv
- * counter
- * entropy
-
-    qemu -usb -device u2f-emulated,cert=$DIR1/$FILE1,priv=$DIR2/$FILE2,counter=$DIR3/$FILE3,entropy=$DIR4/$FILE4
-
-
-4. Using u2f-passthru
-
-On the host specify the u2f-passthru device with a suitable hidraw:
-
-    qemu -usb -device u2f-passthru,hidraw=/dev/hidraw0
-
-Alternately, the u2f-passthru device can autoscan to take the first
-U2F device it finds on the host (this requires a working libudev):
-
-    qemu -usb -device u2f-passthru
-
-
-5. Libu2f-emu
-
-The u2f-emulated device uses libu2f-emu for the U2F key emulation. Libu2f-emu
-implements completely the U2F protocol device part for all specified
-transport given by the FIDO Alliance.
-
-For more information about libu2f-emu see this page:
-https://github.com/MattGorko/libu2f-emu.
-- 
2.34.1


