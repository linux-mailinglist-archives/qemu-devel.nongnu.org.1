Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0F97EB4EE
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:33:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wKM-0002z8-M0; Tue, 14 Nov 2023 11:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wK5-0002wT-Qh
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:31:36 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wK0-0006QF-T8
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:31:31 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9c53e8b7cf4so855624866b.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 08:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699979487; x=1700584287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WLUIW1wEN60RfjCUyh0wJRK9Kz/EqjAkfQjEh/PTjs0=;
 b=xhu4g5f1YxkJyZdUO5alRwSSjZ4qXE6yNMhDqTaCZnG6xqxKij6LrUdAmvwPJWxx9l
 wtSjbTvAn3oJdhz1e6gDNPWHnAELjViNpGneQPJrgYCW1FR86TuRqxbEVwpT+i7XM77z
 J75XdGQAxJuF3lcXqi8AYejWzLa2euty4shkpkPNVxazccRKtWq4KWZrIjp/tb5KJidK
 0+DIXj7e8nIpwEMaLaJoQXiIiNyKwqQTRmcnoS4K3F7gMcKKwxe0+46XPx/JWtFWvYLP
 UsCuj+Ti/D1U1bWQ8/O4Hi/f5Agj5NrYJraeVbWiAGoOzJ8ZdchJytyH71qvqbpMd3Dy
 NKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699979487; x=1700584287;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WLUIW1wEN60RfjCUyh0wJRK9Kz/EqjAkfQjEh/PTjs0=;
 b=m1cuVYHmFrU3c4sGqR+XSKs4HP0TZ5k5tNndgf7fKvBsLZwFFrbrVcup6lApYh+uTc
 a9OsVjDr5eFR4/VopAt1YKhlJ2TEOsegWQ9r5N2dfxKJuGbYURhvcsEVtFTTlpzVfV7n
 DGshtMS4tOWztVzCYZIzE0/EQ9kPqjQ0jtSIC6ZWL/0NRKinxLkSCUu6utwLoGZYvcYp
 UAgIohEiz5ullrMrfTviZZuqkk+E+zUufMAF+RoGHVJZ8l2BPEUOpAgAeW34brbHBdeg
 zGWMDurJfyp0wbdsqztOjnDQcb6a6A7uoheVdhtFIlCEBh6C+XQ3iSMBTg5GHJEsuVzy
 i/6w==
X-Gm-Message-State: AOJu0YzYeNC85faeYftiOiMbM1ljvKVvjJOcXQvpFUoRo5a8K6wZzs2h
 3tFkd0pDcj4xUbXPp65vRqz5gwb84ERnpbkHr1g=
X-Google-Smtp-Source: AGHT+IEWSkzHY5obRM6zNhXhqu10PReegPajovJZrPBLVpt+fJDzRpOh65h9KSuNBeV+qPZ25y+u/g==
X-Received: by 2002:a17:906:b889:b0:9e0:dcf:17f6 with SMTP id
 hb9-20020a170906b88900b009e00dcf17f6mr7932359ejb.58.1699979487100; 
 Tue, 14 Nov 2023 08:31:27 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 m16-20020a1709060d9000b009be14e5cd54sm5785453eji.57.2023.11.14.08.31.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 08:31:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 David Woodhouse <dwmw@amazon.co.uk>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.0 0/9] hw/xen: Have ARM targets use common
 xen_memory_listener
Date: Tue, 14 Nov 2023 17:31:14 +0100
Message-ID: <20231114163123.74888-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

Hi,

While looking at Xen target-specific code, I noticed some
generic code used by x86 which is not implemented for ARM.

Maybe ARM machines don't need it, I don't know. But I
wanted to see if I can get this common code target agnostic
and build it once, possibly bringing smth useful to ARM.

The changes don't break CI testing and Avocado local tests.
If this xen_memory_listener feature isn't required for ARM,
I'll send follow up patch that keep this series with common
xen_memory_listener but with a runtime flag to disable.

Patches do the usual "change target-specific API to a
target-agnostic one", in particular using "exec/target_page.h"
at runtime. Then non-x86 code is extracted, then merged to
the generic xen/xen-hvm-common.c.

Thoughts?

Regards,

Phil.

Based-on: <20231114143816.71079-1-philmd@linaro.org>

Philippe Mathieu-Daudé (9):
  hw/xen/hvm: Inline TARGET_PAGE_ALIGN() macro
  hw/xen/hvm: Propagate page_mask to a pair of functions
  hw/xen/hvm: Get target page size at runtime
  hw/xen/hvm: Expose xen_memory_listener declaration
  hw/xen/hvm: Expose xen_read_physmap() prototype
  hw/xen/hvm: Initialize xen_physmap QLIST in xen_read_physmap()
  hw/xen/hvm: Extract common code to xen-hvm-common.c
  hw/xen/hvm: Merge xen-hvm-common.c files
  hw/xen/hvm: Inline xen_arch_set_memory()

 include/hw/xen/xen-hvm-common.h |   5 +-
 hw/arm/xen_arm.c                |  24 --
 hw/i386/xen/xen-hvm.c           | 441 +----------------------------
 hw/xen/xen-hvm-common.c         | 474 +++++++++++++++++++++++++++++++-
 stubs/xen-hw-stub.c             |   4 -
 5 files changed, 468 insertions(+), 480 deletions(-)

-- 
2.41.0


