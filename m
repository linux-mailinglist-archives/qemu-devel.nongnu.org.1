Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ECD784A29
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:20:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWuy-0006R1-5k; Tue, 22 Aug 2023 15:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWuv-0006Jq-Sn
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWut-0000wO-Jg
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-319e93a1594so4438230f8f.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 12:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692731989; x=1693336789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ex2wYhsS71++plSwD4vywQfTwawR7Om/B/i5Q+QelHk=;
 b=CGawmIMPr+KKww1AGg+Hj29zSPM98Ur3VBM2UqMjf0nBvTK18ool/R6S1nWUCynl0Q
 biC07tsMbuROHw7PzME8F5eH7x1+SXdV7GytS+13COepMxYwnKIEn2s2fNj02V1kppMO
 4FZbI4MKB8CsI2gg5tSX1MivhRgasb2c+8M5k0kubaKdqBet15pk6Hmx9eiCiGx4vtTm
 rMemrDk9gX0fTSYLiyu7w1gC2auQSxdQLyvT9KBCSPB2auwS0SNOK6kaAxRgncsSmtPj
 wHuml4GYYJw+X0TJAA20fX+YHuOnxo51quUzagKTmVVz1kxic7dWaGjWHe4AhwQacEyy
 LdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692731989; x=1693336789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ex2wYhsS71++plSwD4vywQfTwawR7Om/B/i5Q+QelHk=;
 b=f7TAag8e3tp/X4thGopZQaqpLohzqgsTle1sAPS/TjJq4zZcguEDApA69gBcQhss5c
 D8Z2a11fN3LXlU0FOp0g0WS7lrszOpA80FmspttOaOYFeEv5hpdsRFEInKlrHHdwWBO+
 EoWxprUQJBIl2CsBw0iTFfRYNq67KsBI+d4uIk1jLofkKUn+py16nPsAezKqj4ilxZ9h
 fpGtF6FtT9GrCF2W4Nm+xZsak7y9272VD5mBkYA7rHL7YDTUlsS9+JmqehhxWwslnVoD
 TEzf8eepDH9zAKQJ0sKsv/5nyM+Lrpv079wfy45yvT6hJ273XwRbZsDs0rVGPpk8qrfn
 XFAw==
X-Gm-Message-State: AOJu0YxL6M0SkW8gokoSJ+gt7h+zN964E+/5K09NQKqaXl0Wbimngcui
 cj4KncBY4IFhFeEstRLcpFFTyFW1o1VWcV1SYIA=
X-Google-Smtp-Source: AGHT+IFiggDxmZr8/mDl+OamB4cWThFrkoLGTyxkZmYvnmO01W9toE5KxDHc5Xx9v8hv02ha4fEzbg==
X-Received: by 2002:a5d:45c6:0:b0:319:854a:9ea1 with SMTP id
 b6-20020a5d45c6000000b00319854a9ea1mr7395294wrs.15.1692731989602; 
 Tue, 22 Aug 2023 12:19:49 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.109.242.225.tellas.gr.
 [109.242.225.200]) by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c294400b003fe2a40d287sm126905wmd.1.2023.08.22.12.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 12:19:49 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Igor Skalkin" <Igor.Skalkin@opensynergy.com>,
 "Anton Yakovlev" <Anton.Yakovlev@opensynergy.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 12/12] docs/system: add basic virtio-snd documentation
Date: Tue, 22 Aug 2023 22:18:35 +0300
Message-Id: <6bed90224721b36df5c0c125df5ae4e0d7da2fa3.1692731646.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
References: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x435.google.com
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
---
 docs/system/device-emulation.rst   |  1 +
 docs/system/devices/virtio-snd.rst | 49 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 docs/system/devices/virtio-snd.rst

diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index 4491c4cbf7..dae19446e5 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -92,6 +92,7 @@ Emulated Devices
    devices/usb.rst
    devices/vhost-user.rst
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


