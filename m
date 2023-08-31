Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F33F178F5E4
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 00:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbqb4-0004Sm-SO; Thu, 31 Aug 2023 18:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqb1-0004Q0-MK
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:57:03 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbqay-00034O-Nj
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 18:57:03 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99bdcade7fbso152896466b.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 15:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693522618; x=1694127418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07RpMt5MApgRw9NJGh9PZXX3Pgabrwsg/tvmA1poNBo=;
 b=lGQGAhhQSn0lSGUBdZ80+FaS4uKk7iUk9/Q0TpljhNFpiwPV5C2M3ZdHmUBCY3WPge
 hgJGh8e9ONA8cwHkvsaaGXr0DERTa0nAs3Je0RrUVGOYnHuMgFbXGYUyKl/PzflQyhl+
 7o3KIxt41flbhJ4GKK+i1GxTEaxbJ9nyGa4sHcMsKKNA5MSv59T4WDbcwaB6DBgGMksS
 Pfi+kN1Ch06BJruXOyiVOqjYlZW6b/55x1vsIDIgBwUzKnZqm9vry9DoglxrIS5Rn5fp
 jEGBaiOAGcjteoQ5ZPX6tqWt+4rWrFpli/5KOVQt2epqY8BvilzhrhLhWxLEgbuvjfKa
 PmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693522618; x=1694127418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=07RpMt5MApgRw9NJGh9PZXX3Pgabrwsg/tvmA1poNBo=;
 b=IkHWfZhi1IRqx7m2z2pkiJky2umHAcpGsjJRaz5DuzAAA8eP1ajY8dibmY12yyepQw
 kZwh6Rebb0BGuWlnOSvR1sn+mF7+xw/kaJSBLIx/6f8b+kcYjZ3jTjJubCp7TQPdTN04
 B2HB23iS5NsGPtH6iZuoSn0wb3XpETfYURLOtgAGCeNp2WfF3nxXSqQPeDVQEu89ZFmI
 l1JsTfqAJFr/jl1wXry+g0XGrpLn7J9vXoeDxAhZTKkmVqzbFSiXrv7/GC7M75atUcbM
 WMvKQP52QD61ZMB2qIuwtQceU0dKKHqdaXlVpPqQ/dXiRCRcj+g7zSZIOBQPixWZeTP4
 RGUg==
X-Gm-Message-State: AOJu0YwMartYlB+C+Px5hihoqmhBmNGu0zAaAtQIai0+3BI9wlZtY4Nf
 DvpaLFBflvsOPsQJTgpA2HzX2p3hRQaSIr3fEtQ=
X-Google-Smtp-Source: AGHT+IH5nfpZ+8CuHwGqPothU7hTYES62x1oA4wm6Fp13MKGhfn8ax+/p1JVp+00ViTDIHrqRLepEw==
X-Received: by 2002:a17:906:224a:b0:9a1:f415:7c24 with SMTP id
 10-20020a170906224a00b009a1f4157c24mr530634ejr.46.1693522618052; 
 Thu, 31 Aug 2023 15:56:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a1709066c8600b00989828a42e8sm1246798ejr.154.2023.08.31.15.56.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 15:56:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 08/11] hw/m68k: Clean up local variable shadowing
Date: Fri,  1 Sep 2023 00:56:03 +0200
Message-ID: <20230831225607.30829-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831225607.30829-1-philmd@linaro.org>
References: <20230831225607.30829-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

  hw/m68k/virt.c:263:13: error: declaration shadows a local variable [-Werror,-Wshadow]
            BOOTINFOSTR(param_ptr, BI_COMMAND_LINE,
            ^
  hw/m68k/bootinfo.h:47:13: note: expanded from macro 'BOOTINFOSTR'
        int i; \
            ^
  hw/m68k/virt.c:130:9: note: previous declaration is here
    int i;
        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/bootinfo.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/bootinfo.h b/hw/m68k/bootinfo.h
index a3d37e3c80..0e6e3eea87 100644
--- a/hw/m68k/bootinfo.h
+++ b/hw/m68k/bootinfo.h
@@ -44,15 +44,14 @@
 
 #define BOOTINFOSTR(base, id, string) \
     do { \
-        int i; \
         stw_p(base, id); \
         base += 2; \
         stw_p(base, \
                  (sizeof(struct bi_record) + strlen(string) + \
                   1 /* null termination */ + 3 /* padding */) & ~3); \
         base += 2; \
-        for (i = 0; string[i]; i++) { \
-            stb_p(base++, string[i]); \
+        for (unsigned i_ = 0; string[i_]; i_++) { \
+            stb_p(base++, string[i_]); \
         } \
         stb_p(base++, 0); \
         base = QEMU_ALIGN_PTR_UP(base, 4); \
@@ -60,7 +59,6 @@
 
 #define BOOTINFODATA(base, id, data, len) \
     do { \
-        int i; \
         stw_p(base, id); \
         base += 2; \
         stw_p(base, \
@@ -69,8 +67,8 @@
         base += 2; \
         stw_p(base, len); \
         base += 2; \
-        for (i = 0; i < len; ++i) { \
-            stb_p(base++, data[i]); \
+        for (unsigned i_ = 0; i_ < len; ++i_) { \
+            stb_p(base++, data[i_]); \
         } \
         base = QEMU_ALIGN_PTR_UP(base, 4); \
     } while (0)
-- 
2.41.0


