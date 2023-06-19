Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCE3735BD2
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 18:00:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBHGP-0001j2-PZ; Mon, 19 Jun 2023 11:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHG7-0000rV-Sn
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:57:43 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBHG2-0005Ii-4X
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:57:35 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51a4088c4ebso3225243a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687190252; x=1689782252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yhu8d6diQ3is2pZ2Ay7Lkxc29r3qyYX7d/FAwcjykEo=;
 b=UoZ5Tweaq01fz9vMxPO3V6ToIpKxpEQJH8aTwQyxFciQRpp7RAUBMrRM16Fdnee0m0
 oAXZ4vZPGk53Jbg3lupubkM/xxq8wsKflZ3ofid79NVA9n83W8Yx5jkDas8miwRBBw+9
 eycu76FWF63yvoY1VYpiGCLO+QnsUeWwGTEsWKd7ULGYrmlpO+HZoKM6WUv63NQFWN1v
 EU3YytKTdCaW5ubABBDPa3xTzNvq0t1JDU+4bbkSmhRvh16E8mozwBmNONuKfoOJpL7x
 /SRpz9ukzpO9OOXU3MgCwpmWBiPNEGWr8WFLYnHFLB7pNMDmYfoskPOgKvMYcLaSkfll
 0Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687190252; x=1689782252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yhu8d6diQ3is2pZ2Ay7Lkxc29r3qyYX7d/FAwcjykEo=;
 b=bt4GSW12m0M79qVz2g3lisjGayjMqZCoHBXm4QNvrZbKJz6v+jy0sHiZqaRu3eoVfq
 8jFAaHhjENJwjqrAfKps3ntgI0UzPbPOqNwd9P3D7I6c8NshuU8B0X37FnduOVT2Hnvz
 uW8murxLdEgY53habL0JAo5Emy4toP/PJkTX6vbclxvPp50aiRc2aWhLnvdiX70Sx0g9
 fAWvupEwI3Htg3hgD8e7yMcNJJIjS0hd1linsFgHh06SBygD/Gblb8ofa48BPQPjuxFZ
 snL0qlFj+7ec2kwh4RrkplZtQPF+q/Q8J3dvmBENLNAN7cu35q0E8T+8KdWkdKH3RjAq
 Oh+A==
X-Gm-Message-State: AC+VfDzPu4m1NHJnoBNUabxVA8Xj4WD6DyTBPWBXU58u8CVywpzBwchb
 3dE6Azqt2WEDwbzsqzlWN9YTNeRCYcWLRzM3Mxl2eQ==
X-Google-Smtp-Source: ACHHUZ4JPUUh8LkVV3YoDGE6PZ3HkeyJv9hLXkhN260+gOb4XhfM32FlCoPvusrZCvBZiLBtxwft9Q==
X-Received: by 2002:a05:6402:2043:b0:51b:7c2d:4b28 with SMTP id
 bc3-20020a056402204300b0051b7c2d4b28mr1128702edb.10.1687190252421; 
 Mon, 19 Jun 2023 08:57:32 -0700 (PDT)
Received: from m1x-phil.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 c7-20020aa7df07000000b00514b854c399sm13222120edy.84.2023.06.19.08.57.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 08:57:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 31/34] target/arm/tcg: Inline 'exec/helper-gen.h'
Date: Mon, 19 Jun 2023 17:55:07 +0200
Message-Id: <20230619155510.80991-19-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230619155510.80991-1-philmd@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/translate.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 7d57a71b67..13d59d8417 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -6,9 +6,11 @@
 #include "tcg/tcg-op-gvec.h"
 #include "exec/exec-all.h"
 #include "exec/translator.h"
-#include "exec/helper-gen.h"
 #include "internals.h"
 
+#define HELPER_H "helper.h"
+#include "exec/helper-gen.h.inc"
+#undef  HELPER_H
 
 /* internal defines */
 
-- 
2.38.1


