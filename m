Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D8C7F1F67
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:46:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5C5S-0005bz-I8; Mon, 20 Nov 2023 16:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r5C5E-0005U7-KF
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:45:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r5C59-0005wU-Pd
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700516726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yOi8zo4jI/uumYmIqWG8dRZhTC7Umkqv7tQVWJif/z0=;
 b=c/mWOfwS11M63g+Pt2NR/Vi4dMTfr1BjjrymyDZ+GVvMR3flosOooWTcV1Gti8DTFx4624
 5s+/A5O1+cnJ3KgAu2PMD7m/s+f4c0FK2AovkP9HLNebeqD5tfl33TzlfonKKYhimZgZES
 XPXMuAVlSanF3Xjr4CObQKZ5j8XDW9E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-2X9WDuReMtOfcfuBPuJepw-1; Mon, 20 Nov 2023 16:45:25 -0500
X-MC-Unique: 2X9WDuReMtOfcfuBPuJepw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9fcfa742e49so116719066b.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516723; x=1701121523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yOi8zo4jI/uumYmIqWG8dRZhTC7Umkqv7tQVWJif/z0=;
 b=NYwmA5qTavSoQsbbsX2SjjKD0CeROU05o/cIM+os4Zhkp1fWc9tpIdFwAV60xPKzLi
 T4NamtPoxwCO6Xe+oF9H+4fssUGOpmTQkkpHjR8M8yp3fTboVPDBSPq9bzB1Yyth7yTy
 9AhLgF4X4foNZg/Gh1xBqkRXU1xCjMr/RRYMWCbRbzBysbchifKEaaB9OKdzHhboKwDB
 PHqdcNKJ4fFFHhwFZRjLNvDBR4B8Ka0ifvlornirYAK+Cd25KSrEpyGGOM09/QWjxDiq
 8ynQAAybZo7+5E0DQkeswEby5DvytXkv+p/hWy3p1tQCcgHEoIPOk777xUU1HY7rCIna
 uL3w==
X-Gm-Message-State: AOJu0YzBWIzAzDYUz1Aki7EbbFti6Uzfm5YlxJrez0eFPlk9Z3aw90Hh
 vYTkWCKeqOaV2PX/4Wj+8LJo4+5UiS3kT6YcsCqk0xDQACIy1Th0yxGgzVLwOEGUDOIT/VSa+PY
 6Ms3P1XEyNvjNTCi21TgHgL4o5skcz0lJ4i48RiGtlrjBQylJeTdCLMCr8Sjlr8FFQ/9UNUGdMT
 A=
X-Received: by 2002:a17:906:a86:b0:9fd:a5da:cff7 with SMTP id
 y6-20020a1709060a8600b009fda5dacff7mr3577216ejf.29.1700516723393; 
 Mon, 20 Nov 2023 13:45:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdlY0f+gM4n0j5GU3iqvKD4uvFJdi2YTP59pvNPLv8Fpasxw8gtjs/swSvSWiwOPow8+JXPQ==
X-Received: by 2002:a17:906:a86:b0:9fd:a5da:cff7 with SMTP id
 y6-20020a1709060a8600b009fda5dacff7mr3577206ejf.29.1700516722908; 
 Mon, 20 Nov 2023 13:45:22 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a170906530b00b009d23e00a90esm4365376ejo.24.2023.11.20.13.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 13:45:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2] disas/cris: Pass buffer size to format_dec() to avoid
 overflow warning
Date: Mon, 20 Nov 2023 22:45:20 +0100
Message-ID: <20231120214520.59431-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Message-ID: <20231120132222.82138-1-philmd@linaro.org>
[Rewritten to fix logic and avoid repeated expression. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 disas/cris.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/disas/cris.c b/disas/cris.c
index 0b0a3fb9165..409a224c5d1 100644
--- a/disas/cris.c
+++ b/disas/cris.c
@@ -1731,10 +1731,10 @@ format_hex (unsigned long number,
    unsigned (== 0).  */
 
 static char *
-format_dec (long number, char *outbuffer, int signedp)
+format_dec (long number, char *outbuffer, size_t outsize, int signedp)
 {
   last_immediate = number;
-  sprintf (outbuffer, signedp ? "%ld" : "%lu", number);
+  snprintf (outbuffer, outsize, signedp ? "%ld" : "%lu", number);
 
   return outbuffer + strlen (outbuffer);
 }
@@ -1876,6 +1876,12 @@ print_flags (struct cris_disasm_data *disdata, unsigned int insn, char *cp)
   return cp;
 }
 
+#define FORMAT_DEC(number, tp, signedp)                      \
+    format_dec (number, tp, ({                                \
+            assert(tp >= temp && tp <= temp + sizeof(temp)); \
+            temp + sizeof(temp) - tp;                        \
+        }), signedp)
+
 /* Print out an insn with its operands, and update the info->insn_type
    fields.  The prefix_opcodep and the rest hold a prefix insn that is
    supposed to be output as an address mode.  */
@@ -2105,7 +2111,7 @@ print_with_operands (const struct cris_opcode *opcodep,
 	    if ((*cs == 'z' && (insn & 0x20))
 		|| (opcodep->match == BDAP_QUICK_OPCODE
 		    && (nbytes <= 2 || buffer[1 + nbytes] == 0)))
-	      tp = format_dec (number, tp, signedp);
+	      tp = FORMAT_DEC (number, tp, signedp);
 	    else
 	      {
 		unsigned int highbyte = (number >> 24) & 0xff;
@@ -2241,7 +2247,7 @@ print_with_operands (const struct cris_opcode *opcodep,
 				       with_reg_prefix);
 		      if (number >= 0)
 			*tp++ = '+';
-		      tp = format_dec (number, tp, 1);
+		      tp = FORMAT_DEC (number, tp, 1);
 
 		      info->flags |= CRIS_DIS_FLAG_MEM_TARGET_IS_REG;
 		      info->target = (prefix_insn >> 12) & 15;
@@ -2340,7 +2346,7 @@ print_with_operands (const struct cris_opcode *opcodep,
 			  {
 			    if (number >= 0)
 			      *tp++ = '+';
-			    tp = format_dec (number, tp, 1);
+			    tp = FORMAT_DEC (number, tp, 1);
 			  }
 		      }
 		    else
@@ -2397,7 +2403,7 @@ print_with_operands (const struct cris_opcode *opcodep,
 	break;
 
       case 'I':
-	tp = format_dec (insn & 63, tp, 0);
+	tp = FORMAT_DEC (insn & 63, tp, 0);
 	break;
 
       case 'b':
@@ -2426,11 +2432,11 @@ print_with_operands (const struct cris_opcode *opcodep,
       break;
 
     case 'c':
-      tp = format_dec (insn & 31, tp, 0);
+      tp = FORMAT_DEC (insn & 31, tp, 0);
       break;
 
     case 'C':
-      tp = format_dec (insn & 15, tp, 0);
+      tp = FORMAT_DEC (insn & 15, tp, 0);
       break;
 
     case 'o':
@@ -2463,7 +2469,7 @@ print_with_operands (const struct cris_opcode *opcodep,
 	if (number > 127)
 	  number = number - 256;
 
-	tp = format_dec (number, tp, 1);
+	tp = FORMAT_DEC (number, tp, 1);
 	*tp++ = ',';
 	tp = format_reg (disdata, (insn >> 12) & 15, tp, with_reg_prefix);
       }
@@ -2474,7 +2480,7 @@ print_with_operands (const struct cris_opcode *opcodep,
       break;
 
     case 'i':
-      tp = format_dec ((insn & 32) ? (insn & 31) | ~31L : insn & 31, tp, 1);
+      tp = FORMAT_DEC ((insn & 32) ? (insn & 31) | ~31L : insn & 31, tp, 1);
       break;
 
     case 'P':
-- 
2.41.0


