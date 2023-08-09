Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7877766B6
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 19:51:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTnK4-0000PG-Rh; Wed, 09 Aug 2023 13:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTnJz-0000NA-LP
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:50:11 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTnJy-0005eE-0L
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:50:11 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-26834a73b8dso24308a91.2
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 10:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691603408; x=1692208208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jv2rFQy8ox3PX4o5HcVDJ943M2bxOe2uVjR6ZEkXsuQ=;
 b=OR4mZc1Pc0zGjoBELSZoM+eVnA4MttDG+51/ZIgdp4d+nvUAZsbYIKi1ltLPGREefQ
 MZbI/hC9daAnhSq0UnnPS5oqQTwLyS3lSI6eYJUqTUpI4sWH8OrBUpiq6vDq7r1q3Bx7
 KTCw90+1aiy+UsrrxxQJxEM5XJydmS3fPT3CMZ3dmZNjAsvxRqV/WFS5eIZCzZDLK1Q4
 e0KChBTRHrHKCjQGYpY/bRVBTJzhJg1V0KcfGEAel2TjMogD0DaVSxhJb2BgCul/l/Tf
 5UxOrJtkVyAIF913kDx+nadVcJSATPVcIPU5SWSU60KKq7GfTmCRlPs6P7dWqg8Dj9dq
 pKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691603408; x=1692208208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jv2rFQy8ox3PX4o5HcVDJ943M2bxOe2uVjR6ZEkXsuQ=;
 b=LwIlLb44rv7uH99AssiImt/bfbZwy8oIqTPvpnCkhlZmol9erJTwCL0QoR8cUuhsyE
 XoPaKvnNfjqq24TrRAuyQafKxHChXk5r0wQO6KyvCxsK+fxi+483epoCvr3kc5tXmpjQ
 BcOKAq1ZNP1v8TMkB95UoSgu+OV3geNot6tLmXgywB5vUAhEjfP91G60reY7PJP9jpXN
 az21kxf+aC6Gb/NUEmDKWUCF9uovxwfhGVQ3yJeEeQDm1ROdXFOdD4Werbesxy7IZG5R
 R5Vs4HRylCwF0ylfjZpOobgU0i6H/2gvy792UJfBGEaAAUJtvE2vNs0r1IcEP38EMkKi
 lpHg==
X-Gm-Message-State: AOJu0YwN3iOlDN6WDFWKziKRRY3DfSZhLE+9cYlEJ1KLq+FJm/A0Coyg
 pbtRmrpmdK+NcS7SMdfX/tZs2UWZ3NpXam/6/40=
X-Google-Smtp-Source: AGHT+IEmGqrd76hZdZHYjA+vrjsGGK98DCgupWyd4Gqhj16QcK0Dd1RiS7tIpGkmdFI8+VQZxLCzgw==
X-Received: by 2002:a17:90a:8982:b0:256:8dbd:74fa with SMTP id
 v2-20020a17090a898200b002568dbd74famr5198pjn.22.1691603408564; 
 Wed, 09 Aug 2023 10:50:08 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090a2b4700b0025dc5749b4csm1753710pjc.21.2023.08.09.10.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 10:50:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 1/6] qemu/osdep: Remove fallback for MAP_FIXED_NOREPLACE
Date: Wed,  9 Aug 2023 10:50:01 -0700
Message-Id: <20230809175006.242479-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809175006.242479-1-richard.henderson@linaro.org>
References: <20230809175006.242479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In order for our emulation of MAP_FIXED_NOREPLACE to succeed within
linux-user target_mmap, we require a non-zero value.  This does not
require host kernel support, merely the bit being defined.

MAP_FIXED_NOREPLACE was added with glibc 2.28.  From repology.org:

                  Fedora 36: 2.35
          CentOS 8 (RHEL-8): 2.28
                  Debian 11: 2.31
         OpenSUSE Leap 15.4: 2.31
           Ubuntu LTS 20.04: 2.31

Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230808164418.69989-1-richard.henderson@linaro.org>
---
 include/qemu/osdep.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index cc61b00ba9..21ef8f1699 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -289,9 +289,6 @@ void QEMU_ERROR("code path is reachable")
 #ifndef MAP_ANONYMOUS
 #define MAP_ANONYMOUS MAP_ANON
 #endif
-#ifndef MAP_FIXED_NOREPLACE
-#define MAP_FIXED_NOREPLACE 0
-#endif
 #ifndef MAP_NORESERVE
 #define MAP_NORESERVE 0
 #endif
-- 
2.34.1


