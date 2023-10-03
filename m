Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEE07B6FCC
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:32:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjFJ-0000GN-5Z; Tue, 03 Oct 2023 13:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF9-0008VK-61
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:35 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF6-0007Xu-ES
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:34 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-692eed30152so920538b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354291; x=1696959091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrUTbAqq5Rh4+S6dQa7CskGzlO2N+g4ynCNykCd/g2Q=;
 b=tXCef8G2J2V7P68D5l4b1DX8jL5sT5gDKQbnuY/8PPYkvbXUhcAdoz/Ajbpep+FGMU
 jyCn4K+pdgsPBcgV9wshh8WXnLHg1ytxeqwces6l2Kf3usg5mI/3GKe91+8n4s/Wzbqy
 ce43omQrMGJka64k89AOIahPCXyieCReHsBzVTaqLST8JU3Wat5VOy3iI7Y9dOexeeBY
 u6IOuqJ/jAmzkRlfMpsTf+1LBo6teUYgAPvNm3hqvoPO2DHnCZ4ca0MmnXsyvy9aM5Jp
 Y7T3c2zQgMQLlkFVvjcmKEUTai3YDKUrgD91GAFJ+rb533DHZrwtXHqu9S9GXLW1bFoi
 ntHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354291; x=1696959091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FrUTbAqq5Rh4+S6dQa7CskGzlO2N+g4ynCNykCd/g2Q=;
 b=H11WiPZ+PDjikkIgY8+sHhVsmRuoTQXCO8WTZ7NecODhFnAh/UeOSoU1K8ibnbuXms
 TpZmoyeMeirBXkkw0BSuEETIt7ptbwrSNKAxengfaWixxYkdHPqqQAQKbEIZbn3B1lVK
 f2FnOgq3+TTSN72WDcuyptoUOr4hTXIt2uia/VQCkbzeAStGZkwQpChV3ZTeJdt8POaA
 ofdGmB6nV6EJ3g2KmUCuEvxfQyy82+niSgQ1YefDGhBGhdm1zy4iogyXhCKcrQlP6v9U
 +McYgBmCTOcijKHYpkmK2ugOB7qQpwWUTPouKrnW8yDp2WcQZrmik9WGqeCjkEitiOMb
 3jlQ==
X-Gm-Message-State: AOJu0Yxlxy2zwMnarbN8SSJ0+bvp+UfT6GbC1ZLVeu+6dv+gx1K8sJgs
 91Qy6QmbXYf9sT1+4jvCXnASWbKJSEA2lbGx2K0=
X-Google-Smtp-Source: AGHT+IFqLayzwHsiZP3YpjKuUG8QYOSNAEDT7vieGCM4gwb1+4MzUyyBs6Y9lPPTdYDTXyy+9Hv7IA==
X-Received: by 2002:a05:6a21:35c8:b0:14c:dc8e:9d3e with SMTP id
 ba8-20020a056a2135c800b0014cdc8e9d3emr132108pzc.26.1696354291228; 
 Tue, 03 Oct 2023 10:31:31 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 34/47] accel: Make accel-blocker.o target agnostic
Date: Tue,  3 Oct 2023 10:30:39 -0700
Message-Id: <20231003173052.1601813-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

accel-blocker.c is not target specific, move it to system_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230914185718.76241-5-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/meson.build b/accel/meson.build
index 638a9a03ba..76f3cbc530 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -1,5 +1,5 @@
-specific_ss.add(files('accel-common.c', 'accel-blocker.c'))
-system_ss.add(files('accel-softmmu.c'))
+specific_ss.add(files('accel-common.c'))
+system_ss.add(files('accel-softmmu.c', 'accel-blocker.c'))
 user_ss.add(files('accel-user.c'))
 
 subdir('tcg')
-- 
2.34.1


