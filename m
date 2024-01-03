Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F6A8229BD
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 09:50:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKwwG-000070-ID; Wed, 03 Jan 2024 03:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rKwwD-0008Rq-25
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 03:49:21 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rKwwB-0007RU-Ez
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 03:49:20 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d894764e7so20925195e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 00:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704271757; x=1704876557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=udXDshpISZVUvpF35iOBeAPV8/e7E/cugb86G6jXdUk=;
 b=aZo3MYfX5up8hhLOQbS12g7KmDG/1ty717m/x35+VQY/jZ10X9z/b1qu0yeLKaDDmC
 ferRnydxCsZiMX7B3/u7WGrVRB/FTUvJSB1ZVhAXBDVPPVHti2Ngx6Hc6k1T7GKpPRx1
 kCj7ro71uIlZWxNNUbQIcmFiH6jwRzpgaXiTSI7gGvTraYM+xUmbSNWUbvRq8bUK69r3
 j6HJRZk6k7xUHr+UbdLjDH9BNjr+v48cm/gSazIIk3UqtIwefjnTvIKLZbWergYJK9Pb
 Jr12Ln46E28jkgGIRS6qWMJYQ++gTVVhfn07zy9lz6v5jVz8ENNpWMPbxrfaoQXFjpXT
 tHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704271757; x=1704876557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=udXDshpISZVUvpF35iOBeAPV8/e7E/cugb86G6jXdUk=;
 b=IZb0hAKey6vlFFobQOafdLQlT2SI9hqbRwtq2/DHFR9eR5vxyIcENOEX9/zzlZejJY
 E9mt6fZJ4xpf12nek3cT0LPmA60XvVjKpfGcwfyn6rlSOMe1zFGwpYGHafK92v7lUow4
 6SRNDX0c0rRYz7poZbaiXwXxArTV2vU9gxyqpjt37dfoThTXCGeMcLiJdrOi6Tpr119Z
 Ch4DHqwQPD0yjd2+6U4aMiAuUA4OWuRLvsuFgANgiA111wrjLpWF41Ebg6YtIHAWZqNO
 5ZJpeesoTVRaAvz7TTnEYce2AC13WsBW7C72xBzyg/CcKwgwv+TJdKexl+9o0/QXVGZD
 5MYA==
X-Gm-Message-State: AOJu0YwVLF3z1LbRTIKwbXi7wb4Lh4IZ+2pGEoFBk7mC6OUVoqThfpX9
 JoCQFNi92Tx9FeVi4gX8UhC7OnAPIepVOw==
X-Google-Smtp-Source: AGHT+IGgZjU9sp6q5BDAtqxkfWnuKSdLCeILqTz6Px6Fzjep+apMVazXsW1JQMDSdB5D8jdSLiKvdg==
X-Received: by 2002:a05:600c:211:b0:40d:5821:5148 with SMTP id
 17-20020a05600c021100b0040d58215148mr4701847wmi.67.1704271757116; 
 Wed, 03 Jan 2024 00:49:17 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-013-084-064.77.13.pool.telefonica.de. [77.13.84.64])
 by smtp.gmail.com with ESMTPSA id
 z16-20020adfec90000000b003366fb71297sm30063183wrn.81.2024.01.03.00.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 00:49:15 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/2] target/i386/cpu: Fix small typo in comment
Date: Wed,  3 Jan 2024 09:49:00 +0100
Message-ID: <20240103084900.22856-3-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103084900.22856-1-shentey@gmail.com>
References: <20240103084900.22856-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 95d5f16cd5..2ae271e9a1 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2179,7 +2179,7 @@ static const CPUCaches epyc_genoa_cache_info = {
  *  Conceal VM entries from PT
  *  Enable ENCLS exiting
  *  Mode-based execute control (XS/XU)
- s  TSC scaling (Skylake Server and newer)
+ *  TSC scaling (Skylake Server and newer)
  *  GPA translation for PT (IceLake and newer)
  *  User wait and pause
  *  ENCLV exiting
-- 
2.43.0


