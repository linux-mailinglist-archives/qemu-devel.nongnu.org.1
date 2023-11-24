Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0F17F77C0
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 16:26:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Y2m-0004iU-Vp; Fri, 24 Nov 2023 10:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2l-0004i5-9T
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r6Y2j-0004Bd-NC
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 10:24:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700839472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IwpePLbK8L8er5IFJ0cDPeto50q8k0R3zr0tlVz0C5o=;
 b=J1rAFXZ3RrOMEux4TIL/1BA3T7DPUwc3jWmloQ5ejR+j75aU34QrsdE16YX4loOCNq7bjd
 0/bThATY0JxbAtQwi55Tn21SwSeBWsWT291o6Ey2Y55Y8bAQRycWe4KrStZ0FKivTC4p/v
 iqvFak2rAZT04CbPx8O/H1M7Bd7pYMU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-I61ebTawOWavAh6SRkdjGA-1; Fri, 24 Nov 2023 10:24:29 -0500
X-MC-Unique: I61ebTawOWavAh6SRkdjGA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77a12fbe7eeso193617485a.2
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 07:24:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700839468; x=1701444268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IwpePLbK8L8er5IFJ0cDPeto50q8k0R3zr0tlVz0C5o=;
 b=kgBfyIuyaEY5ZU79vakVvFJD5lQ/s8cW2lJn/qDzt53F1rwESymKjsFM50/aroRa0Y
 pQHYvxeBakcj2JPvDV5851A1/21HvOKYpzmsnHpmwbsMuHXnLjJ8ATwgn2SKNBzw1DLC
 /Wx0zcd/SmK4w1QiC0uuColyjw1mF8oXVGYhBEh7GcbKKSW0y7WRz9CpsFecRMhbf+5g
 eFYeejTBN6eNiUhJFQ2rqTVVHZjEK1MgChMVOnh2yUt2Mx4q3NyOTHQ463f6/Q3myptP
 /kjFRbzbt5iptQsMHAFqPCN4NQc0AnF2mSMr1DEcUJWiLyZOyKpkJo7KUDBiJ1HS7qOb
 65Jg==
X-Gm-Message-State: AOJu0YxpyimbftwMTV7YO23fOftoZ3wT86ikf0waiQCVfZWBKN+vM15q
 vAlmQlv4LvKcTOFCprz8oE4SO2jkXcgjyLW2nsDZ1hP9DLV9eT/KUSGB6yk1eIuFmkf69nOhY9i
 h6G8rpe6XHMFb4cTYSyt7kZSYUeg+7i2euLopdkuV0ULNY1gOTdVlN5hvzLs/SA10D+GO4jF+Vs
 Q=
X-Received: by 2002:a05:620a:4883:b0:77b:c650:5eab with SMTP id
 ea3-20020a05620a488300b0077bc6505eabmr3597048qkb.5.1700839468004; 
 Fri, 24 Nov 2023 07:24:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdXn+yvNsu8ZJm0mCUpNyFPZgmWqCuHxYjYtCan2WP1g2NA0sdqX+m77LnuRasxL8Crz+NtA==
X-Received: by 2002:a05:620a:4883:b0:77b:c650:5eab with SMTP id
 ea3-20020a05620a488300b0077bc6505eabmr3597009qkb.5.1700839467593; 
 Fri, 24 Nov 2023 07:24:27 -0800 (PST)
Received: from [10.201.49.108] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 ss12-20020a05620a3acc00b0077d62e78db9sm1282569qkn.128.2023.11.24.07.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 07:24:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 07/10] disas/cris: Pass buffer size to format_dec() to avoid
 overflow warning
Date: Fri, 24 Nov 2023 16:24:05 +0100
Message-ID: <20231124152408.140936-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124152408.140936-1-pbonzini@redhat.com>
References: <20231124152408.140936-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
2.43.0


