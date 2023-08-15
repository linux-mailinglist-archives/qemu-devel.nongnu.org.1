Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8181A77C9FA
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 11:09:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVq2r-0005bF-8S; Tue, 15 Aug 2023 05:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVq2p-0005Xy-Ew
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 05:08:55 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVq2n-0005FK-66
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 05:08:55 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b9f48b6796so78683031fa.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 02:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692090531; x=1692695331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJu53+vAfr/Z+of/xFoYQgjefaYOdjmVFpoIqpi6WZc=;
 b=Ojg2t80zXf/NFQ/bGO3+wBx44IS2olW0zZHAXT/dfO8Zrd71l+oXJ6+GBrTn7eLOvk
 7TtnT5Iz0Vtwd/Yr8ZgHONSMeMVtbx8LVYtmaDV2GiJZieHcppC8A4cv+yEKSFmEw6pq
 IooP73Ms2RIywX8W382j+v+zVlZd38BQUD0RPDRTA+LBSOENI3qBa8rCQorrmgvBobj4
 wqmNqa0QoXAsR1KfQL3JAxpKXk9Hz3P9iSQMDaRm0WdMzn1tS+KCn8D7rhGD2Y1rnxxj
 Eg8w5rqH/9dX5+6WvMvMU6wn6Dpx64EtOc5GMaz/kp03nAz4Dnzkyr7XRNnfiMULhuS/
 4n9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692090531; x=1692695331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJu53+vAfr/Z+of/xFoYQgjefaYOdjmVFpoIqpi6WZc=;
 b=GEybQuClhWCKlaKAinOgHJn3e/G+3OpEDa3ypL0jLdBd4jO8zrHyhoIkf1sQerQx+K
 CqWOIrVlI7XHN8tEtrfvSP9miXBGO533tHenIFSKDdfcTdde1JCNP47+wlbAYwepWXwz
 5g77PwFT8rHz1oC9WhhJS4BUw3JIOEEjRpzwwy7fks96MMx8//Wt8aJ0zKFHDOYx/n37
 RCf8UEAjuxLcKm9voQ2WKWrNona9bk8JmgV0t92jcOrSNWWHo4by6vDBJLjXGNSKxkNm
 sy5il38PtYAEMq3fJjEFydiCydpainIgo95jRQ++tovGPpW35Y4vdmBIXy43w209xoSq
 pzQA==
X-Gm-Message-State: AOJu0YySh7C3jf3gRJQ85PjIFctuWXlP7FlvCToxfYldXJ5LAKttJWCf
 Ijc2NFm1XkWngDFbmufpSaLsAGX3kHmj2m3Jp7s=
X-Google-Smtp-Source: AGHT+IGsx3UQ1xSNuzCIrqvZLoqwhTb8+Ane+dE/BU4xuiU6tCD134ikxi7H2vsxufb0js3BxrVOBw==
X-Received: by 2002:a2e:7c19:0:b0:2ba:18e5:106f with SMTP id
 x25-20020a2e7c19000000b002ba18e5106fmr8352012ljc.30.1692090531463; 
 Tue, 15 Aug 2023 02:08:51 -0700 (PDT)
Received: from localhost.localdomain (adsl-56.37.6.0.tellas.gr. [37.6.0.56])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a7bc4c8000000b003fe505319ffsm19774707wmk.18.2023.08.15.02.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 02:08:50 -0700 (PDT)
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
Subject: [PATCH v6 12/12] docs/system: add basic virtio-snd documentation
Date: Tue, 15 Aug 2023 12:07:17 +0300
Message-Id: <a3f2576f6a5198e01cf02176a85bbb39892d789e.1692089917.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
References: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x234.google.com
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
 docs/system/devices/virtio-snd.rst | 36 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
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
index 0000000000..b73de6b42d
--- /dev/null
+++ b/docs/system/devices/virtio-snd.rst
@@ -0,0 +1,36 @@
+virtio-snd
+==========
+
+This document explains the setup and usage of the virtio-snd device.
+The virtio-snd device is a paravirtualized sound card device.
+
+Linux kernel support
+--------------------
+
+virtio-snd requires a guest Linux kernel built with the
+``CONFIG_SND_VIRTIO`` option.
+
+Description
+-----------
+
+virtio-snd implements capture and playback from inside a guest using the
+configured audio backend of the host machine.
+
+Examples
+--------
+
+Add a PCI device:
+
+::
+
+  -device virtio-sound-pci,disable-legacy=on
+
+And an audio backend listed with ``-audio driver=help`` that works on
+your host machine, e.g.:
+
+ * pulseaudio: ``-audio driver=pa,model=virtio-sound``
+   or ``-audio driver=pa,model=virtio-sound,server=/run/user/1000/pulse/native``
+ * sdl: ``-audio driver=sdl,model=virtio-sound``
+ * coreaudio: ``-audio driver=coreaudio,model=virtio-sound``
+
+etc.
-- 
2.39.2


