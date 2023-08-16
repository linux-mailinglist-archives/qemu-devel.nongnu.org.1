Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5B277E878
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:16:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWL2d-0002Kn-2n; Wed, 16 Aug 2023 14:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWL2Z-0002KE-4p
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:14:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWL2X-0003g4-18
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:14:42 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bdf98a6086so17377055ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209679; x=1692814479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v0SVMZiZZQzHyN2ohKnpzim2pRbcuuTNesX6/I+PcLs=;
 b=XUI7UClqMQaLMbsaZueaIfu9rMjihLuNP2sSIvesEBkjmgxY5rDsf02Pp9P5L5ok2/
 IVem2RvWCHpwzAUF/hTRoU3JNOyx/PRablzwcLBen3Qn6uqNF1gDa0mFt4PQ+uQKTgCZ
 uqyadTf6mq4row5P+WAdg+20tmd1cmb90yvFdxYqPsXPiPZ8a2ztboHcHvCObmSRfL6M
 7CwVmoars1qIrrXNdvouTbXd19c9MJ1c00GYvfyrTX6TkWUy3joMbR1fpqqxDQunSBD7
 fIdcSs32yVPwzsXqjN1wbRcnZfnYRM2VrycRuwR/4WvCeHpodDGVNKmjgrMssa/y6Q4p
 7Q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209679; x=1692814479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v0SVMZiZZQzHyN2ohKnpzim2pRbcuuTNesX6/I+PcLs=;
 b=ReApA44+c9ytNw2lOEfLtHhRyR9cNTtt68fQgeG8Kw/aLGYgqGI3at83ZH9e+fFpJw
 wbS2yd5AQgQfdd4KH+Wzml7t+p9fe2uTAcYx/8kNBG2K8eOqyYJ7Elc5Y5dZoWA/e8jh
 mh+6cAZ6otk1R/WaiogoI30dRlWekXO+5IY1UBOl3ziZYbLwEJf1B7vaGijnFlx0xQ3F
 cHkqji4XWjA7bmXdsHCNwNa6mwPwIXxuPIpWZ4FX1t34nYlf+y3Rkf+PYxjwcRZaYS+w
 lduwtwK3+OkRYFHA3CVNigF8K0hKEtx7fJwq5v456zQFpBkkGVGjkuPI/BuyaYao4ZtY
 YoJA==
X-Gm-Message-State: AOJu0YwJODUKhgkp7yp0r+Efovy/FuG0a6fQxrO2YJ5yU/TcUyTxwSl9
 jUTWbYe9rkx8crs6QuU9uLQWQ7AutGARs13Dmw4=
X-Google-Smtp-Source: AGHT+IE7J8E2yza9V3kVGE954Yi86ocyRkS3N/lJT+a/t7GnFAIA1fyR9XYjukxm7+YSBJG1q+AWrA==
X-Received: by 2002:a17:902:b788:b0:1b8:76ce:9d91 with SMTP id
 e8-20020a170902b78800b001b876ce9d91mr2830511pls.1.1692209679336; 
 Wed, 16 Aug 2023 11:14:39 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001b9dab0397bsm13423563plo.29.2023.08.16.11.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:14:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	deller@gmx.de
Subject: [PATCH 0/6] linux-user: Rewrite open_self_maps
Date: Wed, 16 Aug 2023 11:14:31 -0700
Message-Id: <20230816181437.572997-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Based-on: 20230816180338.572576-1-richard.henderson@linaro.org
("[PATCH v4 00/18] linux-user: Implement VDSOs")

As promised, a rewrite of /proc/self/{maps,smaps} emulation
using interval trees.

Incorporate Helge's change to mark [heap], and also mark [vdso].


r~


Richard Henderson (6):
  util/selfmap: Use dev_t and ino_t in MapInfo
  linux-user: Use walk_memory_regions for open_self_maps
  linux-user: Adjust brk for load_bias
  linux-user: Show heap address in /proc/pid/maps
  linux-user: Remove ELF_START_MMAP and image_info.start_mmap
  linux-user: Show vdso address in /proc/pid/maps

 include/qemu/selfmap.h |   4 +-
 linux-user/qemu.h      |   2 +-
 linux-user/elfload.c   |  41 +--------
 linux-user/syscall.c   | 194 +++++++++++++++++++++++++----------------
 util/selfmap.c         |  12 +--
 5 files changed, 131 insertions(+), 122 deletions(-)

-- 
2.34.1


