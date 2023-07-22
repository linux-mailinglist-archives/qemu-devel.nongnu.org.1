Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1271C75DA59
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 08:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qN656-0003zy-IE; Sat, 22 Jul 2023 02:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qN64o-0003zX-Lh
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 02:26:50 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qN64m-0005PX-Sm
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 02:26:50 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-666ecf9a0ceso1658859b3a.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 23:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690007206; x=1690612006;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=igkg25D9DpaLjmRPnKedm/HR+c3ExF/v30NY6pfyyvw=;
 b=DH18i8EB6KCP1kW0KRaDB1TNdpIXrwOyzJpHT+LhqTjlT1rpiMC4NhJH6UWl3L8JBV
 qEfQTHtYh5aOqL7uBc+eoixAj/x5P+lO6jyM3+v2jEqHecDAEEA+HBa17TF9xT1QgsS7
 2fcps0IK3oMzD9/Nd4JvI2Kzj+UubYslEyUOa60RuLlPZxOdH97v3m3NjLX8Iq4tQuXi
 pILeXqqrUt/VoNK2S1rM2hU/qZSEHCr15JWtw2PsjmsVHpwxwIE3GfoZqy6RnKlWtEA/
 3rGqWRtfxtsvdVM7Vil4m8tjvW8M8FR7lBkrm90NNdNry6C9xRibYSA47iVZxIOuTLhN
 GHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690007206; x=1690612006;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=igkg25D9DpaLjmRPnKedm/HR+c3ExF/v30NY6pfyyvw=;
 b=HmseJpqthzQDfH+bpJ6MuauVLTDYhMnkWmIcDDnXtvQ4IW+Md0CnCW1hs4u5Y30XsM
 ijZGjHjSluQaaDMWe1EB14Zc8f7wc67++HCcmcnIPwKZsc0GhLzk2Cbo2VQY3wEYCAGN
 trM+UbN0OzJfW8iBVF58et0rkm+A9zvtLsGy7lU0VWO7vIexCxMi0Ellua6OQ7k7ci2a
 /fl1w+tXLOzd5RoLiY1v/7nO1T42Y9ZHCxEN+6isX72wRPuGUUrOi1kXeNGqXbx8FoQH
 iUzACL58tn9TRSSaqU/QLtqGrmKlLEGkVjBbJSGhF4eFlkqt+X08zR22yCCkH16mFafZ
 oO3g==
X-Gm-Message-State: ABy/qLbzy1irqXRMis0V7FjjYbgjzYHrMFdH9PjQ+SuaoJhuyD0aD7OQ
 mZRZKtFEnsleoK5wUdS2Zf5DtQF+v8VMMQEu5Is=
X-Google-Smtp-Source: APBJJlGrx6G+/hEI6KVhpKdysGeaJZB7dZQBMjVbZvX3NGGV87/etE37Ggm//r3nAON2E8FzL4OikA==
X-Received: by 2002:a05:6a00:2492:b0:673:5d1e:6654 with SMTP id
 c18-20020a056a00249200b006735d1e6654mr2696331pfv.33.1690007206446; 
 Fri, 21 Jul 2023 23:26:46 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 d16-20020aa78e50000000b006827d86ca0csm3941014pfr.55.2023.07.21.23.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jul 2023 23:26:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] vl: Free machine list
Date: Sat, 22 Jul 2023 15:26:40 +0900
Message-ID: <20230722062641.18505-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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

Free machine list and make LeakSanitizer happy.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 softmmu/vl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index b0b96f67fa..802f728298 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1484,7 +1484,8 @@ static gint machine_class_cmp(gconstpointer a, gconstpointer b)
 
 static void machine_help_func(const QDict *qdict)
 {
-    GSList *machines, *el;
+    g_autoptr(GSList) machines = NULL;
+    GSList *el;
     const char *type = qdict_get_try_str(qdict, "type");
 
     machines = object_class_get_list(TYPE_MACHINE, false);
-- 
2.41.0


