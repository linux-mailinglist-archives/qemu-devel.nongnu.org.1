Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C9D774107
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:13:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDu-0004OL-Sz; Tue, 08 Aug 2023 13:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDr-00044t-V8
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:19 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDo-0003mv-9N
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb72b9so31735105e9.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514615; x=1692119415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qv1al80z8Au5vOkyDpqa1Ck5HEJrKmriHoTb34daV8E=;
 b=r66y1VUAeo9MHyPGWrIVF8P1aiQ/IlkTY7vMtMKtXXzObhqfPoiHbtAhdPJqCc05wP
 OR8XIhh0m0y40b0fNPbDLSGIcKz7TPgvsQCKyDRLZG7dUyAx972TD6UZCsyQgkwegaLy
 Bm1i3XkHBELrhAOYDv+aRArai1Yc371uAm9eZI1HOMIIQvakWyJ7tEEoE7wijtxUymAN
 IuUE0mUuA2dkVXluAOuSg6lApy9knCzgYSgaPhjGThNkvfGcsAmEEzrQue+iDwc8dhJc
 f+gnuOMIrTUx3sqoWgg1XVlWu5nE2OZP1UcZWT7/2OBA4dUtcNz7m9obfbPbsI5eqzjU
 5VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514615; x=1692119415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qv1al80z8Au5vOkyDpqa1Ck5HEJrKmriHoTb34daV8E=;
 b=YJt6aiyzcVsSl1Mh71HU7dNmwKc5DeNZSwIDEFgpfM/sG4au0hMZBs8y71tjS0reYB
 iY4GMR6WUOtp1hhojNDTqLjRmdvGjmsIWs0Dl3t1sxVCQsfNeuRJokSoMljHg7CFFuQE
 7sYu6ZHyKjbkfaCjxBQU/oNoa9hwnjHzkwKE/M+uy1JPoFDLh2bP1UlrNqF8aDDxe6uB
 oLmw8LsaqBDPu8i2wbswbmbbgwtWl4jnsN2zLjiyCr2XjV4FUf7Qjohgm/iVWtCi9VG/
 zPWTRLpBLPEogmpECjosLbK/zyLpUde6vEyazguP62Q1KbOfvA+5chQCWtqvEy6jnQnx
 Ct4Q==
X-Gm-Message-State: AOJu0Yy3vXKfYTAG7de9MSQsEt6lIQy2tRbSKIy2nZXzBu4O4qryOV5R
 KrbvzUpFIuPZNxiHkMeAjId4t448SyHczA==
X-Google-Smtp-Source: AGHT+IHhIRLNYJjPsyUnun3o4c8mZX9McrePsLocOUp9OtblrIZp+17n7hPkOFalas+rvd071tfTFQ==
X-Received: by 2002:a7b:ca51:0:b0:3fb:e356:b60d with SMTP id
 m17-20020a7bca51000000b003fbe356b60dmr356238wml.38.1691514614699; 
 Tue, 08 Aug 2023 10:10:14 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:10:14 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 27/33] Implement freebsd11 stat related syscalls
Date: Tue,  8 Aug 2023 08:08:09 +0200
Message-Id: <20230808060815.9001-28-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x331.google.com
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


