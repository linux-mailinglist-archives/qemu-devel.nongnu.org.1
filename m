Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB31B73DD26
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:19:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkBv-0003Mn-Hz; Mon, 26 Jun 2023 07:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBl-00037G-1s
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDkBi-0000mb-4c
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687778112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pZvex8/ZXpvWNVXIq7fGZYNulJMqc+TOm3c+D70WX+I=;
 b=AeR0V8a5UsR5UtpECo5i7h54ARiHbkcQshtJYhTv4jOFU4t4xRXT9RF0gitAEX4sRo70vh
 qDht6FUaETDStTc3PxHljBKABVlGDikcCQE9bLxzShkKCSPZzDX4FjmbGGZLdBMGu9F47o
 fSi58GTnWO6mKftA3NcD10KHTsbQpSM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-ngwb1t43MAGrZTaAEhV27Q-1; Mon, 26 Jun 2023 07:15:11 -0400
X-MC-Unique: ngwb1t43MAGrZTaAEhV27Q-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f858280d89so2211196e87.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687778109; x=1690370109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pZvex8/ZXpvWNVXIq7fGZYNulJMqc+TOm3c+D70WX+I=;
 b=Li6A1p6+jgrjh3Lb9gusMa9PS/WLo/owwmsYtF7znJVDLAivgfaobocCadK0cEWm6S
 exMd8RntLUGJdF8J3wl/bChvLB3NHE8BYBzqM7F/OlK9edmNYdq41HhCO2hBR5uD0UGO
 CC3NFRqbl95HEoBB2hWRYKH0Qs8fXjQD2z8M63XfRLHH5XFPAVXlU46kp9/nog8oqEWC
 DzUQRy2vCt6RUmCOMo6qOEle7oALP6zznN+4kINmS7MOtroMXVNIyjtQMxFqQQ8fcbBZ
 4/WEWvLC9w+AgOe/s71MY5Qqe/7iI8KWvct+i9KISyYV48qssvtEGNrIoiV+nt9aolW/
 1uYA==
X-Gm-Message-State: AC+VfDwvWWRtoVsm60eXsROBRzrW8zXQVLZbmzxDpvfMLn7ElJGEx57q
 f72u3aQZI04c4ncegWERjAPo2bz3a+hIGHw+Rfz3C0ksCrVJmVZsJ5V/be8znDj1HyBlmACNPl8
 qxi14IZ79jJvDGhs6W0nM2P+5zmY/jvUTMye/O7WZ8eSXCok6kUPTt2a7koiLUlXQMA/I1cDxC2
 U=
X-Received: by 2002:a19:2d54:0:b0:4f8:5e5f:b368 with SMTP id
 t20-20020a192d54000000b004f85e5fb368mr14396041lft.21.1687778109420; 
 Mon, 26 Jun 2023 04:15:09 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5B9CDfxucKhe7Xn9cRJ+NBReAfgxmbte88t6ZuhiTUqHEzFjCgnlviclhS8KPKxmHH0VlBeA==
X-Received: by 2002:a19:2d54:0:b0:4f8:5e5f:b368 with SMTP id
 t20-20020a192d54000000b004f85e5fb368mr14396027lft.21.1687778109066; 
 Mon, 26 Jun 2023 04:15:09 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 k1-20020a05600c0b4100b003fa82210e7asm7478456wmr.14.2023.06.26.04.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:15:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/18] target/i386: sysret and sysexit are privileged
Date: Mon, 26 Jun 2023 13:14:42 +0200
Message-ID: <20230626111445.163573-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626111445.163573-1-pbonzini@redhat.com>
References: <20230626111445.163573-1-pbonzini@redhat.com>
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


