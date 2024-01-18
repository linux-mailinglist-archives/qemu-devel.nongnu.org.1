Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55151831914
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:25:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRS1-0003j8-Bw; Thu, 18 Jan 2024 07:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRr-0003VO-9b
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRp-0006Ak-9S
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vUUEQ1/9ptoeMV67o4glnytwMPNSBdclswY2AvsVL1c=;
 b=jT74PaWcX5mzc+JJscpmqoNBNFespvR5Kw/lOOuLm0M00ohKQpr22I3v+LbXhI1skVX0WJ
 /tq8/8kHssYJbLFWhewbTJpxCqZTs9GhYsFsRcfXzs4xK+/kXiuxNXIcCR9KcfK7AVJOis
 4Hr1oZ7v0JW5IU1/PVxBJuGXCjJUOVI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-69ETQF5bNNWh3vQwyhqXTg-1; Thu, 18 Jan 2024 07:24:39 -0500
X-MC-Unique: 69ETQF5bNNWh3vQwyhqXTg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50edf4f4767so5030338e87.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580677; x=1706185477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vUUEQ1/9ptoeMV67o4glnytwMPNSBdclswY2AvsVL1c=;
 b=ZsW3f2f99FzEpzlyc0M0w0FISIEt82dLRAfuAN2x5RHDt4Xn8ike8jpu97CW60xDpp
 tfw4EhCt8XZCq8az3p0oIVcPQDId2ML6okerS6ZUpVfY4/fkxQa4TJau1Rj6OCFrP27X
 uuDvCTtNoPcQv5fyVOdYxMBuwLQM6d3hKUZMVEWVZPTHLYXgZiCUDfJugMF1B8v8dS3V
 RecDSaIddTKnjBORm8/0EFQ35bjpj0I50pqXu46tEkJEaidXlS8Sz9TDfep4xSmc6K0q
 gO0+WXnZGxuN4rESXcujEupxCN7XHzJFzmhKTocr/YnlCNwUfQ9k2HkrCh4TgIHTZ/pm
 Jtyg==
X-Gm-Message-State: AOJu0YzXDVYwHw19d7jW4jNj4iSPNXBcSkFGQH8EAj2THqrE9HvzxC3A
 9KfqcjBZ5qv9DPkQAjYaYV72vZET++sdrJ+EFARKoKvF24xOuBgieBIJTUNfkjR08LWAZvpoy6A
 27Blree0zkE6I5fWFrfK/tD3pDiSEkIn8PTAw+/CfNiTpEqFDG+y9jXpnLnRmODSK/XDPUChNSL
 Vu6E6h2Gsci7iewfD/min/53YhsnlDmcVat0Ct
X-Received: by 2002:a05:6512:491:b0:50e:62b1:f67b with SMTP id
 v17-20020a056512049100b0050e62b1f67bmr185980lfq.134.1705580677075; 
 Thu, 18 Jan 2024 04:24:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESFeK504yxarmh08xTFAV3Lyci60HkJtiogSq0c8jZS+IXwuNHeDZleJU3A+k5v4Twyp2VNw==
X-Received: by 2002:a05:6512:491:b0:50e:62b1:f67b with SMTP id
 v17-20020a056512049100b0050e62b1f67bmr185973lfq.134.1705580676816; 
 Thu, 18 Jan 2024 04:24:36 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 ss3-20020a170907c00300b00a2eb3d16fa9sm2376505ejc.144.2024.01.18.04.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 11/16] target/i386: Do not re-compute new pc with CF_PCREL
Date: Thu, 18 Jan 2024 13:24:11 +0100
Message-ID: <20240118122416.9209-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118122416.9209-1-pbonzini@redhat.com>
References: <20240118122416.9209-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

With PCREL, we have a page-relative view of EIP, and an
approximation of PC = EIP+CSBASE that is good enough to
detect page crossings.  If we try to recompute PC after
masking EIP, we will mess up that approximation and write
a corrupt value to EIP.

We already handled masking properly for PCREL, so the
fix in b5e0d5d2 was only needed for the !PCREL path.

Cc: qemu-stable@nongnu.org
Fixes: b5e0d5d22fbf ("target/i386: Fix 32-bit wrapping of pc/eip computation")
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240101230617.129349-1-richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e1eb82a5c68..d4d7e904adb 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2866,10 +2866,6 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
         }
     }
     new_eip &= mask;
-    new_pc = new_eip + s->cs_base;
-    if (!CODE64(s)) {
-        new_pc = (uint32_t)new_pc;
-    }
 
     gen_update_cc_op(s);
     set_cc_op(s, CC_OP_DYNAMIC);
@@ -2885,6 +2881,8 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
             tcg_gen_andi_tl(cpu_eip, cpu_eip, mask);
             use_goto_tb = false;
         }
+    } else if (!CODE64(s)) {
+        new_pc = (uint32_t)(new_eip + s->cs_base);
     }
 
     if (use_goto_tb && translator_use_goto_tb(&s->base, new_pc)) {
-- 
2.43.0


