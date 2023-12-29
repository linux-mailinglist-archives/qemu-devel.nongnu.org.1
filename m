Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 875598201B0
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:28:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLA-0006vt-Ij; Fri, 29 Dec 2023 16:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKL2-0006t0-HZ
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:18 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKKy-0006J4-K6
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:14 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5ce74ea4bf2so353316a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885051; x=1704489851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qey0fjhrVWPpPqjaLWiAWIvGaxQY0g0jcM6s2r3zWX0=;
 b=Gjl1j3+Zu+BpkYS5vXp7qvAYJ0f0PZOQxiNO98CW0qm74qs6LjR05WtwIGLFvSN0Dt
 2X7PTrq6Ddtabzqydz2CQ3rVkybC1jRPgwEDZeoIem5aU36O6MrXvJ7Hi1kgRQfZ3yMX
 VryxzfAje8U6d1xeC6oe9+HgTTXG/kAVuw5mwzFnttuZX4u4X1SMhzfXwxjZ2rBVSwai
 gznxlYt1WnEu5YuJ6lN3AieKE1aSmmpnv9FXHlTU5FxcOPMDTySSvjfxDn05RUCIJTwU
 kf7DB1Tq5U989CwBcoPuDKHHARpLmgGf91OcqZaaaszyi7tSsu8C0pDkrxT0VQH6r5Fo
 lKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885051; x=1704489851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qey0fjhrVWPpPqjaLWiAWIvGaxQY0g0jcM6s2r3zWX0=;
 b=X9PR/P+DZvHdNJIBj4AdzohsAb5UjqXDySei1PUnKAfgBxbwdTJpHfH6b9O5D3ICpL
 GO/Vqci62OvQZxQrjqNA5qveo0Rw+atov42JiVfJgj+9R10xIYrlFa8qTkAI3EqD8wLF
 D8s8dgpL67RV/2SnCxhWmzE9DoDnP9p3oJHPLCTSko6lP0KiUUu4fub6ds8GiTJUhg9D
 sLO2NfEOHoPdNcitVgs9zLkYZ1nmnt06yd2+oXNoUULtBt6YufWLw+kyACOI8M/vRNF8
 pg33ldMQBvIc5PS0d7ihK+564WP4mdQOfSKs/Vclm5UN/NfVtTL5oT3mfTDUfmQjLObz
 OmTQ==
X-Gm-Message-State: AOJu0YyDOAkNU7apZAoV+5E3GciM68Z5DG26+X+c2zP/BJBg5KFUxi9c
 lqWW1sddYXoI/BuUoZbRzd0a0Zi+kcSN97qCMotn90vX+OmK/A==
X-Google-Smtp-Source: AGHT+IFEZL9zTlInXrPFwPedWw7GadviktjR8oV56wPhMDE/3n6umytT9rDhiQ6UVfgMdGaI6DGQXA==
X-Received: by 2002:a05:6a20:9390:b0:196:a796:4a58 with SMTP id
 x16-20020a056a20939000b00196a7964a58mr328595pzh.32.1703885051028; 
 Fri, 29 Dec 2023 13:24:11 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/71] target/hppa: Constify VMState in machine.c
Date: Sat, 30 Dec 2023 08:22:42 +1100
Message-Id: <20231229212346.147149-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-8-richard.henderson@linaro.org>
---
 target/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 15cbc5e6d0..211bfcf640 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -201,7 +201,7 @@ static const VMStateField vmstate_env_fields[] = {
     VMSTATE_END_OF_LIST()
 };
 
-static const VMStateDescription *vmstate_env_subsections[] = {
+static const VMStateDescription * const vmstate_env_subsections[] = {
     &vmstate_tlb,
     NULL
 };
-- 
2.34.1


