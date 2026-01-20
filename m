Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
Delivered-To: lists+qemu-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2I6NKZvMb2mgMQAAu9opvQ
	(envelope-from <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>)
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:42:35 +0100
X-Original-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5865749ADB
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:42:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGfI-0002bI-MA; Tue, 20 Jan 2026 13:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGer-0001rp-HA
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:40:56 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGep-0006MQ-OT
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:40:53 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4801c314c84so37201445e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934450; x=1769539250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pX41MIA/J+S5uTiA3L6aGtCdymy1tHeIDv8lBddp/TQ=;
 b=CoeS+qGTr3mXDvulK4x2oTD4UTgrCawQJkIJBqsebPeS5OZLSDDwhgjGvZ6Hfdhn3t
 YOyCWjbO9FCHP6LOOg9goEaQqtIpKKsd33/LZ5ESf5pUZdSlQ5hF/bHU5JjjeMUIEheB
 MI/vysI5tu4f3ycL0cC9ZqSJt1TtUBA6Hh6fqEvnN8cA7lO4maMyf6Eeyx2ZRQl3W1mB
 TdQWMA9Ws4zKAoNFBcxaZNrHLnYIoBl0M8VkPBs8+JDK5n6rRbY3T0VX0oWIIMxAL1aC
 LfnbE5M1hml5yt6KKA4Rk4ZmGlKjKKw5eiApUHYCrK+YPoGakHNF3ru61gm6+2bfiBWv
 qQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934450; x=1769539250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pX41MIA/J+S5uTiA3L6aGtCdymy1tHeIDv8lBddp/TQ=;
 b=Sxab6SY+G+2CuTkSyHuIml+M46YxXgjShdjoTkl5pfZwcebQjTy4U8t2vqfz2U7SmR
 7e2vansTC1ylRtfzBec2L4Lr/JKWryb0svxTDhrotpmkNtDXAFFQtR/Pbz3kUd9ZQ5OZ
 ThDeY7vGgrpynr9IuS0rLdV40/ELuoYrsVPw/Q1Adgni/WRaYGefN889U8XSMP99IWB5
 ZeFaXesNcBlf9NdL5PIIgz4qKbjXq5QTsInSvJDYyyqQLUD+vjmn8JdwyjgQi7zMxHXC
 mQJ5CkB4Sug986aqke3bBpSoOM4rrb4TGJxVDKxLRXjUfk0s/yvoSomS79pMkdZ1tVVb
 wOkw==
X-Gm-Message-State: AOJu0Yz7JoiSJopcSRHdMDINJcUvkEAOfWBCmsNyFtWoTchSgJ8T6QPV
 Fxp7/7pna9PMOZ/Rdrr59rNOhj804++CmI6PjfV/+8THT+Ag4q9sW6gwzrxf4g9J55C499ao1i1
 X1yN5rAY=
X-Gm-Gg: AY/fxX5nPCaF7+O4u/EngBabYlEmhEVAsLO6h1yjTMwsbGlDeW6nZ5Arkr5FBbI7Erc
 p6E++L3AZZKb+Y7YWgvCl0Y4LS9UfHvPMmv62pPiEtzQAeWb+j9F4pgt2ebfB5hPopwpFQu6n2+
 SECHsG8o5EBA2nDLZzHgdMl1+u77jFVtWYIWUr25wn2mGmS1GzMM5hBJ2lSmyxV9kh3EhG4C2Wc
 vAIUbMi0C12Q5pS9ZfqapcwVCx2cTIkyJ+ZKnt+gkalPme0UrviXfdIqti5CkkGh/qJLZNt4/he
 Vpl/xtIvCtQ6+oQpwQR7MnDypIuJ5mYAt8SQT3HCGwe4BRl4Y5+uHeKDPYrBEC7doPj9z46m3Yh
 +CDsNjdTCBBb2Rm6/FmQEEGak/tw2XZARO36aA/jXkqlWpPOsqFGMJY5BjLuv7UqSatol7YWcY7
 orinwMhg73YD22TISqIyHxSECgOT1TyZbb7VB6lIt4U7dIZqfw9wwWG/Kfa7VD
X-Received: by 2002:a05:600c:3554:b0:47a:8154:33e3 with SMTP id
 5b1f17b1804b1-4801e34cac0mr189196475e9.28.1768934449935; 
 Tue, 20 Jan 2026 10:40:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921f6esm30225743f8f.4.2026.01.20.10.40.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:40:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/29] hw/sd/sdhci: Rename usdhc_ functions
Date: Tue, 20 Jan 2026 19:38:48 +0100
Message-ID: <20260120183902.73845-16-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
X-Spamd-Result: default: False [-0.21 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MAILLIST(-0.20)[mailman];
	R_SPF_ALLOW(-0.20)[+ip4:209.51.188.0/24:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[lists,qemu-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:22989, ipnet:209.51.188.0/24, country:US];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[philmd@linaro.org,qemu-devel-bounces@nongnu.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[qemu-devel];
	PREVIOUSLY_DELIVERED(0.00)[qemu-devel@nongnu.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,linaro.org:mid,lists.gnu.org:rdns,lists.gnu.org:helo,bme.hu:email]
X-Rspamd-Queue-Id: 5865749ADB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bernhard Beschow <shentey@gmail.com>

The next patches will introduce eSDHC device models (big and little endian).
Prepare for that by renaming the functions. Also, this makes the code have
similar conventions as in Linux and U-Boot.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260112145418.220506-8-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 779f411babe..531dd3c2911 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1659,7 +1659,7 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 #define ESDHC_PRNSTS_SDSTB              (1 << 3)
 #define ESDHC_PRNSTS_CLOCK_GATE_OFF     BIT(7)
 
-static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
+static uint64_t esdhc_read(void *opaque, hwaddr offset, unsigned size)
 {
     SDHCIState *s = SYSBUS_SDHCI(opaque);
     uint32_t ret;
@@ -1673,7 +1673,7 @@ static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
         /*
          * For a detailed explanation on the following bit
          * manipulation code see comments in a similar part of
-         * usdhc_write()
+         * esdhc_write()
          */
         hostctl1 = SDHC_DMA_TYPE(s->hostctl1) << (8 - 3);
 
@@ -1716,7 +1716,7 @@ static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
 }
 
 static void
-usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
+esdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 {
     SDHCIState *s = SYSBUS_SDHCI(opaque);
     uint8_t hostctl1;
@@ -1872,8 +1872,8 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 }
 
 static const MemoryRegionOps usdhc_mmio_ops = {
-    .read = usdhc_read,
-    .write = usdhc_write,
+    .read = esdhc_read,
+    .write = esdhc_write,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
-- 
2.52.0


