Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 543537CF5B9
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQYU-0006Ih-Dx; Thu, 19 Oct 2023 06:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYR-0006FQ-7H
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYP-0006Ca-Lz
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O0fO7ODbzYSAx28Rwy633NyqFTt8J0HLgXe91UBK6GM=;
 b=X8Am7y2iEu5tTIylBbVrLo4V7Oxr8A9IaDQXYfAMMJ2bxOUVKByWEbhqNdwHbRVNvlD9Tf
 Z5z+GhO6O1cD2IfkwP8qT6od439owkfJLrga/D53HDXywriwZzBQy4o+dS4L3wNa8LTJn3
 H5mpTiF8ILICLjRVG1FkEedurKD53Wg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-wyELXB9mOAG3xZzY4Elqvw-1; Thu, 19 Oct 2023 06:46:59 -0400
X-MC-Unique: wyELXB9mOAG3xZzY4Elqvw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b822f5c156so584548366b.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712417; x=1698317217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O0fO7ODbzYSAx28Rwy633NyqFTt8J0HLgXe91UBK6GM=;
 b=Tv0sTgfJ/5WB6F9S+SAVywDMG6j+tRI21mPeDYPrhYxq2hSAqbN2u5p7TEi2ZSbMYV
 Todth0V3Cg/Y5IUWa3155+WtLCGpanci4zdff9+YqEalSP9Zz8mJHpzNgslksDmDAUM7
 ewkY75nljbYzGi7kmcjejlHbx1EAIvo+bo1/KOMwywfyJlIKTay0h9wTBe2u60mrLlYH
 UkWCAFVD1td3nsIK9wSxuxRumWKAeMS7YChA4ZLe96YImZKk0yB8M11vCIx3VUvdTuQo
 0rNSEt7V/wo+J1dbpR01mNWhhDWrvWnNlRsvG68uMHt6Mt1XO/CMHpy3yJQCsQsZq/A1
 1pNQ==
X-Gm-Message-State: AOJu0YxF0uIiyJSejlNGbufKxQhkuVMDXq9McdjnWQ5Cf3EDzPz0MWNX
 5LAxTUyJyTf5etRc6dR7cdJPMi9SOJ0bKYbq853+oT2fhY1n5CiDkIQurVHGw42nuzB7j8gvJv3
 kloVKVJom71Bnhf6EirGpIxU/5v5Dd0knTdGUZeiROWJdamHnH6NGMUk6ckPD2V6OWL4S9LkvJk
 I=
X-Received: by 2002:a17:907:25c9:b0:9ad:e180:16e3 with SMTP id
 ae9-20020a17090725c900b009ade18016e3mr1301468ejc.37.1697712417613; 
 Thu, 19 Oct 2023 03:46:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkTBqXwNLTNdQltyVMqnG4j9JcLUHPARHTpRIFS3dbboKMK8IeEiuoP0x6XQyaw0M4XY/ZNA==
X-Received: by 2002:a17:907:25c9:b0:9ad:e180:16e3 with SMTP id
 ae9-20020a17090725c900b009ade18016e3mr1301455ejc.37.1697712417327; 
 Thu, 19 Oct 2023 03:46:57 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 bh12-20020a170906a0cc00b0099bd7b26639sm3387872ejb.6.2023.10.19.03.46.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:46:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/19] tests/tcg/i386: initialize more registers in test-avx
Date: Thu, 19 Oct 2023 12:46:33 +0200
Message-ID: <20231019104648.389942-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019104648.389942-1-pbonzini@redhat.com>
References: <20231019104648.389942-1-pbonzini@redhat.com>
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


