Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B5A8266DB
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 01:15:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMdHN-00061n-GM; Sun, 07 Jan 2024 19:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rMdHL-00061Q-VT; Sun, 07 Jan 2024 19:14:07 -0500
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rMdH5-0000Jt-H4; Sun, 07 Jan 2024 19:14:07 -0500
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3606c7a4cb5so15257705ab.3; 
 Sun, 07 Jan 2024 16:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704672830; x=1705277630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzamXCpLxEay9M5YGNIWRAjHptEGseFQM8AYZ2e7o/k=;
 b=JV05nDa5U6AlKBnpafd4yu9jiI342niFryxOVKIR3jVTcsfpR52iVt+gO+ElCj9RYD
 ALw8vlsrxbFTfj2l3N8nYZXXDmVwYjjwWKHbeghyCE/6qmRLxRk0aRLzf/k/setSGRKp
 /levGBv1eTHF54MjxwQME9hd1XbDiAiwJ/ohxaymZlenWUITWXcmok5prdC3Jr7DfaiA
 NNJvClRKYj2iXjmGACfRLfT0ZSKagKLGOdW6nex2ioJO2Cce8qms/v3U2DvByja0FpoV
 cdCvriJi/dUQ5TC2cQwH6xQRN/5ZEBcLsEUEKFiqHB6ocY+c+d46Xs9IfFOTyrNovWOC
 AQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672830; x=1705277630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzamXCpLxEay9M5YGNIWRAjHptEGseFQM8AYZ2e7o/k=;
 b=bBpwAGTPXsPD9JOxA1qgIwRaP5atcr+n0nYITUIkt+oBkDUkFcq06IL+nnDVLgoWt3
 cn0tyQ3noVcEettM/xUPyhBziO42/AynziC7YkoaBsy7J9yhleeRloP2SdcZBt6I5WhI
 rJmINjaopuuJ4A2z0Z1U4kq+ZwFZQuES+TWthCVU1WcbOsgNdOVw9tEO85OronfMt9XH
 eWV61pMJOHGxKlPCbxfLbkw3W4R1I5mr5EN0PzISJ6+55tj65PjLTjX78hVwOk4BcJ7d
 G4aL4NAmdiYwFHV/oB/moVP3unbVUtmYGtzQcH1YojdI74vTLFY34BARNSQSsRBEYfQn
 SYyQ==
X-Gm-Message-State: AOJu0YxUJyGiLwhXetPbwH/asy356rynlKHKopcOUzYt2YS8KzDh9trZ
 jPn6ETyiaRfCu1AVBv2PowU=
X-Google-Smtp-Source: AGHT+IFN06+nWdsdhZe5odsxv42OnYTo1YV9/R6LO8/4owMscpLto6fOtXdju5hG+V4QRo8yy0BWxg==
X-Received: by 2002:a05:6e02:1c48:b0:35f:f3af:3634 with SMTP id
 d8-20020a056e021c4800b0035ff3af3634mr6097904ilg.125.1704672830146; 
 Sun, 07 Jan 2024 16:13:50 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a170902b70f00b001d4974385d4sm4943434pls.250.2024.01.07.16.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 16:13:49 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, palmer@dabbelt.com,
 dbarboza@ventanamicro.com, bin.meng@windriver.com, qemu-devel@nongnu.org,
 liwei1518@gmail.com
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 3/3] target/riscv: Ensure mideleg is set correctly on reset
Date: Mon,  8 Jan 2024 10:13:28 +1000
Message-ID: <20240108001328.280222-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108001328.280222-1-alistair.francis@wdc.com>
References: <20240108001328.280222-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x132.google.com
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

Bits 10, 6, 2 and 12 of mideleg are read only 1 when the Hypervisor is
enabled. We currently only set them on accesses to mideleg, but they
aren't correctly set on reset. Let's ensure they are always the correct
value.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1617
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b07a76ef6b..e20ff46c23 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -891,6 +891,14 @@ static void riscv_cpu_reset_hold(Object *obj)
     /* mmte is supposed to have pm.current hardwired to 1 */
     env->mmte |= (EXT_STATUS_INITIAL | MMTE_M_PM_CURRENT);
 
+    /*
+     * Bits 10, 6, 2 and 12 of mideleg are read only 1 when the Hypervisor
+     * extension is enabled.
+     */
+    if (riscv_has_ext(env, RVH)) {
+        env->mideleg |= HS_MODE_INTERRUPTS;
+    }
+
     /*
      * Clear mseccfg and unlock all the PMP entries upon reset.
      * This is allowed as per the priv and smepmp specifications
-- 
2.43.0


