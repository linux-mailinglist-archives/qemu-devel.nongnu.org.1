Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC94747AD3
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 02:56:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGqnO-0006V8-UI; Tue, 04 Jul 2023 20:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qGo4l-0004ce-0b
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 18:00:47 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qGo4j-00069P-3T
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 18:00:46 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-34570ed4cb8so24592175ab.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688508043; x=1691100043;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=83/cdAL0KcxCkv+HhX4A2NJ1elMGjfOXi6WNzrVwof4=;
 b=S/tM4EiUdeOFAWiPEqX5RsD/Mg0XwY8KteWGtkZzEfNsYVguIbcK9kXS8dAFJbkiBN
 gnRHpuRf1GlzLbqe7Drzx8JAsOeOSuSn2CSGOzOVSPt0wC+XfjEAa2kWwnilErgnElsb
 P/yGSSWyHAXqlA6zTuqp12uNIIB+vTATaiRiGd8eJQJf5RyscC476WfTro2dObwBvGiM
 /XRJJ4lYy1zycH+cOvtkreHsL3xpaCncbW0TuKZy9WerKEwiZ+ACpf5XjUR0Pom1d2rR
 Srun7eun5OT8bnANucTFVEb40Hq3692CNdo/Ran46S+UGj5F86LA/fe39K+pEWDwhudE
 NuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688508043; x=1691100043;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=83/cdAL0KcxCkv+HhX4A2NJ1elMGjfOXi6WNzrVwof4=;
 b=HpHSR6LWLU3JR8Tl0k57/o2eA26F5Ga6XTXiS8ZU7umgaO5vCoNKJs+hpRJKv+AYkM
 4j1e7Sg1frKEAAN5PKRb++TmKGrckQAS/6D4lswJs0OM+tjeGI3zw0zVbfzGTrdWHgZJ
 ciw9DFB23TfeG1/XmgqqAi3lqq9jZKWATL2kuk2XqqBIcltN5nJ1Y5paH3R5deOqY10J
 hfxcwZgcSkVy0flcFdi84m9zRiXznMDW2hLWi3AwET86dFsvA+to2G2SI5orLx06gkAM
 DcGN5yY7/70bNB6cozoZn5nlWvvyYijhhfUxMXWETXpeVcz6eo1K9WfgRt5h3cUM7i4c
 2png==
X-Gm-Message-State: ABy/qLblOWhiHD9rJJKeCQ6R9T6AG032IMjPlPE+nlEiVlkAqwVGXjx7
 SEjOnuvxF0CzWrQX9U1tvUBP1BMSOzI=
X-Google-Smtp-Source: APBJJlFNKtFHRooWFkwsor9gIlH4zLVemmSQ3AmppZTkWK22YW44MWRRCQstjyY4pYeEA0aJnBFRPQ==
X-Received: by 2002:a92:dccb:0:b0:341:c806:a8cd with SMTP id
 b11-20020a92dccb000000b00341c806a8cdmr13622595ilr.6.1688508043303; 
 Tue, 04 Jul 2023 15:00:43 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:284:8201:e850:1a78:8057:4d63:c6a5])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a0566380e8400b0041ab9b6f5b0sm3182728jas.128.2023.07.04.15.00.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Jul 2023 15:00:42 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Matheus Tavares Bernardino'" <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>
Cc: <bcain@quicinc.com>,
	<quic_mliebel@quicinc.com>
References: <d40fabcf9d6e92e4cd8d6a144e9b2a9acf4580dc.1688420966.git.quic_mathbern@quicinc.com>
In-Reply-To: <d40fabcf9d6e92e4cd8d6a144e9b2a9acf4580dc.1688420966.git.quic_mathbern@quicinc.com>
Subject: RE: [PATCH] Hexagon: move GETPC() calls to top level helpers
Date: Tue, 4 Jul 2023 16:00:41 -0600
Message-ID: <000001d9aec2$fa0154e0$ee03fea0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMLtznP2ydTcuVr1uYKeHdh6Igx+K1F9cGw
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 04 Jul 2023 20:54:58 -0400
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



-----Original Message-----
From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com> 
Sent: Monday, July 3, 2023 3:50 PM
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com; quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com
Subject: [PATCH] Hexagon: move GETPC() calls to top level helpers

As docs/devel/loads-stores.rst states:

  ``GETPC()`` should be used with great care: calling
  it in other functions that are *not* the top level
  ``HELPER(foo)`` will cause unexpected behavior. Instead, the
  value of ``GETPC()`` should be read from the helper and passed
  if needed to the functions that the helper calls.

Let's fix the GETPC() usage in Hexagon, making sure it's always called from
top level helpers and passed down to the places where it's needed. There are
two snippets where that is not currently the case:

- probe_store(), which is only called from two helpers, so it's easy to
  move GETPC() up.

- mem_load*() functions, which are also called directly from helpers,
  but through the MEM_LOAD*() set of macros. Note that this are only
  used when compiling with --disable-hexagon-idef-parser.

  In this case, we also take this opportunity to simplify the code,
  unifying the mem_load*() functions.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
---
 target/hexagon/macros.h    | 22 ++++++++++-------
 target/hexagon/op_helper.h | 11 ++-------  target/hexagon/op_helper.c | 49
+++++++-------------------------------
 3 files changed, 25 insertions(+), 57 deletions(-)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h index
5451b061ee..efb8013912 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
+
+#define MEM_LOADn(SIZE, VA) ({ \
+    check_noshuf(env, pkt_has_store_s1, slot, VA, SIZE); \
+    cpu_ldub_data_ra(env, VA, GETPC()); \
+})

Note that check_noshuf calls HELPER(probe_noshuf_load) and
HELPER(commit_store).  Both of those call GETPC() from within.  So, you'll
need to pull the contents into separate functions that take ra as an
argument.

Does this pass the test suite?  You are only using the SIZE parameter in
check_noshuf, but cpu_ldub_data_ra only reads a single byte.

+#define MEM_LOAD1s(VA) ((int8_t)MEM_LOADn(1, VA)) #define 
+MEM_LOAD1u(VA) ((uint8_t)MEM_LOADn(1, VA)) #define MEM_LOAD2s(VA) 
+((int16_t)MEM_LOADn(2, VA)) #define MEM_LOAD2u(VA) 
+((uint16_t)MEM_LOADn(2, VA)) #define MEM_LOAD4s(VA) 
+((int32_t)MEM_LOADn(4, VA)) #define MEM_LOAD4u(VA) 
+((uint32_t)MEM_LOADn(4, VA)) #define MEM_LOAD8s(VA) 
+((int64_t)MEM_LOADn(8, VA)) #define MEM_LOAD8u(VA) 
+((uint64_t)MEM_LOADn(8, VA))

A further cleanup would be to remove these altogether and modify the
definition of fLOAD to use MEM_LOADn.

 
 #define MEM_STORE1(VA, DATA, SLOT) log_store32(env, VA, DATA, 1, SLOT)
#define MEM_STORE2(VA, DATA, SLOT) log_store32(env, VA, DATA, 2, SLOT) diff
--git a/target/hexagon/op_helper.h b/target/hexagon/op_helper.h index
8f3764d15e..845c3d197e 100644
--- a/target/hexagon/op_helper.h
+++ b/target/hexagon/op_helper.h
@@ -19,15 +19,8 @@
 #define HEXAGON_OP_HELPER_H
 
+void check_noshuf(CPUHexagonState *env, bool pkt_has_store_s1,
+                  uint32_t slot, target_ulong vaddr, int size);

Does this really need to be non-static?


Thanks,
Taylor



