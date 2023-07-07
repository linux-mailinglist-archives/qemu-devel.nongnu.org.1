Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F80274B043
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgt-000272-Ip; Fri, 07 Jul 2023 07:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgr-00025c-Oa; Fri, 07 Jul 2023 07:31:57 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgp-0006Zc-2O; Fri, 07 Jul 2023 07:31:57 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1b055511b85so1664697fac.2; 
 Fri, 07 Jul 2023 04:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729513; x=1691321513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awLLcEuof0r9FCsBYOzlLJecOACX4RR8zf0Y7ZB7uvM=;
 b=Um4grg2+RAgdoAEX/rY6wQyLqIf1CYYEcYG/mqQBLSqjFSDaAwFPRd/m3HTKu5bmnb
 LKSPUwP9XyDyiObuWWUdOEzPLNaq6+nc93i3Krdiaer1HprCU+WheIGkMEg55CQkC1GO
 qtcn2j5SoLC6reiIBmZ62yBwTasxNvDeWTSvCeEcKoPbuARVeCXll3fQKhmsbC2pFl9g
 K7d3paHb8lzOi65jN9Mhz9hwCMfi0QxNwoJc/IIsbq7n3OepKuNq7Y8MFOvY+kfmP120
 1Vrpg6FOVxhwZ4pHdzWmGsZbL0I5yiVq5XNEY1vLOq6MjY4Q10ntBU6tCkXrFA6iTk2r
 t7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729513; x=1691321513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=awLLcEuof0r9FCsBYOzlLJecOACX4RR8zf0Y7ZB7uvM=;
 b=ae+PXSkT4MDPW3g//3bPCMK/0LcQtXpJTGr2oktM703VS/BQEmAgL3emF4azPNp/Oz
 fPAYJPw05Ds3l/QdkrNEpDJPG0DsJ4oeK3GW1pt3K5Kv5ZPkD1/zcM/3Vkg5Et6s8PdP
 ZT/HcDbYXLPhrqO0Zd0UgFs8LExwxHTh2ioiKCYpfjXUnp4M2tTvfaCttK++pxNwdbeE
 groKgbPQktwMb0qXI8sJw0RSDlle+rYTgpdM8wydFKGLXg6JQNGXB5gdAmFLw47mdZdW
 LMpoy7KKAOaJCxt8WhjCJUwoHphSzwn6Zt1KeXyq5R9Ujg70IBCpGwqpPtl4FD+X/iDl
 bDNA==
X-Gm-Message-State: ABy/qLbrTGC8csAO2bAiQtgAtxXdYRLP9VohYygqbOw8dpLQ9SWjhpSc
 8Y3UO4PjKpDcRsLJSqkbBCQbwek+JkY=
X-Google-Smtp-Source: APBJJlEJQ1f5IE0HlQ5Nmm04W65jxZBK8jFGjce9clNsNkx20YMVpX8YC3zrZ7qAdDFv8ubQK9DvRg==
X-Received: by 2002:a05:6870:9708:b0:1b3:ab3d:8dfc with SMTP id
 n8-20020a056870970800b001b3ab3d8dfcmr4907999oaq.11.1688729513447; 
 Fri, 07 Jul 2023 04:31:53 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:31:53 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 12/60] target/ppc: Remove some superfluous parentheses
Date: Fri,  7 Jul 2023 08:30:20 -0300
Message-ID: <20230707113108.7145-13-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <8384ed0f7335093012bbd3d28fb2a543a2e7346c.1686868895.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/excp_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 2158390e27..f51a8db075 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1030,7 +1030,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
     {
         int lev = env->error_code;
 
-        if ((lev == 1) && cpu->vhyp) {
+        if (lev == 1 && cpu->vhyp) {
             dump_hcall(env);
         } else {
             dump_syscall(env);
@@ -1048,7 +1048,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
          * uses VOF and the 74xx CPUs, so although the 74xx don't have
          * HV mode, we need to keep hypercall support.
          */
-        if ((lev == 1) && cpu->vhyp) {
+        if (lev == 1 && cpu->vhyp) {
             PPCVirtualHypervisorClass *vhc =
                 PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
             vhc->hypercall(cpu->vhyp, cpu);
@@ -1572,7 +1572,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
         lev = env->error_code;
 
-        if ((lev == 1) && cpu->vhyp) {
+        if (lev == 1 && cpu->vhyp) {
             dump_hcall(env);
         } else {
             dump_syscall(env);
@@ -1585,7 +1585,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         env->nip += 4;
 
         /* "PAPR mode" built-in hypercall emulation */
-        if ((lev == 1) && books_vhyp_handles_hcall(cpu)) {
+        if (lev == 1 && books_vhyp_handles_hcall(cpu)) {
             PPCVirtualHypervisorClass *vhc =
                 PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
             vhc->hypercall(cpu->vhyp, cpu);
-- 
2.41.0


