Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA6F7B6974
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:52:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnesJ-0007ek-Be; Tue, 03 Oct 2023 08:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qnesG-0007dB-Ql
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:51:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1qnes9-000491-U4
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:51:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-406618d0991so8448715e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696337491; x=1696942291;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GvyQiCIBd0KJPsZf47fDj2Cg3EaKAeHwpM+pW5lcdp8=;
 b=CQ1Rl5GbaH0Oy8x/R0I4d5uMnbKVPUOusF1aM0CcyrdK4NNtQnQRRVFD/3stupZ750
 5KDxazcOsLZNQnoc6cJRpvpLt9p8ADm57lHnhX0HBjuK55EIJLXB4lmG6F7+iZ5vvZbI
 tsgASPYtrs0c8OOmLlkcnucY49TG2psdnu4PdFeenEmPrsWc8ggBd6N50Tp1AgZ8/TLI
 38c/wBoaLZo6o4D2EmnnX5yaxZQPpLcIj/Nri79WfzWAb0n1PbNovi/DoTYvlQbyAlbj
 QnwOi08pbQH2OMdcj9s4C8d+MBcKL+8W6RDIAOuPM6thikF1kQspMOYDRVURgkBDpWxy
 X5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696337491; x=1696942291;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GvyQiCIBd0KJPsZf47fDj2Cg3EaKAeHwpM+pW5lcdp8=;
 b=RR1KPcojtt6z1ZV4wAGi1TekX8UA+5Pmm7L3Y4S9GBoj1xH7/y/bCwucVd1NjjOWv5
 dvhVFzSkmVgumM4HhhvJTvBIqrV0qmQfbe2IKjsj53vi7IGHl9uUwXLnHXQkKpgrhufE
 Rk5INjAjPhkvS8eSRDzC1mOEaOjUvnaiIZt44f+6AiwRUS/cEXgSItw9+vSAHUGty39j
 fgWVv5Z+32lbE9bSH5zjyTfos8J0NjgDdNSevFhdVSk22TtC6IMQCxDUcAidUhoQPbBp
 Lov35yWl6qNkK2aksAk8BLQYezpzc8qiHxieHKr5Kj4sQmQeYCGmYC/fYe+iTm0X9c+m
 SkiQ==
X-Gm-Message-State: AOJu0YyLrViA4liXBwtMPiZ7nLeJLEhgC8Ye3i5GR1CpF+LoYFW0wAG8
 d5uCBzqCr/JUrou9QgQjGkWThBSE04NvRsWXbMI+20LL
X-Google-Smtp-Source: AGHT+IFcteaJ7+xvfSelbR4Fk9sHoinOu6xdYju/HxO045bcon/F7fgO066sKqMV+Ywsd1aSKZVPlQ==
X-Received: by 2002:adf:f4c4:0:b0:322:6201:6049 with SMTP id
 h4-20020adff4c4000000b0032262016049mr10676540wrp.39.1696337491436; 
 Tue, 03 Oct 2023 05:51:31 -0700 (PDT)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 l21-20020a7bc455000000b0040531f5c51asm1240335wmi.5.2023.10.03.05.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 05:51:31 -0700 (PDT)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH 0/3] Support discontinuous PMU counters
Date: Tue,  3 Oct 2023 13:49:34 +0100
Message-ID: <20231003125107.34859-1-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Currently the available PMU counters start at HPM3 and run through to
the number specified by the "pmu-num" property. There is no
requirement in the specification that the available counters be
continously numbered. This series add suppport for specifying a
discountinuous range of counters though a "pmu-mask" property.

Rob Bradford (3):
  target/riscv: Propagate error from PMU setup
  target/riscv: Support discontinuous PMU counters
  target/riscv: Don't assume PMU counters are continuous

 target/riscv/cpu.c     |  9 ++++++++-
 target/riscv/cpu_cfg.h |  1 +
 target/riscv/csr.c     |  5 +++--
 target/riscv/pmu.c     | 32 +++++++++++++++++++++-----------
 target/riscv/pmu.h     |  3 ++-
 5 files changed, 35 insertions(+), 15 deletions(-)

-- 
2.41.0


