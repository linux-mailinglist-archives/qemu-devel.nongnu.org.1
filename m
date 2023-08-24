Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8CE786463
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 03:04:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYykM-00008T-4A; Wed, 23 Aug 2023 21:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykK-00007D-1F
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:48 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykH-0000Qu-Og
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:47 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68bed286169so331985b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 18:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692838964; x=1693443764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nx0E+Cf9iwRX4Njxvb3jlIfoidd9B3bB+8lmV0laZYk=;
 b=Fqkb/Air8yokxmh0Wsk32iilPc3nBNTUqoBNTelkAr606zh/6wvVHISGt9YA8SsP+U
 HUIwVBGCjK0V+y2F3l7rs7Z7PXZNSFw9tAPmFKR+kRMbDEjklObVHX/MPQ0hojoKVnH5
 C8wNOlIGqDsEMB9WaI8EwvTLdipCoBKAyste87mu4qhXlCm15eiCBNsRWIuewcmYZDh+
 Y8GdCPkL6BqykJ8MgvLp+v8N8DYi+beJQNPLbWW6NGJZY73ME49havzv+lhh6EEcHxeE
 b2XTBhtVyYUYV7M4UVX21aaVHWrQ67QtRMYu7CvfIrry6elAVWb/+G4LTgmYCIJ1oeiO
 t47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692838964; x=1693443764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nx0E+Cf9iwRX4Njxvb3jlIfoidd9B3bB+8lmV0laZYk=;
 b=XwM2vFTkMfAK+jjFRZDgDZI6ug23rQHHe7p0WILBbSlb1MK1h2h28DeL/rN9DedHCW
 pDceWsoCVqYgof62VzM6s8He4TqqUTgWCJHZqU1cesfpZKMTix8gWiSJqBGQoH4ZxSWs
 fC2YvprrNgZRt9Njtptqv1dh8EqbxaHtZL2Nb/7FHcFIU18NxrN+/brJ9cb4jEMcYcIf
 M+65JW33FoP6+xg1F6TtgU/fGAx8ftTClq9WxXYx+H6dx7fWehUy6habS9lDeWd5Mmjw
 XoIyynUobcpSwtiZ7wJwQbGxjCHsRzCjVc55MnWSR+GbYHCcHm2i0XsEY7GD4+uj5zu8
 1+Nw==
X-Gm-Message-State: AOJu0YzLxuANnpFVw/rtB7QKTNx44uszJAMwQ779y8vuy1KM8wQt5XDY
 hzgtfVF+punLI0u82NtKnSZfTc3Bt5a51UkLnuM=
X-Google-Smtp-Source: AGHT+IF6TFRKnBgga3XrR1gRNo2COqFL/5CJjCuC4s0GpUHd/oIFitFV20kq8namRKQU98u1MddGtg==
X-Received: by 2002:a05:6a00:14d0:b0:68a:45a1:c0ee with SMTP id
 w16-20020a056a0014d000b0068a45a1c0eemr12711358pfu.15.1692838964147; 
 Wed, 23 Aug 2023 18:02:44 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa78c0a000000b006875df4773fsm2050789pfd.163.2023.08.23.18.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 18:02:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/13] linux-user: Adjust brk for load_bias
Date: Wed, 23 Aug 2023 18:02:30 -0700
Message-Id: <20230824010237.1379735-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824010237.1379735-1-richard.henderson@linaro.org>
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

PIE executables are usually linked at offset 0 and are
relocated somewhere during load.  The hiaddr needs to
be adjusted to keep the brk next to the executable.

Cc: qemu-stable@nongnu.org
Fixes: 1f356e8c013 ("linux-user: Adjust initial brk when interpreter is close to executable")
Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d5f67de288..dbc5d430e8 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3326,7 +3326,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     info->start_data = -1;
     info->end_data = 0;
     /* Usual start for brk is after all sections of the main executable. */
-    info->brk = TARGET_PAGE_ALIGN(hiaddr);
+    info->brk = TARGET_PAGE_ALIGN(hiaddr + load_bias);
     info->elf_flags = ehdr->e_flags;
 
     prot_exec = PROT_EXEC;
-- 
2.34.1


