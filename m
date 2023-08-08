Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 204AF7740E0
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:11:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDo-0003K9-B1; Tue, 08 Aug 2023 13:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDj-00033k-Mx
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:11 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDi-0003hA-17
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:11 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-317c1845a07so4438906f8f.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514608; x=1692119408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1BgqP/3efusJ7vB+9IYEzefqxebmmteR1Mu1BRPGKI=;
 b=AELfYUCbhyGU5Zj6CLv1Q1N4TYNydvy0+wly+iRmBYP8GUVupwhMPe341gitQzBqoI
 Dj5Yywr2w9WzVRckDCEVVX/HJtNJsNM8Xs5rukZz5zVCs1pVYPdlqCJ/Qa/bS1blaSMH
 WmjFEl7tHs9KM0/tCM+dSi6VGDEcYO3UtIsSh55bI2uD9HvkpSnX5TwdRctinV7OSjJL
 rBxdn/jgHqc82KsV6yKbbzKzXvsqqPucSe3RBJNf8FICQxfqNI9FiZlHyXS3X0lF2sC1
 kckeTO9KmiX6BtjAQZpn/gDibuNhqiSFmjHHSohHJh4CWs1jeeypHPs7UEAIjWAVux5i
 YBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514608; x=1692119408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P1BgqP/3efusJ7vB+9IYEzefqxebmmteR1Mu1BRPGKI=;
 b=LXMS56y/RVv/Gls40/z5BXjtszdxaAVsdxEej8xsUrUn2Mm/OjuaWlCNH4U0sEu1MD
 ENGIzKKyBCIvk64iSZ8LLDgEyXGOzxiLWWzxfzoMo10lYHcsItLq/r2hJRxyP/TFFsJ/
 K72YrNaaoOHf8H4QiB10MZBV2IjE5lEknqrC2KhvkPMZ7H3JswzwMeF+JsZ0e6sKN9lF
 3pSqG/wQJ/NnTXcmutANIkMg5r8JVG3IrOUPMsofUHZV/SjkZaX7SRJnVeQvlElb6uEx
 5q5plE6m1OJId+/YeHqtzxBP8ZpAg2BYqTgDNrJw+WzVNe2Gb7nTnbTRyP9688rxu00u
 M1/w==
X-Gm-Message-State: AOJu0YxqvWX4QXtmQm9gnjAHPCnHxZqKKD58mc1I4muh8/pWgXVAlFD3
 h0clpYy4JduhwvH++uvd2fqz3ysB6wylTA==
X-Google-Smtp-Source: AGHT+IG4N9sCm+IdsjNiI6ugdWbTY+Y+MZphhMVa0y2PVEZubb5PCLsDonELpoXwMxQX4BVVUhzxxA==
X-Received: by 2002:adf:fa01:0:b0:30f:c5b1:23ef with SMTP id
 m1-20020adffa01000000b0030fc5b123efmr58416wrr.41.1691514608212; 
 Tue, 08 Aug 2023 10:10:08 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:10:07 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 23/33] Implement freebsd11 stat related syscalls
Date: Tue,  8 Aug 2023 08:08:05 +0200
Message-Id: <20230808060815.9001-24-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
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

From: Michal Meloun <mmel@FreeBSD.org>

Rename the following syscalls to the freebsd11 variant:
do_freebsd_lstat -> do_freebsd11_lstat
do_freebsd_stat -> do_freebsd11_stat

Co-authored-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-stat.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 5d9323c7d1..aef55c8bb5 100644
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
2.40.0


