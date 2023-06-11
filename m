Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A79472B024
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 05:36:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Bqn-0002RU-Oc; Sat, 10 Jun 2023 23:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q8Bqm-0002RM-GG
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 23:34:44 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q8Bqk-0003Rh-KZ
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 23:34:44 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-652d76be8c2so3478424b3a.3
 for <qemu-devel@nongnu.org>; Sat, 10 Jun 2023 20:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1686454481; x=1689046481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KA96QyxeI4djTH2s2kCqWnsVaefnEIp83iauDmafHZA=;
 b=RcobZDq0L+OIlDmXGthBFbllw061QR1O/7gMEgHgQyDASVIeRZQe8M4l4CPjixuzNF
 Zs08x9YuGxBW7pncKprapeZYN9GEIzE5RgrjoyuX1ixiiq6JQ6GF1MGp4edQXhY1DiDJ
 Frs/VZb8+iLGl+FtCa2U82WqbW1Hgc9UWRe5075oB/RXXGe/DU117tJEDMihqyUDxN0m
 upLasA+YztnYHYfOcNKTd/UYn3t9IBZnrDi4gFuFCAowjCRX990CRQbPykhvQLqAqLfD
 t1eZCz6njic/ghPKjFgH9UDmBIa/zlIkcJR/jDH1LfObUbRoVnEzHpkfy4h+9cDblv8D
 LW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686454481; x=1689046481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KA96QyxeI4djTH2s2kCqWnsVaefnEIp83iauDmafHZA=;
 b=DbIq9PO8Blj+peCRzzoZTDcLDMBW9nPVupwiIezW8pMt0BzemFlAWs+f1uafC9pIcr
 8oSKE08Ktmaqk52AAX4QvW2gxNJGLFo7suEA4FwfNhiRnnoz0aRSR6kf2Smq5dkYQyVT
 odz9mi4yk9xoXTrFt6KdWDOD1+9ZVGLLAOkXQAr9ij/7UeJAGMBO+93yyXWzBMW4vnQX
 PMLrjRO8r9Fz10irhVJiM74BjDfKuYeFEO1DygqAV8qDaRKuDhOrOKJHZw/6xs7zVkCT
 Lrozms1Utw5uMppy0pmLTGcZFB4jOINa7lt17N8h7jNSOyYCdolFePC9tgGFt+a1EtIs
 IDkg==
X-Gm-Message-State: AC+VfDygYthuYaabg3Q9CEgV6nHhBe3JzNAIQgpWctR+7+ylXedUkUQc
 PmIR3TXuE+Dnp/7oQmDJI5SLui0BTCHTkZ4S+ls=
X-Google-Smtp-Source: ACHHUZ6njQEVMMKmPjDFuxXrq9B56hhBZ9lQPy0I564Jv8VAu2nmjeo8wBQcuqfaX7CPkyjOLHPq9Q==
X-Received: by 2002:a05:6a00:140e:b0:64c:c5c0:6e01 with SMTP id
 l14-20020a056a00140e00b0064cc5c06e01mr6762830pfu.31.1686454480953; 
 Sat, 10 Jun 2023 20:34:40 -0700 (PDT)
Received: from fedora.. ([157.82.203.71]) by smtp.gmail.com with ESMTPSA id
 5-20020aa79245000000b0065a1b05193asm3194462pfp.185.2023.06.10.20.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 20:34:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] elf2dmp: Don't abandon when Prcb is set to 0
Date: Sun, 11 Jun 2023 12:34:34 +0900
Message-Id: <20230611033434.14659-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Prcb may be set to 0 for some CPUs if the dump was taken before they
start. The dump may still contain valuable information for started CPUs
so don't abandon conversion in such a case.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index d77b8f98f7..91c58e4424 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -312,6 +312,11 @@ static int fill_context(KDDEBUGGER_DATA64 *kdbg,
             return 1;
         }
 
+        if (!Prcb) {
+            eprintf("Context for CPU #%d is missing\n", i);
+            continue;
+        }
+
         if (va_space_rw(vs, Prcb + kdbg->OffsetPrcbContext,
                     &Context, sizeof(Context), 0)) {
             eprintf("Failed to read CPU #%d ContextFrame location\n", i);
-- 
2.40.1


