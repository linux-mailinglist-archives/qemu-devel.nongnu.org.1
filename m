Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0064A820A81
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:49:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrTe-00058c-HE; Sun, 31 Dec 2023 03:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSX-0004ij-EA
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSR-0000lt-1F
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dTjIvAkPLdtVRpHX22Ws7b3AAQ+o1Z6sne5FDLaVAl0=;
 b=WWSOrR5MJrAejZwCw9bNM2N/FBrk+V1JR3/mJbUfXg7f6at7cAyRIJgICOF664VlRJatB7
 uVv12dVi3QkEEfTkqBY46kUjAwi1JqIRgPuJmocsxLNx2/sHUXXjYYDlfJFTMmU2bw2DIm
 NMQFjHsD4xDB39Du/YwDiVjC2Sca3sE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-XSq4OsrlOPKOOg5SZVeGrg-1; Sun, 31 Dec 2023 03:46:04 -0500
X-MC-Unique: XSq4OsrlOPKOOg5SZVeGrg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a19c5cbbe86so447591566b.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012362; x=1704617162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dTjIvAkPLdtVRpHX22Ws7b3AAQ+o1Z6sne5FDLaVAl0=;
 b=qSq5mtkmALp7iGAUU0Gt89tR4+6b/+Bg6XDUPQMm4/xkzbJZEKC0Ugae/HgVJZ2XNZ
 6iowkttL0ZuBCki53RJk8wjKyaGfg1oD1RxC4Ajzgr60oetc1M+UcrejS/ATfCnH52Ez
 UXMwhlpDyUeKvvMHVJKsv3i0YThHszV9XjpBCiUcTQxtNv8trHOxHQoTn8nZaD5FP75J
 EwsdBG1LBB8gxysWPhMRlfLmGoqP+jACS5grg+rQ6pMmqdACH/BiP8yn5QJ5sLdmSE0h
 ygfrq9QM9oj4mGd42MVPOkb3rQzo+sXNP2oYQSNjls/Gd3cLbHPf3pPxJ1QMVEQbKntV
 8ljA==
X-Gm-Message-State: AOJu0Yx+KswMJIoI785QZVwvUfUkXOi09sdSDPWuq4KpcNmsDoMJbeUP
 dPTl/GuE650Rrx6KSTdAT/4Mz37UlYiJ+8qF6+tGft9a8qKE9qnP72yaUyJ3lRAAQwvBo9D3hKb
 cT2bkYL2/HpDaEy3JC3dDfl4a9OHklzoTrItiDpC+5E6WOMMZs6obAuV7JNMQckw3Zz+Ui0DKbf
 /E92U4lq8=
X-Received: by 2002:a17:906:7381:b0:a26:f62c:3ffa with SMTP id
 f1-20020a170906738100b00a26f62c3ffamr2925395ejl.118.1704012362798; 
 Sun, 31 Dec 2023 00:46:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPBZTYK2B97P9CvwYKJtbTG5cAI/Ve8ojvHh9bR8otKdFz0ndAgYkC67v5r8rCVILfmLh/Xw==
X-Received: by 2002:a17:906:7381:b0:a26:f62c:3ffa with SMTP id
 f1-20020a170906738100b00a26f62c3ffamr2925392ejl.118.1704012362521; 
 Sun, 31 Dec 2023 00:46:02 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 ew18-20020a170907951200b00a1dd58874b8sm9788265ejc.119.2023.12.31.00.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/46] target/i386: adjust decoding of J operand
Date: Sun, 31 Dec 2023 09:44:36 +0100
Message-ID: <20231231084502.235366-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

gen_jcc() has been changed to accept a relative offset since the
new decoder was written.  Adjust the J operand, which is meant
to be used with jump instructions such as gen_jcc(), to not
include the program counter and to not truncate the result, as
both operations are now performed by common code.

The result is that J is now the same as the I operand.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 99d18d2871e..f30889dbc0a 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1329,19 +1329,9 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         }
 
     case X86_TYPE_I:  /* Immediate */
-        op->unit = X86_OP_IMM;
-        decode->immediate = insn_get_signed(env, s, op->ot);
-        break;
-
     case X86_TYPE_J:  /* Relative offset for a jump */
         op->unit = X86_OP_IMM;
         decode->immediate = insn_get_signed(env, s, op->ot);
-        decode->immediate += s->pc - s->cs_base;
-        if (s->dflag == MO_16) {
-            decode->immediate &= 0xffff;
-        } else if (!CODE64(s)) {
-            decode->immediate &= 0xffffffffu;
-        }
         break;
 
     case X86_TYPE_L:  /* The upper 4 bits of the immediate select a 128-bit register */
-- 
2.43.0


