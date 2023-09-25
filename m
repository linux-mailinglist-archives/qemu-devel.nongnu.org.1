Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ED57ADE9D
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:26:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHY-0001GJ-Q2; Mon, 25 Sep 2023 14:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHT-0001Cg-CC
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:03 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHO-0007HO-AY
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:26:03 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40572aeb6d0so35482595e9.1
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666356; x=1696271156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtr4AZcHHxXXmu6rDPP2dwqMNgqNWW0hP+jIdi1BnOc=;
 b=j9B6hG6qi+qaMPpqu6MGAxaaLprEw5afbtaMPug3tcB3Q6hCzLLZHePlNL96SNreVe
 savVbVVLtJawpvFl39/6tthLD0a5B02ecrX8GhRKAbEgtgAwHYLfd5NcWiji5wxR8yKj
 6rzEn/e8jMKs+sSp/npNAhl7i5lqUJ0p6LbAucBpl9cLi35zmiRpKszNN3VJsOdbZOhr
 y63A5ss/rH3GdSZdHFeZXxa55j7WD0wxRWmrSJ5Jkq79zNcnyz1i8FsMq9nSvoD22FHF
 scej8lFF6hvdY8MvIOgv5kBUpMB/F0rDrDcVcQJu1E1njKcBBY+x3T8S2JOs3TlVt8Hx
 Pm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666356; x=1696271156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gtr4AZcHHxXXmu6rDPP2dwqMNgqNWW0hP+jIdi1BnOc=;
 b=XELmzJDwkXMyPbSyytoW4mTi+vreqqViZW72IDZyHmECduj9z4RhQh2QNU9C7nS3rR
 852YGuZejl+HDnYD/lmaOec/1Bs+df0PSwXyVGI2oMsrA6x8jSRi7T263lHD8ksYwH9y
 lHDJ5LK9DRKitbtpHvEKcuWPZuLaKl77hPKF3eMOyJYYrf/jUIUO6CjWomEJ7j3Snbpo
 ZAHifgSjB2S1HQd63EXuvDSzwYU5toCoY3XQuJU1zImDDtSQXgmycMHkt0bXiTJAl2Mu
 wzVvd35CIAXj/xrVpCH5lnA7TToSb6pr1OPpD3cLa1hHAVW335UHhRweZe+9XvEsWeE0
 BdcA==
X-Gm-Message-State: AOJu0Yxn4qBie00MXMVAIp1HKJqV33x1/tLs1v8fyzLnDHprhmBjKnW4
 vKrtvwjjWGSo5bUwjzyxw05DA7jemLg=
X-Google-Smtp-Source: AGHT+IE5f7q5rBCBufMF0L41T+vobyWXvQa2+BGFjrwUNc7leNB6idDWz/Nf61ttjC0zfMgeiDgQCQ==
X-Received: by 2002:a05:600c:22d8:b0:3fb:b3aa:1c8a with SMTP id
 24-20020a05600c22d800b003fbb3aa1c8amr6027292wmg.16.1695666356506; 
 Mon, 25 Sep 2023 11:25:56 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:25:56 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stacey Son <sson@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 04/28] bsd-user: Add freebsd_exec_common and
 do_freebsd_procctl to qemu.h.
Date: Mon, 25 Sep 2023 21:24:01 +0300
Message-ID: <20230925182425.3163-5-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
References: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/qemu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index d9507137cc..41c7bd31d3 100644
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


