Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 676E37348B6
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 23:52:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB0J7-0002s5-Tt; Sun, 18 Jun 2023 17:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0J5-0002q4-Ej
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0J4-0006Wb-2s
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687125093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o9Faz8JkOAqTEvYHb2f7jU89r8nve7Zdfl/atjBRxOM=;
 b=Ic06LZas1W7xglXemv3sCdcai3pjsqhksSz3FLjyd4jIUNzpBZIw0RUqps84VWhN4uzUsl
 j442bkHlISfVQuObxLVLwCsvq/m7VM1IHf7+tPDHnm7zFTzAdm0Iveq+N6LmhOY/eHuoKb
 qf1gR/1bAJhWdvtYzCFbxFLwjgsXOAI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-5WsVmBBeNGeaYWutm5ctgA-1; Sun, 18 Jun 2023 17:51:31 -0400
X-MC-Unique: 5WsVmBBeNGeaYWutm5ctgA-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-51a4a83d597so895714a12.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 14:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687125088; x=1689717088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o9Faz8JkOAqTEvYHb2f7jU89r8nve7Zdfl/atjBRxOM=;
 b=Kjqecy5p60lf44BRh4vVSQ8qKOJYTD2YRrga/YkNT/eNOKGfn7WHGXBRpdpJcxd9IT
 jimPywYnbDHKVVj9T7BiaDb9Oumhtf4VJruiN8YHtIr0JMqvIGpt2H1DEQVlGaddeSz0
 YxjV0HYxXc+V5jYIsM/JL47Jvyzhnitvg5h3iRWb/EmVjAzB5KWWZFJuU/zcQu7iEMHC
 Zhq7+Zy34qtXSAFsShsEA0c3oM3VlB9Pxv0aUtEbwn8Xz326sv7F6THBp+YnH4x70wOj
 vZ7fWW+GWHXTdOsJYKAuSiAdJhqQ2y+9X0mbA0yNvK2S2u+IPhUUmrUvauHqfAhdBF+v
 q2NA==
X-Gm-Message-State: AC+VfDxypMMCxov9vqroHCZmo93gvE7SHQffUq6ey32MGqp+XExq7hQI
 zuD3+/kz48kP9dcoHtanwXHM36KZZgGudX59ZMr58DuBHTiyMdteR2C5bgUfDXc0cOjDAxcNp4q
 gP5XyxuZBsfOqrdtcFyp21UZ1VJutrvT0du9aRKAYG3cwmBVK2Rwum4F6dkTemkYf3D18TgxEqM
 NdRg==
X-Received: by 2002:aa7:c55a:0:b0:51a:4d8d:e4db with SMTP id
 s26-20020aa7c55a000000b0051a4d8de4dbmr2199511edr.23.1687125088003; 
 Sun, 18 Jun 2023 14:51:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5fxvQIIibckQjU+Vmq7HLAC91JCrZM1IngO5a3sfUMl2iGMkegdKHV5YD19cyx4IZHP80wQw==
X-Received: by 2002:aa7:c55a:0:b0:51a:4d8d:e4db with SMTP id
 s26-20020aa7c55a000000b0051a4d8de4dbmr2199505edr.23.1687125087779; 
 Sun, 18 Jun 2023 14:51:27 -0700 (PDT)
Received: from [192.168.60.219] (server.hotelpassage.eu. [88.146.207.194])
 by smtp.gmail.com with ESMTPSA id
 bc24-20020a056402205800b0051632dc69absm1509347edb.86.2023.06.18.14.51.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jun 2023 14:51:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/7] target/i386: TCG supports XSAVEERPTR
Date: Sun, 18 Jun 2023 23:51:12 +0200
Message-Id: <20230618215114.107337-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230618215114.107337-1-pbonzini@redhat.com>
References: <20230618215114.107337-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

XSAVEERPTR is actually a fix for an errata; TCG does not have the issue.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index be16c66341d..8e12616db5e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -678,6 +678,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
 
+#define TCG_8000_0008_EBX  CPUID_8000_0008_EBX_XSAVEERPTR
+
 FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_1_EDX] = {
         .type = CPUID_FEATURE_WORD,
@@ -939,7 +941,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "amd-psfd", NULL, NULL, NULL,
         },
         .cpuid = { .eax = 0x80000008, .reg = R_EBX, },
-        .tcg_features = 0,
+        .tcg_features = TCG_8000_0008_EBX,
         .unmigratable_flags = 0,
     },
     [FEAT_8000_0021_EAX] = {
-- 
2.40.1


