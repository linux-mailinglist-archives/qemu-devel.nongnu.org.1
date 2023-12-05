Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CFA804455
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 02:54:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAKch-0002q7-TE; Mon, 04 Dec 2023 20:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKce-0002pc-0X
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:16 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rAKcc-0005xp-Hg
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 20:53:15 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3b9b90f8708so757035b6e.2
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 17:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701741193; x=1702345993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNCZEt0jssVqmuXszpYWIIpR+RwMQc0XvTsifV7CiSY=;
 b=R3TAv2fQEWq8yIrAUten5Cq3QGsS9UThAtssLx0gFSADtCOfaqHMGH8pVeN2uuphMP
 7zbey+pDVGEAYu4h7iAhJTGYpJPFpZ1QPi57GCwDkuleo6WI8EGox/kLj1gD2ZhJ8roh
 aAV7mCUeRUzfX1qrO2v10JPnFaJH6t/fY+g7n0juzRdm7hpuKoNPb1ybN246yeJoFwq9
 r7si21O1Yl30o4BRTWPZD55ceGQnKrAl1q+aPq4uECWySI97+c8UGJWyfvRHMWSwEqbt
 MJ5hfd4mexGJgALn90ghk6xzvVXxcXt0YRGXpTnS0c1M8kTuOsTb+uoLNrdffeCJY5kr
 QoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701741193; x=1702345993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YNCZEt0jssVqmuXszpYWIIpR+RwMQc0XvTsifV7CiSY=;
 b=UUjW0dA/2EgqnieEv2hsDn7lqPirNp7vRH19Fs921tKpESQv4eC1uT/g2M18a23cZJ
 2H5Ep8bSb6MnqdtoCht0oB42qSoQlPJuks0YoMHrtWL31lPmLCVywIiwsv0PrpBAqam/
 RkAq7gSeqmBVTMCT3mXsDYf320+xbWT3612SoKK2eldJfp52xXfwUxjb76ozY8uWTct1
 ++MmiKcWg/ndnxtq26VjNZ26PNRafOTlrpm6tkFq23Fq0Sn6zLoD+2baZImfwkHcMP6m
 mc04l240MqnW6Bu3qjyfO0hzfly4ZQPUERDCUskIDVEj9ryztpeM7qmBwubTBFmTLTCI
 M9aw==
X-Gm-Message-State: AOJu0YzbrBC98cf2YoNqYKlUw4e1Gjtx7trfiYsS3pwL+wpZLNh+Oab3
 gSLaSVEVtZ5vexjOIZNT1kq5QlTTZG04/Q==
X-Google-Smtp-Source: AGHT+IEVmY/O0SfAYnrYidOQIQJbjwO/TEUb38Cz4LP9W9N5s+K+0h62khdMuezponJlvJ+Vhj0DTQ==
X-Received: by 2002:a05:6808:d49:b0:3b8:b063:5d6e with SMTP id
 w9-20020a0568080d4900b003b8b0635d6emr5925730oik.85.1701741193051; 
 Mon, 04 Dec 2023 17:53:13 -0800 (PST)
Received: from taylor-ubuntu.austin.rr.com (068-203-008-061.res.spectrum.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 c4-20020aca1c04000000b003b8b7063a44sm1064624oic.44.2023.12.04.17.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 17:53:12 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 quic_mliebel@quicinc.com, richard.henderson@linaro.org, philmd@linaro.org,
 ale@rev.ng, anjo@rev.ng, ltaylorsimpson@gmail.com
Subject: [PATCH 5/9] Hexagon (target/hexagon) Make generators object oriented
 - gen_idef_parser_funcs
Date: Mon,  4 Dec 2023 18:52:59 -0700
Message-Id: <20231205015303.575807-6-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
References: <20231205015303.575807-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x234.google.com
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


