Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7214786173
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOh-0000Fo-5n; Wed, 23 Aug 2023 16:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOV-0008Kx-49
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:59 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOK-0005Tq-RT
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:52 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bf1935f6c2so1715225ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822215; x=1693427015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rL9dYhZlLtnzzFut315rTSxIOrY7aBzaEd71D0pOj5E=;
 b=s9LgB6hdO/95/Y8hh2Wi8YjyzTVBiVUZP8VxBD1m9S3a46P/SpTc+wKloSr1qcaH5I
 P7kHrFmpH7CiwU2F4kxhugmQhBHerwgdf9rljgUkGVabeNJ9NIdpi0o/eO4Nbvbbtyf6
 v/t7PuwS0fr6rgzBmzlVKS8OJfoJmi8Y4qTGjKKTeSqsxDSL9O4s0o15aBF4iMggoS2b
 5OBr8wx6F++fD3OYRwR9pD8QrbugdQqhIhNObWJrOv2IYBjKy4/5ifZ8ImoO6fh8uZTt
 eR65Rrqr+mLL7WUn5S1pvDSvk+ZGzCK+G/XcuWtzUZPhIgR/VIsHUol2XRvNSGbo4NDR
 5g1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822215; x=1693427015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rL9dYhZlLtnzzFut315rTSxIOrY7aBzaEd71D0pOj5E=;
 b=BU54zWL+Bal8TqLubYXwfvWjHJLcxHaTN8gXo5n3WkdDK5A+59qWGBoyIHOqCDQ7Rt
 ZGIjvmkDVZ2tRh1f57dz5znU6D2NftLg/lJKt7s52UiPRmOSnqbITp9qOZsDfZs+65jL
 aq2bm4I2OwHLRNv6EvsoSGxfqGpV4KQviel1tnAz0GAC5c8qBpflue8cti96OBNROcU6
 neICnwChccNPM1wLxgXjGOcT9I4+aWRc+UkOS0mSo2+UepPJHu5IPnB9QNoAD+8t01pY
 w1a9auAUdP1itwlQ/FtpavXcZHVpK+QGKgWF4XX1rom2NIpfqda+Se49bFZMmOF9JpH9
 rLiQ==
X-Gm-Message-State: AOJu0YzZ2hfGQ7pUHSc5J2A9td2mTeY7Oc3RKQCJKqPhfZbrXGc3x1x/
 ES+S6TSMJ4/hWtSQ20cM67X1S2bqhPpcWXMx1Wg=
X-Google-Smtp-Source: AGHT+IFos+Ca1cKMqycQKVmtkHIqgC9uGm75NUqb6pXYdCKF3qHhEN5bE8x2890ZQc4yT7gMXKgrdg==
X-Received: by 2002:a17:902:db0f:b0:1bd:d510:78fb with SMTP id
 m15-20020a170902db0f00b001bdd51078fbmr20662892plx.3.1692822214837; 
 Wed, 23 Aug 2023 13:23:34 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 07/48] include/exec: Widen tlb_hit/tlb_hit_page()
Date: Wed, 23 Aug 2023 13:22:45 -0700
Message-Id: <20230823202326.1353645-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Anton Johansson via <qemu-devel@nongnu.org>

tlb_addr is changed from target_ulong to uint64_t to match the type of
a CPUTLBEntry value, and the addressed is changed to vaddr.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230807155706.9580-8-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 94f44f1f59..c2c62160c6 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -397,7 +397,7 @@ QEMU_BUILD_BUG_ON(TLB_FLAGS_MASK & TLB_SLOW_FLAGS_MASK);
  * @addr: virtual address to test (must be page aligned)
  * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
  */
-static inline bool tlb_hit_page(target_ulong tlb_addr, target_ulong addr)
+static inline bool tlb_hit_page(uint64_t tlb_addr, vaddr addr)
 {
     return addr == (tlb_addr & (TARGET_PAGE_MASK | TLB_INVALID_MASK));
 }
@@ -408,7 +408,7 @@ static inline bool tlb_hit_page(target_ulong tlb_addr, target_ulong addr)
  * @addr: virtual address to test (need not be page aligned)
  * @tlb_addr: TLB entry address (a CPUTLBEntry addr_read/write/code value)
  */
-static inline bool tlb_hit(target_ulong tlb_addr, target_ulong addr)
+static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
 {
     return tlb_hit_page(tlb_addr, addr & TARGET_PAGE_MASK);
 }
-- 
2.34.1


