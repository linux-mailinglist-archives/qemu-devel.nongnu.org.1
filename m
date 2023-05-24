Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D15270F7EB
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 15:41:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1oik-0008NF-Tf; Wed, 24 May 2023 09:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1oie-0008DB-ER
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:40:01 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1oib-0003m9-Sr
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:40:00 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3093a778089so578412f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 06:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684935596; x=1687527596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qglgXO3384mpR0z3xJrO+Vr6cI8uX9097a2UR+OWg40=;
 b=EFaTwHJqn3YDbgs4WaTj7W02Z+GWi0caGdP4kAyhuhIdrc0Q6NbgdI4xvlASC3ah1Q
 9kh1Q8BuST9pA2um+QIMSzPDePf5fQe9/q3lSNZVLH3mCEXbW6h5IEeEMzta7erF9h7h
 QU68nMwkg+Vvex9HOZVz1x+i8Xj6shSzWcJFEktxf56oybSpjpLtDdywlXZ5XE4KO8Bl
 DaodG/AONh6MhDngY2s8zE910t5bSUK8u8AnC/A8m+Fm1LX9qgzQnvmseuKgKiZFUwSu
 PFRbjRmNHXxpOAZ6lOF8Wv04jFwYhtKnZ5WpTUgNJqRJo0ulYuOZHPnij2E7bRxGXMCe
 dUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684935596; x=1687527596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qglgXO3384mpR0z3xJrO+Vr6cI8uX9097a2UR+OWg40=;
 b=UFbNMvzJTrKr1gGxALLSbu4Ax4OBfQIjNgoASS0QOwknwU1dQ/XO2ooRBu5bz/OimW
 DWa21GHsBVh2y0c1+xUTDzfJ6bMoWLWpVn0wHaoijdNwTOPQMgEHeI2zyf9sJ+IkyKkJ
 ClEG9I61fJ8+Zln/dlO/W9qlZtbizq6OrJGbWriQaIQYq9ZldmE289+uDGiznyUWJZJr
 mY3y+LaD4PU/h9z/gkc+m+aFvCMjB+lHMjMoNyntAM+Fi+lq6P3+zEi5fzor7/8Bl5Er
 Mhebs+LQVTsJfCNNqkN9drlkbcBcrshNMFDXWrweTC8EvhoGOnpFMZs95CV6Oz7Ym0Ky
 ipJw==
X-Gm-Message-State: AC+VfDx7wmS8EPGTlTyEDE1ZtyLdKIASks/p7XhUT/FM3Jd/pGg4RlnW
 BWYFSUxETbLX4s0UyqZ8/NmI9w==
X-Google-Smtp-Source: ACHHUZ4FIj/gVQ3sXfxjhv+lJ2b4g3GpupDxq3YzcE0ptRWPTpv/5ZKlTp7wzV9N9uSNWz0TUJH3dw==
X-Received: by 2002:a5d:4ace:0:b0:2f5:3fa1:6226 with SMTP id
 y14-20020a5d4ace000000b002f53fa16226mr13167144wrs.14.1684935596268; 
 Wed, 24 May 2023 06:39:56 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c12-20020adfe70c000000b003078cd719ffsm14520773wrm.95.2023.05.24.06.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 06:39:55 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 125611FFC3;
 Wed, 24 May 2023 14:39:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, libvir-list@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v5 09/10] hw/9pfs: use qemu_xxhash4
Date: Wed, 24 May 2023 14:39:51 +0100
Message-Id: <20230524133952.3971948-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524133952.3971948-1-alex.bennee@linaro.org>
References: <20230524133952.3971948-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

No need to pass zeros as we have helpers that do that for us.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230523125000.3674739-10-alex.bennee@linaro.org>
---
 hw/9pfs/9p.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 9621ec1341..991645adca 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -738,15 +738,14 @@ static VariLenAffix affixForIndex(uint64_t index)
     return invertAffix(&prefix); /* convert prefix to suffix */
 }
 
-/* creative abuse of tb_hash_func7, which is based on xxhash */
 static uint32_t qpp_hash(QppEntry e)
 {
-    return qemu_xxhash7(e.ino_prefix, e.dev, 0, 0, 0);
+    return qemu_xxhash4(e.ino_prefix, e.dev);
 }
 
 static uint32_t qpf_hash(QpfEntry e)
 {
-    return qemu_xxhash7(e.ino, e.dev, 0, 0, 0);
+    return qemu_xxhash4(e.ino, e.dev);
 }
 
 static bool qpd_cmp_func(const void *obj, const void *userp)
-- 
2.39.2


