Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E236770386
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 16:50:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRw7r-00054T-Bo; Fri, 04 Aug 2023 10:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRw7p-00053j-3q
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:49:57 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRw7n-0000A8-Gb
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:49:56 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52256241c66so4714158a12.1
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691160594; x=1691765394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CJw5zTZopm9LRZgtC/TcDyRAU1zu3Pa4NugWYHkRy6I=;
 b=dXijyc82jJBbVcTQl3FEDbM7oNKsTepzAmsZdGgehx2nKI0TecoZuAjB7N9OX2XY3x
 goiRZU286PdadGbuP8+STYkxD8TEvhOMIK8PFXnAzXXXrzRJ5hugqD27Ig5AvUzMgADs
 IRaj/RMT5PjYhaLDumRtqPqHte1FGypMrKNVgm+PBbcsiEr8BgxA1LwNArZoA4U9SMam
 2VCf0T2GKyDsSo2ZNHry3Df4xbCGQLaBvRqB55VV4HQhNtou4c8T0BAjGQhv5Gkd8wX1
 vxRDU3kRvlm5NOKnhgwYediL16vxZWIe/yEZNkyh8Wsa3x4B8NTB4MbhtyW95z34vSRq
 968A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691160594; x=1691765394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CJw5zTZopm9LRZgtC/TcDyRAU1zu3Pa4NugWYHkRy6I=;
 b=XKX+l+gGiKSaHV5TaLAhkXy5x3fqLDL0JdU4f/Xm8WLMd8R66n/3zb7AwxrCPOZlhk
 NuNZkKMCpmHf77z2K2oPccT6Hu11znXkJE3xW8RxMpfFFIIoMdf/k/ZhrMHUrxGUqG5z
 2qUxsDvu2NXar22qvenvEKA1VDw9j2ARW0sHNcGUBhZfPN6LPGuvGeYUWYL1UnvXTpch
 DVbyCVKCE582ck28UdvBSTpDPCA0VasuPczEU9Ts/9FVYM/QzzxZEI3KEv7MuDVw/s3N
 Jpsa8JOESyShHFv8WjdaeLZVduTRd4AZcc3zyCcLEjWvG3li3MYccCaq8h+4M0c3jEZR
 BT2Q==
X-Gm-Message-State: AOJu0Yz/jS+Z7AFY3baYvWkxQ2n/rtpQnEL1DFhUZNxxJ+963+Ce8BFI
 mpqax7MRddo2Pi58mSyY0r+HStchKmeK/p07F+U8Qw==
X-Google-Smtp-Source: AGHT+IF2Fko32RxHeacW7YfX+WD7rWRlLxb5NSNFMOexwEr1gPJA60/HYWd5F/jn/6wzUeM+1LWBo+eAeN0iQPsdslY=
X-Received: by 2002:a50:fe99:0:b0:51d:f0fd:bc80 with SMTP id
 d25-20020a50fe99000000b0051df0fdbc80mr2275296edt.17.1691160593920; Fri, 04
 Aug 2023 07:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-33-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-33-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 15:49:42 +0100
Message-ID: <CAFEAcA8n1_vuuVcSt4EFzadAhcgfRnXg5UAyatRp_yh2Cxt-GQ@mail.gmail.com>
Subject: Re: [PATCH 32/44] Enable BCM2838 GENET controller
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 26 Jul 2023 at 15:10, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_peripherals.c         | 16 ++++++++++++++++
>  hw/arm/raspi4b.c                     | 17 -----------------
>  include/hw/arm/bcm2838_peripherals.h |  2 ++
>  3 files changed, 18 insertions(+), 17 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

