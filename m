Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F98820A98
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:52:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrRr-0004Ax-Ad; Sun, 31 Dec 2023 03:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRo-0004AS-CR
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRm-0000gq-Sb
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g3YULLl7BLmS8slrhX3w8JGdKP5hECtRv+zOkMDe9Gs=;
 b=Q6bAZ1ADib+U+f7nNvT46aCP2f+6vpD/PDvLTuTsLneYDpg1snA1TxBxGMziT1BsK8dFeY
 5UcRUdFY+FFKPe4+SDHhb9ebwQWpiBH73amd7lMpduvqmHflwWuYFnrDSCVhbmyb410tOR
 2Td4wRuuj+1Beg8Zg9Mm6pWwWq2jTpI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-dnIBsa51OOi3CVMb2Fvyxg-1; Sun, 31 Dec 2023 03:45:24 -0500
X-MC-Unique: dnIBsa51OOi3CVMb2Fvyxg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a2351094960so842066366b.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012322; x=1704617122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g3YULLl7BLmS8slrhX3w8JGdKP5hECtRv+zOkMDe9Gs=;
 b=OiTx69qw82SrmyzbSGX1iBgW/Mv5FdfOdWmjufovYC2j3sXUUj2Eu5R4y02vRvW8HK
 IvAYD3gnDBA+LjbVKO6a2Q/OzypoL3SjEpN62UmJsEapvB1h/nAOgCrN13bWf3bYFRu3
 KvwG9nGgMrT7+W6KeMmrD25RHzLYA2U1uY2CvcKgYPuaee19lW3YTFRPWNUxfiMqBNbU
 l0AwlOe7B/A8Vyo5Y9GDeXy44KwTo31t224wkmuTLHTZIMVh+VFoJDuOYqegs+CDKtMg
 kX8OqAc6yy7UhfkeLq6jAzb8gZkBouX+0eyHt4SrT7kydZW1L0PQ72I9QUPR8Eh552AX
 ZZ/A==
X-Gm-Message-State: AOJu0YyoALTdw38I+jjsJGBwQojWhFWs1eR+TmSCY0cjql5Tf6NdeTCF
 UEflRdy42+Cq3KiDGXtrEeAKvXop1xiPfchpRWAdGUYP1FNIz5ielSjS2YvThKEW9MQhohe9ovw
 fyOG3VTGs7+u5gNVjUepWZrCgwTaApsByJas2ypKoxYVCwuq/4oeZ12oTVAALaVdqVsnLvU1zMq
 RUVMY6jMg=
X-Received: by 2002:a17:906:1741:b0:a23:4998:7e6e with SMTP id
 d1-20020a170906174100b00a2349987e6emr15296940eje.5.1704012322754; 
 Sun, 31 Dec 2023 00:45:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8lBwP8zH0/kOps+/Pzx+SDoY4U7JJqEcOTJ+p5G+jE5Gd6jRVY/ZkN1E6mVFyNacvqeY9sg==
X-Received: by 2002:a17:906:1741:b0:a23:4998:7e6e with SMTP id
 d1-20020a170906174100b00a2349987e6emr15296936eje.5.1704012322466; 
 Sun, 31 Dec 2023 00:45:22 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a05640210cd00b0055298b38768sm13317796edu.80.2023.12.31.00.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/46] target/i386: document more deviations from the manual
Date: Sun, 31 Dec 2023 09:44:23 +0100
Message-ID: <20231231084502.235366-8-pbonzini@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 2bdbb1bba0f..232c6a45c96 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -26,6 +26,13 @@
  * size (X86_SIZE_*) codes used in the manual.  There are a few differences
  * though.
  *
+ * Operand sizes
+ * -------------
+ *
+ * The manual lists d64 ("cannot encode 32-bit size in 64-bit mode") and f64
+ * ("cannot encode 16-bit or 32-bit size in 64-bit mode") as modifiers of the
+ * "v" or "z" sizes.  The decoder simply makes them separate operand sizes.
+ *
  * Vector operands
  * ---------------
  *
@@ -44,6 +51,11 @@
  * if the difference is expressed via prefixes.  Individual instructions
  * are separated by prefix in the generator functions.
  *
+ * There is a custom size "xh" used to address half of a SSE/AVX operand.
+ * This points to a 64-bit operand for SSE operations, 128-bit operand
+ * for 256-bit AVX operands, etc.  It is used for conversion operations
+ * such as VCVTPH2PS or VCVTSS2SD.
+ *
  * There are a couple cases in which instructions (e.g. MOVD) write the
  * whole XMM or MM register but are established incorrectly in the manual
  * as "d" or "q".  These have to be fixed for the decoder to work correctly.
-- 
2.43.0


