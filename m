Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAC67CCB4C
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:54:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspCy-00018b-7x; Tue, 17 Oct 2023 14:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspCv-00013t-0r
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:54:21 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspCt-0006yn-3M
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:54:20 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57bc2c2f13dso3439222eaf.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 11:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697568858; x=1698173658;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3BzVwr3UEcBbEt5b4hjQFKBfF0nJi4NqiILVepQC6QE=;
 b=xvSxzGpE3U3knEy3Yz9b+3JR9AcZCmnrBVcjA0PCQFsYCVKjkrqcnBftTxVPPYk36W
 o3Mr2s7hNnP401VUEAv0bOC1N+QFr2DphLagsL59OrkEFlcKay6EuEwo0nmgQEKres58
 NiHGTnrF9QogqkoldWhoTAxm6FqeoxzEr7l78lTzxFKJyf50ovcVj2R8+pm5tgWI9drL
 p2tI3g7KmL+9XhtHLYFnsQY0Ds2F7U8VLxG8v/Nc2Ue343qBURSYnTSv110/HvvQF78n
 JJmLkJ6fX7kl2tMkN0xCrREPma9dhSRLU1kgEnpBd1t/N1PCWmOSNQKdP06/6J0KY70m
 zt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697568858; x=1698173658;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3BzVwr3UEcBbEt5b4hjQFKBfF0nJi4NqiILVepQC6QE=;
 b=g2aVtlXt8mLv5KYLyREnM7B1L8orul+VZXEShdxEbLuLlFhPcGWj6X7d4B6J/21w6G
 F35wOto/JwKjdXrTcMRCqZU/oxY3TUn2sVIxKDjDPNzXYXjorWD96/w5VBkdTAoDm2ii
 /xNI6Eeiz9XIuEbb8cZ74zRRxZmeIkBdjAo/VY9z9PqPHLqBZ9EERjeCFh+Fxw+eU8G8
 beq9wdhYljoWSMaY6G18nT9B0WIBD+593YInco8ZiA68BF3OCDskfbH/YepidCiFBuAS
 SIceBCEeFdZAr/rrr8CXUGolto/q0EvdxjeYSqfdJu+kHQqz/rSSUwzPW+XC/52Q3uY+
 MZdQ==
X-Gm-Message-State: AOJu0Yzr6aC/Jkzg8vlethbls2QNtpaWIu/E1uT8yKuMthBe97WBdJr9
 xXB75fK07gkwzvVyF82p0QyONQ==
X-Google-Smtp-Source: AGHT+IHNIYiNw4C0SfYqIt6rjbSV+mn0Bf83Fm1hmuLWAkrIygWLNr4DWq/ODOenvZlrHB29wSuJaA==
X-Received: by 2002:a05:6359:5e02:b0:134:dc90:b7d1 with SMTP id
 pw2-20020a0563595e0200b00134dc90b7d1mr3302544rwb.25.1697568857679; 
 Tue, 17 Oct 2023 11:54:17 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 x25-20020aa79ad9000000b0068fe9c7b199sm1796952pfp.105.2023.10.17.11.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 11:54:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/5] gdbstub and TCG plugin improvements
Date: Wed, 18 Oct 2023 03:53:55 +0900
Message-ID: <20231017185406.13381-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2a.google.com
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

This series extracts fixes and refactorings that can be applied
independently from "[PATCH v9 00/23] plugins: Allow to read registers".

The patch "target/riscv: Move MISA limits to class" was replaced with
patch "target/riscv: Move misa_mxl_max to class" since I found instances
may have different misa_ext_mask.

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
  gdbstub: Check if gdb_regs is NULL
  target/riscv: Remove misa_mxl validation
  target/riscv: Move misa_mxl_max to class
  target/riscv: Validate misa_mxl_max only once
  plugins: Remove an extra parameter

 target/riscv/cpu-qom.h     |   1 +
 target/riscv/cpu.h         |   3 +-
 accel/tcg/plugin-gen.c     |   9 +--
 gdbstub/gdbstub.c          |  34 +++++----
 hw/riscv/boot.c            |   2 +-
 target/riscv/cpu.c         | 139 ++++++++++++++++++++++---------------
 target/riscv/gdbstub.c     |  12 ++--
 target/riscv/kvm/kvm-cpu.c |  10 +--
 target/riscv/machine.c     |   7 +-
 target/riscv/tcg/tcg-cpu.c |  42 ++---------
 target/riscv/translate.c   |   3 +-
 11 files changed, 131 insertions(+), 131 deletions(-)

-- 
2.42.0


