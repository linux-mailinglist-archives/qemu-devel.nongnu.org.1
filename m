Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E22B70A828
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 14:39:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0Lqh-0007TJ-61; Sat, 20 May 2023 08:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q0Lqd-0007Sy-6Z
 for qemu-devel@nongnu.org; Sat, 20 May 2023 08:38:11 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q0Lqa-00045g-0t
 for qemu-devel@nongnu.org; Sat, 20 May 2023 08:38:09 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-510d92184faso6730198a12.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 05:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684586286; x=1687178286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sodBaUbIIBP3YQBI3zr8YQ5KKd3axlGTGAqXJU42UXs=;
 b=i2kSbI5svxKH5TrfW02P9EOmvm4A3uwKMigjvv8Ttv66HS/U91y3ezdlP3DaS8j3rW
 3XS0keCqbErWVVtL0rz/o5vDVO6RSLbPF2WCV8A63XL0QtTATy20RdUOlSqYZ3YqL6CQ
 b2bzdNk7PSTxLPEHwUt1eqasZPlRNAugHFZ1X+PYYO4NarujjLXlhOjEVSegv16/zI/4
 QTvQH+YrLhwWFMlcLelHHNQ9V37C/BwLi0kmC/EQGB67ogYEz+ffb8+FlZqfwxnk1yUQ
 Bff7QunQ2gdTNieitclAyGsWPR2a9OtMi9CQUi1JoV5YwIN/N6nUCTMDFFWMwEzCUPgh
 ekTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684586286; x=1687178286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sodBaUbIIBP3YQBI3zr8YQ5KKd3axlGTGAqXJU42UXs=;
 b=mCCIyCJm994pIfjclNJKZJ8dvHVWhV1VLVRi20m4lttnEBDoOCx2H0M2fHXvLiCQ7g
 BAMFtVnQswy4e7lyje3uKxQoJ9ZBiT5PvlpX5yiikBa+QzWJltYpQX5k8nWiOJY/4vw9
 ih7PD4HZTjDYfpAX5iVj4v48CL53Jn6Vv6BXV1Fn5bCajegZpzdJtpjq0RsPFeXrvXVU
 q42v9W1hZfEhSFWXlI+KG63PTxCET/TyWnwWR/F9l0cKwDwHesk7rNEnJ8yFDguglOYk
 h6UNcfwhTJAc48FcGdsZ3tUVgb04R8IZLanCz8xLz/HZTMRrrCZjCPOPDtAZBC5vLUWx
 xwLg==
X-Gm-Message-State: AC+VfDx1cwe/7jFbLpBntZB1El+X7QEct2VZdPIce3tuuaz1V05zH28i
 37I8RDOILdeEgchUmjTXnnC9CHPx2vKiKzrZr0IDZQ==
X-Google-Smtp-Source: ACHHUZ6ccSfmLlx5bLjn6mhYNAoy4X85foHkwJ+euJ/rK2DSipa6zQTeAQyRPpvyg02IcMFEYUhvXpa1YggIFNPj2Jc=
X-Received: by 2002:aa7:d905:0:b0:50b:febd:3cde with SMTP id
 a5-20020aa7d905000000b0050bfebd3cdemr4289123edr.42.1684586286093; Sat, 20 May
 2023 05:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
 <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 20 May 2023 13:37:42 +0100
Message-ID: <CAFEAcA_kjm+k7SEEnz6uw+cOJyXSoUqg2wCQ5h+W-eTfwxD=FA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned 24
 bit field
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
 Fan Ni <fan.ni@samsung.com>, 
 linux-cxl@vger.kernel.org, linuxarm@huawei.com, 
 Ira Weiny <ira.weiny@intel.com>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Dave Jiang <dave.jiang@intel.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>
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

On Fri, 19 May 2023 at 15:19, Jonathan Cameron via
<qemu-devel@nongnu.org> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> CXL has 24 bit unaligned fields which need to be stored to.  CXL is
> specified as little endian.
>
> Define st24_le_p() and the supporting functions to store such a field
> from a 32 bit host native value.
>
> The use of b, w, l, q as the size specifier is limiting.  So "24" was
> used for the size part of the function name.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  docs/devel/loads-stores.rst |  1 +
>  include/qemu/bswap.h        | 27 +++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> index d2cefc77a2..82a79e91d9 100644
> --- a/docs/devel/loads-stores.rst
> +++ b/docs/devel/loads-stores.rst
> @@ -36,6 +36,7 @@ store: ``st{size}_{endian}_p(ptr, val)``
>  ``size``
>   - ``b`` : 8 bits
>   - ``w`` : 16 bits
> + - ``24`` : 24 bits
>   - ``l`` : 32 bits
>   - ``q`` : 64 bits

Can you also update the "Regexes for git grep" section
below to account for the new size value, please?

thanks
-- PMM

