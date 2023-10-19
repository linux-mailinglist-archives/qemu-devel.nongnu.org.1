Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2757CFB6B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:41:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCc-0002hY-8Y; Thu, 19 Oct 2023 09:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBp-0001rX-9S
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:54 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBg-0001Ck-18
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:49 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40806e40fccso21758515e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722542; x=1698327342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g9r6zIkMYz7JcnSG+rRRxCK1RkPWO1zbCKf8oqt+HSA=;
 b=FyPoHSuYTT3zGbpuGNnOuW0mK3OanV1ilmoJKA82SiJ/9nOd+wkLcRVAbJDdOOvtL1
 H9q8WisnC+gWBoskk6qzUqX6XNUdQkTa0Mc6LMxQhlI0KJTfloIQ60/Ci/qC2JYlOdJA
 AKml5mnHKp7D8pW9caRNe92hjX8uXM1VYqvIitcGzEJdTo7OKbrJj7cvurmsa6j/yutM
 KbOTzOgTxslvb1ww7B6v89etnuaPA9pqCMcfR0cwQR0P8Lj+Gs77xGPJm3Z1V5GMT+/E
 U98+f01SfN+GVhiNclEml+DJAMPnh7GTLgFZNREV11K/bB6tPcwIQWAhpN4iazsoXq26
 gHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722542; x=1698327342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9r6zIkMYz7JcnSG+rRRxCK1RkPWO1zbCKf8oqt+HSA=;
 b=jlaID1BhzsD9Kw5A/nVllYJ4bhCpbEmHRi6B/k89asHxwDLeiA5sPtVHniJUXH3g9t
 zZkYsb2tb9hpCUK143q7Lx1nW//Lq/RDXSwL173VxaRTI5YG8Fr1i1cCICjE0ytSTOIk
 F9s8HqFoIkGZJ+V5plD/J4xnQkcZqYZnXTYOvLkeD1yjkNWyv4q+1WiYIvGrAv+Jc+R0
 +OrkHDwTwj/Mw1x0qQOmEKsl4xZUovRAcLHWbW/8Zj0kQRN3yzWVvfuPy4UL5og3tR6g
 iHYGAy9SWpeAwBqyY13SjFuV1PEAvf5PDlnQN+buxWSZ1LqO36BoCwhUp+eTQKNVrkW7
 JOPA==
X-Gm-Message-State: AOJu0YyH2qj4LQtkjIyqTWT0rD3PAVxlrRGipP5J8pDYPfrAeV2C6p5u
 1a0r6fdFoYnacWFhSVMdFvg/sBy/4Ah+ziZcPjY=
X-Google-Smtp-Source: AGHT+IHFH0XD/I6YtzDU1wXg8atVkWbrl2SYTICBFYXkfkEGTPqR2T0Uq8SGNnjvY7Rr+D7mniNDew==
X-Received: by 2002:a05:6000:1203:b0:32d:9789:6066 with SMTP id
 e3-20020a056000120300b0032d97896066mr1856449wrx.5.1697722542324; 
 Thu, 19 Oct 2023 06:35:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/24] elf2dmp: limit print length for sign_rsds
Date: Thu, 19 Oct 2023 14:35:20 +0100
Message-Id: <20231019133537.2114929-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Viktor Prutyanov <viktor@daynix.com>

String sign_rsds isn't terminated, so the print length must be limited.

Fixes: Coverity CID 1521598
Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-id: 20230930235317.11469-2-viktor@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 5db163bdbe8..6de5c9808ef 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -478,7 +478,7 @@ static bool pe_check_pdb_name(uint64_t base, void *start_addr,
     }
 
     if (memcmp(&rsds->Signature, sign_rsds, sizeof(sign_rsds))) {
-        eprintf("CodeView signature is \'%.4s\', \'%s\' expected\n",
+        eprintf("CodeView signature is \'%.4s\', \'%.4s\' expected\n",
                 rsds->Signature, sign_rsds);
         return false;
     }
-- 
2.34.1


