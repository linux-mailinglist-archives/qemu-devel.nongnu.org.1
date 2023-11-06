Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB5D7E1AB6
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:07:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztfz-000675-0w; Mon, 06 Nov 2023 02:05:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd4-0000kS-CT
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:39 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcj-0001zT-FF
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:32 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc938f9612so21212615ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254131; x=1699858931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WrSHdS8nFZ56nl7bHUN8gol+4q/tu5sIGlKfmtBWAC4=;
 b=pNv/Yksf3dsJSvaZLNVbwOMA/Dgc+fiwQjA/Cv7Ez4GD1cslqgDVCG9+WD1AVsQERr
 EtTkuWAeO7IOUhzCbNrdjKmgsQ6fBJxDGT5+scXKGDXh5lVVa5s5w3FJcYjW4GteOC+E
 gUbjCqNzJ/hPfYIMpBWpv2Rmgw5JLJmdpMgEq5xR1Ibr/EFYA7et/z9Mg8Qn1k0bY3dJ
 OXVyqj6mODBBdHTW5QkaOqP+L2IO6EVD1WnEeoYYLiWcDzJLCT7Kg+S61wP+LMQ3ZCzJ
 SUsl/b+Up8rI12uNJ+URD4CbQeOk2NJbo9HhxQ0zBsZFE/10YyRjRdqC8UnnY96jYQ9d
 238Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254131; x=1699858931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WrSHdS8nFZ56nl7bHUN8gol+4q/tu5sIGlKfmtBWAC4=;
 b=b9ncWjZ+Fmnfg72soKikF0JIVYSPJa/MTYknfxk9+98tNM0C6NNU7jBiD+wD9Vn7X2
 bz8M+sAM5x6mpV1pHD9slvz8B0x2KKLTMMNluMSoDiBU+tkcfGibvGFQYtW1NP8SiN9d
 4SsWK8IXkBGjM354mNk9CHANAztok0a5MY/izsumHYU+6z4CI61Ffbb4UrLXb+ujP2I2
 gFU45hApWp6TJCV7CTeF0dfmRZSGpsFA9L+ToD+xNvnLHYo+saXezeS2g167D8EZuhCp
 Fv9E/v+mDf6FBC56hY0H95sXWsuNYcqYevaApZxmWwmvsWAeN8wGks6Ylsbj88XJ0EGd
 uPew==
X-Gm-Message-State: AOJu0YylA8L1qxPQngsf39ryY8lDLBog9V63d+Y0+NeAm2XWEMXcLSLz
 xoLR76v1gvIfVNphAqONwE9nKTTR9kezjxAQu1c=
X-Google-Smtp-Source: AGHT+IGxU+Lsoymzkj0jf6aUM53nBCNVsy+3vFfLOEcZU6jDjFSXd88EZeHXAKJO6LJSb3XfcYf7vA==
X-Received: by 2002:a17:90a:cb12:b0:280:1cfb:f7ad with SMTP id
 z18-20020a17090acb1200b002801cfbf7admr19904520pjt.4.1699254131497; 
 Sun, 05 Nov 2023 23:02:11 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 48/71] hw/riscv: Constify VMState
Date: Sun,  5 Nov 2023 22:58:04 -0800
Message-Id: <20231106065827.543129-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 hw/riscv/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 7331248f59..d3bfaf502e 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -374,7 +374,7 @@ static const VMStateDescription vmstate_virt_acpi_build = {
     .name = "virt_acpi_build",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(patched, AcpiBuildState),
         VMSTATE_END_OF_LIST()
     },
-- 
2.34.1


