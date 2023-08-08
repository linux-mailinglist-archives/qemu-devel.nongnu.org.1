Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2290773AF9
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:24:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTOYU-0005GW-N5; Tue, 08 Aug 2023 11:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qTOYT-0005GN-7o
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:23:29 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qTOYR-0002zl-Rv
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:23:29 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bc6624623cso23992305ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 08:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691508206; x=1692113006;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tff7/VxCu3lJgyrFVTEmEEvmaBxACIob4e0+bwUx8O4=;
 b=QEGuOQaYn3CC9LEtmIVhKHpTG5E9VpYy40uLhCrFSdSMKai+PGFXhCvCov7xt63eb+
 Gybu+jVOmECOtNVBrsd2x1rXc0df1RcB4HZTJ3tN+GnWN2Y7MhFg+u2GZygwpeEIS/6d
 Ut+wpSMyswbbI9qkM8oGLWHJL125krnOuGJqS5GXvx+qx8U/LWmmXLiVd6yRcgkRd087
 7Dbcei+5/b9//fKjJLLo4ofHImJ13Nh9B7rajBG5iRZXdH475uWO0dz2iyAiEe4WYWsH
 ZV41AKaiwxTN/sAinaOSTdkoiaMoWGzkBXQvx4SEjGoZpX8AMScRr4XKdNIAE7DxoWvv
 65lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691508206; x=1692113006;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tff7/VxCu3lJgyrFVTEmEEvmaBxACIob4e0+bwUx8O4=;
 b=eknu0YmWSnHOrv8OCfxJ3LnO5tc9iH8zcPkcM6HOJaO3ZKSvVWclinkv1b1E/jmkdu
 RH0f4B7XLkj5HF7YR1qk3MSm+docfL7PrQYxoDsV8/vIOzTV9Y9a6A7pEndutUIsJXoB
 /qWvlqxZWX4Vnj3SVPTOuuNrn7l0HAD4m3OyXwJP93G4QprktqV+X+dvvuAbz6uU3oL9
 vhqtp+kAOFTpH+uAs1eOvDGz2BD39l12CFBkNKSy6DUO1pcnOUZLSFYYCoCTjZ5d1K+H
 OZcBkFSXYYF970AqBNKL2oHC4lOK20R744i1Ft+aNiIW9ionHPNvhHNli7Twt3yyYPKS
 002g==
X-Gm-Message-State: AOJu0Yx+yX70huk7sSC/L9EBXrjTdQI+7Mb875LZpD31uQypjMsAsx7a
 3A9Qg6hAnIzHIEOWvykvmigYDxhqRLbxmDy3ynU=
X-Google-Smtp-Source: AGHT+IEA1cHHsjJOWXLYLxJImbumUTzPZw4X232G2wWfpAeQlFpnp1f+hCI8Kjhs1ynh0Qwno1wEJw==
X-Received: by 2002:a17:902:ced2:b0:1bc:6c8:cded with SMTP id
 d18-20020a170902ced200b001bc06c8cdedmr14085498plg.67.1691508206238; 
 Tue, 08 Aug 2023 08:23:26 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 x7-20020a170902820700b001b80de83b10sm6280246pln.301.2023.08.08.08.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 08:23:25 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] thunk: Delete checks for old host definitions
Date: Wed,  9 Aug 2023 00:23:10 +0900
Message-ID: <20230808152314.102036-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Alpha, IA-64, and PA-RISC hosts are no longer supported.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/user/thunk.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index 300a840d58..d9c131ec80 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -111,8 +111,7 @@ static inline int thunk_type_size(const argtype *type_ptr, int is_host)
         if (is_host) {
 #if defined(HOST_X86_64)
             return 8;
-#elif defined(HOST_ALPHA) || defined(HOST_IA64) || defined(HOST_MIPS) || \
-      defined(HOST_PARISC) || defined(HOST_SPARC64)
+#elif defined(HOST_MIPS) || defined(HOST_SPARC64)
             return 4;
 #elif defined(HOST_PPC)
             return sizeof(void *);
-- 
2.41.0


