Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FAF737029
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBd6U-0003Ww-7B; Tue, 20 Jun 2023 11:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6S-0003WI-Jp
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6R-0007Sb-6b
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687274222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0HhDiWb58uRb84/9vQ3z2FaN86twOISs5asaxbq5Go=;
 b=S+lQNRyxUWMykdAn8tVf1SeMeqo0xx7Bop1s0roEmyNRXpJYC8zPTLiCI20N6eIa+xhHu+
 nE9ud/Odr+PZ/LQaNyTjMmCx0MkbZs0PthpuHItM7fAr/E/ksOcQEBjWhYsd1H9faGTJod
 x80G3I+WJlhFS846tvO2IVuxWWuCwZ8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-Py_C59JpMMuFzaKOe8sIoA-1; Tue, 20 Jun 2023 11:16:56 -0400
X-MC-Unique: Py_C59JpMMuFzaKOe8sIoA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a35b0d4ceso286802766b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274207; x=1689866207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c0HhDiWb58uRb84/9vQ3z2FaN86twOISs5asaxbq5Go=;
 b=QW9yWLZP3m1rm8XtzMlJ6yuMCoDpfTazvdMp4+/IsoZgmydrEDNHi4N5V9gihkzgle
 +jUhwtYks0/7cRSEgkbo4ogk30IZZDqPcerjr6Q64STV7ReA7ThNlNW2w5So+a53va1y
 iHGiuoE9lWmaHS98pyxxdfpU1UtrvJyH9hQX76cJEvR7Gkysf3BQZ+MQbArM6sye11DE
 5FdIZosKgnyV/Rlgk8/04ij3yUVuvPahlfoEmUlhUms2PeK+Mnk2Yy6fkHCAdE5d/cdk
 NKcXw1jFMoY/xfSrvZxakrl8fln1c8nIi9mp7OnSgqbnzN9EeWQqZaqgpqLCe2qM+Mdd
 WOgQ==
X-Gm-Message-State: AC+VfDxt7wY+lqrz3dpD+O+/8wE2YzyfE4ivzEce5GumAJA9foE9zXCV
 qfLEBcJ3V/sgZbv4/Z82t86ReuiH59DCPCvWv5DuAz9PxXXpXo6FZdYhaiO1XuZrwiIgwfUeyvy
 xwKpujJuUfA3MmmOIDp6aVM709GuQPiEG+RQYx3pEYV0/ILjH0P+tRym0DcXbARQ/tXl+4pDqMF
 A=
X-Received: by 2002:a17:907:9623:b0:988:9a65:eae6 with SMTP id
 gb35-20020a170907962300b009889a65eae6mr6016635ejc.38.1687274206969; 
 Tue, 20 Jun 2023 08:16:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6cNBXaFy1AGxGcyiME9jHSa4CXTCLvF+vUbGuQdiJuBYMKtOJTqWOuUUIPV0Wvxzpi6NxguA==
X-Received: by 2002:a17:907:9623:b0:988:9a65:eae6 with SMTP id
 gb35-20020a170907962300b009889a65eae6mr6016620ejc.38.1687274206694; 
 Tue, 20 Jun 2023 08:16:46 -0700 (PDT)
Received: from [192.168.1.72] ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.gmail.com with ESMTPSA id
 n19-20020a17090625d300b009890e402a6bsm1596903ejb.221.2023.06.20.08.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:16:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 06/10] target/i386: Intel only supports SYSCALL in long mode
Date: Tue, 20 Jun 2023 17:16:30 +0200
Message-Id: <20230620151634.21053-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620151634.21053-1-pbonzini@redhat.com>
References: <20230620151634.21053-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c           | 4 ++++
 target/i386/tcg/translate.c | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

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
index 89df7bb528a..9aec7ec8288 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -5684,7 +5684,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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
-- 
2.40.1


