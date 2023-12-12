Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED7180EA80
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 12:38:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD14V-0000MO-IZ; Tue, 12 Dec 2023 06:37:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD14T-0000Jx-RX
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:37:05 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD14R-0006wt-97
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:37:05 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-54c9116d05fso7620217a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 03:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702381022; x=1702985822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRG2U+UvZdWTGYdcA/MTX3iesT+e4Kqtp08ALJBiHJ0=;
 b=JOtS9yYrPIX6UlFDjXZCB48vf+zJgFmNV2WX8Dswj5SYSKi1lsK9jYZpzOJzbWNImn
 GlIPFmW1rNsSbi7xRsqS4OhDdVziv2GgHO+UD9V++hN1qfmGV/+ESemK0lEHptPXb+ng
 Io9vKtm4SCviavCqvA3NqV2GDH4Lh2A1doTEsErcSW91jjmif8BjdKSk6rdGaM4ZnNtI
 9SyoXDFanyqb8sIybfqQZUf5MoMSaZoRW2hJC2UVVImitAmCDKm2k21Po05RkoR0cMAd
 gHa4EWUvtu97wuTJ35DhWetmKwMV3i7Qlf89qaMdK+umDUufwCioPX11AvIF/L9j6RCd
 XYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702381022; x=1702985822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRG2U+UvZdWTGYdcA/MTX3iesT+e4Kqtp08ALJBiHJ0=;
 b=AmPOA7SHqMOkaH9VaMyXxkfpIMb6blGvnsNSvey/fvZW/uNferj1X9fePScozY2DhD
 Q3poJd06IrZUlFo5c3eHXLFd2qLI5nKTNR3tirL/yVK89MY0uaYQ/ET1ZBBt1HMIWL9v
 GvEmsJ/3MrL1/Opsh5JJdi7iGAsjHrckH41RHmVebP/cJ8bRTJEnIVv3ZMlCJ43Co87y
 ezoTU7NuNh/6tA2bwaLe7STgrPxQomvVXXTqe/2kXPa3sp5BRPHLBafBi7+qECPoFRd6
 pkCBOvV8F+UG7LxqnkQ0UJZJ1XqqD5rFDAF5nNC8ek+BL0x7J/qZgg5sDySQS3WkpIi3
 yLJw==
X-Gm-Message-State: AOJu0YwTJ69mz26jhe+99iyXt8qCkvXBBxLGU7PMS3IfKgV1EmbO0RHF
 tKjtVSD4NAWYh8S0ULTKXSas4V7whjFpbJka7dsvIw==
X-Google-Smtp-Source: AGHT+IG7wigeLzEy94ZfmT38G9M0xvCEqYOXKZAd07PDzxyUWq45tAHtTjaaPmYF+UV64d6g/eLKxw==
X-Received: by 2002:a17:906:86:b0:a1f:ad9e:5e15 with SMTP id
 6-20020a170906008600b00a1fad9e5e15mr504499ejc.66.1702381021857; 
 Tue, 12 Dec 2023 03:37:01 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 ub26-20020a170907c81a00b00a1c96e987c4sm6184806ejc.101.2023.12.12.03.37.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 03:37:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH 3/4] hw/s390x/ipl: Remove unused 'exec/exec-all.h' included
 header
Date: Tue, 12 Dec 2023 12:36:39 +0100
Message-ID: <20231212113640.30287-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212113640.30287-1-philmd@linaro.org>
References: <20231212113640.30287-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/ipl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 515dcf51b5..62182d81a0 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -35,7 +35,6 @@
 #include "qemu/cutils.h"
 #include "qemu/option.h"
 #include "standard-headers/linux/virtio_ids.h"
-#include "exec/exec-all.h"
 
 #define KERN_IMAGE_START                0x010000UL
 #define LINUX_MAGIC_ADDR                0x010008UL
-- 
2.41.0


