Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E232D7423DF
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:20:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEokL-0000DM-7D; Thu, 29 Jun 2023 06:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qEokJ-0000B6-PV
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:19:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qEokI-0005mq-DL
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688033965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r6eYcQOpdQGaBIAyIqv467VGeA30T2RXy/LIF4+Ra8w=;
 b=ER7/xR/mf2puunsjDW52w2zNnYRFcJLl3i6jd5I4ZYCld9wj189jM4hr0ls9uXlgvLSONu
 myNgNW9J+i9qZFpznFtVklDZVjXJdZvf664YFtITbGcRoB4l3syE8rGBK9Tm7isK9MOjVf
 JXwk08PjtfNrvWAAPA8A/SJ25Li/J98=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-0d4rw4wPNsGrDO2Wllt1Kw-1; Thu, 29 Jun 2023 06:19:24 -0400
X-MC-Unique: 0d4rw4wPNsGrDO2Wllt1Kw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-51dd16f823bso402123a12.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 03:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688033963; x=1690625963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r6eYcQOpdQGaBIAyIqv467VGeA30T2RXy/LIF4+Ra8w=;
 b=lZuaB+25lK/t866g5ST3Tzd2VKqjZQghnD1LHfNczQYLF2Uwc/UsDiM+TWWBKOJzBR
 VjcpDbfYIGBO2WPRPEQGy1mEZRYksLRiZ7S3s0EwOeXmfJ3GRbPRL2ywTIGpqSXXXDgo
 R3YTLICIOhFDwuCK8X6ARkuyiiucb/wuor7dfgJq4gTsCJQdLk8EBJBxXEk370jbfGHH
 rhe/QFu9Hjin2PbtZkXGrLpa97h5jGMiycfQGLUNEI1x2f4VPL1Mr6kZwEcHFCQRxiQT
 vUC2fjoKzbsUMahux4aFjYaJXMS+QVy0T6Y8mril+1MUgDvzaStecKplTA2G+Y9c9fBX
 ybTA==
X-Gm-Message-State: ABy/qLZxEeuwwQ2qIX5hQ/q2LNJthnS/tWho2Xc6gVgJQKzaS596QTAm
 QQMNix5+73tOCvz44CyfOQEhurKWtIjzUHlmIoycxljrccgUtjFxoJ/u3Szfo1Tnu/0klPnjrVT
 dbjvk9IAVPAtQHzB07klMaMQbvEakN8DQKUSIFojSf43fod6eo2xGU2L5l82X7iGrFnZC0POqoT
 U=
X-Received: by 2002:aa7:d902:0:b0:51d:e3d2:f5eb with SMTP id
 a2-20020aa7d902000000b0051de3d2f5ebmr608571edr.5.1688033963283; 
 Thu, 29 Jun 2023 03:19:23 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEpbzJFajmdv8EKasE/kuDoXoxLquFQeAuhy41XrQvfaPBYCb81wwrVi5bu+Eonhs+d1TV70A==
X-Received: by 2002:aa7:d902:0:b0:51d:e3d2:f5eb with SMTP id
 a2-20020aa7d902000000b0051de3d2f5ebmr608558edr.5.1688033962856; 
 Thu, 29 Jun 2023 03:19:22 -0700 (PDT)
Received: from [192.168.10.81] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 r16-20020aa7da10000000b0051d2968b26asm5668333eds.77.2023.06.29.03.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 03:19:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PULL 2/5] target/i386: Export MSR_ARCH_CAPABILITIES bits to guests
Date: Thu, 29 Jun 2023 12:19:15 +0200
Message-ID: <20230629101918.9800-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629101918.9800-1-pbonzini@redhat.com>
References: <20230629101918.9800-1-pbonzini@redhat.com>
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

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

On Intel CPUs there are certain bits in MSR_ARCH_CAPABILITIES that
indicates if the CPU is not affected by a vulnerability. Without these
bits guests may try to deploy the mitigation even if the CPU is not
affected.

Export the bits to guests that indicate immunity to hardware
vulnerabilities.

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Message-ID: <63d85cc76d4cdc51e6c732478b81d8f13be11e5a.1687551881.git.pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c0fb6b3ad92..b96a609d966 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1060,10 +1060,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "rdctl-no", "ibrs-all", "rsba", "skip-l1dfl-vmentry",
             "ssb-no", "mds-no", "pschange-mc-no", "tsx-ctrl",
             "taa-no", NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            NULL, "sbdr-ssdp-no", "fbsdp-no", "psdp-no",
             NULL, "fb-clear", NULL, NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL, NULL, NULL,
+            "pbrsb-no", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
         .msr = {
-- 
2.41.0


