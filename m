Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B24707010
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:55:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLDZ-0006y2-19; Wed, 17 May 2023 13:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDS-0006mU-Qb
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDQ-0003zd-GT
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MVkYSUnOf9teWZaYW9AhoFuts4lEDIpBaOEEfStXpQ=;
 b=DYg9Fv7Bzp8nQr3wwbP8ilQUsxP++S9i+W/qtOXL65CfXNSFgTQ7Or4WxozSYAeP9nGQtq
 GgjM8LwZlW6e+m870oM/pVTGQjua2bdtvsdXdOJ2XnEJo9mwf/UwV+A6z5IC1imN9Kt4Yd
 EpdsnwpaWE1TiWD479KFwYhO5qcj1Ko=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-FrpbDyiTMDuftoLdOhDZvQ-1; Wed, 17 May 2023 13:45:29 -0400
X-MC-Unique: FrpbDyiTMDuftoLdOhDZvQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f518f2900eso7556255e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345528; x=1686937528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7MVkYSUnOf9teWZaYW9AhoFuts4lEDIpBaOEEfStXpQ=;
 b=OhMTQYRb0XbErM/bvQ1nwZcIvN6Hg9qWtHAtE3iAUHuSxPuWnFVfOQ9/ykj8+yPnNV
 AhbMor9PhFMiT/DNGiAH34Z5RWo88+8VnmrlV2PNud6fNxyWvGRzL0RncrCwVlsu+uBk
 fxOu5q3LSZzbTYRUzcFt/5TUupAcWRmVwod/A6GgdJMKSVSMqUEMVpYjPH9NdZdEwEx/
 6Tx7OKWjr01TyfaRW9ky3yFMNjxUqAxdFTN2d3AxlEnCyBWMDSvwlwqY452wZHECr99O
 yH/vu9LMJ63Y1lk+x5dqd5agTLYKY/CnEzcErLt6KtUvEkiP95omnps1rzI53yjy32bX
 6CPw==
X-Gm-Message-State: AC+VfDxfrFXfqpT2PuIbTpV2DMZOBD1L7ZvD9r6w3nF06OZE38n+Tltr
 Ao/hAMnRozUPTlAFHFg25HFo/1CHYWnb7q7tSGyab80saDqw4b7n8iqULGv6xI8LjgLVMyBfthm
 taIxCIFonSHjhQCFGiF36OQ4BA1O5SMWB2tfBayfPt8ypNXBoAL+lwn16WU23Oc5Y7/3fyKv3tq
 o=
X-Received: by 2002:a05:600c:2292:b0:3f4:fa56:3186 with SMTP id
 18-20020a05600c229200b003f4fa563186mr11219602wmf.14.1684345527903; 
 Wed, 17 May 2023 10:45:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ665wpEFu3tJO3ViabSJmCUrIOIU83WMF4eLyPNgi/7vIDToQ/EE/ZtGzRgbnUDWPZYzhXrsQ==
X-Received: by 2002:a05:600c:2292:b0:3f4:fa56:3186 with SMTP id
 18-20020a05600c229200b003f4fa563186mr11219584wmf.14.1684345527476; 
 Wed, 17 May 2023 10:45:27 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a05600c358400b003f1738d0d13sm3960075wmq.1.2023.05.17.10.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gabriele Svelto <gsvelto@mozilla.com>,
	qemu-stable@nongnu.org
Subject: [PULL 03/68] target/i386: fix operand size for VCOMI/VUCOMI
 instructions
Date: Wed, 17 May 2023 19:44:15 +0200
Message-Id: <20230517174520.887405-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Compared to other SSE instructions, VUCOMISx and VCOMISx are different:
the single and double precision versions are distinguished through a
prefix, however they use no-prefix and 0x66 for SS and SD respectively.
Scalar values usually are associated with 0xF2 and 0xF3.

Because of these, they incorrectly perform a 128-bit memory load instead
of a 32- or 64-bit load.  Fix this by writing a custom decoding function.

I tested that the reproducer is fixed and the test-avx output does not
change.

Reported-by: Gabriele Svelto <gsvelto@mozilla.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1637
Fixes: f8d19eec0d53 ("target/i386: reimplement 0x0f 0x28-0x2f, add AVX", 2022-10-18)
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 4fdd87750bea..48fefaffdf63 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -783,6 +783,17 @@ static void decode_0F2D(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
     *entry = *decode_by_prefix(s, opcodes_0F2D);
 }
 
+static void decode_VxCOMISx(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    /*
+     * VUCOMISx and VCOMISx are different and use no-prefix and 0x66 for SS and SD
+     * respectively.  Scalar values usually are associated with 0xF2 and 0xF3, for
+     * which X86_VEX_REPScalar exists, but here it has to be decoded by hand.
+     */
+    entry->s1 = entry->s2 = (s->prefix & PREFIX_DATA ? X86_SIZE_sd : X86_SIZE_ss);
+    entry->gen = (*b == 0x2E ? gen_VUCOMI : gen_VCOMI);
+}
+
 static void decode_sse_unary(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     if (!(s->prefix & (PREFIX_REPZ | PREFIX_REPNZ))) {
@@ -871,8 +882,8 @@ static const X86OpEntry opcodes_0F[256] = {
     [0x2B] = X86_OP_GROUP0(0F2B),
     [0x2C] = X86_OP_GROUP0(0F2C),
     [0x2D] = X86_OP_GROUP0(0F2D),
-    [0x2E] = X86_OP_ENTRY3(VUCOMI,     None,None, V,x, W,x,  vex4 p_00_66),
-    [0x2F] = X86_OP_ENTRY3(VCOMI,      None,None, V,x, W,x,  vex4 p_00_66),
+    [0x2E] = X86_OP_GROUP3(VxCOMISx,   None,None, V,x, W,x,  vex3 p_00_66), /* VUCOMISS/SD */
+    [0x2F] = X86_OP_GROUP3(VxCOMISx,   None,None, V,x, W,x,  vex3 p_00_66), /* VCOMISS/SD */
 
     [0x38] = X86_OP_GROUP0(0F38),
     [0x3a] = X86_OP_GROUP0(0F3A),
-- 
2.40.1


