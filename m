Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0C0797194
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 12:51:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeCaq-000069-KM; Thu, 07 Sep 2023 06:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeCan-00005y-Tu
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:50:33 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeCal-0004n8-Kh
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:50:33 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31c63cd4ec2so814594f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 03:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694083830; x=1694688630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7e245FoK5q01LB4PXDdn1jGxm+SXz3DlMpzLfK1cumM=;
 b=NcvG9ysuIlePKppQnCP/t9NVOP8XESAWpsRtmDEV//GQFF0fTmeV+p9gqHx+yW5y7C
 B/wHmASZqQ+nhUx02P33s4Dxqx8HpFSSqYCkisqyREc8M9pPFxO0u6MXXveuCw48d1Oq
 Li2Jdux8tWOE5hysOwj1sQt06/V8AzLFQPkGu9roT7eyLkDADH9rwiBKqQ7sbpwxzc17
 hhBs/ACInUZnLNxE9TEezKuZ3tUSEoUQBnA1RZenjRQ3GsjEj1bmOJzUpk6usHncTvg/
 xEZXcNRpRpIttHK1YIY+AK3UiC56FXtVyBT7IMJouHHdrziJKlcHilL++HkXDbwwz3Vv
 mW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694083830; x=1694688630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7e245FoK5q01LB4PXDdn1jGxm+SXz3DlMpzLfK1cumM=;
 b=hZ7ine9pSzS+fcvO29zLRwERTZ7KWGOeR0EjBaNMxbviycAWryRlwCGy8eFbUeVAxM
 8L2kwG4wyq7YTQyEE1WgPtF6fepnUj56uiAuBLzyL0EbQBlqMUhkgq76D2M0BgxAecwy
 vI9onJl8bGQG05XEqjNjfGj/b5tvlCVNdcLaaEwaRRbESwXtCQi23bjwOryA7pRhR7Da
 jLGPqCqhMPbv8B55f07zxRRJoOdud+udnXSFgSgyWDbRPu4DnfoXNND+UPRaVoXQYs6K
 lGY+3J3iycBn6tBJNXs5QBp/IpQ9185Vbs4Kp+ICNPk5krGm32S/8aFxssZSOQ2oL/99
 i7ig==
X-Gm-Message-State: AOJu0YxWXIQhTzONsVrRuGHnW8/EmSXK1sEUb9HiZlxz3evMV35S26MP
 95xqIm1lxhpgkO5jrjtoNWP7ZGRUA24gsnGl09s=
X-Google-Smtp-Source: AGHT+IHHvfxnh9YBYW/P3+n0lRVBUYzCo/J6erwI8C3NYvA/0nS4qoqWiCb1DtwbDmrtw15+aePvvg==
X-Received: by 2002:a5d:4246:0:b0:31a:dc58:cdd9 with SMTP id
 s6-20020a5d4246000000b0031adc58cdd9mr4297383wrr.60.1694083830003; 
 Thu, 07 Sep 2023 03:50:30 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-226.abo.bbox.fr. [176.131.222.226])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a056000137400b003142c85fbcdsm23103720wrz.11.2023.09.07.03.50.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Sep 2023 03:50:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] contrib/plugins/lockstep: Fix string format
Date: Thu,  7 Sep 2023 12:50:03 +0200
Message-ID: <20230907105004.88600-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907105004.88600-1-philmd@linaro.org>
References: <20230907105004.88600-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

  plugins/lockstep.c:138:25: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                          us->pc, them->pc, g_slist_length(divergence_log),
                          ^~~~~~
  plugins/lockstep.c:138:33: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                          us->pc, them->pc, g_slist_length(divergence_log),
                                  ^~~~~~~~
  plugins/lockstep.c:148:25: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                          us->pc, us->insn_count, them->pc, them->insn_count);
                          ^~~~~~
  plugins/lockstep.c:148:49: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                          us->pc, us->insn_count, them->pc, them->insn_count);
                                                  ^~~~~~~~
  plugins/lockstep.c:156:36: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                                     prev->block->pc, prev->block->insns,
                                     ^~~~~~~~~~~~~~~
  plugins/lockstep.c:156:53: warning: format specifies type 'long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                                     prev->block->pc, prev->block->insns,
                                                      ^~~~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 contrib/plugins/lockstep.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 850f7b2941..682b11feb2 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -134,7 +134,9 @@ static void report_divergance(ExecState *us, ExecState *them)
 
     /* Output short log entry of going out of sync... */
     if (verbose || divrec.distance == 1 || diverged) {
-        g_string_printf(out, "@ 0x%016lx vs 0x%016lx (%d/%d since last)\n",
+        g_string_printf(out,
+                        "@ 0x%016" PRIx64 " vs 0x%016" PRIx64
+                        " (%d/%d since last)\n",
                         us->pc, them->pc, g_slist_length(divergence_log),
                         divrec.distance);
         qemu_plugin_outs(out->str);
@@ -144,7 +146,9 @@ static void report_divergance(ExecState *us, ExecState *them)
         int i;
         GSList *entry;
 
-        g_string_printf(out, "Δ insn_count @ 0x%016lx (%ld) vs 0x%016lx (%ld)\n",
+        g_string_printf(out,
+                        "Δ insn_count @ 0x%016" PRIx64
+                        " (%ld) vs 0x%016" PRIx64 " (%ld)\n",
                         us->pc, us->insn_count, them->pc, them->insn_count);
 
         for (entry = log, i = 0;
@@ -152,7 +156,8 @@ static void report_divergance(ExecState *us, ExecState *them)
              entry = g_slist_next(entry), i++) {
             ExecInfo *prev = (ExecInfo *) entry->data;
             g_string_append_printf(out,
-                                   "  previously @ 0x%016lx/%ld (%ld insns)\n",
+                                   "  previously @ 0x%016" PRIx64 "/%" PRId64
+                                   " (%ld insns)\n",
                                    prev->block->pc, prev->block->insns,
                                    prev->insn_count);
         }
-- 
2.41.0


