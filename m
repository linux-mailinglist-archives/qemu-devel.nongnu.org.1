Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD042825FAB
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 14:27:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rM6go-0000d7-Pu; Sat, 06 Jan 2024 08:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rM6ga-0000Y8-7U
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 08:26:00 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rM6gY-0005xz-Lw
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 08:25:59 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55778f7662bso49959a12.1
 for <qemu-devel@nongnu.org>; Sat, 06 Jan 2024 05:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704547556; x=1705152356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/a3uZAXmye1jvF0NadDhii00zuAt23ZrEREzrYmaBKk=;
 b=XupCpiCHktwONwXEAlDxzN6I90WOExCjfJPMDcyKUFaSsq70AUx0Wb+J15xXgTEeYk
 G95hpJAuwehoaHmi7M7svrt9ycx3JewHyXq+q62OX2gsa6VhICgVh2CBfn9uAdXMTVyg
 2MJxke19iURP/qY3Xol8zrbI8YDgG7axtJ5wAV/A2sXAzyifqIngH3PafxCax2O6ry0u
 NFKf6A/PX3kDosd4w29TYpvZxn/0DCNeNMGMAM4pcuMSoMWARf/NFDHlL1fba3gwPS+p
 4X/UnNYMpzeV2dTjqwQxhwiet4SjN2oYD1ZYndJZT+CwjCUlg7xOzayBHqF/PGWYvg1r
 Ixyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704547556; x=1705152356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/a3uZAXmye1jvF0NadDhii00zuAt23ZrEREzrYmaBKk=;
 b=vK/n1LYOFORALxGbuRqt5QZYVxsZe7HJtPE4ruQh6HZLAfiwePlShaG4vjtS+FJ/xU
 IPp1H/qtscRiv8XzfxiYbi1TNGVTRf6hRyF5fYdElXzuTncFmCVjQldB7Ywenyg9ip2p
 dfaHzVXp0bHwNwDcDOiJVPBPneH0lb0GuZvIXC17ovrT5PZMgAKDdkXz9ayMmTTALNSG
 SGMdmS3dEAjqAkg4Gw7yjsbs9DLCkMUx0Sr6rK90bJOtKOgbZaGw48htgPjSXWsfSaay
 c5N+5wqVT9/pC/gBTFdC5i0xTo4/FPxn1mBIhIIGfVqNsXtWbw2JxkPYOjedokls7SHO
 lEuw==
X-Gm-Message-State: AOJu0YxNhdGT/sToZDL5aDb3Qley9WdFgtbqpH6LdCOWjiqmcFcBdIAW
 AEPTcUT/bRlXvIGXgcOROt3InZyb+vI=
X-Google-Smtp-Source: AGHT+IGru39AzgFUl0fww+fXcbcpXmnkSQGe5mnCd/pUwsnBTy70LBw+WRdunCourTIWu814KcIrkw==
X-Received: by 2002:a05:6402:2684:b0:557:4a49:26b0 with SMTP id
 w4-20020a056402268400b005574a4926b0mr1270310edd.20.1704547556199; 
 Sat, 06 Jan 2024 05:25:56 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-174-094.77.11.pool.telefonica.de. [77.11.174.94])
 by smtp.gmail.com with ESMTPSA id
 3-20020a508e03000000b0055515b40464sm2159752edw.81.2024.01.06.05.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 05:25:55 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 1/3] hw/i386/x86: Reverse if statement
Date: Sat,  6 Jan 2024 14:25:44 +0100
Message-ID: <20240106132546.21248-2-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106132546.21248-1-shentey@gmail.com>
References: <20240106132546.21248-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
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

The if statement currently uses double negation when executing the else branch.
So swap the branches and simplify the condition to make the code more
comprehensible.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 2b6291ad8d..61af705e90 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -516,10 +516,10 @@ static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
     CPU_FOREACH(cs) {
         X86CPU *cpu = X86_CPU(cs);
 
-        if (!cpu->apic_state) {
-            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
-        } else {
+        if (cpu->apic_state) {
             apic_deliver_nmi(cpu->apic_state);
+        } else {
+            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
         }
     }
 }
-- 
2.43.0


