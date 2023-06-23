Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E78E73B8AF
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:24:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgl8-0006ub-Fb; Fri, 23 Jun 2023 09:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCgl5-0006uE-Fh
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:23:27 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCgl3-0000Or-KK
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:23:27 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51bec5c09ecso670840a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687526602; x=1690118602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6WLu3ud7U4QHCaaPoCBDVlMpZ1/TAxHCM8xxEmrcb3c=;
 b=OYGe4rSsk0jXiSfk+5bC+JC2s/2m8rS0LjzKxvb8unFfplz3rWzBAbLwPLBexVcQtM
 aO6HkIiCYDk6zIY21jAh89WfUvlj03H5EZcpLV07D9RMTcVzrVsHgwhaUISLCBisnTVa
 /lwXVbYomIEAP5vNoXVE6elizHej5CoHGl058mkUUbBkN67RkpejQlsJn3KyTfAG9qxQ
 6h+DxTeo/CCO+b5p7XUo/n0dAo6bt6qJJz7QibapFZ1nVD0HeTOyQPz4qMqVvGSACW8S
 GUTWzmsWwSSjPa6QBKV/1Membk42b6GRaKIE4YMVhqllH+t1WjTwY4mqwrCjTQUJ00nw
 obeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526602; x=1690118602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6WLu3ud7U4QHCaaPoCBDVlMpZ1/TAxHCM8xxEmrcb3c=;
 b=fHt5yYsNpnnUB6ugjbhfSgvRyuHSeOIzEWyppQb4PeSg6TbE18TWN5XRSqPmv4UEeH
 B5dwzjst69L/Br7HTCYXhq30GWZEkWsTfVGqmGI/yERWcb2zYi+9TVDXEH4wlME/8xvD
 5/FipDA9wc4M18M/DVvuMCraiUKQzNjO1k2yf2Jvv4MbZbU1A5xozFVS4kr6bIeWfHwZ
 VJRKKZiXfw0ewgPyZCRaRdgxcylgY9MsMoEUej2Ilw/y0bWjVBheGLp/f8BbsgEei/Z4
 6+ES+Q1+L+cjTxFfqa0yXiz1HZRz7yC5oXXGnWuunGscj3uMQODbyHbdmuwTcxEkwE1z
 FXWw==
X-Gm-Message-State: AC+VfDwWkzc3T47IxEzoKhLz3pckSROAuAE9HOiRd/SjOL5wl2wGHUeW
 JdSRqTd09eibBnpl0KRcVVo52D7HkoC88jyAFmxn5w==
X-Google-Smtp-Source: ACHHUZ5SVPaHsuABhauPX3uXo/eu/ySqimjgHxTLHdHmJhSk5cl4bgjIJFzW2mqCX1urRUbbog0oiQPLC67DpY/M7oc=
X-Received: by 2002:a50:e604:0:b0:518:9174:9b5f with SMTP id
 y4-20020a50e604000000b0051891749b5fmr17789530edm.1.1687526602283; Fri, 23 Jun
 2023 06:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221107224600.934080-1-mst@redhat.com>
 <20221107224600.934080-26-mst@redhat.com>
In-Reply-To: <20221107224600.934080-26-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2023 14:23:11 +0100
Message-ID: <CAFEAcA-eKRB2s4bg0Bnc0n2RBC0bCuRohs=4TFPmBjwG9yM6Mw@mail.gmail.com>
Subject: Re: [PULL v4 25/83] hw/pci-bridge/cxl-upstream: Add a CDAT table
 access DOE
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ben Widawsky <ben.widawsky@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 7 Nov 2022 at 22:49, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This Data Object Exchange Mailbox allows software to query the
> latency and bandwidth between ports on the switch. For now
> only provide information on routes between the upstream port and
> each downstream port (not p2p).
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi; Coverity points out (CID 1508120) something a bit odd
in this code:

> +static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> +{
> +    g_autofree CDATSslbis *sslbis_latency = NULL;
> +    g_autofree CDATSslbis *sslbis_bandwidth = NULL;
> +    CXLUpstreamPort *us = CXL_USP(priv);
> +    PCIBus *bus = &PCI_BRIDGE(us)->sec_bus;
> +    int devfn, sslbis_size, i;
> +    int count = 0;
> +    uint16_t port_ids[256];

> +    *cdat_table = g_malloc0(sizeof(*cdat_table) * CXL_USP_CDAT_NUM_ENTRIES);

Here:
 - cdat_table has type CDATSubHeader ***
 - so *cdat_table has type CDATSubHeader **
 - so the array we're allocating here should be items of type CDATSubHeader *
 - but we pass sizeof(*cdat_table), which is sizeof(CDATSubHeader **),
   implying that we're allocating an array of CDATSubHeader **

It happens that sizeof(CDATSubHeader **) == sizeof(CDATSubHeader *)
so nothing blows up, but presumably this was supposed to be
sizeof(**cdat_table) ?

Using g_new0() lets you pass in exactly the type you're creating
an array of and avoids having to do the multiplication explicitly.
It also gets the type checking right because the return type
from g_new0(my_type, N) is "my_type *".

  *cdat_table = g_new0(CDATSubHeader *, CXL_USP_CDAT_NUM_ENTRIES);

As a side observation, "Foo ***" is a really awkward type
to be working with and it's not surprising that this kind
of "did I mean to dereference once, twice or three times?"
bug has crept in. Perhaps there's some refactoring that
could avoid that ***...

> +    if (!*cdat_table) {
> +        return -ENOMEM;
> +    }

Also g_malloc0() and g_new0() can never fail, so don't check
them for failure.

thanks
-- PMM

