Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 508CD7737DC
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:21:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTEDy-00008Q-2E; Tue, 08 Aug 2023 00:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDv-0008NU-Nh; Tue, 08 Aug 2023 00:21:35 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDu-0007ql-4f; Tue, 08 Aug 2023 00:21:35 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a78604f47fso2644033b6e.1; 
 Mon, 07 Aug 2023 21:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468492; x=1692073292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oe5890oGRPS+euqSPniLxD+ePYVnJf70zsSY1/DG20s=;
 b=QCC2P45G5UjYHNJRNRlIn+jC6BjgA4mImpAqVsmg8LWSMpniLJXhP7PCqS71wDNJpd
 usUxZu5z1Ftd/gD23tcURNaA7hOLweXMiClRysslmiyYxv/MurrFoCC8Cbo93VMLhos1
 H5i07+R4v7IMvnijyxIvbsyFaiSQjeLjJqRNvC2a6uyLusFvOqtqLhPZ3B6rg/hM/AGL
 R7FNyZettE4x6RXISvNolx7pyIth5rYH8gTy5cp6jIPxwjewx0E68905ir0AOmlnNA/4
 3OvJfJ+BlRGgj+vDXacoaeWNwQOopd01Rbq1ExDHGLkX8rtgx1yqxUjoySdiCOOboJlG
 9FVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468492; x=1692073292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oe5890oGRPS+euqSPniLxD+ePYVnJf70zsSY1/DG20s=;
 b=cDAYhciPzCg+vMbkRHIBNslWgjbdE47xoIhZRENKRPvJXVDPGBqXJx1FvvaN/6zHSE
 Z+YFpQBL8lzvP1PM0s0i5N1ksxJ91nZSTV9fd7TDO3zZ42zMJfrL090hGZDAyL0V5ciB
 GeOimUf8gf8rdZksAER+L0fiJPyJ4i+JU/yvPjfENq3JWVBl46zvx5BpdWAmSIOjkKKT
 N9Me/etcC5zGb02eVhtVpjAsw/1TM8yT3GY266LxdbVOVe3QGpcH2Nf1FdDxYwAaWHls
 +qfwM5zeSR1l/7fRhDz3kf/0cQUB15EcbWhP6DuF7pRet7+KVk2D0uTfHiSb3WpJ1fPO
 S1ag==
X-Gm-Message-State: AOJu0YwbiUzdFwlBK54eBztKzVwoLBjaNRsEaxKWZ5NA9J/a6V6ntQFn
 xDicnjOE0THVV7KTHyXxzds=
X-Google-Smtp-Source: AGHT+IGRuRSBOIC8T4NG6fHADVNd9ju2J3yHn74cjjZkrAuNfFuccRlvQ/fQEnniXi3uWyEq6YWl7w==
X-Received: by 2002:a05:6808:2218:b0:3a7:a00b:f725 with SMTP id
 bd24-20020a056808221800b003a7a00bf725mr5714279oib.47.1691468492433; 
 Mon, 07 Aug 2023 21:21:32 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.21.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:21:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH v2 17/19] tests/avocado: boot ppc64 pseries replay-record test
 to Linux VFS mount
Date: Tue,  8 Aug 2023 14:19:59 +1000
Message-Id: <20230808042001.411094-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This the ppc64 record-replay test is able to replay the full kernel boot
so try enabling it.

Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/replay_kernel.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
index 79c607b0e7..a18610542e 100644
--- a/tests/avocado/replay_kernel.py
+++ b/tests/avocado/replay_kernel.py
@@ -255,8 +255,7 @@ def test_ppc64_pseries(self):
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
-        # icount is not good enough for PPC64 for complete boot yet
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        console_pattern = 'VFS: Cannot open root device'
         self.run_rr(kernel_path, kernel_command_line, console_pattern)
 
     def test_ppc64_powernv(self):
-- 
2.40.1


