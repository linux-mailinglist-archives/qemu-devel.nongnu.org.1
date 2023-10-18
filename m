Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3543D7CEB53
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:32:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzj-0008Cl-OM; Wed, 18 Oct 2023 18:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzf-0008AK-Vw
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:24 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEze-0002WQ-Gw
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:23 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c9fa869a63so37239135ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667981; x=1698272781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qq+/ocKlHxuwOLYzAnqcUyLG835LUOMki3n0K/cpOvs=;
 b=XjfzpNBS+3c2+hjem6mOqS4IFEiTXolG/SEECoOCTFI4Tw2oICEmqKo7eQ8j5wuLWL
 8WYCZs5QLB60Yunb+Z+ZOjMapJQ0Fvdgp+nwUGTnxmeyRtqVjd44hktw9LmulRcKhTXU
 9KaO6mkprzEyh6c+kng1VzTZjDFDgR2RktQm6uftylK+gKw4CPt8j+D3JW1JlFj8/vBQ
 Md/J6d/jhn6e80nr0o6wCCwal1SzvigP0LynashOFQ3cQba+J7twFSwzG0aX707rjM75
 7O1H4+XT87lLZIHm5xd2k7iHZOGb0tLO/w3pYyDr2gHj3SzHVc6o7tGoTzDKBmCMbqva
 GjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667981; x=1698272781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qq+/ocKlHxuwOLYzAnqcUyLG835LUOMki3n0K/cpOvs=;
 b=YsiHGfVtlvMJN77RO6DA7cdjUcvBjRfPLJOvXFANQ42ZHmsE8U0miyuuwVHdOIc04w
 l1Qe358ewDOP+7lLOMdS90UZM6ML/TONFWJgO4HorQOpv5d4YRKi8gkTg0ZG1b9ETymp
 /JPgiPzA2Eo9BfesbC91QwGZr2Nw7FYBDm1A6zugfsvr0xfNJYwcIBZUIY6/a1EECSYQ
 clp3PXEpMFMaJ4Mpgel4wt3o8nikgLfqbFfRr6ZjtRdKBuz+7xegCTbXjRYqQTGqsidJ
 pJybc6rnRCanBc73HQ3YxOFogQUxxQ6/F26TKstDp7gPdK7gTkWXLG21+aYVLboODpkC
 uZfQ==
X-Gm-Message-State: AOJu0YxU5r33GuX3JUniBocBbyx4PFjvTiPrm7sbDUAAog/i7hSeYmzr
 XB8MfA09KG4BH/LadHB4GuRUIrimRYT+00R3cSA=
X-Google-Smtp-Source: AGHT+IG5v7ZRWCoZHAPxcFNIinbmMnYxJOVT64EdD5c3iHyKUxg2xEBZ3ZmYBoNCPeV7/nlDQSTAvQ==
X-Received: by 2002:a17:902:da8d:b0:1c5:de4c:f079 with SMTP id
 j13-20020a170902da8d00b001c5de4cf079mr828068plx.33.1697667981229; 
 Wed, 18 Oct 2023 15:26:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mike Frysinger <vapier@gentoo.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/29] tcg: drop unused tcg_temp_free define
Date: Wed, 18 Oct 2023 15:25:53 -0700
Message-Id: <20231018222557.1562065-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

From: Mike Frysinger <vapier@gentoo.org>

Use of the API was removed a while back, but the define wasn't.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231015010046.16020-1-vapier@gentoo.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 80cfcf8104..3ead59e459 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -52,7 +52,6 @@ static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
 typedef TCGv_i32 TCGv;
 #define tcg_temp_new() tcg_temp_new_i32()
 #define tcg_global_mem_new tcg_global_mem_new_i32
-#define tcg_temp_free tcg_temp_free_i32
 #define tcgv_tl_temp tcgv_i32_temp
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i32
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i32
@@ -60,7 +59,6 @@ typedef TCGv_i32 TCGv;
 typedef TCGv_i64 TCGv;
 #define tcg_temp_new() tcg_temp_new_i64()
 #define tcg_global_mem_new tcg_global_mem_new_i64
-#define tcg_temp_free tcg_temp_free_i64
 #define tcgv_tl_temp tcgv_i64_temp
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i64
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i64
-- 
2.34.1


