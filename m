Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1167B3DBC
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 05:12:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmQO1-0001Re-R3; Fri, 29 Sep 2023 23:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmQNz-0001Qr-Jw
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 23:11:19 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmQNy-0000CI-2W
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 23:11:19 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6c64a3c4912so467734a34.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 20:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696043476; x=1696648276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yDhQouHtI0bFcQQSACQjQbPDcgLaFXjYo7GpM00vPgg=;
 b=plj3Usldzd6WntgrczxEQPi006uOiLNY1i/XXddiB9D0NBDNNIE5UvL9OWlQ/2m4TW
 MO82jvGnSqFIJdRCjU19woNzDLeSL/faNwMFXvP/+N6J531eDrajro72HHCPlRqfW7p0
 jEwRpTH2A0Hu5xicLBr5InWMd1JtnBZ4sbuEzEeIbwKIrS+lLaeJKE1aFD5F2lNulv3D
 DJ8l5YzVQDtDj18CxTsVmF5jg5m1tYdsbw7F88dusza+RnS6Q2aJhI3c23S5Ef7rH8rU
 Hb6kRvR3kvNc1lILtCBW5PLH9HcpAbijpFiN2Hm18dxyoaF5OVVi+7JRWt+f8uKenJru
 Wwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696043476; x=1696648276;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yDhQouHtI0bFcQQSACQjQbPDcgLaFXjYo7GpM00vPgg=;
 b=R3LWBLxEDl6qMa0uB39zT6szIGcOc8B7YneI02/vS1jDdCjmSxYBeRK8zz0MQtaDHz
 rBWLUiGsnNa1hIfYWCwFYPfl4tFHCTEoWIHzzEU8Lqtm7JEpmcBfnP9CNPZLm6EJZqJP
 8KcwMSjWx+gQGIZ/hwLNVAEfivJFcIFxAA8MEzZ8nwN4R4uJwziohtcbil3Xmn7Z9/sG
 Sxlkf8JnHXKSrfs+mZI1AI6ZLN6JAGbtcWfl5Awvea7S7VPn3OXp34SaRdC1LFdyfNBh
 9Ci514f0jiHBqXanRYlFlPlsAHewtcNaBZ2nK6be26UprcJDFyvliljQepoEGU5JXrbF
 OvOA==
X-Gm-Message-State: AOJu0Yz8RN8TSo+F+H6LZX1T7qSVYKhirCbCwIug+XZSb6I5Ck/eDqOk
 KwBYAniSmIyYgyWsqrLWj5tJasxzedMmxYH4ol4=
X-Google-Smtp-Source: AGHT+IEKDjM3l+LWSS0F4vbM3qHsXxsG6OjhkMqyxRJYVv/uzZg2+Eh40dNEEF0wqct3lFGJF+S2hA==
X-Received: by 2002:a9d:6249:0:b0:6b9:ed64:1423 with SMTP id
 i9-20020a9d6249000000b006b9ed641423mr6281045otk.2.1696043476416; 
 Fri, 29 Sep 2023 20:11:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 gp15-20020a17090adf0f00b002790ded9c6dsm2146821pjb.31.2023.09.29.20.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 20:11:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 0/2] Split out tcg init functions to tcg/startup.h
Date: Fri, 29 Sep 2023 20:11:12 -0700
Message-Id: <20230930031114.1042913-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

Supercedes: <20230923130843.3708899-1-peter.maydell@linaro.org>
("[PATCH] tcg.h: Split out runtime-only functions into tcg/runtime.h")

I thought "startup.h" was perhaps a better name than "runtime.h",
at least for the functions moved, since it's about starting up
either tcg or tcg within a new thread.

By removing the argument to tcg_prologue_init(), we can simplify
the users even further, since they no longer require TCGContext.

Adding tcg_init() seems to match the other two as a startup-y
function and allows tcg-all.c to avoid "tcg.h" as well.


r~


Richard Henderson (2):
  tcg: Remove argument to tcg_prologue_init
  tcg: Split out tcg init functions to tcg/startup.h

 include/tcg/startup.h           | 58 +++++++++++++++++++++++++++++++++
 include/tcg/tcg.h               |  3 --
 accel/tcg/tcg-accel-ops-mttcg.c |  2 +-
 accel/tcg/tcg-accel-ops-rr.c    |  2 +-
 accel/tcg/tcg-all.c             |  4 +--
 bsd-user/main.c                 |  4 +--
 linux-user/main.c               |  4 +--
 linux-user/syscall.c            |  2 +-
 tcg/tcg.c                       |  4 ++-
 9 files changed, 70 insertions(+), 13 deletions(-)
 create mode 100644 include/tcg/startup.h

-- 
2.34.1


