Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FD6781279
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:58:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX3jF-00011O-Cb; Fri, 18 Aug 2023 13:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX3jD-00010D-67
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:57:43 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX3jA-00049k-Jx
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:57:42 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3a82db15081so761891b6e.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692381459; x=1692986259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wdilCwPFymanBcvogkn2wHE26a1921DHapwmojyGce8=;
 b=dvpTnjst9JON6CPOj3DAs2EIk93Jw9Tq8eEBxgDUlBWA59ZI0fScmRjP4ZFfSKVZZD
 qWT5I2E1RTkUS8Jq1XJmzkKUa/kjeQQ6Z+BlU07nQHt2/Q82s6MSxniLvPGoxPToaJ7t
 h697aKhHahnyDqXTUUfIw7sqasTJPldfHq4S7DEIlCodGfpademdxsN4QVirzDljAoZw
 RlChNGzv/fsblA9e6IuKWw4qy4fe44Bvf1VU/jvf27dO6jnnqB6p6AmobULrZPhIwey+
 RAA0KX721cT0y2QHVFR0N4PZMIhId8HNW/oM61vPECzCr9TedJHXpKH1FU9TnWYH5Q9O
 AlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692381459; x=1692986259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wdilCwPFymanBcvogkn2wHE26a1921DHapwmojyGce8=;
 b=DY1U3e1+fICZGHh9xLZfGVqERiIVtSK4cdXJYWYjRpNrr77CQ8nuNLbdD6NaH4kx+K
 UwPLflYF0Kcn8BpBPSHpBxHtL3jHxE2ArGgW4zw3KPuqT1ORDubmr8z4jFkz6m38Vnlg
 LkpXouVcBxVNyRFo8l+PIn54BXnjgic91MioeZbCH0SDUtbBOFUk7sFNPk4dztlaWzd1
 0fvNtm/nX+Tlj838ZT9Sezs1ewOf+/t/7qIIhts31T/3wl/SOXcA3pO9dg59hUtTKYCS
 OsHjunevGGNiKOzp094LQJn4QLZpx6ztc28xeh+VdnMBcSbR8bB6g9UknIDlSmGDgNJk
 H6HA==
X-Gm-Message-State: AOJu0Yzjr02H/HXxnNlPMw7m4edzpJDXjaIAuXHNnWka/ySvvJTUlHgi
 htDjoD8e6jvLbPAXfrkX9WPV4JW4EId3iTRbxWs=
X-Google-Smtp-Source: AGHT+IF4jqr31qYNkqMvyhJ3hos3XWOJJtkl+bDaxbvII8F7SwSdIH9MrBfWf8ODDW+vFH0ZX/jyhg==
X-Received: by 2002:a05:6808:18a3:b0:3a6:febf:fb with SMTP id
 bi35-20020a05680818a300b003a6febf00fbmr4682069oib.22.1692381459383; 
 Fri, 18 Aug 2023 10:57:39 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a638c4b000000b005637030d00csm1838212pgn.30.2023.08.18.10.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:57:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com
Subject: [PATCH 2/3] bsd-user: Remove image_info.mmap
Date: Fri, 18 Aug 2023 10:57:35 -0700
Message-Id: <20230818175736.144194-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818175736.144194-1-richard.henderson@linaro.org>
References: <20230818175736.144194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This value is unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/qemu.h    | 1 -
 bsd-user/elfload.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 178114b423..898fe3e8b3 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -52,7 +52,6 @@ struct image_info {
     abi_ulong end_data;
     abi_ulong start_brk;
     abi_ulong brk;
-    abi_ulong mmap;
     abi_ulong rss;
     abi_ulong start_stack;
     abi_ulong entry;
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 38a3439d2c..2d39e59258 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -738,7 +738,6 @@ int load_elf_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
     /* OK, This is the point of no return */
     info->end_data = 0;
     info->end_code = 0;
-    info->mmap = 0;
     elf_entry = (abi_ulong) elf_ex.e_entry;
 
     /* XXX Join this with PT_INTERP search? */
-- 
2.34.1


