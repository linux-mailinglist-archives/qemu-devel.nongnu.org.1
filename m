Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B43F78B650
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:22:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qafvz-000584-Cs; Mon, 28 Aug 2023 13:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qafvw-00056K-W5
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:21:49 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qafvu-0006f8-Re
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:21:48 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68bee12e842so2315029b3a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693243185; x=1693847985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+M1b4oBXMxVhhUnSSd4fdMxTnS6/iN50/aUGAiSJHs=;
 b=o5W8Ov5S+xXMkhtLjCWgo0Yhtt9pzQUVw5P1dARwQx8OAtLtlkUBjfggOtStrhhBVi
 ZkFiIAwYmMilOWEcvNlDaYFh7NntBUB2txgGunI6rhZvIj2544UXb2kTHm7sbd7z11mn
 G74A1GlbJwK8YLJ4vYP03ZCXvVObNYblFKTPFOE6LZsvxiQkE64i1VNssxpGuZ2msdsF
 omqUWWqj/M/66ullt4aViIN1NiryOOvKH+9KX9+qcLLeJS3ZhNAeszFmHcxPTwqmBbXn
 1hm1rFaaXvUCnOiMg6mdAxpXQOh/o+/oCU59RdCNR5RDLBFPbo34N/gdZ+8agSf3Jrjd
 eltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693243185; x=1693847985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+M1b4oBXMxVhhUnSSd4fdMxTnS6/iN50/aUGAiSJHs=;
 b=H3b+clJ+eo7UPyi0xmmHL/3j1ll/ePZj71dNnvLrmc6il6RVzY+aFPRXRa7pQZfG4s
 pbV7tn7nH38wpGf3qVFH6qQMJKH+8yOprKbfaYAnhwLFpuYaR963/sK/PhB1KpyGRLCO
 GY7DCgik/HY5lu55wUcPdl6SVAeXHxhRkE9dEJC6fhV4GZNKu3AnbqgT4pKZOk8SMrH5
 ABSD2YZZtxl+qb7PDfaB1lhEnPTC/UxtNs27AYBXi0Zv89x7D5YPrL5LYFqx9ZdIfQZc
 ZL5HwhBP+Htt2YQOEZhei44kTgFvhOzTN61Dke3uHZOKStCC7YUMgD7XqmFk6wnHl8pU
 0qhQ==
X-Gm-Message-State: AOJu0YxYJmD3SkPfhNarJwslTolniQsOCVj49Xa+T3R3WiunCS122dNM
 LDf9eWRt2cCj6+hHhx1YsIalj7yjThSig5KNAoseJCrr
X-Google-Smtp-Source: AGHT+IHZqQE825N6wQbFSNr4M9kjHPorihvkgjnfji7T66yKo+Y+utiYuDlgaYMAgraKDVJ3l6/w1w==
X-Received: by 2002:a05:6a00:15d6:b0:68b:de2a:3798 with SMTP id
 o22-20020a056a0015d600b0068bde2a3798mr13708927pfu.18.1693243185268; 
 Mon, 28 Aug 2023 10:19:45 -0700 (PDT)
Received: from localhost.localdomain ([118.114.61.244])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a637357000000b0055c558ac4edsm7697985pgn.46.2023.08.28.10.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 10:19:45 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "alloc.young" <alloc.young@outlook.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 1/3] softmmu: Fix dirtylimit memory leak
Date: Tue, 29 Aug 2023 01:19:20 +0800
Message-Id: <6d10290e8c25e8228657f6496aa0bb4342694fd4.1693241678.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1693241678.git.yong.huang@smartx.com>
References: <cover.1693241678.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: "alloc.young" <alloc.young@outlook.com>

Fix memory leak in hmp_info_vcpu_dirty_limit,use g_autoptr
to handle memory deallocation.

Signed-off-by: alloc.young <alloc.young@outlook.com>
Reviewed-by: Hyman Huang <yong.huang@smartx.com>
Message-Id: <SA1PR11MB6760B9AB7EAFBDAFB524ED06F5E3A@SA1PR11MB6760.namprd11.prod.outlook.com>
Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 softmmu/dirtylimit.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
index 3c275ee55b..e3ff53b8fc 100644
--- a/softmmu/dirtylimit.c
+++ b/softmmu/dirtylimit.c
@@ -653,7 +653,8 @@ struct DirtyLimitInfoList *qmp_query_vcpu_dirty_limit(Error **errp)
 
 void hmp_info_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
 {
-    DirtyLimitInfoList *limit, *head, *info = NULL;
+    DirtyLimitInfoList *info;
+    g_autoptr(DirtyLimitInfoList) head = NULL;
     Error *err = NULL;
 
     if (!dirtylimit_in_service()) {
@@ -661,20 +662,17 @@ void hmp_info_vcpu_dirty_limit(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    info = qmp_query_vcpu_dirty_limit(&err);
+    head = qmp_query_vcpu_dirty_limit(&err);
     if (err) {
         hmp_handle_error(mon, err);
         return;
     }
 
-    head = info;
-    for (limit = head; limit != NULL; limit = limit->next) {
+    for (info = head; info != NULL; info = info->next) {
         monitor_printf(mon, "vcpu[%"PRIi64"], limit rate %"PRIi64 " (MB/s),"
                             " current rate %"PRIi64 " (MB/s)\n",
-                            limit->value->cpu_index,
-                            limit->value->limit_rate,
-                            limit->value->current_rate);
+                            info->value->cpu_index,
+                            info->value->limit_rate,
+                            info->value->current_rate);
     }
-
-    g_free(info);
 }
-- 
2.39.1


