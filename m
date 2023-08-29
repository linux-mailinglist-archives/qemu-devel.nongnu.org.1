Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C605578C8A6
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 17:33:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb0i8-00083T-Lv; Tue, 29 Aug 2023 11:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qb0i3-00082x-7k
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:32:51 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qb0i0-0006jy-D3
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:32:50 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c09673b006so23404405ad.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693323047; x=1693927847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+M1b4oBXMxVhhUnSSd4fdMxTnS6/iN50/aUGAiSJHs=;
 b=Sn564WK6SbJVRkR6ZAjiYpv7mJgG/qAN5XOQck36SxqKwBdKJhn80ccc7/GRtqz8Uv
 NrhRZDEP8TwT5D+Oye2/8vXn+e6nHRSEc5vEbWpRROIy/CoxxdYzyXCcnVXww8RB0+1Y
 4FZOI+Owo5PCvSoj0mzN0B/X+hmFm7TVG4KXTuTC4FzMmWEhVdwqIUX24ByiUQwwZxKm
 TPyc+kKE0WT+2V3gSIn8HGsnN4Q5cm/lBc2HM3szFEq2JWWphFD0p1864a/AdUT/eT+r
 2eH1ZwDh4hgiIDOUYcM0HfODrNOLKhwQO07m2AFpZwQpt9l4xJoaVLSOWn/9IGCKZKf+
 P8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693323047; x=1693927847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J+M1b4oBXMxVhhUnSSd4fdMxTnS6/iN50/aUGAiSJHs=;
 b=SbFztY19sE3JyCK6kocS/2B+SNb0Dj7TjeMSIfYbUebIIufFaEECkS7NKfAzkhKX0J
 zQU2Pz2L0XyjJBmk/B8X1n6kwWrGn5QYohcu3Vnv8vrg0Bi7W0wNQO8CKpDJfH2uzkg4
 mkZZLZl+3dqRkS1okS/Te1zt5Lcv4OFtsZTCxfxchi7YnM8E7Ypc2LKyRtVkXOIWuHjg
 Mmsjr6yeObdDear0jhvZFU75POeIDajX0/1K1h69P0ccLN68PbyjH8ODcY5mw5cmMWQT
 J64rRtBFlHVnnWcLnhZz3slaN+e7hWbcGS6RLgvFVpsye+33x5YJHT8UR30xMUPfamdV
 ZAXQ==
X-Gm-Message-State: AOJu0Yyx8mqTuVgVU6o4VHcdgo7WbtBjp1Hw/Uj2KJMR4+BrG6Flz2C3
 VlOk7c+0bAVBRppoDhW9AH2LAc5O4awQscIBRJI2m7PO
X-Google-Smtp-Source: AGHT+IGa5IzyHGugidMrEsV0khfbCqb/Rpxq0IfWg2At3tf8jP2qo4yZK67Wn+ODr8KkCunQZByCJw==
X-Received: by 2002:a17:902:d4c3:b0:1bb:f82f:fb93 with SMTP id
 o3-20020a170902d4c300b001bbf82ffb93mr28094518plg.2.1693323046737; 
 Tue, 29 Aug 2023 08:30:46 -0700 (PDT)
Received: from localhost.localdomain ([118.114.61.244])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a170902d48f00b001bdc8a5e96csm9510282plg.169.2023.08.29.08.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 08:30:46 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "alloc.young" <alloc.young@outlook.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 1/3] softmmu: Fix dirtylimit memory leak
Date: Tue, 29 Aug 2023 23:29:48 +0800
Message-Id: <ff118704fa5498c64a55d7a732fd42515fdc356c.1693322363.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1693322363.git.yong.huang@smartx.com>
References: <cover.1693322363.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x629.google.com
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


