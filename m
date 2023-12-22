Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 366FA81CE3B
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:01:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGjop-0001zj-Rs; Fri, 22 Dec 2023 13:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGjol-0001xO-9A
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:00:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGjoj-0004EU-KP
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DuZCQfhQuiDH4tVHc550AR9fUBjRBXylOFkP9CHeGps=;
 b=DaRp43fdm9xOEZhlcAKF/DkIWu+r/mKtQ9yJ2fILNr2kuwmsKH8s2UVUwnm/p+Yo7SAnMe
 anUvv3pvLa4SyE8XuTqYOXwcU8vXonKuTrGD445Hsy5kXzebi2J6T1Y3pzB+srs6WujMO5
 AH6vHXTvh5g3rcw0KdnW6T6tbmuTky0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-3WLBevcqNcWXp7OIdhg43g-1; Fri, 22 Dec 2023 13:00:10 -0500
X-MC-Unique: 3WLBevcqNcWXp7OIdhg43g-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-332ee20a3f0so1326947f8f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268008; x=1703872808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DuZCQfhQuiDH4tVHc550AR9fUBjRBXylOFkP9CHeGps=;
 b=PdkL2BelMRKka+c9TIGxKez5ayxe5qDi8tnMQG6pU4D0f0Q1Fp35L/sFoMBGkbXPkI
 /fk0hNqhOSWWAPh3EP/GjQ/iwuXuRls9L6WiYazHJ4uxIm61cjZKh0kR+ILdLPAPhhFw
 DDiWNhalrdYvf3zWg4Lc+giBUuLS8iYBnOhn4LTNpk1MwSOdXeWCLQi6ckVcqG9MpwD6
 5OI+NyG5gn0fk7oF8N/p9uhN/yJm2P23dm3YG8t2TJmiMcSZ1h4Sbx6quJ0r3uSWTHpV
 48vch2ZCYKZRFJRqMcqgkKDV1/vkr+5v/YB/fLRKbR3KEU8pn7UvNYiv5/w+Vjtp4+kA
 ELSw==
X-Gm-Message-State: AOJu0YzWukOez3Ido+Hqp+wnAnotuTVg7LyswZyfrxolVYKj6lHT3B+s
 ZE6QricPVHJMbMfaie8KxGJlX7U/b5uk9uU9dEvsE1UqR+0hHELT2sp1hxXkCrciMCp+frelYvc
 8w90ZERoYSp26IWXcWaPC/ElFryEeri+qYENIM1QDWN9pfJzm4FpPzKLwO60scnBmzm/2S1rk9X
 bXaCDiCko=
X-Received: by 2002:a05:600c:1f08:b0:40b:5f03:b448 with SMTP id
 bd8-20020a05600c1f0800b0040b5f03b448mr527518wmb.362.1703268008454; 
 Fri, 22 Dec 2023 10:00:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT1c/bLnQ038TgWxa6WhDnmml865YxPl+IkG/Ay+bhBi6JUHeGuwSJ10cIhcnWBEOhI3MT3Q==
X-Received: by 2002:a05:600c:1f08:b0:40b:5f03:b448 with SMTP id
 bd8-20020a05600c1f0800b0040b5f03b448mr527510wmb.362.1703268008055; 
 Fri, 22 Dec 2023 10:00:08 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 fl6-20020a05600c0b8600b0040b30be6244sm7873337wmb.24.2023.12.22.10.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:00:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	mcb30@ipxe.org,
	qemu-stable@nongnu.org
Subject: [PATCH 5/5] target/i386: leave the A20 bit set in the final NPT walk
Date: Fri, 22 Dec 2023 18:59:51 +0100
Message-ID: <20231222175951.172669-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222175951.172669-1-pbonzini@redhat.com>
References: <20231222175951.172669-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The A20 mask is only applied to the final memory access.  Nested
page tables are always walked with the raw guest-physical address.

Unlike the previous patch, in this one the masking must be kept, but
it was done too early.

Cc: qemu-stable@nongnu.org
Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/excp_helper.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index ede8ba6b80e..37e650c1fcd 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -134,7 +134,6 @@ static inline bool ptw_setl(const PTETranslate *in, uint32_t old, uint32_t set)
 static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
                           TranslateResult *out, TranslateFault *err)
 {
-    const int32_t a20_mask = x86_get_a20_mask(env);
     const target_ulong addr = in->addr;
     const int pg_mode = in->pg_mode;
     const bool is_user = (in->mmu_idx == MMU_USER_IDX);
@@ -417,10 +416,13 @@ do_check_protect_pse36:
         }
     }
 
-    /* align to page_size */
-    paddr = (pte & a20_mask & PG_ADDRESS_MASK & ~(page_size - 1))
-          | (addr & (page_size - 1));
+    /* merge offset within page */
+    paddr = (pte & PG_ADDRESS_MASK & ~(page_size - 1)) | (addr & (page_size - 1));
 
+    /*
+     * Note that NPT is walked (for both paging structures and final guest
+     * addresses) using the address with the A20 bit set.
+     */
     if (in->ptw_idx == MMU_NESTED_IDX) {
         CPUTLBEntryFull *full;
         int flags, nested_page_size;
@@ -459,7 +461,7 @@ do_check_protect_pse36:
         }
     }
 
-    out->paddr = paddr;
+    out->paddr = paddr & x86_get_a20_mask(env);
     out->prot = prot;
     out->page_size = page_size;
     return true;
-- 
2.43.0


