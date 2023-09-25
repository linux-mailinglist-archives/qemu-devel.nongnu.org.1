Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 113207ADABA
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:56:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmsu-0000el-B1; Mon, 25 Sep 2023 10:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmsX-0000bQ-Ie
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:48:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmsT-00083V-QA
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695653280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0i85JQMgZeBziBZVnevU+Vblkj1/JGCW+rRqcYXuLaM=;
 b=bjB9lDnKCKfT40WXbN7YSorqfOk1dpE95gb26O3r8DLORMTAeV1dO3S0yL6Fln3InoGVvN
 jfcsw5OEdxBeYAzZnAGWJ+MiFw2uUsDA3b0R3zsVaEU/f5nkuKoT1o8VEo25QuT3Nj3uAF
 lbneUUjQwze2w+YN+EEb/RCObeID2es=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-QrowrVglOo2gNa7Kki1LkA-1; Mon, 25 Sep 2023 10:47:59 -0400
X-MC-Unique: QrowrVglOo2gNa7Kki1LkA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-404f81fe7cfso41631205e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653277; x=1696258077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0i85JQMgZeBziBZVnevU+Vblkj1/JGCW+rRqcYXuLaM=;
 b=H0vrJ6idUECmmjsNv2EsxOweJe4IeXoPH7VJTwTkruPzsPkWJ4lCH0uunjqFm+S6w5
 qDhmT7z48uSIZkOpU8eeC9c1/kdXCCgY/IzmMo+rzv4zjWPXk5++a8lZJnqITdWcw2kP
 K/BN0DAGdNez+kZYVj/T/t0ekXUDf2Te/Po9FPmkf4as4xX3enKgavGvMN8pRKozH+PT
 ngIyIi+h8eX66hIBhpj6rLSTagzqk8yMUrUZ1x2+E3zIZ4TVk4D23YVhN+xoxYdXG2GF
 /UjdM8IS6m4v2+LtwOcSvPdU2JKQ7elrGrSm8GB9wc8jcrVubpWW+zS1FTvcZOt60k0M
 SJhQ==
X-Gm-Message-State: AOJu0Yzll5bIRDl2Vst/eFcOgVsUSbf3qJmg00/rM56uad4kqg08iOqD
 Noov4c0ATjsDD0Sf0eVo89xKBmTgsk/v9+gVj6WviY2KTlntKVUAQGaMYgRqm/HUvGMKm2Xo3yx
 ioBTylfDohGsLpPflTnYuP1VsmJLdlgRfHQ6YKuNzxcTECRAOhNMWG3WZk1L/aDTzEp9hhl3Ic5
 0=
X-Received: by 2002:a05:600c:501e:b0:405:2d29:1648 with SMTP id
 n30-20020a05600c501e00b004052d291648mr7899454wmr.19.1695653277497; 
 Mon, 25 Sep 2023 07:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJgAZ7qUDLXPHmAMKyp2JyQYWexNPSpDBn8WXBaAPER9oEggACzBR+6I7+/ZakCMTgkG4vww==
X-Received: by 2002:a05:600c:501e:b0:405:2d29:1648 with SMTP id
 n30-20020a05600c501e00b004052d291648mr7899446wmr.19.1695653277255; 
 Mon, 25 Sep 2023 07:47:57 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 e20-20020a05600c219400b003fe1c332810sm15251466wme.33.2023.09.25.07.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:47:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH] target/i386/translate: avoid shadowed local variables
Date: Mon, 25 Sep 2023 16:47:44 +0200
Message-ID: <20230925144744.527958-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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

Just remove the declaration.  There is nothing in the function after the
switch statement, so it is safe to do.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e0a622941cb..26b9308d350 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3242,7 +3242,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0x30 ... 0x35:
     case 0x38 ... 0x3d:
         {
-            int op, f, val;
+            int f;
             op = (b >> 3) & 7;
             f = (b >> 1) & 3;
 
@@ -3302,8 +3302,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0x81:
     case 0x83:
         {
-            int val;
-
             ot = mo_b_d(b, dflag);
 
             modrm = x86_ldub_code(env, s);
-- 
2.41.0


