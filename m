Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B58E774C72A
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:35:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAc-0008OY-Kr; Sun, 09 Jul 2023 14:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAX-0008LD-EP
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:01 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAV-0000Ik-Tj
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:01 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fc03aa6e04so16329525e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927398; x=1691519398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NM1xXL81EtFD9ExbvPk3EQKQbkl//TA55SFLIHfjSWw=;
 b=XSHy+Ohal8jIDY3VO1YwT5GP9nQOkhLf07/YqI14GALszfjELoi/tHKdegFdwRzctb
 rgylzwE+w35s7HjyLt1+zGbEOqRjDZayUBeawtcKJAtjVORY7KQ1MD5aeA4LkXuz6iwy
 Bf2+WG7dc44pBVxZqwU/u3TLbyAHhQi7FoQTaCiYxpk7fPB/ZAOD55y/COlI+4lpDMxp
 sTJHHi5CZigeIMNPEGdY3h4H30xXy0b0du2kWpJFYuPJZa33BnHOXN3Pbvln6enFpnac
 rJTkv47zWvV93ZLUhdbeYkIpn5FwvICvA4v3CwuYMzyhRYyhZPjhSxhL29cPVE/VHL03
 7Rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927398; x=1691519398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NM1xXL81EtFD9ExbvPk3EQKQbkl//TA55SFLIHfjSWw=;
 b=D0roCjD41P4/7UggHYKY/eT7/lGLQpXCZrkwZpudkNqRfWu7qwWhWrrs5543D8E4Uu
 iWTBxf3PlSwntGuCoad4aatgwIeQRCIFxMTWREUvfvZQOxOd+UTgpd3q85hHIx4VLSR/
 aLLeSTdAmmz+pPbvILizEhbTaOwNO0qK1+Tp1VMCsH20cVvIKOVoj/gRbZKc7xl7zQmW
 XGLWnxD8TNnfN2cer/SQzAczXWTGv0jdpmZ0OxZumZm0uXWaxnLepMWbvIIBzrmlDxa1
 DzCzGWyIpqKoSOW8JOUxhD3LHgBgNe1pDGEo4i8nWHa9v8fStUNFCffx0p/w9bezvLRv
 5WSw==
X-Gm-Message-State: ABy/qLZTnSo1m4biJ67EWJn0tvTAyaDL2Woji6Ga0kn+guvQQFPce1S0
 w206t2enUgjyNCAGw9aI7vuzaoQ70DDCVpBblTv6eA==
X-Google-Smtp-Source: APBJJlE3ArNpOTNHCUKyDNSu1LN36Ly7RJMcCxFxASHiPcB+aQeCB5d1JgmP4EsIcUEFqBz+l5IzFQ==
X-Received: by 2002:a05:600c:3786:b0:3fb:b890:128b with SMTP id
 o6-20020a05600c378600b003fbb890128bmr8767337wmr.27.1688927398570; 
 Sun, 09 Jul 2023 11:29:58 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 13/45] linux-user: Use abi_uint not unsigned in syscall_defs.h
Date: Sun,  9 Jul 2023 19:28:38 +0100
Message-Id: <20230709182934.309468-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 9dc41828cf..c8ffb4f785 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1776,14 +1776,14 @@ struct target_stat {
 
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
-    unsigned        st_dev;
+    abi_uint        st_dev;
     abi_long        st_pad1[3];             /* Reserved for network id */
     abi_ulong       st_ino;
     abi_uint        st_mode;
     abi_uint        st_nlink;
     abi_int         st_uid;
     abi_int         st_gid;
-    unsigned        st_rdev;
+    abi_uint        st_rdev;
     abi_long        st_pad2[2];
     abi_long        st_size;
     abi_long        st_pad3;
-- 
2.34.1


