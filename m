Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6DC76C652
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 09:20:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR67X-0007Yk-Pd; Wed, 02 Aug 2023 03:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR67U-0007YO-2p
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:18:08 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR67S-0002no-EP
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 03:18:07 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6bca38a6618so2596750a34.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 00:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690960685; x=1691565485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rQcw8k68MOdrh2WluUA73b05P6tF+ayKNuHwzr1IbSc=;
 b=NyX1duMDzl0omaOufduLTSUfF+4Gnsgb/xeZVhod9YNLFlGB3qIdPAJQj5PWZ4CaD+
 Q2tYH74bV/NWsnslvxkDxeavk88McFRKe/vJrCJT47LCt/DyPS9hBcKjRbrc9q48iOUy
 df+OU1FZwHBObL3c+w1lE3RRgldilU466a6+vJ+g7OAnglay9Y6OGUMv94g2zK3RXV8s
 A/Eo8ONF0F44GdfI+CQcozbzPz0CxPf5Sk/i1kCVaOAcnumfNQQU5kLW1HFfcXY6WGCD
 977fj3R6+K8D7JOZMQtr24V67Gg7jagRdrXyoTsJQEJaeti1hb3/dLJtEnphGai5C7de
 Q5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690960685; x=1691565485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rQcw8k68MOdrh2WluUA73b05P6tF+ayKNuHwzr1IbSc=;
 b=Xhrekd89POs4TqC99NcZNuNbT7wxCXvg61z+NICK4wJbfiK25WMh4F/6gsvEnRkgg0
 D69XEm+ZfJwqwN33owIEQzD8UoofvA4rPXSQOLvIo1h6JicE0geC4XwRajTDhuvrHuj+
 bukkjiarygR/W0RU1JTtOelj63VolcocgdkL/otpIte6PiJMDknzkBqEke9meXN9juWW
 lBj1cZRit2rvyyNEFhQCsyhU6liGsAKIlkXZUGJ5IpZfnPc8ofKjwIbVVOpWsG9tNZbf
 x3VGpB5PSK0ccQNfpBmYgMpVLctd1l9CENnEAlgMLco11gJzAoKPgr3wgrxQWJLxysNl
 e8+w==
X-Gm-Message-State: ABy/qLYhRq53VKKXrxV3gvC/M/tJAadsSrppnZgt+tIIrWj9dKZK0keA
 oAVkGzcwjbk6Kq0AIbmrcOhbFQ==
X-Google-Smtp-Source: APBJJlHkstBSaPN/+i6XwILINkNFpZNpj9w5b8Se37w8YkvY7NqLIEiSmkFYizhOBAl2d4xQTR5ujw==
X-Received: by 2002:a05:6358:7250:b0:139:cd0a:989a with SMTP id
 i16-20020a056358725000b00139cd0a989amr6779345rwa.16.1690960685308; 
 Wed, 02 Aug 2023 00:18:05 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a63b20c000000b00528da88275bsm11004440pge.47.2023.08.02.00.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 00:18:05 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Helge Deller <deller@gmx.de>, Joel Stanley <joel@jms.id.au>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 2/6] linux-user: Fix MAP_FIXED_NOREPLACE on old kernels
Date: Wed,  2 Aug 2023 16:17:48 +0900
Message-ID: <20230802071754.14876-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802071754.14876-1-akihiko.odaki@daynix.com>
References: <20230802071754.14876-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The man page states:
> Note that older kernels which do not recognize the MAP_FIXED_NOREPLACE
> flag will typically (upon detecting a collision with a preexisting
> mapping) fall back to a “non-MAP_FIXED” type of behavior: they will
> return an address that is different from the requested address.
> Therefore, backward-compatible software should check the returned
> address against the requested address.
https://man7.org/linux/man-pages/man2/mmap.2.html

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 linux-user/mmap.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 14cd1b9feb..1a8477dbb2 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -263,7 +263,11 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
         void *p = mmap(host_start, qemu_host_page_size,
                        target_to_host_prot(prot),
                        flags | MAP_ANONYMOUS, -1, 0);
-        if (p == MAP_FAILED) {
+        if (p != host_start) {
+            if (p != MAP_FAILED) {
+                munmap(p, qemu_host_page_size);
+                errno = EEXIST;
+            }
             return false;
         }
         prot_old = prot;
@@ -686,7 +690,11 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             }
             p = mmap(g2h_untagged(real_start), real_last - real_start + 1,
                      target_to_host_prot(target_prot), flags, fd, offset1);
-            if (p == MAP_FAILED) {
+            if (p != g2h_untagged(real_start)) {
+                if (p != MAP_FAILED) {
+                    munmap(p, real_last - real_start + 1);
+                    errno = EEXIST;
+                }
                 goto fail;
             }
             passthrough_start = real_start;
-- 
2.41.0


