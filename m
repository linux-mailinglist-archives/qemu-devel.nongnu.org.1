Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DED80AE45
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 21:51:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBhna-00011W-0E; Fri, 08 Dec 2023 15:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3foFzZQMKCoExh1lttlqj.htrvjrz-ij0jqstslsz.twl@flex--scw.bounces.google.com>)
 id 1rBhnY-00011J-Am
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 15:50:12 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3foFzZQMKCoExh1lttlqj.htrvjrz-ij0jqstslsz.twl@flex--scw.bounces.google.com>)
 id 1rBhnV-00064k-Pa
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 15:50:11 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5ca2e530041so30623637b3.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 12:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702068606; x=1702673406; darn=nongnu.org;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=G3yL+/JS3JWx1cPp71KUfWtGLWSAB5UNwfPttx6LtRs=;
 b=oDXkp29mng/Vte8X8UzlUauhJLwlkzmfVPbXQRNrklxxKSPaE76i0N/DXTT8pUegVS
 sGoZZ4JalqYDcGgYIpe3Hz98Qi12W2RYNX2pWkE//9RcU6cIG1fF6PoBH32zBQls3WG+
 YEtumJSFnLNzdPRTVXs/HDWSLirS0FnATKOwWXeQ8vBLoKpEPj2rYAUJEF0Iy//DSCWD
 i9Gmr4t5ehEbvfK0xJFM3KPsKNvcFhBnHSE/+9imh3en4Bo1KF4ZqXJ6v2/3aOSITIZi
 2FYzlBI4phA6OKg9zCCW73wm1m0H4RFE4N1mDF+ddPbXkLeuLZStbCPVP0hEhuCa7A87
 JtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702068606; x=1702673406;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G3yL+/JS3JWx1cPp71KUfWtGLWSAB5UNwfPttx6LtRs=;
 b=nCKv0HyP//0xa14TopPFe6vQMsLi55iu41vGwasrbYDIPpzYIfNUZxv18OWB7nQUiz
 3yyD45gEZxlhfqD/VJnwsNUoIzqfiDq0dBER3bc9SnFrg9VS5O75wGr0t5h/D8AYGHIw
 3RKk5b6QTiVwPjDwQER7d0AeS95Gwgxc92+pGYKv3ZDdOlOtqXaAUR01TdlVxbJHTu6i
 V0ZWYBpd4/zoIgL2mayE20sRKyHabOW5zJ7jYtqy+8vxymnGwsKn885SSgWpWFD6Jmf/
 zUAzU67ca163IrTqgaarDyX058nbRTmZyzMBxn2OtOzp3VfNFpOUYGRyzXovxbNVKTPu
 7jGg==
X-Gm-Message-State: AOJu0YxP/zg9Zyucuhp5rYSedEar6+JLMZ+pZ+z1Mf5xvljP+2P3bfOc
 eRoOcCc4Ip4z38WSpEPHd0H6AsMC7imCZF9zwJxm7GAXS+ScotDTfhdVlOf8lw/uUWN8ZNRIrW9
 HEWF0ktJgbpCJAiOeIAqtabW6+RNRKGJyqtqJhoZEnDdYhpFALVCq
X-Google-Smtp-Source: AGHT+IGFjenjWbudVuj5xIBbaFUfgvUDI5iwwO14rn9WX/vFfpq4XvTRsx1gdDsAalQNtMRUex75Gdc=
X-Received: from scw-glinux.svl.corp.google.com
 ([2620:15c:2d3:205:37bb:5740:1ec:48f2])
 (user=scw job=sendgmr) by 2002:a05:690c:83:b0:5d7:29d7:8a35 with SMTP id
 be3-20020a05690c008300b005d729d78a35mr7442ywb.5.1702068606573; Fri, 08 Dec
 2023 12:50:06 -0800 (PST)
Date: Fri,  8 Dec 2023 12:49:50 -0800
In-Reply-To: <20231208204951.552837-1-scw@google.com>
Message-Id: <20231208204951.552837-2-scw@google.com>
Mime-Version: 1.0
References: <20231208204951.552837-1-scw@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v2 1/2] linux-user: Define TARGET_O_LARGEFILE for aarch64
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Shu-Chun Weng <scw@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3foFzZQMKCoExh1lttlqj.htrvjrz-ij0jqstslsz.twl@flex--scw.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

In 050a1ba, when moving the macros from preprocessor-guarding to
file-based definition, TARGET_O_LARGEFILE appeared to have been
accidentally left off.

This may have correctness implication, but so far I was only confused by
strace's output.

Fixes: 050a1ba69a ("linux-user: move arm/aarch64/m68k fcntl definitions to [arm|aarch64|m68k]/target_fcntl.h")
Signed-off-by: Shu-Chun Weng <scw@google.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/aarch64/target_fcntl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/aarch64/target_fcntl.h b/linux-user/aarch64/target_fcntl.h
index efdf6e5f05..55ab788a7c 100644
--- a/linux-user/aarch64/target_fcntl.h
+++ b/linux-user/aarch64/target_fcntl.h
@@ -11,6 +11,7 @@
 #define TARGET_O_DIRECTORY      040000 /* must be a directory */
 #define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
 #define TARGET_O_DIRECT        0200000 /* direct disk access hint */
+#define TARGET_O_LARGEFILE     0400000
 
 #include "../generic/fcntl.h"
 #endif

