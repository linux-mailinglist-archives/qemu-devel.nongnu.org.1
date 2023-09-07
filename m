Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1B5797190
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 12:51:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeCak-00005A-22; Thu, 07 Sep 2023 06:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeCai-0008WR-LG
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:50:28 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeCaf-0004lM-W4
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:50:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401da71b7c5so9170285e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 03:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694083824; x=1694688624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGcUdcCLBUtbOEaXKDnL3F02Ox1clS60PlAXYhCrD+c=;
 b=WB+XGbeHp+W5KAyFB3kw4vthhkDKqJBQcVyZKqoXcGJrKr955AhyVrSbAGV+U0XcV0
 Fm2S7D8QpUZU8aDLslMftlMzD/KP1hfd0n4f0tWtP/MCl3ub7K9Keu0FYLTloJBSWadH
 zfbSpfCpNRJldMUOBpJxbhYhqFJmJ6tSsHtWlPwse6ekoea8w9bIVzf97kt2lXtt6YFk
 VPole3v2PFMIgs7VuGlivlk2nfM9jXHgeBLeBDHr7f89qIU55nKQa4FKa4xY4lRk7UX+
 8flT45S3Jf4s78uiekedTTyGjRbvcvQNsusUWR7NfQRFK7Nmlev8JFjX21r8eLFDmz3A
 3zVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694083824; x=1694688624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EGcUdcCLBUtbOEaXKDnL3F02Ox1clS60PlAXYhCrD+c=;
 b=Oad3ILRi8nUxdWAPemMyP/YNZVwA4jYw96U6gxiF47cTGKvsptqQXAYWYI3LocFQvW
 W6Ykstb15YKI4bmawREI0QvrrhiUGrwxx2N2Xm5WiOxvv/vC8hQEa1BDegW+tSCO62pF
 eQA8Drb378wGg492hS35ZmghqowV/jiDxIaOPDa1q4Q30U/Sfo1sRrtIAL35Abckaii6
 fTnnJhi9PSAVhPQVJ3vEYpkaVrWDhB8BaK+jr8zHnAaOMJMj2WmrSCb/PiUySjq94x/N
 mAvQw8JKlZxPa8ZTuH2pN4cSJ94LKGJZFESUn44YjYlarOpNq33rVVQiSNXBmIIjZpYs
 XF3A==
X-Gm-Message-State: AOJu0YyMNN1ymXASaNWb3tjow0Xja3CCd9ii9sIZIP/DpGZscN/YCbkI
 56oK4CeoEoy5/1t4RbxpyK7OFadK39H0hdZE5kQ=
X-Google-Smtp-Source: AGHT+IHOP3q3ewswTdoVHTs7X9urheRFQGBO1z862658MrTgG3q+z0mmbAMvSVtCPw7e90NcLH+haQ==
X-Received: by 2002:a05:600c:45c8:b0:402:ee67:45d1 with SMTP id
 s8-20020a05600c45c800b00402ee6745d1mr928521wmo.36.1694083824206; 
 Thu, 07 Sep 2023 03:50:24 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-226.abo.bbox.fr. [176.131.222.226])
 by smtp.gmail.com with ESMTPSA id
 y25-20020a7bcd99000000b0040210a27e29sm2141832wmj.32.2023.09.07.03.50.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Sep 2023 03:50:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] contrib/plugins/howvec: Fix string format
Date: Thu,  7 Sep 2023 12:50:02 +0200
Message-ID: <20230907105004.88600-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907105004.88600-1-philmd@linaro.org>
References: <20230907105004.88600-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

  plugins/howvec.c:186:40: warning: format specifies type 'long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                                         class->count);
                                         ^~~~~~~~~~~~
  plugins/howvec.c:213:36: warning: format specifies type 'long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                                     rec->count,
                                     ^~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 contrib/plugins/howvec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 0ed01ea931..644a7856bb 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -181,7 +181,8 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         switch (class->what) {
         case COUNT_CLASS:
             if (class->count || verbose) {
-                g_string_append_printf(report, "Class: %-24s\t(%ld hits)\n",
+                g_string_append_printf(report,
+                                       "Class: %-24s\t(%" PRId64 " hits)\n",
                                        class->class,
                                        class->count);
             }
@@ -208,7 +209,8 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
              i++, counts = g_list_next(counts)) {
             InsnExecCount *rec = (InsnExecCount *) counts->data;
             g_string_append_printf(report,
-                                   "Instr: %-24s\t(%ld hits)\t(op=0x%08x/%s)\n",
+                                   "Instr: %-24s\t(%" PRId64 " hits)"
+                                   "\t(op=0x%08x/%s)\n",
                                    rec->insn,
                                    rec->count,
                                    rec->opcode,
-- 
2.41.0


