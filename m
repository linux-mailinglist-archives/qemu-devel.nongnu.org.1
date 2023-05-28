Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEAD713AC4
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 18:51:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3Jap-0000cc-4v; Sun, 28 May 2023 12:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3Jam-0000bb-A7; Sun, 28 May 2023 12:50:04 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3Jak-0003di-PF; Sun, 28 May 2023 12:50:04 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5552cbcda35so1304844eaf.1; 
 Sun, 28 May 2023 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685292600; x=1687884600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uP2QaSuIXsG//a1ZA9+wHtKetoo+PJIJ53Y3HgHjslQ=;
 b=dxKdiowqj9tjq1GjplayWSxxaZNR3WnC0jhaoJ/E1k1PVamRdYJqUEcyQR4sZvEnxQ
 CPXYvE/RERDSqfOH9DaHDkUD5ER7lIjVt4O83HDoun+DVAD1p5jky8nug5ylkxGA0A7/
 BmrpgR7J/28oxBOHPpESWLgJ2QATTmiC0JAviu0oEXxzBPXtGSOa8gyWfEzn2U19Svr6
 KPkzrJvb+vKQUnF5wCO0EQMlvQLh3e1ZGKTKOeVYA9TNSYD1i7UUxGx6gQaOelcyLWnN
 5vHjiu6ysuLNVXOFk6RZlqk6fmby8ErZigiJ2DL6EZGn5KEbQsyRXEjmhANfylKwAFYv
 yzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685292600; x=1687884600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uP2QaSuIXsG//a1ZA9+wHtKetoo+PJIJ53Y3HgHjslQ=;
 b=ZVxTs0dO9HSSxFBBvnPbJJ14Qf9UFQR+i8pzYNm6Iz1tasPhdy9MnaVPEci2ta1L8Q
 d+mgYQapfxE2FV7E+zvdaFoOXIUbtqJRbtOOWG5J6jpoZq40rV1wiFYxFikkrlschZjs
 ygKjeQNCZgz+DqZkS9e4DQqpE9MbqG7XlZThko/P4Jhc/sqvLQRme5PR1Pc3U9Mp2sm7
 wTiWqMSSLvSh7XiQkuvZI0eLrgiGb0JJnw8XOTS/NPjKnCrLpti+yP3+sUanrRxWNRDL
 qTFps7GV0aESIvQEJ3nIRxT+vBydgz5NgE2DNhTuDuvHCjgnLHfp5RAfB9ZsXaG87bsT
 rHyw==
X-Gm-Message-State: AC+VfDxlCXfaA2EVS+3+Ksg+bIaCHz+FsmEiDOClNL/zQMy0IFgQnFSx
 gFeg9GmHRreOsAZOtcttVbg+m21xWFs=
X-Google-Smtp-Source: ACHHUZ6kBUOD+ze7beCbCB9N5v/A0nhFWdJvrRIrDSBgKQ2sGJgsJZF30sF83SLG56SEJ41CAgxCNQ==
X-Received: by 2002:a05:6808:1295:b0:398:5a2a:2219 with SMTP id
 a21-20020a056808129500b003985a2a2219mr6176707oiw.33.1685292600139; 
 Sun, 28 May 2023 09:50:00 -0700 (PDT)
Received: from grind.. (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 w4-20020a4adec4000000b0054f85f67f31sm3378830oou.46.2023.05.28.09.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 09:49:59 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Rene Engel <ReneEngel80@emailn.de>
Subject: [PULL 10/10] ppc/pegasos2: Change default CPU to 7457
Date: Sun, 28 May 2023 13:49:22 -0300
Message-Id: <20230528164922.20364-11-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528164922.20364-1-danielhb413@gmail.com>
References: <20230528164922.20364-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc35.google.com
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

Previously 7400 was selected as a safe choice as that is used by other
machines so it's better tested but AmigaOS does not know this CPU and
disables some features when running on it. The real hardware has
7447/7457 G4 CPU so change the default to match that now that it was
confirmed to work better with AmigaOS.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Rene Engel <ReneEngel80@emailn.de>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20230528152937.B8DAD74633D@zero.eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pegasos2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index f1650be5ee..af5489de26 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -524,7 +524,7 @@ static void pegasos2_machine_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     mc->default_boot_order = "cd";
     mc->default_display = "std";
-    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7400_v2.9");
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7457_v1.2");
     mc->default_ram_id = "pegasos2.ram";
     mc->default_ram_size = 512 * MiB;
 
-- 
2.40.1


