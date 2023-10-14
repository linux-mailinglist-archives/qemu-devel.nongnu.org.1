Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0013D7C940D
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 12:06:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrbSw-0002Wq-RQ; Sat, 14 Oct 2023 06:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSt-0002Vf-EB
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSr-0003zn-SU
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697277705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iqQigo6rDRFhr9fYnayCGDlH/l/Bu25xII4fq1wfHbI=;
 b=LUO7+H3tDNa6zI0nzbuCwSP2OltUuQE59D2Qr2uBHoiT1J3me3nxquyPiAjiHqg4oz9VG1
 PI4+T706rAF+7ic4T2G+lVxAp6TwUP+v+f56XmSV9CZu/dxQ+iKqwS71gCag97U8jrPpPO
 IYkw+kUpAL0IvOqTaW2gU1/e9TPaaWo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-uZjSrZIsM_SeAU7gV3Opxw-1; Sat, 14 Oct 2023 06:01:43 -0400
X-MC-Unique: uZjSrZIsM_SeAU7gV3Opxw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9ae57d8b502so223119366b.2
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 03:01:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697277701; x=1697882501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iqQigo6rDRFhr9fYnayCGDlH/l/Bu25xII4fq1wfHbI=;
 b=GNz6Wf6tWo6oy4GR2kZ1p4bUGlxaSjtAVnjtxu8Lx0ORasgy6A5nN+mnvmbcrEkLgK
 knV3OmLtBMHV1/7ZauC5aAVo9NQzblzGm24b9MCaIesQqufMOS2FVUOvHJ9Fb1sfMPi1
 JGdbZomiTahJCCd1+Kl13ktfsfco/9o8Lx+PMljqyehoBIjgaOaLE+LM8DWiYh2+MpJD
 uaXSiy/MABHYgiTalplnotTxYOsqjWKyZPSBvFhqtIUMlBq277m/YU7chsjLZ9ewBv5e
 r/3XSms2HKJAFQAHD83csFZ3q23TOG4TtO3J6JbX4FjZk+4+g8YWAKOes8Lreu1C4QaC
 AbVw==
X-Gm-Message-State: AOJu0YyTxcmbInl9wOVc9JTu2rV/HpIAfPCg49ne/j2VBYumwlErMbXj
 WQi39npHuZWTUKT/dBODnH/N7+7dz4WMLpnUEcde8k3y/HrNAk+AhakSw0yLtjijXreE64a6yYD
 Ci6LLhWVnmbuan17iGOgulz+TrdXD287NcszqMixTWDTIv88D+GSYQJXfyKWcrluM6hll4I0isz
 g=
X-Received: by 2002:a17:907:1c9e:b0:9bd:f031:37b6 with SMTP id
 nb30-20020a1709071c9e00b009bdf03137b6mr2552616ejc.49.1697277701590; 
 Sat, 14 Oct 2023 03:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9GQqRAzDTyykB6tk3fPU935D2rwFP4vfNCsHoEqp/Oz8anxhIVoCBQFz1qToxrRxty7gWCg==
X-Received: by 2002:a17:907:1c9e:b0:9bd:f031:37b6 with SMTP id
 nb30-20020a1709071c9e00b009bdf03137b6mr2552597ejc.49.1697277701229; 
 Sat, 14 Oct 2023 03:01:41 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 lu9-20020a170906fac900b0099bcf9c2ec6sm722076ejb.75.2023.10.14.03.01.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 03:01:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/18] target/i386: reintroduce debugging mechanism
Date: Sat, 14 Oct 2023 12:01:12 +0200
Message-ID: <20231014100121.109817-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014100121.109817-1-pbonzini@redhat.com>
References: <20231014100121.109817-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc |  5 ++++-
 target/i386/tcg/translate.c      | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 01c46e6a789..fb95e0b9268 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1701,6 +1701,9 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
     X86DecodedInsn decode;
     X86DecodeFunc decode_func = decode_root;
 
+#ifdef CONFIG_USER_ONLY
+    if (limit) { --limit; }
+#endif
     s->has_modrm = false;
 
  next_byte:
@@ -1987,7 +1990,7 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         tcg_gen_mov_tl(cpu_cc_src, decode.cc_src);
     }
     if (decode.cc_src2) {
-        tcg_gen_mov_tl(cpu_cc_src, decode.cc_src2);
+        tcg_gen_mov_tl(cpu_cc_src2, decode.cc_src2);
     }
     if (decode.cc_srcT) {
         tcg_gen_mov_tl(s->cc_srcT, decode.cc_srcT);
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 39b5752e780..080b56840da 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2980,6 +2980,9 @@ static void gen_sty_env_A0(DisasContext *s, int offset, bool align)
     tcg_gen_qemu_st_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
 }
 
+static bool first = true;
+static unsigned long limit;
+
 #include "decode-new.h"
 #include "emit.c.inc"
 #include "decode-new.c.inc"
@@ -3134,15 +3137,39 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 
     prefixes = 0;
 
+    if (first) {
+        const char *env = getenv("QEMU_I386_LIMIT");
+        limit = env ? atol(env) : -1;
+        first = false;
+    }
+    bool use_new = true;
+#ifdef CONFIG_USER_ONLY
+    use_new &= limit > 0;
+#endif
+
  next_byte:
     s->prefix = prefixes;
     b = x86_ldub_code(env, s);
     /* Collect prefixes.  */
     switch (b) {
     default:
+#ifndef CONFIG_USER_ONLY
+        use_new &= b <= limit;
+#endif
+        if (use_new && 0) {
+            disas_insn_new(s, cpu, b);
+            return true;
+        }
         break;
     case 0x0f:
         b = x86_ldub_code(env, s) + 0x100;
+#ifndef CONFIG_USER_ONLY
+        use_new &= b <= limit;
+#endif
+        if (use_new && 0) {
+            disas_insn_new(s, cpu, b);
+            return true;
+        }
         break;
     case 0xf3:
         prefixes |= PREFIX_REPZ;
-- 
2.41.0


