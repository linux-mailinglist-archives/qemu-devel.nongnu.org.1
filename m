Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE9B80EA81
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 12:38:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD14R-0000E6-Am; Tue, 12 Dec 2023 06:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD14E-0000AV-VJ
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:36:51 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD149-0006tq-SQ
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:36:50 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-54c671acd2eso7387504a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 03:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702381004; x=1702985804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IsM3jluMYG+fGfRQAzPOap3By7YAk7vhZE+TTIaa53Q=;
 b=zP3C2KMn75Jwm+FnAuzIMz+6UY4CL7JFYEIC52IDC1qArLUOb/7svmp25q+zZkOrRH
 IqEGxKLjczk+a76AuQ33O1ansQL5cwh88LaV03BjnXOQs4kGGERhdZla9J9EvdKUR20F
 h+zyJ/V+JfDhrE99eV6bg7Z92KgljfF6Y9EWkcQ0fzXJPfMuY5S58HSorZmI4PZy7NFm
 DDoK4Zs6IHh/3s2aAijq+Dq8rfLYavB3+88UjDmg+H4q3mUFNbaBxkt+zdfnQGrWKbTZ
 xZccxzCa6wF5h5YaY4LGtxguEY+slMhoEtIwESzRjkhuY84Xd6NQWQ8ERh1PL2P4575p
 d49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702381004; x=1702985804;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IsM3jluMYG+fGfRQAzPOap3By7YAk7vhZE+TTIaa53Q=;
 b=Gt8VzWiz1vpbfg7LaM9bDqQmITbHiMM6waFbVQe9usdDRjrPwy9cIaXhSWXE9mE4mJ
 7jIUWWz71zQoXOYXkEe/b7DSLKFPU/GJecxHs/91Q1V/iPtzkgInuUw+DG1OQ/Aq6f7O
 P6YiFlj6sHTvm0mHaQeZ6jqSc8g2PTqlZ7YkSFglPlt6VYxjF0gMfYYqt7JOPlgRV2X3
 40drGW5Hn9x75ID77kutZQ7GZwBIhVZpFy4n9N8luVs6N6uOE9ZJMKITUbP4ro9/Cq5K
 i+AP0GUw8aZquWo7uyg5BFaz2nR9vXLJnUBOPs2UHCfyV4nBjZ4IsidNLnQBiHnT+qUD
 8yDw==
X-Gm-Message-State: AOJu0Yxgxpp+bH9S9HsIP74cOFTAV6685aCisvleJ11KH7c6VhlY1XUE
 bqezOtIrLaeUC5HNJ4thmplhz7JWI3ME3QHFOGcVOA==
X-Google-Smtp-Source: AGHT+IHN6EApjDUjIWmoMPIaNO+czOldnp+ADy4usrsTnUzjZ6NLbmnnReb6JUBAZi+jUAP4mw4THw==
X-Received: by 2002:a50:8581:0:b0:54d:c18a:eed3 with SMTP id
 a1-20020a508581000000b0054dc18aeed3mr3503870edh.34.1702381003990; 
 Tue, 12 Dec 2023 03:36:43 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 q3-20020a5085c3000000b0054ccac03945sm4526361edh.12.2023.12.12.03.36.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 03:36:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/4] hw: Remove 'exec/exec-all.h' header when unused
Date: Tue, 12 Dec 2023 12:36:36 +0100
Message-ID: <20231212113640.30287-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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



Philippe Mathieu-Daudé (4):
  hw/ppc/spapr_hcall: Remove unused 'exec/exec-all.h' included header
  hw/misc/mips_itu: Remove unnecessary 'exec/exec-all.h' header
  hw/s390x/ipl: Remove unused 'exec/exec-all.h' included header
  target: Restrict 'sysemu/reset.h' to system emulation

 hw/misc/mips_itu.c     | 3 ++-
 hw/ppc/spapr_hcall.c   | 1 -
 hw/s390x/ipl.c         | 1 -
 target/i386/cpu.c      | 2 +-
 target/loongarch/cpu.c | 2 ++
 5 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.41.0


