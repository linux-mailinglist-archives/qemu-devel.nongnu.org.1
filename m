Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E82804454
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 02:54:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAKct-0002t5-7f; Mon, 04 Dec 2023 20:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKcf-0002q9-V3
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:18 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKce-0005yM-Cu
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:17 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b84e328327so2853548b6e.2
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 17:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701741194; x=1702345994; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YX52rAacWGPHiinB+0t2CMAB9QvzNPHES8Kqre+0Amc=;
 b=kk3wBn3AzB9rN+D1WD+2/J9pLuzzQ1ApX5Gw68O7NDngKQzJToLGQka/0Oc10fqAjB
 cqiMI6xvfsGOWSGcehHpFcnZDg78l/Ayt3Eri09FyPKcyCZNG7Jt9g2a6YAxPxG6fsF/
 Sgz8XQzz7zKwvQXWzPBYBuOpnwmEBgOLD1w32AEXpNAA7p4gDe/LgeYBvp58izvAH1bv
 T2AQ9PS5ZEZI4cJJnFHQD8wMQHkLLuGsiEk1WvGq73ynp9T1GVa6jJQVsHFad/HlDHj0
 5CC+3YhL1xIshHYXZLapC3OZapOC9BkDP9OQx9wPujMR+RRW8G3wNwefvdlWnUiNuTVD
 Wm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701741194; x=1702345994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YX52rAacWGPHiinB+0t2CMAB9QvzNPHES8Kqre+0Amc=;
 b=PVWxbpUGh9dH0wk5emBj8VynMPmERg5dXbI/ex2lc4Yp0unnKOmw3A2FicXK9MMB7s
 FjOZ0YK1Ug3vbp3IRqLCfzcBlXyeHPyFq9WWmOhmHNagb/M0AMbr13Ju/Pf+SSnavQjp
 fMtE8kD63R2EjOkAox4MlFi1kaYJboTjmLaZKMNDr3HWfX745visSP51sL2jfUf1GGpz
 2oku3rHatGqTnJqMr0Ck36M9HHCjPwMv/Sija2Ld/5lN9rVJzgOltVP+YzmjaLHeXGlj
 6F0vO/xmP77yUcmLVdUL9fG0g52gMUnuX5lHjSnZATf0gKtyakG8PRSJa1Gog8faO64/
 lsBw==
X-Gm-Message-State: AOJu0Yzg9CaylsrWfEJ0oCr0OezmHClFpS+f++6aFG15K8k2SIULKj1J
 TcWqL2nH8OhK6msarNBXS7/0LEs+dXDvZA==
X-Google-Smtp-Source: AGHT+IHzJ8qe1ef4XWxnMEa8qYUbiekU6Fi3hQMVD7/u18fMokUFS57Ol/Yp3w4n7LJTlJwobY5vEA==
X-Received: by 2002:a05:6808:1a84:b0:3b8:382b:8e1f with SMTP id
 bm4-20020a0568081a8400b003b8382b8e1fmr5110639oib.28.1701741194395; 
 Mon, 04 Dec 2023 17:53:14 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 c4-20020aca1c04000000b003b8b7063a44sm1064624oic.44.2023.12.04.17.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 17:53:14 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 6/9] Hexagon (target/hexagon) Make generators object oriented
 - gen_op_regs
Date: Mon,  4 Dec 2023 18:53:00 -0700
Message-Id: <20231205015303.575807-7-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
References: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x22d.google.com
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

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/gen_op_regs.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/gen_op_regs.py b/target/hexagon/gen_op_regs.py
index a8a7712129..7b7b33895a 100755
--- a/target/hexagon/gen_op_regs.py
+++ b/target/hexagon/gen_op_regs.py
@@ -70,6 +70,7 @@ def strip_reg_prefix(x):
 def main():
     hex_common.read_semantics_file(sys.argv[1])
     hex_common.read_attribs_file(sys.argv[2])
+    hex_common.init_registers()
     tagregs = hex_common.get_tagregs(full=True)
     tagimms = hex_common.get_tagimms()
 
@@ -80,11 +81,12 @@ def main():
             wregs = []
             regids = ""
             for regtype, regid, _, numregs in regs:
-                if hex_common.is_read(regid):
+                reg = hex_common.get_register(tag, regtype, regid)
+                if reg.is_read():
                     if regid[0] not in regids:
                         regids += regid[0]
                     rregs.append(regtype + regid + numregs)
-                if hex_common.is_written(regid):
+                if reg.is_written():
                     wregs.append(regtype + regid + numregs)
                     if regid[0] not in regids:
                         regids += regid[0]
-- 
2.34.1


