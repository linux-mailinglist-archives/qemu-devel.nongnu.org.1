Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFD3706FDB
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:47:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLDY-0006uy-7P; Wed, 17 May 2023 13:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDS-0006mA-4x
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDO-0003zI-Gr
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9EoFhTMSuj6MdzeaASZZUUxMEPiDwMGTBjRSt3wNO30=;
 b=SxNhIRGz1dNFGU/tHrdEVLOWJQQDZE+UlalJ9FVTrJdon5Z1/xqybcHgvjrdPI3bcF+sIQ
 lSTbt57ZGblMmGdVBi0cn5MwGjlXJKtY/qRIIjSAxw/GUwFkqBeRnHjDGbSpzBtcIsM7t8
 +xUA8AiyXLxtUpvT+ZGznDyQqfhK5h0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-YY8ITvs3OGWt7W59Rm2PtQ-1; Wed, 17 May 2023 13:45:27 -0400
X-MC-Unique: YY8ITvs3OGWt7W59Rm2PtQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30634323dfeso490120f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345526; x=1686937526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9EoFhTMSuj6MdzeaASZZUUxMEPiDwMGTBjRSt3wNO30=;
 b=aYniz6eTL2ExXyO18ZwcV88SWL7jCZ7DYFEXfThmU2YI8SkcsGPSOKMYPv23LohkYm
 Ns8YL2gkhcnZAMr6KKCg8mO7C0zjCqEKza2ZNen3FiCv+ZNaWMRB0xVjKo/5jpA4Oj6a
 iJMeKyDd4tH5Do2lCwaJDuEcB6aXFnSUm9kzmG0Edtvx6VzOrQjyysxu9PYzwKC8Wkfg
 aFu2ouVL9bVz44PKhV94j1pAQAzIoSPnbbHCzhVjAHA347tZojv7HGrbeuH92+kiYPwh
 JKOryBMkUUL7HzJ0G1U7s+pAcrsigAJ2Xa2f3sju/jleAzY9bMQ+Wmyndq7L2jvdsAzE
 3d7g==
X-Gm-Message-State: AC+VfDzUsz37JfHrL4K5aJ5wVjGbQ2AktJMiywGxPg4xjJxgQwOcVIKs
 PqYqy0+b8RkO0oHry64GTdCrBXoLHWMEuJsG7xCAKej9CQGv28ApOAoaSweE8nccg1J6NX0tO7V
 XRLNtfgGIZS0nubstr+9cCh9054ZgZGavDJYZ2Nh9X/Af+UoWYDSi6YjRNolyEQPFZoWg1+i2Bb
 0=
X-Received: by 2002:adf:f3c1:0:b0:307:95d1:d7d0 with SMTP id
 g1-20020adff3c1000000b0030795d1d7d0mr1330625wrp.39.1684345526115; 
 Wed, 17 May 2023 10:45:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Ty4qSOgIWhhFB9GodF8Fnhb/hMbOpik0zchP0N6X2gCM0R1YeXIs5IN5ROgInBGkqy5CndQ==
X-Received: by 2002:adf:f3c1:0:b0:307:95d1:d7d0 with SMTP id
 g1-20020adff3c1000000b0030795d1d7d0mr1330612wrp.39.1684345525816; 
 Wed, 17 May 2023 10:45:25 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b003047dc162f7sm3237610wrw.67.2023.05.17.10.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PULL 02/68] target/i386: add support for FB_CLEAR feature
Date: Wed, 17 May 2023 19:44:14 +0200
Message-Id: <20230517174520.887405-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Emanuele Giuseppe Esposito <eesposit@redhat.com>

As reported by the Intel's doc:
"FB_CLEAR: The processor will overwrite fill buffer values as part of
MD_CLEAR operations with the VERW instruction.
On these processors, L1D_FLUSH does not overwrite fill buffer values."

If this cpu feature is present in host, allow QEMU to choose whether to
show it to the guest too.
One disadvantage of not exposing it is that the guest will report
a non existing vulnerability in
/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
because the mitigation is present only when the cpu has
        (FLUSH_L1D and MD_CLEAR) or FB_CLEAR
features enabled.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-Id: <20230201135759.555607-3-eesposit@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 target/i386/cpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e5c813199a0d..a61cd6d99d1f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1050,7 +1050,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "ssb-no", "mds-no", "pschange-mc-no", "tsx-ctrl",
             "taa-no", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "fb-clear", NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 3c6f9226e1f1..7201a71de863 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1018,6 +1018,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define MSR_ARCH_CAP_PSCHANGE_MC_NO     (1U << 6)
 #define MSR_ARCH_CAP_TSX_CTRL_MSR       (1U << 7)
 #define MSR_ARCH_CAP_TAA_NO             (1U << 8)
+#define MSR_ARCH_CAP_FB_CLEAR           (1U << 17)
 
 #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
 
-- 
2.40.1


