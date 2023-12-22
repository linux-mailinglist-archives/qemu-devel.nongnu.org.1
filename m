Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF1181CE40
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:01:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGjoj-0001vg-8T; Fri, 22 Dec 2023 13:00:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGjoh-0001vJ-1C
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:00:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGjoZ-00041O-2m
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z4el3FsUgZFP9kUFar2QDkzqENXHe2AFPJ5BKdoS5aM=;
 b=LKhnxu7ny4gsJ3YiS1JLVdUqnZJhdSvfg93qIIcQ9ljT/w3D11AqkI6NVftVWUjAOJTD7D
 +T4cgQFRAyDPesofzudPGHHj16gMyyiZK9horAkKUwfQQMASompG7fR9mqfI21pidn2vgR
 0Yod+zWhCDKE04QfuRx2447/OCijw/g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-frPKqiDlPU-U7vzIuO6q9g-1; Fri, 22 Dec 2023 13:00:00 -0500
X-MC-Unique: frPKqiDlPU-U7vzIuO6q9g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40c4a824c4bso14812025e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703267998; x=1703872798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z4el3FsUgZFP9kUFar2QDkzqENXHe2AFPJ5BKdoS5aM=;
 b=UbyjGq5sFJjNmVIq4vzFLMd959v92DGMCD0puKHcJTZ8kWT9xNN4a53Pk6/lwcOx2w
 jxrgbffNWczRaCRmB+MkDiK5M49fdSwQkMX8g5k4D75BamOpUOecbinUWRjjrAD/vFQG
 HhQ9pV0fOn8VYybQnriW7v010RZ6MYkhDaVvkEHMTWYQSDDqdKAAzZWT6vhyb3Ds7TQt
 uim2HHyHXE8EG21ewdoV0lVOu6YD+SwpJoAtnE9LxrhS0vl8EnA5WQXHCXAAvmHP2a3l
 Z5xr6Cn0tvJJGBbvYIKu8uCv9ggIxn6N7+aQLowRDx0Qn/oOinfe78cJb1li1K1Er9Ka
 VdWg==
X-Gm-Message-State: AOJu0YzuPFEBZ+e0x6FP4mDarozMSjgKmSRJnAHcTjy1oeIhHiv1NG6Y
 UtW9LolJDYguNMRioonmZn9AzYFklBQVB2zqMWOT2/B1Uk4GdlnVozqKGcjkpP/aUs4aKZ8JSI1
 Z2oA6CBZcCVwsHxB2ewCVFn+DbE3zaVWnE+A8XjOslN1vJ8pDPgKuXwQHoM/6n5Zza5eT9C0fNs
 bJDbtgEPM=
X-Received: by 2002:a05:600c:4595:b0:40d:1778:cdae with SMTP id
 r21-20020a05600c459500b0040d1778cdaemr1001778wmo.25.1703267998216; 
 Fri, 22 Dec 2023 09:59:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEa+WJTwPc1wookDV/f51BPJO8buAEkuXjpn8OKNSme6mKxszogysJGN/Fi1zkh+DHrRnUYoA==
X-Received: by 2002:a05:600c:4595:b0:40d:1778:cdae with SMTP id
 r21-20020a05600c459500b0040d1778cdaemr1001770wmo.25.1703267997751; 
 Fri, 22 Dec 2023 09:59:57 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 d22-20020a05600c34d600b0040d42f8b8dasm4001993wmq.15.2023.12.22.09.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 09:59:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	mcb30@ipxe.org,
	qemu-stable@nongnu.org
Subject: [PATCH 1/5] target/i386: mask high bits of CR3 in 32-bit mode
Date: Fri, 22 Dec 2023 18:59:47 +0100
Message-ID: <20231222175951.172669-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222175951.172669-1-pbonzini@redhat.com>
References: <20231222175951.172669-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

CR3 bits 63:32 are ignored in 32-bit mode (either legacy 2-level
paging or PAE paging).  Do this in mmu_translate() to remove
the last where get_physical_address() meaningfully drops the high
bits of the address.

Cc: qemu-stable@nongnu.org
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/excp_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 5b86f439add..11126c860d4 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -238,7 +238,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
             /*
              * Page table level 3
              */
-            pte_addr = ((in->cr3 & ~0x1f) + ((addr >> 27) & 0x18)) & a20_mask;
+            pte_addr = ((in->cr3 & 0xffffffe0ULL) + ((addr >> 27) & 0x18)) & a20_mask;
             if (!ptw_translate(&pte_trans, pte_addr)) {
                 return false;
             }
@@ -306,7 +306,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
         /*
          * Page table level 2
          */
-        pte_addr = ((in->cr3 & ~0xfff) + ((addr >> 20) & 0xffc)) & a20_mask;
+        pte_addr = ((in->cr3 & 0xfffff000ULL) + ((addr >> 20) & 0xffc)) & a20_mask;
         if (!ptw_translate(&pte_trans, pte_addr)) {
             return false;
         }
-- 
2.43.0


