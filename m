Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5730F743CAC
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:23:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4j-0007eU-BY; Fri, 30 Jun 2023 09:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4g-0007bY-9L
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:10 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4e-0003Nc-P5
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:10 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-313e23d0a28so2234244f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131327; x=1690723327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QWcGYI7xB8LlKTPPYJbQ3MPkeMAscTRkJ+piG/iDAy8=;
 b=Eaiz4QxrUIqwQUx8aBwkhmeEGe9yFNAjkcHRj7+xD/3npjI0yOXBIAcM9SGKhFFHcv
 dvN3eypvv1Nix/IqPG8fZI7uVuGqWkFO06CkgKKwAk9J/pUGFGWgrObeDeGA0FJVrI4e
 1fkM8IV2vBaMP2hHx6ApBrZKS/pvzjAr4CXSeAsoa55S+uIZf1ex+BpxTMpCVD4zBJCp
 If96eas36X6IFthmOn/S/kFknGlIgWitOhiMYXfs2XK+PWC6sXlnU36l8KSrNWssGHFY
 IQpYaaSNeqndcHHmgSlbeGwqdRI0ZprUmKK3PArQp5eKGStqSzGml8XqhrOuC0DjQxaR
 ovpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131327; x=1690723327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QWcGYI7xB8LlKTPPYJbQ3MPkeMAscTRkJ+piG/iDAy8=;
 b=aGxC2by/JxSYIE2TUgLBups/gX2Jp3r4k+mK35bMw2Gg0+fgX2/1bRlbvvFFO7l7l+
 HmRsUj/Msp/EDyIfo4EhLvOIqunRR+9IoL0NwC9mGlYxAfMSqIyxt9CyvSZIhJCMTcQn
 17n+Q1HY1dS5kOzVq9EQ/4aW3MaPAAw7oAv3D5t7QxYU8POuZVpIM9sUWnjUnBaguvi0
 6ONi6XYA5m79ookXmyQvcAQQAQ7K1Awez8D55+hdMNM9LSVhdqw9T0CKHpSXltBH8UgX
 Z55BZPXk45iq9wp6rIMDEZyVBi1uPBqbrpQ9KWPH8BImPBK4gHBDTIVzDA0A0DCbFLBf
 N7qg==
X-Gm-Message-State: ABy/qLar+RFqp8saQJlWUfIR9UA/wyJwsOapO1u1NrbLlpfRxG/nYS84
 JfcldNzoMl8V1TolQeR/N7gzmBgUY3Hf9xMGqhGN7g==
X-Google-Smtp-Source: APBJJlENe65VyDrBIMCp5UBfARxP1HmeRkmezQnKOXv5bh5ywjpVM3FmE+ihV10Fgda9FDbRttW5Zw==
X-Received: by 2002:a5d:525c:0:b0:313:f61c:42bd with SMTP id
 k28-20020a5d525c000000b00313f61c42bdmr2728223wrc.59.1688131327039; 
 Fri, 30 Jun 2023 06:22:07 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, laurent@vivier.eu, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PATCH 08/24] bsd-user: Use page_check_range_empty for MAP_EXCL
Date: Fri, 30 Jun 2023 15:21:43 +0200
Message-Id: <20230630132159.376995-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

The previous check returned -1 when any page within
[start, start+len) is unmapped, not when all are unmapped.

Cc: Warner Losh <imp@bsdimp.com>
Cc: Kyle Evans <kevans@freebsd.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 565b9f97ed..07b5b8055e 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -609,7 +609,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         }
 
         /* Reject the mapping if any page within the range is mapped */
-        if ((flags & MAP_EXCL) && page_check_range(start, len, 0) < 0) {
+        if ((flags & MAP_EXCL) && !page_check_range_empty(start, end - 1)) {
             errno = EINVAL;
             goto fail;
         }
-- 
2.34.1


