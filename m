Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABB570AA9B
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 21:07:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0Ruk-0007GS-63; Sat, 20 May 2023 15:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0Rui-0007GE-9q
 for qemu-devel@nongnu.org; Sat, 20 May 2023 15:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0Rug-00008M-SP
 for qemu-devel@nongnu.org; Sat, 20 May 2023 15:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684609606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDil6ojXcrA8yrvkIjnS2BxrShNRD12fHk2YDYi2Uro=;
 b=Fp8hHeavC8YTlSkhhHO4l2kXIjI2ODq/zIoSzohHDbaS8bKL6eU4KJvmI7BvLr9fr9BKMI
 ha3Vj+zXWQo3CaDMqRtmIE4aOeC9OUEGh3fdoW7mhKDG27SsRNjDQoeBI4Bxk/iC+l6gqT
 Ntouzunr5QiktIO+a2bwOR0EmbCgcdY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-JJGy4Bu0Pai6O_S8cx5FKA-1; Sat, 20 May 2023 15:06:45 -0400
X-MC-Unique: JJGy4Bu0Pai6O_S8cx5FKA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a355c9028so541644266b.3
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 12:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684609603; x=1687201603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YDil6ojXcrA8yrvkIjnS2BxrShNRD12fHk2YDYi2Uro=;
 b=IzJfrUSFT5IkCGxYj314FdWlNf+Xp8W8PmIFhQadV5WTiDn8ETyrrhGNJB2Lv0CL5J
 DVnGuELrgFMgB+Tqler50TE64L+EIz6bOvsw+aN95GZqOpPxmcHHXcwR67cL+CDxWyAd
 FbkFHDW7p+MvftsOPj+IGhhB/IcWyobfM9aInDR3vJ4RGpNlJHXoKIRuxy/JBbBzLxJc
 YAG6CdSttbHaWK70Q9UoE8hqt7TzSb/YuLq99muPCrESXLY1wT6nKTDCun7g3LYXfqFS
 o17QUq6f9mPLuWriizJC3jf+fKb1OGoqDKMSUqphY4qLnn0fTcFOtsB9n4pwYoG7Hd/+
 mQpw==
X-Gm-Message-State: AC+VfDzVaK9VYF18FsDPnZCxE3YrHC2H6lSZmSKzoa1IBuwtrVQkLYNH
 zWYczB0SB4G2mjA7XZ8xAMsmWAq96Oe2SYEi4XIIWarrZA7qam080QzDo7IWAE2/3fFDa5O/Sar
 8mM7vaIw/GSNccUgZuQBY36eD+YBoxeqdPIVCv3KOPfMAZx4FiXm8bKt58pRWKpVPfGWtr2SCfd
 8=
X-Received: by 2002:a17:906:9743:b0:96f:32ae:a7e1 with SMTP id
 o3-20020a170906974300b0096f32aea7e1mr6404193ejy.63.1684609603448; 
 Sat, 20 May 2023 12:06:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7P1u4EbnaIj1uyW3bjFi5u3DVH7KC2d9C7acMeMLgYA/aXf7OwuboswgfHGo8l5CgmRysiIQ==
X-Received: by 2002:a17:906:9743:b0:96f:32ae:a7e1 with SMTP id
 o3-20020a170906974300b0096f32aea7e1mr6404179ejy.63.1684609603225; 
 Sat, 20 May 2023 12:06:43 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a170906845000b00965cd3a037fsm1074093ejy.112.2023.05.20.12.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 12:06:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 6/7] gitlab: custom-runners: preserve more artifacts for
 debugging
Date: Sat, 20 May 2023 21:06:31 +0200
Message-Id: <20230520190632.7491-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230520190632.7491-1-pbonzini@redhat.com>
References: <20230520190632.7491-1-pbonzini@redhat.com>
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

Since custom runners are not generally available, make it possible to
debug the differences between a successful and a failing build by
comparing the logs and the build.ninja rules.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/custom-runners.yml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
index 34a1e6f32735..8e5b9500f401 100644
--- a/.gitlab-ci.d/custom-runners.yml
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -20,8 +20,10 @@ variables:
   artifacts:
     name: "$CI_JOB_NAME-$CI_COMMIT_REF_SLUG"
     expire_in: 7 days
+    when: always
     paths:
-      - build/meson-logs/testlog.txt
+      - build/build.ninja
+      - build/meson-logs
     reports:
       junit: build/meson-logs/testlog.junit.xml
 
-- 
2.40.1


