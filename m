Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 334F17C80FB
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:55:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqw-0002D7-DI; Fri, 13 Oct 2023 04:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqY-0000jL-RD
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:38 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqS-000167-Mw
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3231dff4343so1170831f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186911; x=1697791711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wma/LfPEhTSCVT/vWtJT3ahd546XNc3ZJHgiAxgAERk=;
 b=l+Fn/Nbx/HYD5jTyB04jKR/GWh8ucnnAhKkrtzXqIHq7O6NC6XjmueMdYbdr9EQa0/
 xJPJplAKgaqGZ1NN+ePGQjSgSPNNTgETRu6Za57OvdfADtXUstaVg3DEfOHW7j/i9F62
 hRXK/37mgTO7MMnGXeO+fpBsXoSWKb5VD2VRl+P0PtgQwpcgeef70tHkXfYH55MdYPQV
 jPw8gforIEY468jgNCCRM84O7BTHeJWLSNg8JriD1FJxK3umhj4ffaWqeebe9cmOzmnt
 mZE12bnVLtP5zn95XPVCyZKd1rdAPEOLm8WmR2E/9oOn1CibJlxSwuG3yoByAFXXNKUq
 Ya7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186911; x=1697791711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wma/LfPEhTSCVT/vWtJT3ahd546XNc3ZJHgiAxgAERk=;
 b=B2JdGSqvBWJQh17LjzlRVQWzENJnBMguoJwbTL9Jfx30id4zRWbD9rkibm6c0w7G/C
 cfpYuJKEyEkIzP8iwkvHH+z91soY8ySE8g+bZZp2XigppShy+PtJcXS+FvcBAASznqUo
 PZkWiU4dpyXxSKIW0udk2rSgQrgBrqU2Le3wbhG83tq5IVAGkJAD43F5roJelvBXfEVq
 71UYBDObupCZlSvTbdCgevvsrUfMo6gruafMDVXKA8gPoaKs+vi5yik0vgoyN5cALdJ0
 UhawvrTdhj7v5A+2Pt6Gk5oBrU51Ff0ghrvFktVIX46bQRbnhRI954hlTPFeDf07Oihw
 r5kQ==
X-Gm-Message-State: AOJu0YwuEM+/GlKMM2UC9PkoKv58p+u00BMEfcH+LfCTPEtD4eXSR3tx
 Tqo9mM1j9PgVtMWnVLPk/ZZOx1DWZrJxqIwIvi8=
X-Google-Smtp-Source: AGHT+IE4bDzRs+jXW9zDePW7Y1E4EomUVLFNGpAkoFKwxBHIdQiNdiPMlaCm2IiGsApg21jisYt2fg==
X-Received: by 2002:a5d:668c:0:b0:317:6579:2b9f with SMTP id
 l12-20020a5d668c000000b0031765792b9fmr18366446wru.30.1697186911001; 
 Fri, 13 Oct 2023 01:48:31 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:30 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [RFC PATCH v3 46/78] disas: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:14 +0300
Message-Id: <6470aad157306403e22f24d9b60bd041eb602366.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 disas/hppa.c  | 4 ++--
 disas/m68k.c  | 2 +-
 disas/sh4.c   | 6 +++---
 disas/sparc.c | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/disas/hppa.c b/disas/hppa.c
index dcf9a47f34..1a2bdb8d39 100644
--- a/disas/hppa.c
+++ b/disas/hppa.c
@@ -2027,7 +2027,7 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
 			 completer.  */
 		    case 'X':
 		      fputs_filtered (" ", info);
-		      /* FALLTHRU */
+		      fallthrough;
 
 		    case 'A':
 		      if (GET_FIELD (insn, 24, 24))
@@ -2104,7 +2104,7 @@ print_insn_hppa (bfd_vma memaddr, disassemble_info *info)
 			 format completer.  */
 		    case 'E':
 		      fputs_filtered (" ", info);
-		      /* FALLTHRU */
+		      fallthrough;
 
 		    case 'e':
 		      if (GET_FIELD (insn, 30, 30))
diff --git a/disas/m68k.c b/disas/m68k.c
index 1f16e295ab..a755951bb7 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -1623,7 +1623,7 @@ print_insn_arg (const char *d,
 
     case 'X':
       place = '8';
-      /* fall through */
+      fallthrough;
     case 'Y':
     case 'Z':
     case 'W':
diff --git a/disas/sh4.c b/disas/sh4.c
index dcdbdf26d8..f7c95407ca 100644
--- a/disas/sh4.c
+++ b/disas/sh4.c
@@ -1757,7 +1757,7 @@ print_insn_sh (bfd_vma memaddr, struct disassemble_info *info)
 	    case REG_N_D:
 	      if ((nibs[n] & 1) != 0)
 		goto fail;
-	      /* fall through */
+        fallthrough;
 	    case REG_N:
 	      rn = nibs[n];
 	      break;
@@ -1963,7 +1963,7 @@ print_insn_sh (bfd_vma memaddr, struct disassemble_info *info)
 		  fprintf_fn (stream, "xd%d", rn & ~1);
 		  break;
 		}
-	      /* fallthrough */
+        fallthrough;
 	    case D_REG_N:
 	      fprintf_fn (stream, "dr%d", rn);
 	      break;
@@ -1973,7 +1973,7 @@ print_insn_sh (bfd_vma memaddr, struct disassemble_info *info)
 		  fprintf_fn (stream, "xd%d", rm & ~1);
 		  break;
 		}
-	      /* fallthrough */
+        fallthrough;
 	    case D_REG_M:
 	      fprintf_fn (stream, "dr%d", rm);
 	      break;
diff --git a/disas/sparc.c b/disas/sparc.c
index 5689533ce1..61139256b0 100644
--- a/disas/sparc.c
+++ b/disas/sparc.c
@@ -2803,7 +2803,7 @@ print_insn_sparc (bfd_vma memaddr, disassemble_info *info)
                   {
                   case '+':
                     found_plus = 1;
-                    /* Fall through.  */
+                    fallthrough;
 
                   default:
                     (*info->fprintf_func) (stream, "%c", *s);
-- 
2.39.2


