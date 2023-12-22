Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB02F81CE41
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:02:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGjol-0001xJ-VY; Fri, 22 Dec 2023 13:00:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGjok-0001we-3J
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:00:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGjog-0004DV-Oq
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9ocpx1qnCoCOuO6Sr/8Qok8Q7DSdqCpknLFXwtQwTc=;
 b=CF28zxJ4QxHA088ndKxIwr0fCvuRhQHBUNH8B4+VUnf30bZY5zkxHsxvGxSPX0D49JwNUE
 WCbD3Na+yZFDZyCpbdYuHac/nb4F67erz6/37ReN0gNdA+zvO2I53VOZow6UxRcMqZNNmr
 nAn353H3pQykzaNZgFPzZifQ173HabE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-MjOuqD4qMWSDFWADK3aKpQ-1; Fri, 22 Dec 2023 13:00:04 -0500
X-MC-Unique: MjOuqD4qMWSDFWADK3aKpQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-336599bf7b8so1012545f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268003; x=1703872803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9ocpx1qnCoCOuO6Sr/8Qok8Q7DSdqCpknLFXwtQwTc=;
 b=ZJ9hRmlEpGPa4bbBNE9EqmA66VOwJlOjv+ZjDC59JiJLN/fZ0YvF8I1b4s7GSaEZpN
 XgIgm2Hpy1sCRiXlZPl03oyZ8n70f96ZeqqpC1Bb+vfBTjn28lm9+wWE2Oh0dwdJw06R
 Ihh3EniSZkwXK4z0aMx7+dgl6AeWXNWAisSddd/ZxXkP4lWZqm6sdQOwEMKyLBzERdt8
 iY6POpZgrJil8p01F1DfLE8qdqENKKqGSWyFedG9brrkkQnU667TB0RJbhIrcX3/g8i0
 TCreIL5DxkeBPwqitDzeXJU2dvo7FMFcaBOPowF/Ke+f5j2ArwymhCLVc5hxyzD5kS0V
 RCag==
X-Gm-Message-State: AOJu0Yy4ej2stjkFf//ZzXiAz4V4MumbrVYWllgYowcK2LMx8ClrW2zj
 5AlDUFsCj15Ha0fDXJWamxMqRKQtQsEqzY1MdYF2Crd3zjVv7nREfcVzIqWPa5NRXIhNMHSkMUV
 uNuoGO4SYPcmfuMCw8fFQmV9iENCEhMojMK54pT4srAoQevPSH/thTdNLcQxhHRdsH2bPQrcofp
 +cvgnFs88=
X-Received: by 2002:a5d:4a48:0:b0:336:602e:dfc4 with SMTP id
 v8-20020a5d4a48000000b00336602edfc4mr951312wrs.38.1703268003459; 
 Fri, 22 Dec 2023 10:00:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHf2RTCa76w/WY46fZwcWJzzgxlcPGiwKR57sG7YIqySgboaMgPOpAO+YN/1g+HyJeg6JFDUA==
X-Received: by 2002:a5d:4a48:0:b0:336:602e:dfc4 with SMTP id
 v8-20020a5d4a48000000b00336602edfc4mr951303wrs.38.1703268003073; 
 Fri, 22 Dec 2023 10:00:03 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 v18-20020a5d5912000000b003368789f25fsm4285084wrd.17.2023.12.22.10.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:00:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	mcb30@ipxe.org,
	qemu-stable@nongnu.org
Subject: [PATCH 3/5] target/i386: Fix physical address truncation
Date: Fri, 22 Dec 2023 18:59:49 +0100
Message-ID: <20231222175951.172669-4-pbonzini@redhat.com>
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

The address translation logic in get_physical_address() will currently
truncate physical addresses to 32 bits unless long mode is enabled.
This is incorrect when using physical address extensions (PAE) outside
of long mode, with the result that a 32-bit operating system using PAE
to access memory above 4G will experience undefined behaviour.

The truncation code was originally introduced in commit 33dfdb5 ("x86:
only allow real mode to access 32bit without LMA"), where it applied
only to translations performed while paging is disabled (and so cannot
affect guests using PAE).

Commit 9828198 ("target/i386: Add MMU_PHYS_IDX and MMU_NESTED_IDX")
rearranged the code such that the truncation also applied to the use
of MMU_PHYS_IDX and MMU_NESTED_IDX.  Commit 4a1e9d4 ("target/i386: Use
atomic operations for pte updates") brought this truncation into scope
for page table entry accesses, and is the first commit for which a
Windows 10 32-bit guest will reliably fail to boot if memory above 4G
is present.

The truncation code however is not completely redundant.  Even though the
maximum address size for any executed instruction is 32 bits, helpers for
operations such as BOUND, FSAVE or XSAVE may ask get_physical_address()
to translate an address outside of the 32-bit range, if invoked with an
argument that is close to the 4G boundary.

So, move the address truncation in get_physical_address() in the
CR0.PG=0 case.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2040
Fixes: 4a1e9d4d11c ("target/i386: Use atomic operations for pte updates", 2022-10-18)
Cc: qemu-stable@nongnu.org
Co-developed-by: Michael Brown <mcb30@ipxe.org>
Signed-off-by: Michael Brown <mcb30@ipxe.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/excp_helper.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 11126c860d4..eee1af52710 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -577,17 +577,14 @@ static bool get_physical_address(CPUX86State *env, vaddr addr,
             }
             return mmu_translate(env, &in, out, err);
         }
+
+        /* No paging implies long mode is disabled.  */
+        addr = (uint32_t)addr;
         break;
     }
 
-    /* Translation disabled. */
+    /* No translation needed. */
     out->paddr = addr & x86_get_a20_mask(env);
-#ifdef TARGET_X86_64
-    if (!(env->hflags & HF_LMA_MASK)) {
-        /* Without long mode we can only address 32bits in real mode */
-        out->paddr = (uint32_t)out->paddr;
-    }
-#endif
     out->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
     out->page_size = TARGET_PAGE_SIZE;
     return true;
-- 
2.43.0


