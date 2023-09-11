Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CED79A3BC
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:47:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfaeL-0000C6-TM; Mon, 11 Sep 2023 02:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaeK-0000By-5y
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:43:56 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfaeI-0004RX-3g
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:43:55 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3a7781225b4so2811071b6e.3
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414633; x=1695019433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxgyHj3pWoEqxLeuIclC5zzk9fMaICBkgpM0QGf+99I=;
 b=QAs3LfpJQzpcoM4xoC+oMJ5HWyuUatkEpTuwj+YVkK+yfEfc2qVslSZUwfSNnZ4avJ
 40BBakj3xX1kAst75xnWsKyBOgL7zWuPefEg7wKCvqapa/f/Vyl8bMZmoHdByIH3qtLT
 Dy8Sf0TJ7tbiPcRmExivp8dlokjFZk7HPiRwZcsg8GmFB/Gisz/Utyxy9Nev3Urswzcl
 JIoaJeJcHnK6yMAYSFTa3lwNtPo3Cn7Nk2TZ8CjdXMj2oxTiB1lml1w6lv/ufiGtmzlu
 w7qXWLq4loevQQhAj2yJRTU0/rKk+mkGl1PRKHEn0h1gjny0sAItQ/ZUi0W1MjJqNuIe
 ntOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414633; x=1695019433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxgyHj3pWoEqxLeuIclC5zzk9fMaICBkgpM0QGf+99I=;
 b=lkJ9SKmm4ro2rmXzS139M57OSgTJIBRbc+ZRHL6fkp5hCM7K569Ga48U8S9mIWy1yh
 uFkDhdvAM+5EbHNUaK+a23arTyHtDMGL5M6GZT2q30VBiLtld5qxvbAt6aLEzW3NgXCo
 6H/XUF2Yxz4VjP7rCDttljUSrokCyXGRaiSIliiw11t2ys+iXhdFI3g47/BTGzHpck31
 oHWRgSAIMp9pKm5WEhBdb2yyUhVrtDBuxOJWvA+5bUOXBncorlermFs6BTzJFJaTeLcE
 kz3h2RT3C4IECmmLj0LnaFUEIXGSWwhsFSlPZY8pVhuuKBCKQQRqtPBLJEd8/uY270E+
 hZRQ==
X-Gm-Message-State: AOJu0YyaGvYjpAsI6zc/q+ILqaO3an1hFSRqy1E4uraMj9qbzbmIT9/K
 aFv0xCocsjfCvKBv6w9r8xoiyBTCw8C/ew==
X-Google-Smtp-Source: AGHT+IH1MVjmjYtGkKHWpOWoboUznBfuKBVTTKAStaC8L6FG9TiD+Tk0MwYuUuKTsbw2K+nOpIy+fQ==
X-Received: by 2002:a05:6808:8f0:b0:3ab:83fe:e185 with SMTP id
 d16-20020a05680808f000b003ab83fee185mr4600347oic.33.1694414632766; 
 Sun, 10 Sep 2023 23:43:52 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:43:51 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 04/45] target/riscv/cpu.c: add zmmul isa string
Date: Mon, 11 Sep 2023 16:42:39 +1000
Message-ID: <20230911064320.939791-5-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

zmmul was promoted from experimental to ratified in commit 6d00ffad4e95.
Add a riscv,isa string for it.

Fixes: 6d00ffad4e95 ("target/riscv: move zmmul out of the experimental properties")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230720132424.371132-2-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 08db3d613f..6d02e85102 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -88,6 +88,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_icsr),
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_ifencei),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
+    ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
     ISA_EXT_DATA_ENTRY(zfbfmin, PRIV_VERSION_1_12_0, ext_zfbfmin),
-- 
2.41.0


