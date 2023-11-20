Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C627F144C
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 14:22:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r54ET-0007ey-B0; Mon, 20 Nov 2023 08:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r54EP-0007en-Mh
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 08:22:29 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r54EN-0008UZ-NY
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 08:22:29 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so14318715e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 05:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700486545; x=1701091345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2y1sL+gKEFG55CTwAoEXtCcaUVie133WeBtuFqTdgic=;
 b=qTII3eyVui8d0JB6WwPqnG+tHoKppKvpQNoqt6Ps2ccaQ5bvO04ygKVU+SzefS7Q+7
 p4XxNB5eJHCSM5PJM3+xUT8I1f9Qk5DcAV0IZ7dXn4c4C2QThpJZqjMXK+JI8T2B5DhB
 2Fv4va/ppuaua5yaUBh8Nr/HNZnUNp+2wF8CLRq+7GARs6gu9P+GttRqoE/VCweag6em
 O6zFu21hV6zWX0/0zyf/RdpHHExipW0dQWchlVSP7QImS8RvsbbSYvHo4vnbZiLSE4Dw
 OkaWivEGnxT6MbAAwob5G8AG4TF7nonyBklZbPCtr56Huu1huTND7kjJoWxiLw0i53Hb
 cDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700486545; x=1701091345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2y1sL+gKEFG55CTwAoEXtCcaUVie133WeBtuFqTdgic=;
 b=GHA0Cu7nAmxDUeQC84O47KzaMdSFKlCHHQBVNFROarTw2cpoGujSTCQ0HfF9lPhGdr
 gQgUkzgJUVDwEnSpNBcGj/9OFvUsKLNZDOSorJLkWj1VQTvKI3Tf28GiniGHTfnIoxqS
 deBYkaUNtOsyXmj3Fj4rkXpel6ds6bSU2HI2tmt6YY7Z3XIPOw/Bqct3tuf5kYNO/Qa8
 h0Xnc/Zqp8tutFXZMhKf3PT2c4ujoRIGBXDY9QGNstuCqYgLZHqHXjS1M+dqOH7Qz216
 SpPz3GNisEH2DE7KK+OnuiZ7kXY3PGFjMHKActiGoT0Y1ygQTnX2J5Jmf27VwTvN12hG
 Oifw==
X-Gm-Message-State: AOJu0Yzf0iKFO83WURdiEnJqk0D/8umaAuDSimyj4K/NSH3bntvAO7T/
 Itest0a09nhDa+OCa6CiNZuijobkr6S1Sw9s54U=
X-Google-Smtp-Source: AGHT+IFx0N+SXbzAbm3TnGqpe5SJlPcGl0NiErYFT6JV/ljCQJLdR6DcwddPI3bXtNlUvhX8r0ey+A==
X-Received: by 2002:a5d:40d1:0:b0:32f:7ee7:1f6c with SMTP id
 b17-20020a5d40d1000000b0032f7ee71f6cmr4476780wrq.35.1700486545011; 
 Mon, 20 Nov 2023 05:22:25 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 z5-20020adff745000000b0032d829e10c0sm11152229wrp.28.2023.11.20.05.22.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 05:22:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [RFC-PATCH-for-8.2?] disas/cris: Pass buffer size to format_dec() to
 avoid overflow warning
Date: Mon, 20 Nov 2023 14:22:22 +0100
Message-ID: <20231120132222.82138-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Propagate the buffer size to format_dec() and use snprintf().

This should silence this UBSan -Wformat-overflow warning:

  In file included from /usr/include/stdio.h:906,
                   from include/qemu/osdep.h:114,
                   from ../disas/cris.c:21:
  In function 'sprintf',
      inlined from 'format_dec' at ../disas/cris.c:1737:3,
      inlined from 'print_with_operands' at ../disas/cris.c:2477:12,
      inlined from 'print_insn_cris_generic.constprop' at ../disas/cris.c:2690:8:
  /usr/include/bits/stdio2.h:30:10: warning: null destination pointer [-Wformat-overflow=]
   30 |   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   31 |                                   __glibc_objsize (__s), __fmt,
      |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   32 |                                   __va_arg_pack ());
      |                                   ~~~~~~~~~~~~~~~~~

Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
TODO: add compiler version

Surgical alternative to this patch from Akihiko:
https://lore.kernel.org/all/20231120112329.4149-1-akihiko.odaki@daynix.com/
---
 disas/cris.c | 47 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/disas/cris.c b/disas/cris.c
index 0b0a3fb916..74a487c733 100644
--- a/disas/cris.c
+++ b/disas/cris.c
@@ -1731,10 +1731,10 @@ format_hex (unsigned long number,
    unsigned (== 0).  */
 
 static char *
-format_dec (long number, char *outbuffer, int signedp)
+format_dec(long number, char *outbuffer, size_t outsize, int signedp)
 {
   last_immediate = number;
-  sprintf (outbuffer, signedp ? "%ld" : "%lu", number);
+  snprintf(outbuffer, outsize, signedp ? "%ld" : "%lu", number);
 
   return outbuffer + strlen (outbuffer);
 }
@@ -1898,6 +1898,7 @@ print_with_operands (const struct cris_opcode *opcodep,
      intermediate parts of the insn.  */
   char temp[sizeof (".d [$r13=$r12-2147483648],$r10") * 2];
   char *tp = temp;
+  ptrdiff_t tp_avail;
   static const char mode_char[] = "bwd?";
   const char *s;
   const char *cs;
@@ -2102,12 +2103,13 @@ print_with_operands (const struct cris_opcode *opcodep,
 		number = 42;
 	      }
 
-	    if ((*cs == 'z' && (insn & 0x20))
-		|| (opcodep->match == BDAP_QUICK_OPCODE
-		    && (nbytes <= 2 || buffer[1 + nbytes] == 0)))
-	      tp = format_dec (number, tp, signedp);
-	    else
-	      {
+        if ((*cs == 'z' && (insn & 0x20))
+            || (opcodep->match == BDAP_QUICK_OPCODE
+            && (nbytes <= 2 || buffer[1 + nbytes] == 0))) {
+            tp_avail = temp - tp;
+            assert(tp_avail >= 0);
+            tp = format_dec(number, tp, tp_avail, signedp);
+        } else {
 		unsigned int highbyte = (number >> 24) & 0xff;
 
 		/* Either output this as an address or as a number.  If it's
@@ -2241,7 +2243,9 @@ print_with_operands (const struct cris_opcode *opcodep,
 				       with_reg_prefix);
 		      if (number >= 0)
 			*tp++ = '+';
-		      tp = format_dec (number, tp, 1);
+          tp_avail = temp - tp;
+          assert(tp_avail >= 0);
+          tp = format_dec(number, tp, tp_avail, 1);
 
 		      info->flags |= CRIS_DIS_FLAG_MEM_TARGET_IS_REG;
 		      info->target = (prefix_insn >> 12) & 15;
@@ -2340,7 +2344,9 @@ print_with_operands (const struct cris_opcode *opcodep,
 			  {
 			    if (number >= 0)
 			      *tp++ = '+';
-			    tp = format_dec (number, tp, 1);
+          tp_avail = temp - tp;
+          assert(tp_avail >= 0);
+          tp = format_dec(number, tp, tp_avail, 1);
 			  }
 		      }
 		    else
@@ -2397,7 +2403,9 @@ print_with_operands (const struct cris_opcode *opcodep,
 	break;
 
       case 'I':
-	tp = format_dec (insn & 63, tp, 0);
+          tp_avail = temp - tp;
+          assert(tp_avail >= 0);
+          tp = format_dec(insn & 63, tp, tp_avail, 0);
 	break;
 
       case 'b':
@@ -2426,11 +2434,15 @@ print_with_operands (const struct cris_opcode *opcodep,
       break;
 
     case 'c':
-      tp = format_dec (insn & 31, tp, 0);
+      tp_avail = temp - tp;
+      assert(tp_avail >= 0);
+      tp = format_dec(insn & 31, tp, tp_avail, 0);
       break;
 
     case 'C':
-      tp = format_dec (insn & 15, tp, 0);
+      tp_avail = temp - tp;
+      assert(tp_avail >= 0);
+      tp = format_dec(insn & 15, tp, tp_avail, 0);
       break;
 
     case 'o':
@@ -2463,7 +2475,9 @@ print_with_operands (const struct cris_opcode *opcodep,
 	if (number > 127)
 	  number = number - 256;
 
-	tp = format_dec (number, tp, 1);
+    tp_avail = temp - tp;
+    assert(tp_avail >= 0);
+    tp = format_dec(number, tp, tp_avail, 1);
 	*tp++ = ',';
 	tp = format_reg (disdata, (insn >> 12) & 15, tp, with_reg_prefix);
       }
@@ -2474,7 +2488,10 @@ print_with_operands (const struct cris_opcode *opcodep,
       break;
 
     case 'i':
-      tp = format_dec ((insn & 32) ? (insn & 31) | ~31L : insn & 31, tp, 1);
+      tp_avail = temp - tp;
+      assert(tp_avail >= 0);
+      tp = format_dec((insn & 32) ? (insn & 31) | ~31L : insn & 31,
+                      tp, tp_avail, 1);
       break;
 
     case 'P':
-- 
2.41.0


