Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5E0832912
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:42:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnCK-0008ED-Fk; Fri, 19 Jan 2024 06:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnC6-0007rK-W5
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:37:58 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnC4-0003Bx-9J
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:37:54 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3387ef9fc62so577577f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664270; x=1706269070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nr4OUHS+lBPFXd43ccavf7bhITrAw62IpLJRw1qHBNM=;
 b=rN+smCISHU8mn4jfzBBQCtnZWDkmz+dy+rKhFkNdItQpLzJQhUAr2bBnqbKVGA5GMP
 3HgEoiMFEJ0Cqe5a9BINjCfA2aqnP0ELGMvhUyqpcmhvo9WDDdGxTdk2jv8HhfCh6V1V
 7Voe2KLE4cmdItrzWk0QPENVbzdmIDWu/+kg8XigSFSZIK+AVEgSnp2D+k/KAEkD6S5V
 lGwEUBqdT3850r23JoXY9B4lUjVLxpZ9XBzS2xvkQk+t2+lSwDaE36AYEVcm8bnl3ruz
 g1X7FG0PIeEGI4M1H/cejHwM4nXFclqMZLdPiBJ4zFpSbh2nsYP54HLS1WSqtf1C+JV7
 PEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664270; x=1706269070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nr4OUHS+lBPFXd43ccavf7bhITrAw62IpLJRw1qHBNM=;
 b=vMD2LKTTfXBFJyRWKbNLoWU/Omm/6FBJTDdemyacBJUvb45k0qm2JrQFEQvng9ArHT
 HcENTjowSgnDiQFMLBLXJsf/q/jkGhbJWZ1NNLtL442OsSgUTKZhbqp2BA/qhpq314LM
 X+pW/d5UHWJTgHZJmCtW5dALPRcIvyyDqOGzjvfaJguzdIgUnfQ2kUqNWkZP9vq8MV2z
 RLIbE/qJ2Hf4j6G2cbzDlapBbHbHe4WReQBKE+Gb+G+tYjuKztbK2bYct97/ae1lAE5O
 NmVLCwRyubHNsN3wqtSV3osLjTWtYoMiDeGlUzcL2/W5/3B12lGl2+AXEYYl1mmsfisM
 iNcg==
X-Gm-Message-State: AOJu0YyfxgLhoiR2x6Bk70E/NejnUHOSJYCldIZjcFsq9KgwBWxp3c9J
 yY2eOQZ3PqXFYPfcG6dZ+MIvaqnS7BzDvUHes2rp5+lOm+BhJWatyE68GcPrlLF/gCZ0vc4T+ty
 t9YH7gQ==
X-Google-Smtp-Source: AGHT+IFyTbs9SjNe0bzDqWuc52RujTUb9c4usvahIXvdRm1GAXWN+0NECvsNYTHwwL2fqfD9VRtwkQ==
X-Received: by 2002:a7b:cc88:0:b0:40e:6207:2ecf with SMTP id
 p8-20020a7bcc88000000b0040e62072ecfmr1314432wma.10.1705664270639; 
 Fri, 19 Jan 2024 03:37:50 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 hg14-20020a05600c538e00b0040e5cf9a6c7sm29076314wmb.13.2024.01.19.03.37.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:37:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 36/36] configure: Add linux header compile support for LoongArch
Date: Fri, 19 Jan 2024 12:35:05 +0100
Message-ID: <20240119113507.31951-37-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
References: <20240119113507.31951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Bibo Mao <maobibo@loongson.cn>

When compiling qemu with system KVM mode for LoongArch, header files
in directory linux-headers/asm-loongarch should be used firstly.
Otherwise it fails to find kvm.h on system with old glibc, since
latest kernel header files are not installed.

This patch adds linux_arch definition for LoongArch system so that
header files in directory linux-headers/asm-loongarch can be included.

Fixes: 714b03c125 ("target/loongarch: Add loongarch kvm into meson build")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240116013952.264474-1-maobibo@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 21ab9a64e9..3d8e24ae01 100755
--- a/configure
+++ b/configure
@@ -445,6 +445,7 @@ case "$cpu" in
   loongarch*)
     cpu=loongarch64
     host_arch=loongarch64
+    linux_arch=loongarch
     ;;
 
   mips64*)
-- 
2.41.0


