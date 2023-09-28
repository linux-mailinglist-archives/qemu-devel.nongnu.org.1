Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7A27B1573
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 09:56:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qllsl-0008Gd-LE; Thu, 28 Sep 2023 03:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllsk-0008GV-0v
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllsi-0003Fv-AY
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695887779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ccn7TNxgSXIS0NcJJHaGkTZ6T7PhODk2TPfSMx9cFqU=;
 b=OyaN4zMm2Z/KS5bB7o2xPAbJOptgGAmd37EIy7QmMSQC1fLgZIWtYgIvkNNk/bjTuCh+8S
 N0pJzp3IDOMdfEn4ZN81GJAgnhowT6TpFXqQO4Pc1I/VH8mZVHc9pA2GF64hp1+27bh6DH
 CGWlVLc7taxbTwTbMqILlmeVg6DezxI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-kXvFdl4NMnqV_AgkiLbwzA-1; Thu, 28 Sep 2023 03:56:17 -0400
X-MC-Unique: kXvFdl4NMnqV_AgkiLbwzA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a681c3470fso1045629666b.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 00:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695887775; x=1696492575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ccn7TNxgSXIS0NcJJHaGkTZ6T7PhODk2TPfSMx9cFqU=;
 b=WC4oQN5XRaXSZxmeMI75X4SgvjRznajgmrE+sC9DDPvD4j7QLtHjTkVH+XZO6jKMYu
 rkBHfZGRozO4KbsgHLifmZKaz64+E4qaH4lUYnJyOjllxvDpjYENNqMVUhDXIe2ptMgY
 rznISzowQ562EqIfMT+UR5pVuCUxcl+MOfiwCWKr7b4A7Hj/PmeCk9+Ln1fixDZEFpA8
 MdNJSjUIZIAew1pqEr/onX/QBScBHdicbS7HcPWQcUxddYJ9dxWNlJ66bJs7ZR1HiV8R
 wPu3G1yKEuLyNq7Tr3OTtU20A7L9P0X20JuareKtbsoC/Y6T6vWftryNna5ON0pKW3w1
 xBXw==
X-Gm-Message-State: AOJu0Ywq8Ghhku5grhTvI2gHlyCKLVE4/0T+NAICS7x1Pa1iJPxHtViz
 R4abN8ZXFFw4p8todhuMxHEggf3NBIpllLbMtf4yjcAOlgzPCPDycsNwG1n3m7jxb5hkXG7qG4e
 fwUcGqvitCdzUxzalmm566ndtnTz+zF8IJ/FUOMLJfsViFNXXweAyQQcVzTuFqEvGEY0H2dxttb
 Q=
X-Received: by 2002:a17:906:3098:b0:9ae:69c4:5b4f with SMTP id
 24-20020a170906309800b009ae69c45b4fmr598102ejv.19.1695887775512; 
 Thu, 28 Sep 2023 00:56:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUiS9vpcCdsDjGmgLfMS98FLjMukVAIz4fMUs4CZJmlHg4hxsSjtaV7p1YOLAdcDFyZ6n1mg==
X-Received: by 2002:a17:906:3098:b0:9ae:69c4:5b4f with SMTP id
 24-20020a170906309800b009ae69c45b4fmr598082ejv.19.1695887775040; 
 Thu, 28 Sep 2023 00:56:15 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 mc1-20020a170906eb4100b009a5f1d1564dsm10321159ejb.126.2023.09.28.00.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 00:56:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] Makefile: build plugins before running TCG tests
Date: Thu, 28 Sep 2023 09:56:13 +0200
Message-ID: <20230928075613.875575-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add back test-plugins and, since it is always defined, do so unconditionally.

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Fixes: 2c13c574418 ("configure, meson: move --enable-plugins to meson", 2023-09-07)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 38987426594..dab1989a071 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -73,7 +73,7 @@ $(TCG_TESTS_TARGETS:%=distclean-tcg-tests-%): distclean-tcg-tests-%:
 build-tcg: $(BUILD_TCG_TARGET_RULES)
 
 .PHONY: check-tcg
-.ninja-goals.check-tcg = all
+.ninja-goals.check-tcg = all test-plugins
 check-tcg: $(RUN_TCG_TARGET_RULES)
 
 .PHONY: clean-tcg
-- 
2.41.0


