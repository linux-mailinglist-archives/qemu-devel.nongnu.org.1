Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 821667CC579
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 16:03:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qske7-0003rM-RK; Tue, 17 Oct 2023 10:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qske5-0003n1-Bc
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:02:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qskdx-0008Hr-Ta
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 10:02:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4065dea9a33so53620445e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697551315; x=1698156115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U07vvwJvdXtod6zAds5vLdaXE9ec4HFeXce7l7flLYk=;
 b=AbWopEscAmCuvEamEgZuh8g+L4UlokKMXBg4l7tMC1JyNPtzGDyC8aw7IjaCMXOkTd
 Uy54kYnw69nTvmP6K442zvMiIOnrx+t5sJ0vuYY55AlNMI3E+EQkOBBRf8IJ4YzTIRYv
 LHDEmzGiBXJGfOCg3B+Osxl4z9iThyuRlN5nhwyMphRn1dbmfgVbBVnydoRJ7aKflso8
 CB8Kv8iInY9OR8LiIeLNvvv4Rz/2XtEBt+Wuy756Di9cziH0/1jmuQjwqKdlUTZcKz49
 pzBporv0SbPdo2hG1vqpdkNSVmi1ir0toDCO9MGkLQL87MkjnVUoYzJA+S91HeJpl35c
 6rpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697551315; x=1698156115;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U07vvwJvdXtod6zAds5vLdaXE9ec4HFeXce7l7flLYk=;
 b=Qxdkzfyd+MsK2M1NGvwdi2YiAAiZhh/+zPAWT1IENA5TUEApvnLVOvnHiY2drymkZK
 Ga/HZjoVsd2fJ+EFQ9pvp2HIcxLgVgtm/QFrTPxeG3qFc7gkoe7C+9MHGwV+XsAJsJHa
 o25FeKR0ZooUJW1XF96X1qt0qxMM93BTE958DyJs0elqId2m7pTwsKwyL/ynQpMOOMEM
 0aMes4bgJsVMmXxYcdte4401gIk9c5TTyhADDbjodAft1ya5XJH86fx/UkJzEezc8r2X
 Rj9a8NUOVKK1TJKxNxSZOoSpwKYw9z1he6xS4/+xCOe0SLhIN8KHjvAAjfOKFq76mTvS
 /77w==
X-Gm-Message-State: AOJu0YwHkqtT/ZGEvLMUbo31CDaTu3AWYlCUSGTQhIweySE42OKOnsOI
 JnOiGhl3gyxCNVLJU12XWgObzdwHwSnI96azPWW0Yg==
X-Google-Smtp-Source: AGHT+IHvPkhCdGp5Hy0FBGWuHoRpmwvHC66bu12tErSh6G6pWNRweEExuX28TAfOP+aGh0kDBRoy+A==
X-Received: by 2002:a05:600c:4f81:b0:405:4002:825a with SMTP id
 n1-20020a05600c4f8100b004054002825amr1794417wmq.13.1697551314609; 
 Tue, 17 Oct 2023 07:01:54 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 fj7-20020a05600c0c8700b0040772138bb7sm9973513wmb.2.2023.10.17.07.01.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Oct 2023 07:01:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/7] hw: Few more QOM/QDev cleanups
Date: Tue, 17 Oct 2023 16:01:43 +0200
Message-ID: <20231017140150.44995-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

- Remove a pointless check,
- Use QOM cast macros,
- Declare QDev links statically using DEFINE_PROP_LINK()

Philippe Mathieu-Daudé (7):
  hw/virtio/virtio-pmem: Replace impossible check by assertion
  hw/block/vhost-user-blk: Use DEVICE() / VIRTIO_DEVICE() macros
  hw/display/virtio-gpu: Use VIRTIO_DEVICE() macro
  hw/scsi/virtio-scsi: Use VIRTIO_SCSI_COMMON() macro
  hw/dma: Declare link using static DEFINE_PROP_LINK() macro
  hw/net: Declare link using static DEFINE_PROP_LINK() macro
  hw/usb: Declare link using static DEFINE_PROP_LINK() macro

 hw/block/vhost-user-blk.c |  4 ++--
 hw/display/virtio-gpu.c   |  2 +-
 hw/dma/xilinx_axidma.c    |  6 ++----
 hw/dma/xlnx-zdma.c        |  7 ++-----
 hw/dma/xlnx_csu_dma.c     | 13 ++++---------
 hw/net/cadence_gem.c      |  7 ++-----
 hw/scsi/virtio-scsi.c     |  2 +-
 hw/usb/hcd-xhci-sysbus.c  |  4 ----
 hw/usb/hcd-xhci.c         |  2 ++
 hw/virtio/virtio-pmem.c   |  5 +----
 10 files changed, 17 insertions(+), 35 deletions(-)

-- 
2.41.0


