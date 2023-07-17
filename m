Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4E9756F2C
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 23:55:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLWB8-0004q4-EW; Mon, 17 Jul 2023 17:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLWAm-0004pO-MJ
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:54:29 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLWAk-00040v-Cj
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:54:28 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1b078b34df5so3933280fac.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 14:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689630864; x=1692222864;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UjgKOjBVg5RoJdkiE54ny4j9gWpEU6MbpdXOZnvlujs=;
 b=Qx8HzN+yuMt/MDC4Z1VUpNJqzMkdg4bRROpf8sQDol3oO0b63n+F2UmlhPUDq8PNf2
 J7+BOJmk3xwmGVRiykSlXmqLCzWpewaqS55P1+1Dutt8QBrGN/1b3Zwk+dapxbDZgQMZ
 Gro+yJdw2OwRaKgvXSSg3lFtD9hvrBO7FHGnz5IXMpN+0o5GpUOsUUo3Qr4FMtY0yH7x
 q3N3MCINjEps16MN0yZXal28R8Qha0V9IoMru6Jql7ZTRPvD9QNad9ya58al8VtfmxAx
 Kj8ec5SgawMRe52iplM6YFbfL8EAFNvQtj+gM18aZTL4Sr4lMmQWMXkWq6Lzt2sxJJfE
 YLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689630864; x=1692222864;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UjgKOjBVg5RoJdkiE54ny4j9gWpEU6MbpdXOZnvlujs=;
 b=MEaoRXyDUs6HgqwXmP5VeAK741ASC4awhQoKhi1Uin+9d9GVD7uCmtXj5B1tL2BEz9
 WevocDt6ywJx8WiU7t91QlFpuJ1zMvkD8+uiMV5gdBonGe+pyD9H4eNuhmHCYZfhoRDw
 QoNuzjx3j9o0rK2wZAV5GSSbG5SebiE93xzm2e5lBO/67EAQOE0VNBXMKlvJ7S1xEh9/
 vjik52fowxN/J3KXVBEsIIpK9WuEPjTYpLAb6cpbq4iZmn7K1Te8+QTbqGVG6mkOgGb7
 DF6+F2D/BTAwpqYBeQWCge4nv5idssZrG6xEN5xroEzAKAyMfSqkodWwDkL3M0bsehKB
 lh7Q==
X-Gm-Message-State: ABy/qLY9j3snlKBy5yPduJyjQxtd0yFE297m9sv0U9LAd82yr3cGhPeo
 kHwWUx0AXC44Eqhgj83TH5ujOn2u8v1pPfB9JrgnLw==
X-Google-Smtp-Source: APBJJlGntC/laa9xWPG50VXs6y/blov4QMFGuJtV7IUhwXsd8bzdpwh1a61s+X9pY0Ig1xZhWhLANg==
X-Received: by 2002:a05:6871:1cd:b0:1b7:4b56:fe68 with SMTP id
 q13-20020a05687101cd00b001b74b56fe68mr13600664oad.3.1689630864322; 
 Mon, 17 Jul 2023 14:54:24 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a056830008100b006b9848f8aa7sm322958oto.45.2023.07.17.14.54.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 14:54:23 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 0/2] target/riscv: add zicntr and zihpm flags
Date: Mon, 17 Jul 2023 18:54:17 -0300
Message-ID: <20230717215419.124258-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x29.google.com
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

I decided to include flags for both timer/counter extensions to make it
easier for us later on when dealing with the RVA22 profile (which
includes both). 

The features were already implemented by Atish Patra some time ago, but
back then these 2 extensions weren't introduced yet. This means that,
aside from extra stuff in riscv,isa FDT no other functional changes were
made.

Both are defaulted to 'true' since QEMU already implements both
features, but the flag can be disabled if Zicsr isn't present or, in
the case of zihpm, if pmu_num = 0.

Daniel Henrique Barboza (2):
  target/riscv/cpu.c: add zicntr extension flag
  target/riscv/cpu.c: add zihpm extension flag

 target/riscv/cpu.c     | 29 +++++++++++++++++++++++------
 target/riscv/cpu_cfg.h |  2 ++
 2 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.41.0


