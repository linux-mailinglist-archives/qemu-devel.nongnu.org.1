Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FB878B937
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:12:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaia8-00059X-MI; Mon, 28 Aug 2023 16:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaia7-00050S-3z
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:27 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaia4-0007oU-L8
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:11:26 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99bed101b70so446511866b.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253483; x=1693858283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sV7fWmjGs0AzU7QjCNSEch83JqZsqRJhPpjwbfOHKt4=;
 b=dN+ucFYR5em6eR4Anv2zqpRL8e9R91SQA6rLBwRB8jF2nXqlxSyn9F+Fnm6YKd2aF8
 aNHAkhuFQE2mR0+iEfKOmfZA6xTAhRIzhePsI9i44XiThjvqDbgaOuJoLcctb5kgZ9/r
 37Es5N9Kjgea+y1ZKytkJjEE6oVi/B4vD9WxVxtqgsSNjxa0XkCZ7Lzo5msqoNNtC0w+
 Cal/keQGy/mp5xMEU8q41rJ+Ec7QbUjNVX0WbLe8Vrkp/iIYVI/PJOLc3NK9XbIvDhgg
 8WXMn6pNSnlZiGjBa3UVAZiVhjMDTNjMLD0Qi6pN6nWgAix2nhJTyI5vriWNVp+MKrf9
 4obQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253483; x=1693858283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sV7fWmjGs0AzU7QjCNSEch83JqZsqRJhPpjwbfOHKt4=;
 b=gKSoUp3hYzXQQ1i8Au19hfykgu7oMbEpUCxTNA82WHn72oGNw1BsSLw4dGkzmRUE5K
 PZorixkBHNZDYn9taays3jyc4VQe8bn38hru+5X9ZOO+7hMi8Tev32fypiWn7C0Wk3Hw
 ZsuPlA3i1gdhpIOpsqsqMOfRqYushbw7Yk/jv0wjPSfqsMgpKtlclot4D3ssU9gwMqf2
 Pqjx2dsBCdzraCi7XgV7aQQvdDpEVZi7k5jGYzF9PoigiWSPJiJ4DOmivXEtyGX6iNUa
 NduKaUSyk6txqTxJNfsvLJ2+nsKPNNpmSh0VYM241oRKl3MmdcgpZIzsuS1TuDbmBHe6
 8cSw==
X-Gm-Message-State: AOJu0YzagNwfh5s52XD2fJT6abd/Ji+Iz7CBGHuSVqMFiCJekc5r9HGZ
 h1F7xijkKaoBzxMPjk5+edAAXKUFEVUTng==
X-Google-Smtp-Source: AGHT+IERaIpUN6xbk5gAJ8eueSSdkC3IY8X/1pR6zLB+4+fk7m9Pd2ZZjs0NUrw+ugTCrHmpPFyewA==
X-Received: by 2002:a17:907:2718:b0:9a1:cdf1:ba3 with SMTP id
 w24-20020a170907271800b009a1cdf10ba3mr12033631ejk.27.1693253482814; 
 Mon, 28 Aug 2023 13:11:22 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:11:22 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 24/32] bsd-user: Implement h2t reaper_pidinfo and h2t/t2h
 reaper_kill structs conversion functions.
Date: Sun, 27 Aug 2023 17:57:38 +0200
Message-Id: <20230827155746.84781-25-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 bsd-user/freebsd/os-proc.c | 50 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
index f069472156..a413109bc2 100644
--- a/bsd-user/freebsd/os-proc.c
+++ b/bsd-user/freebsd/os-proc.c
@@ -301,3 +301,53 @@ h2t_reaper_status(struct procctl_reaper_status *host_rs,
     return 0;
 }
 
+static abi_long
+t2h_reaper_kill(abi_ulong target_rk_addr, struct procctl_reaper_kill *host_rk)
+{
+    struct target_procctl_reaper_kill *target_rk;
+
+    if (!lock_user_struct(VERIFY_READ, target_rk, target_rk_addr, 1))
+        return -TARGET_EFAULT;
+    __get_user(host_rk->rk_sig, &target_rk->rk_sig);
+    __get_user(host_rk->rk_flags, &target_rk->rk_flags);
+    __get_user(host_rk->rk_subtree, &target_rk->rk_subtree);
+    __get_user(host_rk->rk_killed, &target_rk->rk_killed);
+    __get_user(host_rk->rk_fpid, &target_rk->rk_fpid);
+    unlock_user_struct(target_rk, target_rk_addr, 0);
+
+    return 0;
+}
+
+static abi_long
+h2t_reaper_kill(struct procctl_reaper_kill *host_rk, abi_ulong target_rk_addr)
+{
+    struct target_procctl_reaper_kill *target_rk;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_rk, target_rk_addr, 0))
+        return -TARGET_EFAULT;
+    __put_user(host_rk->rk_sig, &target_rk->rk_sig);
+    __put_user(host_rk->rk_flags, &target_rk->rk_flags);
+    __put_user(host_rk->rk_subtree, &target_rk->rk_subtree);
+    __put_user(host_rk->rk_killed, &target_rk->rk_killed);
+    __put_user(host_rk->rk_fpid, &target_rk->rk_fpid);
+    unlock_user_struct(target_rk, target_rk_addr, 1);
+
+    return 0;
+}
+
+static abi_long
+h2t_procctl_reaper_pidinfo(struct procctl_reaper_pidinfo *host_pi,
+        abi_ulong target_pi_addr)
+{
+    struct target_procctl_reaper_pidinfo *target_pi;
+
+    if (!lock_user_struct(VERIFY_WRITE, target_pi, target_pi_addr, 0))
+        return -TARGET_EFAULT;
+    __put_user(host_pi->pi_pid, &target_pi->pi_pid);
+    __put_user(host_pi->pi_subtree, &target_pi->pi_subtree);
+    __put_user(host_pi->pi_flags, &target_pi->pi_flags);
+    unlock_user_struct(target_pi, target_pi_addr, 1);
+
+    return 0;
+}
+
-- 
2.40.0


