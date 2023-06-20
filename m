Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE7E73702A
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBd6P-0003TZ-2S; Tue, 20 Jun 2023 11:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6E-0003Qk-ON
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6C-0007QR-R3
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687274212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcBQc1puzC4MySckJJoVaqhICno4U4WYu+JKOwxCJT4=;
 b=Hf739BLa1UFHKvTo+E87zQGlc6HzlmDKHnjUJ1q1ZyVK9Xyls7zR8O9qlOVEdBnkhZCe+B
 w4kCkqSYTmp4HAuItzxHDeSKId7MGy39bvO+RCHdvEjTPvMzgGhfKN3VhWGlBkmDK+t3TI
 ghOTL/1qxyUVH94GYfvx1kX5lLHe7sc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-eHi-ZG_bOdWALbZU80mthA-1; Tue, 20 Jun 2023 11:16:50 -0400
X-MC-Unique: eHi-ZG_bOdWALbZU80mthA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-987accb96dbso232440166b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274204; x=1689866204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcBQc1puzC4MySckJJoVaqhICno4U4WYu+JKOwxCJT4=;
 b=bpW9+2OsVITzw50W62BI4scnlvWT4C3dYA8h3qt42jlbvnbu4hqk87ZUHWErHf2xPS
 e2WzzGg6HPerk9IqpEPqL8V5XB91e/224uh+98sN9VNi/56HhHYLXXTjSJ8NBd17ZdW5
 SlB3TbALbQiBeXG41/dCVvJQ1cbtUFHW0Fsz26aNKVgPMVSGX1W+5tAaucMxkiu8BZSl
 1mdKnKEdZSmov96GymvXyQgc6BpKvI3WT2C9wSJC/je04MatYpYQIAluPxOqwLXBMURW
 va/4EXa5PicfT6AEE8G/XZffK/GFnD+VvJrQ5opSCpahMg0Z+oc6WIe58pnfeiUrUchI
 QzOA==
X-Gm-Message-State: AC+VfDx8BCWpJdUHrz0zSawq33wukyiJorJeCq/qtJMdGkm+8q2DfMFW
 ilM5wAsuEALp9g+YA6MlKt6LT9NJEb6FB/oLuSbyiEkVxQUIAuSavr3ppPH5PO2cvdHzz3gi1rf
 E+PrLZzWlychD5zEvtRqWBRcSl8reEtr+qPKe8RGxBn05nvpOd6l+edsMevs59t/hdZ9AdbWxHT
 U=
X-Received: by 2002:a17:906:9748:b0:989:d9d:d901 with SMTP id
 o8-20020a170906974800b009890d9dd901mr2604489ejy.53.1687274203902; 
 Tue, 20 Jun 2023 08:16:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7GyzS8iqnPGEP8QkXqJgqDOR+/BiP0Ay1IlzfNffOtd6WdNJFrEfAnoAYhJxetPOKXMdx3BQ==
X-Received: by 2002:a17:906:9748:b0:989:d9d:d901 with SMTP id
 o8-20020a170906974800b009890d9dd901mr2604468ejy.53.1687274203501; 
 Tue, 20 Jun 2023 08:16:43 -0700 (PDT)
Received: from [192.168.1.72] ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.gmail.com with ESMTPSA id
 bq26-20020a170906d0da00b0096f5b48fe43sm1570873ejb.47.2023.06.20.08.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:16:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 04/10] target/i386: TCG supports XSAVEERPTR
Date: Tue, 20 Jun 2023 17:16:28 +0200
Message-Id: <20230620151634.21053-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620151634.21053-1-pbonzini@redhat.com>
References: <20230620151634.21053-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fc4246223d4..bce0cb73e85 100644
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


