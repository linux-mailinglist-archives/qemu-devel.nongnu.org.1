Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A55F67E1ADC
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:13:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzta7-0005S9-5p; Mon, 06 Nov 2023 01:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZi-0004g8-Ok
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:59:08 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZf-0001Si-MR
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:59:05 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc9b626a96so17806275ad.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253942; x=1699858742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+xKlBCTvSXenMUD53ZEaQCvJkOxpiWeki4MTKxLW1Q=;
 b=X+Z6Mt3FQHfaSMsW/vSgw7DSbZpdbMLvf/a69pMNxEUfuR0GviYxIGOV1hP842BmIZ
 do9pV94m8BF+4p2VNvtYRDumxhXcyMROoe9V9D0qHyZNw0+33QuJhnVN5zB+QXFm1VVO
 jdGPFAHdEpxVaqNvGGopze6nKQjwCuPx7r2VKZZmaLXpyKmqEy9DZofZsQJZFXWdr6U9
 tKSyUSqVlfoYjPd7R6NyfyPcJGBe+sBsa4uAbmC6vUbsTNo+qRKGYglgvV6V5nc1qbP3
 fCLBOwvs6PfHChoDvlCkwffZjrpC0oDcNjt/5PPCorWARmZvZI87KEbwLu5FceSFJfUT
 GJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253942; x=1699858742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+xKlBCTvSXenMUD53ZEaQCvJkOxpiWeki4MTKxLW1Q=;
 b=uC6jNVaG9HYEnOBSeM2WWl35WBjm42WMlYKqVlFlHjnl+UxGf8uCXohWPXOtGoSxrb
 D2YzbRaTmFZM122e4rAG5k28/gegknNQg3tRp1ZShm0fHmU9SnWBX4rlqutmk3HYlBvn
 dfamwvstsXvuxuKGcoVHW7kTFrNkauQiKTkORoi3LYFWBKzSrJZjf5SAg4Gyise3kqsp
 guHrjANn3Cb/RAzKk5X+icYasyvND3QP1uaFIa2EOYuI25EbGJ4B5GbIO/rLs/TznxkI
 YMd+J+43tjvLHd7zhLAm3W/D8YXFmUbn4lfgDP/keP+lCfhrVVNhJf/tgAuvD/mpzbgv
 vCTQ==
X-Gm-Message-State: AOJu0YxQLIfmRQu2qJCbTDH3BcJpcaXS9PKW+ipMIxPVoKXI8G/3S8tb
 LEtaPRBhZSmS95uIUZO4NwkeC27/M1vh41eXU2I=
X-Google-Smtp-Source: AGHT+IEnl1mqPojsTk+yxNAhv8/9L9hFhX9InvlbC910gw8BYSdiZZ2AqwI7bjLyniZxPt+XRgbdUA==
X-Received: by 2002:a17:902:fb45:b0:1cc:379b:3505 with SMTP id
 lf5-20020a170902fb4500b001cc379b3505mr16224531plb.49.1699253942504; 
 Sun, 05 Nov 2023 22:59:02 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:59:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 38/71] hw/loongarch: Constify VMState
Date: Sun,  5 Nov 2023 22:57:54 -0800
Message-Id: <20231106065827.543129-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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


