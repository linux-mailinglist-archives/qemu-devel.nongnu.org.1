Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D70CE80F369
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:43:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5q2-0002KO-7q; Tue, 12 Dec 2023 11:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD5px-0002Jq-8T
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:42:26 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD5pt-0004MB-JV
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:42:24 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-54dcfca54e0so7634363a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702399340; x=1703004140; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6V3XEQ7dCz9Oc4xHbCPWCUQ4m1Buvb3dGtaqJs6JjpQ=;
 b=VAmm3vbLMPJggSTX6imGVkE6L8nTck7IBL+T4S/q4VwIvzXd/ZueHh5u62Ex42no1a
 x9+YY/l4yqi6NG0fmjIUMb3GiF9roZkfB5GC92R2UB+hoaVVIcO4a+TxEyBnMAuduvOA
 6pKZpQodgs2lAVA4euIQmBOZihHQ7QiryTN1rXSNhTnT34rCnvsTSCyE3Rd2/qeWjNcN
 giVFqFpflBO169E0M/oiCh2OMJR8l0qw5GnzLSYJiv+YLl8VK2bWri8giUY/o41RjXLT
 vfSScnyyt3xUai5hJazq1yxp4kB6u8lyjnX/05E9kOJ1ifOmUg2NsNAfb8GPNC4UnSQT
 RZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702399340; x=1703004140;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6V3XEQ7dCz9Oc4xHbCPWCUQ4m1Buvb3dGtaqJs6JjpQ=;
 b=dP+IwVg9EJz1i2fpyuw+G9y78HTkvkl0q2wMxJFVPz1cLrA6YyjXMJ4Pl4VAbD9GB1
 94Aei3De+g0TH+U/4dKc3pFdQwzvkfAwwoCCl+ewm3RZ8TtcCUFvu5JExqhVnw4UOLd9
 yr9RUGgNA3lM09bzoEfhZzQ9kHV0qG8P0Ct8SZxnvN3IBpmU7GNG9K10cTQuJX1Cb6o8
 0UcveXUnTKxX879vboAv/v/x2IJjFeKKLsgMfQECA3FlJLt6x3bQlN7QzT4SeULh0fFV
 NK15wh/ABiQS3SxsE3q2Kg21HFDCV25a2Jkn/d59INJNnEUMWkIWAiioRYEPvTEjJL5m
 Jiwg==
X-Gm-Message-State: AOJu0Yw+AW8M7k8JBR7gvdMqlkKTtuhRt3Bm/z6rBsfklwVQ2qSaVcv3
 kvp+GU7Zhw3aBqzP4fXkkKkyZPPyPAlYl8AsXJpTag==
X-Google-Smtp-Source: AGHT+IGy0QlesDTzuSOWTXAzg7CzvMePquzPe1ngvhqUHI/WOr9dSZ91dxOUaTd8ELS0lH71x/9Cc8xVFYWUfjJviTA=
X-Received: by 2002:a50:c94d:0:b0:54b:fea4:c57f with SMTP id
 p13-20020a50c94d000000b0054bfea4c57fmr3959506edh.25.1702399339992; Tue, 12
 Dec 2023 08:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20231205100802.2705561-1-sai.pavan.boddu@amd.com>
 <20231205100802.2705561-2-sai.pavan.boddu@amd.com>
In-Reply-To: <20231205100802.2705561-2-sai.pavan.boddu@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 16:42:08 +0000
Message-ID: <CAFEAcA_gyAEs5PmTy6Edfep5HrwG6Prgij18MT1PeysV++=3Tw@mail.gmail.com>
Subject: Re: [PATCH 1/1] xlnx-versal-ospi: disable reentrancy detection for
 iomem_dac
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Kevin Wolf <kwolf@redhat.com>, Francisco Iglesias <frasse.iglesias@gmail.com>,
 saipavanboddu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 5 Dec 2023 at 10:08, Sai Pavan Boddu <sai.pavan.boddu@amd.com> wrote:
>
> The OSPI DMA reads flash data through the OSPI linear address space (the
> iomem_dac region), because of this the reentrancy guard introduced in
> commit a2e1753b ("memory: prevent dma-reentracy issues") is disabled for
> the memory region.
>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> ---
>  hw/ssi/xlnx-versal-ospi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
> index 1a61679c2f..5123e7dde7 100644
> --- a/hw/ssi/xlnx-versal-ospi.c
> +++ b/hw/ssi/xlnx-versal-ospi.c
> @@ -1772,6 +1772,7 @@ static void xlnx_versal_ospi_init(Object *obj)
>      memory_region_init_io(&s->iomem_dac, obj, &ospi_dac_ops, s,
>                            TYPE_XILINX_VERSAL_OSPI "-dac", 0x20000000);
>      sysbus_init_mmio(sbd, &s->iomem_dac);
> +    s->iomem_dac.disable_reentrancy_guard = true;

Where we set this flag we should have a comment explaining why
we need to do it, please.

PS: for a single patch you don't need to use a separate cover letter;
cover letters are only needed for multi-patch series.

thanks
-- PMM

