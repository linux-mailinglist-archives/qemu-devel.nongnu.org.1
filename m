Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7696786157
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:24:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOY-0008Le-R8; Wed, 23 Aug 2023 16:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOU-0008KD-L8
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:58 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOK-0005Ub-Dc
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:50 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bdc19b782aso41151525ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822224; x=1693427024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xi3TssmA/HigYWFgy245JlLJX03+VaDfRVBuqb9pW5c=;
 b=jeHYdHVx7G26OSHg2qLUjGik1KPZAAF0dENH7IaHuBbqUuOpCZcs9uZwz0ctXpGCdj
 dbuXF8oqBFbMvteERt21z9uYyrOmHC+bYN46OqYvnPibJPR5SOeK/AlEZKTaAr5wgnr5
 nB1ZG8AcKzsK+TgoQ8Sqca/WCZU3iPDFabUkYW8UJju9bvYcAXuXDFuUfPs66sDSo+cY
 wNw1yVJrrnC2XUYl1Cw5M9evAWIFzjTvwxnL5GaKQXp04WTc3D0k31hs337tI2POd5a7
 l5hb1JiXTDd5HktZxoqJ08LdXusCk1DvZBiEujCPuwYoVDu0dyI9zBnE5ZxzIgbFdxMV
 bOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822224; x=1693427024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xi3TssmA/HigYWFgy245JlLJX03+VaDfRVBuqb9pW5c=;
 b=OfivFUQhJlEyi703Z1O9jA8o+GN854GR2zXyYkriR6cuayPkAGHvr6UURbJw2eivsf
 sLdUH2UtomHt5bFSGRaV8HMObXL3Ns4zQ8rqxnsKrsULjkO+PV1I31JMgZ5NaTLhW0Hz
 nNPvhO569jDyMvMp8IxHgaxwajYDcOIQnn/kKyM+HXX6yC9m6hXkkq1EBMAHF5HMgWSK
 50+jqcgHw+K6Zf0TzYXsFq9RHU/CrTA0oBweqRWhruKuY276EvYjrY3nUTDtfGSqSlfz
 ZDbSeC7nlfWkVrwfC+hWAT7ubAwsIL+XxDpiNc0h3vAcb6UxuW9zGFGVs4bBRhWngaPF
 OWeQ==
X-Gm-Message-State: AOJu0YzhGMOFFhKbebjqQxrwRsxXeFTyQo2PkCaJ9oa+EBEAp5dM/MSD
 8fg2Lv1ezJo8wc4UAx6oZt/uqjo874QkcNdq+i0=
X-Google-Smtp-Source: AGHT+IHD5jvg1duptqf0W4I+h9UchgcXWAPldUcX0JhkeBT+SBxyv8FSaOcKc+8+oWXpURiU4iddKg==
X-Received: by 2002:a17:902:dac9:b0:1c0:b8fd:9c7 with SMTP id
 q9-20020a170902dac900b001c0b8fd09c7mr1817008plx.43.1692822224674; 
 Wed, 23 Aug 2023 13:23:44 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 18/48] target/alpha: Use tcg_gen_movcond_i64 in gen_fold_mzero
Date: Wed, 23 Aug 2023 13:22:56 -0700
Message-Id: <20230823202326.1353645-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

The setcond + neg + and sequence is a complex method of
performing a conditional move.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 846f3d8091..0839182a1f 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -517,10 +517,9 @@ static void gen_fold_mzero(TCGCond cond, TCGv dest, TCGv src)
 
     case TCG_COND_GE:
     case TCG_COND_LT:
-        /* For >= or <, map -0.0 to +0.0 via comparison and mask.  */
-        tcg_gen_setcondi_i64(TCG_COND_NE, dest, src, mzero);
-        tcg_gen_neg_i64(dest, dest);
-        tcg_gen_and_i64(dest, dest, src);
+        /* For >= or <, map -0.0 to +0.0. */
+        tcg_gen_movcond_i64(TCG_COND_NE, dest, src, tcg_constant_i64(mzero),
+                            src, tcg_constant_i64(0));
         break;
 
     default:
-- 
2.34.1


