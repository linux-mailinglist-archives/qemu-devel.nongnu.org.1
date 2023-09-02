Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 811F1790805
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 15:05:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcQEA-0000ws-OE; Sat, 02 Sep 2023 08:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQE9-0000vw-2U
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQE6-0001gI-TY
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 08:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693659586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/UaO2tdvyoA4JIJQgWAGmd+D1MVsgHmpLvvBwYxVwg=;
 b=ZNMZU8cbVWT3ThBpTPJAizW+0J63yU9BqU7fZLmuNpDtGsU0pl4QKXNi7GX9+6c/MujAzl
 Y8x18/ZrDpXy/NmVtEDRtSRAxnCXEUxTcPb+Df1VybWa5ih9VnKKYe4BTzZW1fFaMbREl6
 knGHVEVsC/07b/i3uQ/dL9CRnMTqHkw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-QYdaXeePNw6aDw9KUdSc8g-1; Sat, 02 Sep 2023 08:59:44 -0400
X-MC-Unique: QYdaXeePNw6aDw9KUdSc8g-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31c6c275c83so1689868f8f.2
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 05:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693659582; x=1694264382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/UaO2tdvyoA4JIJQgWAGmd+D1MVsgHmpLvvBwYxVwg=;
 b=cKT1Uiz8FvfbSJuWQXBxAGlUL3kg/BlHNh0ikmS9BjC3Yl8yDNg9++n7JpDzsXrpES
 Oxn28RXm8i8h6Be0DE1kohR4se86HipJiYYZCgN9y4HC1LQp+CIXjXT5vtqUuLyEX40Z
 laypiL1pMILnIW1424W+mT2aa3SwAWxW8ti+r1dOXBzW8DhDTQGuDvXztkWo7hztZ3cM
 w7aGD4VxWdwIjZ+oiusAB0jPE6rKYnbBLnfnKBebnfoX0eYljkxZa9dUpKIx6O+VepCI
 pYeq0/d2ZB8LgQs7MIqgcjkt7T3dNjGF/1/nl+Om9LPn6zoMwqEv+JDZ9zae9L6EzKxh
 RV8g==
X-Gm-Message-State: AOJu0YySbGn2kvXx7bg1J/xJRtgMjoahshTwhu20JNR09utLtovVQM/7
 E8Gpy5Iq/+ujb5Jy831nLpaPhy1N4aARyN1SE/lx1IfjuNgFVKXFvgfjNCrTJceTKYr/pTRalIo
 CtCI+3sLQyiq5QCNGLmn7Es/k9oG8DesOsDwXcFXfhg6p74X+KlW/YJr8gBxJZMDfEejU7lhfeH
 g=
X-Received: by 2002:adf:e411:0:b0:315:8f4f:81b2 with SMTP id
 g17-20020adfe411000000b003158f4f81b2mr3480753wrm.64.1693659582464; 
 Sat, 02 Sep 2023 05:59:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuyJbadSpQe42h44s5/dOvqikDRZftxoXOU76sAcU8K9irETdD5ot8ppnrHc5NtLgun13ezA==
X-Received: by 2002:adf:e411:0:b0:315:8f4f:81b2 with SMTP id
 g17-20020adfe411000000b003158f4f81b2mr3480742wrm.64.1693659582165; 
 Sat, 02 Sep 2023 05:59:42 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 bt12-20020a056000080c00b0031433443265sm2680062wrb.53.2023.09.02.05.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 05:59:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 03/15] configure: remove HOST_CC
Date: Sat,  2 Sep 2023 14:59:22 +0200
Message-ID: <20230902125934.113017-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902125934.113017-1-pbonzini@redhat.com>
References: <20230902125934.113017-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

$(HOST_CC) is only used to invoke the preprocessor, and $(CC) can be
used instead now that there is a Tricore C compiler.  Remove the variable
from config-host.mak.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                 | 1 -
 tests/tcg/tricore/Makefile.softmmu-target | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/configure b/configure
index b9af8282293..7743c18f2fe 100755
--- a/configure
+++ b/configure
@@ -1800,7 +1800,6 @@ fi
 mkdir -p tests/tcg
 echo "# Automatically generated by configure - do not modify" > $config_host_mak
 echo "SRC_PATH=$source_path" >> $config_host_mak
-echo "HOST_CC=$host_cc" >> $config_host_mak
 
 # versioned checked in the main config_host.mak above
 if test -n "$gdb_bin"; then
diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricore/Makefile.softmmu-target
index aff7c1b5802..2ec0bd36225 100644
--- a/tests/tcg/tricore/Makefile.softmmu-target
+++ b/tests/tcg/tricore/Makefile.softmmu-target
@@ -28,7 +28,7 @@ TESTS += test_context_save_areas.c.tst
 QEMU_OPTS += -M tricore_testboard -cpu tc27x -nographic -kernel
 
 %.pS: $(ASM_TESTS_PATH)/%.S
-	$(HOST_CC) -E -o $@ $<
+	$(CC) -E -o $@ $<
 
 %.o: %.pS
 	$(AS) $(ASFLAGS) -o $@ $<
-- 
2.41.0


