Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DDB77AAE8
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:44:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzr-0007ts-Cm; Sun, 13 Aug 2023 15:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzp-0007tN-2V
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzn-0002SL-MC
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe24dd8898so34105985e9.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955806; x=1692560606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekgOxp/3PUSZDR+G9wkupgXm77JnNTTdc/U/1XMcvVo=;
 b=polU+v6JSW+E87r2LJwmMU17gnlOOcZ7+1ce//SayoEjZjLgfzrvwmwmCE1HNdbESL
 Qvl0l6X4UKK/LNRsHXaZDZhyyhP22VKegNz+h7iJSyiMGDE8D4o+FEdKYnd9mgPJ9AKg
 qsA0a3o34Jfv1NI+2EOX+5nBXSS/HnaPEgS4iUVLf61VBAnzZbW9q8pkiS9Hp/HWNLV6
 lmcdbm5VIGzdpliPq+qCsy4Z3Q8+RhkWoBAjoslfAeaM1CcVBBlr6IpgyNmTOh9suK41
 y1gc4SZbUbfrhmcyYoOJhbR+jWOwd+KAhWNBDjpR6st4GefNQIBdvoxgVgE4/0JicYbs
 ct4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955806; x=1692560606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ekgOxp/3PUSZDR+G9wkupgXm77JnNTTdc/U/1XMcvVo=;
 b=Tzp44y/OpUrXMEc7hcycPeKyn4EKEuoMy8C0DNfJgo2O7riMrdmHYvlykx55LT6vQp
 HzyBVKEk+16wpnmfaGZM6UFKcaFIlXuvFXktwITEDra6938Qk/XqXfpLp8K/AotDEu11
 CHPUOLTri4qZDuxTwb85rBgeZ09Xd3wqBz+CyxwGXJWPGcIZikNqpC2fBuwK8+AOS5iE
 jam+wCa6r/ip0F/So6aTFdjSMLDDaTb3aiqhis83Acmf3bV3OeEWhZWTzPcHMWOXRDWH
 AVFxNj1ZWWlBJXaW0x7CQPn2ob4YognuN29lY2JSH/qB3rPz/cs3yc9Fv4JD14fg/1OG
 OOjQ==
X-Gm-Message-State: AOJu0YyW4jU7OwAJIJhomz3LN1ToDAme6HES9gtdufCCItp/ltch8imo
 Dx491iHnjeQBEXsP/qoDQoCWlTuDJgs=
X-Google-Smtp-Source: AGHT+IE8+u030Q6uRR6C9LHGXrVtx47D8VJDQwvRctgl8HdKCgkYdPLpnoVY+gLTYqglejv86uXVdQ==
X-Received: by 2002:a05:600c:143:b0:3fb:dff2:9f17 with SMTP id
 w3-20020a05600c014300b003fbdff29f17mr5956552wmm.15.1691955806223; 
 Sun, 13 Aug 2023 12:43:26 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:25 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 22/32] Implement freebsd11 stat related syscalls
Date: Sun, 13 Aug 2023 10:41:43 +0200
Message-Id: <20230813084153.6510-23-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x329.google.com
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


