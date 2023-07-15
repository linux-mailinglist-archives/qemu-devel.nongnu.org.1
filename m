Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 142CD75490A
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:58:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfjm-0006WQ-6h; Sat, 15 Jul 2023 09:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiR-000466-4Y
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:47 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiP-0001Is-LZ
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:42 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso2971675f8f.0
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429220; x=1692021220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=viFchcHGsP+nKMHrpwcA4jNmykwjrSvjDrmv/nDVIvw=;
 b=pnld6Wn9wt7S295hr6wOEUse81Ubsg6JhK81XigM8Ow7P/8V3lj46tf0gVRZZwlBle
 dvpp8c9bZBagQspOOc+jTqzII+CiVY7L4SI/qWq0+Md6ROon/6B1np7zXF9yAbcJEVg0
 gCiEGEZpdKddUyy2gMYeHKIxlVC84gy73CcJZ2Pye01k2SfsTAa2UAkTIBHVdLP+STP8
 7Fpv7Xz7t00IyJWpsLzHO69iLmP14aiDpFN5fdKDT5oImTfE49a0m+CEdV0C717vwvMA
 O3I+Qr/l5BOhLIKp+eaI1bviY6woyegSbxcuWfB04t4umgq5a23pGXYko+mixy7sL/29
 uNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429220; x=1692021220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=viFchcHGsP+nKMHrpwcA4jNmykwjrSvjDrmv/nDVIvw=;
 b=B/kboN6ISWH3OpC+HMa8/9UnelDTYZLEXWwk5RRtuZco2UnxRmAkLjBumKkc0gdJL8
 szvdTcyFdq8+c3GSTnrJmnMJM0IH8rwZUFPYySnF/c6NMNILukn27+oE+P756uTqdLde
 M/3LOy+siIqCnMHiuMuXZ5prrTs4yiZkaXmaGBP9Av5BaXHYPKJNYtWzvSiVA6XOZJr3
 8a/1gNccIqXKSd+ZkmB/QLiIZASmajSA7pjWtN9Ys+bRQfTV/5vdzICghIYJWkOXupID
 gaBkMUjBJaOfp8pMMCUSAL3/HRl0EVGuJYcYK2ka/Bry0gSDvamnOvuykaz3rZTT3pb+
 WWsw==
X-Gm-Message-State: ABy/qLbgqsqoyLSmYUmGAs7/m6OuGIsAK8NuFud+cIgrX0viS6St6E9+
 awuwMgi4eWx5ABzBDRDNodocJrGU2W528Y1OojTYhQ==
X-Google-Smtp-Source: APBJJlEtlD66+UJnk1/e99zleawxN6EJ1OnDFoaA/HmgIR5aX/TxXo3XdC8Mi3+YPttOGCWggnUJIA==
X-Received: by 2002:adf:d84e:0:b0:313:f6bb:ec2b with SMTP id
 k14-20020adfd84e000000b00313f6bbec2bmr5756555wrl.47.1689429220394; 
 Sat, 15 Jul 2023 06:53:40 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 26/47] accel/tcg: Introduce page_check_range_empty
Date: Sat, 15 Jul 2023 14:52:56 +0100
Message-Id: <20230715135317.7219-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

Examine the interval tree to validate that a region
has no existing mappings.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230707204054.8792-10-richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 12 ++++++++++++
 accel/tcg/user-exec.c  |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 472fe9ad9c..94f828b109 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -224,6 +224,18 @@ void page_set_flags(target_ulong start, target_ulong last, int flags);
 void page_reset_target_data(target_ulong start, target_ulong last);
 int page_check_range(target_ulong start, target_ulong len, int flags);
 
+/**
+ * page_check_range_empty:
+ * @start: first byte of range
+ * @last: last byte of range
+ * Context: holding mmap lock
+ *
+ * Return true if the entire range [@start, @last] is unmapped.
+ * The memory lock must be held so that the caller will can ensure
+ * the result stays true until a new mapping can be installed.
+ */
+bool page_check_range_empty(target_ulong start, target_ulong last);
+
 /**
  * page_get_target_data(address)
  * @address: guest virtual address
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index d95b875a6a..ab684a3ea2 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -598,6 +598,13 @@ int page_check_range(target_ulong start, target_ulong len, int flags)
     return ret;
 }
 
+bool page_check_range_empty(target_ulong start, target_ulong last)
+{
+    assert(last >= start);
+    assert_memory_lock();
+    return pageflags_find(start, last) == NULL;
+}
+
 void page_protect(tb_page_addr_t address)
 {
     PageFlagsNode *p;
-- 
2.34.1


