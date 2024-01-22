Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A7A836DBE
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:38:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRyEx-0000Kw-2Z; Mon, 22 Jan 2024 12:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRyEu-0000JG-JZ
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:37:40 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRyEs-00042n-OM
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:37:40 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d6b4e2945so41503135e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705945056; x=1706549856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6HSg0+1JZFIe/mANiKGpgt4LhNH0E2x8I+vuZEEVJHQ=;
 b=V0vWHlG1LDpzs+pkp3FHunZJrbQPzteSkBWXLgLYqTGlBjHBxfYvTklTAmdFVNShud
 Z39DCqgJLW05qDhO+qXRUsW8lqeighU1xdCO2t6pQe7Gmr+4bUO+bvLKi27je7tyEXtp
 VvomyWSjDWK02RansjjzQn/f9SQ8fIgSc2RAKQjDD9Jk4sq8bJJh4LHJQvFrDPnUzGjQ
 vb4x20AZTxFyfCc50CEXBfUo0iQT3IUhwFGlcNLK9qj2RsparlWPDIRY8xqAxFDq/POo
 wGs7qZZNyMZVAUeyXuu15MT+6WDuKXx5xjCYxzJ4/arnfzpnV6G5usZ+pa5O6xiu05r7
 0lWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705945056; x=1706549856;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6HSg0+1JZFIe/mANiKGpgt4LhNH0E2x8I+vuZEEVJHQ=;
 b=BYZVo1HZaSkP2CGgezFWVYmV3lLaJ68g/sOEOQ5gH8R0KY8dT3anDigAIkdt2OlZNH
 4jBtlgyp7lHi8dKjSQ5TsMwPuWBxN4Zh5KcQMv/rIny84RUHBe0F4jhcFQlDgacXaQLO
 fbsgqm8DOzBYdUAHRlQaqOwR7GEaevEHU1Qtss/mGb8YHFGCN072cSSPwFdxxd3bwcGw
 OwGYYRbrxKc8yDmArh3AF53rs6knpMJbcH5c9yOVY1luHc4VP5FGfy5UVFVLq/gi6JXc
 78Oe6tUZb3IFFNMTXlbiqtkBh8EACGgm3Y29Zx2HR7j+15r2pi8Shz3kFWNc3+Y8RIxg
 l2mg==
X-Gm-Message-State: AOJu0Yw8kzxn6Y47lMbR7470q40VXBbpIeBCfcNS7Unp5EPO7uTa3BQa
 Fa5sVjtMYgp6TXmmEAZqq1QNWa4ySXsBA5omiqFZSAr2oVwPxsvfMPSwuXItnI4WlP74s3ycG+z
 6
X-Google-Smtp-Source: AGHT+IGdYYmztObwaEBcQ2bmQ0HbrY6c8BlQLYg3q2KBUegAMXnvtsoQKmhlYpUXYeiYAsaA3QjbvQ==
X-Received: by 2002:a7b:cb8d:0:b0:40d:5d07:55d3 with SMTP id
 m13-20020a7bcb8d000000b0040d5d0755d3mr1840311wmi.177.1705945056539; 
 Mon, 22 Jan 2024 09:37:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 bi13-20020a05600c3d8d00b0040e8800fcf3sm19780908wmb.5.2024.01.22.09.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 09:37:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ira Weiny <ira.weiny@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH] bswap.h: Fix const_le64() macro
Date: Mon, 22 Jan 2024 17:37:35 +0000
Message-Id: <20240122173735.472951-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

The const_le64() macro introduced in commit 845d80a8c7b187 turns out
to have a bug which means that on big-endian systems the compiler
complains if the argument isn't already a 64-bit type. This hasn't
caused a problem yet, because there are no in-tree uses, but it
means it's not possible for anybody to add one without it failing CI.

This example is from an attempted use of it with the argument '0',
from the s390 CI runner's gcc:

../block/blklogwrites.c: In function ‘blk_log_writes_co_do_log’:
../include/qemu/bswap.h:148:36: error: left shift count >= width of
type [-Werror=shift-count-overflow]
148 | ((((_x) & 0x00000000000000ffU) << 56) | \
| ^~
../block/blklogwrites.c:409:27: note: in expansion of macro ‘const_le64’
409 | .nr_entries = const_le64(0),
| ^~~~~~~~~~
../include/qemu/bswap.h:149:36: error: left shift count >= width of
type [-Werror=shift-count-overflow]
149 | (((_x) & 0x000000000000ff00U) << 40) | \
| ^~
../block/blklogwrites.c:409:27: note: in expansion of macro ‘const_le64’
409 | .nr_entries = const_le64(0),
| ^~~~~~~~~~
cc1: all warnings being treated as errors

Fix this by making all the constants in the macro have the ULL
suffix.  This will cause them all to be 64-bit integers, which means
the result of the logical & will also be an unsigned 64-bit type,
even if the input to the macro is a smaller type, and so the shifts
will be in range.

Fixes: 845d80a8c7b187 ("qemu/bswap: Add const_le64()")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Tested 'by hand' on the s390 box that was complaining about
Kevin's pullreq.
---
 include/qemu/bswap.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index 933a66ee87e..bd67468e5e4 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -145,14 +145,14 @@ CPU_CONVERT(le, 64, uint64_t)
  */
 #if HOST_BIG_ENDIAN
 # define const_le64(_x)                          \
-    ((((_x) & 0x00000000000000ffU) << 56) |      \
-     (((_x) & 0x000000000000ff00U) << 40) |      \
-     (((_x) & 0x0000000000ff0000U) << 24) |      \
-     (((_x) & 0x00000000ff000000U) <<  8) |      \
-     (((_x) & 0x000000ff00000000U) >>  8) |      \
-     (((_x) & 0x0000ff0000000000U) >> 24) |      \
-     (((_x) & 0x00ff000000000000U) >> 40) |      \
-     (((_x) & 0xff00000000000000U) >> 56))
+    ((((_x) & 0x00000000000000ffULL) << 56) |    \
+     (((_x) & 0x000000000000ff00ULL) << 40) |    \
+     (((_x) & 0x0000000000ff0000ULL) << 24) |    \
+     (((_x) & 0x00000000ff000000ULL) <<  8) |    \
+     (((_x) & 0x000000ff00000000ULL) >>  8) |    \
+     (((_x) & 0x0000ff0000000000ULL) >> 24) |    \
+     (((_x) & 0x00ff000000000000ULL) >> 40) |    \
+     (((_x) & 0xff00000000000000ULL) >> 56))
 # define const_le32(_x)                          \
     ((((_x) & 0x000000ffU) << 24) |              \
      (((_x) & 0x0000ff00U) <<  8) |              \
-- 
2.34.1


