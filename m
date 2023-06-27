Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A73B73FDE0
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 16:33:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE9kK-00041A-Hy; Tue, 27 Jun 2023 10:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE9kI-00040e-PA
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 10:32:42 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE9kH-0003aL-4V
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 10:32:42 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-98e011f45ffso333612166b.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687876359; x=1690468359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yXF/f9t11zAakpvjOX4nDrtnLXHNdzigFTidlmb+aUY=;
 b=LQHHK8u4R1ctyBaBMB8vnFgcgXerPU+61dRqHkMPCrIJYghNCth9RtJiDhuqP0I6eJ
 nTPSIQJx3Yat0uRIw0Tm4NJ/QVDVlM/u1KLdrhfOQIyuhj2WlKRGcoBmfx7QC8zM0rgH
 r9M6kEsK+SQyYbhJAgSfzprjw1vaxgE03d/H1pC3egtt+OOnyyr1mrWmJyVge+Rrlb2C
 THSCwElliI4If6Hr0O10e9tEUHXoJywMR0DITYD8wExJMLLaIDkANxocfYmxr5UMha9U
 LOMiggZiodPypnqSbzghbZKEgm2VxiJIT2PlK4OHDEzBvaZ3cg3Ub8hEll9oFsENcXh4
 SNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687876359; x=1690468359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yXF/f9t11zAakpvjOX4nDrtnLXHNdzigFTidlmb+aUY=;
 b=N1wrLS8Da10nrnKAsrNDqtAK9sxaVOmh5Q82zbm+GQCikmbWhRA0FmjvOXhJWll22j
 0iYw6BqFPDIO/KhcrqaHemxR689OiD1/+PsuGlisVITT/moSDF/A0yKd915hobZgNTHD
 HY6sVWJbACYnQtMmLkwc03QinLnvPyCdFca82151ON/tjV2PzAqoYmy84GHkTOWUHkxB
 BOF+G4e/sWN+3IQCJRkLraAg81Qekucye6f0enoPr8NvADUYsbwdYuVMKUBctH0Alcsk
 xJWo7ACPaViSoKHEmDlLV8PmdJ1+NDuu84i+y8jukFOzKbp0PIST+grlciqlGOqead5l
 faUA==
X-Gm-Message-State: AC+VfDywT1GnQI87pikq+vUOU7KkTWqkLpiu7zLpHLANHcQhdGe+r1ey
 fGKHtAHyc+X2lSZB+CYNGd9wN0fqdJVw2I8SqG0=
X-Google-Smtp-Source: ACHHUZ7agzdM9Dedx+yKJmJVGN3r3Xb00OXtCRck4mDcWPTGYGfERVO6owTNh5AtEL3cH+xhr6ZfYg==
X-Received: by 2002:a17:907:a061:b0:991:fd87:169e with SMTP id
 ia1-20020a170907a06100b00991fd87169emr2306237ejc.8.1687876359432; 
 Tue, 27 Jun 2023 07:32:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 re3-20020a170906d8c300b00977ca5de275sm4690670ejb.13.2023.06.27.07.32.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Jun 2023 07:32:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org
Subject: [PATCH 0/2] target/riscv: Only build qemu-system-riscv$$ on rv$$ host
Date: Tue, 27 Jun 2023 16:32:33 +0200
Message-Id: <20230627143235.29947-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

Per Anup Patel in [*]:

 > Currently, we only support running rv64 guest on rv64 host
 > and rv32 guest on rv32 host.
 >
 > In the future, we might support running rv32 guest on rv64
 > host but as of now we don't see a strong push for it.

Therefore, when only using the KVM accelerator it is pointless
to build qemu-system-riscv32 on a rv64 host (or qemu-system-riscv64
on a rv32 host). Restrict meson to only build the correct binary,
avoiding to waste ressources building unusable code.

[*] https://lore.kernel.org/qemu-devel/CAAhSdy2JeRHeeoEc1XKQhPO3aDz4YKeyQsPT4S8yKJcYTA+AiQ@mail.gmail.com/

Based-on: <20230626232007.8933-1-philmd@linaro.org>
"target/riscv: Allow building without TCG (KVM-only so far)"
https://lore.kernel.org/qemu-devel/20230626232007.8933-1-philmd@linaro.org/

Philippe Mathieu-Daudé (2):
  target/riscv: Only unify 'riscv32/64' -> 'riscv' for host cpu in meson
  target/riscv: Only build KVM guest with same wordsize as host

 meson.build | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

-- 
2.38.1


