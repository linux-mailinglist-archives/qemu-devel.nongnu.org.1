Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4627972B6
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:13:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEeR-0004Ow-Ru; Thu, 07 Sep 2023 09:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdi-0003gl-2A
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEde-0007RR-G5
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PgF+PG80iyOuIUfn5Y8pnguhmR9BA/NiFCqaB6x+twA=;
 b=fwxqnZq0M+c6QajCM2hT3gfCYomFw0+R+O4oSc3GRkjhqwa5S9LnKutUhuy2/gjB9iKNfj
 YE3d6I7i168bRBWqSVORXvnyFFkVLVPZzfi7Mr+S4q/Qt7ilXp5FX5kBk5r7yWjK4lZ2+/
 VPQuHlDAMTgPU+kWlolT354uYAAg2VI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-kcit7G3nMQy0SloaBqPzUQ-1; Thu, 07 Sep 2023 09:01:35 -0400
X-MC-Unique: kcit7G3nMQy0SloaBqPzUQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4011fa32e99so6679535e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091693; x=1694696493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PgF+PG80iyOuIUfn5Y8pnguhmR9BA/NiFCqaB6x+twA=;
 b=G+U6apbtMwzWVoLUCZTox5mi9UO3aSJ80mLT29YtioOiORJnCo0fST132j9OgklohA
 vd/cp27R8QXhMRXnXgcgCKW+9tvG1fiEMSLg7tcO7HH83urBnGiyRMxVdtxCq7WABHD7
 1SYuWKPj245OqZxXIuY4n7/dHzR+LWugpQnZM75683WL98hiGuuHtyoINkt3tYjcyG8c
 cyBW1ezDkAV0ViDM9yeIEFDvm/b0XDDmAhruIq9v08uF9tlsMiQvdxZVzE/2CokQIXvF
 X85m5mDRxAuqMfwP4MYZPlVxzJiCoP7dNSWPiB9IK/Yu7QnqzO04GI/nKuPb87wcLVzf
 P/HQ==
X-Gm-Message-State: AOJu0YwN2x7zPC+DVDXb7PJXduDmI0QwoI6NM+xJ7NYc91KwDFYYVpER
 rHFqrdZV+eShgVeo1FHaldZEDYu4kzsOtwZWrZu75ehnkxynuRY82xe2YKWk21H6oMKwCMA8c6r
 /KZ5fppaxG4hxIMkaiVsyDO/lBeWIQxvOYjRaObbQIQPRlqNXgBl3KoRWbZG6TgB65+PTl7MmRe
 s=
X-Received: by 2002:a05:600c:45c8:b0:402:ee67:45d1 with SMTP id
 s8-20020a05600c45c800b00402ee6745d1mr1183840wmo.36.1694091693246; 
 Thu, 07 Sep 2023 06:01:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuhtsM5LG38bfJGbPEQhxHbv1D1I4ec5SJZZifbAh+nliX61UNefx3ehCu2YuC3DroO0ZttA==
X-Received: by 2002:a05:600c:45c8:b0:402:ee67:45d1 with SMTP id
 s8-20020a05600c45c800b00402ee6745d1mr1183826wmo.36.1694091692971; 
 Thu, 07 Sep 2023 06:01:32 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a05600c378500b003fefca26c72sm2493496wmr.23.2023.09.07.06.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/51] hw/i386/pc: Include missing 'sysemu/tcg.h' header
Date: Thu,  7 Sep 2023 14:59:46 +0200
Message-ID: <20230907130004.500601-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commit 6f529b7534 ("target/i386: move FERR handling
to target/i386") pc_q35_init() calls tcg_enabled() which
is declared in "sysemu/tcg.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904124325.79040-2-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_q35.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 37c4814bedf..43413dd1ac4 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -34,6 +34,7 @@
 #include "hw/loader.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/rtc/mc146818rtc.h"
+#include "sysemu/tcg.h"
 #include "sysemu/kvm.h"
 #include "hw/kvm/clock.h"
 #include "hw/pci-host/q35.h"
-- 
2.41.0


