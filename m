Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6E477A6CA
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:16:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpu-0008G2-Ga; Sun, 13 Aug 2023 10:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpj-0008CO-9E
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:44 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBph-0000uQ-SD
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:43 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-313e742a787so1992881f8f.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935960; x=1692540760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/uzfJdCP5YIWSEpmgBXqvmwwuwBH/r3kHOMiqXIu+E=;
 b=hLG/SCJBDz7mylxBJE5vP/NSFoTzVl9XPH4mbZi2IKeKhoQhwLz+bYvvLXyiezZExT
 DrC5lBE6FVxuReDa4XgyoQ7Q13OOrFtU8f2BYdFX8ZSm2v3vA9t4JtJIfmHN/8xW9dBv
 lZeATdkMvsZdstpAEq13mXMJfjZLz5O1D6oz76xCZ+OnMsXcl0srYyNi8qtQGP46AeQF
 tJpsK+n1mwy29NHoN35pYnoLTxcnyalAFcQOUZ+B0PuvW+5jobVvdK96nrIQadkdK3R3
 IEdkSUbDq0FY/CaApNWwLo8yOiZWGMhXjmWWIj/2mTjsr8Xe4pToSH4LjYO5FtC+JUY4
 Yg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935960; x=1692540760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/uzfJdCP5YIWSEpmgBXqvmwwuwBH/r3kHOMiqXIu+E=;
 b=BgVG16phqUGqZdRTM177lMo8Xej0AV6qMnjAzOFuIlqgMWT4Pzhln5yMLXmxd2rQOH
 zm75RqPUbZZareVh4mI7x9FM04twNzZtHDrrf7J1uRZ9W2vRbHBXRSsk6P6LzGYx5/e7
 pC6CpqjPospS59YF85DCEOAU3wGAlYOPOJI6JO3qL1itDL7jbg+UkUElBc5ha9zqC93H
 XrKSd1ULyMaNG9nCzyEotH8JM5w8TKpYOKjfUmXtv/3I+/PjHhD5bBJyshuR/X8+vo4X
 iQ+Uxkz7qySviEXimTsBqOJ9tOtCROg+4HF52/EFPGWs/TLqpiH3EA02mVGd+P3CvQDp
 BQPA==
X-Gm-Message-State: AOJu0YyrBfnO5kvcp0eJP8LuDzwgEO1REPUuCId7h6nNls8rykAK+sVV
 VbEtPLQRbwWQbl/Qpx1htZUQqMYCbJc=
X-Google-Smtp-Source: AGHT+IGtljsiZn6Rwerp1cVwxNVBM0zuq2asQ9UOyeCGzicL4AoMKhLIlGxzji3lidIHjHenaFNLxQ==
X-Received: by 2002:a5d:5188:0:b0:313:f38d:555f with SMTP id
 k8-20020a5d5188000000b00313f38d555fmr5614342wrv.24.1691935960296; 
 Sun, 13 Aug 2023 07:12:40 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:40 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 26/32] Implement freebsd11 stat related syscalls
Date: Sun, 13 Aug 2023 05:10:07 +0200
Message-Id: <20230813031013.1743-27-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x434.google.com
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


