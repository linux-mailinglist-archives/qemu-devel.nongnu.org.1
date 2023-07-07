Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D86374B3FB
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 17:19:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHnDB-0000u5-0J; Fri, 07 Jul 2023 11:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHnD8-0000tY-3j
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:17:30 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHnD4-0000b2-9j
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 11:17:29 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-993d1f899d7so88155166b.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 08:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688743043; x=1691335043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iBe6Qvj8pJduQ5hD1fED1nercV0+mcJtB8noLJOhi+Y=;
 b=Fq88KvfNrm3WCyYGBK2AF3ubFdZzZ0qJZr4Wqxilycrdgcs90dQE3Ht0JjXqqJOd+W
 Ki0Inw/OiXr4yN24+H9dRLYPVkhAGD9z823I2SSRJ1TKFqiUqgUa5mJplvMWFd2lJgf/
 91LoChPq0y8lWyCQzsBWH2o2Dcs+WeA+vnHDuBjrBRLaKWg+4sPZIDG2OAXVfHblzEkn
 82e0gYePHO9o7kl1ieKNnIl6sv1tvF4OWhf5IEGsjoOpZ4vz9+H2zDgEbhOnoXv1NEu5
 e2TN8eVgTiu6c6h2R0Ckj9fd1ZgRHkh+gf2sUlO8h3zEKbdkcFhgvU5baMV4VMvprS9Q
 /eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688743043; x=1691335043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iBe6Qvj8pJduQ5hD1fED1nercV0+mcJtB8noLJOhi+Y=;
 b=ZCza0xdQrbVuf0Bv717kZI7bZq5oAZcdrtM+Xx3EAmsYjPpmHF+gKQyuBLW5uAocX2
 wQpVfuBf71bDqeEHqEKtESeJk8ifGdhd/9SbVIgvp+gh91Jrb6IUOKPFtG3hh58oTtr/
 3LILq6cmoQxmDJYq1tqW1y9PN+4Ftr7jtBvcjTiYb1lROX40Byt0/Cf9mPeP6M744GUI
 nq0c8Q6pJ5ouBtQ4xFgpq6UTj16s8dYgu5yR8tdz0VVIerPTxaTIz03dnA+EyXzLobm1
 PBqfP9TjjXKi6RaJi11Ep0JI/4Qfve62awH3bkjMDJ9O/Vpp1I0Bulql9fEK1P45XQwX
 AxMA==
X-Gm-Message-State: ABy/qLaWkkw9SSjSAkWsU3IwDLZhq6vCctyru0tqd/SlJpReXmzBYsk8
 n20lRP9weBc/zIgIeNJ36kMYJz0MkpbMNJ0AqLc=
X-Google-Smtp-Source: APBJJlEnQ+dvzDqYrt1m7xbbzn7HYU0U7LNLk3Yu0dEMYWMRjJNP6YuX89QIfFRl4e71LWixBx4p7w==
X-Received: by 2002:a17:906:dc:b0:988:f307:aea3 with SMTP id
 28-20020a17090600dc00b00988f307aea3mr4545571eji.9.1688743043478; 
 Fri, 07 Jul 2023 08:17:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 h22-20020a170906399600b0099329b3ab67sm2311151eje.71.2023.07.07.08.17.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Jul 2023 08:17:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/6] hw/virtio: Build vhost-vdpa.o once for all targets
Date: Fri,  7 Jul 2023 17:17:13 +0200
Message-Id: <20230707151719.70613-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

v1: https://lore.kernel.org/qemu-devel/20230523163600.83391-12-philmd@linaro.org/

Since v1:
- Addressed Richard's review comments
- Split in multiple patches to KISS
- Rename system_virtio_ss[]

Philippe Mathieu-Daudé (6):
  hw/virtio: Propagate page_mask to
    vhost_vdpa_listener_skipped_section()
  hw/virtio: Propagate page_mask to vhost_vdpa_section_end()
  hw/virtio/vhost-vdpa: Inline TARGET_PAGE_ALIGN() macro
  hw/virtio/vhost-vdpa: Use target-agnostic qemu_target_page_mask()
  hw/virtio: Build vhost-vdpa.o once
  hw/virtio/meson: Rename softmmu_virtio_ss[] -> system_virtio_ss[]

 hw/virtio/vhost-vdpa.c | 36 +++++++++++++++++++++---------------
 hw/virtio/meson.build  | 25 +++++++++++++------------
 2 files changed, 34 insertions(+), 27 deletions(-)

-- 
2.38.1


