Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 641AE914F73
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jun 2024 16:00:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLkEb-0007dJ-JV; Mon, 24 Jun 2024 09:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sLkEa-0007at-2m
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sLkEY-00072J-IZ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719237589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MD4v48+cGAfMcTScuUpWWBLZnAAnBazGHTddcBuIHp4=;
 b=cS/PAXsWjxSivk5ONzBd5DDYfg/8v7ac94eKtruVNRHAs1rQi1nkQK0ZjNqqxfIp6yF7Sq
 E62qrxI8RMYTkwXdUF52nyW+Yh0VPSwLJX+a3wyHY+xCSJ26QxA9XQwUUnafWPfgRGrwAy
 fhEpZc6j/Jo3TvOJlb6PVlaQZZXry1k=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-qyX5iqvKP--NeX8uPJ7Fwg-1; Mon, 24 Jun 2024 09:59:47 -0400
X-MC-Unique: qyX5iqvKP--NeX8uPJ7Fwg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ebd982d244so31802701fa.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719237585; x=1719842385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MD4v48+cGAfMcTScuUpWWBLZnAAnBazGHTddcBuIHp4=;
 b=NtDHjiKg6FLxOuBrPBsB7xfvMNKMLG2eVJCiZh1t3VIp0rGYk/yJ/Cwbp9JateW+pe
 0KN0BAJs2sJnVXgwJIreuUJbIiLHCNZM0tBN7934qzKUQ3KunpLoHkfB8ZmDPQjMOpZP
 Ruv7ZrVTKreu6YTp3v8GUuOC9kdYA6cHdbCH9Iyu+seoYHvkp1KsQ+1zA3Xejj+U/T4U
 eikzUH/3vdIjU/g3rJ2zpYihzX4w0jReYz8NL4QdzgP4yt9Rqr594C1/9wc/+Q2N3lqu
 pxqpdOQCxsh+bGXjy0dx1GG2QNqSHKaVmz3jC1Zy5uS/rBJNn0CPpuvIkebFamtysqL4
 LT6g==
X-Gm-Message-State: AOJu0YzPXhMFg6oVpSDHQnDz2XqAZOZOZ47MkPEnRu9BRwyZBPyYULhF
 wX23c3YzRtm59Bz5hM/48ExpOcId3WilhlUf+hU4H0gDug7mmces3JA7kKJx9iims91NlQ6h72r
 uYYv9Fg8ptswUELX7f6ngZMQkYOyHtNUhEh1l2d/weVJtgoJL+7piTFaPSfgG7quo/GWq0L5lir
 I2gMeVrXkxy5zt1m7Sg3BJjYPEUq4vpCgsOC5r
X-Received: by 2002:a2e:b16e:0:b0:2ec:56d1:f28 with SMTP id
 38308e7fff4ca-2ec5b2b1ce4mr26937721fa.26.1719237585651; 
 Mon, 24 Jun 2024 06:59:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEc5RrYAcrUPop2sLuyZg2DX+AR2fe6nub53VoYDSpzkyEtJtsz9txUqxiU2juXKuUGwrahg==
X-Received: by 2002:a2e:b16e:0:b0:2ec:56d1:f28 with SMTP id
 38308e7fff4ca-2ec5b2b1ce4mr26937431fa.26.1719237584847; 
 Mon, 24 Jun 2024 06:59:44 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d66b04378sm408154a12.38.2024.06.24.06.59.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 06:59:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 15/23] Revert "host/i386: assume presence of SSE2"
Date: Mon, 24 Jun 2024 15:59:39 +0200
Message-ID: <20240624135939.632257-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624135939.632257-1-pbonzini@redhat.com>
References: <20240624135939.632257-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

This reverts commit b18236897ca15c3db1506d8edb9a191dfe51429c.
The x86-64 instruction set can now be tuned down to x86-64 v1
or i386 Pentium Pro.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 host/include/i386/host/cpuinfo.h          | 1 +
 util/cpuinfo-i386.c                       | 1 +
 host/include/i386/host/bufferiszero.c.inc | 5 +++--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 72f6fad61e5..81771733eaa 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -14,6 +14,7 @@
 #define CPUINFO_POPCNT          (1u << 4)
 #define CPUINFO_BMI1            (1u << 5)
 #define CPUINFO_BMI2            (1u << 6)
+#define CPUINFO_SSE2            (1u << 7)
 #define CPUINFO_AVX1            (1u << 9)
 #define CPUINFO_AVX2            (1u << 10)
 #define CPUINFO_AVX512F         (1u << 11)
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index ca74ef04f54..90f92a42dc8 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -34,6 +34,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
     if (max >= 1) {
         __cpuid(1, a, b, c, d);
 
+        info |= (d & bit_SSE2 ? CPUINFO_SSE2 : 0);
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
         info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
diff --git a/host/include/i386/host/bufferiszero.c.inc b/host/include/i386/host/bufferiszero.c.inc
index 3b9605d806f..74ae98580f6 100644
--- a/host/include/i386/host/bufferiszero.c.inc
+++ b/host/include/i386/host/bufferiszero.c.inc
@@ -110,13 +110,14 @@ static biz_accel_fn const accel_table[] = {
 
 static unsigned best_accel(void)
 {
-#ifdef CONFIG_AVX2_OPT
     unsigned info = cpuinfo_init();
+
+#ifdef CONFIG_AVX2_OPT
     if (info & CPUINFO_AVX2) {
         return 2;
     }
 #endif
-    return 1;
+    return info & CPUINFO_SSE2 ? 1 : 0;
 }
 
 #else
-- 
2.45.2


