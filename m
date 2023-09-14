Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE177A0EAF
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:05:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsZb-0002vR-Ev; Thu, 14 Sep 2023 16:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZZ-0002ue-5R
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:21 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZX-0001WY-Iw
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:20 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-400a087b0bfso14625275e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721858; x=1695326658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6kOFVD7x0CWlInCOpBq7W9+nfPWQu2AwCNVWCQ27xk4=;
 b=jBCaeTVZSOImL9L6adqQxxmuOzP0Lrp6fq+0HHe3c2pLQFLjKqalXTrVuKq8H1dW2/
 2NdHEXbmmdX0t27gcOUsimPnwS5aHIuh2+Ycn19m2n0E6pRVf2ULAlYPJYNLy3aJUkO5
 sKnOwbcFpDhMBqwOt/DU84yGPL7W8Tz90oXO105mRBs8TqDiyWhpwy/2aZvTb8pRwB8c
 /4rSWpM0G4ejXneEQMHTsTPdU72p0lMcSebSgiWrNnYBiXutXOIOaAChVFP8wxgC5Bxw
 aDvUYU4+dtZUf7wIvj8QwQLgdaKbkSRP0+q709wSOH51Ey6bf/let5L8C9DrtBg9kWyJ
 Cvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721858; x=1695326658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6kOFVD7x0CWlInCOpBq7W9+nfPWQu2AwCNVWCQ27xk4=;
 b=mRwNi0HwZfEyJAap3sR0pSppEC/uWiuUy3cUvUUgc56cgFnJQmMijbjlNc+1x9Nt15
 gFEPjhtvr9v21b0eU56DYeRdDgXNN5JX2i1zrWXUZaY8RgKHrBULBr+JWH9+4tNsayuN
 nezTmjF+hwqG/D1jx6tGeQFennVqTbINY5VQcPGKOQDDV05Emv/cN6ZWlq03sL+GdG34
 JA9h/65VRInbbd5rKl3/C02/4kcJffDJZAzDyMJDuQjpCuC+3qQL+DkdLf1X0TB2y8JG
 ez347To8DAeW/+DYlN3UZCHo298QP/DFfIrRaDoCy/M2XGKq7dcpYcVU+84g5GG5+4/x
 FkVg==
X-Gm-Message-State: AOJu0YwR3Q31E+5tFMlwsqg72RlHZ+FJ52htdGHwaiTz7pbOJLHIIZbH
 00Kk2SiyqdIeptEr5b1MYo9aIcpi0Vc=
X-Google-Smtp-Source: AGHT+IG8jzRqIxbpt/750EpYKd9bOU8JHR5C9hb1jFCmvhGPsgNXoqduuh/ClMnYUCH881OI2b+qyg==
X-Received: by 2002:a7b:cb8b:0:b0:401:d258:ad26 with SMTP id
 m11-20020a7bcb8b000000b00401d258ad26mr5317873wmi.19.1694721857557; 
 Thu, 14 Sep 2023 13:04:17 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:17 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 09/23] bsd-user: Implement ipc_perm conversion between host
 and target.
Date: Thu, 14 Sep 2023 23:02:28 +0300
Message-ID: <20230914200242.20148-10-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
References: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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


