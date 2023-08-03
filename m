Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD41076DDA2
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 03:54:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRNWb-0000f0-4S; Wed, 02 Aug 2023 21:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWX-0000dd-KN
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:09 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWW-0000jp-0d
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:09 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a741f46fadso329872b6e.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 18:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691027587; x=1691632387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zGlGyVbf5mAt3X+pirtJo2XZVAZPR2luQo7KvVPWG+g=;
 b=PUQl7ewocdGUKClZUVQqG1B4IFNhSQEA0NkasIpsB6kJPWpaH80fOs3xAMzKkHzoT6
 Otyt0gKRn+vayvSPtKXvW1lM6EvDLOYEznIwqsnPhRj9OOhwEe3TiqxLD3ZQQnkGRS2o
 lVtDZdBMzzy9AyEb4CoRq8uEHyx6eg6P4pqIJm7uEOANfPhV41rfCGD1ov5KHU4jTZhS
 ims5AeaQIHF1+O3vh150617dYI541mjraCiNh8sx/5PuH+zsFDdAmunufh2MYf7WLn1o
 T4apSRVru2PYQG9oqgmjZMcQwZYG7nR1oRBbLWMPrYfJDUILOUU+yJDRMnRQi+sBg3MG
 uXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691027587; x=1691632387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zGlGyVbf5mAt3X+pirtJo2XZVAZPR2luQo7KvVPWG+g=;
 b=I/BlArIQ3++J/UqNHzHcN04+NrkyuQ+C6qgzMfXwcSH1eRcyan5UnstDVIQJwXZAgd
 XGgqCYxlTfKx52XOFi6C8sIMhAL+lmukstC7/FMqAea8H3X53lzWndY3r9KOP5hF0k/h
 U2GPP5Le7tU21tANMzlJlxvxGRl2PRo3MVXP0gz/HgQaywkVGCCnbn5YDKrRDNMHF/3b
 x/M/2bP3DZYU34s9yhmWNlyz2rYvqR77bKgVRX/z1biGihenl2fOqTyBygR6zIkdhBcR
 nsezNOSwJJG9vspDVCFbEkJlMb1XBVsxrWM6YRNfcdU6yOejaGDs0xXbIKZjQqm2R6TP
 2ghw==
X-Gm-Message-State: ABy/qLb8h9qQrX6bWVIRjq8O02KiTD+XQxfeVc7G4Ar4Uw+IQHDFK1U2
 DEmTrGWSIcRPpR+Mpiz5ZMqR1XQ191DsnkaO44M=
X-Google-Smtp-Source: APBJJlHwRGjIljNiIMg2yeQjEJwtxyC83aHxMTlB0TjkYQ+DJNVrmVyQBVTqF5h8LSb98wZvq+2jDQ==
X-Received: by 2002:a54:4e11:0:b0:3a7:9d0:b71 with SMTP id
 a17-20020a544e11000000b003a709d00b71mr14241976oiy.53.1691027586704; 
 Wed, 02 Aug 2023 18:53:06 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a63a319000000b005649cee408fsm157123pge.0.2023.08.02.18.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 18:53:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, laurent@vivier.eu, akihiko.odaki@daynix.com, joel@jms.id.au
Subject: [PATCH v7 03/14] linux-user: Do not call get_errno() in do_brk()
Date: Wed,  2 Aug 2023 18:52:51 -0700
Message-Id: <20230803015302.407219-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803015302.407219-1-richard.henderson@linaro.org>
References: <20230803015302.407219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

Later the returned value is compared with -1, and negated errno is not
expected.

Fixes: 00faf08c95 ("linux-user: Don't use MAP_FIXED in do_brk()")
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230802071754.14876-4-akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 95727a816a..b9d2ec02f9 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -862,9 +862,9 @@ abi_long do_brk(abi_ulong brk_val)
      */
     if (new_host_brk_page > brk_page) {
         new_alloc_size = new_host_brk_page - brk_page;
-        mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
-                                        PROT_READ|PROT_WRITE,
-                                        MAP_ANON|MAP_PRIVATE, 0, 0));
+        mapped_addr = target_mmap(brk_page, new_alloc_size,
+                                  PROT_READ|PROT_WRITE,
+                                  MAP_ANON|MAP_PRIVATE, 0, 0);
     } else {
         new_alloc_size = 0;
         mapped_addr = brk_page;
-- 
2.34.1


