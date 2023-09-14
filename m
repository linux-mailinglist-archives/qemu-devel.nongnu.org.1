Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6D97A0F3B
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:47:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtAz-0003XB-PM; Thu, 14 Sep 2023 16:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAs-0003OK-De
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:54 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAf-0006LA-LY
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:54 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31aeedbb264so1273994f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724159; x=1695328959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6kOFVD7x0CWlInCOpBq7W9+nfPWQu2AwCNVWCQ27xk4=;
 b=JHVBPNql/KEdrE6wc55G1lkVSglrj/yDs1OZuDNwlyT/UJsqJ/kINlEVnUcCRiwZRF
 p4RE83NEbv62zzFU89xUH+OWM4sT2MtGnblNvDV9jZPp+rlih5+FDNvSXQjyWi1fXYkV
 /D4E7t09kP8kShhUorsb9uGCzlBfhbceqeexdgYWvkbq/cD7irzxIMKlcJ2KAsVCC/8P
 IFojh81f0j/OMsTY6rIeZvrUV4HRqwB+atDrK0yhgACaXOgrVjd2ZyyagMLbwzt0TFib
 pn8ptU9s5XJvRMFr6/6bgXh3VFEpxWrOih/rwl6Lkpeogn6mSsZa2TA/G97qPWmGMTdW
 bwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724159; x=1695328959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6kOFVD7x0CWlInCOpBq7W9+nfPWQu2AwCNVWCQ27xk4=;
 b=O2C8WB6iBk43cVCDPE2SJmkmez1Hz+Lq579MpDXAS0e2ajkyQuYPLhTVzb3L6HCUYF
 RC/sgVYY9b6vrntAT2q538kb1N30xhjp4dUpNg3w5iro6OnvSNpMTYI1T78i2oJhCxnb
 j/bVtLqRSe+LstIg/u3QLcg1Oi5g86VIFPWYw90OgdVh9QV7L70UKmiCN8a2fuBIPMu+
 8L7nBgqYquX9vAsdMMafqK+J64GWh9D2fDtI3nNkQwtaNxzebbhSmcc6vriHVW/ojPQe
 30f3KpTV9hoLpWPWFoTwMuls+NZZZ1EbUrlTBaS7jYNCbU03x+clRMiTLdGuAvdKpWcp
 ITNA==
X-Gm-Message-State: AOJu0Yw1X930XHmaZvpkKIfkRkGZjvtqhLNo+XeuVGArIMLs+jADn5iQ
 sEPZwcWepmq9qhzwQ35HWp1qz2Lal5k=
X-Google-Smtp-Source: AGHT+IHn7Em2SF5Q6WdTIMI+MGwi7sWNCQ7xGoef7gTIZAjbPgn7R3SKTnzGNBK7MAma32ASq0bpbw==
X-Received: by 2002:a5d:658e:0:b0:319:7a72:5d82 with SMTP id
 q14-20020a5d658e000000b003197a725d82mr5638059wru.21.1694724159562; 
 Thu, 14 Sep 2023 13:42:39 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:38 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 09/23] bsd-user: Implement ipc_perm conversion between host
 and target.
Date: Thu, 14 Sep 2023 23:40:53 +0300
Message-ID: <20230914204107.23778-10-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/bsd-mem.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
index 8834ab2e58..46cda8eb5c 100644
--- a/bsd-user/bsd-mem.c
+++ b/bsd-user/bsd-mem.c
@@ -30,3 +30,28 @@ void target_set_brk(abi_ulong new_brk)
     target_brk = TARGET_PAGE_ALIGN(new_brk);
     initial_target_brk = target_brk;
 }
+
+void target_to_host_ipc_perm__locked(struct ipc_perm *host_ip,
+                                     struct target_ipc_perm *target_ip)
+{
+    __get_user(host_ip->cuid, &target_ip->cuid);
+    __get_user(host_ip->cgid, &target_ip->cgid);
+    __get_user(host_ip->uid,  &target_ip->uid);
+    __get_user(host_ip->gid,  &target_ip->gid);
+    __get_user(host_ip->mode, &target_ip->mode);
+    __get_user(host_ip->seq,  &target_ip->seq);
+    __get_user(host_ip->key,  &target_ip->key);
+}
+
+void host_to_target_ipc_perm__locked(struct target_ipc_perm *target_ip,
+                                     struct ipc_perm *host_ip)
+{
+    __put_user(host_ip->cuid, &target_ip->cuid);
+    __put_user(host_ip->cgid, &target_ip->cgid);
+    __put_user(host_ip->uid,  &target_ip->uid);
+    __put_user(host_ip->gid,  &target_ip->gid);
+    __put_user(host_ip->mode, &target_ip->mode);
+    __put_user(host_ip->seq,  &target_ip->seq);
+    __put_user(host_ip->key,  &target_ip->key);
+}
+
-- 
2.42.0


