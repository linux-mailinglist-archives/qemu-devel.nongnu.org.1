Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D24B170D3CA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 08:16:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1LJW-0004lY-Fm; Tue, 23 May 2023 02:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1LJS-0004k4-3u
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:16:02 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1LJH-0005v3-42
 for qemu-devel@nongnu.org; Tue, 23 May 2023 02:16:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f509ec3196so29340205e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 23:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684822549; x=1687414549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hxpaBQnYbq6uneZzMMpOzN8+mfUPhtC8eR0rzpaDnw4=;
 b=cOLW07yOtva/dc0Gb+LZZkb2LkaTSj8NdQy6E0hR8OUnA3kOIn0G854B1ch42O1PE3
 sS+pzzr8FwALC0H4iwph1afBUW/RBNcAWpy8XG6hjCpCUfJD8B3VYe6zopnzKLc8qz9O
 In99XjFFb8vqy2c0gpGmxZFaMkDyhd0o9upxahhvc20bnjT5AyAHwDSdOATIWemg0HW4
 /7bOCE5PLdlAVW49PSrXz7ZPFTobVwkngU/XWakMlf6+3PhsCbv5gteQ+yycFGn9+l8h
 gMwfPFtIVnP8fm6JM+cCC48zxpW1+Je50yuBarYtX1aaoomT4KSOkzHjj7Lk838WLBQY
 mZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684822549; x=1687414549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hxpaBQnYbq6uneZzMMpOzN8+mfUPhtC8eR0rzpaDnw4=;
 b=K2mNk5LEP+nGGCz2PkU5ZgbxY2e7HbP/YuvDaTChIAdg2Eyvv9LB6m0ORqh0zEbaMR
 aWFK6Vj9Xv9nrBLhOAhUXCa3viDRU6vNP6ds8hu4YlroNSCKEMGNjQ1LqpmYSB3T4G27
 MHTXGrBh94p90Dc5p5USz65lxaCCffvDgWtIddTe8sB7Gi2ESiMPHcVlGnxmd/E3x6FO
 F3EjklwEmjz+WmCjS4VRBcovOm9EL/JdFmIPY+jxH8LaECyB1RYTkadGUv5BWiOGJR+r
 A7dyttrF0RcDlQz7+ynOWbAvv27c8ZUI5kpmms/NZVf7YgyNii6L4IKwMjTZ+A2Ytpci
 VRhA==
X-Gm-Message-State: AC+VfDz6RfcYoJSycQwjVtTmk1ULTjA5TJ0UVC5OILfnQGgFJWffwUU0
 3+Lr2EfTcIxYlGhtCPAxNDypGHnpwKCSnSv2L/c=
X-Google-Smtp-Source: ACHHUZ7zGGWH3QUOY00Ym7qvFGgvGWis41KLejy5KUb582e9okenGQFf0EvcXq5Ay/ANFib9qBtP8w==
X-Received: by 2002:a5d:658c:0:b0:309:596f:e5a8 with SMTP id
 q12-20020a5d658c000000b00309596fe5a8mr9020981wru.4.1684822549343; 
 Mon, 22 May 2023 23:15:49 -0700 (PDT)
Received: from localhost.localdomain
 (vil69-h02-176-184-48-94.dsl.sta.abo.bbox.fr. [176.184.48.94])
 by smtp.gmail.com with ESMTPSA id
 k1-20020a7bc301000000b003f50e88ffc1sm13948454wmj.0.2023.05.22.23.15.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 May 2023 23:15:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/ppc/openpic: Do not open-code ROUND_UP() macro
Date: Tue, 23 May 2023 08:15:46 +0200
Message-Id: <20230523061546.49031-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

While reviewing, the ROUND_UP() macro is easier to figure out.
Besides, the comment confirms we want to round up here.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/openpic.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
index ebdaf8a493..bae8dafe16 100644
--- a/include/hw/ppc/openpic.h
+++ b/include/hw/ppc/openpic.h
@@ -55,7 +55,7 @@ typedef enum IRQType {
  * Round up to the nearest 64 IRQs so that the queue length
  * won't change when moving between 32 and 64 bit hosts.
  */
-#define IRQQUEUE_SIZE_BITS ((OPENPIC_MAX_IRQ + 63) & ~63)
+#define IRQQUEUE_SIZE_BITS ROUND_UP(OPENPIC_MAX_IRQ, 64)
 
 typedef struct IRQQueue {
     unsigned long *queue;
-- 
2.38.1


