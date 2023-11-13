Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E2D7EA340
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 20:03:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2cCg-0002cq-JP; Mon, 13 Nov 2023 14:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2cCd-0002ch-Ni
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:02:31 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1r2cCc-0000KP-3I
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 14:02:31 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-421ae930545so23937091cf.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 11:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699902148; x=1700506948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=A9B8vhmBdTNNLSSb0o4IuksifGIRJjzQsowtMpmMZmY=;
 b=uS6B7ZX1wATZ0HosTRCldPsYYMHIK7pt+Lx+aJjGSA7pYSwpjbQ/Xb1lZU97ZUTi33
 dh4pwUApN1vdNOkgqH9DwACelhc8GtazAtGxRlTRhwmavVaVFySOBd3El4x7ey/ZIwRX
 xhJ8Rz1IchFdDTTYEmq0cDJKjSO7ebQX07NC9bUg02UXr6HVAPQ1LTGo9jtsEZNIfVyZ
 9h9iJl6/B8+xBCO62nw1M7D1ChfiFPhOtWk/+SRCEQmMY2cYUmLctAE/mhvXsSP8apPu
 Jq/5tPZx/8RbnY6fiROHBaCL53yJJ/CAiRjRdWvTPcZL/kpm5yXjFnT9d/qOYkmzlTV8
 /qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699902148; x=1700506948;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A9B8vhmBdTNNLSSb0o4IuksifGIRJjzQsowtMpmMZmY=;
 b=lCeJoeRFIh9MdmLKd1CTuZKuZYa5l5UwhU5HaoawxLZQzvD4s8g3irNMp6dl+BKfiR
 Gyk9fQKab/iY2TbFUwupp8xSJ2uKb1R825MKwbh2/7kyYmC2v5Yqud5ZLK30trrXIe7F
 ZeeYrqTdOL6ChFg2pOALPa9fb3Eq3prX1sklIT9gh9UODRdxCCk72wTGGK0P3wez6n+9
 EVPQoKxnFYfvd2+ZcpLtCsLkAbEwZjpGXp92tQwObaGn645p8hUVTVmYdWggD/I0LZpp
 Va8/aCmUcJ99hBLtu+KMGb/zpCUk/vQJeTRBC2ZXzIB+e9zegr8y7PNBoAR4qLvfwcIG
 ZEbg==
X-Gm-Message-State: AOJu0YyskzPgD9cmaaMaWecaqafU+Nq0HM7LsXuSO9/pN3huXcmrED18
 DM+waMYGaPKzK/ZxqtKVImHMws+dxUM+qlQBDdB5DITlEvs=
X-Google-Smtp-Source: AGHT+IFALW2ejjl3WCEIanqwwMnxyanEKWdVJoYu5YT1Nsapu6gxGnLtnqV3CIuW7l3ZRikf/I+5kQ==
X-Received: by 2002:a05:622a:3c7:b0:421:b48d:af02 with SMTP id
 k7-20020a05622a03c700b00421b48daf02mr12686qtx.19.1699902148345; 
 Mon, 13 Nov 2023 11:02:28 -0800 (PST)
Received: from localhost.localdomain ([12.186.190.1])
 by smtp.gmail.com with ESMTPSA id
 kq4-20020ac86184000000b004181c32dcc3sm2124834qtb.16.2023.11.13.11.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 11:02:27 -0800 (PST)
From: Leo Yan <leo.yan@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/4] virtio: Refactor vhost input stub
Date: Tue, 14 Nov 2023 03:02:07 +0800
Message-Id: <20231113190211.92412-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=leo.yan@linaro.org; helo=mail-qt1-x832.google.com
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

Changes from v1:
- Fixed typo in vhost-user-input.rst.
- Updated MAINTAINERS for new added input document and
  changing folder for vhost-user-input.c.


Leo Yan (4):
  hw/virtio: Support set_config() callback in vhost-user-base
  docs/system: Add vhost-user-input documentation
  hw/virtio: Move vhost-user-input into virtio folder
  hw/virtio: derive vhost-user-input from vhost-user-base

 MAINTAINERS                              |   3 +-
 docs/system/devices/vhost-user-input.rst |  44 ++++++++
 docs/system/devices/vhost-user.rst       |   2 +-
 hw/input/meson.build                     |   1 -
 hw/input/vhost-user-input.c              | 136 -----------------------
 hw/virtio/meson.build                    |   4 +-
 hw/virtio/vhost-user-base.c              |  17 +++
 hw/virtio/vhost-user-input-pci.c         |   3 -
 hw/virtio/vhost-user-input.c             |  58 ++++++++++
 include/hw/virtio/virtio-input.h         |   6 +-
 10 files changed, 128 insertions(+), 146 deletions(-)
 create mode 100644 docs/system/devices/vhost-user-input.rst
 delete mode 100644 hw/input/vhost-user-input.c
 create mode 100644 hw/virtio/vhost-user-input.c

-- 
2.34.1


