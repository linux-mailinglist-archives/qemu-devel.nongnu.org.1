Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAB0A9A041
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Apr 2025 06:52:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7oXv-0005h0-Nm; Thu, 24 Apr 2025 00:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u7oXq-0005gc-OX
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 00:50:43 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u7oXp-0003Vm-4Z
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 00:50:42 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so681878b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 21:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745470239; x=1746075039;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UHcKhUy69pRs0cRfr7uvJrTweyJDdDo4Zt7XhLrkh30=;
 b=DPrq9CzCV50UCB2/SbHYi9ueZ4vP5ciVY12ab9TNqf/wES29+nSnsI63Cuz6mtefev
 ZVUVpRZlnDTbj9UXyg0S+Pm7I9FEUNMzfUm/7w7nXp4mQ152nrm7+cOvNqVfc30Lknu7
 MqcVn4yD7UAEPY+MWEQ2rHSDluCso2ndSLz2ef6aLuuuRbb83JVycZg59dGXlf8i8w8A
 curUqtR5/MuCmgOlIx+eKywdTe0+VUB4LXxISX42Mm/CLA9Y/HRcSVtt4/ZPK2ZSluYe
 AkR9lzEbsw2IsVd3pcrD4BUDvB/H1PZmkEaO8PARKLSk79bKfl8RstS2hjI1vE+fRwr9
 8DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745470239; x=1746075039;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UHcKhUy69pRs0cRfr7uvJrTweyJDdDo4Zt7XhLrkh30=;
 b=ikJkb3r8G1Ayse7Gm/1/LILzeONgVHnPZY3s9/Pb1Mq7Mz8IDojSUPt49AIbbiA79H
 B4eYlKWKOGCkaGD1T0HahPOSSDHoc41oCjXumPN2XRhEJWFfBv6qFoKJyDkvpZYxTspE
 qDXstKbCQNO0R6/IOyEGV8UQsKNGUT5IFK1sr4CTZsy9QQbqsEcsKfCqpLITh6JbVUI1
 M7gswqRioGPWq4jHEfL0eQjagGHTsyMZjprKQse5RRj/wn98wYJKUBJOrIkRkJwnbPQz
 Wdww8bow93Moocbvk8frZXtxVmKPcCPVYZwJa9A8vfKG+OQsEeK5tH+2nMsNe2P5u7kD
 opAQ==
X-Gm-Message-State: AOJu0YxmVGSzMYSgyUVm/wNe6HGYfMk1BlMqtdDPgzaq7gAmJIlvwW5+
 P71aJOmyuzbg5miunCTrcVyyDMP9qUt6ASk6XL1v4ATHk07E3+5+Z6rwWCT63LA=
X-Gm-Gg: ASbGncupmhxR0yUUBm6fL2ge+Zn7igJWoofX6osh/njEO+UG/BfBReNhR8FUBcmHcup
 71ctqAHMTlz/Y8VSshU7I0Z/ukd5gpa6FcfTOu1KZL/d/hNHhVDW25b6T4YQqJsLKCSZd4Ss1jD
 5Mj5g9PrS+e+u7va+RYQ1lvrgKSuNpISW06I5+Bm7RMgjE22UXyC+JDaAutDbkY7jRo+ZgkG64X
 nh+NyVxNmT73S530WP1mIvFcRuXA8FLbS/xtrxLHML7knlDNoNwSe1LCcXlF+eozT3x87YyI0Lc
 ZdCSCHW60/gzmYMcbGZS1ef02dgktQZTxmtk61EVwip5
X-Google-Smtp-Source: AGHT+IEra/vFCi2BDDzY1r4nUErC79fofw+U0qF1kAowqiak+bzwuPamKZO0tJFniQlkIfGd/bsu5g==
X-Received: by 2002:a05:6a00:2285:b0:73e:970:731 with SMTP id
 d2e1a72fcca58-73e24aecfcamr1785136b3a.16.1745470239055; 
 Wed, 23 Apr 2025 21:50:39 -0700 (PDT)
Received: from localhost ([157.82.205.213])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73e25a9abf2sm448766b3a.122.2025.04.23.21.50.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 21:50:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 24 Apr 2025 13:50:11 +0900
Subject: [PATCH 1/4] meson: Use has_header_symbol() to check getcpu()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-buildsys-v1-1-97655e3b25d7@daynix.com>
References: <20250424-buildsys-v1-0-97655e3b25d7@daynix.com>
In-Reply-To: <20250424-buildsys-v1-0-97655e3b25d7@daynix.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The use of gnu_source_prefix in the detection of getcpu() was
ineffective because the header file that declares getcpu() when
_GNU_SOURCE is defined was not included. Pass sched.h to
has_header_symbol() so that the existence of the declaration will be
properly checked.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 41f68d38069b..c0ecb6feab77 100644
--- a/meson.build
+++ b/meson.build
@@ -2635,7 +2635,6 @@ config_host_data.set('CONFIG_CLOCK_ADJTIME', cc.has_function('clock_adjtime'))
 config_host_data.set('CONFIG_DUP3', cc.has_function('dup3'))
 config_host_data.set('CONFIG_FALLOCATE', cc.has_function('fallocate'))
 config_host_data.set('CONFIG_POSIX_FALLOCATE', cc.has_function('posix_fallocate'))
-config_host_data.set('CONFIG_GETCPU', cc.has_function('getcpu', prefix: gnu_source_prefix))
 config_host_data.set('CONFIG_SCHED_GETCPU', cc.has_function('sched_getcpu', prefix: '#include <sched.h>'))
 # Note that we need to specify prefix: here to avoid incorrectly
 # thinking that Windows has posix_memalign()
@@ -2713,6 +2712,8 @@ config_host_data.set('CONFIG_FALLOCATE_ZERO_RANGE',
 config_host_data.set('CONFIG_FIEMAP',
                      cc.has_header('linux/fiemap.h') and
                      cc.has_header_symbol('linux/fs.h', 'FS_IOC_FIEMAP'))
+config_host_data.set('CONFIG_GETCPU',
+                     cc.has_header_symbol('sched.h', 'getcpu', prefix: gnu_source_prefix))
 config_host_data.set('CONFIG_GETRANDOM',
                      cc.has_function('getrandom') and
                      cc.has_header_symbol('sys/random.h', 'GRND_NONBLOCK'))

-- 
2.49.0


