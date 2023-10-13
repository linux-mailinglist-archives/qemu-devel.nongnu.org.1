Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A7A7C80E9
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:54:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDtw-0002pn-3t; Fri, 13 Oct 2023 04:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsm-00078k-Tz
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:59 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsl-0001cU-89
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:56 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-313e742a787so1144823f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187053; x=1697791853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JvnQ2bCr8avBvltEi0ERRv9qNmrE+W42qzxZRuWjpg=;
 b=tg4SiZhfXR1D3VN6dxkzH0cOaToRNhvvDfXQKswYtP8fZos1rR4gxiE8UJjgylkxpv
 y7RlnWhceAItFVriWvpUj3BfzMsFg9Jb8mM0SVUaXGpTqRCnlVHc++NTAUrejY6GF0Wo
 m4c2sQtRth1ujR0o5wlnuG3MQsLp5yThWBErRInnzoX8leGGNc9HV2NU3Bj6BYZMryGG
 Im3PCYNWER0yilNkEOwWJQl1t2aiSHRqGa4p0bn13iMbVEVQ1isDLt2E4E0ZGM0cCVtF
 QM0TUw3/+JFEErD8xHccoR3Zm1zH9+dDdtjy220cXXfjkFbk/YtYXdR99GIw4XuP0yV1
 S7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187053; x=1697791853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JvnQ2bCr8avBvltEi0ERRv9qNmrE+W42qzxZRuWjpg=;
 b=ipjvdr9ZfarCv0wWbsI3XeYHF/n+oPTjtNkIoFTQZbY5WzNFiOZMQeASXse7aBF995
 zp2MBXY62ByUOKh3gwD7pzzdD1TRqGDczAoLzhDEvkNpbkoV8qkBW9LKWcUhqDZ+r3BX
 NEaCUC10sv9CKlocBFkzpeyX8Bcmim0f59IMRuHiaUzCHD9j8jU85q5waJ1gPq+ubQC2
 kl4NEy0CGK/yWmRDj/UW79pRYzVpc0e7jaUqZmD/3iTZqK1eIyWrac+T+sxYu9sCRhv+
 C0+KaZhm7wZRIj57Z5DU6MtexmuH93VVl3VlBuW1iF4WkYdxtCvPwxUO1XW138PJyDGW
 150A==
X-Gm-Message-State: AOJu0YzFavvCB7vYO6v2faKDheB824WNAFhMgpAcE5fRdvsmwe+4vuGG
 2Bfh0d4xG61FNsPl3KbPHmv0qZAMtgarhc87NGk=
X-Google-Smtp-Source: AGHT+IH07QSeh5nem0+CseAuLiQCIrNRPGBclM3VLgYgeZD36Yny9Uc/ArUp4Tn0zNOxHzTG3SFzzQ==
X-Received: by 2002:adf:e4cb:0:b0:31f:a717:f1b6 with SMTP id
 v11-20020adfe4cb000000b0031fa717f1b6mr19447738wrm.11.1697187053747; 
 Fri, 13 Oct 2023 01:50:53 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:53 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: [RFC PATCH v3 75/78] migration: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:43 +0300
Message-Id: <60edc70e7ff41ee87e39884a5fdf87fac1bd9f77.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 585d3c8f55..fdad37efbb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2784,7 +2784,7 @@ static void migration_iteration_finish(MigrationState *s)
         assert(migrate_colo());
         migrate_start_colo_process(s);
         s->vm_old_state = RUN_STATE_RUNNING;
-        /* Fallthrough */
+        fallthrough;
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_CANCELLING:
-- 
2.39.2


