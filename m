Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DA076F723
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 03:47:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRjss-0002fa-Vk; Thu, 03 Aug 2023 21:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsc-0002co-CK
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:38 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsY-00058m-VB
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:24 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686f19b6dd2so1183660b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 18:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691113522; x=1691718322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZjeFygd6IIkR9M2DIG513e5CPYAFIDSvTnL6qX1fRv4=;
 b=aWD5SYAOqOrW8KVpkC/8GTDCWzxvrXTEJiXrbjpavdfbS6fsurSzd66YcblmUd8aq9
 0F2Jrne0Aczwlw7LVR/8ddOKk0p8NYhcw60AJV6jNywdoAepPRSkG/+FyMBC+iGRDwtt
 QqNPKFjO5xsShxXE3aSWnTOuqK1gfzQRTStySWnc6MlPvb8cDO55R1wMdWzWp25x4O9Q
 3k9GDji0nJMulTihAN/z8xrZnnE3goZgAxUYpGJWoRjgXSAlAgA98D3LBEybJ0WIplZO
 1jfPbjEElSoscC7F2eAsbG1BiZxcDXT5O2R3ra6DwMtaS78EMXv2S1T+9ykGXm38N1n+
 27lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691113522; x=1691718322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZjeFygd6IIkR9M2DIG513e5CPYAFIDSvTnL6qX1fRv4=;
 b=gUspSzCZhL20zM3A5ZqxIBoGdCwtIuWt5EEvgYlMgR3i2BBR9wSM2+8AEW4RpgXfIW
 xv9Q1eYHnakyrEL+B6968HiM+pqs5CLdjOSFfJG6pMuERE+hUPyaBJJQrpbeffr7mD+2
 Q9TxVZaiIIrIOPm9v22KZSzhSCUv8b12c7+V00zfNZAxIRrLyQDeK16doSFClx1Uz5RO
 rQNOdNl//9wu1MyZi9pKDYVNRTkECsG0guEnqH2VvafBim3375w1HqkfIHQET+0yapmX
 E5Gveua2vB5MtlKLrb/j3Z/jw4U4VmCx/DXGQsD7B2uiY1tvsT99Bf4RZAHFvsCuCkXq
 rODg==
X-Gm-Message-State: AOJu0YzAX2LisuSLIQKlIHgOo5e3oS4FhOiigCUZOWtJXjvtdlg+6Rph
 bnkED2OOU/5kE42PbmVS5XpJMIrOBiHeSq8VKQg=
X-Google-Smtp-Source: AGHT+IHy1TfUqGEeo5lxp8ubIm4N78oLprm8u3Z043sFUYOwVOjO2rpBKMUBFQ318tXHohCBhKdCsw==
X-Received: by 2002:a05:6a20:9191:b0:12c:f124:5b72 with SMTP id
 v17-20020a056a20919100b0012cf1245b72mr278850pzd.43.1691113521699; 
 Thu, 03 Aug 2023 18:45:21 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9d52:4fe8:10ce:5c3])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa78c05000000b0066f37665a63sm456138pfd.73.2023.08.03.18.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 18:45:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, akihiko.odaki@daynix.com, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH v8 04/17] linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
Date: Thu,  3 Aug 2023 18:45:04 -0700
Message-Id: <20230804014517.6361-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804014517.6361-1-richard.henderson@linaro.org>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

MAP_FIXED_NOREPLACE can ensure the mapped address is fixed without
concerning that the new mapping overwrites something else.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230802071754.14876-5-akihiko.odaki@daynix.com>
[rth: Pass -1 as fd for MAP_ANON]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b9d2ec02f9..f64024273f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -854,17 +854,12 @@ abi_long do_brk(abi_ulong brk_val)
         return target_brk;
     }
 
-    /* We need to allocate more memory after the brk... Note that
-     * we don't use MAP_FIXED because that will map over the top of
-     * any existing mapping (like the one with the host libc or qemu
-     * itself); instead we treat "mapped but at wrong address" as
-     * a failure and unmap again.
-     */
     if (new_host_brk_page > brk_page) {
         new_alloc_size = new_host_brk_page - brk_page;
         mapped_addr = target_mmap(brk_page, new_alloc_size,
-                                  PROT_READ|PROT_WRITE,
-                                  MAP_ANON|MAP_PRIVATE, 0, 0);
+                                  PROT_READ | PROT_WRITE,
+                                  MAP_FIXED_NOREPLACE | MAP_ANON | MAP_PRIVATE,
+                                  -1, 0);
     } else {
         new_alloc_size = 0;
         mapped_addr = brk_page;
@@ -883,12 +878,6 @@ abi_long do_brk(abi_ulong brk_val)
         target_brk = brk_val;
         brk_page = new_host_brk_page;
         return target_brk;
-    } else if (mapped_addr != -1) {
-        /* Mapped but at wrong address, meaning there wasn't actually
-         * enough space for this brk.
-         */
-        target_munmap(mapped_addr, new_alloc_size);
-        mapped_addr = -1;
     }
 
 #if defined(TARGET_ALPHA)
-- 
2.34.1


