Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D8A743CA1
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:23:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4f-0007aw-PD; Fri, 30 Jun 2023 09:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4c-0007aK-Ei
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:06 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4a-0003JP-De
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:05 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-311099fac92so2216391f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131322; x=1690723322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WCk4vvC6feJ5EFGebo8RId3A7LSTmPdZSonDHzt4Yf8=;
 b=CVWFnHbsVL7MM6NcZy0kv7Dp0gaqrqAy0Zwn2rtPPhI8Obq/LTFhYUazYMtxnrdO4a
 rep9vjz61rTt//5G0jwV/UMSICjzpPBLb8ac7i942N3xB5oMujq59w3MVJXC7O59Lrah
 MoJLm61z2/xnDlA1ggXmQFRI1eR6JxSjrdvl2KhCXLmC3ABX/+iqTzsK+sfdCk80RwZm
 3EetIYjlpS3B1vNjVF9LYD49vDW1i1Eha4izsgmeC4xGd29lgQTlEcvWGU047KD0giQ4
 FW7cBE/cRSTo40Oc+17KY8MdHY4PzpcUfxNIhrN3u9gGC8X7w5hpAUgHly+JyZKrMih5
 MW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131322; x=1690723322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WCk4vvC6feJ5EFGebo8RId3A7LSTmPdZSonDHzt4Yf8=;
 b=e7I4PYp1CfJT6GngHkXljaeke4OWoLu518RkxsaNK7q0UJ4x/f01RCDyw3TRgPLHxQ
 pj/cpSBsuL3WYT2zP4IlfKsTPAun2qv8IYj0/UQMETDFrSE5vUINaUKpEfsNKyk4h6f/
 GsRBjaQjOkSnaJrIX2vjrdOnNKeIkjf00XUMjiK1sWJ6zkfxVmZjs9OQHjStGvVfMBBw
 pmb/d+vez735iyoEjVAOc5/qaR/aVqODCUh0Jwwf/2S9P6p3SpIU0NOOxJn9eVtRopbO
 5QJlZoWxVVhI+s7CAHw0wwEY9k3JFc4xF+msihz2kPoRBVKCJIbDCgZr8bgHVX/xlv23
 D1eA==
X-Gm-Message-State: ABy/qLbzH4ROVmQOMow88wycZeW+sFsmL0UQls4AvI1M0/3rvThLssFy
 AskKvso3uXqX/d/57TX87XNF4RWFk3lrFZvZmphiAg==
X-Google-Smtp-Source: APBJJlFXeea4N9e/QbNTRyTBvHcqzWJUP/g4JZkBzzsPYDahi/3MZ+KEwguASM7BqxGft9CypoBEhA==
X-Received: by 2002:a5d:660b:0:b0:314:37a:4d2 with SMTP id
 n11-20020a5d660b000000b00314037a04d2mr2219281wru.60.1688131322094; 
 Fri, 30 Jun 2023 06:22:02 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 01/24] linux-user: Use assert in mmap_fork_start
Date: Fri, 30 Jun 2023 15:21:36 +0200
Message-Id: <20230630132159.376995-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

Assert is preferred over if+abort for the error message.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 0aa8ae7356..83cbcce769 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -49,8 +49,7 @@ bool have_mmap_lock(void)
 /* Grab lock to make sure things are in a consistent state after fork().  */
 void mmap_fork_start(void)
 {
-    if (mmap_lock_count)
-        abort();
+    assert(mmap_lock_count == 0);
     pthread_mutex_lock(&mmap_mutex);
 }
 
-- 
2.34.1


