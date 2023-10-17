Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CD57CC1EB
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:39:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsiPk-00031k-36; Tue, 17 Oct 2023 07:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qsiPi-00031Y-Ca
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:39:06 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qsiPg-000159-1T
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:39:06 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6c67060fdfaso3857730a34.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 04:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1697542623; x=1698147423;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZN3PZcjXAZrKvaLzoF/mqQnoItoBs27sZrKsshwE4s=;
 b=mvXCYDBi34BcNaQgLtzugUGKVcQfitn/1SKYKYouyePoCPdKgGes/ABY4oIHsjec32
 fMaWtYkjI+eQ2ekuweWBylYSyr8x/7VaJpXNFpWfrvwTdNSHHaPzwrghHgm0dvRHts3f
 CTLK5/iOTqzUkeawLWmqUcKlzJaUeedbei6eiUOSPDnt1FitHJhfUjhykpeBdiBO4wjx
 8geqCE9OVi0VH7e3EvCsKD348KNQ6cpjrbmnsJY1xydDWWSMlTxFGPmAT+pVtyuSrbu/
 vwPivlqLE/MreXhp2hN3DaSIN9hVUcSJpkWp1qKkkEMdyzLEpw3DuZtiF3LDcIgET+Sf
 XHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697542623; x=1698147423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NZN3PZcjXAZrKvaLzoF/mqQnoItoBs27sZrKsshwE4s=;
 b=fxhBSdw5VusexHUT+r+2IQ6O/mjwdcJ4jOZqe/G62kvinIjugtF4vI3uMkZypZQegD
 iPy88BkPN3ZWDcskgLPEcEoL+DJLW9YCnyq6AoSHCq2S6YGINLkDsCQ98KevzY4C7RUO
 nO7PxFb7JfY1d8MZcW+V5oKzeNN0S9UQeUJP+mEST8/iB747DF08pEhjJsQsQYkZKsB5
 rZxD8qLVU97xzzqCkabQRfzqL9Z8iclaKlqgD1A3Uabmsxj2GOKq9wYYV3D9hphjA4Df
 ZyhcNIUvr66hTtqby9oLSDA+OASrCpFf4Dap3dLwGOhTzL7eUSaQl2lDMp9zaOgxZdl0
 s0pg==
X-Gm-Message-State: AOJu0YwbNTWur8bQlNsCaJLQUBRrWKlswQhqwnBi4aNt6rfdJxL5qwqX
 IIAdAXwfm8UBy2NnhS/QJmWqY7KxltFqQSpisj9dwoK/
X-Google-Smtp-Source: AGHT+IHuANjDvuOmNZP89BifXKe3+8uw71sT0jIxoXk5To2bFdEJ3zD4XpDIBfyVlNV+EzZZ9qjsGw==
X-Received: by 2002:a05:6830:18c3:b0:6c4:81d6:171b with SMTP id
 v3-20020a05683018c300b006c481d6171bmr2134957ote.21.1697542622742; 
 Tue, 17 Oct 2023 04:37:02 -0700 (PDT)
Received: from localhost.localdomain ([171.216.79.181])
 by smtp.gmail.com with ESMTPSA id
 x28-20020aa79a5c000000b00692c5b1a731sm1198647pfj.186.2023.10.17.04.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 04:36:55 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH 1/6] system/dirtylimit: Fix a race situation
Date: Tue, 17 Oct 2023 19:36:04 +0800
Message-Id: <69ad82c901244e55f05a157edd828914b057e084.1697502089.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1697502089.git.yong.huang@smartx.com>
References: <cover.1697502089.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x332.google.com
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

Fix a race situation for global variable dirtylimit_state.

Also, replace usleep by g_usleep to increase platform
accessibility to the sleep function.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 system/dirtylimit.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index fa959d7743..3666c4cb7c 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -411,12 +411,20 @@ void dirtylimit_set_all(uint64_t quota,
 
 void dirtylimit_vcpu_execute(CPUState *cpu)
 {
-    if (dirtylimit_in_service() &&
-        dirtylimit_vcpu_get_state(cpu->cpu_index)->enabled &&
-        cpu->throttle_us_per_full) {
-        trace_dirtylimit_vcpu_execute(cpu->cpu_index,
-                cpu->throttle_us_per_full);
-        usleep(cpu->throttle_us_per_full);
+    if (cpu->throttle_us_per_full) {
+        dirtylimit_state_lock();
+
+        if (dirtylimit_in_service() &&
+            dirtylimit_vcpu_get_state(cpu->cpu_index)->enabled) {
+            dirtylimit_state_unlock();
+            trace_dirtylimit_vcpu_execute(cpu->cpu_index,
+                    cpu->throttle_us_per_full);
+
+            g_usleep(cpu->throttle_us_per_full);
+            return;
+        }
+
+        dirtylimit_state_unlock();
     }
 }
 
-- 
2.39.1


