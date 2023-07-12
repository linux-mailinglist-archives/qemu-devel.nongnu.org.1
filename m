Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DCA751213
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 22:59:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJguc-0000Fa-Aq; Wed, 12 Jul 2023 16:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJgua-0000Ee-78
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 16:58:12 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJguS-0005T9-Ss
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 16:58:11 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6b9a2416b1cso785801a34.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689195483; x=1691787483;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gkG+7qZyYpzMB1CIWIF5nOYbQKd6MV64dGxdex70EcI=;
 b=LELgSZ/LAFNkpSMWlnWngHIHMvLgazopnvvAfbNTiSf9G3K/OYNmRffhH+HZQ0DL8Q
 15szgYSaNRfqh8d6qDMMEuV73zZTgMVrFBUh0/BG3QdmepsxoFykHvpSE9+0qWbEzYOG
 AeOmfWHdfv+MkHJ7x7O1eRZO7ZKyvXkg5lObCcLLrse8dM7VZeQ/o/9+C/FYfmBVqdSY
 bal46ZQFVECkXZYNNfzyRn9ABO71Ca5rZAKWBX+GdL0y8Dh5Hzcd5nnzupKLn9pUKxp4
 QsWVehRr6POpYbxd5rT+6A25bWmbFk9Qdxm3Hd8os3IaoPivkGYqGYZOnPyxcuDtVuFE
 UaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689195483; x=1691787483;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gkG+7qZyYpzMB1CIWIF5nOYbQKd6MV64dGxdex70EcI=;
 b=X0xvKPOsWRfviIYJLBIyncIvSkBUzqmeU21l1vZn4CfvcpX/D8R6b7peurP2LGmAv6
 a7S1ITFC4SuURynYeyppEXPEka9aDuwtSl+Y6qzvCyePD1+NmV8Hdrl+CCTWeX+QcDYc
 f5HEwcBV/CcpPLiDhEz3RyIkOeSMf5DErxH0BRlmOKhfCsUxcjj0TvLxJyBLQt+T5oyE
 5aQMoAWWfm5S5P7Quk7g82+FIcYWkyQIVH4pEHP7vhTg2aozXvEFi6yoLaxoEJUJ4dLD
 NAThrVJvjxHnsy8I3HVmwa/kDkn753zniTIBavtDOQjWh1o1Ou24kh2kuAnnM+DbUqXq
 jB2Q==
X-Gm-Message-State: ABy/qLaOo4v30x6hAzi12ryqLHelSF8A22BRCaUTjbmb6HlrJ2yx3GCk
 fdOZ0F74Ebb6zF5Hq83o3ZEsY715V8iJGna31YA=
X-Google-Smtp-Source: APBJJlFZ3uesEeuzFFiZE9ecJMpFKktAai5Qi6MMHGHJrt8hgwjqXaE/hVOpvrMWU38SwDLBnXckHg==
X-Received: by 2002:a05:6871:b2a:b0:19f:9495:95ff with SMTP id
 fq42-20020a0568710b2a00b0019f949595ffmr25104043oab.27.1689195483137; 
 Wed, 12 Jul 2023 13:58:03 -0700 (PDT)
Received: from grind.. (201-69-66-19.dial-up.telesp.net.br. [201.69.66.19])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a056870344200b001a9911765efsm2359904oah.40.2023.07.12.13.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 13:58:02 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v2 0/7] target/riscv: add 'max' CPU type
Date: Wed, 12 Jul 2023 17:57:41 -0300
Message-ID: <20230712205748.446931-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x333.google.com
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

This second version has smalls tweak in patch 6 that I found out
missing while chatting with Conor in the v1 review.

Changes from v1:
- patch 6:
  - enable RVG, RVJ and RVV in riscv_init_max_cpu_extensions()
  - Added the resulting 'riscv,isa' DT in the commit message
- v1 link: https://lore.kernel.org/qemu-riscv/20230712190149.424675-1-dbarboza@ventanamicro.com/T/#t


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
 target/riscv/cpu.c             | 109 +++++++++++++++++++++++++++------
 tests/avocado/riscv_opensbi.py |  16 +++++
 3 files changed, 106 insertions(+), 20 deletions(-)

-- 
2.41.0


