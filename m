Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D19F381CE60
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:18:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4n-00014J-En; Fri, 22 Dec 2023 13:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4Y-0000zT-G4
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4W-0006CR-Q2
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ll8p9KevJakPI83ChSwjE8GB2f9xJT29V7JfVUV9WkI=;
 b=E/a5ITLEeqLrGDNVP3bOoWRyXM37Usbu5if6a4I+8Q2pPEyHOQycHhrPEVQf+pDU6JVrak
 QFS7jfMlijdlyI8YW4pNKbdSQS3VIWJ1kbE99FnoaPRhN/r4JffBa6TIZkFAur/FhlXkSz
 ZjLiyOR0i+mv0FiaUZk7tQMLOA1KO1I=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-_JMmTVmZNZmjmq0dp-qF6Q-1; Fri, 22 Dec 2023 13:16:29 -0500
X-MC-Unique: _JMmTVmZNZmjmq0dp-qF6Q-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50e316696d4so1648859e87.3
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268987; x=1703873787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ll8p9KevJakPI83ChSwjE8GB2f9xJT29V7JfVUV9WkI=;
 b=OHDp9eLiFK5tBquitFLxqSWX7O6qpt5pHRiXbTqDciIKI+kouf7jA+RZv3BYqFTb5I
 zgUFPqw2NvzeTGomteGV2vRKNhtX/izqDCC0yK6AnBMVT6fSOcXS436eK9Asjb84mxSp
 HHCiSYtpIFRkZV3gTHKPoZQKq8KpN3uYqb+EAQ9dgAH3uM30eAUmQK9lz8d4+yTkzNeZ
 tYZHSGWEFBJnaFOfhEPYzXkUdvHdOmvxXNKEFMABbrV+GRZL/Yvpx5+JHb8Vc5zv9X+5
 5oKBIU8ivVFR0hCPatvX1encAweyWQQOkrIsE+XTnaLuJ5fqpjkHrxL7sY0iT7C25jTz
 s8qw==
X-Gm-Message-State: AOJu0Yy3vDXJcLak1PonzYmNdUi3wLDpKD9IJs8DCYumx1mba7P0Xm48
 Wa19qqQETErdU3fhBqjFgNv28MB/ybiEBX/OL6Cg3r/V/phSBGb5H1AJ/SXF8QzI5Q/ga1wCcUj
 SAk88lyqR96+YtNf8eCzOGhYAclZxuvH2edsAsTZQNl/ChS1TBA9IHJFejAzGa5/iMw2QDCNXgh
 SkhTLq2PY=
X-Received: by 2002:ac2:5f68:0:b0:50e:67b0:6886 with SMTP id
 c8-20020ac25f68000000b0050e67b06886mr717864lfc.66.1703268987421; 
 Fri, 22 Dec 2023 10:16:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbASfux5lrWtkfJSTDMiy+yf930n+XylX7bvVBo3rE6NrZrHCQZp2jy50mjPNGHgxqLdDdqQ==
X-Received: by 2002:ac2:5f68:0:b0:50e:67b0:6886 with SMTP id
 c8-20020ac25f68000000b0050e67b06886mr717859lfc.66.1703268986934; 
 Fri, 22 Dec 2023 10:16:26 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 dx15-20020a170906a84f00b00a2363247829sm2270687ejb.216.2023.12.22.10.16.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/22] target/i386: do not decode string source/destination
 into decode->mem
Date: Fri, 22 Dec 2023 19:15:52 +0100
Message-ID: <20231222181603.174137-12-pbonzini@redhat.com>
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

decode->mem is only used if one operand has has_ea == true.  String
operations will not use decode->mem and will load A0 on their own, because
they are the only case of two memory operands in a single instruction.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index d7a86d96c0c..99d18d2871e 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1212,6 +1212,8 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
     case X86_TYPE_None:  /* Implicit or absent */
     case X86_TYPE_A:  /* Implicit */
     case X86_TYPE_F:  /* EFLAGS/RFLAGS */
+    case X86_TYPE_X:  /* string source */
+    case X86_TYPE_Y:  /* string destination */
         break;
 
     case X86_TYPE_B:  /* VEX.vvvv selects a GPR */
@@ -1346,24 +1348,6 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         op->n = insn_get(env, s, op->ot) >> 4;
         break;
 
-    case X86_TYPE_X:  /* string source */
-        op->n = -1;
-        decode->mem = (AddressParts) {
-            .def_seg = R_DS,
-            .base = R_ESI,
-            .index = -1,
-        };
-        break;
-
-    case X86_TYPE_Y:  /* string destination */
-        op->n = -1;
-        decode->mem = (AddressParts) {
-            .def_seg = R_ES,
-            .base = R_EDI,
-            .index = -1,
-        };
-        break;
-
     case X86_TYPE_2op:
         *op = decode->op[0];
         break;
-- 
2.43.0


