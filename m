Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C257CD676
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:30:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1v7-0001u5-KS; Wed, 18 Oct 2023 04:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uw-0001oF-KY
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uv-0003gL-5S
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UWFwfKWsP26Bal1UGvJOrMRc81Ismgv98NyAMzklpAA=;
 b=gvUM+JO07/AHtFwE7ZpF8Sqx8+fhTXxA+GQn8FTtkqD8483tQOl2RNnVQDlkbGfL2bSpiz
 onGtgG6ZBLgg7wR3ifXY/63qk9+h+DJQkrgBicSd6Ncm2DG+5Vz0dayQWl16oay1fyI6ES
 xGG97FcH+4KPwMP+izB73R/Y5r2MsU0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-bIedYtN_OxW8t1C3Z-87rA-1; Wed, 18 Oct 2023 04:28:34 -0400
X-MC-Unique: bIedYtN_OxW8t1C3Z-87rA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-997c891a88dso485404666b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617713; x=1698222513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UWFwfKWsP26Bal1UGvJOrMRc81Ismgv98NyAMzklpAA=;
 b=PQiptOnADDfE2vwdI910tFrf7jSdkOdp3lu0kHQiVwphzAZ1VrxztJnZwMR/cM/TTB
 90E/kQEsT6bG+ZmRbqxzdqejmzjK+l4sLbQT9RHlW93youXgthB/2FzQgC6tGJdDicAG
 qZ4rYr3t4BLaA7qFSyPfrh6cEC02vd4jD7QIoGaj+QGooqkWWpzEsN8G9iv3MLpnSfif
 efCsMHbNhY96R1gtqcknH6QL/FPKlljN/AeIHTMz6F2RNj9czSpAX1CMKvRmkxEfce/w
 QTa7VAC6Z5VBctQcQRWH8PbUKqQ/OQIEpHBI+AeSiF6gMWP80i8MzjWCuYT2vUhzvaDC
 WwCQ==
X-Gm-Message-State: AOJu0Yz947bnPfHTZqE/6Mnr/NhZuNAqjlvVP8FsEHtcIKIRwI5Mja/3
 rJmiSvJYYqsvwjjwAXvYFq7ktjTZxAuekIBxlk0v1qvEZnGY/z6eA+0G79yYggGO5BDMAX0SnrN
 E69pAqCV5LW5jAIG1a8/pafEb3UDNge6dV1HJwIFq+IfGgdXb8gJB9/V3sSGkbOBwnu3eUyPcou
 Q=
X-Received: by 2002:a17:907:788:b0:9c3:e158:3168 with SMTP id
 xd8-20020a170907078800b009c3e1583168mr3565190ejb.30.1697617713254; 
 Wed, 18 Oct 2023 01:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzo4yffqQkYBtlfEDshpowdmcCdmJsy348xNbNDwQKLzArjdeBRHIZB9KovxHlBUPz4e82mA==
X-Received: by 2002:a17:907:788:b0:9c3:e158:3168 with SMTP id
 xd8-20020a170907078800b009c3e1583168mr3565179ejb.30.1697617712977; 
 Wed, 18 Oct 2023 01:28:32 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a170906b28a00b009b9af27d98csm1165325ejz.132.2023.10.18.01.28.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 21/32] tests/tcg/arm: move non-SVE tests out of conditional
Date: Wed, 18 Oct 2023 10:27:41 +0200
Message-ID: <20231018082752.322306-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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

test-aes, sha1-vector and sha512-vector need not be conditional on
$(CROSS_CC_HAS_SVE), reorganize the "if"s to move them outside.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/aarch64/Makefile.target | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 2efacf9a5a3..d01b8ff47c8 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -73,11 +73,6 @@ endif
 # System Registers Tests
 AARCH64_TESTS += sysregs
 
-ifneq ($(CROSS_CC_HAS_SVE),)
-# SVE ioctl test
-AARCH64_TESTS += sve-ioctls
-sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
-
 AARCH64_TESTS += test-aes
 test-aes: CFLAGS += -O -march=armv8-a+aes
 test-aes: test-aes-main.c.inc
@@ -100,12 +95,15 @@ sha512-vector: sha512.c
 TESTS += sha512-vector
 
 ifneq ($(CROSS_CC_HAS_SVE),)
+# SVE ioctl test
+AARCH64_TESTS += sve-ioctls
+sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
+
 sha512-sve: CFLAGS=-O3 -march=armv8.1-a+sve
 sha512-sve: sha512.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 
 TESTS += sha512-sve
-endif
 
 ifeq ($(HOST_GDB_SUPPORTS_ARCH),y)
 GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
-- 
2.41.0


