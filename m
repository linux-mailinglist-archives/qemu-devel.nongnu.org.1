Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3987CEB52
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:32:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzY-00087N-JI; Wed, 18 Oct 2023 18:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzU-00086f-Qq
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:12 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzS-0002U5-TB
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:12 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c8a1541232so63879555ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667969; x=1698272769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eJDwvSu5y6aQI1FUpLq82z/uiGp428KQX4VVdh13eIw=;
 b=kgyhGm4yR/esohGdJ5PzSpqwAYS2rdE+5onU0lW7VqOJr5BF0HOcd3z4giSDI6tBhB
 /IXjnyb4GodbRA2FF+AzuN2wBhC9RFOdbroFNJDZyrO6x4514iaMfloWSQKfXjzSvJbA
 3Hb9NuTqjvLzPfuz6K8oM4LETIX7hnV0kelR/KIhrGWpdor5ev+WW9r8G4EQA5pfVHIQ
 BemIzneZwRgTeP1jjik3nmP/0gVVGvz0EtxAZ3uLg3kMDTDJemYVPlB6pAWkfQ2ieKkR
 qG0ZaYmPKWXxL1LKqYhDB2PqyiPTP4rcpPpleNPSlojqqN9MaM9S4/A3F2ZLRYbegB6Y
 CfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667969; x=1698272769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJDwvSu5y6aQI1FUpLq82z/uiGp428KQX4VVdh13eIw=;
 b=GTVKJZKwV8MZoiclyEdSa3qbatWF/FQfsBu7gzoxTSl9nhDRvv023zWlxlQ5Gd4XmQ
 WfOq+TqmCn1ym0wxDlakZ1WiM0XSjJD88hJN5U8sfnzxSSf4vJOq9ZGmASg51XzSk52m
 O3qb9PySVgS5XCF0Yig3XhOxZWnQTDBpfpoNG2h43WrUKlm0a1aoPHqZiNeMpoPlE4qc
 Y1fAE22VSEsDPOP/ZSHi3HDvkzdVSbdxGlug8ITyF5b/Oy09HRHP4fFb5TcL3QSZIrYi
 aorhi7zJDqQbL4UP15nqSGVwYukcuK7P+G+kG5ch3vZbfb3mDlpqsBYZmS54XRXAGl98
 0Bbg==
X-Gm-Message-State: AOJu0YxzwS8egClxiriIKIm0LCjVoRmSP6zYYXPDEXRBUN/Fliiyn/zo
 54VQ6YvVskqJHmCuMevpbIliO6HqAqrX1w3B24Q=
X-Google-Smtp-Source: AGHT+IHSpv9GYsNDXFHGqDsIcMfrqd45VsCgJhpzDLeKzosiWkdGFp8fnPgSuiZfc7L67g1YBy5g3w==
X-Received: by 2002:a17:902:f682:b0:1bd:aeb3:9504 with SMTP id
 l2-20020a170902f68200b001bdaeb39504mr780901plg.15.1697667969689; 
 Wed, 18 Oct 2023 15:26:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/29] tcg/ppc: Use prefixed instructions in tcg_out_dupi_vec
Date: Wed, 18 Oct 2023 15:25:39 -0700
Message-Id: <20231018222557.1562065-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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


