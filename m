Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C54CB80BD7D
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 23:08:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCRxS-0004xs-9D; Sun, 10 Dec 2023 17:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxQ-0004xD-9X
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:28 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxO-0004ZG-S4
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:28 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-58e28e0461bso2281230eaf.1
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 14:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702246045; x=1702850845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VE8SldnlUWLsAkTls79GcRUG0/TMtf9McVHfy+l+F64=;
 b=e3qmq0PtvKsUEZ2Ecx/G4guWgQjt9uuhi5yTcZscObp2Sys+Bji1Ix/3SJ7g+oyIZy
 NyC/wzoa/rCTiVl9/IrfS2nPHFhrfPSO0oURVJqOBWWXarG+rnkzqB6+rOOvWUomaWrs
 FsqDzxe09Ln+1Us7llhA33XYjgU3V0lmpPm7MoNXzHCRBTsOxF2kfE36RpDFm/v5sNSW
 w5X101QyqhV/YdCy2tDmGJGSEjRMVlnnQ34sjZp2DpFUeoGSzLhFxtXh5FWfObVEzXOD
 5mStiuFirJOJLnvaXDk4O23eExzOcBiWfZUnbYAf7EhCDV9UUcsST6Eu6/oOWEJSdHpN
 Cnkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702246045; x=1702850845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VE8SldnlUWLsAkTls79GcRUG0/TMtf9McVHfy+l+F64=;
 b=GduAPBnnTzN9ONxTHkqbyxYldRO98RAgTUub+7w1m+y+4NX02Y04iUN1KXVrUgD5Zd
 4/J6u1Ft179vs6/o7wU2MXu4haz2uhoEeyyjfkmd2Tbni0GXY1SqY2gaguxJleCwupq6
 WkLIinq5SgImzMZrMcOTLJFHn+VkPbMgOOtpWVTMnvJ4Z8dahr+RoXtcP6AY/yNQlK7j
 E7y8S6WmJ8pjNQWIlSQBqR4X0ipJgHsocT4HXugpyY3CXUpf57NX3tLOSkt3biY7wJta
 2m4d1cNQT5c40dIp0N9D9eVUOt3sJgQyIkXBjBidHy5iS17WALdxaAIcypx5fcy4lmj9
 FwEg==
X-Gm-Message-State: AOJu0YydemWe+afTung6/x+5UkiaQbOFLTRdNphgE9I0stNFg0cGQwNx
 HlyiUqf0/5FX6eY3zXjKcXdPGNsCvIwsDw==
X-Google-Smtp-Source: AGHT+IE6tQievG5dU7Uzx04GDl/U2JSaH46/6UVF84kVgb++5F8EZj5V5lj8dQM90sDvZTZkgB82ZQ==
X-Received: by 2002:a05:6820:1627:b0:590:2b6d:a862 with SMTP id
 bb39-20020a056820162700b005902b6da862mr2138763oob.15.1702246044970; 
 Sun, 10 Dec 2023 14:07:24 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 q23-20020a4a6c17000000b0058e200a9065sm1588173ooc.29.2023.12.10.14.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 14:07:24 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 6/9] Hexagon (target/hexagon) Make generators object
 oriented - gen_op_regs
Date: Sun, 10 Dec 2023 15:07:09 -0700
Message-Id: <20231210220712.491494-7-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
References: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo1-xc2f.google.com
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

Reviewed-by: Brian Cain <bcain@quicinc.com>
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


