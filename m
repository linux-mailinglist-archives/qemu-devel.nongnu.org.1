Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C16667E3A5A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:55:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Jim-0004fw-Hn; Tue, 07 Nov 2023 05:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0Jig-0004eu-JU
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:54:07 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0JiX-0002fy-0k
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:54:01 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-543923af573so9414255a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699354432; x=1699959232; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bGiIUoRrj9woNH8DaQDac/Ooei8TyCT72n7X5JluGTY=;
 b=ovuSCxvIppiqH/DNeohXTZ0bB83lSgwg1SiVeLYwBDj9x/zUq5LQq5zbem8aTHO9+C
 CPAEb8nzPaBXx5LZnvX2gfQhlufL4KdCbx3gtHr1nifrbCuG2RTAZn5kgJkH7MG/UfDL
 PF2RD6TiT+zrgNbG2e6IFFNOe3E1GbAhZawOSl+7UypSfcsZws8sDJh5eLReZSMxLMoN
 pnpOFeXd2ZMUkyvJKWm6yEXKQvB+s37doKbAOHB6qZ0ZtIHP2w6rd30MBGGPka6+Jqra
 t6OSf7y/yfEgWBJmr2uAbIkawW1qybTYqDzRBuK1Zbu3Q/V0gwim1R5ofYvMNl8MNqyp
 CfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699354432; x=1699959232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bGiIUoRrj9woNH8DaQDac/Ooei8TyCT72n7X5JluGTY=;
 b=wanK1Q8z5Xc6cy83ueMMe2nwawYbv+BHZls9QuMmUzOkTuRuZw37W6ch4XeVHmUNrF
 9SjRfy+0tyqa2D0gMxCWQz5Zvo8HPm+1Q5Kuysvlxcmh6Y2m8aOZvJ2DZapUldq+8AEG
 3Ti2MYi+mY5hRBwNS6mYiD11oKxQHs48fcfZ0FUrIZLmeRpragWRAyWKSAOnoip2gBSL
 mAmaqJSeX4WTejtsKpwo34QwtSqQz6+urm7fTNFTRDrgQDckZWnfDQHgLBMQCzRam2iW
 7KHLD+DOobjqcyZUnpPvd8007mqRUquHJSb5c5gNVyFC+LXaV5FDLLoOolrYGwmpefXt
 Zy5w==
X-Gm-Message-State: AOJu0YxJ6C5wCrReNNcI2mzkay2JS6QBFnw+YVu6TgfIzRU7/jXGjXh1
 iUmXN3XEa9/DWTLIcPf/BbT55an7ifTjlqWCIZPNPA==
X-Google-Smtp-Source: AGHT+IHQlnbaanJTQ5AONzD5hwHxF/PS1eFwCwKm91FLTDq4b9/hhwsV4hhQgz0rh4fZJ5yPrRbagxcvAh/rX0CGRiI=
X-Received: by 2002:a50:875b:0:b0:540:7a88:ac7c with SMTP id
 27-20020a50875b000000b005407a88ac7cmr24354601edv.21.1699354431724; Tue, 07
 Nov 2023 02:53:51 -0800 (PST)
MIME-Version: 1.0
References: <20231102094015.208588-1-ethan84@andestech.com>
 <20231102094015.208588-2-ethan84@andestech.com> <ZUOo3fGmqM/gVyTR@x1n>
 <CAFEAcA86B-V0gFLhE9rPK2kG=XeFw7OJ4C==8g2i_WHSLW_HYQ@mail.gmail.com>
 <ZURpIyjhraORROn5@ethan84-VirtualBox>
 <CAFEAcA-1dJnsDyZpf2Dy9XuAdp6CFWSFCzV7eceUJ6RyFLaVPA@mail.gmail.com>
 <ZUhH3Rulnj64whB4@ethan84-VirtualBox>
 <CAFEAcA_z1VCyeUFNMDSsxp-UYRLoMm-4=oo86JkJ3fmjoWdq_w@mail.gmail.com>
 <ZUmokGGG0BXyuxB7@ethan84-VirtualBox>
In-Reply-To: <ZUmokGGG0BXyuxB7@ethan84-VirtualBox>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2023 10:53:40 +0000
Message-ID: <CAFEAcA9J7euoRVCd8xm+UPVpOHNj7pBjvtqJXnGg_HtAV6f0YQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] exec/memattrs: Add iopmp source id, start address, 
 end address to MemTxAttrs
To: Ethan Chen <ethan84@andestech.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, 
 pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com, 
 in.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com, 
 hiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 7 Nov 2023 at 03:02, Ethan Chen <ethan84@andestech.com> wrote:
>
> On Mon, Nov 06, 2023 at 10:34:41AM +0000, Peter Maydell wrote:
> > What AXI bus signals? You already get address and size in the
> > actual memory transaction, they don't need to go in the MemTxAttrs.
> >
>
> A burst contains multiple continuous read or write operations. In current
> transaction, I can only get the size and address of a single operation. IOPMP
> checks not only a single operation but also the burst information. I propose
> to add those signals to MemTxAttrs.

QEMU doesn't emulate bus transactions at that level -- we have
no concept of burst transactions. You should have the IOMMU
do whatever it would do for a series of simple transactions.

thanks
-- PMM

