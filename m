Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEA374D228
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:50:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInWs-0001xD-M0; Mon, 10 Jul 2023 05:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInWh-0001wf-45
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:49:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInWf-0003ZJ-9h
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:49:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbc244d384so43594395e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688982587; x=1691574587;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PFQ228QJ1ULYwaa8X7mJRHb37/NGxF2lONxPTU8t5wM=;
 b=QyupCxy2nPfCrLEixGLOuUhIFmKiix5STxZ7mV1WZ0hTkivGVMGXTjIm3dI9u6+Mji
 ibwqT/dWC1muaNMlvrXxcyOyBap5oxX0jCDgd5jJzaWRIVbNrD98Q6IZc5ZLEDzCmap/
 gZK0dYPD1j0KfALU2RRDgG4iyhk0fuI7f0lJ+1PmFRZSvCfOAxMAHCJu86Imjcf/c3OT
 eRkyKaohJabJtzDTeI8mUhLFmFzFRSiG8gx6nVgHHFefJ8wd97suiWglqCg3OB37uo51
 2G4D3y/fjgwu5hJ0gr8Eqg4i02SsmoMLwqAmHJXuLNSTcMHCZmPQG/BLFlkqqI/8VmXa
 c7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688982587; x=1691574587;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PFQ228QJ1ULYwaa8X7mJRHb37/NGxF2lONxPTU8t5wM=;
 b=KdJt//s/XnHK6CtK237ub0YPWr7DnNg9GafzKBKuDErztVT7/WJrNJCp+hazWnp+hk
 ZcfUMoRGGO5HSbLYU9rh/6KV0660Fd9oCWParw/Cl/ZHLIC4ff46FsYAyrKfD5hWYEYj
 r+fknbZH4+LI/x7kimOI41Fj6oFz7DYX4dww17LS8xrFHCUr/hadtDV5z4IxmjiwlkDG
 Iep9JVNbcd4lq37rIEhs+xauKMJaB7DN+wGVVDbWUe+fLgj9F5Xzn/Z6lkIuXCnC6Tdk
 pOg0coS/mxO3bOElhUjDGYrjKk1wv/ibHt8LQhHOkRdm454B75IReVmoAUj1nrIq4ar0
 986A==
X-Gm-Message-State: ABy/qLYuhqrxcphJsjlQRuHvzr9qfFrwqKXUMr/BJnBLwYXiMuPKDjm2
 7vGXCmk4v2VZIUTNvU+jmjEPVVM2jGidlSCFNJdMKA==
X-Google-Smtp-Source: APBJJlHpjjhq/89JHk4dWXPEHVKbr84lF0aBUl+YhTd1Y+H9kphZbRNu3tCEqznKtVW18NKWsAXIGA==
X-Received: by 2002:a05:600c:20c:b0:3fb:ff57:1750 with SMTP id
 12-20020a05600c020c00b003fbff571750mr6916260wmi.32.1688982587350; 
 Mon, 10 Jul 2023 02:49:47 -0700 (PDT)
Received: from localhost.localdomain (70.red-88-28-30.dynamicip.rima-tde.net.
 [88.28.30.70]) by smtp.gmail.com with ESMTPSA id
 k6-20020a05600c0b4600b003fc00892c13sm8616655wmr.35.2023.07.10.02.49.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 02:49:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/6] hw/virtio: Build vhost-vdpa.o once for all targets
Date: Mon, 10 Jul 2023 11:49:25 +0200
Message-Id: <20230710094931.84402-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Missing review: patch #4

Since v2:
- Added R-b tags
- Addressed Richard's review comment: page_mask = -page_size

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


