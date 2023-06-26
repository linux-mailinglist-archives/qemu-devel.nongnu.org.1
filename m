Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E5673DD14
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:16:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBn-0003Cj-6o; Mon, 26 Jun 2023 07:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBj-00034Q-MB
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBb-0000lq-IY
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJgCEvRIJfsZ4PHdwAsMys/JtM2LhLA5MowluJx/lzU=;
 b=N44+HnRq4DAtDlW9dbxudCSTaphe4CvmE1SWPfnF8rda0t/QyxmtOnEJK87Bfo1jLy+Pwz
 Wshor2W1YLZZTW1zPEXODztATe/4N+TAfBKftUHVgohEH/AxQmqy2eqmJ9xHsHLE6uvvWp
 HN/K26rOWahJ6OJEAzk/sEVVjbvsCvg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-PiE4wFQLN6yyhtkqvhk8BQ-1; Mon, 26 Jun 2023 07:15:08 -0400
X-MC-Unique: PiE4wFQLN6yyhtkqvhk8BQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3111e2620ebso1723108f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778106; x=1690370106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJgCEvRIJfsZ4PHdwAsMys/JtM2LhLA5MowluJx/lzU=;
 b=Vwk/gv3kKbQUidS2yOpjRZjk+aIDUMP45TaBSbpMl3qXSe4bRWFmnCavF4FnpAzbTZ
 6UTJZRAeqxlns/4KQ5+/jXYs1rZd/cR+BTM45gi7bEOqzebXx8bNk4mxtSP4IBNH/mcI
 4+DiY8z7We92LnN6Tnhhmmd7DeqAjkSolKkdahVUlskIXWX/rIfc2qRKbNqxti1Vu4Gv
 s2FcvF+9zWhbIxCboExRpWdzfN607LP+5hDh3HY9ON+dIFryv8RDomrh/NpzvO1UL2Nr
 Zg5sD4Xn+lZvo0/0uaOy2XUA96i0b+Y8Fv7HXdF5ssIxQDXpkEIYpkq9VCLmmPRXQmAz
 BzsA==
X-Gm-Message-State: AC+VfDxWugnMuD9rbkogaWRUGwHiSHD6uchRayaf/8oIlmEnEM2ZDMYO
 zPxY3giyPy/2z+C2KPsjWw2HgE6uOb9csCaGdLgF21a8cRteGD/ORoimTJKEQbW2At6gCv3R1zz
 MKcXH52ZWbU4Cirxh8nVQfc5YHvUtW6L216+WyDfH/qvoFQ2gZeQ7nJ42VM4Svq/aOwYjYaVSVI
 k=
X-Received: by 2002:adf:d092:0:b0:30f:c7e4:d207 with SMTP id
 y18-20020adfd092000000b0030fc7e4d207mr19297024wrh.61.1687778106458; 
 Mon, 26 Jun 2023 04:15:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6qOdT+nI6V0fEQg0VLH22pq1lAdqfkwzYit7wJxmudkjwSIXU0Sq72WR47C1cWdnUI59ZlsQ==
X-Received: by 2002:adf:d092:0:b0:30f:c7e4:d207 with SMTP id
 y18-20020adfd092000000b0030fc7e4d207mr19297010wrh.61.1687778106155; 
 Mon, 26 Jun 2023 04:15:06 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 z13-20020adfe54d000000b00313ee3e50c7sm3811532wrm.97.2023.06.26.04.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:15:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/18] target/i386: Intel only supports SYSCALL/SYSRET in long
 mode
Date: Mon, 26 Jun 2023 13:14:40 +0200
Message-ID: <20230626111445.163573-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626111445.163573-1-pbonzini@redhat.com>
References: <20230626111445.163573-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c           | 4 ++++
 target/i386/tcg/translate.c | 9 ++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 695e01582bf..978d24b5ec7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6238,6 +6238,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 *ecx |= 1 << 1;    /* CmpLegacy bit */
             }
         }
+        if (tcg_enabled() && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 &&
+            !(env->hflags & HF_LMA_MASK)) {
+            *edx &= ~CPUID_EXT2_SYSCALL;
+        }
         break;
     case 0x80000002:
     case 0x80000003:
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index b2e2dccb84f..ed4016f554b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -5692,7 +5692,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         break;
 #ifdef TARGET_X86_64
     case 0x105: /* syscall */
-        /* XXX: is it usable in real mode ? */
+        /* For Intel SYSCALL is only valid in long mode */
+        if (!LMA(s) && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1) {
+            goto illegal_op;
+        }
         gen_update_cc_op(s);
         gen_update_eip_cur(s);
         gen_helper_syscall(cpu_env, cur_insn_len_i32(s));
@@ -5702,6 +5705,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         gen_eob_worker(s, false, true);
         break;
     case 0x107: /* sysret */
+        /* For Intel SYSRET is only valid in long mode */
+        if (!LMA(s) && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1) {
+            goto illegal_op;
+        }
         if (!PE(s)) {
             gen_exception_gpf(s);
         } else {
-- 
2.41.0


