Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D03D77AAF1
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:46:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzv-0007vr-Tg; Sun, 13 Aug 2023 15:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzu-0007vG-AF
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:34 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzs-0002TG-Qz
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:34 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so3172917f8f.0
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955811; x=1692560611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/uzfJdCP5YIWSEpmgBXqvmwwuwBH/r3kHOMiqXIu+E=;
 b=elF6qNMbZOcny/WRMhEbdcPniKFVnaVG8fxLQ3eRec8wWVdQLG2796NOMaYi2CvWD7
 4SbzlF6jWY5p1dYU5mJyW6p3WiMwvNx3W3IejecYNFX78HTN1/Tqp/8cqUNTLT783xSZ
 rC4FyBHIhxWYhV1cRcFYIeViHP7hap97s9+0TToFlB3E8DIJaVAHUGhUPzGqQ7ekYwfh
 YyycIsSSzzEJfLBhOOtfQ8+eL5c8apO5of0KULe7q1fX2CNP4ScwDhny4HncKUlJNCXh
 qJDnbx01gaaA+ltH+nNaoRhLQFmp1YcFdAALc3jr7oWc1CWijctzlAQrPFS84hHgGRgL
 xYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955811; x=1692560611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/uzfJdCP5YIWSEpmgBXqvmwwuwBH/r3kHOMiqXIu+E=;
 b=NGzOfB/3+CHxav9ny0tHh3r3Ybm0aV4I61gtYVlYkVEPnFM7xnK2JeZpPuQOJ/tTID
 R2sK4tZotPwtv8zPn6S2dLI/Jiw60TyHqTre3rvYJlMGH/Fl0VmEAx1Otrz2iEEO3pf8
 4W9N8zieQlxAOfUQEZE/8AWYx04ecBVqHGrxSMgxgbV+H0Or4yfjZ4/pPCiiawNmtrsm
 5JoO4quiAdMO1zsN9MPWA8pf8eNWxzOg5/YuCPkAjW+nwwhaIN3QwVqjPM6S7ST7g+uN
 LcV5A7zy4sYpSiX51oJiElqKuDlwppYlPJJWh7YD5JYNKdlh6Kmt1JecVGU1zui+sV4O
 P9tw==
X-Gm-Message-State: AOJu0YyWCcQDkymUyhtNsJoXSBMKOPsfMgyku1/sag/4wD64AumD1HOo
 HccsCLgtD1MJiwpRxqmMWMHIrYHhYkQ=
X-Google-Smtp-Source: AGHT+IEF9Bvf0JjntJVWH5pme0OrSSlUnG9GMOE8/YDfCQ7+IVb2UkAWfphNUMRwM1GD4OFOPqwKvA==
X-Received: by 2002:a5d:560d:0:b0:313:e953:65d0 with SMTP id
 l13-20020a5d560d000000b00313e95365d0mr5365477wrv.28.1691955811055; 
 Sun, 13 Aug 2023 12:43:31 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:30 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 26/32] Implement freebsd11 stat related syscalls
Date: Sun, 13 Aug 2023 10:41:47 +0200
Message-Id: <20230813084153.6510-27-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x432.google.com
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

Forward declaration of the nstat syscalls:
nstat
nlstat
nfstat

Co-authored-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 26909af455..e31b2aab9e 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -46,6 +46,13 @@ __sym_compat(getdirentries, freebsd11_getdirentries, FBSD_1.0);
 ssize_t freebsd11_getdents(int fd, char *buf, size_t nbytes);
 __sym_compat(getdents, freebsd11_getdents, FBSD_1.0);
 
+/* undocumented nstat system calls */
+int freebsd11_nstat(const char *path, struct freebsd11_stat *sb);
+__sym_compat(nstat, freebsd11_nstat, FBSD_1.0);
+int freebsd11_nlstat(const char *path, struct freebsd11_stat *sb);
+__sym_compat(nlstat, freebsd11_nlstat, FBSD_1.0);
+int freebsd11_nfstat(int fd, struct freebsd11_stat *sb);
+__sym_compat(nfstat, freebsd11_nfstat, FBSD_1.0);
 
 /* stat(2) */
 static inline abi_long do_freebsd11_stat(abi_long arg1, abi_long arg2)
-- 
2.40.0


