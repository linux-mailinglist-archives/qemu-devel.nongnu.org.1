Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2697CF4A3
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:06:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPuk-0005Og-NY; Thu, 19 Oct 2023 06:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtPug-0005La-JC
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:05:58 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtPue-0003eI-Q7
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:05:58 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso6317813f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697709955; x=1698314755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFvxjXyPQyQdUo774rlrcRiYhBR/VXY2nK/Mz5j4NP8=;
 b=HV1r1hu2fBJA8qS6LkOTwf3ZXAXahDCWMPGYB6kxmEbWFeAoAEO/JVJCt19N9wsDQw
 NdCzUCDog/Y0DOcx782dVOYvgG7GDUwa8a8E9OoT9yKVKbeSoguJVB0lWuq1e+lODm74
 i0H++dpeFjSglBYB2b+t/j+VEBj2U2TdcDWnXNeccU6AwyRZnFoqX4PeaPSsWeR8Lplk
 SOolfqaEAwjnpSR917Rh9ndgSPBTIty4nhCNdNZBILynOfTmYeUf8QucBvzqR+CM69Mv
 6eAbjCB72FTFnMB0MhCe90HKiEWpcSrupiB0SgtPAmDKlUZykUnpQp6ue0UTw9K/hEH4
 i9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697709955; x=1698314755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NFvxjXyPQyQdUo774rlrcRiYhBR/VXY2nK/Mz5j4NP8=;
 b=Js1OnfLOugOZEn8XemtXyU7JEBzbldZwc4uS/6Hee2YjZWeb4DicaC2G/XVK9Tjw5f
 ZH9VQzNAH5pEhB2ghsuljC+ZxRTzWvtPWVI2Pwp1GNem2QIwdnpG/W4g0l6Z6QkxfaH2
 AZRwmzj9ddsisod3+f8PV81cqKzHG1W0jJPVE6APndh76u/1fH8xeyLTBHva9xnFSPzD
 Q6dH5DcYeKx+jWcTSpFF5EHspFHd0Bpz3uClXKOUV62HsYGbTRIz5yuKay62tHOj51H+
 Mo/fskJDyCJeLTGU24k2K+m7zQMJRBh8Or9UeEUHwh4etzNIQ3d2kysybQpXtukDZHfG
 Vaqw==
X-Gm-Message-State: AOJu0Yxv/qOrnlPMm5dPqRKM80Huh0+Wg+9ur34GH3FGHMdwU1vErQK/
 ac6Q6TZ0+NiBk1wB/nJdxMcJm3drYuw4bcCI7H4=
X-Google-Smtp-Source: AGHT+IHmi+pfvMEP6QaB21ASMsyDxA2e0BHfBbozqzIvBOoCuYPl8gB4wKRK3kE733t3h/ISwHtmbQ==
X-Received: by 2002:adf:e886:0:b0:323:37af:c7c7 with SMTP id
 d6-20020adfe886000000b0032337afc7c7mr1242878wrm.69.1697709954169; 
 Thu, 19 Oct 2023 03:05:54 -0700 (PDT)
Received: from localhost.localdomain (adsl-141.37.6.162.tellas.gr.
 [37.6.162.141]) by smtp.gmail.com with ESMTPSA id
 d13-20020a5d538d000000b003232d122dbfsm4110307wrv.66.2023.10.19.03.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:05:53 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	"Gerd Hoffmann" <kraxel@redhat.com>
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Igor Skalkin" <Igor.Skalkin@opensynergy.com>,
 "Anton Yakovlev" <Anton.Yakovlev@opensynergy.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 "Stefano Garzarella" <sgarzare@redhat.com>
Subject: [PATCH v12 11/11] docs/system: add basic virtio-snd documentation
Date: Thu, 19 Oct 2023 13:03:55 +0300
Message-Id: <c660c8427853d90784a89b6f3b0c31e19cc3be95.1697709630.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
References: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
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

This commit adds basic documentation for using virtio-snd.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS                        |  1 +
 docs/system/device-emulation.rst   |  1 +
 docs/system/devices/virtio-snd.rst | 49 ++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 docs/system/devices/virtio-snd.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index cd2663ada8..ca273ddb0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2274,6 +2274,7 @@ S: Supported
 F: hw/audio/virtio-snd.c
 F: hw/audio/virtio-snd-pci.c
 F: include/hw/audio/virtio-snd.h
+F: docs/system/devices/virtio-snd.rst
 
 nvme
 M: Keith Busch <kbusch@kernel.org>
diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index 1167f3a9f2..d1f3277cb0 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -93,6 +93,7 @@ Emulated Devices
    devices/vhost-user.rst
    devices/virtio-gpu.rst
    devices/virtio-pmem.rst
+   devices/virtio-snd.rst
    devices/vhost-user-rng.rst
    devices/canokey.rst
    devices/usb-u2f.rst
diff --git a/docs/system/devices/virtio-snd.rst b/docs/system/devices/virtio-snd.rst
new file mode 100644
index 0000000000..2a9187fd70
--- /dev/null
+++ b/docs/system/devices/virtio-snd.rst
@@ -0,0 +1,49 @@
+virtio sound
+============
+
+This document explains the setup and usage of the Virtio sound device.
+The Virtio sound device is a paravirtualized sound card device.
+
+Linux kernel support
+--------------------
+
+Virtio sound requires a guest Linux kernel built with the
+``CONFIG_SND_VIRTIO`` option.
+
+Description
+-----------
+
+Virtio sound implements capture and playback from inside a guest using the
+configured audio backend of the host machine.
+
+Device properties
+-----------------
+
+The Virtio sound device can be configured with the following properties:
+
+ * ``jacks`` number of physical jacks (Unimplemented).
+ * ``streams`` number of PCM streams. At the moment, no stream configuration is supported: the first one will always be a playback stream, an optional second will always be a capture stream. Adding more will cycle stream directions from playback to capture.
+ * ``chmaps`` number of channel maps (Unimplemented).
+
+All streams are stereo and have the default channel positions ``Front left, right``.
+
+Examples
+--------
+
+Add an audio device and an audio backend at once with ``-audio`` and ``model=virtio``:
+
+ * pulseaudio: ``-audio driver=pa,model=virtio``
+   or ``-audio driver=pa,model=virtio,server=/run/user/1000/pulse/native``
+ * sdl: ``-audio driver=sdl,model=virtio``
+ * coreaudio: ``-audio driver=coreaudio,model=virtio``
+
+etc.
+
+To specifically add virtualized sound devices, you have to specify a PCI device
+and an audio backend listed with ``-audio driver=help`` that works on your host
+machine, e.g.:
+
+::
+
+  -device virtio-sound-pci,audiodev=my_audiodev \
+  -audiodev alsa,id=my_audiodev
-- 
2.39.2


