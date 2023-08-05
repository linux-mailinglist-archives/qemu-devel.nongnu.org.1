Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7318B7711DA
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 21:40:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSN6t-00014U-8C; Sat, 05 Aug 2023 15:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSN6q-00013f-NP; Sat, 05 Aug 2023 15:38:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSN6p-0007GU-3U; Sat, 05 Aug 2023 15:38:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B76A918647;
 Sat,  5 Aug 2023 22:38:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 91E521BA3F;
 Sat,  5 Aug 2023 22:38:13 +0300 (MSK)
Received: (nullmailer pid 69545 invoked by uid 1000);
 Sat, 05 Aug 2023 19:38:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matt Borgerson <contact@mborgerson.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 44/44] target/i386: Check CR0.TS before enter_mmx
Date: Sat,  5 Aug 2023 22:38:07 +0300
Message-Id: <20230805193811.69490-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230805210608@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230805210608@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Matt Borgerson <contact@mborgerson.com>

When CR0.TS=1, execution of x87 FPU, MMX, and some SSE instructions will
cause a Device Not Available (DNA) exception (#NM). System software uses
this exception event to lazily context switch FPU state.

Before this patch, enter_mmx helpers may be generated just before #NM
generation, prematurely resetting FPU state before the guest has a
chance to save it.

Signed-off-by: Matt Borgerson <contact@mborgerson.com>
Message-ID: <CADc=-s5F10muEhLs4f3mxqsEPAHWj0XFfOC2sfFMVHrk9fcpMg@mail.gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit b2ea6450d8e1336a33eb958ccc64604bc35a43dd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index c2ee712561..ee4f4a899f 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1815,16 +1815,18 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         }
         break;
 
-    case X86_SPECIAL_MMX:
-        if (!(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA))) {
-            gen_helper_enter_mmx(cpu_env);
-        }
+    default:
         break;
     }
 
     if (!validate_vex(s, &decode)) {
         return;
     }
+    if (decode.e.special == X86_SPECIAL_MMX &&
+        !(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA))) {
+        gen_helper_enter_mmx(cpu_env);
+    }
+
     if (decode.op[0].has_ea || decode.op[1].has_ea || decode.op[2].has_ea) {
         gen_load_ea(s, &decode.mem, decode.e.vex_class == 12);
     }
-- 
2.39.2


