Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB9581CE56
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:17:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4q-00017T-Ps; Fri, 22 Dec 2023 13:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4o-00015l-1V
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4l-0006Ee-L2
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703269007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dTjIvAkPLdtVRpHX22Ws7b3AAQ+o1Z6sne5FDLaVAl0=;
 b=jHzJoKGV4z3F2beaa1dRr6bXbs7pmsnYFQAvoBe73GA9dPDGQoV+Omcnoe8ac/9lfy7sw/
 +0e43Nfb2BUVT806BlgvJuNaePID5Edx5kDAZITGBmeM7zYB4Fv7/GFKw6CtONlY3udcax
 kHFnoeIpgD5rO8RF/UkTEhJDFUSlrqg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-Uf5yIsvaNX-A9czPd-XCyw-1; Fri, 22 Dec 2023 13:16:45 -0500
X-MC-Unique: Uf5yIsvaNX-A9czPd-XCyw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2336545b23so115030866b.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703269004; x=1703873804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dTjIvAkPLdtVRpHX22Ws7b3AAQ+o1Z6sne5FDLaVAl0=;
 b=KiPHtRXnQRSypuR9yWejL9kRyoq/Yrc1TdX6F0HnTAWUIBnNwXb8eK8H+nDXqXpsON
 IgSxPjUvGwFz7LtpOMXh5izf1nB5gOpBgde4F3DmUDH/S4HlfK7sroNr1QVeYoJf7gze
 pa2dZNla2Ffby74gL4HddFoeuhZGgu49+rH6+8tdoQ5yEEtvbd3wo7f04z/GzmqOnP/e
 pESAz4bqik3f9z+kCnG420H2fXZAU81n9WdTzeYuEmNWDZqWsjhTijomGi73WaroyCg/
 bIRlTJxwTJeLE2aNQL12kF98ZqAoD8rjQ0kFUIzhKvSi+6H55AcnXM8x18hXNCwVfIGI
 ywfA==
X-Gm-Message-State: AOJu0YyC56PL+352YgMFdMV07BI/1bWKcjBo7RMbR8E02lQaS0zfJ+Eb
 si3Fyd723auScYggso4OBr0SWGMuOf3S9EGZ4rWtBpXTtOxiQhGa+CCNm395VeLMD5cbfF+an4e
 doihfY9IyHcBrvleCtbCv/abZ9dvyn6RDVFcyjJGqF7xkbaoVr1Vq+VShZh+oC2FId/QsP9oH8e
 g0rr+IRIs=
X-Received: by 2002:a50:d50f:0:b0:552:e43d:cc7c with SMTP id
 u15-20020a50d50f000000b00552e43dcc7cmr1252329edi.16.1703269003954; 
 Fri, 22 Dec 2023 10:16:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExM9XeS34tMLAYfJm/UwgDf5Z6oYpkKGwWVDjfYJFjnEzEyVHBKgW9xORbT9887beB1uhx7A==
X-Received: by 2002:a50:d50f:0:b0:552:e43d:cc7c with SMTP id
 u15-20020a50d50f000000b00552e43dcc7cmr1252322edi.16.1703269003560; 
 Fri, 22 Dec 2023 10:16:43 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a50fe85000000b0054cb88a353dsm2850195edt.14.2023.12.22.10.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:42 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 20/22] target/i386: adjust decoding of J operand
Date: Fri, 22 Dec 2023 19:16:01 +0100
Message-ID: <20231222181603.174137-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222181603.174137-1-pbonzini@redhat.com>
References: <20231222181603.174137-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
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


