Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEC27CF5B0
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:50:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQZI-0007MT-HX; Thu, 19 Oct 2023 06:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYn-0006aM-OO
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYk-0006KC-Rr
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2h5Sv7Cu7V/LW3D5gdOyCZoMT0o3K+w+18w1QrPVYBc=;
 b=UHihQUMkCafDiYnmtlf4/QOsNMvkZCVLP81SScoF8UiBQOiAzmBw1k6eexKy2ehEC2bs9q
 UuTauyEVWcPc/W10NM8hQh3Z6dNh5qeiu11HJ6y/WjFT7oL+dNQV+Ehfw+iZGGVP65RkGB
 HzvFBPiDWlhOb/68xLPYWEsJmpAQNeo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-L-PeBuj9MD6kVU9IQ4_PZg-1; Thu, 19 Oct 2023 06:47:09 -0400
X-MC-Unique: L-PeBuj9MD6kVU9IQ4_PZg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-99c8bbc902eso582534566b.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712428; x=1698317228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2h5Sv7Cu7V/LW3D5gdOyCZoMT0o3K+w+18w1QrPVYBc=;
 b=ac83/hJ+JY7vkpqu0ORyxFDrkoBCdnI7gHr1YZLkiB+k0Dq4PYujEURiqL5JZkSWVg
 kwmvIx2bSlqKwd6LkR5fNDe3Ptn8QI2rhILOYWFaAiFwuYlW7BCsxgzYq3zbQ9uReUvj
 FB/mlhKa8Hwp4EglhfY5LpZtm0EgqBWF4rIZVkB2qGT4C/XbTLGcFgbX7ADcolfIwvHx
 tl4b0auCJKARLKD9GdjoMLrOSZ3DzaTzW2D8xBrxIozSO8qFzc66Gvt2Ia4Ztr33iu0b
 IynFcXl2aag52ZkAgrRk579Psa/uC/mXEl9aRh7/pJGpuYlbTYjNESDNsoAtERsHNfKt
 HZ8Q==
X-Gm-Message-State: AOJu0YxJHwoETPR52eR+MseSqJYUj83rgVc3rISj7PY3UixmWJQXK5ET
 OuRUad0U3/S7xrXqkLbgPYX3DX+ENn28SSXGZCPZpS9crtCejg4e3XGssMBcNn6vdUy5btWzm3r
 Xomn6dnlXzmWGctw8ugY7bshoRzchCXntQsGYaB4QarRI3WTGSaJvlw0fRWGPYOcVI6nSP+oHJm
 I=
X-Received: by 2002:a17:907:3687:b0:9bd:abb2:d4e0 with SMTP id
 bi7-20020a170907368700b009bdabb2d4e0mr1252294ejc.22.1697712428258; 
 Thu, 19 Oct 2023 03:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBVFybQp7/FeV2G23g8d4VfAqd5ePqmgdthsIHMoexueLuZnectdgYZacH2SpeMQbRpyjTpA==
X-Received: by 2002:a17:907:3687:b0:9bd:abb2:d4e0 with SMTP id
 bi7-20020a170907368700b009bdabb2d4e0mr1252285ejc.22.1697712427935; 
 Thu, 19 Oct 2023 03:47:07 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 w19-20020a17090652d300b009ae05f9eab3sm3268970ejn.65.2023.10.19.03.47.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:47:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/19] target/i386: reintroduce debugging mechanism
Date: Thu, 19 Oct 2023 12:46:39 +0200
Message-ID: <20231019104648.389942-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019104648.389942-1-pbonzini@redhat.com>
References: <20231019104648.389942-1-pbonzini@redhat.com>
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
 target/i386/tcg/decode-new.c.inc |  3 +++
 target/i386/tcg/translate.c      | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 57a5014bc8a..2f614e2a6f0 100644
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


