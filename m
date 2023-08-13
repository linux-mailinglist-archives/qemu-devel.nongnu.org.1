Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 149CA77AB02
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:50:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzy-0007x2-5t; Sun, 13 Aug 2023 15:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzw-0007wQ-AU
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:36 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzu-0002Tc-UI
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:36 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fe1fc8768aso37030595e9.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955813; x=1692560613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1p1EbelIrl574LxcCV2hZyhTqJPEK2mCoLPeGMnT7c=;
 b=E9c1NNx09yaHiIFsH7O2XqtUJdyP38PjdOYQZOm1Z2CIPSn018OU+9SLu+NB2YCjKj
 IFUk2xuUVjGLSIgbFBFqASvN649ZrxIiEvT0tDJN7HnIe5fVrSNyT3cGgtUzZS+OLKjK
 bMXEs8Usb1sILDP0n6AC8Dr3Whd04Ja8up8ICrKgvpj/nu6x8iEZIsloUnQYUfeyMIrs
 5BUDjOjNIWT6+VTXXh/0mWgJeuBbQ2525fCet3ITnMJfOAdR1Vxl1V4lUDXjcIY8W7/s
 DDXDrdTSPEWGCJYj6drOYP9wF/2Gd4SQpOs1col9YUE96/Z7uPRl6wCGA1AguJT9TmEz
 yL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955813; x=1692560613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1p1EbelIrl574LxcCV2hZyhTqJPEK2mCoLPeGMnT7c=;
 b=EDP7Ku+7sJxEhntMW3gneXL3laSgO0WCcndUgDoH4YI4Vr/MkBGBuygkkoTH/c7mPZ
 boLrQqolPc62cjVFga8nD371Vu/MvsrkOqfRHSL+GGiT+yCSJXHmb6RAjCKaBM95M0/4
 sAE9L6G+IUOHAoyfUmvuXEddO1NAzBvRCXK6D5X7l53raGikUaiO2gmk5fXR/S1xl2Ls
 BJFYGQvTz3bUjyi6orSYubXR9pQRSBLFoxgH0JBSfU0ga4Zl7PR9HY/MD/F9Mp4E6j+n
 jBxfP/Uq5rXU9Im2XcW8/wSxn5PpgvCERERxzPKVbx6Ii6nlGbgb1PMjtqPz8BVWKVXG
 6uBw==
X-Gm-Message-State: AOJu0YyiT3xitxX/D5sQpuiYhc+i8GqxBDQiVvWQyH3ThTQhMuUESdX9
 6lZpj0gEZDZ8TEC+Hp4Q+gUYaY635Mg=
X-Google-Smtp-Source: AGHT+IEX5glHz3BvJoH1T7gtuohjZ6tY3crGcr/dprnN49BoXz/0eZ6qVGbwIp99i8g5+y2JGUWFqA==
X-Received: by 2002:a1c:7417:0:b0:3fe:173e:4a34 with SMTP id
 p23-20020a1c7417000000b003fe173e4a34mr6066495wmc.40.1691955813382; 
 Sun, 13 Aug 2023 12:43:33 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:33 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 28/32] Add os-stat.c to the build
Date: Sun, 13 Aug 2023 10:41:49 +0200
Message-Id: <20230813084153.6510-29-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32f.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


