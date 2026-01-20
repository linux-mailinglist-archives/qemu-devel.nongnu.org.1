Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
Delivered-To: lists+qemu-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADtdHI3Mb2mgMQAAu9opvQ
	(envelope-from <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>)
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:42:21 +0100
X-Original-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E89D49AC5
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:42:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGfF-00020p-Th; Tue, 20 Jan 2026 13:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGek-0001lJ-A0
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:40:52 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGei-0006Lw-SQ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:40:46 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso54007955e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934443; x=1769539243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8/8EVFYZXMFuk6VWmUP64vs2hU05CO6vz8Wwm+fVrOk=;
 b=TBsA9neE0MQGzM2TKRc+CzVvRRwtKirrmKxato5zKdpXv4JsD3VnxfwMbsOEWs4c3n
 yhto7VqYOmT359PI9N2K23/sb2po1CHdRtzV8ukixC+0mEjExyW+Mvg52bxkZnOWlx4L
 kwx16Ocyq24j+qzlKHqWJjp3xdbclggdM+/tFuLdYm6ODAvj7vQRrT+IQgfrNEb1RKGu
 ttunH7HiT4qw1zVSo+bfngtOGFMUi8gARzJciOrjcxm4b9HyHJiXK9wo1hDoBwj9w6Wi
 SqXcWzwex2wIQQiLY7EAkgQlGEui+l9PySGGfX3uJGzrtdc/lLYqpKnGoIGx+OeCOfQk
 dEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934443; x=1769539243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8/8EVFYZXMFuk6VWmUP64vs2hU05CO6vz8Wwm+fVrOk=;
 b=b7iZxolVLf14Cxi+p9CdcCOhmaJuPCMNdhYuHo/gLSnSzdoxg4V5Cqcte7SjLfDW5+
 uGUgDiYe4AlPjng28DHrmUJNMGqGtdXBUML9Xfww3553mVKrnfTvFGcg/8vQEjVxJVhw
 uGS0rfXYwIcjsS0ul+XL5pF04/6uin+Q9Zu4ayz2Zhx6wSfBFJ/XWtQX3gUujGdvv8IX
 HpY7KODuEJYO9Xc53zJ6/4UKH82CziPVxAhUvmJT7Gi2XUGSLqOPDmiktvQevDVUe9k6
 JwfO15uY+68LvY/C9PHZFZiglmhWGPhvW6v4+pDYfeTrOirTAGCVDywOcsRzRJ1Bjaay
 QznQ==
X-Gm-Message-State: AOJu0YyanjoHtWekqbXxBl1bPLflX+1EOOt0eSUTrqJtQN0nAoxYB7ni
 2VnxcR/aojC0SfadeL3EG12kliYjateliff7k6By+J5+KGoXr6vE0u0qJ6B6rcDy2DACalWBkRJ
 T3mqy68U=
X-Gm-Gg: AY/fxX4p731rz2Pgsa0dOTUQ5+cnvKt0rTHfxt8EFTyEVF/KrgmA33/26ZR2KVINxsT
 wXkJZXh7W4bd0HFzNspPCU6kYLQ84DhtoKTWXQKt8nDINksrPZzYPe5oUTDlgRCrSTT3R/hH7FH
 hYZ25E/bAOoFzjH4DpDMYxAnw5S7nj0wcFXZVp9XZUZGqYc6ZokriWchXlv7uv2zAWyY7GUk6Ye
 77SZApd++spNm7GFxg7uGpQwnPHhvV+q4OR7dBUmXXGrjJ9S31NEGw2pJEZ4672tZVUWgqYw1hw
 Rm5jtICY/72/tawU2hiCsJiS8dtsMcNTRfqFaxHzxfLLnnAoT19j8//2swelHCSf84s6NzAU5J2
 L+zanJJgzWyhzKCpV7cG7e7OqKqs1IQ49Ibk5HBDkgf20CM2YestuIVegsL6j4YI9FymD+iWkIO
 FHh0NeEXVrUXz3vc7O67T/YzQEmp7pecrFUvvJUEgxwYLiULGhjzkHB3hjwnVvLKUIA9zE2Lk=
X-Received: by 2002:a05:600c:1552:b0:47e:e946:3a72 with SMTP id
 5b1f17b1804b1-4801eb0e021mr198656835e9.27.1768934443034; 
 Tue, 20 Jan 2026 10:40:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8c05c3sm254264795e9.11.2026.01.20.10.40.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:40:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/29] hw/sd/sdhci: Consolidate eSDHC constants
Date: Tue, 20 Jan 2026 19:38:47 +0100
Message-ID: <20260120183902.73845-15-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
X-Rspamd-Queue-Id: 2E89D49AC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bernhard Beschow <shentey@gmail.com>

Drop the "IMX_" part of the names since these are actually {E,U}SDHC
specific and apply for PowerPC-based SoCs as well. While at it
consolidate all ESDHC constants into the ESDHC section.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260112145418.220506-7-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci-internal.h | 1 -
 hw/sd/sdhci.c          | 9 +++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 3e81821dd1e..f24532eed28 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -75,7 +75,6 @@
 #define SDHC_CMD_INHIBIT               0x00000001
 #define SDHC_DATA_INHIBIT              0x00000002
 #define SDHC_DAT_LINE_ACTIVE           0x00000004
-#define SDHC_IMX_CLOCK_GATE_OFF        0x00000080
 #define SDHC_DOING_WRITE               0x00000100
 #define SDHC_DOING_READ                0x00000200
 #define SDHC_SPACE_AVAILABLE           0x00000400
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ccdfc59af85..779f411babe 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1642,7 +1642,7 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 #define ESDHC_MIX_CTRL                  0x48
 
 #define ESDHC_VENDOR_SPEC               0xc0
-#define ESDHC_IMX_FRC_SDCLK_ON          (1 << 8)
+#define ESDHC_FRC_SDCLK_ON              (1 << 8)
 
 #define ESDHC_DLL_CTRL                  0x60
 
@@ -1657,6 +1657,7 @@ static void sdhci_bus_class_init(ObjectClass *klass, const void *data)
 #define ESDHC_CTRL_8BITBUS              (0x2 << 1)
 
 #define ESDHC_PRNSTS_SDSTB              (1 << 3)
+#define ESDHC_PRNSTS_CLOCK_GATE_OFF     BIT(7)
 
 static uint64_t usdhc_read(void *opaque, hwaddr offset, unsigned size)
 {
@@ -1731,10 +1732,10 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 
     case ESDHC_VENDOR_SPEC:
         s->vendor_spec = value;
-        if (value & ESDHC_IMX_FRC_SDCLK_ON) {
-            s->prnsts &= ~SDHC_IMX_CLOCK_GATE_OFF;
+        if (value & ESDHC_FRC_SDCLK_ON) {
+            s->prnsts &= ~ESDHC_PRNSTS_CLOCK_GATE_OFF;
         } else {
-            s->prnsts |= SDHC_IMX_CLOCK_GATE_OFF;
+            s->prnsts |= ESDHC_PRNSTS_CLOCK_GATE_OFF;
         }
         break;
 
-- 
2.52.0


