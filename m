Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBDD77967A
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 19:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUWEy-0006tJ-9D; Fri, 11 Aug 2023 13:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUWEw-0006q5-8N
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:47:58 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUWEt-0004sw-It
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:47:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fe2fb9b4d7so19711055e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 10:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691776074; x=1692380874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UYOUlYSvFbFl1pmmwKESH5JX8p01RT7peqBRnIGSGfI=;
 b=EEAyt+s8Ba1FGxgNdYgPS1jtaZKkVqf5HaFb/duSzW8wbwgIQO74Xw5XHmh4wcRaX3
 KjrkirfJyNTGxfrVO8xppAg0lSaQhc1wRUk4mXhvirD7bAViK2a2cBlpT0D8Pi47l+//
 /UJIk/kns6eglT5KsQ9qCbrUJ8O08c8OI+rDlqoCoUHQKzPtkzmWOtHD5IdCJCYhWi9G
 P7x4QMfHLYhXL6LkfeaMAOBdfLmq2Fcx5G2d5Tir4vKfuMe+OSrniSiUB994d9Tmk8Uk
 50Mf1v6lRNhADQ/Pp/OJJcRvRKfQ3crDaaqq/eXrTOGeEU5QVgbHkNm/v+erBKj9ZOWD
 Y4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691776074; x=1692380874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UYOUlYSvFbFl1pmmwKESH5JX8p01RT7peqBRnIGSGfI=;
 b=NZqgdBnWvV1jEcrGm19WS0KyBaLjwVNp1T71AJtVRmpukZhvXRy7uE+P5NU7ZaOI/q
 6Ku2+02dOI/PGxFg6+2vrQnRiip65Yd6R1ntNkwZjCVTUh6ihKU2rLFH1cefeBRbnE8d
 ClpGmGxKSA2xpdtuzglPMDOCrUCdfgY7x5h7f/cEQ8wRh3Hg40uItgtq5T0zfg46It5u
 X9Ug2ApxTC7wpnr+iE0CK6lc5pz5qfLwB0x2ey0L2LPwqVmN4VtvCe94F8T9b+GXoc4U
 bX6HSuEOimXdzIWQX/5KTy9VOopZR8GhNqc1D6O0AwDcLpHE0EJv4M8FDzItATmeqVJd
 qfQg==
X-Gm-Message-State: AOJu0YyGAHBpg1qV9UUvByEmO7itnG3etqjzI/8MtY7mTbeVUiCBgeCn
 UJ3RXO9MarDVXaivpLReMvEXmgiyAi+gE9Tg1RA=
X-Google-Smtp-Source: AGHT+IG86H6SsNI5cUYG2l8uv6IjKSAEY5jKHqRosp+rgksDmwdyH2sVFgE6Fk6Gn4/zJAlatKU+Yg==
X-Received: by 2002:a7b:c8d7:0:b0:3fb:ff57:1750 with SMTP id
 f23-20020a7bc8d7000000b003fbff571750mr2169565wml.32.1691776074077; 
 Fri, 11 Aug 2023 10:47:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 c21-20020a05600c0ad500b003fbb346279dsm5874940wmr.38.2023.08.11.10.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 10:47:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Subject: [PATCH 2/2] hw/nvme: Avoid dynamic stack allocation
Date: Fri, 11 Aug 2023 18:47:51 +0100
Message-Id: <20230811174751.784620-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811174751.784620-1-peter.maydell@linaro.org>
References: <20230811174751.784620-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

Instead of using a variable-length array in nvme_map_prp(),
allocate on the stack with a g_autofree pointer.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Using the approach suggested by RTH in review of Philippe's
original patch:
 https://patchew.org/QEMU/20210505211047.1496765-1-philmd@redhat.com/20210505211047.1496765-9-philmd@redhat.com/
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index d99a6f5c9a2..90687b168ae 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -894,7 +894,7 @@ static uint16_t nvme_map_prp(NvmeCtrl *n, NvmeSg *sg, uint64_t prp1,
     len -= trans_len;
     if (len) {
         if (len > n->page_size) {
-            uint64_t prp_list[n->max_prp_ents];
+            g_autofree uint64_t *prp_list = g_new(uint64_t, n->max_prp_ents);
             uint32_t nents, prp_trans;
             int i = 0;
 
-- 
2.34.1


