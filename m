Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0797B5555
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnK4g-0003ok-R9; Mon, 02 Oct 2023 10:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnK4b-0003oX-T1
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:39:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnK4a-0000Tj-EO
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:39:01 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40566f8a093so135515805e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696257538; x=1696862338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jn5ZxORjhgJn12vfYi9R5rCee4N7YBuTkdlgmnHzriE=;
 b=LxOySX4PTOrXFcFdDK+PNEEvSH5KguXmQ82Mr7SmeUrLmhs5H5dLouAeYFuIv4xWvI
 tJOJUyLTWYii2uUBLITprE1a0PM6hNTJjkSSAAN+3wYe0HRsFBQlqQE45zXIfuv06f7M
 6no4Ii0NmulJ9Ct/ca3E9XIh+It7ya10wzr7zHwQB/22Q0ecRUa6EWxVXFEscCffonYg
 9339EWdiG2HE35KDxWMI2xUFbdIysi0A2hh/6IfYW4fak0ph5m6VVHBpLCzNbu37l27b
 BqbdHL3OxXsNt8bcDJn7fsw03AAkhpgnEyQW2jfXtSJwek7XNuz4IOMOoWzjJarrqYVn
 UpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696257538; x=1696862338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jn5ZxORjhgJn12vfYi9R5rCee4N7YBuTkdlgmnHzriE=;
 b=hQZ8v/cacmMpKtE2fyruVdkJQVAgBz5NYgWV7cckxPMy2/b4PM2WZeNdorp4KTJp1A
 6nMjPA1XYoqnvpmp5jKB02y4yg9enuEN/cKuPC2nm/xDFW24BMsffRo2knru0rMwOnkw
 3OiP4PVIz2ludX0RP14KeII2hAcMHjel/9HBNcfLrMPDAQBsrNyLpUaXRleRixBhUXDB
 v75rhg4WOvASgZqDf3rkaw4GY8pX6WSYpA3y2eGT40/01Fhw8d7qPtQqEFbPenZTuqdu
 9nsIwHj1AZDd7QXWyFeoPTlX2k7t692XZ5fG4f9Df7cbGYwVpe5sMY01lhl8m5x8oW8A
 +gGg==
X-Gm-Message-State: AOJu0YwqX/IWKJYZj4+3/f8fb6Cs6VwY61k/gdyezY4sb9EeoffuK1VM
 BMzu9EbWXnYzxwtebgqJr+SZ69DLRe5g6Fikm2N4EA==
X-Google-Smtp-Source: AGHT+IFMhic14BOSKFu2n5QPCbB/haS3EbfRgNKH9pt4esGSddBih6ABYdHio591VXi+yhEfr9E/rg==
X-Received: by 2002:a05:6000:1188:b0:31f:fed4:d79d with SMTP id
 g8-20020a056000118800b0031ffed4d79dmr10512037wrx.30.1696257538296; 
 Mon, 02 Oct 2023 07:38:58 -0700 (PDT)
Received: from m1x-phil.lan (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 k9-20020a7bc409000000b00402f713c56esm7436244wmi.2.2023.10.02.07.38.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Oct 2023 07:38:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] hw/ppc/spapr: Rename SoftMMU -> TCG
Date: Mon,  2 Oct 2023 16:38:50 +0200
Message-ID: <20231002143855.50978-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

We want to clarify when code depends on a software
MMU, or when it depends on TCG system emulation.

This series renames the 'softmmu' mentions in PPC.

Philippe Mathieu-Daudé (4):
  hw/ppc/spapr: Add missing license
  hw/ppc/spapr_hcall: Allow elision of softmmu_resize_hpt_prepare/commit
  hw/ppc/spapr_hcall: Rename {softmmu ->
    tcgppc}_resize_hpt_prepare/commit
  hw/ppc/spapr: Rename 'softmmu' -> 'tcg'

 include/hw/ppc/spapr.h                  |  8 ++++----
 hw/ppc/spapr_hcall.c                    | 12 ++++++++----
 hw/ppc/{spapr_softmmu.c => spapr_tcg.c} |  9 +++++++++
 target/ppc/tcg-stub.c                   | 15 ---------------
 hw/ppc/meson.build                      |  2 +-
 5 files changed, 22 insertions(+), 24 deletions(-)
 rename hw/ppc/{spapr_softmmu.c => spapr_tcg.c} (98%)

-- 
2.41.0


