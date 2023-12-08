Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D5D80AFCC
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 23:43:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBjY2-0007Wn-1m; Fri, 08 Dec 2023 17:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3xZtzZQMKCvwwg0ksskpi.gsquiqy-hiziprsrkry.svk@flex--scw.bounces.google.com>)
 id 1rBjXz-0007W3-V6
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 17:42:15 -0500
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3xZtzZQMKCvwwg0ksskpi.gsquiqy-hiziprsrkry.svk@flex--scw.bounces.google.com>)
 id 1rBjXy-0007em-Ie
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 17:42:15 -0500
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-db53919e062so3384797276.0
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 14:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702075333; x=1702680133; darn=nongnu.org;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=G3yL+/JS3JWx1cPp71KUfWtGLWSAB5UNwfPttx6LtRs=;
 b=a1846F1VGB0ZtjFh7UaEVeCVIjZ2NVXwLFxkdUL1gnLQMZJakThbLFWXWwWk2/tvI+
 ESelQua4kpQCJEDwFiJMF24SdBe1bEY06BcCPfXLYRfxjdQ+VETHz2MD8ioldMx45a2M
 ixmpwh3QKgjzMX+v0qVDY1GUGhA2adkVgBQtBwdFFzCoIVLQ2eP+RreJ1UKgVNckuBjg
 kb3xQrzPFTDCqs+SzaKhnoSZx5QSVa+Olp8gxsMVKvJvsKUciv6zYJ46c+ctbSPSwvj4
 zZjeFybpi7S44QHUnNWq2k+t55tv9D2Y1Fv8lcvbrQ9BZSyxSLWD1umk3qHYp4zNDn9N
 ShsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702075333; x=1702680133;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G3yL+/JS3JWx1cPp71KUfWtGLWSAB5UNwfPttx6LtRs=;
 b=Nx+9TNWnIp8krQv02ApghqQV1AragrJOCpvcU5kqbsdVZciSDPJPBm/iaHTG6DzQgk
 +yr5Y5r2mTUbfIdckzKbLh19PzT1sAZVEzHktv4IuBhEmVvTtzrGmYQMv3MPYJYvPGMD
 utUBHbHizzDiioV7BeFbAqX058ZBl1ddqQVFZYppy7UZ3SOfSjUIh1W0kBwYk4aUMqA/
 o9ozFOlc3nMBkO7JYXDGum5ahDg0fwQ6hCFoFhYjFyMVmiu67+ZxuofJpyVu+HFfWOTC
 4C1KIIsuc9nPL6vJ00DTFciAaOTquGP872GOQ8yB26yE7R7fHgl2Ff/ob2TyVcGPrBaX
 Nx3Q==
X-Gm-Message-State: AOJu0YwBfKr9kWRdpr1Gk+0g8vhDLSW7pNx8WWBOROI5FaggfnblT2rs
 D3fSW5No++JJsqDXnoZpbmQCwLBdVAJ/Lzy3Yvyh27DVOfViLRBkfzKqqEV15yfekb9vmWb+5ai
 g4wkGkj6bpXcFohF5HLQDs37RORmK5ut+YqN5tf2BDjSXZrQpXsbp
X-Google-Smtp-Source: AGHT+IGZcnLbMFJ+g4gyffe8wcohsseJdqjUjkpDiBsmVLLodIPGgJCzUYcztICDAdP5VPiePmy3C/w=
X-Received: from scw-glinux.svl.corp.google.com
 ([2620:15c:2d3:205:37bb:5740:1ec:48f2])
 (user=scw job=sendgmr) by 2002:a25:9f07:0:b0:db5:4692:3ab7 with SMTP id
 n7-20020a259f07000000b00db546923ab7mr5571ybq.8.1702075333253; Fri, 08 Dec
 2023 14:42:13 -0800 (PST)
Date: Fri,  8 Dec 2023 14:42:06 -0800
In-Reply-To: <20231208224207.613445-1-scw@google.com>
Message-Id: <20231208224207.613445-2-scw@google.com>
Mime-Version: 1.0
References: <20231208224207.613445-1-scw@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v3 1/2] linux-user: Define TARGET_O_LARGEFILE for aarch64
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Shu-Chun Weng <scw@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3xZtzZQMKCvwwg0ksskpi.gsquiqy-hiziprsrkry.svk@flex--scw.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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

