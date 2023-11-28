Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 639CC7FBBC0
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 14:38:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7yHi-0001sM-2p; Tue, 28 Nov 2023 08:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7yHg-0001qr-6M
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:37:52 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7yHe-0007ya-O1
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:37:51 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a013d22effcso740507866b.2
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 05:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701178669; x=1701783469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=htBKMVce+5k4Dd75IUusM/oeR5Wa1XdashAH0btXn4s=;
 b=pvOS4t1YWqQkJ+frrO1KRiLgYsltZlr36WIdRcL/sg6mdGe5cjaC1Pvwfw+Vth7CUO
 KLbS1h+D1eQgpskQPYx86IndfRZgi9rPydocaNO5q5jfIxPsqRDYaxfjfCI82WqXXl4g
 VUy9g3YoRIFgbpndhHKABycEkd5Vcz7NuxaAG75iG0VEo9Su58aKZ8WLcoVAIYxoEih1
 MYN4Sbc8oRn7p7oY251GDbtmbSCerid4l3NTLbueB+nbbMwBf7+ug44a0OD+yfmMLze6
 qBjBCyE8wD/jWvSt/wSXsxBGYlTdQJ9rJRGoXmZvRzQdOhHooeyrUXvy1GpVvYtoBUa4
 +Jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701178669; x=1701783469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=htBKMVce+5k4Dd75IUusM/oeR5Wa1XdashAH0btXn4s=;
 b=RuRwnMtHIKh6wlaykDjG/xxYSE/m/qit02uABPJkB8GFyEr04seBjv1EmOeqRgB6+c
 8aSs6C2kdQRiVJEFIcoczfgtM9W79afA/DhwvntjMW1ooyjNXSlIoBQndfuenvbW41H5
 R43d36NabRHJKl1aMbmaQdn1QijvbEB0wrHawyrLOocbIu3yU06VkXpqXT0RyNWCsFio
 1ZgWhp5hzobWVUHBBKUAZtIo8JFhwDvLCj1Qp9DspYt9niopaVoEMSH651dO3qY+pEar
 L6jR8Yh6+MlXWlnCmNW0s4qJMAKoYH8IZcEnqRVl/qsuIkVs7NPngCUiNXWXJA5IJ94w
 3CGQ==
X-Gm-Message-State: AOJu0YzeJwoNhYmVbdPZTOit1z8DCIxfBQOWsfMwJChMtsrGFfY1B7eg
 TFEPEeavrRMaVMyW4bI088L5NKvtfviiNbj1Tyg=
X-Google-Smtp-Source: AGHT+IG0ddno8ozv8YjUVBb7izg3bRab+R+FnCAjN+JZKFsEabaqSQdBXsAo+aa7K0NoVhkv5GF/PQ==
X-Received: by 2002:a17:907:c8f:b0:9c6:8190:359f with SMTP id
 gi15-20020a1709070c8f00b009c68190359fmr9290221ejc.33.1701178669125; 
 Tue, 28 Nov 2023 05:37:49 -0800 (PST)
Received: from m1x-phil.lan (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 q26-20020a17090622da00b00a0d74d56d66sm3154544eja.42.2023.11.28.05.37.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Nov 2023 05:37:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Alessandro Di Federico <ale@rev.ng>
Subject: [PULL 1/7] target/hexagon/idef-parser/prepare: use env to invoke bash
Date: Tue, 28 Nov 2023 14:37:34 +0100
Message-ID: <20231128133740.64525-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128133740.64525-1-philmd@linaro.org>
References: <20231128133740.64525-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

From: Samuel Tardieu <sam@rfc1149.net>

This file is the only one involved in the compilation process which
still uses the /bin/bash path.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20231123211506.636533-1-sam@rfc1149.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/idef-parser/prepare | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/idef-parser/prepare b/target/hexagon/idef-parser/prepare
index 72d6fcbd21..cb3622d4f8 100755
--- a/target/hexagon/idef-parser/prepare
+++ b/target/hexagon/idef-parser/prepare
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 
 #
 #  Copyright(c) 2019-2021 rev.ng Labs Srl. All Rights Reserved.
-- 
2.41.0


