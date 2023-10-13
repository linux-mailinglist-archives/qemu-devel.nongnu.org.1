Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B027C7C819D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 11:12:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrECN-0005l6-MP; Fri, 13 Oct 2023 05:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrECL-0005jy-12
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 05:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrECG-0005NY-Qu
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 05:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697188261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZvnDkgkojYakbouPNQnSNioH7Xg+71/AImlTm5h72Ow=;
 b=IC/WkPx/Cqe92M04v+Y6dfsCsf7nHlWCL9aBd3534MlZsQlMUxS8eJFtqc/Ejdl4fdYwDj
 lTCSSpr/RhvF0CjVfSCExxDMyXO0X3nU+xlFo+pqI69f3H7n2TQgWxjhdCSO7P+8s1RFPo
 3xCs/3+S9Ml5I7/c2CtanXSjuDjowuQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-pwA1a1cDM_qQaIQPO8UusQ-1; Fri, 13 Oct 2023 05:10:53 -0400
X-MC-Unique: pwA1a1cDM_qQaIQPO8UusQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-993c2d9e496so131375466b.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 02:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697188251; x=1697793051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZvnDkgkojYakbouPNQnSNioH7Xg+71/AImlTm5h72Ow=;
 b=WSE9krUrnSHLCzQq/88KoXHR2hgUSMq96Tnd74ypaMQGitRFCYGUOVY6ri2vhl28bA
 kXfYhiE841Vsp+/BfiR46iRltoyf7AFJH0XRbLPpPpRbL0R9yGbUajc5B2Cgtx9vyugF
 l5IxL5Fu5S5JvRsYIJBl6H7obN36FNhW6xHVwwdm789N6Pc93mFF90AFVi8CXSAdaJal
 n4oNhzGslviQAvLsrY7E4iskpsmPs5ZnoHDqbcM+YaMACudNP+Mmkr6VTWnpVbXzpEyM
 Zo5paEePtPRymDXqQeInhDGGDXW0z+//aH+ZdR+zBPBZ2GxnS/Q/nUQLpvWMswz5iNi8
 w1cA==
X-Gm-Message-State: AOJu0YxJ1J10gMBPQjfAUy+qN3xDRrj20rT/5/EThfrt0oh22Vw0JB3u
 O1F4X9SGWG5TW/aQEnXF7yRe8U8nNwQXz2IMVGZwaxGykbL4LNhgNAw/59fnhjEAfWE4qCYUMLS
 A5WjwgPZhxhF60EYr0nJTwJhdoCGswlGxZc9sGERBvnO4GNPAPHvfmXt1iNoIF+Bz9DeT4EGQ2y
 s=
X-Received: by 2002:a17:906:cc13:b0:9ae:63bd:a7fe with SMTP id
 ml19-20020a170906cc1300b009ae63bda7femr21791682ejb.10.1697188251475; 
 Fri, 13 Oct 2023 02:10:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZX9uQ07zGckINTKxLuSPjSIYckndiruIex3DWBLL5axQQ+PbQeAQhVhW7GKrrUYGfRLdHkw==
X-Received: by 2002:a17:906:cc13:b0:9ae:63bd:a7fe with SMTP id
 ml19-20020a170906cc1300b009ae63bda7femr21791663ejb.10.1697188250976; 
 Fri, 13 Oct 2023 02:10:50 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a17090680ce00b0099cb1a2cab0sm12130496ejx.28.2023.10.13.02.10.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 02:10:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: check intercept for XSETBV
Date: Fri, 13 Oct 2023 11:10:49 +0200
Message-ID: <20231013091049.538945-1-pbonzini@redhat.com>
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

Note that this intercept is special; it is checked before the #GP
exception.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/svm.h           | 1 +
 target/i386/tcg/translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/i386/svm.h b/target/i386/svm.h
index f9a785489d8..1bd78447306 100644
--- a/target/i386/svm.h
+++ b/target/i386/svm.h
@@ -132,6 +132,7 @@
 /* only included in documentation, maybe wrong */
 #define SVM_EXIT_MONITOR	0x08a
 #define SVM_EXIT_MWAIT		0x08b
+#define SVM_EXIT_XSETBV		0x08d
 #define SVM_EXIT_NPF  		0x400
 
 #define SVM_EXIT_ERR		-1
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d2061ec44a0..4f6f9fa7e52 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -5916,6 +5916,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
                                  | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
+            gen_svm_check_intercept(s, SVM_EXIT_XSETBV);
             if (!check_cpl0(s)) {
                 break;
             }
-- 
2.41.0


