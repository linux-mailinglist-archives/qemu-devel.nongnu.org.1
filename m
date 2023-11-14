Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC477EB276
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:39:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2uYc-0002Z9-HL; Tue, 14 Nov 2023 09:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uYa-0002Ys-QQ
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:38:24 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uYY-0007hF-QL
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:38:24 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53e04b17132so8861078a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972701; x=1700577501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FMnSSW8jr/cJKCHmkfkuNGM9r6aQH+5mtjx4iGXWqMs=;
 b=x1c9VYGVBIa2E6Vhy3xFtAK2qPHrnH8oaemeaNSWbU0v3OsXxYUHUwjfBvHegBalBx
 NcMjM7lN196i9r2VMpCC04PDsAfUW0tGh97hLj0/DwML+f54AM55rI7I3UZIvwiWS09w
 ijmgfxxFwrnFS2inV5XoO3ErmepwSD5ROZHeVSGmsZ/s+B2R7mT8GhSW84OUes0xxL3B
 UsihIxwAgUA0ggPCfHb90vC2pMBzM4B4PzOEzIUNzHZYZtuGrSZODTOjJiDx49Sj0MGt
 1xHt2lZCzJMtKpOTxHfC+Cx7S9r9TZwuabTQK06PWHeWxg/jIssdpPpL0PseNOUpBwRB
 V73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972701; x=1700577501;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FMnSSW8jr/cJKCHmkfkuNGM9r6aQH+5mtjx4iGXWqMs=;
 b=UbG000HpkTfGdA+mLY+OmHdvurtrl5sg+uwNMA2T6ZHjUuzUmG8ZdcQ/WsHKmXwZW9
 kS4mgVK3JrBakTGvmqdQP3MG3ZVxn2KdDJ5uFTZ5ff1FXqmgs1UDfIxbu3j6FAuHgbGR
 3BO4X207/8oB0Smi7Aau6cbPZ1siiADbD6nhUxXrJfl0E4cJHnE16ml2bzna1cDXXIy1
 bZ3cPSKX1uxYtbYgnX2VOupC0RwAf0QQUQDcGnyflwMZCdnjeeN7B4BzqmUQVup68Tdh
 AE/pG/hStli/uF69+t7BJq+oIZ2pWCJFxBYFb3xwmOIcGcc3vSnoNg7qXV2XMc0q0BZA
 51FA==
X-Gm-Message-State: AOJu0Yze+TTLWZidMzXDEeJMFZHswAGz3pAWjfDfUWQsRR/6+Q5gd863
 H4sV3fpUwhEJ5NtZtK1772px2w==
X-Google-Smtp-Source: AGHT+IGalhPiUDY/2vhmD3Lr4wAa0t8q7dAjDO0/CMsaGIPZeXHvHP6kcXfcCCLtVPKEbEl31jhTGg==
X-Received: by 2002:aa7:cf12:0:b0:526:9cfb:c12 with SMTP id
 a18-20020aa7cf12000000b005269cfb0c12mr6182599edy.38.1699972700668; 
 Tue, 14 Nov 2023 06:38:20 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 r17-20020aa7da11000000b0054554a7bbedsm5137696eds.24.2023.11.14.06.38.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:38:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v2 00/19] hw/xen: Have most of Xen files become
 target-agnostic
Date: Tue, 14 Nov 2023 15:37:56 +0100
Message-ID: <20231114143816.71079-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

Missing review: 4-10,13,16,18-19

Since v1:
- Rework handle_ioreq() patch (Richard)
- Call xen_enabled() and remove various stubs
- Use QEMU_ALIGNED() in xen_blkif header
- Rename ram_memory -> xen_memory
- Have files using Xen API also use its CPPFLAGS
- Add missing license
- Added Avocado tag
- Added R-b tags

Hi,

After discussing with Alex Bennée I realized most Xen code
should be target-agnostic. David Woodhouse confirmed that
last week, so I had a quick look and here is the result.

More work is required to be able to instanciate Xen HW in
an heterogeneous machine, but this doesn't make sense yet
until we can run multiple accelerators concurrently.

Tested running on x86_64/aarch64 Linux hosts:

  $ make check-avocado AVOCADO_TAGS='guest:xen'

Regards,

Phil.

Philippe Mathieu-Daudé (19):
  tests/avocado: Add 'guest:xen' tag to tests running Xen guest
  sysemu/xen: Forbid using Xen headers in user emulation
  sysemu/xen-mapcache: Check Xen availability with
    CONFIG_XEN_IS_POSSIBLE
  system/physmem: Do not include 'hw/xen/xen.h' but 'sysemu/xen.h'
  hw/display: Restrict xen_register_framebuffer() call to Xen
  hw/pci/msi: Restrict xen_is_pirq_msi() call to Xen
  hw/xen: Remove unnecessary xen_hvm_inject_msi() stub
  hw/xen: Remove unused Xen stubs
  hw/block/xen_blkif: Align structs with QEMU_ALIGNED() instead of
    #pragma
  hw/xen: Rename 'ram_memory' global variable as 'xen_memory'
  hw/xen/xen_arch_hvm: Rename prototypes using 'xen_arch_' prefix
  hw/xen: Merge 'hw/xen/arch_hvm.h' in 'hw/xen/xen-hvm-common.h'
  hw/xen: Remove use of 'target_ulong' in handle_ioreq()
  hw/xen: Use target-agnostic qemu_target_page_bits()
  hw/xen: Reduce inclusion of 'cpu.h' to target-specific sources
  hw/xen/xen_pt: Add missing license
  hw/xen: Extract 'xen_igd.h' from 'xen_pt.h'
  hw/i386/xen: Compile 'xen-hvm.c' with Xen CPPFLAGS
  hw/xen: Have most of Xen files become target-agnostic

 hw/block/xen_blkif.h            |  8 +++-----
 hw/xen/xen_pt.h                 | 24 ++++++++++--------------
 include/hw/arm/xen_arch_hvm.h   |  9 ---------
 include/hw/i386/xen_arch_hvm.h  | 11 -----------
 include/hw/xen/arch_hvm.h       |  5 -----
 include/hw/xen/xen-hvm-common.h |  9 +++++++--
 include/hw/xen/xen_igd.h        | 33 +++++++++++++++++++++++++++++++++
 include/sysemu/xen-mapcache.h   |  3 ++-
 include/sysemu/xen.h            |  8 ++++----
 accel/xen/xen-all.c             |  1 +
 hw/arm/xen_arm.c                | 12 ++++++------
 hw/display/vga.c                |  5 ++++-
 hw/i386/pc_piix.c               |  1 +
 hw/i386/xen/xen-hvm.c           | 18 +++++++++---------
 hw/pci/msi.c                    |  3 ++-
 hw/xen/xen-hvm-common.c         | 23 ++++++++++++-----------
 hw/xen/xen_pt.c                 |  3 ++-
 hw/xen/xen_pt_config_init.c     |  3 ++-
 hw/xen/xen_pt_graphics.c        |  3 ++-
 hw/xen/xen_pt_stub.c            |  2 +-
 stubs/xen-hw-stub.c             | 28 ----------------------------
 system/physmem.c                |  2 +-
 accel/xen/meson.build           |  2 +-
 hw/block/dataplane/meson.build  |  2 +-
 hw/i386/xen/meson.build         |  4 +++-
 hw/xen/meson.build              | 21 ++++++++++-----------
 tests/avocado/boot_xen.py       |  3 +++
 tests/avocado/kvm_xen_guest.py  |  1 +
 28 files changed, 121 insertions(+), 126 deletions(-)
 delete mode 100644 include/hw/arm/xen_arch_hvm.h
 delete mode 100644 include/hw/i386/xen_arch_hvm.h
 delete mode 100644 include/hw/xen/arch_hvm.h
 create mode 100644 include/hw/xen/xen_igd.h

-- 
2.41.0


