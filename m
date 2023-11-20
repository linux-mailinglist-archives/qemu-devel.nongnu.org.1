Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3AE7F1F39
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:34:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5BtT-0000rG-7I; Mon, 20 Nov 2023 16:33:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BtQ-0000qg-TI
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:33:21 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5BtO-00037J-58
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:33:20 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-332c7d4a6a7so845257f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700515996; x=1701120796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hTS81rcfQfLYfQDgcPUQbgGkksTLDJmJ/NWa4pFo3AE=;
 b=kRHWp2v+cqgTP7Qcv2CEVV2AK9DkO3QlLyqLwRzlr2DyHbSjx6HCowqurzeaA9wfps
 +MY7Yc4ciEQINq4lctpBuXjjap3qpyrUIdQAuiX10uwgw8p7fAbLAhaaGyw38S4Zs9+B
 StMG1uZQYoH4hCRGBtGqQemXt3EecdGt1OUUs2jT58ePfjqPP9Qiecat1avxrBVcw98a
 N+tCOkMz/qNPdNFaYm2o9hDinkY+gcLqg9lQxtaIy39JRjx6jKuH6Ke3JQw7NHzN5cIO
 LbahMaBLhcrNkkZDKDBoOo912geTo5Ui7rudX59l76KN6c10TIEEa2ag5DCE4jRvq/zF
 IVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700515996; x=1701120796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hTS81rcfQfLYfQDgcPUQbgGkksTLDJmJ/NWa4pFo3AE=;
 b=vtf/yN0NsyhLY51SJIq5OjN0rWuZb/+lhV1W4In7gJelQVWFJ1rSOXG4Oir6HzXvCL
 28W2gXXsGMTCZ1VW0iXe65WK6PgSGg3t2KhHWnjVG7BCfrfuRLYEJJvKkxv5PhBj69G0
 FnGOlPnowpUZFB9R8yg+bV+S1iy0F73bzxw2cUm7qzXcV81e+iqQcw6e5UzriVU//8I1
 qHQUiAHoOZsZTVBUigtQdZLbihoSTcK4V9FM651+bK7IvuejD1PC9yPP+LxpLFHjwtXd
 vbOQnuxxCof2gvGEK7a/vYC/kuzM6AZ8y2J7zDpjYGuQJMMtIYL27524n8pf/Qmy7Q2N
 44gw==
X-Gm-Message-State: AOJu0YyJSFZ5rKslMo2fXtX2YPcutFzgMx89B0jQyN9Jtjh1pV13lfBQ
 VNCE5fWjapSHj3kF0DtQShAOId7tXpTYed4Zfe8=
X-Google-Smtp-Source: AGHT+IEUZaPQ0WGY6zKRrJOTlw513AG12Fp0kK3RZpdajNQXtcUZb/Xg4yVvB/XIeKzzLRwodgeTJA==
X-Received: by 2002:adf:fd0c:0:b0:32f:889a:2b9f with SMTP id
 e12-20020adffd0c000000b0032f889a2b9fmr5519318wrr.15.1700515996324; 
 Mon, 20 Nov 2023 13:33:16 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 dd11-20020a0560001e8b00b0032db8f7f378sm12302913wrb.71.2023.11.20.13.33.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:33:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH-for-9.0 00/25] memory: Propagate Error* when possible
Date: Mon, 20 Nov 2023 22:32:34 +0100
Message-ID: <20231120213301.24349-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

This series is remotely connected with the "dynamic machine"
project. We need QOM objects created either from command line,
QMP or loaded by modules to NOT fail exiting the whole QEMU
process, but cleanly propagate any error before failing cleanly.

In preparation for that big goal, we start reworking a bit the
Memory API to be able to propagate all errors.

This targets the 9.0 release, but posting earlier to discuss with
Markus meanwhile.

Regards,

Phil.

Philippe Mathieu-Daudé (25):
  memory: Have memory_region_init_ram_flags_nomigrate() return a boolean
  memory: Have memory_region_init_ram_nomigrate() handler return a
    boolean
  memory: Have memory_region_init_rom_nomigrate() handler return a
    boolean
  memory: Simplify memory_region_init_rom_nomigrate() calls
  memory: Simplify memory_region_init_ram_from_fd() calls
  memory: Have memory_region_init_ram() handler return a boolean
  memory: Have memory_region_init_rom() handler return a boolean
  memory: Have memory_region_init_rom_device_nomigrate() return a
    boolean
  memory: Simplify memory_region_init_rom_device_nomigrate() calls
  memory: Have memory_region_init_rom_device() handler return a boolean
  memory: Have memory_region_init_resizeable_ram() return a boolean
  memory: Have memory_region_init_ram_from_file() handler return a
    boolean
  memory: Have memory_region_init_ram_from_fd() handler return a boolean
  backends: Use g_autofree in HostMemoryBackendClass::alloc() handlers
  backends: Simplify host_memory_backend_memory_complete()
  backends: Have HostMemoryBackendClass::alloc() handler return a
    boolean
  backends: Reduce variable scope in host_memory_backend_memory_complete
  util/oslib: Have qemu_prealloc_mem() handler return a boolean
  misc: Simplify qemu_prealloc_mem() calls
  hw: Simplify memory_region_init_ram() calls
  hw/arm: Simplify memory_region_init_rom() calls
  hw/sparc: Simplify memory_region_init_ram_nomigrate() calls
  hw/misc: Simplify memory_region_init_ram_from_fd() calls
  hw/nvram: Simplify memory_region_init_rom_device() calls
  hw/pci-host/raven: Propagate error in raven_realize()

 include/exec/memory.h    |  40 ++++++++---
 include/qemu/osdep.h     |   4 +-
 include/sysemu/hostmem.h |  10 ++-
 backends/hostmem-epc.c   |  14 ++--
 backends/hostmem-file.c  |  22 +++---
 backends/hostmem-memfd.c |  13 ++--
 backends/hostmem-ram.c   |  12 ++--
 backends/hostmem.c       | 144 ++++++++++++++++++---------------------
 hw/arm/aspeed_ast2400.c  |   6 +-
 hw/arm/aspeed_ast2600.c  |   6 +-
 hw/arm/fsl-imx25.c       |  19 ++----
 hw/arm/fsl-imx31.c       |  19 ++----
 hw/arm/fsl-imx6.c        |  19 ++----
 hw/arm/integratorcp.c    |   7 +-
 hw/arm/nrf51_soc.c       |   7 +-
 hw/misc/ivshmem.c        |   8 +--
 hw/nvram/nrf51_nvm.c     |   7 +-
 hw/pci-host/raven.c      |   6 +-
 hw/ppc/rs6000_mc.c       |   7 +-
 hw/sparc/sun4m.c         |  20 ++----
 hw/sparc64/sun4u.c       |   7 +-
 hw/virtio/virtio-mem.c   |   6 +-
 system/memory.c          |  68 ++++++++++--------
 util/oslib-posix.c       |   7 +-
 util/oslib-win32.c       |   4 +-
 25 files changed, 234 insertions(+), 248 deletions(-)

-- 
2.41.0


