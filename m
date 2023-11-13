Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EB37E93FA
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 02:18:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2LZm-0000WB-Pl; Sun, 12 Nov 2023 20:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2LZj-0000Vy-5n
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 20:17:15 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2LZh-0003nP-DH
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 20:17:14 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso4056127b3a.3
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 17:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699838231; x=1700443031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NRil/3WXz3A5t4E/bnd1ZWl6zvRFOIC+1hfQyN4QTSY=;
 b=eA7E5G9jZIOFefPpC3ewgqgeITsoWSr5yxzW6li+jBYDWoYZAhD4gXF4YWjkgv10MB
 xT4Mi7sj1m5VhK46aq1+JnH6kNlgXJri3uEQvCIlDrvl4PjwkCs0IRaQvmK77Dnlwexd
 g5esdDavdxShYQPJdq/LY+9XiVZJ5IiC/BU1Y+sVh7hE9AWRUurNq/WqvhV3aXVERAag
 1dYfprCttCrc9db77gTdZw4o0blr38g7ign5VXnUpS7EjvtTYzNzf+Ngx0qpzRK0VaT+
 sCIuekPr2XE2ElEZZcv0fe1OaqkJFpfTdyXZfKId4Q20koJHf7l3Ddmg7beqwSP9YEwU
 2V1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699838231; x=1700443031;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NRil/3WXz3A5t4E/bnd1ZWl6zvRFOIC+1hfQyN4QTSY=;
 b=PB+LPiRKMrOZsR+gFemsGOnBt0YQX1/pfGKQFZnLdpDwImm5ku54jPQmjhpdT5P1EW
 gD9ww2OjhMFP2VzXVCCt/aTJaV8pwMCy18okyMN4r8tLnc2iLCi/gy9gucZB5SAP/4j2
 kZ1z3APORo5HcJHj/oiRMOwAi2E6Mq8cQeHo/uYz2K7+/4ngKEsEKr4zNFPOxTZIewTK
 NNLIOiw3aDcxUt8ZGQJSUYWOjC8ATdzJGvrE+SPIQZ3qIwEEheyB/h65gy7BiZFX+Y+y
 1c9vK/7BMBWdlsc48FGWoRvNfhSkI5TAtagKpu3u4A0/RMLY5ZDM87h/setIAv7cxJp/
 i4Dw==
X-Gm-Message-State: AOJu0YztFw6aDN98lmQwFR/vWJTKVmRSSAG9+V9sRVsWm4ItkeBBET7h
 qGQxTq0nqTYiJDKGYNeJn9spOOeWmn8Q1Z6AOKljMv42L9s=
X-Google-Smtp-Source: AGHT+IG/Fs2zmDdNOtTCfbUNZ6zNLpnPGgYNToUhMZTQwRPzYiF/hhCG0crxVYlKrKaYPdQMMBtN5Q==
X-Received: by 2002:a05:6a20:8f1e:b0:186:251f:7338 with SMTP id
 b30-20020a056a208f1e00b00186251f7338mr5625026pzk.19.1699838231060; 
 Sun, 12 Nov 2023 17:17:11 -0800 (PST)
Received: from localhost.localdomain ([128.1.74.235])
 by smtp.gmail.com with ESMTPSA id
 r6-20020aa78b86000000b0064f76992905sm2918511pfd.202.2023.11.12.17.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 17:17:10 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/4] virtio: Refactor vhost input stub
Date: Mon, 13 Nov 2023 09:16:38 +0800
Message-Id: <20231113011642.48176-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=leo.yan@linaro.org; helo=mail-pf1-x434.google.com
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

This series is to refactor vhost stub vhost-user-input.

Since vhost input stub requires set_config() callback for communication
event configurations between the backend and the guest, patch 01 is a
preparison for support set_config() callback in vhost-user-base.

The patch 02 is to add documentation for vhost-user-input.

The patch 03 is to move virtio input stub from the input folder to the
virtio folder.

The patch 04 derives vhost-user-input from vhost-user-base.  We reuse
the common code from vhhost-user-base as possible and the input stub is
simplized significantly.

This patch set has been tested with the backend daemon:

  # ./build/contrib/vhost-user-input/vhost-user-input \
		     -p /dev/input/event20 -s /tmp/input.sock

The series is based on "[PATCH v8 0/7] virtio: cleanup
vhost-user-generic and reduce c&p" which introduces vhost-user-base.
Based-on: <20231107180752.3458672-1-alex.bennee@linaro.org>


Leo Yan (4):
  hw/virtio: Support set_config() callback in vhost-user-base
  docs/system: Add vhost-user-input documentation
  hw/virtio: Move vhost-user-input into virtio folder
  hw/virtio: derive vhost-user-input from vhost-user-base

 docs/system/devices/vhost-user-input.rst |  44 ++++++++
 docs/system/devices/vhost-user.rst       |   2 +-
 hw/input/meson.build                     |   1 -
 hw/input/vhost-user-input.c              | 136 -----------------------
 hw/virtio/meson.build                    |   4 +-
 hw/virtio/vhost-user-base.c              |  17 +++
 hw/virtio/vhost-user-input-pci.c         |   3 -
 hw/virtio/vhost-user-input.c             |  58 ++++++++++
 include/hw/virtio/virtio-input.h         |   6 +-
 9 files changed, 126 insertions(+), 145 deletions(-)
 create mode 100644 docs/system/devices/vhost-user-input.rst
 delete mode 100644 hw/input/vhost-user-input.c
 create mode 100644 hw/virtio/vhost-user-input.c

-- 
2.34.1


