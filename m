Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A9E716204
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:33:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNQ-00076N-7P; Tue, 30 May 2023 09:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zMm-0005Xz-5p; Tue, 30 May 2023 09:26:28 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q3zMj-0001NA-JI; Tue, 30 May 2023 09:26:23 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-53482b44007so2789329a12.2; 
 Tue, 30 May 2023 06:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685453178; x=1688045178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UdXARA3EpNPbqqOH3CYQMWohOqmwxTrOtjufG8jsHQ=;
 b=ergR1ZBZGNgi9XKiZrIEPRJ6yFD07hhHQ5n/9CvCl/Hz8psDKMsvOUlTx43gtrn1Xn
 H/0QBUqY1c10E5vET7aPPTcEcSNsgx+aJS+NXFomELiNUGBsiiI9gJ8yvfdxLh424gEe
 sP7EhcfkqVksNb6r8S4T3pFcrb4YoeK0qFCZJY4V6YCIoxiT+UwIhvoE41YT4wOtiEsQ
 gdt+Z1NZMjcMbInyuFeqUQc+RUEWCXicj+hVUUx5upSxAoRMqqQaY76cgmim6fWF9NRQ
 JXpopwekvv+oxPZzPvlJqqnj0+CwQKrGfcjhXb258yM76Aahz2c5Hh9AVu3EfKaUCGXd
 3aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453178; x=1688045178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8UdXARA3EpNPbqqOH3CYQMWohOqmwxTrOtjufG8jsHQ=;
 b=hhV4k2/bvHmO7KvRe1pJAxiUPT4JM4rpHOUD5zjZfxvZMvuCB2AMQLu9gs2VkRkIuo
 aasxKjjROobqKKQ0K1SATp4jCk6buh83R81CBTx0/MaFGNV3Q6gvFOlA+/OpV0LJrVVw
 GIs+quTY4KTF/ZgzK0R5Ors1cx3e3STxk3tWyXwe3gT6uRaK+lW67GHR05hBhj4oCl7Q
 UvlOsj39LBVzgoiKynankfiUUNM+LkLWdo3sGZ8LWZBrGVS991COD6lZkZQt4jfeDe+1
 pXrZjVXkvpyyfPX1DpayDmAWI5F6vi1vIukPk0ktKqxfp3S93DkyGuMWeeJ06OilCozY
 AsBw==
X-Gm-Message-State: AC+VfDy9jG8qx0Bbi19C49UaGMmetf9eHD5lcTXGLGXv7vgb201X8yo5
 02sNwiqcY8w71xv5xRE1Wy+5mGYxNDU=
X-Google-Smtp-Source: ACHHUZ4u7K4AHdXXY3IPQ9BIDij21A/HK5Bpv7snio+WnDanB00OoRBDIw0otYdYKrN5UIHFJezh+w==
X-Received: by 2002:a17:90b:1d8e:b0:256:bc62:831c with SMTP id
 pf14-20020a17090b1d8e00b00256bc62831cmr2086802pjb.39.1685453178208; 
 Tue, 30 May 2023 06:26:18 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 w32-20020a634920000000b0050927cb606asm8601514pga.13.2023.05.30.06.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 6/6] target/ppc: Better CTRL SPR implementation
Date: Tue, 30 May 2023 23:25:43 +1000
Message-Id: <20230530132543.385138-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530132543.385138-1-npiggin@gmail.com>
References: <20230530132543.385138-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
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

The CTRL register is able to write bit zero, and that is reflected in a
bit field in the register that reflects the state of all threads in the
core.

TCG does not implement SMT, so this just requires mirroring that bit into
the first bit of the thread state field.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 9b7884586c..b6bab4c234 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -425,7 +425,14 @@ void spr_write_generic32(DisasContext *ctx, int sprn, int gprn)
 
 void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
 {
-    spr_write_generic32(ctx, sprn, gprn);
+    /* This does not implement >1 thread */
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    tcg_gen_extract_tl(t0, cpu_gpr[gprn], 0, 1); /* Extract RUN field */
+    tcg_gen_shli_tl(t1, t0, 8); /* Duplicate the bit in TS */
+    tcg_gen_or_tl(t1, t1, t0);
+    gen_store_spr(sprn, t1);
+    spr_store_dump_spr(sprn);
 
     /*
      * SPR_CTRL writes must force a new translation block,
-- 
2.40.1


