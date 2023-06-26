Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D43873E3E1
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:47:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoLP-0002Ov-4u; Mon, 26 Jun 2023 11:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJs-0000Ji-G6
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:08 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJp-0002rc-UX
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:00 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so4185700f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793996; x=1690385996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/d9RaY710qpk29m9NqH9KDca+EQbruyiS1ODzVmbSbA=;
 b=N99KCKQhLS/q950UocoLeM9uylNIvrymTBb8PXigGVLk06+ThT5VqaHV3eRO4sAkkl
 I9xV/lvnpgWfhL423oZLrtnfkkMmaAf6IyM0GcuoepgrlsuofYxcpst/gWh3C0Kqm297
 p47erO75hdBvXQPjFD95xLrur6kVTUvPIJGX6rONlnZrSwW9w1pxBjwqSHeKPjgHLMMU
 NFvz0/svy+5t128w3jJQLmDPtz/dfJOnVur458FyfEavY2HfLfGgK7AWpJhpsd71v9OM
 U6CRR3T09yUlkWDoUm7GAxNy6YJ3F4YK5z4NfZ3RBW1kHwI97UBZtggSzFpMnGt2S/xC
 7YVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793996; x=1690385996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/d9RaY710qpk29m9NqH9KDca+EQbruyiS1ODzVmbSbA=;
 b=FtXOfmPhjecf8M4YmnTc5M6EvwAWoPFMDTuOu0JjILCl8ODykP7mBUH32EXw6Dz9LP
 FDkADn5x7teYX5XKxnX/itnHhvNzsUSQGUGJQOAhe/6D0yQVoRjqx/nae6Ee17Wzur2j
 +0ATXb0v0g1bbdvskkS4stECn0BaThrO7r5bq+mSz1w9MDnGq8SDmBj+NXMqKih0SVS+
 t+0XPx2cPN43+OOePv0fFpcqFdFuSPI01EgAkr/Uu0jebHhT6w6vZd1kHkZOhp46T9tU
 7RyUW83EW7VpgUW3t1578JyY8eljzUNwhJO7sllX/Qy+WqGSiXHo2W88oZdXv+F/ItDs
 Tm1Q==
X-Gm-Message-State: AC+VfDyu1UTyq2g/eZZKazIF8KY9wS0Z66S6fiQ11mhJCspaombspTjk
 7a9ovO876Yw4I2SC2585HKbITv4kqB1CRkYWW33XGGCa
X-Google-Smtp-Source: ACHHUZ489EJ56WqNT1A38W5J62fdp9hlDLvt81rdBapHviMYFjwC8ZScY6blnRpbhzo2TocB2S3NWw==
X-Received: by 2002:adf:e7d1:0:b0:313:f29f:5eb3 with SMTP id
 e17-20020adfe7d1000000b00313f29f5eb3mr2062068wrn.32.1687793996637; 
 Mon, 26 Jun 2023 08:39:56 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar@zeroasic.com>
Subject: [PULL 16/22] target/microblaze: Define TCG_GUEST_DEFAULT_MO
Date: Mon, 26 Jun 2023 17:39:39 +0200
Message-Id: <20230626153945.76180-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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

The microblaze architecture does not reorder instructions.
While there is an MBAR wait-for-data-access instruction,
this concerns synchronizing with DMA.

This should have been defined when enabling MTTCG.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar@zeroasic.com>
Fixes: d449561b130 ("configure: microblaze: Enable mttcg")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 3525de144c..a7b040abd4 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -24,6 +24,9 @@
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 
+/* MicroBlaze is always in-order. */
+#define TCG_GUEST_DEFAULT_MO  TCG_MO_ALL
+
 typedef struct CPUArchState CPUMBState;
 #if !defined(CONFIG_USER_ONLY)
 #include "mmu.h"
-- 
2.34.1


