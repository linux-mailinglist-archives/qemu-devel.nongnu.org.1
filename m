Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 227FE8201BA
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:29:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLD-0006x3-99; Fri, 29 Dec 2023 16:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKL9-0006vm-5y
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:23 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKL7-0006Xt-NL
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:22 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3bbc755167fso2038386b6e.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885060; x=1704489860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JdUJ+a9jwe6jFr1Vp2r8iUErAThFUW3vNQyu0k8ot3I=;
 b=k+oPniaqny+ovl0t0D3tuVhQZJvJ8Gwz+A06oejlma7zjNtFnHY4lqZe+QiJdbWiBZ
 nRlO+Y3sqPx4T0Pws/53kiWtPeuG1pEu6SD5ql5tE7pTAfxAHD6qw/ylZlQ3N4hWmlA0
 WK2bIYaV6nshAabFZvD+hdhjhm8TWDtc/xeN25wXb+KeuTA94LXWmeUyH9uUqWOLTwnM
 AHtDBbQon6i93IW6QMVtHUFE4r+H0K2/6vLqCWnzGMpml9NgPGk719cvk1Xf7fGhxcm+
 IOcPYavsSA4FPilRlVT5S/a+x/W8HBDPQFoEXdoSBPv3Jxij5hyYcvCnmGVT1SF/3GkF
 UkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885060; x=1704489860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JdUJ+a9jwe6jFr1Vp2r8iUErAThFUW3vNQyu0k8ot3I=;
 b=rO7H9KZo1679tDyM4K2Ig87cn5E2xO7TB+cqDYIXhj82V56WPRITrIKIUfwk9n9o0v
 f5546pUGVQSlscUOoOACRt2HioV15y6GRP9E7My6846pXtuGW+9wza6ElbgloiF+odNn
 3Mx6ACb241XvTqmR/MF4FKPhVXP08cQ+BMvyLzn/qEiDInR1upu55qNLCcd8NjiJBOb7
 b1K3FJQtIeZhP/KbPyulwZwFOgIrdPkS7Bo6LKzZkw5+msP/Yf9QU1NmxeGzWHlRye9s
 QiNW7OEfaTuP3Ge2IgL0UXuNCvIi56gylvYtdmP33gq+11dvZu0EY6pUxjsS/n4Uwiyr
 puBQ==
X-Gm-Message-State: AOJu0YwQIm1eyZUXsaYuWq7JXxHUtFtv4YvkDxfOj1gN5y+AUCEcQYv2
 MqDy4SPjLWCrfYJx/7AIM2cNY4Hhxy+vlMOpp6F/c6ePoneG1A==
X-Google-Smtp-Source: AGHT+IGHAoyn3aqZ0ndFJPv3sUF3tA6QPB8JMgTrc2+/MJ4hse6LB7QL3aewLnTfAL6X3rDY8p0Pdg==
X-Received: by 2002:a05:6870:b620:b0:204:1df1:8c85 with SMTP id
 cm32-20020a056870b62000b002041df18c85mr13654332oab.94.1703885060568; 
 Fri, 29 Dec 2023 13:24:20 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/71] target/microblaze: Constify VMState in machine.c
Date: Sat, 30 Dec 2023 08:22:46 +1100
Message-Id: <20231229212346.147149-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-12-richard.henderson@linaro.org>
---
 target/microblaze/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
index d24def3992..51705e4f5c 100644
--- a/target/microblaze/machine.c
+++ b/target/microblaze/machine.c
@@ -22,7 +22,7 @@
 #include "migration/cpu.h"
 
 
-static VMStateField vmstate_mmu_fields[] = {
+static const VMStateField vmstate_mmu_fields[] = {
     VMSTATE_UINT64_2DARRAY(rams, MicroBlazeMMU, 2, TLB_ENTRIES),
     VMSTATE_UINT8_ARRAY(tids, MicroBlazeMMU, TLB_ENTRIES),
     VMSTATE_UINT32_ARRAY(regs, MicroBlazeMMU, 3),
@@ -60,7 +60,7 @@ static const VMStateInfo vmstate_msr = {
     .put = put_msr,
 };
 
-static VMStateField vmstate_env_fields[] = {
+static const VMStateField vmstate_env_fields[] = {
     VMSTATE_UINT32_ARRAY(regs, CPUMBState, 32),
 
     VMSTATE_UINT32(pc, CPUMBState),
@@ -92,7 +92,7 @@ static const VMStateDescription vmstate_env = {
     .fields = vmstate_env_fields,
 };
 
-static VMStateField vmstate_cpu_fields[] = {
+static const VMStateField vmstate_cpu_fields[] = {
     VMSTATE_CPU(),
     VMSTATE_STRUCT(env, MicroBlazeCPU, 1, vmstate_env, CPUMBState),
     VMSTATE_END_OF_LIST()
-- 
2.34.1


