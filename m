Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AF9734F82
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 11:20:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBB2Z-00034F-Pm; Mon, 19 Jun 2023 05:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBB2W-00033O-ED
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:19:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBB2U-0001xi-SA
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:19:12 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f9b1a117caso4353235e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 02:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687166349; x=1689758349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ymckh/jJUuhk+bN7W/yTN4TDJ8aIcl8RwV72SXESkek=;
 b=VYTjg9ouQCSN11FK8Enjl5bbtCqNjPTp9kwTO9PT3gZIi7b/8f9LAPiQhMGyfVkpvv
 rXFA6Z0QRwuLGlgI+5eA2hcOcPEf7x842iKYmVShuiKlnip5+hRhWTXnOP8OqKbvP4CV
 FUTIL9HW08VhtZUAhjhBmoOfFghlBtVjduqOJeAOSyro9u6mLqVSCP+rf8P+0xElt0xC
 JhtjBVKf4TSCn/O0QjaUnCACMnf7E8bgDsjgJ1yjomUwmujcBl9y1MgRAXMSHtoYEXD0
 +IbHeKDIMt+kOZqEsoUToeQ+FyBVEjLDjoLJZS5Wl4xopBFkaUh7vVO3anDBPdEgw1Mq
 sCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687166349; x=1689758349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ymckh/jJUuhk+bN7W/yTN4TDJ8aIcl8RwV72SXESkek=;
 b=iX6GLT1xvCRaWk18u9QOUNP5vCtPGTbSM4WbFD6HB8DfIoCnabsUHYxnBBt97iaNty
 udRLH81hlFApphJi/neG7QWe4tafDssYB9Wd/8frA+7GpjYgY3Dt44/rX2k4q48wd4FL
 cwfKo2O0dtMejp0kNeCBhTUD06n5Wg/lyn1b2Q8sI71V882IYhnJZbt973JKfVvbZKga
 jTjMWBYxL/bs1mnNUi5ezM9dp/KztfsJgupzRh69ixE6I90TqWnPa2/2nGXkr1WfJVES
 9x4zDze5qRdL9UpwAZwyXiy3tyejaYeQ8Vf/44bTZu0HaK3wdIVx0XhlbS8Gi2lS2Yln
 utjg==
X-Gm-Message-State: AC+VfDz3gqpJrKAtbfHYd34VzkxKb+QlDEYaL8TbItt7rvjJ82JIhJDV
 hRb4ohVYJ4jccCAy/eWjytUBkkMwKnj0D3hJGkSz1Q==
X-Google-Smtp-Source: ACHHUZ4mnnZS6YCWE/XWziTozH56HFwBnuGL0GtO3P6iDdTd0azRWGuMHTQIAUMOWJ/l4yACGg7miA==
X-Received: by 2002:a05:600c:acd:b0:3f9:92d:9ffe with SMTP id
 c13-20020a05600c0acd00b003f9092d9ffemr2854342wmr.14.1687166349005; 
 Mon, 19 Jun 2023 02:19:09 -0700 (PDT)
Received: from localhost.localdomain (194.red-95-127-33.staticip.rima-tde.net.
 [95.127.33.194]) by smtp.gmail.com with ESMTPSA id
 g18-20020a7bc4d2000000b003f8d0308604sm10189156wmk.9.2023.06.19.02.19.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 02:19:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] target/arm: Widen probe_access()'s address argument to
 64-bits
Date: Mon, 19 Jun 2023 11:19:00 +0200
Message-Id: <20230619091901.51607-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619091901.51607-1-philmd@linaro.org>
References: <20230619091901.51607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Make probe_access() agnostic to the address size of the guest,
using a uint64_t type since usage varies between guests.

Since we don't access any CPUARMState particular env field,
use the generic CPUArchState type insted.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/helper.h        | 2 +-
 target/arm/tcg/op_helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 3335c2b10b..cee9462c73 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -101,7 +101,7 @@ DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
 
-DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, tl, i32, i32, i32)
+DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, i64, i32, i32, i32)
 
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 3baf8004f6..6cb84bc994 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1009,7 +1009,7 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
     }
 }
 
-void HELPER(probe_access)(CPUARMState *env, target_ulong ptr,
+void HELPER(probe_access)(CPUArchState *env, uint64_t ptr,
                           uint32_t access_type, uint32_t mmu_idx,
                           uint32_t size)
 {
-- 
2.38.1


