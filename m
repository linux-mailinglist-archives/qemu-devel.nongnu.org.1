Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C78537972C4
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:14:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdH-00038Y-UG; Thu, 07 Sep 2023 09:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEd8-0002tS-IW
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEd5-0007KZ-5C
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/UaO2tdvyoA4JIJQgWAGmd+D1MVsgHmpLvvBwYxVwg=;
 b=ftm2rBB4FIbnXWbIR2PIPY/IiSvWlGDvIvbrnkNQdw2bMtk8HhsOkGjdUSPotfPWGL5UTN
 DG1/Vo2NqAuXJiTyuCDbxQab7MYM7ZErhNB55P7k6gVBKlyHiUPGdJwWE7PJ8VwV8jc/IY
 GVPrU191WzEWZKsS2bTa++l6YH/4TOQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-mSIaphdDNped7UAAHG_LbA-1; Thu, 07 Sep 2023 09:01:00 -0400
X-MC-Unique: mSIaphdDNped7UAAHG_LbA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5009121067cso957803e87.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091658; x=1694696458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/UaO2tdvyoA4JIJQgWAGmd+D1MVsgHmpLvvBwYxVwg=;
 b=RjzByUfadxB9MycA44ZJF6H88gZAyS4U98nb0gZVBR4dAuWpFrXA7ntBMT0t+FLFID
 hR+4Slmd1esgFDDjwGyasynojejbJxLUUlMFhJfJpvmdkMFPzqS2G2bPkS6I7nk8fLQb
 smay87PRK5IdQntEB6OoHQljKjVe85cOf2+Doz1XYCpkaNaZ6a3M69R4d2ffUSP5rxAe
 wr7yDzFZOxttKYPR52D87U47tOh3fhPBT/kkjm/ujamWBJgiZWn4apBvydHS5Vy+PMsu
 bIoGqsJO3P6cjeJeirddL7u9sfmD+K+AKDLSZQLoFpYCmUgT91fQAfosMH6ntlDb+mIR
 vRvg==
X-Gm-Message-State: AOJu0YzxeUaa+9aHtC7DXg4vGcb9Aqcnzww2/OWxH91AxVWahDc1GIwL
 IaOuBBf427YuO0EsTEqE7REXfQ74e94mIQB6VMvhr6OmM3y8LmKbSuXx5XjN0Wo2gCkAbMUrDfI
 PqPSiIzkqxBjB6rFc6EG7gKB6Azdyh75OkwENcfFddGxrIo3KXaP4kHV5hOadB/yiAVHgl/utx2
 c=
X-Received: by 2002:ac2:554a:0:b0:4fb:89f2:594d with SMTP id
 l10-20020ac2554a000000b004fb89f2594dmr4541914lfk.63.1694091658153; 
 Thu, 07 Sep 2023 06:00:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm9RDpIlG5cyXSAMWkW8fUjEZ70DoyJf4q+uQX4/S+13bBRrlZ/XnfPVFllf8Ij/oY7J94Mg==
X-Received: by 2002:ac2:554a:0:b0:4fb:89f2:594d with SMTP id
 l10-20020ac2554a000000b004fb89f2594dmr4541881lfk.63.1694091657616; 
 Thu, 07 Sep 2023 06:00:57 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 z20-20020a1c4c14000000b00402e942561fsm2449504wmf.38.2023.09.07.06.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 22/51] configure: remove HOST_CC
Date: Thu,  7 Sep 2023 14:59:31 +0200
Message-ID: <20230907130004.500601-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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


