Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 328A580BD82
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 23:09:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCRxR-0004xU-Od; Sun, 10 Dec 2023 17:07:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxP-0004wY-73
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:27 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rCRxN-0004Z9-Gj
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 17:07:26 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-590bb31ccf5so945295eaf.3
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 14:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702246043; x=1702850843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNCZEt0jssVqmuXszpYWIIpR+RwMQc0XvTsifV7CiSY=;
 b=aPZTcNLZAsdHBHIzpK5eW/N7U1SrrrUpiSMVzVATdxZ4QDCbVSgAXGWwHsR3pkBTuL
 UYuPANx2mkUMMTVzFSsohssAGoddDJ/H6lya9JqGngVkO52ArbZqoO4wdm7GnSvk0OnB
 6+MPbes5WkouLYm2Fmfi0kNsWFwsAfJWkCVZbXeLEkMwfLlkzOPtUg6zZi+MJWDmOv8I
 2aaCz8H7X6nsx5xb4kdke/SSFX6oefxP5HruYnsyrb1trRDIjv8gJQw5VkV63iC34kur
 Klspxz0hekzzyDZWyEgHx97MwjEZxsRdXdkPOGRJfNCDvrfVMbyokrWniW/dBPwErjqX
 U/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702246043; x=1702850843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YNCZEt0jssVqmuXszpYWIIpR+RwMQc0XvTsifV7CiSY=;
 b=Zs+pxurLCtnw5mfw+QSSl9k1AqXMzOH/5V6tmXiNb5gbkuU8/PSFxPX+3OKscNU2EU
 iI754Hh9Y8UPixRqCEyKjOQFEymLf89nmuEogKIF9XxMZcR7eF/Nj1ifgQXawEwC/bR7
 pe+Gedw2D/6lu2Lrze6Ctlz5fBHRM81TgSlL2bxF7TqUBsGen7tPx8HB6ncudJaWDnnj
 wRRuyakkzHLopYf20sQDU7ovIY5aY3f4+Q8Y27mF1Wi7ghepempZeS6YL8XZ8YkS7Azl
 6xc1Go50vK6LzPjHgBaSLEcD7DmZRkUq7n+8vscZouJbLO7EXWVIYyqraaBqaiVUQUtU
 uTZQ==
X-Gm-Message-State: AOJu0YzPumW0BK7vPJ5u+DZHFKv+EzgLIPYsdsCk//sNl4uIddwG2qSn
 RKpVblxjiQl/muh88uvt3XTkxoNWoeKHAQ==
X-Google-Smtp-Source: AGHT+IHOKIo9l+HhCbudN5Hy/qFOhKW92sg3pbu5hYw+CbxGKklahPHXcHvZ+sNogL1FgE1omEkY6Q==
X-Received: by 2002:a05:6820:22a4:b0:590:16e7:d767 with SMTP id
 ck36-20020a05682022a400b0059016e7d767mr2408527oob.3.1702246043596; 
 Sun, 10 Dec 2023 14:07:23 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 q23-20020a4a6c17000000b0058e200a9065sm1588173ooc.29.2023.12.10.14.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 14:07:22 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH v2 5/9] Hexagon (target/hexagon) Make generators object
 oriented - gen_idef_parser_funcs
Date: Sun, 10 Dec 2023 15:07:08 -0700
Message-Id: <20231210220712.491494-6-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
References: <20231210220712.491494-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oo1-xc36.google.com
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
 target/hexagon/gen_idef_parser_funcs.py | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/target/hexagon/gen_idef_parser_funcs.py b/target/hexagon/gen_idef_parser_funcs.py
index f4518e653f..550a48cb7b 100644
--- a/target/hexagon/gen_idef_parser_funcs.py
+++ b/target/hexagon/gen_idef_parser_funcs.py
@@ -46,6 +46,7 @@ def main():
     hex_common.read_semantics_file(sys.argv[1])
     hex_common.read_attribs_file(sys.argv[2])
     hex_common.calculate_attribs()
+    hex_common.init_registers()
     tagregs = hex_common.get_tagregs()
     tagimms = hex_common.get_tagimms()
 
@@ -132,22 +133,9 @@ def main():
 
             arguments = []
             for regtype, regid in regs:
-                prefix = "in " if hex_common.is_read(regid) else ""
-
-                is_pair = hex_common.is_pair(regid)
-                is_single_old = hex_common.is_single(regid) and hex_common.is_old_val(
-                    regtype, regid, tag
-                )
-                is_single_new = hex_common.is_single(regid) and hex_common.is_new_val(
-                    regtype, regid, tag
-                )
-
-                if is_pair or is_single_old:
-                    arguments.append(f"{prefix}{regtype}{regid}V")
-                elif is_single_new:
-                    arguments.append(f"{prefix}{regtype}{regid}N")
-                else:
-                    hex_common.bad_register(regtype, regid)
+                reg = hex_common.get_register(tag, regtype, regid)
+                prefix = "in " if reg.is_read() else ""
+                arguments.append(f"{prefix}{reg.reg_tcg()}")
 
             for immlett, bits, immshift in imms:
                 arguments.append(hex_common.imm_name(immlett))
-- 
2.34.1


