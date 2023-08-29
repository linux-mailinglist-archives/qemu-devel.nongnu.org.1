Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1B178C9F8
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:54:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1y0-0002qa-Jh; Tue, 29 Aug 2023 12:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qb1xq-0002oZ-VE
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qb1xo-0002zh-F7
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693327991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kx+/IxthZgFSqxHugpKwjpq3kgNjgZILQXQCxotth7w=;
 b=elWScvfhFa9jKKs7pCAuR1EuMb27V9p5JfK0AL1+8HvWgcfTDi8lRRCgrA02vrn4nM7NS/
 EOCtAd9IcR8/MRz7jN4LSGPSsudEG1i67BmY2hADvw9M66ASUNjP9e5hfz07tklZXYhHhe
 mhbve419wqhDvwxQYvROG06S+DhFUsE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-eJfArkDAPVqI0RiV_kYrWw-1; Tue, 29 Aug 2023 12:53:10 -0400
X-MC-Unique: eJfArkDAPVqI0RiV_kYrWw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fef5403093so46945e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:53:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693327988; x=1693932788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kx+/IxthZgFSqxHugpKwjpq3kgNjgZILQXQCxotth7w=;
 b=SS9q6cwGJl45Gqc1c2a5IMBapXhE2tOyQiOWgCu5V61Ijq097ArEfDwoF8YSZD9CY9
 9yCwzxyJZ2fPvxF9Zuqxh6peywe9rbq+UNzKU3oFziWzRO1wYNAFevPkfo71N9AodB/6
 5n2AKT8aSd+tA+v0ls8QPwa9KOep5K6YWbjFH62K03vZlqyXn/ET+92pQK3uybZIchgZ
 P7Wj3auP2o4mF3qFLmkHkkKp+gGk55MSfySBQV6t27X2jM+gB9b28nlmbgbmFm/oX/PL
 BKaue1sDqu0z156uWne/7mmiIoBoDh6pASk5ZHoSo83WVJLTectTKoUn3h7ze2nY4yIj
 Ssiw==
X-Gm-Message-State: AOJu0YyIQetF1FyYvMON8mMz71VGvW2G1HEcWyCTLWLWU4aYsSq/HLI9
 VOM+xqh6Pyatgev/UuqtMBf88ZctuhTdFFxGRjXwA+a/6pWKDMnKJabIjufBnzuvYV+yDkT6kBV
 ik2Hq8ejrDVwEPtAp5lIX25TR8U8jav07dbweO10WImNvaPPfn8UQqMjVKRqqdhhN8sPL9ebstJ
 0=
X-Received: by 2002:a05:600c:1e06:b0:400:5962:6aa9 with SMTP id
 ay6-20020a05600c1e0600b0040059626aa9mr2499713wmb.11.1693327988209; 
 Tue, 29 Aug 2023 09:53:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGE1msqH428Q3JVgzqH/9FiNoZNM0bHPG3Z82e3Mmw8dgUlC6fxY7bVMRV5sc7yj9WkGfCheA==
X-Received: by 2002:a05:600c:1e06:b0:400:5962:6aa9 with SMTP id
 ay6-20020a05600c1e0600b0040059626aa9mr2499695wmb.11.1693327987818; 
 Tue, 29 Aug 2023 09:53:07 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a7bc7d3000000b003fe2b6d64c8sm12036818wmk.21.2023.08.29.09.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 09:53:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 1/2] target/i386: generalize operand size "ph" for use in
 CVTPS2PD
Date: Tue, 29 Aug 2023 18:53:03 +0200
Message-ID: <20230829165304.114948-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829165304.114948-1-pbonzini@redhat.com>
References: <20230829165304.114948-1-pbonzini@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

CVTPS2PD only loads a half-register for memory, like CVTPH2PS.  It can
reuse the "ph" packed half-precision size to load a half-register,
but rename it to "xh" because it is now a variation of "x" (it is not
used only for half-precision values).

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 6 +++---
 target/i386/tcg/decode-new.h     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 8f93a239ddb..43c39aad2aa 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -337,7 +337,7 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
     [0x07] = X86_OP_ENTRY3(PHSUBSW,   V,x,  H,x,   W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
 
     [0x10] = X86_OP_ENTRY2(PBLENDVB,  V,x,         W,x,  vex4 cpuid(SSE41) avx2_256 p_66),
-    [0x13] = X86_OP_ENTRY2(VCVTPH2PS, V,x,         W,ph, vex11 cpuid(F16C) p_66),
+    [0x13] = X86_OP_ENTRY2(VCVTPH2PS, V,x,         W,xh, vex11 cpuid(F16C) p_66),
     [0x14] = X86_OP_ENTRY2(BLENDVPS,  V,x,         W,x,  vex4 cpuid(SSE41) p_66),
     [0x15] = X86_OP_ENTRY2(BLENDVPD,  V,x,         W,x,  vex4 cpuid(SSE41) p_66),
     /* Listed incorrectly as type 4 */
@@ -565,7 +565,7 @@ static const X86OpEntry opcodes_0F3A[256] = {
     [0x15] = X86_OP_ENTRY3(PEXTRW,     E,w,  V,dq, I,b,  vex5 cpuid(SSE41) zext0 p_66),
     [0x16] = X86_OP_ENTRY3(PEXTR,      E,y,  V,dq, I,b,  vex5 cpuid(SSE41) p_66),
     [0x17] = X86_OP_ENTRY3(VEXTRACTPS, E,d,  V,dq, I,b,  vex5 cpuid(SSE41) p_66),
-    [0x1d] = X86_OP_ENTRY3(VCVTPS2PH,  W,ph, V,x,  I,b,  vex11 cpuid(F16C) p_66),
+    [0x1d] = X86_OP_ENTRY3(VCVTPS2PH,  W,xh, V,x,  I,b,  vex11 cpuid(F16C) p_66),
 
     [0x20] = X86_OP_ENTRY4(PINSRB,     V,dq, H,dq, E,b,  vex5 cpuid(SSE41) zext2 p_66),
     [0x21] = X86_OP_GROUP0(VINSERTPS),
@@ -1104,7 +1104,7 @@ static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp
         *ot = s->vex_l ? MO_256 : MO_128;
         return true;
 
-    case X86_SIZE_ph: /* SSE/AVX packed half precision */
+    case X86_SIZE_xh: /* SSE/AVX packed half register */
         *ot = s->vex_l ? MO_128 : MO_64;
         return true;
 
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index cb6b8bcf678..a542ec16813 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -92,7 +92,7 @@ typedef enum X86OpSize {
     /* Custom */
     X86_SIZE_d64,
     X86_SIZE_f64,
-    X86_SIZE_ph, /* SSE/AVX packed half precision */
+    X86_SIZE_xh, /* SSE/AVX packed half register */
 } X86OpSize;
 
 typedef enum X86CPUIDFeature {
-- 
2.41.0


