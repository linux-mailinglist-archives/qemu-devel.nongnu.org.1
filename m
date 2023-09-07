Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD39799655
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:39:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfH-000100-HQ; Sat, 09 Sep 2023 00:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfG-0000zq-38
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:46 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepfD-0002w8-WA
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:45 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31f6ddb3047so2467150f8f.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234022; x=1694838822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B7l8yTYvF0exPE7Y1/cG6wE7nHKc1Z9FnZqMFX4sgdA=;
 b=ngeNLSMLAYvoE5x+vE7mgthHCfYfSbLKaKAfxCxHD6OzZfv0HVpKp+xuCz8v63wrjM
 fD6wAbafCTmXcJPlXVoA4PqjzgbzoWQ/eu6Fzm5zfTkOfBOPV4ax+tEUGSXnk0dlnqU6
 l4unE+gz43jvDphpnTG+s9hhGstjtqkGHIkuCnxPLXJh3Ts6s4BaMAmLiW2PuUYMbFoX
 El1Pl9K2C5hm9NLXj5n4shBmfGtiQvZv2jNz7fZfM8cYSn/7em9e2Bcn0v9RiDmrC0Dg
 1OyL5jjZfuuFmqSrC4RPxMzbWSyrT6y8XxHANTNDw1LEW71Vy96Kbe3dnkLmBu1AN9f6
 TtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234022; x=1694838822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B7l8yTYvF0exPE7Y1/cG6wE7nHKc1Z9FnZqMFX4sgdA=;
 b=JjTQPSLviA/ltX+NUrvZQfrBY3Eii++bwhdg9cd9WVVMdDQyvCaXJ3W4Fq9oeGW8vz
 89E8iWCOrUDvr35a2pbl15CNTaSOr2P1ZP/3s99WkgyL53ba7gMqyiyzvhg7xMEs2kej
 pqemMQLRiDkKVPO0nRL2Vr2Wf22iifAqmo7zsXoQ4Zmvb9QMJr2XaBNcasuelOUq0N/M
 bVC1FX/V0Ick9ZLLhW5WCnQiyICi7fScL8L5+9hrkveWXoLG/WWoREZG+0Oiji72gx5z
 2GcwxTr/Qd9vewEl7lhro4narZK4wiqhZnNvySkOMb2EatFrIQvxZgoys7ZWRRckk5Kk
 O62w==
X-Gm-Message-State: AOJu0YyAp5FNxFGVIHq3xmhn9yh+7FeX9t+CwtSD+ii0x4nTg+c7Ml3P
 jZhfuOR5TzS9rFWLsjC5XOAmMb73Atk=
X-Google-Smtp-Source: AGHT+IHQ3YGjtqw5VijP20EpxRkByBU/g+nT91mxphCtgnwTwtNxAviVeWpmDO3Glz15SQ9+UGO+Vw==
X-Received: by 2002:adf:cc8a:0:b0:317:67bf:3376 with SMTP id
 p10-20020adfcc8a000000b0031767bf3376mr3283362wrj.57.1694234022422; 
 Fri, 08 Sep 2023 21:33:42 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:42 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 07/23] bsd-user: Add bsd-mem.c to meson.build
Date: Thu,  7 Sep 2023 09:42:46 +0200
Message-ID: <20230907074302.79234-8-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
References: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-mem.c   | 0
 bsd-user/meson.build | 1 +
 2 files changed, 1 insertion(+)
 create mode 100644 bsd-user/bsd-mem.c

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 5243122fc5..6ee68fdfe7 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -7,6 +7,7 @@ bsd_user_ss = ss.source_set()
 common_user_inc += include_directories('include')
 
 bsd_user_ss.add(files(
+  'bsd-mem.c',
   'bsdload.c',
   'elfload.c',
   'main.c',
-- 
2.42.0


