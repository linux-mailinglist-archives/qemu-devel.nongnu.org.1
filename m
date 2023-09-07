Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CC2797175
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 12:19:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeC5g-00087w-Iu; Thu, 07 Sep 2023 06:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeC5e-00087V-8d
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeC5c-0006v2-3X
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694081898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UW0LYVBQ86z9c2cV3F6pmV9ZwvsvlDsGKOMCu7v7vrc=;
 b=UEGjoyjLHrEPXXdxWy+nhD9gFpXpDiNy5Hkc6eSM/bsVYCIlsUMMXzzVxd+9maJhaGniOs
 +NHbhgbawVuibIRZgGVfssrCeOoXhwIGqleu+QVzAEaRFYLo7LW6yZAMXOoIHF6R1Wc06X
 l5R8sDheeekd3kfJA1aJXYuFSCtxSU8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-x_50O3FwNS-XOJCMk0CjIg-1; Thu, 07 Sep 2023 06:18:15 -0400
X-MC-Unique: x_50O3FwNS-XOJCMk0CjIg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fef3606d8cso6452295e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 03:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694081894; x=1694686694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UW0LYVBQ86z9c2cV3F6pmV9ZwvsvlDsGKOMCu7v7vrc=;
 b=hcU2O2INNmodJrV9Sut93TFf0BKcqGOUzG+HMezN9yUgiZWrWVPMfnVfAYo83/yhIR
 RHWSbDhduNX9JitgDlflAdXAWb6e88bT0wpwODesSmeZjB29LjD53VIepXORSr7u2Vqa
 n0DgEQdz9KyEo9eOO26/zgkxA4HqeEzLWvE3ay4rRQU6UB291dNIjsce7kH+J7adwVFr
 XSJVvpNAYt8PbO7S3VjX2c7evrzh9hpq7z8RVHKWUk98/fwYcacrPJDSZ69hBT2qjRQM
 u9/g7iWGOmshzfdn+TDyOu4AmhiDLfNIcxLCyN1C0NKkd5v5wDDv7eWa1ebK6Og+b0R1
 remQ==
X-Gm-Message-State: AOJu0Yx4bwoc+MtwfG5fA35LAg/b61E5rjau2MmoZE9X9RNEqXj7fmYm
 xn5DubhuYfmH+UDtQs21sbTLzPS8kFtaAkcyvSB1OCjVoDcGsjeVu1eW7nVB3xmIhZ4GqSSm8JB
 Y0B+OjlfRWiI0Gg75aXMUv0FVuMNdYxQC7FYlKJAPQPVxk29fzx5EjPaUREC5JaPOXwBY040Kkb
 E=
X-Received: by 2002:adf:ef8b:0:b0:319:7472:f0b4 with SMTP id
 d11-20020adfef8b000000b003197472f0b4mr4046879wro.34.1694081893966; 
 Thu, 07 Sep 2023 03:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpViYJUUt/SxIRWeuVqPgIVOCUpx1+yrufshjJK0zh7nLnCs8tVGV4BxLhlPYrydKWQTOvbg==
X-Received: by 2002:adf:ef8b:0:b0:319:7472:f0b4 with SMTP id
 d11-20020adfef8b000000b003197472f0b4mr4046863wro.34.1694081893594; 
 Thu, 07 Sep 2023 03:18:13 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312::1fc])
 by smtp.gmail.com with ESMTPSA id
 24-20020a05600c029800b003fbe4cecc3bsm2084592wmk.16.2023.09.07.03.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 03:18:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH] contrib/plugins: remove -soname argument
Date: Thu,  7 Sep 2023 12:18:11 +0200
Message-ID: <20230907101811.469236-1-pbonzini@redhat.com>
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

-soname is not needed for runtime-loaded modules.  For example, Meson says:

            if not isinstance(target, build.SharedModule) or target.force_soname:
                # Add -Wl,-soname arguments on Linux, -install_name on OS X
                commands += linker.get_soname_args(
                    self.environment, target.prefix, target.name, target.suffix,
                    target.soversion, target.darwin_versions)

(force_soname is set is shared modules are linked into a build target, which is not
the case here.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/plugins/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index b2b9db9f51a..db1bd04dfa6 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -37,7 +37,7 @@ all: $(SONAMES)
 	$(CC) $(CFLAGS) -c -o $@ $<
 
 lib%.so: %.o
-	$(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)
+	$(CC) -shared -o $@ $^ $(LDLIBS)
 
 clean:
 	rm -f *.o *.so *.d
-- 
2.41.0


