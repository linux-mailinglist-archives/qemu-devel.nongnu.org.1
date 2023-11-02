Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C59C57DE971
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 01:36:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyLfW-0002p6-RK; Wed, 01 Nov 2023 20:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qyLfU-0002hn-ND; Wed, 01 Nov 2023 20:34:40 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qyLfR-00040N-4M; Wed, 01 Nov 2023 20:34:40 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5842ea6f4d5so196248eaf.2; 
 Wed, 01 Nov 2023 17:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698885274; x=1699490074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UWYyC1B0giHCsZW0ITJxiaUXwylVs/gXz4ihPJwzBVA=;
 b=LYJMTsdgbtkFACv9r1LORbZFMjqECD0QcaCp+Un7Z/W55jvGCxOrLIvulswTFEDMdX
 eBDJYmQYnkvnzrerCJNY1C3Euwp7MZnjqzivJg4Vu/TdfrDFnS6BEpDK7YLlVQS5xTec
 aM1Fcv3qYXV8FIjFr+N6AJXdrp+9Du2lqtnVXu93YxDwGeMau2St/mfBxZzILjIG+po9
 XVvfeF1K2ZjKlkUj2DZTKpkSvs4ddJUzrDldCVcRxAwElXEChQwh1EvyHdVUGV7KnZ2w
 9F0DyNtSjb5JFFfEMP2orv8m1+Md1YksVWKSr7irP72fu5rSwyYc/aTgTnY7TnDoQaBG
 PVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698885274; x=1699490074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UWYyC1B0giHCsZW0ITJxiaUXwylVs/gXz4ihPJwzBVA=;
 b=AluYcvZTpr4b/6MXbpyqfFJWkjYgnlj88dE3px5D/CF21k+En6H56QlU/fl/1VCTOi
 L/D2o2ljFOuIUPTuWdRjaeyuk9EfFSlWty97N1NYgxfsHr09+ci2wkq7YfbBij3qdB/y
 ly+fQFtGalSM5902LG0PDYkRYpHlDomKGjle2cIJ5iVwL0YxjZFI82iEjwTVJ+w3U5ee
 +t3Ulel/2C5g6p+OiG2HhCbjZOI8TIYgOnZzIEAbJkWWMLOioBb5NdVAv18LC9QgFIds
 G2Ud3tkhuLHBJ+bBykvcLAY62o1k6bvMQyjvoaVz/woWEQY4DrfACKcjcOfIkNGvv+Hl
 0DAA==
X-Gm-Message-State: AOJu0Yyp7GK2a+QdXxk6jFcpQeC7soFZgPoqrRboC75Ddb0uwCJ1ml92
 JCtp33EKx36YQyJ4kD+DdUy9cDFYnkTjoA==
X-Google-Smtp-Source: AGHT+IEARA2Me6CV1XjML1BboWmq3yxQwYlO6vr5OibcWTkw60Z/a3g2SO6xIrro1OGnWtRvJIlThw==
X-Received: by 2002:a05:6358:7206:b0:169:81be:8ba9 with SMTP id
 h6-20020a056358720600b0016981be8ba9mr9720559rwa.7.1698885274105; 
 Wed, 01 Nov 2023 17:34:34 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 k187-20020a633dc4000000b0057c29fec795sm411783pga.37.2023.11.01.17.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 17:34:33 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: liweiwei@iscas.ac.cn, Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Palmer Dabbelt <palmer@dabbelt.com>, alistair23@gmail.com,
 Bin Meng <bin.meng@windriver.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, bmeng.cn@gmail.com
Subject: [PATCH 0/2] RISC-V: OpenTitan: Fixup ePMP and SPI interrupts
Date: Thu,  2 Nov 2023 10:34:22 +1000
Message-ID: <20231102003424.2003428-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fixup the Ibex CPU priv version so that smepmp/epmp is correctly
enabled and make a small change to the SPI interrupt generation to
ensure we don't miss interrupts.

Alistair Francis (2):
  hw/ssi: ibex_spi_host: Clear the interrupt even if disabled
  target/riscv: cpu: Set the OpenTitan priv to 1.12.0

 hw/ssi/ibex_spi_host.c | 6 ++++--
 target/riscv/cpu.c     | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.41.0


