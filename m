Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 917BC77A6DD
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:19:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBps-0008Dt-BO; Sun, 13 Aug 2023 10:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpW-00088p-LO
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:31 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpU-0000r5-8d
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:30 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-318015ade49so3234520f8f.0
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935946; x=1692540746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ab1IvE3iWruWgD8FlAhi9ghHGvE08UiOYtOTrfrC7KI=;
 b=Z5uTExoe6jGvA5NjW4dKDixDGCJX7rl1r/J2ScVvGDEn/Fsyw+1+iZS/FIWnrSnP0z
 6ek/tR2WrcHIPKph+6lGrG6qxXd5Df9QiXsgbUate1mGbBfJgfOEDg9Qf97L1Y+M07Gq
 ogPP4pCIvlYH8wB167Qw5w6ze/BM22XUmlpDDqMIlkTuWchqdBcmTgCPfgsZObtnXTiz
 qRv9SEGQv9qJvbNv26DI08Y9dPXYivJ+416/Y6vY7gXZDdMMAyG+Jx+0gVd/igLhAQwC
 h4cNLQpGbmt00Bpeeu65eeApNIVUA5eupnCUvdtZlEh54KSE8QrbJL0J99jKiuveMKag
 oY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935946; x=1692540746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ab1IvE3iWruWgD8FlAhi9ghHGvE08UiOYtOTrfrC7KI=;
 b=RbSC7GPa75KJW3CPBnUXxsQzlz0NBDL3Tn8gT/LOeREg7RZDPJVhZoWI+gqZGGLfGo
 O6WCjMwLDRY/2u9xBgL5pPGCNhVEauU4eZlp/uBXl+lCbgsfr1iFgHzLZhdcT0wgOT7i
 9CaocSupbFl54fnUJfxu8WLdyDgvsYo2N3IOGjPBYpzRYOA8UPPRNQTBGIM+Yn6FLe6V
 i6aPGDdu5Q0GVcsmyR45T1PaWSyQemecbx7IcubRDdeGaPkkEe6ou1/0i4+9XOp8JSnL
 3sw3M4YYgF35uOeVGJDhSkKrp40FSUtdz7Bk4saIwaftyeaI49nZcmXw27Z/1iARAjmd
 hwJA==
X-Gm-Message-State: AOJu0Yx2Oe/Zuu/OSbsk2qmbT9Pun8gs6q2qZGd8X9tUG5esHQtVdAF4
 CfmWQ8otPN0KsQAarJrqucYAsrjPkDg=
X-Google-Smtp-Source: AGHT+IGafK9foU6ti1PCjWFV8hOByXJhZ2fqcPGtDxvGOGLbdIer/HIlluDUKyCvVCDJ3y5UXE3lyg==
X-Received: by 2002:a5d:4573:0:b0:317:5de3:86fb with SMTP id
 a19-20020a5d4573000000b003175de386fbmr5081881wrc.10.1691935946609; 
 Sun, 13 Aug 2023 07:12:26 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:26 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 15/32] Implement target_to_host_fcntl_cmd
Date: Sun, 13 Aug 2023 05:09:56 +0200
Message-Id: <20230813031013.1743-16-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x434.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Implement the stat conversion functions:
target_to_host_fcntl_cmd

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/freebsd/os-stat.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
index 9eb01bf664..2ce235d5da 100644
--- a/bsd-user/freebsd/os-stat.c
+++ b/bsd-user/freebsd/os-stat.c
@@ -170,3 +170,11 @@ abi_long h2t_freebsd11_statfs(abi_ulong target_addr,
     return 0;
 }
 
+/*
+ * fcntl cmd conversion
+ */
+abi_long target_to_host_fcntl_cmd(int cmd)
+{
+    return cmd;
+}
+
-- 
2.40.0


