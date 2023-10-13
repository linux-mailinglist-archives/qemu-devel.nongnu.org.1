Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF977C8C1D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:11:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLgO-00014n-2T; Fri, 13 Oct 2023 13:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLgC-00013Y-7o
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:29 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg9-0005aX-9E
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:27 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-57bb6a2481fso1235347eaf.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697217024; x=1697821824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJDwvSu5y6aQI1FUpLq82z/uiGp428KQX4VVdh13eIw=;
 b=rPLGpPW/GmLywRdTtg+2xEgOJvhqMV9a1xw0lVYRD7mrM3pyKg506U19qhAf2ntA+s
 BWc91fCklah+xonQJmR///A5kP+yQUkE++NiSLAyjM1M38GVuOmqzPRgHBkn5ARPDrcs
 PtdQVUULeAaDd1fttFQtgZnyKkWVEDVpRK0WZzelovuGmH2zrpsXS9s+EoPeNawwdrZg
 Ibq7BDVXOiHwLL2YXSmAY45Py2hf3LmK0M8Z1DRKbNgXs2IojHFF9/xQN1bf+WGy8gk7
 NPljP2eZtMIUWpgPDVGw6sr1i4GaBWFUMyFOhiNZOi8mpY4d34oBq01R66LuPab6JY6n
 iIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697217024; x=1697821824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJDwvSu5y6aQI1FUpLq82z/uiGp428KQX4VVdh13eIw=;
 b=sogcaRF8W+5yH9jSWOR8KV91injEupOj0sDJUqqhMo6JTm7txKMdOsHnYfgahRBKZ0
 a5LNJLbsBmPXITtlgBVZagxXQOwltNMxvL0n7/LEIOu+LTporupJRVnYaDkvxQqvp91E
 FGlTMWbBfbq+lNYenqERtPX/DpMN1oHzqGxGGyyVOcgb90Vb/i0z8YizEvKduONZeLGT
 OG/EkvMi25pan5yxKi8ipdnGga6tQGYxUIOnEWTHvlFUe1TSK3wi7iHm59X0wgWR6DiE
 vTCi+MNFzIcVvjb6rQqEX98HViQF5Dkt18jBHT9abAAEDDUOOmUZ1Nw1Mo7uxAVPip27
 2SmA==
X-Gm-Message-State: AOJu0YwwsUWn3UeKIL0kWIXWaY95S5HSxhZnxB8T4f2Kljn9OKGfar85
 iy67z6WIOHE/wfkbmr/itzSDajltLmf4vART4VQ=
X-Google-Smtp-Source: AGHT+IEKu3F2JkgAv2sZGnQguRTvryWdHrNt3sZ4fUoiBL4hmgqOufaG28JVldSzGIwZWcC/h2zBHA==
X-Received: by 2002:a05:6358:2624:b0:142:d097:b14a with SMTP id
 l36-20020a056358262400b00142d097b14amr20704937rwc.13.1697217024032; 
 Fri, 13 Oct 2023 10:10:24 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00693411c6c3csm13687926pff.39.2023.10.13.10.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:10:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com
Subject: [PATCH v4 11/13] tcg/ppc: Use prefixed instructions in
 tcg_out_dupi_vec
Date: Fri, 13 Oct 2023 10:10:10 -0700
Message-Id: <20231013171012.122980-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013171012.122980-1-richard.henderson@linaro.org>
References: <20231013171012.122980-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

The prefixed instructions have a pc-relative form to use here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 79e82d2f94..db3212083b 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1242,6 +1242,15 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
     if (USE_REG_TB) {
         rel = R_PPC_ADDR16;
         add = ppc_tbrel_diff(s, NULL);
+    } else if (have_isa_3_10) {
+        if (type == TCG_TYPE_V64) {
+            tcg_out_8ls_d(s, PLXSD, ret & 31, 0, 0, 1);
+            new_pool_label(s, val, R_PPC64_PCREL34, s->code_ptr - 2, 0);
+        } else {
+            tcg_out_8ls_d(s, PLXV, ret & 31, 0, 0, 1);
+            new_pool_l2(s, R_PPC64_PCREL34, s->code_ptr - 2, 0, val, val);
+        }
+        return;
     } else if (have_isa_3_00) {
         tcg_out_addpcis(s, TCG_REG_TMP1, 0);
         rel = R_PPC_REL14;
-- 
2.34.1


