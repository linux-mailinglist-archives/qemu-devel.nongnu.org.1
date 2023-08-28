Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E8B78BBC0
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:46:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalsO-0003uS-P5; Mon, 28 Aug 2023 19:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalsH-0003sd-Fy
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:26 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qals6-0006qO-VO
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:19 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-34ca1aadcccso13056695ab.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266128; x=1693870928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5U7mLm+bsD4Khy6hH0NG/eGf24P7ccIdU3Pa7XNEEg=;
 b=ddLGrgU2WY/5emi0ha+QVi6IM2vbyhOoFS/RGX4Q/+T/vwFj2pAza3nmLtuRDj7stW
 wqfqiI0Or6iefxO/9X1lj+7uFhOyueJycBuNBFyKnTMUI2vIX55tyh/VWLRxqB377r8C
 Q+RueXjUhvnr9UslUBRrgu19Z2n86qzcM0ZWDyyfp+0P39uwnobOAwhZWAFA8Mx9krW6
 PKLmEaKwCwsQkKXQRvKd8f03mCzNLoHxmfw+suNwZdn7jWYCmuryUanCH/v4gcxgcX8D
 ByhGY3If8vaV5CXRiOSpzJ2bFNU3MOuc3yUtUJkbkHXYymc9tApQ5fAfkJXVHGTnp8lN
 whCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266128; x=1693870928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5U7mLm+bsD4Khy6hH0NG/eGf24P7ccIdU3Pa7XNEEg=;
 b=O4lncI5kDB69JFC9COa8moM8mrrL1dpWZWIBSfFVp/SBLz2U2hMnzYdm4R5Fme6h3N
 m3NgSfmGv68uEo2jcyf+R0CMKxqENevYN4Z/AneNMEwsWOIQljO9pqXUBCOEARa0YgZw
 7F3nCyBAbE9x4Cs7xf9n2WNWcLuSOp2IViB6IyP9q0wzhpK4aJrR1FSYfcg0SJirmWYX
 MEyfbt90zTzB+hRuil3+PcK2uLnYYfOggfcW/VX48PfiQG874xxTvT8YlSfiCGyw4eJL
 HNp09tA8a4+/roNZpybSicUW+tEhln3iB8m3uwfk1OF8xzr9ExxSivrrYzggzcWXW8F5
 lWfg==
X-Gm-Message-State: AOJu0YzbaaAO5iR/j5i3WHe2qMaU1rXAgWnLkM5XHG7PbZdNdxgRV2VC
 xGtKbD+JpGqP0semgjZwzF0eU78V37FJszdL65k=
X-Google-Smtp-Source: AGHT+IERLk60p7nKJ8itiDe06YiM7Eqeuj4vBaNoppiLGaGYwbUhvobp2EKZqKXyUpiV5SkxSruhgA==
X-Received: by 2002:a05:6e02:1c08:b0:34b:ad7a:383f with SMTP id
 l8-20020a056e021c0800b0034bad7a383fmr21793482ilh.0.1693266128340; 
 Mon, 28 Aug 2023 16:42:08 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.42.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:42:08 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 33/36] bsd-user: Add glue for getfh and related syscalls
Date: Mon, 28 Aug 2023 17:38:18 -0600
Message-ID: <20230828233821.43074-34-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::130;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x130.google.com
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

Add glue to call the following syscalls to the freebsd_syscall:

getfh
lgetfh
fhopen
freebsd11_fhstat
freebsd11_fhstatfs
fhstat
fhstatfs

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-syscall.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index ade47a0d2f2..73616a5be08 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -524,6 +524,34 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_freebsd11_nlstat(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_getfh: /* getfh(2) */
+        ret = do_freebsd_getfh(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_lgetfh: /* lgetfh(2) */
+        ret = do_freebsd_lgetfh(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fhopen: /* fhopen(2) */
+        ret = do_freebsd_fhopen(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fhstat: /* fhstat(2) */
+        ret = do_freebsd11_fhstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fhstat: /* fhstat(2) */
+        ret = do_freebsd_fhstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fhstatfs: /* fhstatfs(2) */
+        ret = do_freebsd11_fhstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fhstatfs: /* fhstatfs(2) */
+        ret = do_freebsd_fhstatfs(arg1, arg2);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.41.0


