Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E327CC1EC
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:40:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsiPx-00034Y-RG; Tue, 17 Oct 2023 07:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qsiPv-00034L-IE
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:39:19 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qsiPu-00016I-0u
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:39:19 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6be840283ceso231897b3a.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 04:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1697542635; x=1698147435;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRQRlUyCRNvmksYGbVPBdusDzt/xm0aUk10LnlLsi/M=;
 b=ZbHthgHNU4hKlJ+CQKG2nKJNkuHHIAN9k4Yb0Vf50I1Gb4Z1hn5qzO84BoJuDH+7un
 4WvTA3iW+ItvSqXre9+3jFQOhueuTv/lkWnAyGM2FemLg8i3HXwRGsMgJDxn2a18hT6r
 WwCS4hPPwK1lHfIbeWBuwDD/9CMbBdUTKbWSpb837yCQjAA8/SO1sCgRYHadFHsIWUPl
 OIjIGfsvcSF1fwCF8A8dYJORkcpIEDNWoxlr+5P70a1+PkhDlUHXDq9eH2XW/VAJv/c+
 HCY+qUNb/pH7PKwxj68bgSWDQBTqz7kwC2WjBwsxKgYcYccKmE/NzuZcczJ6ZyuczCaQ
 BX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697542635; x=1698147435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRQRlUyCRNvmksYGbVPBdusDzt/xm0aUk10LnlLsi/M=;
 b=rM+YvBVinGbOrAhykLWZCB4tdKx/bq6dCwaLSzKNb6WGeM+HC944WxGAINNDj/MKJn
 HUkfIPEFK5AKSjRwaJcr3Ovm587JkTojiqY1TUSFUHXR4nUlHROXVKf7k0rBVIWERSis
 ElS6xNxHXbAbrCa6kcSG2QsqccMMr/kKWIYf2xdcRPJEZB+YFikm5z76SyHcXoRzesh/
 JFdsIzWk1PzuaP8kFXwBnPNpJao866pl9MEvp4rRnr2c05TPZv3bdN3gSxJz49uQ+ZsP
 RmoLgYSNCupySW9g1tASSQECfJdrBlbkFEZqB5q4Ham9W8BqqcHUq7X9lrHcq8qkAZl4
 F79Q==
X-Gm-Message-State: AOJu0YxmlFMZbgBiquP9fSVCQbVlDyhzzaAqOqjxqCnhkV4KjubdyoDD
 uALvzXW5gVH4w2d5qcZ6gcAO6k9vPofqDQv2xzrfr3jt
X-Google-Smtp-Source: AGHT+IHAf+Daq5qb6gfp59/uRTwgeCa7GHTdd6sAf7FFphHyNGz4XnRjjRFijeY7RJhkr+Ks0ipIyw==
X-Received: by 2002:a05:6a00:1916:b0:68f:cc47:fcc8 with SMTP id
 y22-20020a056a00191600b0068fcc47fcc8mr1884172pfi.14.1697542635343; 
 Tue, 17 Oct 2023 04:37:15 -0700 (PDT)
Received: from localhost.localdomain ([171.216.79.181])
 by smtp.gmail.com with ESMTPSA id
 x28-20020aa79a5c000000b00692c5b1a731sm1198647pfj.186.2023.10.17.04.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 04:37:12 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH 2/6] system/dirtylimit: Drop the reduplicative check
Date: Tue, 17 Oct 2023 19:36:05 +0800
Message-Id: <b370a33be0a1c393cfcb2552c6305c42463f8156.1697502089.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1697502089.git.yong.huang@smartx.com>
References: <cover.1697502089.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42d.google.com
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

Checking if dirty limit is in service is done by the
dirtylimit_query_all function, drop the reduplicative
check in the qmp_query_vcpu_dirty_limit function.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 system/dirtylimit.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index 3666c4cb7c..495c7a7082 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -652,10 +652,6 @@ static struct DirtyLimitInfoList *dirtylimit_query_all(void)
 
 struct DirtyLimitInfoList *qmp_query_vcpu_dirty_limit(Error **errp)
 {
-    if (!dirtylimit_in_service()) {
-        return NULL;
-    }
-
     return dirtylimit_query_all();
 }
 
-- 
2.39.1


