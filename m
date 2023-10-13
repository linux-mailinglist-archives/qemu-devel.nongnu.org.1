Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 141047C7FDF
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:19:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD6O-0002zY-CG; Fri, 13 Oct 2023 04:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5j-0000Eb-Ng
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:16 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5g-0007kG-M6
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:15 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507973f3b65so1148197e87.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697184010; x=1697788810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S964A9VbqpoT1FNU2LtM4g5Lvu6jdE/CEr94qTHl6bQ=;
 b=XMvBmSHnYgxfIO6FfDsFUeahRgkeuP2OzAT+aIj0oy02bZpGuz/OWaBzUF2s7+tWYq
 vhHslnGm77gZLBUmbN4nYNM+MB9c2YWYVfvxLPHzCs+WfDw/kqd41gmfCvlxQltuNHOw
 UrBWMI+W3aNoVKo/onXxJXatfeNgdTxgam1J7iwnqmBXUvaUD+RhXXGyQd3YWtJ/6PwG
 BioqWYyoXADXmNJtjzI8PvqZj/F/XsVqsGYgwNLJpm7NjKZA4EYnwZc4se+xUQ03xp3L
 fDC5qRHuEKue/0Q7sR2JYEcP8Qes0jYPLDl+XZ7Axu6CrV3sJem3QkqQCT7+5p4MItEn
 7AHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184010; x=1697788810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S964A9VbqpoT1FNU2LtM4g5Lvu6jdE/CEr94qTHl6bQ=;
 b=Uve3jX7TsUfVfFnCCbkuSp68LIHOdsD72qO2d5ASqK9Yma++rPPBv1ExZ8XRdMKVpA
 3Hrj43zKilJaouFJhJl9a5tSl2kwynMFVFDQYQBYggsw4ItOzXvaIkj4nklTi2TYyL3G
 bIg7EUeXpk9XxKxeJBW6RLNCMW8iNrR0wgu0kPBZTdeYVP1sfLGb52d6E59hSlMux7Nh
 mcRxn9xlfRDY3P/KIBPnr+EUafOUHJHFQNa/yRwa1BGYH91amu8CSDcYU5ps6DZXTj0Y
 /SPVlnIojmv2S8A8j7DZffHXAMJx2utQbSkVHQrPBIZbIrHYl4O5wxlSk03VN822+5FL
 zVLg==
X-Gm-Message-State: AOJu0YzPk7lTtR5+JMPgTpibBaisM63GgaTyXa1jc7X4AiE1GUg83URe
 XOS5D6yqgPJYwjd6uak4qJ3MxA01QxIXmL1NNVs=
X-Google-Smtp-Source: AGHT+IGr05zMSk1WzdMk9tKIs354LyVhI5gAZGqLLkHb7vZYm1mJewbA9bmRBKNBBfVmGtuuSgrz4w==
X-Received: by 2002:a05:6512:1104:b0:4fd:d18f:2d93 with SMTP id
 l4-20020a056512110400b004fdd18f2d93mr28929623lfg.6.1697184010597; 
 Fri, 13 Oct 2023 01:00:10 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.01.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:00:10 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [RFC PATCH v2 74/78] hw/cxl/cxl-device-utils.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:41 +0300
Message-Id: <93054ef7101216c752d26bbd4011e612ff67010d.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12d.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/cxl/cxl-device-utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index bd68328032..63f009847e 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -78,18 +78,18 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
 static void mailbox_mem_writel(uint32_t *reg_state, hwaddr offset,
                                uint64_t value)
 {
     switch (offset) {
     case A_CXL_DEV_MAILBOX_CTRL:
-        /* fallthrough */
+        fallthrough;
     case A_CXL_DEV_MAILBOX_CAP:
         /* RO register */
         break;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s Unexpected 32-bit access to 0x%" PRIx64 " (WI)\n",
                       __func__, offset);
         return;
     }
 
     reg_state[offset / sizeof(*reg_state)] = value;
 }
@@ -97,22 +97,22 @@ static void mailbox_mem_writel(uint32_t *reg_state, hwaddr offset,
 static void mailbox_mem_writeq(uint64_t *reg_state, hwaddr offset,
                                uint64_t value)
 {
     switch (offset) {
     case A_CXL_DEV_MAILBOX_CMD:
         break;
     case A_CXL_DEV_BG_CMD_STS:
         /* BG not supported */
-        /* fallthrough */
+        fallthrough;
     case A_CXL_DEV_MAILBOX_STS:
         /* Read only register, will get updated by the state machine */
         return;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "%s Unexpected 64-bit access to 0x%" PRIx64 " (WI)\n",
                       __func__, offset);
         return;
     }
 
 
     reg_state[offset / sizeof(*reg_state)] = value;
 }
-- 
2.39.2


