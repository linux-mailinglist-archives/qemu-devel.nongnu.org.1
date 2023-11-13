Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A53557E9FDF
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 16:23:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Ykd-0001Z7-5N; Mon, 13 Nov 2023 10:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2Yka-0001YY-TG
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:21:20 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2YkZ-0003Cv-7u
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:21:20 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53e3b8f906fso6970632a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 07:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699888877; x=1700493677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wYPq4PnrkT6VT7CGpVPJFK/tNxRA7Q2Z3pzO9BbyyC0=;
 b=H9xyWEJ8H0YqVlqfzKWaKx16oZWptdeFnCCK97lXtdNUv6D9kIiUBcbtq37lzLLE3M
 s6RGPh4vAvvJQsrlqmuJSdudyZnInYtaRjonCznPcmfd6fU5W+klY2cl5ELUMAWNhAop
 qIhKID7R5ByD627HGrFRZDnmMSPojTm/XdMegjIOSgYkZs0CRTr1fA3s1iYW44+fW4MM
 ekFQT6Re+MDt+Fy3uZS3nhiJ/MYJ5WtrJ7FpYB+8owvVWjDpdrQIm38AqjFhP508BK8f
 o1CAYm1HTu/CPkVNIhDueJw8ogGf5R4l3D/wHWXn0T0RXC4n7KJRCyJg54fmVW0vTOiP
 iKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699888877; x=1700493677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wYPq4PnrkT6VT7CGpVPJFK/tNxRA7Q2Z3pzO9BbyyC0=;
 b=KkQYcQTMEwQyiIci8bir2xZwSfZ8Ec/jDqgCRqalGFOOGg3NhQkeUapERDbE98LnAJ
 dxX0Tph7rgJPxmfAN311XJLqHaPXssWJMUjOyXbfDVTkvRQScs7++T32B+vup1k87Q9r
 8CqCCjo47l1db+jykreSpjo35org7zWZUPMuhI7grN5LDlICMP8Xx3hdTq+cd9qC3lvr
 Cia5v5BdgWqTJh92O0LPYfHjhsXz5RGnl9K8ebhc8jxF44HYJN3nh3iUXZcTx85PGP3f
 yLaLWlCrNsoZbbr2ZfritEjZvEmOth4MWrxwj+19fBJ9CoGiHGZK0zDbn+bxXpC5pIVX
 SImw==
X-Gm-Message-State: AOJu0YxWRTz2/NnJDcei4jYIwsDwuxzlBVePL4w7jQHNRT2olaU9vgHE
 4u7ZXM56zMJ4c2/MGWaZpa9/ig==
X-Google-Smtp-Source: AGHT+IF3A9n9kAcrQZnsw9wrjTnx3rsvapxiH3ZCQBhhtTiOatMf4sVc2qaWUo7af2ThaKbG2fzFSA==
X-Received: by 2002:a17:906:410e:b0:9bf:b022:dc7 with SMTP id
 j14-20020a170906410e00b009bfb0220dc7mr5409271ejk.48.1699888877542; 
 Mon, 13 Nov 2023 07:21:17 -0800 (PST)
Received: from m1x-phil.lan ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a1709062e8900b00985ed2f1584sm4168622eji.187.2023.11.13.07.21.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 07:21:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 00/10] hw/xen: Have most of Xen files become
 target-agnostic
Date: Mon, 13 Nov 2023 16:21:03 +0100
Message-ID: <20231113152114.47916-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

Hi,

After discussing with Alex Bennée I realized most Xen code
should be target-agnostic. David Woodhouse confirmed that
last week, so I had a quick look and here is the result.

More work is required to be able to instanciate Xen HW in
an heterogeneous machine, but this doesn't make sense yet
until we can run multiple accelerators concurrently.

Only build-tested.

Regards,

Phil.

Philippe Mathieu-Daudé (10):
  sysemu/xen: Forbid using Xen headers in user emulation
  hw/xen/xen_arch_hvm: Rename prototypes using 'xen_arch_' prefix
  hw/xen: Merge 'hw/xen/arch_hvm.h' in 'hw/xen/xen-hvm-common.h'
  hw/xen: Factor xen_arch_align_ioreq_data() out of handle_ioreq()
  hw/xen: Use target-agnostic qemu_target_page_bits()
  hw/xen: Reduce inclusion of 'cpu.h' to target-specific sources
  sysemu/xen-mapcache: Check Xen availability with
    CONFIG_XEN_IS_POSSIBLE
  system/physmem: Only include 'hw/xen/xen.h' when Xen is available
  hw/xen: Extract 'xen_igd.h' from 'xen_pt.h'
  hw/xen: Have most of Xen files become target-agnostic

 hw/xen/xen_pt.h                 | 14 --------------
 include/hw/arm/xen_arch_hvm.h   |  9 ---------
 include/hw/i386/xen_arch_hvm.h  | 11 -----------
 include/hw/xen/arch_hvm.h       |  5 -----
 include/hw/xen/xen-hvm-common.h |  8 +++++++-
 include/hw/xen/xen_igd.h        | 23 +++++++++++++++++++++++
 include/sysemu/xen-mapcache.h   |  3 ++-
 include/sysemu/xen.h            |  8 ++++----
 accel/xen/xen-all.c             |  1 +
 hw/arm/xen_arm.c                | 14 +++++++++++---
 hw/i386/pc_piix.c               |  1 +
 hw/i386/xen/xen-hvm.c           | 16 ++++++++++++----
 hw/xen/xen-hvm-common.c         | 16 +++++++---------
 hw/xen/xen_pt.c                 |  3 ++-
 hw/xen/xen_pt_config_init.c     |  3 ++-
 hw/xen/xen_pt_graphics.c        |  3 ++-
 hw/xen/xen_pt_stub.c            |  2 +-
 system/physmem.c                |  5 ++++-
 accel/xen/meson.build           |  2 +-
 hw/block/dataplane/meson.build  |  2 +-
 hw/xen/meson.build              | 13 ++++---------
 21 files changed, 85 insertions(+), 77 deletions(-)
 delete mode 100644 include/hw/arm/xen_arch_hvm.h
 delete mode 100644 include/hw/i386/xen_arch_hvm.h
 delete mode 100644 include/hw/xen/arch_hvm.h
 create mode 100644 include/hw/xen/xen_igd.h

-- 
2.41.0


