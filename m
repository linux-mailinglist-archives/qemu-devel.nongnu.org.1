Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8630D7C9408
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 12:04:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrbSn-0002UW-KF; Sat, 14 Oct 2023 06:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSl-0002Tx-Pf
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSh-0003yT-6Y
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697277694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O0fO7ODbzYSAx28Rwy633NyqFTt8J0HLgXe91UBK6GM=;
 b=IjGnHmZ0/spdH67fKNoT9CTs/Tj5RR6Zi8BwJQo4/WEOZ87sH1c7seXKbk3b2jWSoEj0jK
 6Hf+raw6nDuDWpbVg658OUnBDi8rjFurSOfv58gUvIGi8gjqAKDLHx/VNnWxufYWAiBVMQ
 DL65rm9sn1wkj186uXFzj9q7LVh++mM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-2qy9Z_-POh2guX2i-t79fw-1; Sat, 14 Oct 2023 06:01:32 -0400
X-MC-Unique: 2qy9Z_-POh2guX2i-t79fw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9ae0bf9c0a9so184852166b.3
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 03:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697277691; x=1697882491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0fO7ODbzYSAx28Rwy633NyqFTt8J0HLgXe91UBK6GM=;
 b=ZaqOPSHSlb+db0IQQmPJZ6J8P5+k/g+tHhIR8ciT51LnL2WYkdzyrDdB1LawISVrQT
 oPMjrjhMMDReo5vE+DbHCjvyGVc1uCL8WVfmCA81mZMOIBnv6+OZW6MSSapjM1M64uGg
 1xsOJ7P3wsdO+MrE9uJpAoTZp61/Fx2Lo5NagiYanWOL199ClCECuSzBp86VhpAD3AyA
 MkjBPXWORpq7wBOC3gy8wb57oiBZNZYS3Hz9POwVCEFvOVu0BeWdFHYmuz+QsrjZWyq9
 NwEuuzPqjyv8z6rpjorEr2NhD72ekRSIXN9w5wIDyaetsmBD/Ql1KsY4BgId/AhVUSsi
 thtw==
X-Gm-Message-State: AOJu0Yz5lL07AwzwilGsZUORnLAq6usQ+W74pQVGbwZInbB058P5yJWH
 dZmUl+ArdGLzpDpk262k/Q3WZUgGFfsBRns1ryjaSLZYs4eO+taFx4p+/6s3jWXL8DBS+h6aq1x
 IJI53dvrd3RT3VaMOoAmapEfnObjN0ge2+md4aWCipSa7gx4wKqhyE/n1zydjqg639Vf42rI+Nh
 8=
X-Received: by 2002:a17:906:7308:b0:9be:ab38:a361 with SMTP id
 di8-20020a170906730800b009beab38a361mr1013513ejc.8.1697277691196; 
 Sat, 14 Oct 2023 03:01:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD2+Xmjxz/gNYwtPrU1XrGhNHsFRaCse6sS+CgF2+sgnq6uV4Ucl2Gd9wKFjhEwYaisJ8cBQ==
X-Received: by 2002:a17:906:7308:b0:9be:ab38:a361 with SMTP id
 di8-20020a170906730800b009beab38a361mr1013496ejc.8.1697277690784; 
 Sat, 14 Oct 2023 03:01:30 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a1709060b0c00b009ad778a68c5sm726884ejg.60.2023.10.14.03.01.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 03:01:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/18] tests/tcg/i386: initialize more registers in test-avx
Date: Sat, 14 Oct 2023 12:01:06 +0200
Message-ID: <20231014100121.109817-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014100121.109817-1-pbonzini@redhat.com>
References: <20231014100121.109817-1-pbonzini@redhat.com>
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
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Some instructions use YMM0 implicitly, or use YMM9 as a read-modify-write
register destination.  Initialize those registers as well.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/i386/test-avx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/tcg/i386/test-avx.c b/tests/tcg/i386/test-avx.c
index c39c0e5bce8..2a04c1ecf15 100644
--- a/tests/tcg/i386/test-avx.c
+++ b/tests/tcg/i386/test-avx.c
@@ -316,6 +316,8 @@ int main(int argc, char *argv[])
     int i;
 
     init_all(&initI);
+    init_intreg(&initI.ymm[0]);
+    init_intreg(&initI.ymm[9]);
     init_intreg(&initI.ymm[10]);
     init_intreg(&initI.ymm[11]);
     init_intreg(&initI.ymm[12]);
@@ -324,6 +326,8 @@ int main(int argc, char *argv[])
     dump_regs(&initI);
 
     init_all(&initF16);
+    init_f16reg(&initF16.ymm[0]);
+    init_f16reg(&initF16.ymm[9]);
     init_f16reg(&initF16.ymm[10]);
     init_f16reg(&initF16.ymm[11]);
     init_f16reg(&initF16.ymm[12]);
@@ -333,6 +337,8 @@ int main(int argc, char *argv[])
     dump_regs(&initF16);
 
     init_all(&initF32);
+    init_f32reg(&initF32.ymm[0]);
+    init_f32reg(&initF32.ymm[9]);
     init_f32reg(&initF32.ymm[10]);
     init_f32reg(&initF32.ymm[11]);
     init_f32reg(&initF32.ymm[12]);
@@ -342,6 +348,8 @@ int main(int argc, char *argv[])
     dump_regs(&initF32);
 
     init_all(&initF64);
+    init_f64reg(&initF64.ymm[0]);
+    init_f64reg(&initF64.ymm[9]);
     init_f64reg(&initF64.ymm[10]);
     init_f64reg(&initF64.ymm[11]);
     init_f64reg(&initF64.ymm[12]);
-- 
2.41.0


