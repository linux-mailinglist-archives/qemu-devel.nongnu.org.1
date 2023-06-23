Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD92A73B89C
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:18:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgfP-0004Zp-5Z; Fri, 23 Jun 2023 09:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfN-0004Yw-BN
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCgfL-0005cA-Re
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687526251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZvex8/ZXpvWNVXIq7fGZYNulJMqc+TOm3c+D70WX+I=;
 b=HPyrOgX9/aHwEl3ayLTPjsrNO+9sbuWOavNT+SgTgqUG+I3SpVjMIDC9WZ9wDI16GVso0z
 lhYU09HZ2A/4uYMKDtH7D2Hd1kaG/bwS19W1Q/nORaPhozIlvyx9CAztin+v784XbSTH0/
 voHB+EXDawmqsUv4XzmCwOTdcQbrsfA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-z5u38J1EOnezlqQKS94cOQ-1; Fri, 23 Jun 2023 09:17:29 -0400
X-MC-Unique: z5u38J1EOnezlqQKS94cOQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b479d12b31so6651871fa.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526248; x=1690118248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZvex8/ZXpvWNVXIq7fGZYNulJMqc+TOm3c+D70WX+I=;
 b=ipULEAKL34/P9531B5HaNLySxEIpuD7BVcgiMwjSX/cuJYLp8n8LVskvTckVceHqwt
 dtMCTzoC3LVkTqYOLTEHqyHpfqg3fyWm+4aDjbybQwDejbQlSzV2jkUNYNM19KECxe3k
 o3j2nndXNmN4g2dSOPIEKiqGlWXd+Pw0vOqxcDE1/XaENWuLTiI4bTyn8/NCxTYG74p/
 lJCe3czELmHsZkhrdhzDk7fuV4baR0hBsOUOEY8RYb7ck5Nb78Fbo9W924JDU7Z3nRhK
 EKQFtUeolVsUeE0aGQ4GYr3y+yhMWGZIhBXY3qIt4mYvSk47J5ftLcFCszIkZcA3dx6Q
 Kttw==
X-Gm-Message-State: AC+VfDwl6aWLj3728YzO7fUpjpNIbK1B4T3+wFDDlPlWYFQdC2jytSl0
 jp1WLU3ZxRShajaEXGdX0t7zFzh3ieBb4vbz1LUCwFmhwJ+W7f4VWMtxd2wCXjaw1e4v7W5eXes
 nIonfkmVFXvvgBDRgOYVo0XVrmKyv9FY3epQZfZPvX5ictpr4P0UWn1RaBwh9ux6OQV70ENyWzv
 w=
X-Received: by 2002:a05:651c:1045:b0:2b5:8204:ec9b with SMTP id
 x5-20020a05651c104500b002b58204ec9bmr6710851ljm.43.1687526248018; 
 Fri, 23 Jun 2023 06:17:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5OSQG4J0DMAeeY+fwro23IC3QPf/I6wwaiuX13nM105zOto32C7Ohb6u4ddQobBWTOOtcTQA==
X-Received: by 2002:a05:651c:1045:b0:2b5:8204:ec9b with SMTP id
 x5-20020a05651c104500b002b58204ec9bmr6710843ljm.43.1687526247792; 
 Fri, 23 Jun 2023 06:17:27 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 t18-20020aa7d712000000b0051827a12b47sm5180176edq.15.2023.06.23.06.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 06:17:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 09/11] target/i386: sysret and sysexit are privileged
Date: Fri, 23 Jun 2023 15:17:09 +0200
Message-ID: <20230623131711.96775-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623131711.96775-1-pbonzini@redhat.com>
References: <20230623131711.96775-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 target/i386/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a20b5af71e7..66800392bb9 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -5685,7 +5685,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         if (LMA(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1) {
             goto illegal_op;
         }
-        if (!PE(s)) {
+        if (!PE(s) || CPL(s) != 0) {
             gen_exception_gpf(s);
         } else {
             gen_helper_sysexit(cpu_env, tcg_constant_i32(dflag - 1));
@@ -5711,7 +5711,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         if (!LMA(s) && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1) {
             goto illegal_op;
         }
-        if (!PE(s)) {
+        if (!PE(s) || CPL(s) != 0) {
             gen_exception_gpf(s);
         } else {
             gen_helper_sysret(cpu_env, tcg_constant_i32(dflag - 1));
-- 
2.41.0


