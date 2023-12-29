Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C97A68201C4
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:30:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKMh-00027F-2o; Fri, 29 Dec 2023 16:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKMB-0001Yt-LC
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:30 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKM8-00086T-Iq
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:25 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6d9b2c8e2a4so2694268b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885122; x=1704489922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7X80Y/pAYkS9ptMo/yJ1dNZkar4tYwTu/+PVpKo0ts=;
 b=hIUuqALjDOrX3i6FzaJYHa0WsCMrWrYhyqzf6RU2EV9ZJ5aZd/sVWb+OodLIUT11b5
 nmP5dFFbNVGXn6TIwLIyW9UH0zRACuBqzJzMnx0vxhNU3kNXKN2XH5VuFNlV7B9Ftj7w
 1W9l2oSC1K0b70KE1yP07sGomL9DMQD8ozlltkgiQ3zh+UfniLgWxL/jihmwnsT4kRJR
 rzh2sYmmhv60fi3onoqmWDPz5eumOyx8B0wumVN3gLJMtMclg1q+tygqTN1GMTbRV3c0
 El49GpDXlM7mk9+U9kYlifAQNZtHNGoxgG/s8O3MHfPIHP7CBoF4xUrGT0d7vEv0VCgl
 GEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885122; x=1704489922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G7X80Y/pAYkS9ptMo/yJ1dNZkar4tYwTu/+PVpKo0ts=;
 b=OjJOaGq3/HsLw62qULfjc9XcMjQHmQlvfNbMlR4itcC2IoSGhb/CGQpToFXWwpPI4c
 aeSCDvQg56Vo7Xl1svlZj7NhwgWmy8IQUyYh9PjfW3nOGgtUSXdvLNAjWVbxEjcu4nU1
 uBMAGPIdynfttHLPP17+Ms5aWyXZCL0TTF6oFxY87nbDoHauj4knBmHsq66lOkUw+lXd
 Uyp21jnzIYFoNevO2rxDYXU432ZG4jXHIYCVLz+YSgVY8ga934srzETUZ8Uu9lT1CIi8
 ML6rob/r7lCTkNEAzIFEysxXM3eZIKHS0UUNCl/H/ysuS9MZUbaqPgCJchMmjHE63Lv5
 C02A==
X-Gm-Message-State: AOJu0YzdQwQmR04NPAATJgVKQ5M3Ywiw98f+Vx466ipJT1ekJNnAmbiS
 I9leuZypWGP+/oT/p3kGNzJITyegyfVoM8S6CuVdXpKx1z6Ekw==
X-Google-Smtp-Source: AGHT+IGc8nK+XDBrEQ9s/bw+PJagnCp8/trgReHvsgSQ62s2JOdar6zr2/OD2aX4kzIllA1yFlIZsQ==
X-Received: by 2002:a05:6a20:3955:b0:196:21f5:7aff with SMTP id
 r21-20020a056a20395500b0019621f57affmr5295128pzg.47.1703885121992; 
 Fri, 29 Dec 2023 13:25:21 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:25:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 38/71] hw/loongarch: Constify VMState
Date: Sat, 30 Dec 2023 08:23:13 +1100
Message-Id: <20231229212346.147149-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20231221031652.119827-39-richard.henderson@linaro.org>
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


