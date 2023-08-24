Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DACD97875E5
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:47:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDUJ-000124-Uo; Thu, 24 Aug 2023 12:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZDUH-00010e-13
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:47:13 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZDUE-0001iS-G2
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:47:12 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31c63cd4ec2so2564732f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692895628; x=1693500428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U3NVoFX8I2yBXsG5NAg5GSDZNqYtQOTrMBo/dPaCWF4=;
 b=yZMUxImVkADRHCjVsYCoODyFWspLvBq41EEvNWsMT2VXT2WQ2Djz7WrvQKT/SnL5hw
 JuOjzbXPdMW5MlWPCBFfnr8bTtp49rT7AiAE5mue0xFJRMyzi40exQ6fmzkrKrrHwOvt
 DUVU+CWioHRSt3eEIq5QC8ZZ71zZIb5ubjWP6iDEZUzMF6xjtVS9HCMe2gh7ujp7uRNv
 H2+Vmv5x9VVHccAskSGCCM1sf4rr2/+IArrPKiEGTv4pSio24n23HQrlaMmkHH4JEeek
 9qe10EAbXfHuQst63PTcCml2X5Ji9JbgL4CUtGkxafs/nDMRH45gO9FzEH6Xk2T5VVmF
 raJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692895628; x=1693500428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U3NVoFX8I2yBXsG5NAg5GSDZNqYtQOTrMBo/dPaCWF4=;
 b=B/SYLad9dnWZZpKuAcVBmdteB8hrIq/m27s7ac/6HrWGk+ZxJOzqbG70lR1WK6fSdQ
 XxLQgdXzXuXmikYTeKmhbguBPkuyoMUfkaoBE1WMJt/Qk+4qCN37LbQ492j7IkMeoy5N
 5N6AXK9Q2dSfZcGiJNWgDoqNTm8G793b5uAr/gNRCO0jzKnYZ7cZAqTaMYILkriZIhmw
 mvh0xNKFtokhLg1lKgnGjKMxKsm3iQ8TIRltx5Hr1sGrTOh0ApbX9IRUEeF4XoJ8qDNW
 z2Ys7O6SCF5ZiRYnmXozIJ+8HIIxhms4fZxGLZhMgkDjh/fthDEJmqiWEh57vxwMXzRl
 6KbQ==
X-Gm-Message-State: AOJu0YwMDpvrqSfa3UqHVxTGtCpCe/7Rgey8ttLECtWP31uumVJiDq1I
 Agf2hD9sLMaue2lzeKfX0dqAX+xW73B0cIYZxjQ=
X-Google-Smtp-Source: AGHT+IGR0A10QAn4JxS45wAeORD/G1E5StKWw4ydrUUJhvIi920HQukCJemH38NN4GUU7BOUPfcZAA==
X-Received: by 2002:a5d:4246:0:b0:31a:b3aa:d19b with SMTP id
 s6-20020a5d4246000000b0031ab3aad19bmr11725425wrr.23.1692895627673; 
 Thu, 24 Aug 2023 09:47:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a5d410d000000b003142e438e8csm22795655wrp.26.2023.08.24.09.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 09:47:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH] util/iov: Avoid dynamic stack allocation
Date: Thu, 24 Aug 2023 17:47:06 +0100
Message-Id: <20230824164706.2652277-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Use autofree heap allocation instead of variable-length array on the
stack.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Usual "only tested with make check/make check-avocado" caveat.

 util/iov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/iov.c b/util/iov.c
index 866fb577f30..7e73948f5e3 100644
--- a/util/iov.c
+++ b/util/iov.c
@@ -571,7 +571,7 @@ static int sortelem_cmp_src_index(const void *a, const void *b)
  */
 void qemu_iovec_clone(QEMUIOVector *dest, const QEMUIOVector *src, void *buf)
 {
-    IOVectorSortElem sortelems[src->niov];
+    g_autofree IOVectorSortElem *sortelems = g_new(IOVectorSortElem, src->niov);
     void *last_end;
     int i;
 
-- 
2.34.1


