Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E80FB7B7EA6
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:06:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0b9-0003FY-K1; Wed, 04 Oct 2023 08:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0ZF-0000O1-NB
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:34 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0ZC-00015k-Gw
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:29 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32487efc319so2025839f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420884; x=1697025684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaBKBsLGQ/LuJm7hrK1IdnE8JEzy7Etr5v11yBfp1ug=;
 b=Rfm1la5sKrMWtTpzIbcfi0jV0qof3ooOZgH8CpV9gcrrjH10bwiScPAgu3jx7PobnM
 QAlNEf3ip/u/oGVWc0JPq+x3X6pPioysbNhnWHY3rp7UDa1UKnDBIdrfUXFEpxz54Pgs
 YoZmz2Dqa7fe/GsGAp2UvPwJlRYj3NcS8eckt13AsBawIqC/KbN0hbIi9NgdxpXkPPsA
 zCdNuJEBYNXP63Htk9SfifdNCfIXEb79zO8aOPWeKccQX29jTpk6fieKn2zYfCgQtz4s
 jbXtMIvV9P0v3AzFS6eG1PRdRo6nvcBABmIg/oEO0KRYhqYd4twMYAsVTN2gHYmKhi6o
 YuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420884; x=1697025684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aaBKBsLGQ/LuJm7hrK1IdnE8JEzy7Etr5v11yBfp1ug=;
 b=O7D1PYN3KTNaHZvmH10F35atMfIRa8kZ4UOkzchfffu735iOScShOqDPuSTcjXrb6F
 BEs+wnOB0m2+4GJRDfSmdFvhmMKciurFifhr+EsTTDRe5XNd9fRtE8wlIW/B1G732nN5
 HSxbkPkZC7R+qhQxzVeEZFdklEILZ4OYNWYnnLPAOxMPzbM4hJl4zVEjYsTpvJ4Hznv8
 5KavJty365iSfvfzCQ9ZzlQsHYnNkn6Hv4DYqVAi3rmHNwOIqivwSkkcjn04c0QCE2mZ
 /NFTiOpweB32eW3zxhGOauABg3FtnrOkPvysZYsf9wRWck7xcdS9cHsAJVeE8fBhXnnN
 y1Ug==
X-Gm-Message-State: AOJu0Yx7qLj5X86zWWCmv/JClJk9Kl/2ohtBFKz3HSZSTVsP7qZxoE9q
 69LBJa0sBrJ2GlRdd68bImj/zOG7Xka9LNQ1Atc=
X-Google-Smtp-Source: AGHT+IESLymds+pnPfiIjWjB+IzTvFThDGHRqlErQmqXu4f56VtY5QXAn1g4OxkDQW/vSmLSiuryvw==
X-Received: by 2002:adf:f845:0:b0:31f:e74d:c82a with SMTP id
 d5-20020adff845000000b0031fe74dc82amr1772147wrq.31.1696420883499; 
 Wed, 04 Oct 2023 05:01:23 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 x15-20020a5d60cf000000b003271be8440csm3844037wrt.101.2023.10.04.05.01.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:01:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 10/16] ui/cocoa: Clean up global variable shadowing
Date: Wed,  4 Oct 2023 14:00:13 +0200
Message-ID: <20231004120019.93101-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
References: <20231004120019.93101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Fix:

  ui/cocoa.m:346:20: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      QemuCocoaView *cocoaView = userInfo;
                     ^
  ui/cocoa.m:342:16: note: previous declaration is here
  QemuCocoaView *cocoaView;
                 ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/cocoa.m | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index df6d13be38..15477288fd 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -343,9 +343,9 @@ - (void) raiseAllKeys;
 
 static CGEventRef handleTapEvent(CGEventTapProxy proxy, CGEventType type, CGEventRef cgEvent, void *userInfo)
 {
-    QemuCocoaView *cocoaView = userInfo;
+    QemuCocoaView *view = userInfo;
     NSEvent *event = [NSEvent eventWithCGEvent:cgEvent];
-    if ([cocoaView isMouseGrabbed] && [cocoaView handleEvent:event]) {
+    if ([view isMouseGrabbed] && [view handleEvent:event]) {
         COCOA_DEBUG("Global events tap: qemu handled the event, capturing!\n");
         return NULL;
     }
-- 
2.41.0


