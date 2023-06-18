Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4018D7348B7
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 23:52:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB0J3-0002pJ-Gc; Sun, 18 Jun 2023 17:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0J1-0002ow-3I
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0Iz-0006WA-MN
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687125088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JRGs/jbwLnsIqHw/AeAVPF4p+wqrWG7JPYbu6wKGhMU=;
 b=WdFOO6GELu9lsekKv/vogFlZDGAfUZiEcCwia5GvfAZJJodbU0wfqfON0RGwiYdsL3i2K0
 pwcHPqMv8rTkHJKs8Rppxc07Ijp83yHqpAEJN3uyoiNy3CBGRkvLfrfKgUhPoJlXz8nThR
 1q4jrbP871KX4Pq5EEpP1P+RHcvuQoQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-ltB8sgGDOLahWMbPUH6gEA-1; Sun, 18 Jun 2023 17:51:27 -0400
X-MC-Unique: ltB8sgGDOLahWMbPUH6gEA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-51a2d736a25so1984158a12.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 14:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687125086; x=1689717086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JRGs/jbwLnsIqHw/AeAVPF4p+wqrWG7JPYbu6wKGhMU=;
 b=KvLY2byyDAUgMRsfyxZJTPWTsWqOnl31sJFMLc2lie/WrL+HdOP2B4btL4caj4XN9Q
 0iRnODOolHBZVRujriX77LUmHi0sjrSYATy1eeVGm7j2Px1gqenPAAAe6TJcmggmlwJS
 LpgXLauI7kBnJr6lL+HvgXt09pFCS/529LPK8tIyHpadRUT01yXufH6dKzZemwy5KYes
 ORkgmaicA8bHG1nEzyzGH8QVJ4mEMFK0GL+Y/MZ9AjuyfwTcGkzlb4Tr5kkZqA8DHKJ1
 sNrRccSXIJ+Z0Xi+9zmKBZmNlgyPBfKkJGSCCvOu3vl/mbjD+0S1Q8A0rH5lJbzdx/cn
 nUBg==
X-Gm-Message-State: AC+VfDyiHuZUR1q1cK9joUzK0mtKzVMqGEvJYW8bq4grQnIQCgdw/OlE
 jStG+8a+2GiUCETLweibyRBPeg6l4tnWWvuAw0tSnIG5WVsw1U2Ir7fgHPvBOHo0+A8gi0kTigP
 ZZRYxPuj8aDIu8go2Emczuw6g5AbPasYyPut8DM0T8OJQrA/BIvYfS/Eg73rJ7GIfnIo/mm/Kwa
 uqJA==
X-Received: by 2002:a17:907:2da4:b0:988:806c:62da with SMTP id
 gt36-20020a1709072da400b00988806c62damr2182908ejc.58.1687125085884; 
 Sun, 18 Jun 2023 14:51:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47W3mYb73KxDSyy/WRMxZIGDDb4ckm4T5yGrBRJMYh29pyT9Osbo7mgS0jTXfXg3hh8B+lzg==
X-Received: by 2002:a17:907:2da4:b0:988:806c:62da with SMTP id
 gt36-20020a1709072da400b00988806c62damr2182895ejc.58.1687125085617; 
 Sun, 18 Jun 2023 14:51:25 -0700 (PDT)
Received: from [192.168.60.219] (server.hotelpassage.eu. [88.146.207.194])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a170906178400b00982be08a9besm4815250eje.172.2023.06.18.14.51.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jun 2023 14:51:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] target/i386: TCG supports 32-bit SYSCALL
Date: Sun, 18 Jun 2023 23:51:11 +0200
Message-Id: <20230618215114.107337-5-pbonzini@redhat.com>
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

TCG supports both 32-bit and 64-bit SYSCALL, so expose it
with "-cpu max" even for 32-bit emulators.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fc4246223d4..be16c66341d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -637,7 +637,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_EXT_X2APIC, CPUID_EXT_TSC_DEADLINE_TIMER */
 
 #ifdef TARGET_X86_64
-#define TCG_EXT2_X86_64_FEATURES (CPUID_EXT2_SYSCALL | CPUID_EXT2_LM)
+#define TCG_EXT2_X86_64_FEATURES CPUID_EXT2_LM
 #else
 #define TCG_EXT2_X86_64_FEATURES 0
 #endif
@@ -645,7 +645,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_EXT2_FEATURES ((TCG_FEATURES & CPUID_EXT2_AMD_ALIASES) | \
           CPUID_EXT2_NX | CPUID_EXT2_MMXEXT | CPUID_EXT2_RDTSCP | \
           CPUID_EXT2_3DNOW | CPUID_EXT2_3DNOWEXT | CPUID_EXT2_PDPE1GB | \
-          TCG_EXT2_X86_64_FEATURES)
+          CPUID_EXT2_SYSCALL | TCG_EXT2_X86_64_FEATURES)
 #define TCG_EXT3_FEATURES (CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM | \
           CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A | \
           CPUID_EXT3_3DNOWPREFETCH)
-- 
2.40.1


