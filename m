Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0236C727AF7
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 11:15:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7BiS-0001Zh-OT; Thu, 08 Jun 2023 05:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q7BiR-0001ZA-CB; Thu, 08 Jun 2023 05:13:59 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q7BiP-0005Mb-RY; Thu, 08 Jun 2023 05:13:59 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-256422ad25dso185127a91.0; 
 Thu, 08 Jun 2023 02:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686215635; x=1688807635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+doDSOWQ/yYEapg3XaTRgcOqrIoUXvANsMUQVhLDyMA=;
 b=E/ykourkCAEi95nLoOTUFYyv4QA8zQqbW1NRrHoHMNcyADwDZlrU+onm9P5nZw8gQb
 /Wt3q+ZV8ubLz+VgqSdTzHeGStNv8eMM+TATdhFx3hL0rlUAYa+4rP5S0zywVfiZ3QyU
 RbWtSSZf9xtVeqfJrwGSICye/XrJ/zy+ARN3F6IBOnX6va9dFiV++ymi/NdBzigWxwxT
 pjVYS93z2TYi3EYS/EhFq0PUXVKi42i0C+DiWdrIqjQeImtT7EhF93GZnRl8e1kclUgN
 SbdALa9TMfhV1TXRslWeshHlcg0XmxHo9MENXCu2rxIqGNKWGfE1Zq61lSdNlo7VtHeR
 bQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686215635; x=1688807635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+doDSOWQ/yYEapg3XaTRgcOqrIoUXvANsMUQVhLDyMA=;
 b=T+Sie++UXg0UIEjs2+Lpqu3WxCvLkjsN8FXfIQsa6MSm9dpJYGXGSsl/DC4omSlX9/
 bKYeh7N8BEWDeiUCZOajiWFtMkJkDes8CWRJhKk3nCf8n9jnlJ/bPwfVhdAnn4OxmiX3
 LmOz18L8w+UCxMF2+AlF5NEYNKDO69y/6vxzc0hmNOHgdgjYvorltj3FE0FMixFLfhV3
 siVKiyxL+j6sKAChG8QNdxvkIUOHEKKURm/BeiKpUhNdEN49LwEYw/7slhFeqLc0nUTI
 JQvZNv24Cd6VRiOeYcS9xgXRUg63clfyfYopzNC6gjfm52DHPO+quWykdnx3q1M+CcPr
 QfKg==
X-Gm-Message-State: AC+VfDz1ovAnnZQ86+g58g76awgPsINxQRMw2x766+/ONt91SmtvqJDR
 juFwBsyxpgNKhhBmD0XEMPWyqW+lUAk=
X-Google-Smtp-Source: ACHHUZ4CXZ7/zWCEIICrCTMBKFXV/ScMNrEhNG6Bcpdww6v61pVqTQ90FF4xEmV9gCkDuCOrCFacWQ==
X-Received: by 2002:a17:90a:bb91:b0:256:5637:2b30 with SMTP id
 v17-20020a17090abb9100b0025656372b30mr3296002pjr.40.1686215635531; 
 Thu, 08 Jun 2023 02:13:55 -0700 (PDT)
Received: from wheely.local0.net (58-6-224-112.tpgi.com.au. [58.6.224.112])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a17090a5d8b00b002563e8a0225sm823577pji.48.2023.06.08.02.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 02:13:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/4] ppc/spapr: H_ENTER_NESTED should restore host XER ca field
Date: Thu,  8 Jun 2023 19:13:41 +1000
Message-Id: <20230608091344.88685-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608091344.88685-1-npiggin@gmail.com>
References: <20230608091344.88685-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Fix missing env->ca restore when going from L2 back to the host.

Fixes: 120f738a467 ("spapr: implement nested-hv capability for the virtual hypervisor")
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_hcall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index b904755575..0582b524d1 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1773,6 +1773,7 @@ out_restore_l1:
     env->cfar = spapr_cpu->nested_host_state->cfar;
     env->xer = spapr_cpu->nested_host_state->xer;
     env->so = spapr_cpu->nested_host_state->so;
+    env->ca = spapr_cpu->nested_host_state->ca;
     env->ov = spapr_cpu->nested_host_state->ov;
     env->ov32 = spapr_cpu->nested_host_state->ov32;
     env->ca32 = spapr_cpu->nested_host_state->ca32;
-- 
2.40.1


