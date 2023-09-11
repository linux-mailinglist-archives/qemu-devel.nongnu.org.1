Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A24679AB75
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 23:14:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfoDn-0003cp-RY; Mon, 11 Sep 2023 17:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfoDl-0003cg-Io
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:13:25 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qfoDj-0005BT-C3
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 17:13:25 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9a9d82d73f9so607114366b.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 14:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694466801; x=1695071601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+i6b3bA3Rg0SUcnPH4Ss1gYaJoTqAir2E8b0QJQ/x7A=;
 b=SHOuZudYYGECnPb8iG/xQaliLcbHfEBDSVOVkfMEvt7GuoPyDi2Jra9KwNJZpDEYLt
 ZvGkuiSmBfDx+1ubFYHJ9svpMH362CXrJTvYF6KC2f82JC1sC/BYHGbuEWsOXRx5lk+d
 3CKYop/IappV5eg9dT/EwIrv/VDcDtSSgYhs5jngymFOxdMCwMJ1vUWfMntpNxiQnTOF
 Www935TRpgOM88O+amMciPY9o+GAFqBCfHC5534RuqcfUspk7ZN8rEbevyUN+cdY6VOx
 2jPCpT4/27IVGYlIuBnhYyjKBZz3YqpJMHJwI5ycAoHxuKLmF8UkKcKSzZJY01vq6O18
 Bvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694466801; x=1695071601;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+i6b3bA3Rg0SUcnPH4Ss1gYaJoTqAir2E8b0QJQ/x7A=;
 b=WnyCjjzYmg7PW005JLpbZH+FBTNrCOk3XIk7XCDaWRnn9oGqieiE+5PZ8wzQ6X9B70
 U0OwnA+YABdx/OWGN16OTOK/tfPIiCcXA5KaYykQBcnbZFqaMnGh7zC7Fc+ILxZnEsxe
 ufq6kduPp0ElsQ1FWX8BcjB5uFTZvgvOxeOBJa12+lhDRcr6wVk+noZlKcJcFXVFi6av
 /tbwJr6d1CLV36YjZBEyM/MAmbSoolblshJHlvgHJdaIGnTWr5ipBOilWubvidh1S0ps
 FxmRSLiCZ3rIUk10BAnjZ+qB0fpZJGC+iM4agenZ7IM4GvelH8KWSBHHoQcWyoTFnhGq
 0Pjw==
X-Gm-Message-State: AOJu0YwjEZgg1YX0ay4pJK8iRWD2KXipQ0FYuqT43AerYP3DVrII5KtY
 wbJnI5k6WlLH9ANrSy07t874iKJ6Z7moTqEk0Z4=
X-Google-Smtp-Source: AGHT+IElUDIPmZ/cuW0+paD+bclrhVYiKji+qUy1+WUV9TZqVwtCVc8ugnSPJ1h1PnaIoN52qjgbcg==
X-Received: by 2002:a17:907:7804:b0:9a1:aa7b:482e with SMTP id
 la4-20020a170907780400b009a1aa7b482emr8911335ejc.26.1694466801049; 
 Mon, 11 Sep 2023 14:13:21 -0700 (PDT)
Received: from m1x-phil.lan (tfy62-h01-176-171-221-76.dsl.sta.abo.bbox.fr.
 [176.171.221.76]) by smtp.gmail.com with ESMTPSA id
 n16-20020a170906379000b009930308425csm5884542ejc.31.2023.09.11.14.13.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Sep 2023 14:13:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 0/3] target/i386: Restrict system-specific features from
 user emulation
Date: Mon, 11 Sep 2023 23:13:14 +0200
Message-ID: <20230911211317.28773-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Too many system-specific code (and in particular KVM related)
is pulled in user-only build. This led to adding unjustified
stubs as kludge to unagressive linker non-optimizations.

This series restrict x86 system-specific features to sysemu,
so we don't require any stub, and remove all x86 KVM declarations
from user emulation code (to trigger compile failure instead of
link one).

Philippe Mathieu-Daudé (3):
  target/i386: Check kvm_hyperv_expand_features() return value
  RFC target/i386: Restrict system-specific features from user emulation
  target/i386: Prohibit target specific KVM prototypes on user emulation

 target/i386/kvm/kvm_i386.h |  4 +++
 target/i386/cpu.c          | 58 +++++++++++++++++++++++++++++++++-----
 2 files changed, 55 insertions(+), 7 deletions(-)

-- 
2.41.0


