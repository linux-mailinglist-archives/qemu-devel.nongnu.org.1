Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDEE7ACE43
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:38:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbSt-0003M8-Gq; Sun, 24 Sep 2023 22:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSq-0003KQ-L3
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:48 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSp-00006X-6a
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:48 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3231df68584so1680659f8f.1
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609405; x=1696214205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wP1rfp1dDRIiBnhp1KylL3inypQKBVqgIftLFJMUFhc=;
 b=h1a5ebEHrX1q1X0lbAks6wcmhUoMd0F0O3o8de/3KS2Av23GKFbmRwQLl2Qw5gbTpp
 AXNxSet86p8VvUHIYyz37/zf9DNcMCSIXd+PRqPtfqnL9wv+YROxs0KZAOq/mx8DUBoL
 nCDSnaqjTso8mpRch49YmLGZL3gOAaAzZ2jk6Zq0HAwY4kC0/H7CEqt5L4SGmjlxGJ9t
 tavgQh5vd2JLAenJxvr8jrF8PfT2d4k6iFuqUy6kWl92VSCbH5qTRAvnm3SIiuaN2LeZ
 BnZN2wBoQUN8ip7vdtFKqM61SF6n/3o9KnXawlVOY7axJTyFhpf5eS0yHDZ+cmhwvt+0
 e80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609405; x=1696214205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wP1rfp1dDRIiBnhp1KylL3inypQKBVqgIftLFJMUFhc=;
 b=bssD3e+FXr/2O7RqwW2pz3qkaVt/xcpvlv/hFGFBY+d6Bzl+KQXtDM5d0R8bDfN7sF
 HKd/ZCjgQTnGqMcHAnm7YJp8UGh80UuatrO4pFynHgdcUCbMcnVTO3LkfZqZv8wnBXDn
 IBbXwgqb2JLmEecG1sdqsAiw++mcyRaC0+DH9WFpkXBa9wf/d9kIQS/R6ma1TQQGblJI
 jQ2IUuA0QojVyNndwRlonXPRpj+TmbswHQzVtuMiJ0rK4uMJr+/gwSnYy4OXln0nV2/3
 sLYcT3YdFIQ22rj2SkNHB92w4OhOS5IqQFsaWeSgy74vXRRupA4T7uBY4aIVmUPQnC28
 K35w==
X-Gm-Message-State: AOJu0YyOjflTT+XA72V54sO6UotAIY8jeeMtvQ0vg2qt6smfa7pTEiv6
 CvfWEwYNXWPHGmlKPlcA/AThVmhyK+M=
X-Google-Smtp-Source: AGHT+IHWBv9dRYPUB3m1RKnvGL9GfIMs0fkw+l0+h56OAuJ43rzNDwJopSCFWNszNMCdnFScXo+GJA==
X-Received: by 2002:a5d:404d:0:b0:321:4df5:b85e with SMTP id
 w13-20020a5d404d000000b003214df5b85emr5119700wrp.26.1695609405521; 
 Sun, 24 Sep 2023 19:36:45 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:45 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 13/28] bsd-user: Implement getrusage(2).
Date: Mon, 25 Sep 2023 00:01:21 +0300
Message-ID: <20230924210136.11966-14-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
References: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-proc.h           | 13 +++++++++++++
 bsd-user/freebsd/os-syscall.c |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index cb7c69acb0..133c1b0eaf 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -124,4 +124,17 @@ static inline abi_long do_bsd_getlogin(abi_long arg1, abi_long arg2)
     return ret;
 }
 
+/* getrusage(2) */
+static inline abi_long do_bsd_getrusage(abi_long who, abi_ulong target_addr)
+{
+    abi_long ret;
+    struct rusage rusage;
+
+    ret = get_errno(getrusage(who, &rusage));
+    if (!is_error(ret)) {
+        host_to_target_rusage(target_addr, &rusage);
+    }
+    return ret;
+}
+
 #endif /* !BSD_PROC_H_ */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 44cbf52f08..5d8693ed55 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -243,6 +243,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_getlogin(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_getrusage: /* getrusage(2) */
+        ret = do_bsd_getrusage(arg1, arg2);
+        break;
+
 
         /*
          * File system calls.
-- 
2.42.0


