Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 817BC8328F5
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:37:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnBG-0004on-7Z; Fri, 19 Jan 2024 06:37:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnBB-0004HT-9Z
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:36:57 -0500
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnB8-0002t2-6V
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:36:57 -0500
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2cd8bd6ce1bso7131971fa.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664212; x=1706269012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGnKshp2dblbP34WXgQWGaL1yrp+GbmQPwxQyTF5AbQ=;
 b=Ad8LJFtbUR1zTKQ1LibiGOkAabxSdds05YJcqJ6KCS3xqkDajw+nwIqOdnlG9M75Oh
 Y/1KgUZ8aOQ66J9uNt2U/9VCvP5h4oRR6y4EdKJxNHdM71P4AC/4eiB9rmqk5XwHTuzh
 ncZfF3RdT/tQDyqdh/kWSby7jyIkDnSACF9+7PGCN6wexK9QJYkuu5LSJbEY6eERC50k
 9Q/U7G3abIiOyZlt8HjRLQEpG0XchwMj5BqJqQLbTSbvYVGTECyu2USorekfKcsp3vgu
 uWx5aQU5NJa+P/L5mAvCTaSa1pYBMiAVihGVBKJFrApxU2FFDAW9unePCTu7pgCahSSY
 aL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664212; x=1706269012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGnKshp2dblbP34WXgQWGaL1yrp+GbmQPwxQyTF5AbQ=;
 b=PichCJiPwFrRlZqu6AVKDeobHaCnqvroZtQqU77aoRgkjwzGRjDb6f2XG+Xz/1P6Ex
 y8CCBTVCnsTi2eUTOBT82Rb50BfN/IQnzeCIBCiys0rvOhAF5rpl2l5RJZ4KUsn+VB/Y
 1+HrW6eSgkZtAdWQzymkfdcBVXUfM5P+Jr1K1qau/N+EGgUEBcTXARlZXGRjli401eO0
 x3bXw3eEtA+EklREN+Ioublt17RBPRIbtortv1Ydpav8arMicesH6CkturmPLQKwa8Cs
 GPfRMwmTof48ItkDeZ9/FnjfhKuqtxazi+C0WE8GsQ93IVfeKG4PUKS6i2xppz8QeoP9
 FWCQ==
X-Gm-Message-State: AOJu0YxF9j6q4R+/2j8Qs9wmaQUKKreUpzjDWJMyTh79blG5W2pqZbNp
 qPImgb5X3cVSDOK8hptzNkHCA3au+N2E+NLfxEPtmpxC4tbrz38p+NVYfdjrl5/4aT36SseRZ3c
 Ub0efHA==
X-Google-Smtp-Source: AGHT+IHp/sfs1aEoFmD2LC2DD95HHoHAxn2PDd5kzZVzVFHST26AZ1HnCyEkid8KB1bVCXY2somhMw==
X-Received: by 2002:a2e:7802:0:b0:2cc:da2a:d266 with SMTP id
 t2-20020a2e7802000000b002ccda2ad266mr1006821ljc.71.1705664212183; 
 Fri, 19 Jan 2024 03:36:52 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 l9-20020a056000022900b00337d980a68asm1941011wrz.106.2024.01.19.03.36.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:36:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 23/36] cpus: Restrict 'start-powered-off' property to system
 emulation
Date: Fri, 19 Jan 2024 12:34:52 +0100
Message-ID: <20240119113507.31951-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
References: <20240119113507.31951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since the CPUState::start-powered-off property is irrelevant
to user emulation, restrict it to system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240111161817.43150-1-philmd@linaro.org>
---
 cpu-target.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/cpu-target.c b/cpu-target.c
index d51adfd7e3..f6e07c3deb 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -204,6 +204,7 @@ static Property cpu_common_props[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+#ifndef CONFIG_USER_ONLY
 static bool cpu_get_start_powered_off(Object *obj, Error **errp)
 {
     CPUState *cpu = CPU(obj);
@@ -215,12 +216,13 @@ static void cpu_set_start_powered_off(Object *obj, bool value, Error **errp)
     CPUState *cpu = CPU(obj);
     cpu->start_powered_off = value;
 }
+#endif
 
 void cpu_class_init_props(DeviceClass *dc)
 {
+#ifndef CONFIG_USER_ONLY
     ObjectClass *oc = OBJECT_CLASS(dc);
 
-    device_class_set_props(dc, cpu_common_props);
     /*
      * We can't use DEFINE_PROP_BOOL in the Property array for this
      * property, because we want this to be settable after realize.
@@ -228,6 +230,9 @@ void cpu_class_init_props(DeviceClass *dc)
     object_class_property_add_bool(oc, "start-powered-off",
                                    cpu_get_start_powered_off,
                                    cpu_set_start_powered_off);
+#endif
+
+    device_class_set_props(dc, cpu_common_props);
 }
 
 void cpu_exec_initfn(CPUState *cpu)
-- 
2.41.0


