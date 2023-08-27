Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D25078B934
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:12:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiYi-00086T-Lt; Mon, 28 Aug 2023 16:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYf-00085w-L0
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:09:57 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYd-0007Mx-FP
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:09:57 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99de884ad25so484487266b.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253394; x=1693858194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4iSOxLEnRmlavXANl3gqOotvuJhzKvKKZdyP5X9HPaY=;
 b=fbi9+D+NbCwA4HiNy1AlK/6nW02NdzBv04mn1HMJ06MqrLWHXLgyEU3Mli0WFCMXql
 Tr2FoS1ba8DxwAAhT5tSdRTuXb+jMFjJkn+TtoFmI63gmzPHveRo+kZXX0Al/AVUpEz8
 8QTxkMu3l5VB9KVZtvF+3KX7HunTMKBs+QjxBvbrxFW/T9oKy6jXws+bUYhmR+j8RrsI
 iRKLUq5/oxLfc1h+OT/YGOqYYIAEA8UI6s36COeMJ9WTdFA4CwUDbx8zdQYrXXHOC7iQ
 wr9EYMy+9JTtHm7JRD9mKh/FSxluyGJ9r6VpToDfgmEU7FKDAJ12xbJ5rdv2Kz7pPeg5
 LI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253394; x=1693858194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4iSOxLEnRmlavXANl3gqOotvuJhzKvKKZdyP5X9HPaY=;
 b=iO4RsHGs7ja7tDsoL4ClonyWlJ1hFGMPL1tlrakN5OOB3rr+ewsL3lh7SCLH6n95lr
 DATMUYmvQCiZen/29BTBzfrPgVi2cDTOxZNKzgGqaoXpRWZtqshq6XmK6AzCRJ2hXiE6
 FUmP7Dcj1j9yKqrbi7OH6YHhmDpnIF+EzL541negMlAlNlkJy5i+yqW+yMVX0NBn3ai8
 BcWecvSUkPOkyeInjhcwBxV631KLBKMdGFEkxFdJfGf+SEOzRWBVv/qIDN/YfSkZUvsv
 5Fmb3d/FQqjH10ufN9wxaYIfzk7bjfNnUb8K/zeDHnhhg/hIn3LTiDvipt4cy3zPPQFY
 n6hw==
X-Gm-Message-State: AOJu0Yx2B+9UtcfEqVlSxy59AkNwual3dVx5bwxSorvVpRzDSOKh7oz/
 vDUF0vKvzVXOeDnCgs5kjC2hCQguUCRfDQ==
X-Google-Smtp-Source: AGHT+IEkmiREQG85IEJKqj+gwYuardZ3dDpryZ8jbw0QIw+ekvXjAtlRd0scRMLgTsQpeif0Jdf3hA==
X-Received: by 2002:a17:906:cc18:b0:99b:f58d:1c49 with SMTP id
 ml24-20020a170906cc1800b0099bf58d1c49mr22079541ejb.53.1693253393875; 
 Mon, 28 Aug 2023 13:09:53 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:09:53 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 06/32] bsd-user: Add bsd-proc.c to meson.build
Date: Sun, 27 Aug 2023 17:57:20 +0200
Message-Id: <20230827155746.84781-7-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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

From: Warner Losh <imp@bsdimp.com>

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.h  | 4 ++++
 bsd-user/meson.build | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index a1061bffb8..048773a75d 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -22,6 +22,10 @@
 
 #include <sys/resource.h>
 
+#include "qemu-bsd.h"
+#include "gdbstub/syscalls.h"
+#include "qemu/plugin.h"
+
 /* exit(2) */
 static inline abi_long do_bsd_exit(void *cpu_env, abi_long arg1)
 {
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 5243122fc5..b97fce1472 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -7,6 +7,7 @@ bsd_user_ss = ss.source_set()
 common_user_inc += include_directories('include')
 
 bsd_user_ss.add(files(
+  'bsd-proc.c',
   'bsdload.c',
   'elfload.c',
   'main.c',
@@ -16,6 +17,11 @@ bsd_user_ss.add(files(
   'uaccess.c',
 ))
 
+elf = cc.find_library('elf', required: true)
+procstat = cc.find_library('procstat', required: true)
+kvm = cc.find_library('kvm', required: true)
+bsd_user_ss.add(elf, procstat, kvm)
+
 # Pull in the OS-specific build glue, if any
 subdir(targetos)
 
-- 
2.40.0


