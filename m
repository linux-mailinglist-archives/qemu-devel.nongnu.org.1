Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C29B97CF59F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:48:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQZF-00079a-Qw; Thu, 19 Oct 2023 06:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYv-0006bv-GH
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYu-0006c5-1i
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fy633mC5t4qXfpOf5yp7kSxDtLSJN2IR1Rkjsh86ZrY=;
 b=NXO5bIGIe67BmCT8YCkvlREwUB0vY47B56ZtWfkv9aRjOt5/0yqUG9K79cQt9Tw783KV9i
 RkhR+FmEmeWm9671CeeXmvnMmv1JxxzoxUnDOzi4J55bcIKEhMXehi/S40MdVmVqJhXXvp
 Pa+GXHbBPfOp4hunLv9raC1TYKjTVQ8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-cycq79nINimX2u7QLm0ETQ-1; Thu, 19 Oct 2023 06:47:12 -0400
X-MC-Unique: cycq79nINimX2u7QLm0ETQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9c7558b7b85so84309766b.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712431; x=1698317231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fy633mC5t4qXfpOf5yp7kSxDtLSJN2IR1Rkjsh86ZrY=;
 b=o1PxplsVDnRtws9oVB6nIVmrw8eJm1jkLfl61O4AiWMg5UTJtEXVNvPv+IUp+wEznD
 hGZAQ0245Sj2rRkQsDKxInFSnAJZoPYrB4Y2hH6utvmI8htgFtZ4D4QyjvfcNAdrky8V
 Bvwz+9PYeWe6nKtVsqb3Fbh5TmgEJyHy0FmzIUwkH6zviF4ZZ7k9seZanVJ7/zG3kqqH
 jxvSuH3homUvDwX4dY6aEUONOMqhS7x1lsyQAC9RxLMUzkon8JRm38lEybUog0Q/tl/J
 LIKcAQ4JzaAv8M6Kh6/C1IIb1irluo/iXu9q5UIO/3U5mWkbF+YHbpUiWOTqi7+UGi/I
 Inmw==
X-Gm-Message-State: AOJu0YyyOy8lugj3hUEeqfxB53UoqZnx2wOORFGtoEQIVfeq65QA49Ne
 QNPwV+9yZQNolTb1YQLTe1DrDPff+VCLbcdKXQUb7RpA6trWxg6RlEZpQW9zYqWqEZrhg4bDHzj
 B8sjhV3mPWex+/WUWz61+0smXgrkErOmuauJvZci1bJsrEdNExdpAo5yONfoR/NwB394pim+rN0
 g=
X-Received: by 2002:a17:907:8687:b0:9c5:2806:72e9 with SMTP id
 qa7-20020a170907868700b009c5280672e9mr1301409ejc.34.1697712431186; 
 Thu, 19 Oct 2023 03:47:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpEQrhV/lHhwRF69vtx+BLWaN+KOLDcBmnEjGIWts4P+3KMlPKTaSIXlUoHUIudXB2kyrbnQ==
X-Received: by 2002:a17:907:8687:b0:9c5:2806:72e9 with SMTP id
 qa7-20020a170907868700b009c5280672e9mr1301398ejc.34.1697712430909; 
 Thu, 19 Oct 2023 03:47:10 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 s4-20020a170906c30400b009b65a698c16sm3245790ejz.220.2023.10.19.03.47.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:47:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/19] target/i386: adjust decoding of J operand
Date: Thu, 19 Oct 2023 12:46:41 +0200
Message-ID: <20231019104648.389942-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019104648.389942-1-pbonzini@redhat.com>
References: <20231019104648.389942-1-pbonzini@redhat.com>
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

gen_jcc() has been changed to accept a relative offset since the
new decoder was written.  Adjust the J operand, which is meant
to be used with jump instructions and gen_jcc(), to not
include the program counter and to not truncate the result, as
both operations are now performed by common code.

The result is that J is now the same as the I operand.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index dc596ba9f7a..1ae731459b7 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1448,19 +1448,9 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
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
2.41.0


