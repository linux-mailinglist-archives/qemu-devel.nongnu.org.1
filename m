Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8B378BBBA
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:46:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalsO-0003uR-FJ; Mon, 28 Aug 2023 19:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qals7-0003oq-5e
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:15 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalru-0006lc-K3
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:04 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34bae82b2ffso12430775ab.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266121; x=1693870921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkCIF/cz1CORecgJNpP6wmYIklfZQzDUYN6XXFugEHQ=;
 b=o5jOoKSlVrqNJIrdIhw5gEyIv8hv15MWfL7jQHMbEWe085SwbHLJNrjwofg4ZIXtbp
 E3XJf66S8bMbHX3npP4L3rvalJ/JmdXCgSPIbLj3N0IYliiMU7hSDBzW1bpotfrjYl/W
 PbppR6zgUDCtW/m3Zl89RxVljetpazFd8zjSv0IRD3jxfyerLFpBDouW2DoRQ31/3AyV
 kePPpqSw3htxoc0Yj7NJnO3FZMpR6WGrsVfvBxdiBlE4TeHKYoagWH6y+ad9dWZMrLKG
 hjIUYt1pmJp/cK4rvHRfsKY2EhzWjsrKjGZ99/JK7glqz8XN7ew9jM1ytklu1c9imQhw
 AmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266121; x=1693870921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NkCIF/cz1CORecgJNpP6wmYIklfZQzDUYN6XXFugEHQ=;
 b=RYcD+gg5r1yBjqy/m1/tpMvWuVxge0Ieu5CyJnwiBzEGoizX/l5a7C2voSDn44sgIQ
 kM/m6rbzqsZTLoMhjl6LixTObeR2mQJLd0taCK75V4QzFA1vw0sNHv92de6fn1030FBJ
 +LfuUHdZnDwPCFB6VlONgNhlNWDm3gsJFgGIkqWaTrBdgiYd4BlEEfzAY8Dgxb+Knxfy
 9qgzjyY7B3cHdP7pkr852otRbKvP6RudjMjaQZBxd9owjvugcpy9j6H6J6mHkNU1mtUm
 c/XmDNoEXZKjNnLsA7HDghgepEMsedk00XJ+gMrpNmlEP3pCmqM6/7tn2OX//Ktl6fY/
 mUHQ==
X-Gm-Message-State: AOJu0YyOSKznc7K2LUd2YpbKsOq5FMWbtUP1x9jetbvCy5lqwoINCzwD
 FJoVjcSSpoAf/aIDocOBws60+zlQWcCcjJapoD0=
X-Google-Smtp-Source: AGHT+IFOFC+cD0M0EczcX+SpaF8frUmCm68JTBV3lhBInwYtExlSgHjRmJwPh95QuBO836ReBO8Fpw==
X-Received: by 2002:a05:6e02:144f:b0:348:797d:a94e with SMTP id
 p15-20020a056e02144f00b00348797da94emr20692590ilo.2.1693266121323; 
 Mon, 28 Aug 2023 16:42:01 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:42:00 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Michal Meloun <mmel@FreeBSD.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 25/36] bsd-user: Implement freebsd11 stat related syscalls
Date: Mon, 28 Aug 2023 17:38:10 -0600
Message-ID: <20230828233821.43074-26-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::136;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x136.google.com
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

From: Michal Meloun <mmel@FreeBSD.org>

Rename the following syscalls to the freebsd11 variant:
do_freebsd_lstat -> do_freebsd11_lstat
do_freebsd_stat -> do_freebsd11_stat

Co-authored-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-stat.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 5d9323c7d1b..aef55c8bb53 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -20,6 +20,11 @@
 #ifndef BSD_USER_FREEBSD_OS_STAT_H
 #define BSD_USER_FREEBSD_OS_STAT_H
 
+int freebsd11_stat(const char *path, struct freebsd11_stat *stat);
+__sym_compat(stat, freebsd11_stat, FBSD_1.0);
+int freebsd11_lstat(const char *path, struct freebsd11_stat *stat);
+__sym_compat(lstat, freebsd11_lstat, FBSD_1.0);
+
 /* stat(2) */
 static inline abi_long do_freebsd11_stat(abi_long arg1, abi_long arg2)
 {
-- 
2.41.0


