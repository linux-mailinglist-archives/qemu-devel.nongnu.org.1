Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E77E7C9F9E
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:33:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH8t-0003y9-88; Mon, 16 Oct 2023 02:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8r-0003wf-DM
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8p-0005Sb-V7
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UWFwfKWsP26Bal1UGvJOrMRc81Ismgv98NyAMzklpAA=;
 b=Fp41g1HnLVFsG68QwrSoKw8kiMpka7Ohd0TljUd06FxJcpTO1JBXaUQlOcQX9t6ub8zr1p
 c3zJIpK8iEHmp1BhA5UKfSF4uTjpSVJZrAJJVu4vljqnX2uSl9VoCQREYmcJcyvMKEd3ko
 jAr1CST3GDsYqBlF8K1+M6fhM2m0Z9U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-pj5aymv8MjabHIdWMdSYqA-1; Mon, 16 Oct 2023 02:31:44 -0400
X-MC-Unique: pj5aymv8MjabHIdWMdSYqA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9ae0bf9c0b4so308478266b.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437902; x=1698042702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UWFwfKWsP26Bal1UGvJOrMRc81Ismgv98NyAMzklpAA=;
 b=G3AS6eZJHC2aro3B+ECKvGTo/+NtJWt5Cxn/hDBa9Cw47HBEwuMOPu1nfT8q0TCoiH
 x9QiXyAFvnpcjrphrHPwr5/HD3t8gMmIHcdjKRyRnVykOlWMIsfo+oq+zhxL31qNuAK/
 qGA8m2oaMsJhRJc/xxioxJCsvDC8He5flaqx62ZOfZQkLY/DkQIwPL51VrLT/kzoukNK
 xuu2KAP4ps6Jw1OnD8UFGPyxw8mZdaZn9WPvARoA94ushbgZcRqou6rU5WX7LkPbI+dB
 98FA3a25oxdoVQclzq5pAwIJuRwBxbUE5HNc/oILX+xcA0s5WHbiynPN6pED7SL39LeC
 nNkQ==
X-Gm-Message-State: AOJu0Yw0M1xmVJBp4sOo3gTvxh89leZodcMoPrk6OHR9GQF6oohEOR8n
 ORS8NT83MXAoNWIEfiI1G4/ClYpM6Q5xyBqABeNoYLK8vdEvByR6a/ZYzp28PlvJclK8qH5ISJ6
 K2VmaJKEpdQX38SGJzy9cf0PHV+8zfxUkWvAHixTmRnDvgijOG9Zm2KA4227zCjzHmzF0zCVB9i
 U=
X-Received: by 2002:a17:907:ea1:b0:9be:ef46:6b9d with SMTP id
 ho33-20020a1709070ea100b009beef466b9dmr5256525ejc.29.1697437902617; 
 Sun, 15 Oct 2023 23:31:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaIESZJFotBx06sVT+rwuyDzGjszwQKsje+roRzrw0N3haxPz+2QLQwADSw3XCPMoT4KK4ag==
X-Received: by 2002:a17:907:ea1:b0:9be:ef46:6b9d with SMTP id
 ho33-20020a1709070ea100b009beef466b9dmr5256509ejc.29.1697437902177; 
 Sun, 15 Oct 2023 23:31:42 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 r15-20020a17090638cf00b00997cce73cc7sm3398153ejd.29.2023.10.15.23.31.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:31:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/17] tests/tcg/arm: move non-SVE tests out of conditional
Date: Mon, 16 Oct 2023 08:31:17 +0200
Message-ID: <20231016063127.161204-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016063127.161204-1-pbonzini@redhat.com>
References: <20231016063127.161204-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


