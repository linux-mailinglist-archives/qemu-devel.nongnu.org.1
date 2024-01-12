Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DEC82C430
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 18:05:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOKwv-0003Wd-KX; Fri, 12 Jan 2024 12:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOKws-0003Vf-Qi
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 12:04:02 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOKwq-00039M-8t
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 12:04:02 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-555f581aed9so7796235a12.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 09:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705079037; x=1705683837; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pDqe/f5RnS26pRMEG8/pUrsnHizFnUylzEWIMObqyLU=;
 b=J+QxICk+nASoFIk73jC7otZzSVTPR5hlNESdmreiotedAVcDmKuMRaJsyayyr/T/bq
 EgHq0hqGXw5M3uxZ6hzrXvgH4cpUPk2qLJZzWzLdxWdoLzVJ10+aJ3CzgbfaRTkpqgIO
 nuwKNHV/TsOt85B36GMRN2Wx+A2/YpILZIJBQL4pwgIqIpjDjlqrWZX5FBm2b3THYEyl
 2HVUkmZXMxrlhceOVN9tzUiijWXZAXCP2csrS2LSyyw3xpR9xzlmTxrVlbueMLSI16u/
 dFrGNC8yyzOiNARQejRzFX7j4ZyHVS0bVpDrEEnGuyfEI1F+sytMSvDTy7UbovOFM65A
 IU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705079037; x=1705683837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pDqe/f5RnS26pRMEG8/pUrsnHizFnUylzEWIMObqyLU=;
 b=TOJlp4XLMuGo12txOXyHsENxk89kjMPtg60vfFh0DXCDtPV3nVv9/tKrvM8H4ynBUT
 nmXscq7yaqXU3h4/Be/bOCqqjDu87yp4ykjAXBiT+SWliQVDNYCivUb79XXugTxfIafd
 tHrSYGCzuFWj/SpzThCQKEDj26lQL3KFQLdTuDJDQIKPiaEj9PJoMktmmh2CvOPMJrSh
 dKWwglxT2ySb2kv0FSHpi+TxReBjq2Sb5igdOOZ6NFK92idjnhyN5HmK3EtwTD7xqMuh
 Ia3exJ5RK2RIR4kUPl8kw9W8xj/A8CJ5y3g22lAbGtSbVVErpSsXhkh82wcHn+Q7yDuO
 Ma9A==
X-Gm-Message-State: AOJu0Yy9+gdVZBN/jG4GgAZ+mGq1t9v62GxOsOBq7rVxkLCfFDFTd+jn
 Hg0oL8DioVrMBB0CcbvtU5UQDAHUEVhEY52rJy5Y027fkAY5EA==
X-Google-Smtp-Source: AGHT+IEtNEkBoI7eaba8bWCp/k+YgSGjrJGOoMn1R/fUaIvQ5gPFwlph1JJ5aYDsyNHsnrjdxyf/aqgXIpYnyuYQT48=
X-Received: by 2002:a05:6402:1205:b0:557:1ba9:4abf with SMTP id
 c5-20020a056402120500b005571ba94abfmr897858edw.23.1705079037611; Fri, 12 Jan
 2024 09:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20240109124333.224240-1-shlomop@pliops.com>
In-Reply-To: <20240109124333.224240-1-shlomop@pliops.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 17:03:46 +0000
Message-ID: <CAFEAcA9WYrhuokJ_ox5CH0Et+WxiB_dwfHtsTZCb9cCfAveL9w@mail.gmail.com>
Subject: Re: [PATCH V2] Handle wrap around in limit calculation
To: Shlomo Pongratz <shlomopongratz@gmail.com>
Cc: qemu-devel@nongnu.org, andrew.sminov@gmail.com, peter.maydell@linaro.com, 
 shlomop@pliops.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 9 Jan 2024 at 12:45, Shlomo Pongratz <shlomopongratz@gmail.com> wrote:

Hi; thanks for this patch.

> Hanlde wrap around caused by the fact that perior to version 460A

Is this "460A" version number a version of the hardware
we're modelling ?

> the limit was 32bit quantity.
> See Linux kernel code in:
> drivers/pci/controllers/dwc/pcie-designware.c

"/controller/"

> function: __dw_pcie_prog_outbound_atu

There don't seem to be any comments in this kernel function
that say anything about wrap-around:

https://elixir.bootlin.com/linux/latest/source/drivers/pci/controller/dwc/pcie-designware.c#L468

so I'm not sure what you're trying to explain by referring to it.

> Now in a 64bit system the range can be above 4G but as long as
> the limit itself is less then 4G the overflow is avoided
>
> Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
>
> ----
>
> Changes since v1:
>  * Seperate subject and description
> ---
>  hw/pci-host/designware.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index dd9e389c07..7ce4a6b64d 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -269,11 +269,24 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
>  {
>      const uint64_t target = viewport->target;
>      const uint64_t base   = viewport->base;
> -    const uint64_t size   = (uint64_t)viewport->limit - base + 1;
>      const bool enabled    = viewport->cr[1] & DESIGNWARE_PCIE_ATU_ENABLE;
> +    uint64_t tbase, tlimit, size;
>
>      MemoryRegion *current, *other;
>
> +    /*
> +     * Hanlde wrap around caused by the fact that perior to version 460A
> +     * the limit was 32bit quantity.
> +     * See Linux kernel code in:
> +     * drivers/pci/controllers/dwc/pcie-designware.c
> +     * function: __dw_pcie_prog_outbound_atu
> +     * Now in a 64bit system the range can be above 4G but as long as
> +     * the limit itself is less then 4G the overflow is avoided
> +     */
> +    tbase = base & 0xffffffff;
> +    tlimit = 0x100000000 + (uint64_t)viewport->limit;
> +    size = ((tlimit - tbase) & 0xffffffff) + 1;
> +

I find this patch a bit confusing, partly because the comment
seems to be written from the perspective of what the kernel
driver is doing, not from the perspective of the hardware
behaviour.

What is the behaviour of the actual hardware here, both before
and after 460A ? Which version are we trying to model?

thanks
-- PMM

