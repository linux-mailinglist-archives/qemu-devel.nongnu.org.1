Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2250C81CE50
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:17:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4k-0000yW-JR; Fri, 22 Dec 2023 13:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4I-0000x0-SF
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4G-00068o-VW
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=al44MJOmqHcZOLfSSmKV4UAehtm1YwYdWQ5lf4zgUws=;
 b=Y3qbtZjNstDOIEJdNbbq/L+XzU3YouLLQPgvLQGVZd/r6MAgPwNz0oBZsLoYX2PToprk+l
 3hpRVB1L69lJwJZkl42Sd6qira8Zo5qPMRZAhNCfCr/96JVDQagtmt8u2PZsd130/w50lo
 2TF8gOQhPE3cSVFAdgohnBmLTg3yM4M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-NvyxiqhZOKGaS09A9mIRGQ-1; Fri, 22 Dec 2023 13:16:13 -0500
X-MC-Unique: NvyxiqhZOKGaS09A9mIRGQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3369382a524so664992f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268972; x=1703873772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=al44MJOmqHcZOLfSSmKV4UAehtm1YwYdWQ5lf4zgUws=;
 b=eKDi/jEZh003mK/0F9OmwZyao6Is5Jla0DOrJo2fzQO8qq34djpS2fOy5Q33wPTeX5
 qtPuMVJ7uyEbYbkyMKyXivHDC5SPLZR1yK009sq56l0KErQ9F+MicANfM8bqEMFobTxs
 h9jh2rBIesGuTCLrnMyb58ZD3XXHX0las+TbvCbMq7BTFloFZ052rjIKLPV/IjDdGcRw
 2iqGSWOylTrFosKq3LyfWZ6bUnuI0g2IIyFwabmT+nW6z8a8LNMrRaR2ZWOB5DV9hK6U
 TM6hLGjQR9A4z2FTu1mg1g9RmqLlCYXjGXPPrsMgYE/tPc4FHT3DZOffF+Cp06tVQE3C
 P6sQ==
X-Gm-Message-State: AOJu0Yx0bngrtJlXF0rRAla9etyUWj3izdfDDbAnQ+c9UcBmp4hPpECO
 m9T47Y96Zpmbx4n0yvE0R8OvpEPJ2RVwEzTbj2bL6F5XCZgL2uxfb0iD/5OF9y4plydp38BDVJt
 mr73Bpy/y0a4CfcZtqejAYXMeDQtDUHdylha7x5LaSOsuinJ3bThr0fNmNzBr1vjVHTM2pt3Dwc
 lr+cKbsDs=
X-Received: by 2002:adf:e252:0:b0:336:85b7:12ad with SMTP id
 bl18-20020adfe252000000b0033685b712admr1150034wrb.113.1703268972152; 
 Fri, 22 Dec 2023 10:16:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyhcgq7JJtSM+sZDxpcchwQbeoBInF41DX3aUtF4NQ+Oe7/ReZ7IGXnH+26/IhFlRqfeNalw==
X-Received: by 2002:adf:e252:0:b0:336:85b7:12ad with SMTP id
 bl18-20020adfe252000000b0033685b712admr1150027wrb.113.1703268971784; 
 Fri, 22 Dec 2023 10:16:11 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a5d640b000000b003364e437577sm4817633wru.84.2023.12.22.10.16.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/22] target/i386: remove unnecessary arguments from
 raise_interrupt
Date: Fri, 22 Dec 2023 19:15:44 +0100
Message-ID: <20231222181603.174137-4-pbonzini@redhat.com>
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

is_int is always 1, and error_code is always zero.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/excp_helper.c | 7 +++----
 target/i386/tcg/helper-tcg.h  | 3 +--
 target/i386/tcg/misc_helper.c | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index 7c3c8dc7fe8..65e37ae2a0c 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -28,7 +28,7 @@
 G_NORETURN void helper_raise_interrupt(CPUX86State *env, int intno,
                                           int next_eip_addend)
 {
-    raise_interrupt(env, intno, 1, 0, next_eip_addend);
+    raise_interrupt(env, intno, next_eip_addend);
 }
 
 G_NORETURN void helper_raise_exception(CPUX86State *env, int exception_index)
@@ -112,10 +112,9 @@ void raise_interrupt2(CPUX86State *env, int intno,
 
 /* shortcuts to generate exceptions */
 
-G_NORETURN void raise_interrupt(CPUX86State *env, int intno, int is_int,
-                                int error_code, int next_eip_addend)
+G_NORETURN void raise_interrupt(CPUX86State *env, int intno, int next_eip_addend)
 {
-    raise_interrupt2(env, intno, is_int, error_code, next_eip_addend, 0);
+    raise_interrupt2(env, intno, 1, 0, next_eip_addend, 0);
 }
 
 G_NORETURN void raise_exception_err(CPUX86State *env, int exception_index,
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index cd1723389ad..ce34b737bb0 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -65,8 +65,7 @@ G_NORETURN void raise_exception_err(CPUX86State *env, int exception_index,
                                     int error_code);
 G_NORETURN void raise_exception_err_ra(CPUX86State *env, int exception_index,
                                        int error_code, uintptr_t retaddr);
-G_NORETURN void raise_interrupt(CPUX86State *nenv, int intno, int is_int,
-                                int error_code, int next_eip_addend);
+G_NORETURN void raise_interrupt(CPUX86State *nenv, int intno, int next_eip_addend);
 G_NORETURN void handle_unaligned_access(CPUX86State *env, vaddr vaddr,
                                         MMUAccessType access_type,
                                         uintptr_t retaddr);
diff --git a/target/i386/tcg/misc_helper.c b/target/i386/tcg/misc_helper.c
index babff061864..66b332a83c1 100644
--- a/target/i386/tcg/misc_helper.c
+++ b/target/i386/tcg/misc_helper.c
@@ -43,7 +43,7 @@ void helper_into(CPUX86State *env, int next_eip_addend)
 
     eflags = cpu_cc_compute_all(env, CC_OP);
     if (eflags & CC_O) {
-        raise_interrupt(env, EXCP04_INTO, 1, 0, next_eip_addend);
+        raise_interrupt(env, EXCP04_INTO, next_eip_addend);
     }
 }
 
-- 
2.43.0


