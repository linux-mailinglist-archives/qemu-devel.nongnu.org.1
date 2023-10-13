Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 009D97C80BE
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:50:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDpd-0007Rr-6H; Fri, 13 Oct 2023 04:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpS-0007H5-Kl
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:31 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpP-0000jo-T3
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-406618d080eso19641065e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186840; x=1697791640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAVHThvK+F2Vg3kNZE+qrXSgyNRN8RtaukB64UY3RKk=;
 b=hXmkj+gxqRo9PTyzU+7YqbQnojir2FNB3v1hwgYCFbdcFI2/5zCnxhYqeSLPvWpLLP
 zyi24nxiStrnD/gVubidx8DTTEYyO7n17CfAcUmsxXyQJ2j6Gt3NsMwxx3O+SRPduBHf
 8wz+nXDnSMj23zG34ulTSOqpo8NBs4Vdv9NlifffXbNpcOvH8fsAquA183nHq2APP5L9
 d7ySJAzjwAfE+JpAwBze4s2n0AltfYY7OZMMDso50zv+w0EA8WzU2MCTlGdrXlIHQIFF
 6oDVWLLXI6jzALmMD/TNiYP5yaGWWtd6z5h4C1+UEgNJzTYI9lpTGJV5/36kTvcp1Kr7
 gMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186840; x=1697791640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAVHThvK+F2Vg3kNZE+qrXSgyNRN8RtaukB64UY3RKk=;
 b=WKyxAaMkLZwh0bwURS/Ub2fVBt4vkes1JdnhdNKh44UZ8t67o3NP8EmRAFFAIFWblG
 FelY9rG0ZjEmKpoSMfF0ZTyxY5b6H7DSWQ6gY85X6aBrVxHTSe3uAgtrolMUQx6demHM
 g/OjP2JLAMzOo4qI4F+SMGAc5lpmgvttfhRoBG1xyLNrJKNhyhCyLopHD2WLR/GP3lbz
 VUeBOTBB/GdoUMTBsowZEhQSh8Zb3zDq+FH6npHTWUMUSyZtKNAKD+ErahjAJ1F8R93G
 bNrHB1BfgJeYzYgGUlg/P2sqF4PZCghYTgxRkCrhA+wp/WaIsOrPMvGwITQ2i8pvcxpg
 072A==
X-Gm-Message-State: AOJu0YzpXl3HLkSv+u5CGOw5gWU4CyIwtdqvSAxcMrVzZ1xDmwunVeOJ
 zJo+gk/NgJ70HjoGQLLjgCk4ie/EWe80YQigYfQ=
X-Google-Smtp-Source: AGHT+IHXdietNKwR8CMnFpf2HSz6TLxKH89hp0MFe03wA5/xCtbsqrkBFWT1F5jG9Xms+4NaJzavLg==
X-Received: by 2002:a05:6000:228:b0:32d:8466:498a with SMTP id
 l8-20020a056000022800b0032d8466498amr6052156wrz.48.1697186840016; 
 Fri, 13 Oct 2023 01:47:20 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:19 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [RFC PATCH v3 04/78] qapi/opts-visitor: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:32 +0300
Message-Id: <da9d0ba48a5be92f212e6bc04710803ca0ffa7b3.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
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
 qapi/opts-visitor.c         | 1 +
 qapi/string-input-visitor.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 8f1efab8b9..d7376bf239 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -266,6 +266,7 @@ opts_next_list(Visitor *v, GenericList *tail, size_t size)
         }
         ov->list_mode = LM_IN_PROGRESS;
         /* range has been completed, fall through in order to pop option */
+        fallthrough;
 
     case LM_IN_PROGRESS: {
         const QemuOpt *opt;
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 197139c1c0..1ce43da20b 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -202,7 +202,7 @@ static bool parse_type_int64(Visitor *v, const char *name, int64_t *obj,
             return false;
         }
         assert(siv->lm == LM_INT64_RANGE);
-        /* fall through */
+        fallthrough;
     case LM_INT64_RANGE:
         /* return the next element in the range */
         assert(siv->rangeNext.i64 <= siv->rangeEnd.i64);
@@ -292,7 +292,7 @@ static bool parse_type_uint64(Visitor *v, const char *name, uint64_t *obj,
             return false;
         }
         assert(siv->lm == LM_UINT64_RANGE);
-        /* fall through */
+        fallthrough;
     case LM_UINT64_RANGE:
         /* return the next element in the range */
         assert(siv->rangeNext.u64 <= siv->rangeEnd.u64);
-- 
2.39.2


