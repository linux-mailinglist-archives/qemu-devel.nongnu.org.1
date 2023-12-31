Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DFF820A8C
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:51:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrSK-0004WK-TD; Sun, 31 Dec 2023 03:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSH-0004GM-ID
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrS7-0000k0-H2
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBqfFBgY7aStWUgLumJkflj7wgYc5m8HW3cOyukrRFs=;
 b=LIifgfambYotciv3Eodbsl1z5IQ+YUxondeFBODEtly01OG91b9vQJK9HdlF7ESyCQnYBN
 DnThQjFVKcfzrla802IrqjDYkAXitFCaA+dIBXBxJpUipZiraOLQbQC+iyzXStbr9LWXgs
 zKrVqmxPCUST385FHQUS313g9BIE+yk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-JuEDLFSiNaKTbJwVVRa1lw-1; Sun, 31 Dec 2023 03:45:40 -0500
X-MC-Unique: JuEDLFSiNaKTbJwVVRa1lw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40d5ae4cdadso40286875e9.0
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012338; x=1704617138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DBqfFBgY7aStWUgLumJkflj7wgYc5m8HW3cOyukrRFs=;
 b=cGHAnRV20hG1oZdyn/RQ75XzdmaxAcwWss1Frafle1uyKXdGchTvVAz+UwNOhj0Yvz
 XNCam7NHkIWQfVtjwL8kBQqEIEmyrqxs96o/1ceT4MMpfrSC6lnUuwNgiNWll9Kbj0Ta
 Gsn96ISJnCOzV+B13Q+MaZ+3nwQxeq/Y3WBMxiNPlQZ73YA5Loaq2sDgv71OUYQfbNcw
 ycyz5rhLxwDZtV/3A7APw9JVZxKl02TvNcQNh+N3klFf/vtF0TV6IRYtoJijePcExcjw
 q6Yl9uaFm3umTbqIjgGj3gNfFRliKBJIER9v1fIH0VI63gNU0sL5qvwqm5K1DuK1s+wv
 zRMA==
X-Gm-Message-State: AOJu0Ywr65i3KVElLCOkZkZzvMGQk7qixRXsnwGcNzJoIqZEaXLhR/4N
 h2xXHW17gb+mBXDZOF2IjghZX8q8M0lG3miNgRIIN9HJ5YknuQvjrIaeJw8WE+fMRqrpwA8hgte
 gJ2JEH6PbF506UMAcPkVeqn6BESYH+ZnNS8h60kDSQ/eA8sVnW/jC1aws5GGwrI5BYhXZ/eZkU0
 WlGjZ+fOw=
X-Received: by 2002:a05:600c:1c92:b0:40d:5b1c:26fb with SMTP id
 k18-20020a05600c1c9200b0040d5b1c26fbmr2862249wms.32.1704012338311; 
 Sun, 31 Dec 2023 00:45:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHh9Is2P2asim4QvQH6OFkj4MLQUdTSWzMFN9yogP6M0yfWlLw3mPR+o8rVUofe7yi1JvO5Ug==
X-Received: by 2002:a05:600c:1c92:b0:40d:5b1c:26fb with SMTP id
 k18-20020a05600c1c9200b0040d5b1c26fbmr2862244wms.32.1704012338109; 
 Sun, 31 Dec 2023 00:45:38 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a170906601000b00a26dc8ec78dsm7153695ejj.147.2023.12.31.00.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 12/46] target/i386: do not decode string source/destination
 into decode->mem
Date: Sun, 31 Dec 2023 09:44:28 +0100
Message-ID: <20231231084502.235366-13-pbonzini@redhat.com>
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

decode->mem is only used if one operand has has_ea == true.  String
operations will not use decode->mem and will load A0 on their own, because
they are the only case of two memory operands in a single instruction.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


