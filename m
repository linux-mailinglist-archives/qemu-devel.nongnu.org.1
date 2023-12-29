Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5958201BB
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:29:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKMd-0001qw-33; Fri, 29 Dec 2023 16:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKMB-0001Yu-MP
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:30 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKM9-0008C4-6p
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:27 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-204fdd685fdso1196072fac.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885124; x=1704489924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BjXj4u95pV2k58Z8fsH2ZnhnBu4eBDV3ePIvCvfEGnQ=;
 b=BnYKIYIdmd/L6ZpFNisWCzjog/cLhHLYUT2ujsJ/HtKFZYDGHC/uYN54HjgK9hImXv
 19hw1hV78bMyeyYfNxp24dgtjGnoZl5I78/p49u4GyyTjzKjGEsyefuJJPwjJ+iBNDsD
 1JW/1UpT40q17LV+fs4D6lCPsVEdiSksWDqRLmg+3spsRy8LuSnCumVfu8e0Vo00+YMq
 x3ocnyTmT4gEQETAbYgLZu774WKxJZdtCWdjXDGM9em2KHe8GhcPWtkpS5/KY6KIEvow
 1jd+Q29Q1uvWWp6F9RWAEZef5AeW2M5t43XJ2ifJ4oZFpPWZwoMDzxs1UPQ3CkXAmJsS
 B/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885124; x=1704489924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BjXj4u95pV2k58Z8fsH2ZnhnBu4eBDV3ePIvCvfEGnQ=;
 b=mSlRb1lOD/GyTswRQe9xjLDlhzLH63DUXKpqQViTKwClIWgvcNrx4uSM+OUK6T1/QT
 lk/B56fcdUdY2qeYBetioV0fjyjtIz/o8NY+qaTX+I0Q5QOy3M/JjVoqQ3WcpYJcG30H
 YEmM2yKmdCCFXNbRNSq0xHSXDgzRQSYSo6ua6KaO16eSnI/PhosnjnhzbzEjEXvnK/Vr
 /apkhsZEfT+MPO+62GOsoOhcmvzeV4J3XejBxtXFJYGvpkIS1zFHahcMVggXwZJwfBS7
 QpJkKchlze3znuVLOVkjy92W6+vWF5GphLfusAlfEKyW63xX2HUOK5lcJPPy2ELYrzLu
 Hm7Q==
X-Gm-Message-State: AOJu0Ywop9bC8FYwDR16IOBAPifaeJVn7prSFYAw2uqfCF0BCUxPt9oo
 PmtvesreZqIPmohu9Rn3DQHR9AjwYkYyASA6ctnej7bQdhHMdw==
X-Google-Smtp-Source: AGHT+IFWKJhuYfqVePAUjI5aeRjNAVVUqWEB7q5/hC0hOo+X9CwJ6mMbBJ8PaiIZAmrcSYetaC9nrg==
X-Received: by 2002:a05:6870:b4a6:b0:1fb:75c:3fdf with SMTP id
 y38-20020a056870b4a600b001fb075c3fdfmr17158247oap.63.1703885123957; 
 Fri, 29 Dec 2023 13:25:23 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.25.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:25:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/71] hw/m68k: Constify VMState
Date: Sat, 30 Dec 2023 08:23:14 +1100
Message-Id: <20231229212346.147149-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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
Message-Id: <20231221031652.119827-40-richard.henderson@linaro.org>
---
 hw/m68k/next-cube.c | 4 ++--
 hw/m68k/q800-glue.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 292f13defb..9f6f90d68b 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -923,7 +923,7 @@ static const VMStateDescription next_rtc_vmstate = {
     .name = "next-rtc",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT8(phase, NextRtc),
         VMSTATE_UINT8_ARRAY(ram, NextRtc, 32),
         VMSTATE_UINT8(command, NextRtc),
@@ -939,7 +939,7 @@ static const VMStateDescription next_pc_vmstate = {
     .name = "next-pc",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(scr1, NeXTPC),
         VMSTATE_UINT32(scr2, NeXTPC),
         VMSTATE_UINT32(old_scr2, NeXTPC),
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index f413b1599a..b5a7713863 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -189,7 +189,7 @@ static const VMStateDescription vmstate_glue = {
     .name = "q800-glue",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(ipr, GLUEState),
         VMSTATE_UINT8(auxmode, GLUEState),
         VMSTATE_TIMER_PTR(nmi_release, GLUEState),
-- 
2.34.1


