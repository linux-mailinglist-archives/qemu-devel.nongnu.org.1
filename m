Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE917348B4
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 23:52:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB0Iy-0002oA-M6; Sun, 18 Jun 2023 17:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0Ix-0002nm-5o
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0Iv-0006Vh-NJ
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687125084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VBSHWK3C4o/OpcNsqQu+B6EL43Z871mwHgC4743Mmk=;
 b=MkmP2KG95lkeU3WaBBXLSXzAUZMgk0obUWmz/ayUthyAYywgogPdEsYmbchF21EkKPxLRr
 3uzqOc8PM4/z0chS4cqaJtfQnoC8C/8eaPooTNM91iG7+ItGAOwvFd3rJocY78FtZ9OMQS
 ansRZ1GHZMu8ilTJVAEzfxgf3fz3XVc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-hEN3owDDPmuS-17MxLF78g-1; Sun, 18 Jun 2023 17:51:23 -0400
X-MC-Unique: hEN3owDDPmuS-17MxLF78g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-98890dda439so41882366b.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 14:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687125081; x=1689717081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8VBSHWK3C4o/OpcNsqQu+B6EL43Z871mwHgC4743Mmk=;
 b=dq29gRe2WsLhE5erIggNCdxSXUosyFTalLX6X1TlklwUqw4eW8lsyIlZQCDrAHbK/2
 /9/OQ/gj/i++9TRUYjqzumz+eD/l+6C8lSHVrCM4GzX8/vFZm6X4oXtvWlIWTIgUbssS
 ePmr3a2RBqHVihHMACnSi2JQn6NPYdO+BEXDOvAEkhRWBHLT+6KSbEDCCD4DcScQkpbi
 C4McY4Y5PxUsNyiehI4JhL6hEANwueJoD83GofmUo4yREdU5FpRuFQzsE91DhI0kq8lY
 PPyEIvdsF0ju86m/4F7gOQ1s59uN8lcqXG/XYzDS5gwXkIgIGj3s3RRb6bQ9H1w5WhzQ
 8LaA==
X-Gm-Message-State: AC+VfDzVg1xwUm2euaxZJ4lqXZB3NvblPbM5mph8WyBeHbjZg1OvBUu9
 D2o9WS/uBOcukjPbp1GNTy+Tqtfpqt7V9aEEafk0e3P2Es2EwVzHAv65hiJpRk/vfXkGQhYVvHK
 RKOnSuY7+GkIi/xbGQuatAggHTaKhAYoGfKgH7j+KGy59fStuOUTUEEUk803mP/Rwsx1lkN2XeT
 7LiA==
X-Received: by 2002:a17:907:968c:b0:988:b204:66a7 with SMTP id
 hd12-20020a170907968c00b00988b20466a7mr655833ejc.74.1687125081746; 
 Sun, 18 Jun 2023 14:51:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4vaXPyy94JjCNz2sPwo6aW6NAlSPnofn034NQ/EX17vBbh4sUJSNfOsms2Z5v5uLTwp7K0mw==
X-Received: by 2002:a17:907:968c:b0:988:b204:66a7 with SMTP id
 hd12-20020a170907968c00b00988b20466a7mr655824ejc.74.1687125081418; 
 Sun, 18 Jun 2023 14:51:21 -0700 (PDT)
Received: from [192.168.60.219] (server.hotelpassage.eu. [88.146.207.194])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a170906040700b0098860721959sm1667654eja.198.2023.06.18.14.51.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jun 2023 14:51:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] target/i386: TCG supports 3DNow! prefetch(w)
Date: Sun, 18 Jun 2023 23:51:09 +0200
Message-Id: <20230618215114.107337-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230618215114.107337-1-pbonzini@redhat.com>
References: <20230618215114.107337-1-pbonzini@redhat.com>
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


