Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C35817185BE
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:09:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4NRe-0000zu-8z; Wed, 31 May 2023 11:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q4NRY-0000rp-5b
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:08:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cconte@redhat.com>) id 1q4NRW-0004DF-BO
 for qemu-devel@nongnu.org; Wed, 31 May 2023 11:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685545730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=isVeXj2ZRSeKcqWYbUBK8rUm96hsmSNFmyK+1e5/1HY=;
 b=Kq3T97SKHsEmmrfTh9GfDPU4rnk9WTpGVq/U4CCTUlhZ0CNDuZppY/Y0N9qcD63VpTplD2
 4o76XpAL5d4KuKoTlRih2wC08NljHjRVaA2SkAlybyEKfOjLRGtINYeuJofyWO9XuAmVE5
 CIHjZuJTpZJbKvVUEMQVJjGMU17xm0o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-ljzrm8w4NA6cdvQpUXCmCw-1; Wed, 31 May 2023 11:08:49 -0400
X-MC-Unique: ljzrm8w4NA6cdvQpUXCmCw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f612a1b0fdso34142405e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 08:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685545727; x=1688137727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=isVeXj2ZRSeKcqWYbUBK8rUm96hsmSNFmyK+1e5/1HY=;
 b=mH0OTJHtSI4lWonlmaY0F7BvYmPwNe0qfKhDumSpPCH3u0YoU4Ldhs/WpSH5PPEGRo
 uzeRoj77XzOLUvpz1+4QwKm518XbLe10tXExSMNbDiYQ1V41dKHK1m1PZZeTPDQVb3p3
 9fV6iJFo6beZaIXZxTnrQvlRKwVQFGeHpKkQu3eCv0K2Jf8DbCjDCHApjgoPrV8BLsHz
 xmBe1ld2MnxNkAaYM3lTUuBRAkfhnzbhPRsgbqZKr8xy/B4fYyWRAMp91Zh2PeKD3Fxe
 HPOpAxnG9BupK2yCBFJA1Vke5ukxmVDGg3fsozSO4IbPe8RrWYBn8MfezG5M852fb/s8
 KvjQ==
X-Gm-Message-State: AC+VfDy5mpFwJ1hcNMj/uCZZCGs1TRsEAfU63ESH/oIUOolGmIjPB7kg
 PpJDCAFmjhIPDAIdezoxObmOL45sRI/HYsxV6DEc5UHXmSUnq2Wsk1mol2B9/cuohVWSpmdiNXZ
 U1Yc7L9vdOXSd8npJCV46HKsIy6eGBY/HvST2IrN/hSxV/HGYUclsFQtguM+BEkP0uoUNpMeo
X-Received: by 2002:adf:ec12:0:b0:30a:d867:da29 with SMTP id
 x18-20020adfec12000000b0030ad867da29mr4853297wrn.33.1685545727760; 
 Wed, 31 May 2023 08:08:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Gn6zSJMIXGi4dyrgQnEO4lLGc5QDobkGrETyYXTXHEqVA4f0aJv3m25CCiJH1B1KYWMjRbQ==
X-Received: by 2002:adf:ec12:0:b0:30a:d867:da29 with SMTP id
 x18-20020adfec12000000b0030ad867da29mr4853280wrn.33.1685545727578; 
 Wed, 31 May 2023 08:08:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ad4:d988:c2cd:bd04:c2d7:61e3])
 by smtp.gmail.com with ESMTPSA id
 g15-20020adff40f000000b00307972e46fasm7090499wro.107.2023.05.31.08.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 08:08:47 -0700 (PDT)
From: Camilla Conte <cconte@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, richard.henderson@linaro.org, alex.bennee@linaro.org,
 Camilla Conte <cconte@redhat.com>
Subject: [PATCH 2/5] gitlab-ci: Reference rules instead of extends
Date: Wed, 31 May 2023 16:08:21 +0100
Message-Id: <20230531150824.32349-3-cconte@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531150824.32349-1-cconte@redhat.com>
References: <20230531150824.32349-1-cconte@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cconte@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

This allows for the jobs to extend different templates while
having a shared template for rules.

Docs:
https://docs.gitlab.com/ee/ci/jobs/job_control.html#reuse-rules-in-different-jobs
Signed-off-by: Camilla Conte <cconte@redhat.com>
---
 .gitlab-ci.d/opensbi.yml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index 2e9d51764e..d0221632f6 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -40,7 +40,8 @@
       when: on_success
 
 docker-opensbi:
-  extends: .opensbi_job_rules
+  rules:
+    - !reference [.opensbi_job_rules, rules]
   stage: containers
   image: docker:stable
   services:
@@ -59,7 +60,8 @@ docker-opensbi:
     - docker push $IMAGE_TAG
 
 build-opensbi:
-  extends: .opensbi_job_rules
+  rules:
+    - !reference [.opensbi_job_rules, rules]
   stage: build
   needs: ['docker-opensbi']
   artifacts:
-- 
2.40.1


