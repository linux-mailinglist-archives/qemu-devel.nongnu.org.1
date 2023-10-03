Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8031E7B70EB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:33:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkAr-00083m-5h; Tue, 03 Oct 2023 14:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAm-0007xX-G9
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:08 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnkAi-0001eL-PX
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:31:08 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c3f97f2239so10079505ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696357862; x=1696962662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6qLsUwKkMfH3SdTbz6XhvzJrYIqkyqmV5ZdXlf3DNHM=;
 b=VTkaiEeOe+GiTMMXkxsJdljGfWgqtaUnipVYLl/jvQZrwTZKJ0fPQumwwcg5//XTT/
 XUvXcvXfZHfYlU6mSPV+xEolDX28j1OAHFo+IcIkUxAjs8t3o3OBQpJZQOq6Hl4FSbpA
 MS2Q88yTGBWhseh7xyxHklydDYtmEJdV6W+kO2aXD8wanzJBdMbgHyt5Rtym4IT4DxXJ
 ZayaY3ikOqbJcLCBXsla5itW5ZytYf3hIclWFsDorA0qtpZH2n6KS6SaIUKGo95Vmv7w
 OgX9Gd28Gk3LkXxcZ77jwyR8CO69vmPj2t/gx/MEkK3lDDO6wmFF26P/roGt36NGbJGi
 2aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357862; x=1696962662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qLsUwKkMfH3SdTbz6XhvzJrYIqkyqmV5ZdXlf3DNHM=;
 b=L43IZGOd8mDODBPfb5MG1vNyWU/wSnbU/RgBXS63nVFdPRnxSnhLX/svOcy1XoeqWi
 mpfxPmXZDsOad1n/iWIseELPuOWpxmrLadouj7sGIdoLw7GKn+2+ZXUI7OM6Qwk7ZMtx
 3Xw+6fuxEMxiQ/FuNSX2neJIb+z9+krfU34lEl5N8APQh7Fu2h/xjXABo4cZrI4ET+2y
 Q6wGE6F6qDqTwjVBjpkG4x5nM/k+htvhT9NU2wqCU/OMe4POohVeYsyvpy5vvewOd+Sk
 9OrADfImTHCTGBGfzpA7cMKIFofTG68az74O+vI5+18lfZ3Ku2cgZleAdSA29RLeUxwb
 xHlw==
X-Gm-Message-State: AOJu0YyDwnnLvWHqiXXa8HV4L295P6bVPrUcKuZjgHY5zKrLKU/MtPPf
 k4aBFOUG5coCzC63/jscw1jZyxNO+wtUvKuPB4M=
X-Google-Smtp-Source: AGHT+IFkmWOAdPRe4jeL3MZVuJQDdtGS5trJNwId0eaOM4Rcv/XxFgTn3E1QL2S41B5fdw4wFaqnnQ==
X-Received: by 2002:a17:902:cec4:b0:1bb:ce4a:5893 with SMTP id
 d4-20020a170902cec400b001bbce4a5893mr433536plg.30.1696357862370; 
 Tue, 03 Oct 2023 11:31:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g7-20020a170902934700b001b7cbc5871csm1920432plp.53.2023.10.03.11.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 11:31:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: fei2.wu@intel.com
Subject: [PATCH v17 03/16] tcg: Record nb_deleted_ops in TCGContext
Date: Tue,  3 Oct 2023 11:30:45 -0700
Message-Id: <20231003183058.1639121-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003183058.1639121-1-richard.henderson@linaro.org>
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Record the number of ops that are removed during optimization.
To be copied into TBStatistics when desired.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 1 +
 tcg/tcg.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index e49574b7c7..d60349878f 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -566,6 +566,7 @@ struct TCGContext {
 
     /* Used by TBStatistics */
     int orig_nb_ops;
+    int nb_deleted_ops;
 
     /* Exit to translator on overflow. */
     sigjmp_buf jmp_trans;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index e90b0a0c69..60be2f429c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1494,6 +1494,7 @@ void tcg_func_start(TCGContext *s)
 
     s->nb_ops = 0;
     s->nb_labels = 0;
+    s->nb_deleted_ops = 0;
     s->current_frame_offset = s->frame_start;
 
 #ifdef CONFIG_DEBUG_TCG
@@ -3049,6 +3050,7 @@ void tcg_op_remove(TCGContext *s, TCGOp *op)
     QTAILQ_REMOVE(&s->ops, op, link);
     QTAILQ_INSERT_TAIL(&s->free_ops, op, link);
     s->nb_ops--;
+    s->nb_deleted_ops++;
 }
 
 void tcg_remove_ops_after(TCGOp *op)
-- 
2.34.1


