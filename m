Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D166779678
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 19:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUWEx-0006sh-SD; Fri, 11 Aug 2023 13:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUWEv-0006ph-Tt
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:47:57 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUWEt-0004sp-6T
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:47:57 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so19470435e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691776073; x=1692380873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUNteQvgR3E8lX/9Vp45LmheRy4aUs7Y6HorDACkRHc=;
 b=g6fyV97VBEnAZIa5szB/mnicPfolMnO5ooGK62SATPcrM1kdhem4BXj4B7ACOkWlTU
 CJirQpWHiDVKwKFYpAp/YAWCCv+WALwT1d32oHUhg9AomnDRgWTUbp0nDXDoMVgd3OeZ
 gJQNKAPBnNJ3t1wFHEGWES0tZLLzdoAO/+uJqaJNtVkJ7rO8z/jVoZQHSIx5Qw1KJEIA
 6l5ISWS+haF03sX7mge4DZXaC8va6dGHm4vB1cmYUyKzjNt4hdlDk9OCGAwOdGgRZyoM
 1sDli3ep2MLzkpY8+SAZbfnv8m1agucw+nFKf+GtJnXZ0NAPtjLDyB/24k4phbommW0s
 MjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691776073; x=1692380873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUNteQvgR3E8lX/9Vp45LmheRy4aUs7Y6HorDACkRHc=;
 b=QnDzs2togzfswGlzr9ZDxmJ60AbM6Vb8SbUDYoaaMTytsCFdfpi03Xj3quoaPlxx79
 w37wMKO+SiMMyubkRzG267KTAPy3aifyAzHryayL2VjMlm+0qMv3o2WFu/IuUwT7GNay
 SeUHu4qdOv/4Qv0vKFULdyUjvrgPpJzp7Bwz0wxvL/vKi0IDstD2IZ93jKYu30GtahLT
 2S/tAC+JtTMv65riIVsonJ3Ieit3ryK/NcjoT1lzRtJIyGNNh0dSIgThJGzgw1hQ8k0R
 zHYwuvHwNAb542aUSKDWitIRlzlpGlmFWF5P4fYe9LztDMifr5hOfIguODP6JMQvwE0x
 f09w==
X-Gm-Message-State: AOJu0Yz0UR5Xb1J8hriitlJfhHS718Q+hbTW1mbbcrEjJ9L/+2cwHzmD
 FwR7X+xrLF69dkMz41x7Um9oUdG6MBSy38FPacc=
X-Google-Smtp-Source: AGHT+IHcegjsn1uQCtJQMVT+s5ZcAimmETetYdW5xuKg5OxhNNL9EIqW1IBk3pIssmLiuIRM2nChbA==
X-Received: by 2002:a05:600c:2258:b0:3fe:2f80:8394 with SMTP id
 a24-20020a05600c225800b003fe2f808394mr2145912wmm.15.1691776073585; 
 Fri, 11 Aug 2023 10:47:53 -0700 (PDT)
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
Subject: [PATCH 1/2] hw/nvme: Use #define to avoid variable length array
Date: Fri, 11 Aug 2023 18:47:50 +0100
Message-Id: <20230811174751.784620-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811174751.784620-1-peter.maydell@linaro.org>
References: <20230811174751.784620-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

In nvme_map_sgl() we create an array segment[] whose size is the
'const int SEG_CHUNK_SIZE'.  Since this is C, rather than C++, a
"const int foo" is not a true constant, it's merely a variable with a
constant value, and so semantically segment[] is a variable-length
array.  Switch SEG_CHUNK_SIZE to a #define so that we can make the
segment[] array truly fixed-size, in the sense that it doesn't
trigger the -Wvla warning.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
[PMM: rebased (function has moved file), expand commit message
 based on discussion from previous version of patch]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 539d2735531..d99a6f5c9a2 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1045,7 +1045,7 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, NvmeSg *sg, NvmeSglDescriptor sgl,
      * descriptors and segment chain) than the command transfer size, so it is
      * not bounded by MDTS.
      */
-    const int SEG_CHUNK_SIZE = 256;
+#define SEG_CHUNK_SIZE 256
 
     NvmeSglDescriptor segment[SEG_CHUNK_SIZE], *sgld, *last_sgld;
     uint64_t nsgld;
-- 
2.34.1


