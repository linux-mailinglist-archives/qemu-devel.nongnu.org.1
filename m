Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF29681CE54
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:17:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4q-00016k-6s; Fri, 22 Dec 2023 13:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4h-00012Q-0G
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4e-0006DS-Mo
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z6I5ERZQ1yG8vEhBxW0HwPCUf3bsKl1KO3xi3tzLK34=;
 b=C/a1h3GqdGTrkxOJVT/Q7vHtpdHtxNU9gl9/rrurydHoPy/vSSjWD3JaXnkf9USN22Wb/8
 eISlrXOBQL7SuFHNI9Jkg7qtTH9SUij+2Zx4dtIBrN1nb1/ZbS82rlCWYRbxqN50o2FKMh
 Vw4IOHC2UV1CRSOClqagi4HTs2w+aek=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-rMXa_RrPM6imbq1wS9bsog-1; Fri, 22 Dec 2023 13:16:38 -0500
X-MC-Unique: rMXa_RrPM6imbq1wS9bsog-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-54554ea191bso1015310a12.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268996; x=1703873796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z6I5ERZQ1yG8vEhBxW0HwPCUf3bsKl1KO3xi3tzLK34=;
 b=iu9i7Uq7PycCZSzxPHkK7b7iSwM+5EYIEGkaEb4uXzOIVyEsp4xp8m3EsR+0yIV0Ei
 SxpFY3ObEygpeDOu5Db/yZ9dOOPz2gOUd202owVBiLFM5kXx71+0NvyUNgG2RdYjcZdI
 v/t0zi6Bt4D9hMF3pdQtKX0BG17D4T8dKtGwer6g3Pwdf+dnnR16cGSZHdWlkdbWXMpr
 pi1gfZallQyxYtmCc8+NINpvKRfMs8NPymhSJ2GypKGUxPMOQQsR2Vu6L4S0kFVXGz75
 9iU1S8qkkxr7kZBPViSdRHbig9XDslJxU5cWF5JDXH+Zm0ypz/60QHzkPNtzHxdeiOs1
 bweA==
X-Gm-Message-State: AOJu0Yww4AZlN7ThBUboLQgmGRK7OOUQd3sYTDeJcjeMk1JbBU2+MAVj
 aUlY8TfxPNZiKXSL4vFD4DqaeDTUHhyJWyayyzLl5zh9RHePQSDiYvoZSH2VPAZzLhnL5i3UIFe
 psq/miY4zP5OuZlA9XgLSo6jhgomRCJiZzTOB7c2EYQjP7jFKiDjORLZOKJwWvqOrZgBOZlnPs+
 55d+gFwqs=
X-Received: by 2002:a50:c119:0:b0:554:5cfc:766b with SMTP id
 l25-20020a50c119000000b005545cfc766bmr607114edf.0.1703268996535; 
 Fri, 22 Dec 2023 10:16:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGex9hC8E3cJ8WXY9wf5YvG3QSNSjFUYFj5gDpPEufGSM/ShuJCd227ftJfn3azApz2YbGecg==
X-Received: by 2002:a50:c119:0:b0:554:5cfc:766b with SMTP id
 l25-20020a50c119000000b005545cfc766bmr607109edf.0.1703268996221; 
 Fri, 22 Dec 2023 10:16:36 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 ij14-20020a056402158e00b00554368c9ce8sm1997662edb.1.2023.12.22.10.16.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/22] target/i386: do not use s->tmp0 for jumps on ECX ==/!= 0
Date: Fri, 22 Dec 2023 19:15:57 +0100
Message-ID: <20231222181603.174137-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222181603.174137-1-pbonzini@redhat.com>
References: <20231222181603.174137-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Create a new temporary, to ease the register allocator's work.

Creation of the temporary is pushed into gen_ext_tl, which
also allows NULL as the first parameter now.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index afe0fa6c65f..e5f71170967 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -720,6 +720,9 @@ static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
     if (size == MO_TL) {
         return src;
     }
+    if (!dst) {
+        dst = tcg_temp_new();
+    }
     tcg_gen_ext_tl(dst, src, size | (sign ? MO_SIGN : 0));
     return dst;
 }
@@ -736,9 +739,9 @@ static void gen_exts(MemOp ot, TCGv reg)
 
 static void gen_op_j_ecx(DisasContext *s, TCGCond cond, TCGLabel *label1)
 {
-    tcg_gen_mov_tl(s->tmp0, cpu_regs[R_ECX]);
-    gen_extu(s->aflag, s->tmp0);
-    tcg_gen_brcondi_tl(cond, s->tmp0, 0, label1);
+    TCGv tmp = gen_ext_tl(NULL, cpu_regs[R_ECX], s->aflag, false);
+
+    tcg_gen_brcondi_tl(cond, tmp, 0, label1);
 }
 
 static inline void gen_op_jz_ecx(DisasContext *s, TCGLabel *label1)
-- 
2.43.0


