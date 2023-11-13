Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7A87EA24D
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:47:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2b1X-0007Mv-Ea; Mon, 13 Nov 2023 12:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2b1I-0006xi-Dq
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:46:47 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2b1E-0003Jn-Eo
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:46:44 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4094301d505so37227505e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699897598; x=1700502398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=05kJ8El/iylLN0nD6QWUxl+Z5sjkndWtmUtzuzIy7ck=;
 b=SDyObbPclYkWcw8py3tEW2TmFuIPWKx6ShtPF+87AmBEMAlnZqtcakHOYz9m/TBd6h
 tdRgUy0iQTgnX0uGqWYtl0depFmrJoowLC89ol4E7G69dqfoKzzGPQ/qMG8hobe/H2s2
 Mb2gfqZXywhYKm+4IttX/sQ0Zq/DP8XGZ0KkLuppM8u2IX3oReJ829rH2XKbjLMj8BFG
 Y352NsvBf8dyMCHqzwT88j1DWvAMvffxc7dFaFrSl+4DtPUjg3OL3RJTBcQZAC6/I4ad
 PwEgMJc8NR4a20v+uVCek9lhGOInMJQ48xoKhcw6c29zwfetjyMqlCvbNNAa0+LbUUNq
 JM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699897598; x=1700502398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=05kJ8El/iylLN0nD6QWUxl+Z5sjkndWtmUtzuzIy7ck=;
 b=GSw+xMIK0OuzZFri78kDMKm9pRhPMlbHL8niqFgItmWTw80l3Mwf5P6nWbZ8s3xvHN
 /vlwO/rNZxeoVxpvEfXtgOxIAX81P+hXznsJ5UYpW/GSHBVbdMT7PKkLrdfTG71z7xP8
 eS4iM+kwnEQzstbPLGywQUu7hzahE74qgdK+pRvBG3OMvlqyg97wRIxvM8LNeApfEcbw
 6rSuN0tqAsE9HAwefxlDEYiizRto2XSS0+JTPPn+fyrjC7TVdHy0PT/J5BuUa8u6vixp
 3cCsUVRl/gAtAdZKJtbR/7j4zEQ/lzGMNSfWpRyUjpDx3w6uRKRgNwWF/3dMpaiyvTQp
 V9wg==
X-Gm-Message-State: AOJu0YwB8bKnFK2kcPjHs8ZboUQRPiDYqBLweqNlFqJqiyHRQL0Vzh92
 8yQEL7eHW0LWzNo7351yFDB83h8jgea0GZtVRgA=
X-Google-Smtp-Source: AGHT+IGgz7fF385VpIF26r5sn988nGa1lOW1Iwk5YLz0g/2vnUfJp3f5c4IH+pj/1OjSk/g9c0XO+w==
X-Received: by 2002:a05:600c:1ca7:b0:3fe:f667:4e4c with SMTP id
 k39-20020a05600c1ca700b003fef6674e4cmr6143701wms.12.1699897598581; 
 Mon, 13 Nov 2023 09:46:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c22c800b0040303a9965asm14391110wmg.40.2023.11.13.09.46.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:46:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] target/arm: Correct MTE tag checking for reverse-copy MOPS
Date: Mon, 13 Nov 2023 17:46:34 +0000
Message-Id: <20231113174635.2540484-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113174635.2540484-1-peter.maydell@linaro.org>
References: <20231113174635.2540484-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

When we are doing a FEAT_MOPS copy that must be performed backwards,
we call mte_mops_probe_rev(), passing it the address of the last byte
in the region we are probing.  However, allocation_tag_mem_probe()
wants the address of the first byte to get the tag memory for.
Because we passed it (ptr, size) we could incorrectly trip the
allocation_tag_mem_probe() check for "does this access run across to
the following page", and if that following page happened not to be
valid then we would assert.

We know we will always be only dealing with a single page because the
code that calls mte_mops_probe_rev() ensures that.  We could make
mte_mops_probe_rev() pass 'ptr - (size - 1)' to
allocation_tag_mem_probe(), but then we would have to adjust the
returned 'mem' pointer to get back to the tag RAM for the last byte
of the region.  It's simpler to just pass in a size of 1 byte,
because we know that allocation_tag_mem_probe() in pure-probe
single-page mode doesn't care about the size.

Fixes: 69c51dc3723b ("target/arm: Implement MTE tag-checking functions for FEAT_MOPS copies")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231110162546.2192512-1-peter.maydell@linaro.org
---
 target/arm/tcg/mte_helper.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index 70ac876105f..ffb8ea1c349 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -1101,10 +1101,18 @@ uint64_t mte_mops_probe_rev(CPUARMState *env, uint64_t ptr, uint64_t size,
     uint32_t n;
 
     mmu_idx = FIELD_EX32(desc, MTEDESC, MIDX);
-    /* True probe; this will never fault */
+    /*
+     * True probe; this will never fault. Note that our caller passes
+     * us a pointer to the end of the region, but allocation_tag_mem_probe()
+     * wants a pointer to the start. Because we know we don't span a page
+     * boundary and that allocation_tag_mem_probe() doesn't otherwise care
+     * about the size, pass in a size of 1 byte. This is simpler than
+     * adjusting the ptr to point to the start of the region and then having
+     * to adjust the returned 'mem' to get the end of the tag memory.
+     */
     mem = allocation_tag_mem_probe(env, mmu_idx, ptr,
                                    w ? MMU_DATA_STORE : MMU_DATA_LOAD,
-                                   size, MMU_DATA_LOAD, true, 0);
+                                   1, MMU_DATA_LOAD, true, 0);
     if (!mem) {
         return size;
     }
-- 
2.34.1


