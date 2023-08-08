Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD177737D9
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:21:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTEDF-0006w3-Fh; Tue, 08 Aug 2023 00:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDD-0006uW-D6; Tue, 08 Aug 2023 00:20:51 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEDB-0007jJ-Tt; Tue, 08 Aug 2023 00:20:51 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-686be28e1a8so3638101b3a.0; 
 Mon, 07 Aug 2023 21:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468448; x=1692073248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7dhfUcwpc4jAqyrup5K9pjejMt9A7JsRyG2tDSr+mc=;
 b=dXTJ942WVDwt2ktLti46QlUaN+plR7QbZjmi+9zkANKkG06vHE7jyrh7+WwDkcpYRu
 pmynt/e52XQQ1pY4f8I6JphxOOC+mGxrzAQwc9n6V4qt5oNoDWKjz65F4h0yxmIfTUjG
 xc4x9xBnYLeov1VOf4SLt0P9jKNDo/Mch9jHSRi454Kw+TdnUoWE91Z9OzbtI73GosU8
 2RW/njN4zkCgkVidf7pHZKkSoHBwD5YiGsty5/TGUM5XGP5Broi+Dj0ZqtYMcPxhFIGm
 KG3Go++JwNGRpTRRD5SG+4quCSqPw72k/sIQmZvB9xV5nknVvDSZZDuY9V026oDPo3Ke
 tWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468448; x=1692073248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7dhfUcwpc4jAqyrup5K9pjejMt9A7JsRyG2tDSr+mc=;
 b=enOzt0HLwrA2TSCA3a2Lp8xkZkCp/gvXYhA2seQKz3P1teHso0yE517fPgRhhjHfEG
 I1TMTAy57tO01i/VgzGN3hhKTkoS8JAHYgsmFLpox7V3Q5Ig7ZAECj8tBkQ7CXNQ2wDn
 N0EC50GQS0Csi6HnqeOo8eIZLmmdDkA0ZMjsppjATsG2qhhw2FWOzpZwC2arjcswuIaz
 j0wUN5ywU+0lzuVAtFvdxOXC3gK5xon0B/6h4gaW3/aE1fRRvUQ3QJfhU4GFtpJR/Sbl
 6TYsDC0PGqjnRyKJz+peiSPIzj4esks7NTDmDdraJp69BKGmLM5V4w06Py6btl+BXRJZ
 cIqg==
X-Gm-Message-State: AOJu0YwudKpuDFO2sy+YFMLyHuIhj4GCbmQSIKn6ICEQlvSs4NJxyPST
 3Xfydh+B7S3oCe19BMnm6bUr2mpPLVY=
X-Google-Smtp-Source: AGHT+IErzqNXPEStJAUDHZy5a3q0GtY3cdNTEQDOwxLeP/+EW4ODFLh76ciTEMiqMWc8JA8QfuUdxg==
X-Received: by 2002:a05:6a00:1306:b0:668:73f5:dce0 with SMTP id
 j6-20020a056a00130600b0066873f5dce0mr10076311pfu.29.1691468447971; 
 Mon, 07 Aug 2023 21:20:47 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:20:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 08/19] target/ppc: Sign-extend large decrementer to 64-bits
Date: Tue,  8 Aug 2023 14:19:50 +1000
Message-Id: <20230808042001.411094-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When storing a large decrementer value with the most significant
implemented bit set, it is to be treated as a negative and sign
extended.

This isn't hit for book3s DEC because of another bug, fixing it
in the next patch exposes this one and can cause additional
problems, so fix this first. It can be hit with HDECR and other
edge triggered types.

Fixes: a8dafa52518 ("target/ppc: Implement large decrementer support for TCG")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index a397820d9c..fb4784793c 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -743,7 +743,9 @@ target_ulong cpu_ppc_load_decr(CPUPPCState *env)
      * to 64 bits, otherwise it is a 32 bit value.
      */
     if (env->spr[SPR_LPCR] & LPCR_LD) {
-        return decr;
+        PowerPCCPU *cpu = env_archcpu(env);
+        PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+        return sextract64(decr, 0, pcc->lrg_decr_bits);
     }
     return (uint32_t) decr;
 }
@@ -762,7 +764,9 @@ target_ulong cpu_ppc_load_hdecr(CPUPPCState *env)
      * extended to 64 bits, otherwise it is 32 bits.
      */
     if (pcc->lrg_decr_bits > 32) {
-        return hdecr;
+        PowerPCCPU *cpu = env_archcpu(env);
+        PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+        return sextract64(hdecr, 0, pcc->lrg_decr_bits);
     }
     return (uint32_t) hdecr;
 }
-- 
2.40.1


