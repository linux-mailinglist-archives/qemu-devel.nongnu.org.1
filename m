Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 771237740DA
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:11:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDv-0004Yy-V4; Tue, 08 Aug 2023 13:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDt-0004GJ-9s
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDr-0003p3-8W
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:10:20 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fe1fc8768aso57368045e9.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514617; x=1692119417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7L4DblnyZ6mZ6SUX5IHPSXJ1ZwP6k4CfYzPJU5sNjU=;
 b=VQMDVujvZlstMpOLDknVeRQOOOJzhQ6OXQW+a3f8TNhB9hurJqC1lQyLnYf4kywNRe
 +FLfHSo36REWJzDIS2KFU7IEsU1Hijpl3Qx54nLmnEX/dUgY/I8SvScB/wzeK9nws4DY
 D7N/9BYoaZ4kMyK79y02Dkk5MxhGDVuU6o6qFF5bz+ZI4ESfQRfaLlGzjI/5FN7lUwJT
 MmXC0QkjICRXvGQftyKSKx5ywuppR8i9PIW8+ojV9wuC+qZ3qBi8NzTRaagtVxrIkU2E
 uOlsAyx0FIVwECl3rLjACYjrHddA3P8ttNwe5xqmoQlu5rVt/wrXmCJDDA44hMCv/AMO
 Nm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514617; x=1692119417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m7L4DblnyZ6mZ6SUX5IHPSXJ1ZwP6k4CfYzPJU5sNjU=;
 b=l8Ga6u8zSCmeHbFueihkSPkODrVZIZkehAzM1CJOzxlSB7iudUgKWbdLnOBQKpEzz0
 MJdisBm62+33fg6zlnrMNpCVtfVfz257AwVfM78L5BvD/rPalVsaEW6OD0VmO5CT+nOJ
 wTg7N6pvEZ+7DuMM2tw1mDF4s7Ht2231cii3k6CZuOhM8wCLqfgUWaKuX2q6JMk8UOuS
 R3Ua/4aHdAmvuvPsXJp9s+VSwGHs981YY8u9we2C8ygJ23u0acjnbuCkNniUY4Bm3jMu
 514CB/0lGeHOjJuEYZyeBVNfK7J9ONNwuMCLW5nDWo3o6pAlHV7U1KcrMgekkuALCk5N
 GVmg==
X-Gm-Message-State: AOJu0YznwCgSDRyCrOD807pXq8gW6hxezSWThRZTHWbmmxO0D07ccNQO
 A/a5+dvesbb8akbtN62J9/9zF1144gMRcQ==
X-Google-Smtp-Source: AGHT+IEjGzK8rZfKQNNynipwgdYccJ56LobS4dIdiVqATKitXS8spCBAUgPk2oyihukwDlRLAx3vIA==
X-Received: by 2002:a7b:c399:0:b0:3fc:3e1:7105 with SMTP id
 s25-20020a7bc399000000b003fc03e17105mr345871wmj.24.1691514616921; 
 Tue, 08 Aug 2023 10:10:16 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:10:16 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 29/33] Add os-stat.c to the build
Date: Tue,  8 Aug 2023 08:08:11 +0200
Message-Id: <20230808060815.9001-30-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
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
---
 bsd-user/freebsd/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
index f87c788e84..f2f047cca3 100644
--- a/bsd-user/freebsd/meson.build
+++ b/bsd-user/freebsd/meson.build
@@ -1,4 +1,5 @@
 bsd_user_ss.add(files(
+  'os-stat.c',
   'os-sys.c',
   'os-syscall.c',
 ))
-- 
2.40.0


