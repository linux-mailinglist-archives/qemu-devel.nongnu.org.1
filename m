Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
Delivered-To: lists+qemu-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI1CEEnMb2mgMQAAu9opvQ
	(envelope-from <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>)
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:41:13 +0100
X-Original-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F415949A22
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jan 2026 19:41:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGeW-00013Q-26; Tue, 20 Jan 2026 13:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGeL-0000Ju-4R
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:40:23 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGeJ-0006Id-JP
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:40:20 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4327555464cso3010241f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934416; x=1769539216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9H+ku3kicwpTVsDL+ymVANL2vQb8RdWLt/npWzFJonM=;
 b=WxiobAT7k2bfLR9wGulSeQHUvsqUXvY+vW2IFQWPE6Og2zn8pxMsyBdn4F8AArE1RC
 yG/xEOxuWOFwB054cCVrb3V3zJ+Q65y2YaD33GGG7Wx8xkLXKcIx66CpKi8/VuzlgNvQ
 8W6qfSlrYuKLqxJXfZbKEsHQ7hj5tW7o97e/QLjM6tJE4KhpOJAXukfmtL4RXRlFGsuV
 g/7ADaFU7z3nO/s4aVVBDs9vaO4qGowRlimR+RTXIDDKlTy2+Pgj6I4btkyF9m1mTPuC
 ZQ2mcPlkSb+kj9zINIz3WZP16GbI/vzhst8qOfQS+SRAEGzLu5v+DUh6Ll1x5OPGJbQ2
 TEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934416; x=1769539216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9H+ku3kicwpTVsDL+ymVANL2vQb8RdWLt/npWzFJonM=;
 b=jiXiEgRIA2xtwd70n6plp0wlZP70Fgcpir4MC7SVqyBKWeqgWNXuXNRl+5bpEseyXq
 wGvdmXxBvKUtKM4Lzvp3kz8HJUObYx4mN8Ay0X1HeypSOobnReHrG7MnfOMC1gG5HdPq
 m2rVsj130Tv6p+SgtAuCc5F0Vu23tT3xMJQCu1zMRAXclH9/xDR3x005Dk5nudN4aCFC
 jAJ4JwssLoUQ8yePrjH2BWbyqX4Wagt0M2zh91Qld+Re3dZgmKssa7OGOnZ/MqrSX66d
 oYvLvZFucglLaMLYZQl+3BNWEEzA7AkUC6PNSLpViXNmpmMQPJ2L7DCzB/lNs/5CZEpJ
 Wm0g==
X-Gm-Message-State: AOJu0Yz0Xd++2h5/f3Rtt5s/tn5JD/Lnvnsu7giv5dq31bSHlAsHU+jq
 0OOnzo99AEY5UI/RN2rqS2ZhT1Fz8zpu5bkqXouAe6hjyAsSn8iH1Qi+OWSbld3eXUbRpyW+QCj
 hVvZjPJU=
X-Gm-Gg: AZuq6aKUXbI09oaPlAnFW27+Dm5o4Y0ToxTzPO47QGOWonO0WD3szXtrr9K2XGGwP/J
 BT50+GQEYMFXjlXaRxl/DyvIoQjMnz4CJH3Yd5BsWWMM/bw7LNwGIr8tcSFXUHFggu/PbOO46Lo
 fLTiiaUjCNY8yjxS+bMMCkhmYp2AvuiqseBY6fhKsg10pZ7/oCP76+sCnIWdIfZvJ/BZu34V6Kf
 Alwo+Vw2ZQXceSoCfz/B7b35EMIirLW9WY2X7IZJ/1bucTR5EsuXc/DzJt0YgOWD072HBbxihIW
 k5ayfMN+eOghktxtzQbFlnFyf30yGuERn2aGHv5NmB58wsb+rrrmR+aB3EmY2kP2jjlxVE4zAIq
 73fzM7RRNIkk9KOQMA/RL5wVeUH3+7AGV1VP4V7mx6ILN+QbkeP2fLWh2708rbI3DKRSZJXk86W
 E3L+3NUugZsDOBt9GTjaToxbYsXCVGxOaYWlUmoGNb/aJqnL/m3vGB7t7dDtnc
X-Received: by 2002:a05:6000:40c9:b0:432:851d:35ef with SMTP id
 ffacd0b85a97d-4359017478bmr4363207f8f.42.1768934415417; 
 Tue, 20 Jan 2026 10:40:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43595609c8asm2869271f8f.34.2026.01.20.10.40.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:40:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/29] hw/arm/fsl-imx6: Remove now redundant setting of
 "sd-spec-version" property
Date: Tue, 20 Jan 2026 19:38:43 +0100
Message-ID: <20260120183902.73845-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
X-Rspamd-Queue-Id: F415949A22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bernhard Beschow <shentey@gmail.com>

Now that TYPE_IMX_USDHC sets this property internally it is not needed
on the SoC level any longer.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260112145418.220506-3-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/fsl-imx6.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index f3aa1d81501..46967b74882 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -323,8 +323,6 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         };
 
         /* UHS-I SDIO3.0 SDR104 1.8V ADMA */
-        object_property_set_uint(OBJECT(&s->esdhc[i]), "sd-spec-version", 3,
-                                 &error_abort);
         object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
                                  IMX6_ESDHC_CAPABILITIES, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
-- 
2.52.0


