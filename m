Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A93C73702E
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:18:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBd6N-0003SQ-Mj; Tue, 20 Jun 2023 11:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6F-0003Qm-1T
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6D-0007QT-Fg
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687274212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=37yH9MFy8yOLu2gBRR80Sz7lWPYBdSIgSc9NGTGkMxI=;
 b=JQPj/ACr17UC8uBcxXj7Dv9/Ozu/BlOV6tLc+rbyN61IYTPM0zfWS6CaUEYNbqDloUj8L7
 qpKd8X9qdYRmlFN3KU8aSEz9dlTjtLegzIGZa3HD04boqB2BetjvL+L0B4zyUdqNXk/zZp
 lOJLYMLAGAttJZV0/fJmkRUvfb+DC3Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-bc2KzavNOwizt_AQhWrwdQ-1; Tue, 20 Jun 2023 11:16:47 -0400
X-MC-Unique: bc2KzavNOwizt_AQhWrwdQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a348facbbso377594066b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274200; x=1689866200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37yH9MFy8yOLu2gBRR80Sz7lWPYBdSIgSc9NGTGkMxI=;
 b=X74+zh9+4RRvabuzJBeoBKEPeC2KnHV8i2NRANqOXoMqgDnT8HIpnY2zITNG2kgDbc
 3aOjgXr1qnlqyGmo09YiRrHCfxsbfh3liS7nG1nBpyGh0QGgPBl4fSyQJ5hFmHceVxmm
 xF/CTjOGL0O1yjZslOGI3IA3Z2sK8J0IGRIxw2hYMRUp6Y9jm+ssn3TzzUIjXVoxMR09
 /fLt4Hv1+kaZzIVLFXvFN2/6LOLe8mt2ed09vqB4WKs9TalEXLN0ssLEzsuUTdXlCBND
 G1LWIWWwU+5vqpa9VDV1oafbNq7Kq/YT6NWf43pLLavZEV635PxsYlnDFpBSIbjq+E3+
 In9Q==
X-Gm-Message-State: AC+VfDzlPvI1Vuz3R0nZuaFMSSwI6IjbGIc2/tXZNubrKpNppSYqL04k
 3Xass3iwOy1itwOTeR6V/0PxbJWk5bQS0t2eWq60tODxIqkXFUB7idd1Jb5ZPexEmKHgQsyll7E
 jEITOzFDE9MC7jvpAhvPopKhG4vIF7H0Mpv92HEDPHCAA5HgWIvbJwjAgYoli3Va0QjriTprZYY
 c=
X-Received: by 2002:a17:907:25cc:b0:989:450:e567 with SMTP id
 ae12-20020a17090725cc00b009890450e567mr2447394ejc.65.1687274200463; 
 Tue, 20 Jun 2023 08:16:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5FnlHwyxkTIRudLs4Z07TDoZ9ok6eIZ07XB2vyxZ98YDadWuKOQGuIk1l5zEYyWnETjkmB1g==
X-Received: by 2002:a17:907:25cc:b0:989:450:e567 with SMTP id
 ae12-20020a17090725cc00b009890450e567mr2447386ejc.65.1687274200270; 
 Tue, 20 Jun 2023 08:16:40 -0700 (PDT)
Received: from [192.168.1.72] ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a170906961400b009894818b6cfsm901243ejx.69.2023.06.20.08.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:16:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 02/10] target/i386: TCG supports 3DNow! prefetch(w)
Date: Tue, 20 Jun 2023 17:16:26 +0200
Message-Id: <20230620151634.21053-3-pbonzini@redhat.com>
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

The AMD prefetch(w) instructions have not been deprecated together with the rest
of 3DNow!, and in fact are even supported by newer Intel processor.  Mark them
as supported by TCG, as it supports all of 3DNow!.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1242bd541a5..ff3dcd02dcb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -647,7 +647,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_EXT2_3DNOW | CPUID_EXT2_3DNOWEXT | CPUID_EXT2_PDPE1GB | \
           TCG_EXT2_X86_64_FEATURES)
 #define TCG_EXT3_FEATURES (CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM | \
-          CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A)
+          CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A | \
+          CPUID_EXT3_3DNOWPREFETCH)
 #define TCG_EXT4_FEATURES 0
 #define TCG_SVM_FEATURES (CPUID_SVM_NPT | CPUID_SVM_VGIF | \
           CPUID_SVM_SVME_ADDR_CHK)
-- 
2.40.1


