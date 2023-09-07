Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD178797193
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 12:51:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeCae-0008VK-MB; Thu, 07 Sep 2023 06:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeCac-0008TR-KB
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:50:22 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeCaa-0004kd-66
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:50:22 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-401c90ed2ecso9272665e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 03:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694083818; x=1694688618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qR76MJysRFRlkGpkSxfycYOt+ElbLTNXgKJufTxw2AU=;
 b=gulcJRA76m7pJodcyzudwxUwmifekV+Z+Nx6U3MT0Llie2MDlOVo+W8ucQg1M3Mov1
 eOtYNZXpUzmT3nJbjXqYbi5gRMHo04utZezVms0TwJnwKaDmlGZJwbMMC0gcnEYLms5p
 1WDVlsYdk9geKQieKCcJi4slvhis0z9Zbv1brTwJe/WtbWRx1ShSNoLZbYPw2KGY7Srg
 vb6u6hbfGJgN0M7dzR5mQP1p0HnnSVrcXSarL0Cn7sE641JoK0u3Y6610p/uEwogOqRq
 WpyE1FdF/T5ya34nLhFfVJi9v76xA2Yk6sHpPwlx38Y9HaCXejVs32CSm6LE881uytc5
 +6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694083818; x=1694688618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qR76MJysRFRlkGpkSxfycYOt+ElbLTNXgKJufTxw2AU=;
 b=ksyXzRsCWNepeJRawuqlCLqMo8Q9teikArhD2eB34ojWQ34kxt0KbMyERbHQ2wn/xf
 Da3OY3yrJJ54PCMbRBwQctqa7pf2h1eiGu+B5kl0gA3+2z4Qo6K5ME//51XlN7zgZwSa
 hc5rTBikgibcWM6AEJ2YsHd+gpQiRKKFK6lslITknoPH5SxD+6gdMt23hlB9rlf+K3s8
 68EM3kyiTLcAKQlQ7+3sikCOd9HNpnBXJN4xN/0aa2II/5K7IjETAjlDL0G5meauKdyh
 K/NdkW5SrzMDG3BdvzJqWabuS5OV2rhEZV11D6u+kDRU28WnL8nmHfixqi8dxPg6mF/h
 r+4w==
X-Gm-Message-State: AOJu0Yw1thU4TqX7dyLjFU4TTamsxdBTDGOgYWH/yIRITSqdGohbVh3R
 FZZHVynI4vn0EjTsEbamOWU6r6IX7Itw0DAoVJU=
X-Google-Smtp-Source: AGHT+IE95ezYlDMPxBwWipeU+TdH+9UeVBFojOUl0jij+GROnKdgoRq+RSG2TZcfgpAJ4yLLXP9kTQ==
X-Received: by 2002:a05:600c:204:b0:401:be77:9a50 with SMTP id
 4-20020a05600c020400b00401be779a50mr4312229wmi.8.1694083818635; 
 Thu, 07 Sep 2023 03:50:18 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-226.abo.bbox.fr. [176.131.222.226])
 by smtp.gmail.com with ESMTPSA id
 23-20020a05600c231700b003fed4fa0c19sm2191436wmo.5.2023.09.07.03.50.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Sep 2023 03:50:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] contrib/plugins/drcov: Fix string format
Date: Thu,  7 Sep 2023 12:50:01 +0200
Message-ID: <20230907105004.88600-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907105004.88600-1-philmd@linaro.org>
References: <20230907105004.88600-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

This fixes on Darwin:

  plugins/drcov.c:52:13: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
              start_code, end_code, entry, path);
              ^~~~~~~~~~
  plugins/drcov.c:52:25: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
              start_code, end_code, entry, path);
                          ^~~~~~~~
  plugins/drcov.c:52:35: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
              start_code, end_code, entry, path);
                                    ^~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 contrib/plugins/drcov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/drcov.c b/contrib/plugins/drcov.c
index 686ae0a537..5edc94dcaf 100644
--- a/contrib/plugins/drcov.c
+++ b/contrib/plugins/drcov.c
@@ -48,7 +48,7 @@ static void printf_header(unsigned long count)
     uint64_t start_code = qemu_plugin_start_code();
     uint64_t end_code = qemu_plugin_end_code();
     uint64_t entry = qemu_plugin_entry_code();
-    fprintf(fp, "0, 0x%lx, 0x%lx, 0x%lx, %s\n",
+    fprintf(fp, "0, 0x%" PRIx64 ", 0x%" PRIx64 ", 0x%" PRIx64 ", %s\n",
             start_code, end_code, entry, path);
     fprintf(fp, "BB Table: %ld bbs\n", count);
 }
-- 
2.41.0


