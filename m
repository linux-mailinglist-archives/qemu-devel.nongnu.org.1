Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B65C70D19F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:47:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I2v-00044o-VW; Mon, 22 May 2023 22:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2d-0003Wk-W4
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:28 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I2c-0004kQ-El
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:46:27 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-253340db64fso6281109a91.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809985; x=1687401985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fB3pJeeWuuS9kbphHugRAauKE7v/4ZOcuHnfKDbWEJI=;
 b=UDUS8XU8hgk3DauES++FVWzCJDuCVscyr6uAQSoLVt6zy1UiHJ/BNUjoyhF28JvgW3
 6RBQnX5BYTTsd0tAF8RGYAyXDogJ4bNoR91/KIZB0F6d+sOGZ7xeOJ89/aof3humLSrt
 n+OvT8V/W1HnglfGdW1vq3H0aVLHWksth7tbK3Y5DIEm5Y6O2FDJHaTViu5T4FwRJZRd
 ejrsueRFECgP6O3EVxGKQlULVbtNEVart9dsx5qn+XQ9b+1DUchC/Xhy9DpASnXyv4dF
 2YyhOGZ8B6cY9P/vrTn8pxdG0L2g5iJnHR3YkLpUZk4J50W604wk6IVR2P/3njYA4RqE
 Ev0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809985; x=1687401985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fB3pJeeWuuS9kbphHugRAauKE7v/4ZOcuHnfKDbWEJI=;
 b=lZfwz9crKdWAp4qyB66CSTrx+29IBA7Quz6/5zdiOPePyuGSxBcqFThzsfbnEMITg9
 F98GJMUS2+oLYFCVnjN48bG+hw/xKy6FluYl0BE9WVAwXKmwjIrer/o8NqCgqWijeQQz
 Ym2H61xWWbSIgRKTwUDUz1JYQGig4UtsvWhhhWMi+Qxpya0/hdc9V0oBQiG7uJEqN2K/
 4hBlRePfnnDcrxYhgc+nGn3Xfdw0ZTO7dYdkjJAwocweVtPlvClFrc5GpAggcR2EHvUg
 NfsYHhMKjpCP2ibhalVpTfEO+sc9PErbIGl+6Oh4Oh2ApeVNFrOqFQJ7Lea1vNZFzF2u
 o/+g==
X-Gm-Message-State: AC+VfDyI5BqR1aPzrS+BNusH7SI7yCqk0Zh13nakuQ6v/Fgcpza1l3+f
 RjkSuy3yBhi79x2ntUhdS0BJ4A==
X-Google-Smtp-Source: ACHHUZ42xaJAatQT7gby+UXhbdp+5LZMDMwrj73bWwLhn/1gPQ8kKT7B7Gy40hcJJ8pKFOILFPVEkA==
X-Received: by 2002:a17:90a:e505:b0:255:58c4:fbae with SMTP id
 t5-20020a17090ae50500b0025558c4fbaemr5796197pjy.10.1684809985027; 
 Mon, 22 May 2023 19:46:25 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:46:24 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 45/48] igb: Clear-on-read ICR when ICR.INTA is set
Date: Tue, 23 May 2023 11:43:36 +0900
Message-Id: <20230523024339.50875-46-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

For GPIE.NSICR, Section 7.3.2.1.2 says:
> ICR bits are cleared on register read. If GPIE.NSICR = 0b, then the
> clear on read occurs only if no bit is set in the IMS or at least one
> bit is set in the IMS and there is a true interrupt as reflected in
> ICR.INTA.

e1000e does similar though it checks for CTRL_EXT.IAME, which does not
exist on igb.

Suggested-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/igb_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 823dde8f28..d00b1caa6a 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -2598,6 +2598,8 @@ igb_mac_icr_read(IGBCore *core, int index)
     } else if (core->mac[IMS] == 0) {
         trace_e1000e_irq_icr_clear_zero_ims();
         igb_lower_interrupts(core, ICR, 0xffffffff);
+    } else if (core->mac[ICR] & E1000_ICR_INT_ASSERTED) {
+        igb_lower_interrupts(core, ICR, 0xffffffff);
     } else if (!msix_enabled(core->owner)) {
         trace_e1000e_irq_icr_clear_nonmsix_icr_read();
         igb_lower_interrupts(core, ICR, 0xffffffff);
-- 
2.40.1


