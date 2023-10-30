Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DD17DB2F2
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:50:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxL9D-0002au-5B; Mon, 30 Oct 2023 01:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxL8u-0002aW-Ja
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:48:52 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxL8s-0006vx-N2
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:48:52 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6c0f14d6875so583455b3a.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698644928; x=1699249728;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FBLCc1qs29WRSXkNAGAm/cbNeZPmZuDArO6qx2K6e2w=;
 b=3UdnRWw9Cx37qvAce7r4X0jtv0Ht5b+R9tkSJ7+i9gyjJY5Toln61SmaT4a9SpDNtg
 zz0oAcfNEOXLVMm0ftaTEnVshCUbd5WkivTE70KW0oXLkj+yEv+D8JzGBoyKhIMexUtC
 0kAto98PdOi8JQClpXdyqw8SkI64rbQ8tcxZAQ6OuoLLNqfXGCCUqrXyUCAUqfNH8v0E
 OSe6CMSMoR7Al5+F+HiciNRRyfGv3tSeNgk1VaM/oLjx+SUG2y2S9lE1U3XXqbD1yTkv
 OsqGWYRzYK2fudDxjJ4/RZuYcIhuJG9H5ZkXI/67gg2w6qyV3Mph19SemchMCjpqyqtq
 OO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698644928; x=1699249728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FBLCc1qs29WRSXkNAGAm/cbNeZPmZuDArO6qx2K6e2w=;
 b=pJ0LOQfakmhbAROhPQrG3d0xuKwxx9SvWA+rYrS6Z5n/DbaFhluPVjNP9Zw0IBZnxw
 qU9OGaA5/jg64dEC9qnW94EFBwvUGDNnk40gbXPhmpy5Uyl9OgqYxBc+4uec5TklXGDs
 pojUx305hrnpip7vKiCQ28WVFQeyH/CnrqFIfdojDhQxotwLVj+8kBbxUY6rLlzFerxc
 2Syoc6kMGbwTUG9BBEsTWCPHdLl/lvf2vHK7ymc7jnUx6QME1TFRsKlam1w/51hqO32X
 PBikGDuRqIWd0yFFsRcd1ORL0a6ttk2Rm4DWF8SFZWE3vAcgfzQcFJtQhTJrvDLfEOQd
 KkTw==
X-Gm-Message-State: AOJu0YxQ/Nf2YimjufBK88QhnRLO0rSNN7EA5v4VdG4nTddOavapIxKt
 iELYoIxFGAA7wnBsU4dKjJoSAA1BU5YvsfV9xLfffw==
X-Google-Smtp-Source: AGHT+IFml398YqfKt/fzaGWs1plaN+nJO/59WvN+DCJsyhvtFrU8P758fwBrybVImXcxcNv0p1FeAg==
X-Received: by 2002:a05:6a00:2356:b0:6bd:ca1d:c51e with SMTP id
 j22-20020a056a00235600b006bdca1dc51emr8928790pfj.16.1698644927992; 
 Sun, 29 Oct 2023 22:48:47 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 y20-20020a056a00191400b006b4a5569694sm5083509pfi.83.2023.10.29.22.48.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:48:47 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 0/5] gdbstub and TCG plugin improvements
Date: Mon, 30 Oct 2023 14:46:34 +0900
Message-ID: <20231030054834.39145-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Based-on: <20231029145033.592566-1-alex.bennee@linaro.org>
("[PATCH v2 00/19] Maintainer updates for testing, gdb, semihosting and
plugins (pre-PR)")

This series extracts fixes and refactorings that can be applied
independently from "[PATCH v9 00/23] plugins: Allow to read registers".

The patch "target/riscv: Move MISA limits to class" was replaced with
patch "target/riscv: Move misa_mxl_max to class" since I found instances
may have different misa_ext_mask.

V5 -> V6:
  Added patch "default-configs: Add TARGET_XML_FILES definition".
  Rebased.

V4 -> V5:
  Added patch "hw/riscv: Use misa_mxl instead of misa_mxl_max".

V3 -> V4:
  Added patch "gdbstub: Check if gdb_regs is NULL".

V2 -> V3:
  Restored patch sets from the previous version.
  Rebased to commit 800485762e6564e04e2ab315132d477069562d91.

V1 -> V2:
  Added patch "target/riscv: Do not allow MXL_RV32 for TARGET_RISCV64".
  Added patch "target/riscv: Initialize gdb_core_xml_file only once".
  Dropped patch "target/riscv: Remove misa_mxl validation".
  Dropped patch "target/riscv: Move misa_mxl_max to class".
  Dropped patch "target/riscv: Validate misa_mxl_max only once".

Akihiko Odaki (5):
  hw/riscv: Use misa_mxl instead of misa_mxl_max
  target/riscv: Remove misa_mxl validation
  target/riscv: Move misa_mxl_max to class
  target/riscv: Validate misa_mxl_max only once
  default-configs: Add TARGET_XML_FILES definition

 configs/targets/loongarch64-linux-user.mak |   1 +
 target/riscv/cpu-qom.h                     |   1 +
 target/riscv/cpu.h                         |   3 +-
 hw/riscv/boot.c                            |   2 +-
 target/riscv/cpu.c                         | 139 ++++++++++++---------
 target/riscv/gdbstub.c                     |  12 +-
 target/riscv/kvm/kvm-cpu.c                 |  10 +-
 target/riscv/machine.c                     |   7 +-
 target/riscv/tcg/tcg-cpu.c                 |  42 +------
 target/riscv/translate.c                   |   3 +-
 10 files changed, 109 insertions(+), 111 deletions(-)

-- 
2.42.0


