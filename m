Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42467758D1F
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 07:30:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLzko-0002zA-GQ; Wed, 19 Jul 2023 01:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qLzkh-0002yj-GL; Wed, 19 Jul 2023 01:29:31 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qLzkf-0003WU-Qn; Wed, 19 Jul 2023 01:29:31 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3487d75e4c5so20490765ab.0; 
 Tue, 18 Jul 2023 22:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689744567; x=1692336567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=BetQAi4Kgo9qw84/AJp0GPgPwc6E5Envqce3B3ENuT8=;
 b=hWuLuIrSx4zLsj+p0iUaogxNiTYzl7jbM0VbFnzHnp/Nwr5ZVdig5KW1OjqcnovwaU
 4pUtOIwBlUUSeiDcrsJfIjrCMNVlQZB9ywlJSRp1wRQCamZ9TY/II5vsF1sJVO0fzli2
 tqcvQ2G9TfPv2FXBkLJiSbQyCVntW5/EJeHoYUAJXXXxuBnOIyHUMpMwJF8tsR4ZpIIP
 awq1pulXkzrVmqV/6hf7FdJMQtMnYQgg19pc2WxKOv/z5caVIiXCvkNzj/69tgHA+j39
 tcmKhftZSkNhTpo5E0+8E06xu1QoXaSMH1AMNin53xX6FvjjGhNIlStup0RmtL/f2ipJ
 ODbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689744567; x=1692336567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BetQAi4Kgo9qw84/AJp0GPgPwc6E5Envqce3B3ENuT8=;
 b=BmJYlqrDES1KR9HGTtLut/ahKo4hcutBbAZ0sxudmbbe+zwBeI0x4J5ys3+8GZMmuG
 2hbDRsFPZ9JCAUvCgxY4hXIEg8ykMLbZ2EqHOmwlAfT26pmMF/ZUN41EVnGcQYClpc+d
 KBGHtyfrIAvbRCGWgjhzljltsz6sleE5dFkwQhf9q3Z4E+JWnKmy4WeulpxRp26Ub9ho
 QS9/WZkY625EQvj9oy9yhUdNI9G9wEOAxK5WQlgQMMyzUl73GbMNxElq9aWEbiCwv8CZ
 1hnhc0R8mV2s1ns3YD1j2cvAgIxWI+7emCfVmxqfGo99S6MXgeB2loAWf8vaB9lW5CLd
 W/zw==
X-Gm-Message-State: ABy/qLYZ8zov9l4Ufb/JRFBQJwqPjJBu8LW4uP/2UEB5L+lF5hUNTZnc
 hipqLh3jG3fRBtUFjjS2Te0=
X-Google-Smtp-Source: APBJJlEASijRMTaZPy5dIHY+x7rOyRs0OX2UWnVbfRU9cYUI5pMMSPp638S8P2rFQDyzvrAtvQGfPg==
X-Received: by 2002:a92:c568:0:b0:348:8da5:a53c with SMTP id
 b8-20020a92c568000000b003488da5a53cmr5182874ilj.22.1689744567401; 
 Tue, 18 Jul 2023 22:29:27 -0700 (PDT)
Received: from voyager.lan ([45.124.203.19]) by smtp.gmail.com with ESMTPSA id
 27-20020a17090a005b00b00263c8b33bcfsm476322pjb.14.2023.07.18.22.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 22:29:26 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] ppc: Add stub implementation of TRIG SPRs
Date: Wed, 19 Jul 2023 14:59:20 +0930
Message-Id: <20230719052920.162673-1-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=joel.stan@gmail.com; helo=mail-il1-x12b.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Linux sets these to control cache flush behaviour on Power9. Supervisor
and hypervisor are allowed to write, and reads are noops.

Add implementations to avoid noisy messages when booting Linux under the
pseries machine with guest_errors enabled.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 target/ppc/cpu.h      |  2 ++
 target/ppc/cpu_init.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 25fac9577aa4..6826702ea658 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1897,7 +1897,9 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_PSSCR             (0x357)
 #define SPR_440_INV0          (0x370)
 #define SPR_440_INV1          (0x371)
+#define SPR_TRIG1             (0x371)
 #define SPR_440_INV2          (0x372)
+#define SPR_TRIG2             (0x372)
 #define SPR_440_INV3          (0x373)
 #define SPR_440_ITV0          (0x374)
 #define SPR_440_ITV1          (0x375)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 02b7aad9b0e3..3b6ccb5ea4e6 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5660,6 +5660,16 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_tfmr, &spr_write_tfmr,
                  0x00000000);
+    spr_register_hv(env, SPR_TRIG1, "TRIG1",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_access_nop, &spr_write_generic,
+                 &spr_access_nop, &spr_write_generic,
+                 0x00000000);
+    spr_register_hv(env, SPR_TRIG2, "TRIG2",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_access_nop, &spr_write_generic,
+                 &spr_access_nop, &spr_write_generic,
+                 0x00000000);
 #endif
 }
 
-- 
2.40.1


