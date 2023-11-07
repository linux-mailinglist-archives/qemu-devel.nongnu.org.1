Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1408B7E388D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:12:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J38-0003bc-5R; Tue, 07 Nov 2023 05:11:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2w-0002hn-N4
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2v-0002UQ-03
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=exRXQxzSkBuHePlXjstPNpQJEvpRz38bCMREMqF6jhg=;
 b=KTq5TesSPrxwEQMVLMchMZsTHGBgfY+0KWwvPoBcuqwxOkspxzmyAFTvCUKLM/tETtJrN2
 Y/uTdeiemCveuK1JXuvT0suxeb5+3gZsk3MJbXG5EDPFhBRTn0XNoQsFIhYGAEGwgLlqm8
 GHzgaVQY7CtQEzJ51tLumjgwWoRk+iw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-_MT13OMtP1G6yQEGGvFC4A-1; Tue, 07 Nov 2023 05:10:54 -0500
X-MC-Unique: _MT13OMtP1G6yQEGGvFC4A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4084e4ce543so34963025e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351853; x=1699956653;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=exRXQxzSkBuHePlXjstPNpQJEvpRz38bCMREMqF6jhg=;
 b=cYBgNp4jKE+tjNuNcKT0ObyDe6Gcxv5efy9pFBDqXATq70FmWIdjFJ29VZSqL1rfyr
 Ny4WfIDq6791fSauHdNsobYW702TLSz4OmuX/DIV4FL5rjbUJkmtuhbPGFVHCoyTj37O
 mST4EpbkL3cTJCWv+Ob8hUVf+0TC4SG8PQQdKhxkIohkJ0QoFJgGowYcUGH86D4xNFBc
 kXnfzM426+/MLoN1wod+zZqG21HyueTNzlHa4ElMiy/s1qph1DovC5k1XZI7SQRTIOkb
 JGUhtTp1hBRQBSGHYdMtWbirqw8Ej87WILAjsqwzocL7aqMVZo4zVzk8wXCnUbyfkdY0
 45bw==
X-Gm-Message-State: AOJu0YwejGK3PIOCE3xLfB5iqIRjmGnvpZu5PsYE4w90QtaH5FHfqeYo
 mAXuELXKHnfZbLE6VsvghJdV3tdHCvn3Qa/i0fZ81HAHmrv92KpNDV7B7R5QrTa47aRm0440J89
 aOV06dPkZdE9VKJGQXvJGUpc9k7GAe34+fY5twfGze2+0oqbwl/IZxHgi72q91hCYa0JF
X-Received: by 2002:a05:600c:35ce:b0:402:8896:bb7b with SMTP id
 r14-20020a05600c35ce00b004028896bb7bmr1628320wmq.6.1699351853076; 
 Tue, 07 Nov 2023 02:10:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRw/GRG5qMCCwJmW/BIDMwgC0hRVYveijdIafuP9NS8vyYMUiEFdn/vaVjgH3xhtTSJp0D7A==
X-Received: by 2002:a05:600c:35ce:b0:402:8896:bb7b with SMTP id
 r14-20020a05600c35ce00b004028896bb7bmr1628299wmq.6.1699351852599; 
 Tue, 07 Nov 2023 02:10:52 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 h21-20020a05600c499500b0040586360a36sm14743133wmp.17.2023.11.07.02.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:10:52 -0800 (PST)
Date: Tue, 7 Nov 2023 05:10:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 18/63] docs/system: add basic virtio-snd documentation
Message-ID: <f54fea113cc48000836b95681f3b9fdbe43c7d96.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

This commit adds basic documentation for using virtio-snd.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <e7fb941cf7636fdff40cbdcdcd660dec5f15ca3c.1698062525.git.manos.pitsidianakis@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS                        |  1 +
 docs/system/device-emulation.rst   |  1 +
 docs/system/devices/virtio-snd.rst | 49 ++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 docs/system/devices/virtio-snd.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index c09bb8cf41..4fad272d73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2317,6 +2317,7 @@ S: Supported
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
MST


