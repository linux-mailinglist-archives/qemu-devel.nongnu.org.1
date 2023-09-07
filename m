Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8B7797293
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:07:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEeY-00057o-Cz; Thu, 07 Sep 2023 09:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdj-0003sW-Pp
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdh-0007SR-EK
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnS6kpClTYzSsSYS2ANTQx/6JTtxTxc5WwCUea/91dA=;
 b=EHaO1mm8JnPB/jNqccufYvV9hU3021Iv43aejodScqYR2hwJd4YBRDvpSjHk8PvH28jwYO
 Jtk9GIalYe1TpJ6MDJ0Qagup5CL8ONy8tfYLCgFtYe1hrx2NTehQyDhw1AlsOdcvzGy+n/
 jrTBEqcCyNDT1Pg4o6AS+jOqmfPdvvw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-fBhRkRu_ORWjz22ExgsuOg-1; Thu, 07 Sep 2023 09:01:38 -0400
X-MC-Unique: fBhRkRu_ORWjz22ExgsuOg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-401c19fc097so6611805e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091697; x=1694696497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CnS6kpClTYzSsSYS2ANTQx/6JTtxTxc5WwCUea/91dA=;
 b=SIeVFItEn/o8GORbYUvTqfCO5MjVuBO2iYT2tABD6Og0nDd4Xj6gWKNk/tjFurtj5Y
 6X9flav/tV6mr88IZiH7ZcGCCpgHc/t5MGypGpTAjMluefif6dUT+0CSTKOiuyecW7RO
 2Q6hEPfhKqtqLD9Ge2i2il0mSUqXksD/87SFnSzmlWyYay8Kz6beErkMsJtUXMWQb33f
 VD9BOCf0tW5aS/kg7cWVFXubxtI+jcKhsuxVC4IUFgXqeJAcZNJnyjJ1Jua4n08sp9V/
 RA7pcqUhdnCfBgpiSYnI3BwXio5ANb6hJqeISjWtaK1JoY467C6CqI0rLuqXq211z3pQ
 aoeQ==
X-Gm-Message-State: AOJu0Yy8JkEpfS0b1MXOjPD3vHHIJ7usaQd8nKaLTVHZXRRUtVVTc9Sk
 dXR1lDP9HG+tzhCvAdTxQ0jx+BJS92joG4p7aWSM0JbncT9XWIO8dA9Pbcel6zSrlD9vXLuY2CF
 OElM8paOnPWEdJYRBqVfDBJFmprQJXpmR18Y8tIpmN+YE+w87E/w8yZ4IK4QpBHqZGhM9z6dbf/
 I=
X-Received: by 2002:a7b:cd97:0:b0:401:c944:a4d6 with SMTP id
 y23-20020a7bcd97000000b00401c944a4d6mr4510546wmj.28.1694091697251; 
 Thu, 07 Sep 2023 06:01:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN6D55okrC2bHuKtz5+ID0fcdbiMVH11CrMv6zXhpyqFtEth7GADN9gXgEtjKB3RQM7MM2pA==
X-Received: by 2002:a7b:cd97:0:b0:401:c944:a4d6 with SMTP id
 y23-20020a7bcd97000000b00401c944a4d6mr4510531wmj.28.1694091696931; 
 Thu, 07 Sep 2023 06:01:36 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a1c7508000000b003fed7fa6c00sm2516617wmc.7.2023.09.07.06.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/51] hw/i386/fw_cfg: Include missing 'cpu.h' header
Date: Thu,  7 Sep 2023 14:59:48 +0200
Message-ID: <20230907130004.500601-40-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

fw_cfg_build_feature_control() uses CPUID_EXT_VMX which is
defined in "target/i386/cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904124325.79040-4-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/fw_cfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
index 72a42f3c66d..7362daa45a6 100644
--- a/hw/i386/fw_cfg.c
+++ b/hw/i386/fw_cfg.c
@@ -24,6 +24,7 @@
 #include "kvm/kvm_i386.h"
 #include "qapi/error.h"
 #include CONFIG_DEVICES
+#include "target/i386/cpu.h"
 
 struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 
-- 
2.41.0


