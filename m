Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6368781AD5C
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9b0-0006K5-3i; Wed, 20 Dec 2023 22:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ax-0006GM-RX
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:35 -0500
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9aw-000478-EG
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:35 -0500
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-77f35b70944so23112185a.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128773; x=1703733573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m+xKlBCTvSXenMUD53ZEaQCvJkOxpiWeki4MTKxLW1Q=;
 b=EgnsRCnw0bQbxzVrPAeO8SXG7Xvn/+BwTfB6IsA38tdMA1gWBApSjs+sN7TIn6gemc
 JagCA5pTLsCBwZtD7mmlr1bkyK7VO9zASeaVUMw4M4Pi61GOy+JgfeGaNVXhUPnQSpua
 xcrYnxQdFSAJioPLySg9LB82P4vlinhLBCmMIHQHneeK3APyR1X1drOlyEmsubFnuwAn
 HScnrmiBmKvHODzdJ/D2csd7Kc9xxBxLBZrtCY3MLrF9INceMfRck2ymu8m+a26ZOBey
 raUDyga9LXRqZeZ+pTfuuXugK7G85R0FKtHdPW3zEJN8f/nCcvKjhCPbrLGn8pV59e7A
 eXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128773; x=1703733573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+xKlBCTvSXenMUD53ZEaQCvJkOxpiWeki4MTKxLW1Q=;
 b=hK5XgkwLKgiIJikO8JVGyBK6EXZK4AICYhE2AauYDaY4WnCvF0NoEvIRJSx5TK4u03
 l0H6hPBlRc4iJ5qaSI54XHGO46F+aJMsToi1uggkyye5AbGaq1kxP6xADIy9Yiekcf2F
 0+KGvjyc+DDA+PtQWW4DzDwi4D0oZ2SPgaaemgqFH50vRFbLtwL32I1U0EJfQZIvcHy5
 tSkLtUFT9pjGpawl9N057p8/QsNgFfxlNSGLeQg5LaW0qDZ3aSuFfS4IcHa94OdHWWnm
 meaRN5jVnlaLp536VhSYW2VLrx/UQEqgwhuTf0wVyZSswfDv8BWVmAbDLt5xq4LXQBXM
 wzBw==
X-Gm-Message-State: AOJu0Yx4sZmc17TEXvBHfZLUvZPoZHL1XFW/Uh98o/SLbKFiPI9PzIWy
 YEkuvUID+ZwPwRZEasmVa9JuGWNeSnVS1hOQP5T0fKLi
X-Google-Smtp-Source: AGHT+IHBm7nv+34NP2V88S3M4D9DwAKl7tP6EzosbteDDPLORho4+xopIV5k7aYR+27422j/lK78Sw==
X-Received: by 2002:a05:620a:2953:b0:780:e87d:aff2 with SMTP id
 n19-20020a05620a295300b00780e87daff2mr9257420qkp.104.1703128773692; 
 Wed, 20 Dec 2023 19:19:33 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.19.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:19:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 38/71] hw/loongarch: Constify VMState
Date: Thu, 21 Dec 2023 14:16:19 +1100
Message-Id: <20231221031652.119827-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x736.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/loongarch/acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index ae292fc543..730bc4a748 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -564,7 +564,7 @@ static const VMStateDescription vmstate_acpi_build = {
     .name = "acpi_build",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(patched, AcpiBuildState),
         VMSTATE_END_OF_LIST()
     },
-- 
2.34.1


