Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6381F7D12A5
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:28:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtrOA-0002uW-4a; Fri, 20 Oct 2023 11:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qtrO6-0002nm-Ky
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:26:10 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qtrO4-00063m-AS
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:26:10 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1caad0bcc95so6814805ad.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1697815447; x=1698420247;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkQEX6C2wW1mPOWLXApStdvqFKYQwdr8AV6yMr5GZQk=;
 b=KI+LiRBx41aMUKZvcMDkCisDhu98FMG8KQmHuLkmTNVBK/jLQ6hctOXHOhXSKShzue
 +vMUSW6h5zx2K/X8rmcMwYcV3LheEltAVcyPLvBXD14RLvcSQdv5fQ0qJFbxwk7oGzi7
 mzmM8mf3bzPGkHWsMnwlrVoOhkoH+MTXJbQgSbT2LSYnoWX5W10EBMOgSu17FqBS5zvo
 jCxyo/PmzaHpb+2Nis5uWBcVfx4qRxRuz7TEflahBUgl24MTFU1SLAGOOyp8hXMNgu4G
 /kMhkoV/+XcNgD1I/B3JvBr7s8+bh7ylPaWQwUUYHGzRKEjHiBdH6u4pF6OvsOMGQyzZ
 81+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697815447; x=1698420247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AkQEX6C2wW1mPOWLXApStdvqFKYQwdr8AV6yMr5GZQk=;
 b=VE9s95LB1FW83vIJh3HjElBi10B3vxFmi4+8tjwDOblvRXQRuI28DpqY162OSFBM7Z
 muh+2IE0ylJUxSV7gumNm3aVD50yB5sv29AzSnDR00GLofNgujhz5QFM4C847rsVzs0S
 CrI2kJSFjg/1oiV1Mv4Hdf6ea0Dy6cESjNui3pTDfmCF3nDZ/jrjrOciJ/l0VBFJ3QYl
 vtHWUNHjyyndlIZ1e0HlZKiJ0q0WQdkrTLim/NsqLMKJgCR9pGN5QxgE/4Ub37NPcfV+
 eVXWEfK8bFVxQfxWbOTkRgnZRTHnvRQXBCDI2oTFE8XHS7NcpkUIP4BTFPlUbfTkDemy
 P4jw==
X-Gm-Message-State: AOJu0Yw31c+9z6xQBT40ysXrFl0uGZoEKwPQCswUpLF8wJkUjfj5om1T
 scjlvn89DRm0DjEcCGo+CVkNZTZ6u/aB3PzD7o15ZV1A
X-Google-Smtp-Source: AGHT+IGqS0TXLFwUD7S5nEwoFQEJQIsycHhGeuNESse1OwlaBO8Oz75kdppwCz4HGXI2JBDy61p6Ng==
X-Received: by 2002:a17:902:c7c2:b0:1ca:7308:e43a with SMTP id
 r2-20020a170902c7c200b001ca7308e43amr1577340pla.47.1697815446622; 
 Fri, 20 Oct 2023 08:24:06 -0700 (PDT)
Received: from localhost.localdomain ([171.216.79.181])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170902cec400b001c60d0a6d84sm1644824plg.127.2023.10.20.08.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 08:24:06 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v2 2/6] system/dirtylimit: Drop the reduplicative check
Date: Fri, 20 Oct 2023 23:23:44 +0800
Message-Id: <31384f768279027560ab952ebc2bbff1ddb62531.1697815117.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1697815117.git.yong.huang@smartx.com>
References: <cover.1697815117.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62d.google.com
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
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


