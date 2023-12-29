Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8C18201B8
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:29:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKL6-0006s8-QI; Fri, 29 Dec 2023 16:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKKv-0006rC-Au
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:10 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKKt-00063m-Pp
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:09 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso5598121a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885046; x=1704489846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nyDvxTucZvevaETcjw9mADYnujp4cVpiY3zTBw5hjb4=;
 b=ZoCG+U075binTMh1vSNKOUHcZQtIT1CwnyLr3n1qPiDAJ2UWPP8O7f0FP+dy18Xz2V
 VIgb+jHp6oN3HvjZFlBg+KYlMUb1n3sbdFWVsoWLleJ8h8+j52EahEPZ2R3h0QEMZgZC
 bc8t2lPki3S0Xw2UIeJX+pjxy906iMqp3gcRaDzWjubXZJxhTjpaXgSIin2HFe9ERZgo
 sFM6rsqrl8wljFkNWRmqIkyBVIfn749vjH5NoN0puDAlhog5KdQoAHmG4/7Z10itphdn
 U7/I9dzSQrJxQx2t8/valMt1ugOeRMEtIxZo+FWA7n5TeGSmqvjm5dB4nc69hQLbKZYb
 PTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885046; x=1704489846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nyDvxTucZvevaETcjw9mADYnujp4cVpiY3zTBw5hjb4=;
 b=IQPi+N+9C1r6tMgdwvSK6JTwn5x2YrryCyXk6/aIyjtDP/dnyIjxODkRwgHfNuYjTJ
 PJDNEehsJmcT52PVokZd8XXrZyYtAN8Y6ikiTG+xREGscgHCzlbYQHR5Jt9goWq2jbUa
 BkRVMQupSYRcIQ75H7IMYSF6f9OVORH9rmVDzGaoVJxPaFP4p6zNI2oS2tW8AhtaZpuo
 O9QXMgB03zeAMVNx0lbgd1WghK0nl9BIP21EpWhR0cSl3BtFTpYjSxEvUUUgWAB8i1X/
 A0g1pyh/jsHYng94RfaLtIjSnDWoAnkTjUTz66/A/3OjheFjsMWg0thEQgixV/bEPYdb
 5g1Q==
X-Gm-Message-State: AOJu0Yy9eEkjFvEagPnYhK3TM0gxC/2s/s2Ds5+ysoHjPu5ycccKryC5
 bn+CVm5rA+6tIeKOMj9GiG12qirwTP4uo9MewJSZpgmHRIUB0w==
X-Google-Smtp-Source: AGHT+IEAkPQLkGj5MU1S15gXvToQ+Qy5tHjJSK5h/4sM0MQkIZDN2xNdkRfCrLN5yowWNtHDj1c0fQ==
X-Received: by 2002:a05:6a20:5518:b0:18d:64a:e125 with SMTP id
 ko24-20020a056a20551800b0018d064ae125mr12740578pzb.31.1703885046375; 
 Fri, 29 Dec 2023 13:24:06 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/71] target/avr: Constify VMState in machine.c
Date: Sat, 30 Dec 2023 08:22:40 +1100
Message-Id: <20231229212346.147149-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-6-richard.henderson@linaro.org>
---
 target/avr/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/avr/machine.c b/target/avr/machine.c
index 16f7a3e031..4402862fb9 100644
--- a/target/avr/machine.c
+++ b/target/avr/machine.c
@@ -100,7 +100,7 @@ const VMStateDescription vms_avr_cpu = {
     .name = "cpu",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(env.pc_w, AVRCPU),
         VMSTATE_UINT32(env.sp, AVRCPU),
         VMSTATE_UINT32(env.skip, AVRCPU),
-- 
2.34.1


