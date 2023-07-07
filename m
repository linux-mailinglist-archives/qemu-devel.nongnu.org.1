Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCA474AFF4
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:38:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjh2-0002Ba-8I; Fri, 07 Jul 2023 07:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjh0-0002BN-K7; Fri, 07 Jul 2023 07:32:06 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgz-0006cH-7z; Fri, 07 Jul 2023 07:32:06 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-563439ea4a2so1252094eaf.0; 
 Fri, 07 Jul 2023 04:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729523; x=1691321523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zujtdCidf8av7yZX/8iA1AFeG0VAkT8QncRpnfW5h9w=;
 b=nr1Id7NfN4DmZv25DURtduKIcFVYrwvL0o7kH47h37yUfzxK5lKzfrgyLbxvXexI48
 Ep6IbD6JCUzhIVOaGMK/ALVpnlZ1cIaQHtCGr4crOO8LfTsjxC158V7HCLWqo2CVg/3k
 qfwReG5ZXqHPfQ0oN9Msv8+RSfavZkoLVYFYumT0vjpjvzoRnWmmvZMGyHaSw6sWyq87
 5UVwHgU7UEsLN5h/hnuIukwub2O5E2tidoBTa2iNT+BO5oX4GjBHlDfqWVH0oJAxkgG9
 C8FB3bxbXv+IClwwWXkec5aM5r2Dc60RCdaHKUf12JUov3M27OHKbO9VJ1o0AVn1US4L
 1yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729523; x=1691321523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zujtdCidf8av7yZX/8iA1AFeG0VAkT8QncRpnfW5h9w=;
 b=A9QMR5YufhnoAviFDLL5/zw6VxoVW7dZI64y4TPdeJCL1kbk/T8SXZHFLcdj8lPlrO
 8OIm/jRQghDXmvUH/GyQ9c5scVFTyeByModNkvKP5AC47+m0WYOH17PAdUzgcrFFkmcs
 VlGHyAO4cnZoi+DOJ4oIcERdz7tfi3Nfvc5BmZdq6SASUpUJ93Av/cqIS8+I1muFkRCt
 ua63xZeTC65bkD+LgIvv/v9ongJIC7DsQPYXTyLjc1yApF+oUdNRD0FQStKAgRFyMNvi
 3Spz1FHzruoPqXCNEmNsU8A8eGAdE6e1sqlPbvfNQI+OPNwYsO2ZNwo5oJAF0wUFd+z6
 gKNg==
X-Gm-Message-State: ABy/qLYawzzxXL3UoOhuKhc+T2XMyqnFIXnsVCvZwm2bxB3dWQCT2ByE
 fx4KUysz0wQjpFfnpFXewx/COiZo+U0=
X-Google-Smtp-Source: APBJJlG6tiaZKXLt8JjjvZG2dpj2aMVAI7jfX6gXJ/3w4WF6KpJyd29tKIuY2KiFijzW0fXed40bLw==
X-Received: by 2002:a4a:55c9:0:b0:563:5e40:36a2 with SMTP id
 e192-20020a4a55c9000000b005635e4036a2mr3481187oob.9.1688729523602; 
 Fri, 07 Jul 2023 04:32:03 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:03 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 16/60] target/ppd: Remove unused define
Date: Fri,  7 Jul 2023 08:30:24 -0300
Message-ID: <20230707113108.7145-17-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Commit 7a3fe174b12d removed usage of POWERPC_SYSCALL_VECTORED, drop
the unused define as well.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <50adc24f9d408882128e896d8a81a1a059c41836.1686868895.git.balaton@eik.bme.hu>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4766240927..db0ba49bdc 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4486,7 +4486,6 @@ static void gen_hrfid(DisasContext *ctx)
 #define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL_USER
 #else
 #define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL
-#define POWERPC_SYSCALL_VECTORED POWERPC_EXCP_SYSCALL_VECTORED
 #endif
 static void gen_sc(DisasContext *ctx)
 {
-- 
2.41.0


