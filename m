Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E30F6838BB3
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:25:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDxU-0000RB-9j; Tue, 23 Jan 2024 05:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSDxS-0000Qh-Hu
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:24:42 -0500
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSDxQ-0004e0-VV
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:24:42 -0500
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-599a95e3fceso114238eaf.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 02:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706005480; x=1706610280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oG4pU7qednB+jbhj9CwzPfU2NfzR3Eb/S1PuscRboM8=;
 b=sw6mEeSYC48IuXb4k4Iz2grHSEw+Qg0n+eNpF1ZaQ6FBVRuC4XiuPhWjHjILiYyvOd
 k8L8Fxauht/wJb088Y2YRyn55u/qd/ESFRzwb60Pxzo0fxrtxud8p/NySgdiJSIjoZQG
 bsp9A40LWdemoeagXg2zKqMvEugkOCDxRg9aKDNqoaZPEcHb8MJAH65Mx6CYT5p/+hlG
 sMZWu+ch0UU5wQXZsH/Ccwe5gVSytqUm18XN/x9Onx9XP9DyH5+n4OHDdiWiVGp85lc3
 Bf94IcdKFxHBn3d2hbEH80ryd1rf/kJi6A5x6ks8/cJmm2Jlb/FRJMe/rifotlvO/ojR
 AGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706005480; x=1706610280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oG4pU7qednB+jbhj9CwzPfU2NfzR3Eb/S1PuscRboM8=;
 b=BzewXAK2j2PjnMyzH32/rzvnVIkKM/EkBGpkhPQqjMPCSRfxVH3KFK0Gee0gvbbYID
 x4bY3S3IlXWsz1Ul3LcXpl4jIc6MosqmRfb0c5bAUB3pVyKSUelSsSMGO7xtTv8OTG2L
 t7MxNaWdj40ahMn2bLBdUjSVBnXFF5OJRhHfdykx7AgXe/7wWfa4XJE88Sq6DXzXnota
 Shg7OpFrxazfLESm7705lQME9ODm4e/v/CF/fX3OihHjiDhNzHJniF+JfBCje3ZVA8vV
 eYBdSXCzkDbF3ZsBqfFdCwjKP12/ddM7aYt2yVc3gM/CS89i1Gl8+3wxg+jOyzOvXPXA
 IVzw==
X-Gm-Message-State: AOJu0YwgPppI3EzDVJklOX7QV8DDXua3pL+U3D2nPIp99boTgUcsGBmT
 HiiKIln9ZVHvHkOJ+H+yJmhnawijK4QqYlvEOLaANnpqkRFFOYWgf5IYX/mnNStA9ii+M3AkrwI
 idUw=
X-Google-Smtp-Source: AGHT+IGHfdovhrTxr/GMvwqWofqOPiV6XNwKXYCA9NecYBxJ/NhK0HeXCXEhZ5lPAYYeUsg99hhJGA==
X-Received: by 2002:a05:6358:d044:b0:175:b71f:6178 with SMTP id
 jb4-20020a056358d04400b00175b71f6178mr4543150rwb.32.1706005479827; 
 Tue, 23 Jan 2024 02:24:39 -0800 (PST)
Received: from stoup.lan
 (2001-44b8-2176-c800-b8a0-0408-58be-7d2e.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:b8a0:408:58be:7d2e])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a62f808000000b006d9ce7d3258sm11072408pfh.204.2024.01.23.02.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 02:24:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joseph Burt <caseorum@gmail.com>
Subject: [PULL v2 8/8] tcg/arm: Fix SIGILL in tcg_out_qemu_st_direct
Date: Tue, 23 Jan 2024 20:24:12 +1000
Message-Id: <20240123102412.4569-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123102412.4569-1-richard.henderson@linaro.org>
References: <20240123102412.4569-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Joseph Burt <caseorum@gmail.com>

When tcg_out_qemu_st_{index,direct} were merged, the direct case for
MO_64 was omitted, causing qemu_st_i64 to be encoded as 0xffffffff due
to underflow when adding h.base and h.index.

Fixes: 1df6d611bdc2 ("tcg/arm: Introduce HostAddress")
Signed-off-by: Joseph Burt <caseorum@gmail.com>
Message-Id: <20240121211439.100829-1-caseorum@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/arm/tcg-target.c.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index fc78566494..a9aa8aa91c 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1662,6 +1662,9 @@ static void tcg_out_qemu_st_direct(TCGContext *s, MemOp opc, TCGReg datalo,
             } else {
                 tcg_out_strd_r(s, h.cond, datalo, h.base, h.index);
             }
+        } else if (h.index < 0) {
+            tcg_out_st32_12(s, h.cond, datalo, h.base, 0);
+            tcg_out_st32_12(s, h.cond, datahi, h.base, 4);
         } else if (h.index_scratch) {
             tcg_out_st32_rwb(s, h.cond, datalo, h.index, h.base);
             tcg_out_st32_12(s, h.cond, datahi, h.index, 4);
-- 
2.34.1


