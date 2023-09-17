Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 972887A3DEE
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:41:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUO-0004T2-VO; Sun, 17 Sep 2023 17:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUN-0004S3-4q
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:35 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUL-0004F0-Mx
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:34 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31f7400cb74so3409244f8f.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986772; x=1695591572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WF9rPxUO3cPdaNIEzhYsX6B/whcPjXI3AQNo+xWFSaI=;
 b=klP5lP0Mi1UAm+TTSECGiYrilHF2nlC2FXJrwaoUFLBreY3NFv71hT8ozA+Rl+Y3G7
 3paz4qhglR/V1X8QgNtfLYqk0vZ1+pegri2FdDNxp6IzJkzxP5eFQ3iw6qM26MOIH+4G
 qCXiQF8Fukomyr7DW5iXC5pz2Dtv21G6oqgbOXL6KFl05ioHgrkd+nJRDS3a14MrH2TD
 hEH+5190k1IA3BhkSaGf1inoaiZlYOgHs/m35TRySyp8yr2W1k2576u7csXxtUbSQIE4
 asgUYWtI2m+mXHmlZ2xrcniXvWLc2KDXuHFczooCEOO6/0kG0mdL6auXItTf0Qrl5IjR
 XKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986772; x=1695591572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WF9rPxUO3cPdaNIEzhYsX6B/whcPjXI3AQNo+xWFSaI=;
 b=OyPyi1XgEpTcxUDYNkwvtdhdze/P9rkrC2cRyiTAn0zzvZvS8wEoFWJZTU/5UoGZ7P
 1iGFWI2KAvGOHVyetSEDf+FpWl8DMQ7nEk2lXRrnhyXn5ctItWeW8dRVgLxEVSnjMp76
 ukzgQqcewBwB/o6IJEid9miy4zmubj6VxAx5pazQ7N9coo89oQrWMawO9t1JuRyZu/V+
 lweOz0DxOVYxUsjTI6MyGY58cgbLNLuH5irHFYSmOMIO71XjgTTGBMwWMxjFDqBwZnZI
 hAEm+VsRLIbXS0tqwxRysyqs3gb/OL+EuSdyY5KvcTL902onXjt4hdC4ATFS9OMjFp+B
 QwQQ==
X-Gm-Message-State: AOJu0YxM0BuZx99rdCuvjzV7r8atiS+OWG6KmH718P//j+CuoO9Kj1J7
 HBWks5+Wy/CFAyP0pcGgMCQqlS5f4b8=
X-Google-Smtp-Source: AGHT+IGqeLh1mpurWsaMU38IZbbM3sd9ZcmGSV59B0Bhv1KvhWgyHYNbQTCzdJW840hqBFFZiLXW3g==
X-Received: by 2002:adf:e18b:0:b0:31f:fa1a:83fb with SMTP id
 az11-20020adfe18b000000b0031ffa1a83fbmr5728278wrb.7.1694986772118; 
 Sun, 17 Sep 2023 14:39:32 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:31 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 04/28] bsd-user: Add freebsd_exec_common and
 do_freebsd_procctl to qemu.h.
Date: Mon, 18 Sep 2023 00:37:39 +0300
Message-ID: <20230917213803.20683-5-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x431.google.com
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
 bsd-user/qemu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index d3158bc2ed..2cf96d9a15 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -249,6 +249,12 @@ abi_long get_errno(abi_long ret);
 bool is_error(abi_long ret);
 int host_to_target_errno(int err);
 
+/* os-proc.c */
+abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,
+        abi_ulong guest_envp, int do_fexec);
+abi_long do_freebsd_procctl(void *cpu_env, int idtype, abi_ulong arg2,
+        abi_ulong arg3, abi_ulong arg4, abi_ulong arg5, abi_ulong arg6);
+
 /* os-sys.c */
 abi_long do_freebsd_sysctl(CPUArchState *env, abi_ulong namep, int32_t namelen,
         abi_ulong oldp, abi_ulong oldlenp, abi_ulong newp, abi_ulong newlen);
-- 
2.42.0


