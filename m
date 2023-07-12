Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F4D7510DE
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 21:03:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJf6B-0000mm-Nq; Wed, 12 Jul 2023 15:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJf68-0000m2-Mg
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:02:01 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJf65-0006Us-WF
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:02:00 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a3c77e0154so5106944b6e.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 12:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689188516; x=1691780516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=urOygtk55l5rPaN2EdfFe3uECA48Ch5NVJSrHpWOCBY=;
 b=kIeMLdK9+cy2HWV06gnnrtgDq+57VbkcCsEnanHMtGNKitX5CtwurTNl4FjFLYQvoX
 HWwGmzkBwGWSPz+1TZKNmXDolf+geaNmi5dBfymLaTyNhMX6IRX8kbS4+MYhdIi3svuz
 4KW2Yr82RP/am5ga50DwUdwlRqC0I/R/aeeE7B0TKI7hwntNz7J1TtZ96GDfDfc0RIHB
 Gt5TPbZ1Bx+h/AmF5905LmErCr/NInW5XYsTgE6fhqgeJpi6dBnSx64sFodf9z4aRI49
 fquLKdZosztzyjAoGvMtuCGzoIp0mcRJz5E9udZri6mQVmUqS0wyGyOI8e3cAmnTCqzd
 duCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689188516; x=1691780516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=urOygtk55l5rPaN2EdfFe3uECA48Ch5NVJSrHpWOCBY=;
 b=KVsxBTX2r4XhNFWpgZ40wbpl9+d8g8e8yKCfiDTmGBkgcS3sKp9YnWqVw5hCB4aebl
 /h1QDsDKkG33JeYK9Ky6GRbGa+DICgLuEfve/Odx4NaojAjqRXMxYkGTw+w8nLcPdhGF
 6opMD0MaRnnZDPWAlTPw6Od6yEXhPmQUUdlvqo3YyuKBnjv2RusjERhsoK4pGRyyFLEF
 syg3r5YWYxKy/GlGaAgrAutpHKjzy3o6s96K0GqznGJT0oO96EJEOgzkl1QrBtvkgXUX
 OeJ4+9wY95t8PObsAoGpBaVYqdLc95EkaH8JrLu24olqYXNir+D+2LIm0Mnknh0rOsCa
 QIKA==
X-Gm-Message-State: ABy/qLZUBNk2tO7iBNlzj0kOduVkQsJmdk5Z5JSpEcQFISApK7WQu62G
 MKQD2izelQyUr6WR8EzSYMq/p+Qmg5IvXRHay1E=
X-Google-Smtp-Source: APBJJlH3c335dnKKx6bf4en5AphFsYIFkthv7ScnfOUU95fY+xBCRNaL6zFtrr1QlvBz/FLNqF/VLg==
X-Received: by 2002:a05:6808:1901:b0:3a3:fa5d:6da3 with SMTP id
 bf1-20020a056808190100b003a3fa5d6da3mr13049944oib.21.1689188516292; 
 Wed, 12 Jul 2023 12:01:56 -0700 (PDT)
Received: from grind.. (201-69-66-19.dial-up.telesp.net.br. [201.69.66.19])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a05680802c900b003a020d24d7dsm2174435oid.56.2023.07.12.12.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 12:01:56 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 0/7] target/riscv: add 'max' CPU type 
Date: Wed, 12 Jul 2023 16:01:42 -0300
Message-ID: <20230712190149.424675-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x233.google.com
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

Following the discussions made in [1] I decided to go ahead and implement
the 'max' CPU type.

It's a CPU that has (almost) all ratified non-vendor extensions enabled
by default. Tooling such as libvirt uses this kind of CPU to do capabilities
discovery. It's also used for testing purposes.

To implement this CPU I did some cleanups in the riscv_cpu_extensions[]
array. After this series this array contains only ratified extensions.
This is a preliminary step for future changes we're planning to do in
the CPU modelling in QEMU, including 'profile' support.

Daniel Henrique Barboza (7):
  target/riscv/cpu.c: split CPU options from riscv_cpu_extensions[]
  target/riscv/cpu.c: skip 'bool' check when filtering KVM props
  target/riscv/cpu.c: split vendor exts from riscv_cpu_extensions[]
  target/riscv/cpu.c: split non-ratified exts from
    riscv_cpu_extensions[]
  target/riscv/cpu.c: add a ADD_CPU_PROPERTIES_ARRAY() macro
  target/riscv: add 'max' CPU type
  avocado, risc-v: add opensbi tests for 'max' CPU

 target/riscv/cpu-qom.h         |   1 +
 target/riscv/cpu.c             | 106 ++++++++++++++++++++++++++-------
 tests/avocado/riscv_opensbi.py |  16 +++++
 3 files changed, 103 insertions(+), 20 deletions(-)

-- 
2.41.0


