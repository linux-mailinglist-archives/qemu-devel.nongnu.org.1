Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C547797102
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:48:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeAgP-0000jv-GD; Thu, 07 Sep 2023 04:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qeAgJ-0000fL-Q5
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:48:07 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qeAgG-0000Of-Fr
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:48:06 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31dd10c2b8bso675292f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 01:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694076483; x=1694681283; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mOTLIIOQQVix84XA+QJh2zHn4AR4irebMtlyyEs6J+Y=;
 b=V//Za8oIC6ArDz6hEX4Jsj8i69v4E9CXv+wJewOa+nuHmbOxlXlCoYsxX594GYvmxb
 6Y+odUf1Lg0KrcGbZSKdD52pXK7+0D7/S2Gjx2vh65e+RD93kKT3CzKrMJiey994uebl
 j9T2fX2wy5Db7pt+p814tPIvLHE3s6HsnE7JMk3sFWKxu2pPdJd/1BGA65S0jP9Eoxjg
 vZpsFTvAAoBpcDDfS8kKwXuzdLpE8mE1BjQTYGK8vXD07z5P9mX+jxsC5mhw8F2pgBGO
 hMZmew1iumyIwGj2vxhVmwywk87aNbGjQYsppX1csDGJIxrT/0LvRVe2QlOEt9vJ4aGp
 sjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694076483; x=1694681283;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mOTLIIOQQVix84XA+QJh2zHn4AR4irebMtlyyEs6J+Y=;
 b=I04Tnj3k53gosdoX2Fqs4DS4M42vuNGlLGmvoZ5pFI85+oGEkZemwlQ4jq/Si0sb/e
 zSEB0JGltZbl19kN7oErpPLEkAqrBfqTFwltxyMR8Etfm++8cbDxUY3+tLX3tb6ZLgqb
 gGS/Vw5OgnGN35j96aAzxMqzGyj7eQC/zY1LlEc5yyCeE6Vi0fTYhCQGWLbBu07Sf7+J
 UbgeOd0UDM6qX8Qnnw+jLwsT4G28f7Il+pOOg9Ixg06M+rxG42ucznHWROB6Yn1haPMt
 X5WL4HuCzufiLdpw2yBh85hG1PCUbQVX0ddrSLs0mdsQ09pfghPZWc9RxExuRKA9Vn+R
 H6yw==
X-Gm-Message-State: AOJu0YzWPL0LrKKN38KKDyA14kzHtaLaSgCRUy5Td38dp88segfqT1eg
 O5jsH4s+ZP5jr3iqAeDT76m5fZadwZXUeKlUDuU=
X-Google-Smtp-Source: AGHT+IGhcGScuFvItO26xvtjdBuE7/rgM/3kpGVko8mm9exq4qfXYxeWgHKB9q5slX15J9HY2iHqBg==
X-Received: by 2002:adf:e8c2:0:b0:317:18a8:5fa1 with SMTP id
 k2-20020adfe8c2000000b0031718a85fa1mr3388268wrn.69.1694076482869; 
 Thu, 07 Sep 2023 01:48:02 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 i16-20020adfefd0000000b0031c5d74ecd8sm22817568wrp.84.2023.09.07.01.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 01:48:02 -0700 (PDT)
Date: Thu, 7 Sep 2023 10:48:01 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 palmer@dabbelt.com, bin.meng@windriver.com, peter.maydell@linaro.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH] docs/devel: Add cross-compiling doc
Message-ID: <20230907-1f1d1aa99487ea630eb7088f@orel>
References: <20230726120706.335340-2-ajones@ventanamicro.com>
 <CAKmqyKMbyDn0rZ8tAXCNZvLcVh2dGpkQ9b+WR_6t358kFpUroQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKMbyDn0rZ8tAXCNZvLcVh2dGpkQ9b+WR_6t358kFpUroQ@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 07, 2023 at 01:13:33PM +1000, Alistair Francis wrote:
> On Wed, Jul 26, 2023 at 10:08 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > Add instructions for how to cross-compile QEMU for RISC-V. The
> > file is named generically because there's no reason not to collect
> > other architectures steps into the same file, especially because
> > several subsections like those for cross-compiling QEMU dependencies
> > using meson and a cross-file could be shared. Additionally, other
> > approaches to creating sysroots, such as with debootstrap, may be
> > documented in this file in the future.
> >
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> 
> I get a warning when building this:
> 
> qemu/docs/devel/cross-compiling.rst: WARNING: document isn't included
> in any toctree
> 
> Do you mind adding a toc reference to it and sending a v2?

Ah, I forgot to try an --enable-docs build. Sorry about that. I've just
sent v2.

Thanks,
drew

