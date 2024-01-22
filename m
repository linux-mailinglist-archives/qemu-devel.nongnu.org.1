Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E32836407
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 14:09:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRu2S-0000OF-6Q; Mon, 22 Jan 2024 08:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rRu2O-0000NN-V6
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:08:29 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rRu2N-00012W-Hs
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:08:28 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0016340C6D
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 13:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705928902;
 bh=Y4OKcKP7jlXBrFHkiLNfJJDWcrIJkeVaYwGrZWkItS0=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=jSl6W79ZJkjtZmT0qDOkAPJSYkt1giFsaiwtak3zKjfzSv7AexHm1oxsig7hHKf4S
 /GJMP8P87sKDC7U+Xl/7FKwCzit+yXjuBFYqdSbE136pGkeqP6Ty6OS8nV1UKKlkTo
 iCZvQMosd2kJT0Eib6tRiwArTmn/VjdErYlvWmdJVc5TyYGOp279q17XVqAJRZy3z0
 zH4VQLr6Cypow+bT830TsyXl231cvJdhHgPLCGwEfQyUkM6TpXbsMPo7LIZhKpG1JC
 u2cLwn5DOmyP9wyHdbMzkRXGucvz7FE+m1ul18lqXYlk6jDOPRWd75RCTzGcjf0vwO
 Du+WVi8SE2BHA==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40e74860cb0so11098755e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 05:08:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705928901; x=1706533701;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y4OKcKP7jlXBrFHkiLNfJJDWcrIJkeVaYwGrZWkItS0=;
 b=wBanlhjXZCZnhnmO9OL7yeTudncL+t5+zJbsC8gMKr1QW/VOwRZju64ZhE18Q74wUf
 zJNkQVbz8ZkPPW3tOJYiIakkcHsqDrIMqhIQ6OFEOL8arOcOuR2pR5QkupEi7PsPwH98
 WhJLxGkI+n5U+B5qrSrJh6bSjHv59VKU02IOvZoZvPHVOFPC449neNOaO0bUtcEnNRC4
 1YjnrMlclsqqJBdVitEjCm2Dp6xbQ3O9c5DqOk8TJ3hRYba+LPukNMG4QHgpbDIs5X34
 R3TgIzIMIs/2PIshYsP6T80F1/HZ2XOrtsq36SNvoOW4IKgcZCseDbneLLeI3UGtVOqZ
 ZTvg==
X-Gm-Message-State: AOJu0YwaBvA2qNH9M9KqkhadA5+WJSLRuRfYSqKLKVafL5vG4ux5COM5
 zF7htsaAY+7mFewhUSebKQR8T3FgO5NdEkt3HPAUfhTGRLYF9GZawzS4rNz7N3s1QJjvAeRJ4e9
 MUEoRJmpxK6bu5zMbN/ORQGEi/yqjjlSez3VQ7YqfxTt+AhsTHJSzMVbVNStAVVEXf2aE
X-Received: by 2002:a05:600c:4d82:b0:40e:8550:4240 with SMTP id
 v2-20020a05600c4d8200b0040e85504240mr2193905wmp.138.1705928901268; 
 Mon, 22 Jan 2024 05:08:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKzk9riBbmoodjo8EiiNTIbYimuCnbmdUmn1JSPYm43Ve/mTooiUhTilMY8nMxM4+BlG2AgA==
X-Received: by 2002:a05:600c:4d82:b0:40e:8550:4240 with SMTP id
 v2-20020a05600c4d8200b0040e85504240mr2193901wmp.138.1705928900918; 
 Mon, 22 Jan 2024 05:08:20 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c445500b0040d62f89381sm39214456wmn.35.2024.01.22.05.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 05:08:20 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 0/4] target/riscv: SMBIOS support for RISC-V virt machine
Date: Mon, 22 Jan 2024 14:07:54 +0100
Message-ID: <20240122130758.74051-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Generate SMBIOS tables for the RISC-V mach-virt.
Add CONFIG_SMBIOS=y to the RISC-V default config.

With the series the following firmware tables are provided:

    etc/smbios/smbios-anchor
    etc/smbios/smbios-tables

Add processor-family to the '-smbios type=4' command line options.

v3:
	use misa_mxl_max to determine bitness
v2:
	set processor family

Heinrich Schuchardt (4):
  smbios: add processor-family option
  smbios: function to set default processor family
  target/riscv: SMBIOS support for RISC-V virt machine
  qemu-options: enable -smbios option on RISC-V

 hw/riscv/Kconfig             |  1 +
 hw/riscv/virt.c              | 44 ++++++++++++++++++++++++++++++++++++
 hw/smbios/smbios.c           | 20 ++++++++++++++--
 include/hw/firmware/smbios.h |  1 +
 qemu-options.hx              |  6 ++---
 5 files changed, 67 insertions(+), 5 deletions(-)

-- 
2.43.0


