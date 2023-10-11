Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E057C504B
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:36:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWXN-0001e4-68; Wed, 11 Oct 2023 06:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX6-0001Kw-9m
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:41 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX2-0005BC-F9
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:40 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-504a7f9204eso8164887e87.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697020414; x=1697625214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1zLuzNXUek9chAtmqkdvsAg9LAFRcVol3Mr0VZBUJ0=;
 b=x4df//Z+dtzd7uRjkYsHs+6L4pv7gefJIo6KyuvWbYKD9HbnPYPWciddmNHVV+5ucM
 dIg9URoVtNLH3c6J2QgOOQyiZM9dLgnEL4g+pOH0PFQkiZRysHqaqJkOfX0tV8UXJ4sh
 A9Yrg8fi6nRrwr6Bg+j7CNzwxXZij+GT/oLIszr2AglHSFY1pyd2LCzinvb/hzSz79pq
 vJ3wVvkgEToaSFHPcFCnH3Po0PEnUp8jhgGP+a65n39xnrW62zI0NmTfkE+Hlv0xwKz/
 ndeJcm9W4k2/PnsTWPREoEs+IEWVHDgL6W2fQY6bll3ztFz8MJxAobrNMeeoiQoTmYLe
 xT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697020414; x=1697625214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f1zLuzNXUek9chAtmqkdvsAg9LAFRcVol3Mr0VZBUJ0=;
 b=aHTt1pSe9snH6507sjZ0t6MLALVgT514Ash5BgSPf9Lbb/Ey632kxNItAm3P2Zg20y
 ByQY4b3SoPiL7Ut2PmR6DyVhg7spcq2BsAlHt159HIdM/GiByDC7n9Iii4i0Pz1+WmPJ
 a3D7JZBP4L6MIZfdMM3FbO9KYI9sABpVnWjCN34q5begnXJHFNXXU0DVFe1UTbCVwuYx
 ge5fEkclI5yasDsUoWzrRACQRO1vu4BKv/N7tgKePBmfNRm+wQyfU8kCV9At4TtzaA8d
 CGUlejVszqX9OBBcodQsSrWsziF3l2KCqmimswzo/LCqyg5Mq0fO1p86d9KVdqpCwBAc
 MT3A==
X-Gm-Message-State: AOJu0YzLdHA91ec8zDMkjmXwji/k8fB98IdGqkTc4A4qvibhwA+2yQpq
 rp4raXoVCtdERLj/Xx60M9PlCNy9hbnNmEUqGnU=
X-Google-Smtp-Source: AGHT+IH4huI2ob/OlPUnfCwlf9vUO9mcus72Okd08biZDvc0+ETEMmijWcuqUjpiFml1t1TGH2z1yA==
X-Received: by 2002:a05:6512:718:b0:503:5e1:9b6e with SMTP id
 b24-20020a056512071800b0050305e19b6emr15315676lfs.10.1697020413893; 
 Wed, 11 Oct 2023 03:33:33 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y19-20020a05600c20d300b004075b3ce03asm2945219wmm.6.2023.10.11.03.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:33:32 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E687D1FFC2;
 Wed, 11 Oct 2023 11:33:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 07/25] configure: remove gcc version suffixes
Date: Wed, 11 Oct 2023 11:33:11 +0100
Message-Id: <20231011103329.670525-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The modern packaging of cross GCC's doesn't need the explicit version
number at the end.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-8-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 5c04e63bab..8fada85a71 100755
--- a/configure
+++ b/configure
@@ -1334,7 +1334,7 @@ probe_target_compiler() {
         # We don't have any bigendian build tools so we only use this for AArch64
         container_image=debian-arm64-cross
         container_cross_prefix=aarch64-linux-gnu-
-        container_cross_cc=${container_cross_prefix}gcc-10
+        container_cross_cc=${container_cross_prefix}gcc
         ;;
       alpha)
         container_image=debian-alpha-cross
@@ -1397,7 +1397,7 @@ probe_target_compiler() {
       ppc)
         container_image=debian-powerpc-test-cross
         container_cross_prefix=powerpc-linux-gnu-
-        container_cross_cc=${container_cross_prefix}gcc-10
+        container_cross_cc=${container_cross_prefix}gcc
         ;;
       ppc64|ppc64le)
         container_image=debian-powerpc-test-cross
-- 
2.39.2


