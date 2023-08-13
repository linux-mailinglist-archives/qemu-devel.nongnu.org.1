Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABF077A6E2
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:20:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpv-0008G5-4p; Sun, 13 Aug 2023 10:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpe-0008B6-K5
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:40 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpc-0000tM-Sr
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31757edd9edso2930005f8f.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935955; x=1692540755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekgOxp/3PUSZDR+G9wkupgXm77JnNTTdc/U/1XMcvVo=;
 b=cziAxLQoALy3lgfXOSKWsu3moY6SdmEskzC4a0otJIxyga+3ik9A4JN6V+MBIu1spH
 3RgvnRxyfVChRzyta/Es7oPdV3QZfpAiyaJlVVbND0ezWvkA0lESXzluD/HGNJKuL9uU
 Lwnf+Tp4imVhM7HjaL/pmKNId02T+n6WPjzu0CoJ3ZuyKjrvfTg57mqoMaAJ1Ee7pmNJ
 5aSsm2NhZo27DFbrbGy7nxzOe7zcOW4yl+JeK8ajtuthXtWnBFhJR+wxXnoVXqitHehD
 Mnm+ArGJCzQTMfrsjzHtibuEkIW/lPkvAY/gB4DQi4Gjo7XVuC4z/kvRGVnr1foDmMm1
 ERfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935955; x=1692540755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ekgOxp/3PUSZDR+G9wkupgXm77JnNTTdc/U/1XMcvVo=;
 b=d3PEeqHbPt3h4gcNfG74lILdag598nlJEWJzOn4gvEAymUHZ+Qz6z/I7va9Xxd5mAR
 B2OqTCQ808ZKJKXi/m7XggFmJJTt6hOeQMPVC3/8311SJMAzb2oYCAHN1Jy9x1hfmxii
 eYUhVlHA7LZLTUCEj7ObFu8RPOxFDVn8Vmtsskn8BiIrzuXBjm7A6CeTCNzOdSmpo7PD
 qw3/MSBJdV1dccT70Xm7Wmyzqw8/pfo64Kx9GHZgfuMGzz5ZGk4NzDyqRqIr+oo6/PAo
 2Mmax4Sx/6yZLoGdGLPMw9TpU/2zZoqmWphWUPhdLDAonpgNfbRt83fOmWbHeqMzlvUd
 gR0g==
X-Gm-Message-State: AOJu0YwcrFlMFeg5wnFNwPY255vxukOsq0/f+465QrbFfPnACrqrhuVf
 hQNwrj2+WtmpsRRrGMnNHuBKLpYyCH4=
X-Google-Smtp-Source: AGHT+IFMgnq9543pNAovDCPt695NXnK45jx0+dfYhZY8jM3n2XyH/UarTdE5D7RA6voXQx8RfJMIUQ==
X-Received: by 2002:a5d:456a:0:b0:319:6c90:5274 with SMTP id
 a10-20020a5d456a000000b003196c905274mr2940189wrc.30.1691935955375; 
 Sun, 13 Aug 2023 07:12:35 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:35 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 22/32] Implement freebsd11 stat related syscalls
Date: Sun, 13 Aug 2023 05:10:03 +0200
Message-Id: <20230813031013.1743-23-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x430.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


