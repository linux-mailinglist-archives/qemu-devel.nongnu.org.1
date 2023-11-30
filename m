Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 839577FF99C
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 19:40:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8lxD-0004Tv-JD; Thu, 30 Nov 2023 13:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1r8lxA-0004TG-Tv
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 13:40:00 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1r8lx9-00043q-Gc
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 13:40:00 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1fa37df6da8so626085fac.2
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 10:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701369597; x=1701974397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CZ1rg/KJwPlerOGXgxpRsvRdTr0rTqRqbRHgz2vDDTM=;
 b=WuRI6Zt70e1X8RVuy3xnTc+9cR4rUMhXZ5+14JvkITiI8KsxV+FlK0Pa0aXi2qC6hE
 4w4c4KBTql1tlFXpOC0LxWuHph1/HARtjVStjhYOanFPI2hzgkC+GqQpt5mY4LCZymrp
 S2tl35kLJv3dFqmvICIY56leAfbVKJ98u15kSLVBEU8mkT38zcUzgXONfLy4ySqsaVjf
 2kci0Xd0uY7kY6U+rM6Fd3Imih62KYoKSlNGgPr0FtyWO6EA427iIupuTPjFk0wo7RGs
 NO7q20sgFjgtqhWGT7ycz8dPlPgYdgp4up4r1coE1dHmwQmq9pdWtgKQ1oRJmaDbJ5Wx
 HdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701369597; x=1701974397;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CZ1rg/KJwPlerOGXgxpRsvRdTr0rTqRqbRHgz2vDDTM=;
 b=ZQg3jVA8UvdABlWkf0V2YLIIp1QI9x6bAo3S8IHlyPB6Y59sOze9ZCE+6LbyC/6xhH
 zlYWLEZ/YRvU74TjoQp4oqIAyUDi4dTQnqXsKv5YwM/I3hj/rm83swmZYsYdih+1YIZt
 Ww4GzqjynHF+oPIBpXP6EAOtup8Q57BLPx1cnX95dEe2d+7ARWJmIs34Sg+fWq+tBRA5
 RqZ2UoAv1VZLsqAoYRETWXB5TxpSDNbBJrxWyqv4ZmOJy3DPsFZEDVb45iO/E1FvsQ61
 rlgm0tUqlrvRL12bHfX60ugRTsiwEqxB5Y/FjTF4prO15I3xbXPa26MPpOZDev6Dfsa2
 nvMA==
X-Gm-Message-State: AOJu0YxX5UFXpnov/rrSBWvsuSIfsL2w8MD2/IMKY3SCwOW6P785IC91
 MqjcLiWD1iPtdlg17Cijpwu0X+iEjyMKVw==
X-Google-Smtp-Source: AGHT+IGRAQhUN6A+hv3f2v1unNYbgGvc8cnugRyPrWt+OD5a7EMgivRTJkdMeAqsmPevGSHHeMv7dw==
X-Received: by 2002:a05:6870:f78f:b0:1f9:574c:b5ec with SMTP id
 fs15-20020a056870f78f00b001f9574cb5ecmr30935190oab.27.1701369597145; 
 Thu, 30 Nov 2023 10:39:57 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 gc5-20020a056870678500b001fa4f5ffd90sm384372oab.26.2023.11.30.10.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 10:39:56 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH] Hexagon (target/hexagon) Fix shadow variable when idef-parser
 is off
Date: Thu, 30 Nov 2023 11:39:55 -0700
Message-Id: <20231130183955.54314-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oa1-x31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Adding -Werror=shadow=compatible-local causes Hexagon not to build
when idef-parser is off.  The "label" variable in CHECK_NOSHUF_PRED
shadows a variable in the surrounding code.

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/macros.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index 9a51b5709b..f99390e2a8 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -93,13 +93,13 @@
 
 #define CHECK_NOSHUF_PRED(GET_EA, SIZE, PRED) \
     do { \
-        TCGLabel *label = gen_new_label(); \
-        tcg_gen_brcondi_tl(TCG_COND_EQ, PRED, 0, label); \
+        TCGLabel *noshuf_label = gen_new_label(); \
+        tcg_gen_brcondi_tl(TCG_COND_EQ, PRED, 0, noshuf_label); \
         GET_EA; \
         if (insn->slot == 0 && ctx->pkt->pkt_has_store_s1) { \
             probe_noshuf_load(EA, SIZE, ctx->mem_idx); \
         } \
-        gen_set_label(label); \
+        gen_set_label(noshuf_label); \
         if (insn->slot == 0 && ctx->pkt->pkt_has_store_s1) { \
             process_store(ctx, 1); \
         } \
-- 
2.34.1


