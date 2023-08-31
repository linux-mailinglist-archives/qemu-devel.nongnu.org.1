Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D928D78EE12
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:07:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhI4-0008C8-0y; Thu, 31 Aug 2023 09:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhEy-0002pf-5x
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:41 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhEp-0005Gq-Ay
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:37 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31aeedbb264so649920f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486649; x=1694091449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7qIBX23XIKc4/u+ga9LSmsROxltOGYIHLrY8CEfGsM=;
 b=nrrWo0pBWhQCoFWyLzBG3zpDc7PkECubeXFH2LUv/r8XvZhKno6x7TWRhp6KCAWrDg
 7imyMlNCc3X+V1GtGOPlO8oPqtY0Lnk+2ReKAfUimFmqLfb77xAIStpWhrlq7VsYGYEn
 uJyMBeeUfNgWfhwMRlZKlPbyQZUHJgW2mT50vXi68LMJfWy/5J2tJDiOsKV5U7pfTcrN
 YqQnnKLUuFh+PVTtZx+N3XEhj0HtN6pol8HRo6IgKzAnJTjFSZBLQtXmslMZgcrkOPDp
 6fWwFOci4CDQzRj3i7l72ClL9a2HHF0hemUnzsiN5vdi5lRtyiX58yMzXdcVSANJRI12
 zYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486649; x=1694091449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d7qIBX23XIKc4/u+ga9LSmsROxltOGYIHLrY8CEfGsM=;
 b=WYyVdB7sPAgjp7oFmHSqbB0gUbRcP1yTmEGuqSmolUcXQ7hwjgy2QsMazLM7+QoVI/
 iZfc6SmIBUcfhKiFYRq+GHLY+APWelZ7G44k5Ztan5kHn4GdydEr5nhv2AfYjZ+VscpD
 DgEaK66WeBOkoD/p8Ferecyq0r5JnTZWaqmEqpQk4f/OAnpYpmgLJ8q0+V5k60ScoJ6K
 rmp4RDxvjRCX440tiJEKppGo21GpwF6Csbgf1a4uCxCyVrMVOWXyxxuZSEmDhbnB3gIa
 6qtyr+MrExoiPd5CD/Qqiwtl3mOw7lMG0s9EP2VCUAWZ3artjqgCuaTOi35AlYYcyN0h
 NTQw==
X-Gm-Message-State: AOJu0Yzyj9LFFwRNaa+rxZ2WYM+6m6II9Df4Q80Bpfjok2dENDSPYSli
 vyFSEQkbUmHK6BvmaG1f278fA0LIqHrLDNgbSCA=
X-Google-Smtp-Source: AGHT+IHRsE+WVA8b1LU9P0bsCfISvWbCyAj+RIZIU8/fflEDXihd31NSv60ZPok2JAOhIWhiD4T3ww==
X-Received: by 2002:adf:e788:0:b0:31a:d6cb:7f95 with SMTP id
 n8-20020adfe788000000b0031ad6cb7f95mr3957781wrm.18.1693486649554; 
 Thu, 31 Aug 2023 05:57:29 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 i5-20020adfefc5000000b0031759e6b43fsm2175456wrp.39.2023.08.31.05.57.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 05:57:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/41] exec/address-spaces.h: Remove unuseful 'exec/memory.h'
 include
Date: Thu, 31 Aug 2023 14:56:09 +0200
Message-ID: <20230831125646.67855-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"exec/address-spaces.h" declares get_system_io() and
get_system_memory(), both returning a MemoryRegion pointer.
MemoryRegion is forward declared in "qemu/typedefs.h", so
we don't need any declaration from "exec/memory.h" here.
Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230619074153.44268-4-philmd@linaro.org>
---
 include/exec/address-spaces.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/address-spaces.h b/include/exec/address-spaces.h
index db8bfa9a92..0d0aa61d68 100644
--- a/include/exec/address-spaces.h
+++ b/include/exec/address-spaces.h
@@ -19,8 +19,6 @@
  * you're one of them.
  */
 
-#include "exec/memory.h"
-
 #ifndef CONFIG_USER_ONLY
 
 /* Get the root memory region.  This interface should only be used temporarily
-- 
2.41.0


