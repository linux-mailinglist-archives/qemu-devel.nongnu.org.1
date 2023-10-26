Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB897D792B
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo39-0007OS-HZ; Wed, 25 Oct 2023 20:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2s-00077C-7I
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:18 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2n-0004u6-6O
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:17 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c5cd27b1acso2280565ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279372; x=1698884172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBPTcXjS3BRZCWCMtUYgvGDiz0Qe0sy2s6yIUrx8ZMk=;
 b=iWZ3SNuhg3TWjSRVuu1H6Lts8XOpVOWVD6dqEp9HtqVe4p1xsQbE2VLjwd6A0xfLTE
 LzauRUNiUjOqJbbxtt8m10sZkZjErLeh038ianSDEOQ168RvHWnwLWdDo2yNLRbEfxG3
 N21+JDPnLHF/z4HfjPiCMN9lCozWQ+mAa33G51RKUV123ZME8yvf4uWhN07yhujRY8ot
 JP8RqEKb1Nmdq23Yvg6h2Wy8Ht5pdoCyGgUgW5tKJHnXXKTqoC8CchbGpSgP1vJcG/lB
 OVvccovdrsLJW+k2qdnSsNh3Mt4NAolhFN6PcEO5OPbTTh7AKUlAEpfNo1PEoZiirJP2
 GL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279372; x=1698884172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBPTcXjS3BRZCWCMtUYgvGDiz0Qe0sy2s6yIUrx8ZMk=;
 b=dqh0v/+YPCKd4PJYBC/1vyTjSBDgWqVAmr7oSzPTShklI0F7jgdRSUtds6ql0rA+M3
 832zECOQN93g7hTHMNeUzRJruprNoBOx8lzSVKmciipCSTZDnkUG0Aw3RlOJcgSWMVEk
 FcTPS6cSroNm4tGSPfrm9PIVa11e93Cj2pAYvTtvvMMy+6W3HdLfVjjr5faWNG9PeBv8
 hGYwCK0gn3Dr82NJ8zbnymJIGCAigk5pkW5DtiTXU9IxxICNONHH1XtrfR4bNk2xT+DU
 DNJee/l+MLe+MfX4uB2goTiqIpY+rNJMh7zk8J+DVhVF+eAoXI+6VtCug32ADyEwf/gB
 n9TQ==
X-Gm-Message-State: AOJu0YxcZgHCXyhmf64zTCQ130RRuBGDj1sLM5yOyet9+EhivdNKNXJ4
 vKSEcqbI+/NX4REEDSltGWq1YlAQfrDXEno2Lzk=
X-Google-Smtp-Source: AGHT+IGyDYkViIuQhtt2jwGEK/uhgwvs83ZrIzDck3tFKfE4N/h+FNY1ixKZLS74sRygzMoKSPM41A==
X-Received: by 2002:a17:903:23c8:b0:1c9:b2c1:139c with SMTP id
 o8-20020a17090323c800b001c9b2c1139cmr16573429plh.62.1698279372000; 
 Wed, 25 Oct 2023 17:16:12 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:16:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 17/29] tcg/sparc64: Implement tcg_out_extrl_i64_i32
Date: Wed, 25 Oct 2023 17:14:13 -0700
Message-Id: <20231026001542.1141412-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Build fix for missing symbol.

Cc: qemu-stable@nongnu.org
Fixes: b8b94ac6753 ("tcg: Split out tcg_out_extrl_i64_i32")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 19d9df4a09..a91defd0ac 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -529,6 +529,11 @@ static void tcg_out_extu_i32_i64(TCGContext *s, TCGReg rd, TCGReg rs)
     tcg_out_ext32u(s, rd, rs);
 }
 
+static void tcg_out_extrl_i64_i32(TCGContext *s, TCGReg rd, TCGReg rs)
+{
+    tcg_out_ext32u(s, rd, rs);
+}
+
 static bool tcg_out_xchg(TCGContext *s, TCGType type, TCGReg r1, TCGReg r2)
 {
     return false;
-- 
2.34.1


