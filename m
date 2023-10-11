Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B2C7C55F2
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:55:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZfG-00038p-C9; Wed, 11 Oct 2023 09:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qqZfD-00036t-LW
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:54:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qqZfA-0004Bo-R9
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697032452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=abYt4kVypHIpwZM/jQ4O8/o31wtcUpMYDgHveEZ2A9o=;
 b=HElqKgBmTRyoNJf9XSDKZn6NZ9u3qvhR08ITKtw5JdeAZzs84ZxzjH+wG7RA0yu+zdtBtG
 y0rOGFddZsZI/rJJVWIrk3L6TF3ABFcjFbDOI2gJy/jZy7SbofMQ5uHVwDX2ZCtKpdL4eU
 jiBopCFD/jEyn5BpR3hj/ocAYGDj45Y=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-denj6tXqNqCEB7mUad4NTA-1; Wed, 11 Oct 2023 09:53:54 -0400
X-MC-Unique: denj6tXqNqCEB7mUad4NTA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9ae70250ef5so108971066b.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697032433; x=1697637233;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=abYt4kVypHIpwZM/jQ4O8/o31wtcUpMYDgHveEZ2A9o=;
 b=YDgGE3EceipcFSBxIMfZiNeVYNclclJDYaaB1/cwbLLhDAeTnRQRBpH1H/aduWOBz4
 yLt+KPmRa4jkE+8gfH53rirNeJdyoKOM+3i6T3HzUoICRMhX0NLP1/GVL75ZovIK5W8n
 2G33p9fznpVgKn4cOnPucNO1iXRF339a5v/RJ2lSBR+etmKVnbURzgpaAXQGB8x/b9lQ
 kgiDAGBvYWvOYYKYgQ3ruF0tkNxCsibGAFRsfRXuzg/chEhuL4LpfubSN2oh2UVVAdl3
 EuGXDjYfHEY8SLxSGPyb6sidIHS+eS3FEfftokfIyY1jBciRyskmJJE5TEwbAmpah6wc
 NsxA==
X-Gm-Message-State: AOJu0YxobPnGeuBhw6GR5G1u3yiemjkNOMmeVo4bMznvkGi4bqAlaLSr
 XUkqbqMcrN3y7mYATLLGGkloccyR5uKjySKPKL5lp3pwWFTfW82J8RgGd9pXbDlYR2+QtxgzA89
 HMOkXDXPisr2VJ3kdAA1SJrz01aX2T1BuvtR7jupVfLjvFCngwWoU4l9rirqJyzuZnH7tH74V9n
 E=
X-Received: by 2002:a17:906:5ac8:b0:9b2:b755:5b94 with SMTP id
 x8-20020a1709065ac800b009b2b7555b94mr14515057ejs.38.1697032432783; 
 Wed, 11 Oct 2023 06:53:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFayQ+kwWgCIV0NFWTiPs8nj5pywvw3xCdWLaULATPBYMSzmqUREJ+E8z27Pz/LzSyKs1hhhQ==
X-Received: by 2002:a17:906:5ac8:b0:9b2:b755:5b94 with SMTP id
 x8-20020a1709065ac800b009b2b7555b94mr14515039ejs.38.1697032432363; 
 Wed, 11 Oct 2023 06:53:52 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 ko18-20020a170907987200b0099275c59bc9sm9903462ejc.33.2023.10.11.06.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 06:53:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH] target/i386: fix shadowed variable pasto
Date: Wed, 11 Oct 2023 15:53:50 +0200
Message-ID: <20231011135350.438492-1-pbonzini@redhat.com>
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

Commit a908985971a ("target/i386/seg_helper: introduce tss_set_busy",
2023-09-26) failed to use the tss_selector argument of the new function,
which was therefore unused.

This shows up as a #GP fault when booting old versions of 32-bit
Linux.

Fixes: a908985971a ("target/i386/seg_helper: introduce tss_set_busy", 2023-09-26)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 2b92aee2073..eb29a1fd4e7 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -229,7 +229,7 @@ static void tss_load_seg(CPUX86State *env, X86Seg seg_reg, int selector,
 static void tss_set_busy(CPUX86State *env, int tss_selector, bool value,
                          uintptr_t retaddr)
 {
-    target_ulong ptr = env->gdt.base + (env->tr.selector & ~7);
+    target_ulong ptr = env->gdt.base + (tss_selector & ~7);
     uint32_t e2 = cpu_ldl_kernel_ra(env, ptr + 4, retaddr);
 
     if (value) {
-- 
2.41.0


