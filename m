Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F95798823
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 15:52:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qebtA-0006mX-SC; Fri, 08 Sep 2023 09:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qebt8-0006mH-BR
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:51:10 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qebt5-0000li-US
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:51:10 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52e5900cf77so2829323a12.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 06:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694181065; x=1694785865; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J8pjd1/df+s3RtkGAmFa4NAq964Oj2OD0bhtrmrAYJc=;
 b=U9Hyh9HGn82g/p44x1N0C7YGodlSCS249n8aYC+mUym5ZI2OH9wknchVmRVGYeXW+3
 WC/6zi58E3DtHdao1MtG+cQFNh4fMYNh8cvpYAJKQ8AXHCQevEB9hHiJ3HoW3YxUExP0
 Lkmbe+6F9w6IClRury4bGNFpnpnf9Pd1Qyih4meqHJmY3ZaEba3JTb+t/GwStusT2yxF
 gqMf/8IkDa9m57H05SZuDf01fwTdLFJFL0zfKGtHMD3tpAsyA9AHrXrI8mSXEGfFErrk
 lG/2YtV3nDmsOV6fqg/bZEPLIGmy3TRUdg1Mr9o7UvoC1U7SFCdfeFvUOzbLBt/6t/s9
 10/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694181065; x=1694785865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J8pjd1/df+s3RtkGAmFa4NAq964Oj2OD0bhtrmrAYJc=;
 b=gJL+er+OrE5WXSF8SVm1jjLHv7ebvgEhsg4rmisdsWPWTmmjWYW/TsyNDbyo2j6ohb
 P8H9Fg0k58szEV46v5sV934p4qhpaODTfd9BsYsPk4eubn3FKbmQdcnxD9yc6b7YJaXV
 UfPPpOJtQr9hInH2zTZPJzrexDeGgL3KDkC6fNc7LApfvN9hIEzuU09ornS21JRBO10/
 XLbvHmYQZ9XOu3XNThTdtYFlUDxuO4jBS2+YyS1ImuDMfhT73WgXKf1Icu5W9tj8SIy8
 3WIluWu2QL7bJK1sD/vOhPm2bqe+ML4k/7vYpNgnQtkPIq12GW/SLECHYwCp1p4d7CKo
 tEzw==
X-Gm-Message-State: AOJu0YyMB4hoVbTfB0mrhFLmXc1WP4WyCdWoD0wflBO1vypOrME4Benc
 L91NzKuNRTOh0dNu8CxHo4B8BzOUjoWpRxM7MZQYYQ==
X-Google-Smtp-Source: AGHT+IEQjj9TQ4wV38n8jiVxEkPB4pqx7hwLWUAIz58yT1lE3WfiLYWREcppqs7fooBw09ZICMN/hMQP3yvRSngT8F8=
X-Received: by 2002:aa7:d90b:0:b0:51b:d567:cfed with SMTP id
 a11-20020aa7d90b000000b0051bd567cfedmr1955373edr.5.1694181065267; Fri, 08 Sep
 2023 06:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230905091246.1931-1-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20230905091246.1931-1-shameerali.kolothum.thodi@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 14:50:54 +0100
Message-ID: <CAFEAcA-av-LmRw1f=cU4Mb9r-TS5gfmGBeKdcrsxHMtdJ7-bHQ@mail.gmail.com>
Subject: Re: [PATCH v4] arm/kvm: Enable support for
 KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, gshan@redhat.com, 
 ricarkol@google.com, jonathan.cameron@huawei.com, kvm@vger.kernel.org, 
 linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 5 Sept 2023 at 10:13, Shameer Kolothum
<shameerali.kolothum.thodi@huawei.com> wrote:
>
> Now that we have Eager Page Split support added for ARM in the kernel,
> enable it in Qemu. This adds,
>  -eager-split-size to -accel sub-options to set the eager page split chunk size.
>  -enable KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE.
>
> The chunk size specifies how many pages to break at a time, using a
> single allocation. Bigger the chunk size, more pages need to be
> allocated ahead of time.
>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> Changes:
> v3: https://lore.kernel.org/qemu-devel/20230830114818.641-1-shameerali.kolothum.thodi@huawei.com/
>    -Added R-by by Gavin and replaced kvm_arm_eager_split_size_valid()
>     with a direct check.
> v2: https://lore.kernel.org/qemu-devel/20230815092709.1290-1-shameerali.kolothum.thodi@huawei.com/
>    -Addressed commenst from Gavin.
> RFC v1: https://lore.kernel.org/qemu-devel/20230725150002.621-1-shameerali.kolothum.thodi@huawei.com/
>   -Updated qemu-options.hx with description
>   -Addressed review comments from Peter and Gavin(Thanks).



Applied to target-arm.next, thanks.

-- PMM

