Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D37707DE1E4
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 15:08:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyBrr-0006V2-U4; Wed, 01 Nov 2023 10:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qyBrp-0006UV-CO
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:06:45 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qyBro-0004o4-05
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:06:45 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc58219376so27546095ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1698847482; x=1699452282;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePIQ7ERPNW9uny7bx9FRhQ706OAx7nnA1dsVvqKABug=;
 b=HcDb6wcuRg/UNUtCPYaRG/8uNw+eV2OCJL4JyyV2A2QeIl9jRp2B2VZ8Kbp7ZWxggW
 UX1uAtBPlphRNvzZvjOQvydc0XyVnNzoHHjzhGIvNGSar9ntjCUZP+NAZpb3N0Wx/4Qa
 2k+DkB+/IafpV2IYNECDi5H45etXqnZIVxPfrBP6DSj25VC2kWja7eOuBgWL27/McXoY
 h2iohY6q98eJ3gOKu8EJ8NaZFlP3hG3TVT2OpiaBQTom/VxS2SNkxQeE7ddJGN9FykTk
 vSRDztRdQvDcQrthsOk1bRFhFlDGq3K3HzKyETkn3rrJoh0oZP4EpfgeTYfiUtRuMAkC
 /+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698847482; x=1699452282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ePIQ7ERPNW9uny7bx9FRhQ706OAx7nnA1dsVvqKABug=;
 b=JXX+IuadQcVIT58KfBQMAabt/Dq4pEJHhH5WL3LIDVQab0vsDTqU5Tudl6cLT5b94N
 9MB5/9O4rSLc/N0KHQZECt6ZC8y3GAcUic//m5G2XDbnExFLU1UfpOdzUjAm84hmj8IB
 BYd+ljSj0HVHpxLj3BxeZi81fO50cW0ib6klmnVMCLaeC3TGh9uAvi9juLZ63VS5A5HO
 EpXoUhqk4yHRZ8pjZyaQhhB/D4N5FYNqS2WuTFXMjfm0U5SOJsVNMv+uNDW5l49vt2k9
 mg96tG2ZfUPLyqJf9Feb0NQ8F/2JAU159ZDielz7eXtQdnnFBVf8GLK5JTjSFNpenF0i
 qNPA==
X-Gm-Message-State: AOJu0YyYBOf5EA6tlihhZbF27+I0E4rDWOKJDhZJfOzAB/3dGPmuB+r4
 OgP+2K2R6gq0nzqZ0Gh3mfcNpfCaT8iRiBuj9ku+JvZ+
X-Google-Smtp-Source: AGHT+IFOLvhnMQNg33FOOC1r2UpSTaJvx1ugyKY4bolPkN9jM523DvFVSZdXCa5LJsJI5Hyry9oh3A==
X-Received: by 2002:a17:902:fa87:b0:1cc:3773:3d7f with SMTP id
 lc7-20020a170902fa8700b001cc37733d7fmr8798148plb.21.1698847475010; 
 Wed, 01 Nov 2023 07:04:35 -0700 (PDT)
Received: from localhost.localdomain ([125.71.94.114])
 by smtp.gmail.com with ESMTPSA id
 jn7-20020a170903050700b001cc32261bdcsm1396118plb.248.2023.11.01.07.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 07:04:34 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 2/6] system/dirtylimit: Drop the reduplicative check
Date: Wed,  1 Nov 2023 22:04:05 +0800
Message-Id: <df9c3514933ff6750ef88068af18d3054bedf746.1698847223.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1698847223.git.yong.huang@smartx.com>
References: <cover.1698847223.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-Id: <31384f768279027560ab952ebc2bbff1ddb62531.1697815117.git.yong.huang@smartx.com>
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


