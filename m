Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D153D75841B
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 20:05:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLp3z-0002SB-11; Tue, 18 Jul 2023 14:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qLp3x-0002Ry-QQ
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:04:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qLp3w-0003Zy-6Z
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:04:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc54cab6fso55196705e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 11:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689703477; x=1692295477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yAQgwV3eQ8285Xh6uzWkIHazXNRsUV6lvcp/Cyfwanw=;
 b=bFInejPMN92K3w1AnomvSSPrdkZTnztxSDJus4EJMd/NjhkvWxopvbrOLkxftz8TNM
 YnxEGn8VVQfrW5dFeslS/93XH6woWh6GDifOewpOBs3Kha2uhTATZ/apZg+JRnpSJGcQ
 c6IFUqGxT4G/18tN3orYENu5Dr6UYM5ooLKKTaJEgNrTZB6BzfeDQ2IR7dnEThumaHw9
 k1byY5TIEKsOKo1f6X6fM8ZnrgNgWvlvodTcZfw7JmZRkUz5dix0KyEU5hoSainoxYr5
 eAulIysWVYhQolgJwrtHof5QH7mUO0U/jX6t8gzL1dlOQwtsZ9FZ2Q24mprLpyoq3RyG
 3qIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689703477; x=1692295477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yAQgwV3eQ8285Xh6uzWkIHazXNRsUV6lvcp/Cyfwanw=;
 b=FbrCRoMj4KmCzMda6rOTedM0dCyIjnlO6jOrhnpzeQlL4JLEHyzuycAIpwZY4F0cG+
 5VjPgB5qGvyoYwBAPxaw7zizwtKPKeQ4U3PLZP5wguYkDDPMKYfvGQYH191+G7LniuGA
 4uNz+GwmFuJ4gGxyoBkzBXJFYDdeNK7vyDmKcsZJXyyory+lTD6Nbt9RIhudal4sG3Rs
 ByGoe/RYm8tyji8D/Qm8P1xWeXQx1eNT+jmUFJjQOWe543mZS6y9hLWfSz7QY4QlLr9y
 JbEk8JZ0G5dVxaIxMDDLm+c6YUian7c0ggiOFuVIOBBtKZmlNhoIfd1yNBKkQuBM0um+
 OEeg==
X-Gm-Message-State: ABy/qLaJwOjVc8GBWXAug+IAam1uVj+lPRWdsMTwhvNiLlVKH6RH7EAI
 9D5lUDv4bREUEtzxxQhksxwHWco4MkNIriCycprb5PxZ
X-Google-Smtp-Source: APBJJlGc5Oxclkgxkb+CLvFFUgJUJMLqFz8/9t+cniY3oyRqlkp2uStd8kW9SkusGwBT4uD1sq8+bg==
X-Received: by 2002:a1c:7318:0:b0:3fb:d1db:5454 with SMTP id
 d24-20020a1c7318000000b003fbd1db5454mr2530010wmb.35.1689703477475; 
 Tue, 18 Jul 2023 11:04:37 -0700 (PDT)
Received: from localhost.localdomain (adsl-17.37.6.3.tellas.gr. [37.6.3.17])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a7bca49000000b003fc17e8a1efsm10764311wml.45.2023.07.18.11.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 11:04:36 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
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
 "Alex Bennee" <alex.bennee@linaro.org>
Subject: [PATCH v3 0/3] Add VIRTIO sound card
Date: Tue, 18 Jul 2023 21:04:13 +0300
Message-Id: <cover.1689692765.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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

This patch series adds an audio device implementing the recent virtio 
sound spec (1.2) and a corresponding PCI wrapper device.

Main differences with v2 patch 
<cover.1686238728.git.manos.pitsidianakis@linaro.org>:
- Addressed review comments.

Manos Pitsidianakis (3):
  Add virtio-sound device
  Add virtio-sound-pci device
  Implement audio capture in virtio-snd device

 MAINTAINERS                    |    6 +
 hw/virtio/Kconfig              |    5 +
 hw/virtio/meson.build          |    2 +
 hw/virtio/trace-events         |   22 +
 hw/virtio/virtio-snd-pci.c     |  101 +++
 hw/virtio/virtio-snd.c         | 1289 ++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h           |    1 +
 include/hw/virtio/virtio-snd.h |  194 +++++
 softmmu/qdev-monitor.c         |    1 +
 9 files changed, 1621 insertions(+)
 create mode 100644 hw/virtio/virtio-snd-pci.c
 create mode 100644 hw/virtio/virtio-snd.c
 create mode 100644 include/hw/virtio/virtio-snd.h

-- 
2.39.2


