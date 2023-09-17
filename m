Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 701C07A3E79
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:26:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Bf-0006Tm-EU; Sun, 17 Sep 2023 18:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Bd-0006T4-3y
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:17 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0Ba-0002u0-8o
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:16 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31f7400cb74so3427633f8f.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989452; x=1695594252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WF9rPxUO3cPdaNIEzhYsX6B/whcPjXI3AQNo+xWFSaI=;
 b=cgGfanEcLF5X8LTrR7hRYAvoTZlhveGvBOEpNxCfiPCR/UtUydCxr7vUiY7eAJmofz
 m+b0fDCNjyI2h0LwAk+EjqSexyHB+xIuKX8DyYQWZ5EUdKZsYFChcS+BJe5ZrOz6M3q4
 DIgP8Lhyqudxi1hySusHIlkaizowx2X1oLhuPTDcslP6HmddgI+iTeWBXr6jhHiAEN6D
 H5Z1PZonqeJ7j1N76FfxjDTVnw9bjNwgBpHgOlL7rGCNETvAuzveNKeoEaNWT1KU07B8
 /3g73OaEJOKv3T1inMsxWvddqc11+G4I8HWSKcefmvO8fuR8W283cP7o0Zh0iRFLwkF9
 yRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989452; x=1695594252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WF9rPxUO3cPdaNIEzhYsX6B/whcPjXI3AQNo+xWFSaI=;
 b=vCKcKf0w6N6J/OvkIrZAa33rQm07zIMPoFv6Nt8FDrUY6csIROfhrgJT3gwhanVou9
 XKxDqzoEYPaU16p4Zz+eLfcwHQ04vy/sWz6/5R4UmdfblQ6db4W4YiCYa85bIUzgqaPW
 o2S15Zic4xBPS9BkbvklyKs67rv1IgKCKfd2Azmg0XC6PbTCB5rnKnaKzgK7y0ZE+0l9
 +3o9maCMJHXPHQ6BFtgkrVj/X7u4Hua9nzRj/QZl1q+TRxVOpMfed7d0PkzxUHRkJEOD
 It7dYC+Ty3fsQxQx4MWdTYM+0dIe7Ag68uIYDCDQX8tUvuk8wTYGKeQfo2zrZH2ChG/y
 KtOQ==
X-Gm-Message-State: AOJu0Yy1YNProBlQRbwDhbYDqpVPoIZIvRk4FRQ7Pu8+cuT3AF79qqVd
 tiFoAqZmzp6hOY7lVlnr1VgCJTZtyrU=
X-Google-Smtp-Source: AGHT+IF4B3U38pmnvfmTD/bC+5YcPjpRAAqDuzqLtOddvDZUTD3l2t4j1jQDG4nSRyK+05BJHYCR/g==
X-Received: by 2002:a05:6000:1942:b0:317:5d3d:c9df with SMTP id
 e2-20020a056000194200b003175d3dc9dfmr5221628wry.18.1694989452058; 
 Sun, 17 Sep 2023 15:24:12 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:11 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 04/28] bsd-user: Add freebsd_exec_common and
 do_freebsd_procctl to qemu.h.
Date: Mon, 18 Sep 2023 01:22:21 +0300
Message-ID: <20230917222246.1921-5-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
References: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42a.google.com
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


