Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9408A78B691
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:36:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qag91-0003Nd-9V; Mon, 28 Aug 2023 13:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qag8y-0003NH-Vc
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:35:16 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qag8w-0001Qf-Ra
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:35:16 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c0db66af1bso16161225ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693243993; x=1693848793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+M1b4oBXMxVhhUnSSd4fdMxTnS6/iN50/aUGAiSJHs=;
 b=1V8z3HUO/OYYzwPipYwGRRvv/2quFoDQkkLZKZIQswm6R2XRVvkcY3mvwdeumHhqIN
 vH9dIM6GbwfjDfPQRZwlvn5OhyaMHD7OoAeipEfjCNtMXeEd8sd5r8c3u5wup1aiE44I
 QJMx9C8IeNWmwiAgOxFXy8MS25V0/1LfgBViVhcKySfIlHLEbZOKjl2hT407bqip73+R
 GTHzrNsc93ypvChW3IW/MfKRI4bye7l1FXQREe/icJY6OxZhouva5LAUbhU/xYXW5wSo
 4W5FpQ9CshHRRypM5s6bxUOWMhj2ZyfbTIXPfmCrA1rQE7bKhZDCrBveHmhaicX5DzDn
 6gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693243993; x=1693848793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+M1b4oBXMxVhhUnSSd4fdMxTnS6/iN50/aUGAiSJHs=;
 b=PTMQ0wbZNxWKpViDUCFjUussq4OmOpMLZLf29rcAJq7r2LoO13z+6/iuQIKNs3ipOo
 +YPI/+wgrQSeem+1SLxeHkXQ53iMSrI49YMTtqO7h8x4U2fXnIhrcKPO4QIkbbsP0CTD
 vUOalEBEnoMo2gI1xnIjPi2ikOL2vMiLoJ7eqOAW1MzvfS4vsDIJtNXsmxvrw3CVcyyv
 jWePkVU0NJKiDcSw936N3NoKntCf/CQzozI1jPcQor5wX7/FKwpXTmPIB2syT4Fow3a6
 y+vNLA+LZd8pOouguz9mNHBipdjgUVQ8qe9F58ZNTBjIPfl6XHw2A/sblFLf7MiINYor
 J0vQ==
X-Gm-Message-State: AOJu0YxLM5CaRWUeJFVa7xyKy28HS1+OP64e4Kv08gBpgjZc6mHLGiXB
 Gvmr7M190zqv3xJSB5XEkzzt7++AoeahPM7lvHiymbGn
X-Google-Smtp-Source: AGHT+IFkDrk8B+D591MPWAiRtm0wYFKQVso7gRlVMvRrL4lTksIGqatX3eUGcZh+vSxkO/AyREgjzw==
X-Received: by 2002:a17:902:e546:b0:1b8:7fd7:e022 with SMTP id
 n6-20020a170902e54600b001b87fd7e022mr24665923plf.28.1693243993514; 
 Mon, 28 Aug 2023 10:33:13 -0700 (PDT)
Received: from localhost.localdomain ([118.114.61.244])
 by smtp.gmail.com with ESMTPSA id
 je1-20020a170903264100b001b80d411e5bsm7669103plb.253.2023.08.28.10.33.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 10:33:13 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "alloc.young" <alloc.young@outlook.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 1/3] softmmu: Fix dirtylimit memory leak
Date: Tue, 29 Aug 2023 01:32:50 +0800
Message-Id: <6d10290e8c25e8228657f6496aa0bb4342694fd4.1693241678.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1693241678.git.yong.huang@smartx.com>
References: <cover.1693241678.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62f.google.com
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


