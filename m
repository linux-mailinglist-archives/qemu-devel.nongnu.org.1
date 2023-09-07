Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E017972BF
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:14:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEce-0002e5-Mh; Thu, 07 Sep 2023 09:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcV-0002aq-8f
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcR-0006qI-7q
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r1WiRlJzYZgG+NP4gVjTCKyvNr2I9p2YQt4qg2aGfx4=;
 b=acYtVB7sK6Jk/ZKDZ2rBRfv2ptoIULCiO5B9qRtaU3QC8oZrbrhwk93PzdDE8pDyNYwFYJ
 EO/y4ffz+OydgfWOCZ2+lAR4py4NQFULZVOmPJlE5B9dwt0pHeW8BrMYjfgwajxLBet1Wo
 dmC1gYf+E4Txf4mWqf2e5Mrd7JI1c2I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-dpoSJq-JOTCfzv_OeIIV7A-1; Thu, 07 Sep 2023 09:00:18 -0400
X-MC-Unique: dpoSJq-JOTCfzv_OeIIV7A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fd0fa4d08cso6208175e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091615; x=1694696415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r1WiRlJzYZgG+NP4gVjTCKyvNr2I9p2YQt4qg2aGfx4=;
 b=lN87glX9ezDzZFS3bas896pYAbeXuszJRW1Up0t+K4tgkpb6JXjFGhcyxxB++wG6UM
 sj1d6Y13uQrH1j0K1iS32nudCiG9jODGys37p8n/xS5lL1F10J7HSo36cRX6Zms93Bl2
 B7DZ2Id4ofIzOxhXMq39E2wipQMB2IoEcjYsVj+r5R8co/RemcaBXpYgWSgQtxYWh7Rh
 sz9r4egJB6hTvgWtmuIL/7xgGcd7BQc6RpsowBBTxNy1frJ4FdEcIyrS8bX8VAs5yaD4
 em5Lm4nP7gNZO0z4qwA2OB7qtE8K3qqb7v8RTy838Lg0fg0hnkJmEUIqjFZKxq5cR52Z
 /dTw==
X-Gm-Message-State: AOJu0YyADDFxJ+Giu9pKmsUTxedFpySMahjy3/JeQLceIK0+ZVfhv6EP
 +w07HgTfD9LivVUaNm9Lm4kMn5JiNyOHtok9qdI3ccYtvsrZkqbPGP0Us5Dh1FE+AODwdqaA5Bi
 hUW0WSpF7CxjDItYNJeuxFm3Tyy7Iockpa1oA/q+KAt0+DPpf2TCoSxKekukJTcQzSX03Qv5/Vk
 I=
X-Received: by 2002:a05:600c:2611:b0:3fb:c9f4:150e with SMTP id
 h17-20020a05600c261100b003fbc9f4150emr4743507wma.14.1694091615671; 
 Thu, 07 Sep 2023 06:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY4Hv6i5KrkVX/L2Dyf6KIrlREB+gvwkgSJk5WvDgFnHoBA6gtaciGl+vQDXLkHkoccvehcg==
X-Received: by 2002:a05:600c:2611:b0:3fb:c9f4:150e with SMTP id
 h17-20020a05600c261100b003fbc9f4150emr4743489wma.14.1694091615206; 
 Thu, 07 Sep 2023 06:00:15 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a05600c0b4900b003fe2b081661sm2457077wmr.30.2023.09.07.06.00.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/51] target/i386: generalize operand size "ph" for use in
 CVTPS2PD
Date: Thu,  7 Sep 2023 14:59:12 +0200
Message-ID: <20230907130004.500601-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

CVTPS2PD only loads a half-register for memory, like CVTPH2PS.  It can
reuse the "ph" packed half-precision size to load a half-register,
but rename it to "xh" because it is now a variation of "x" (it is not
used only for half-precision values).

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


