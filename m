Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED518742138
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 09:43:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEmIg-0001du-Rg; Thu, 29 Jun 2023 03:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEmId-0001cF-PF
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:42:43 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEmIb-00067P-US
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:42:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fa94ea1caaso2623905e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 00:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688024560; x=1690616560;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DGr3XOLFv8vV7+ZkTA73lewKsSaSOW2t97q/2DlG0Vc=;
 b=Z3MaZPdYM8Uq/psXrXD93KZw23nZB3kEoFGLGxO401iyUByOH8/AZeNjL+f9W2H0xk
 4hUc2Lq8SJBRguMMIF6BO/ZAEnnzkdcN9SnXWYC1ZCLgPSiMD6MFE9/EOPI41FH2Bbnh
 Xk3KgncxjZBvKsqFhskQ8qWyphNxLL44VDBCAmqk6sbQFarC1qPQ0Pvvc7iEBPEUhuUh
 TNK8HyiamYIN2ltriWngA7W+eMkmDUc2Wihqi5PSMrfMd6zexbFKmTmm3OE+twzjnEec
 3339P7v5mc1Or3UfxJLjUBu6Fe4ZCv/hrCI9lYCS+BYlnZDsY+GOoUi6k5oZc1Her4Nv
 1TjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688024560; x=1690616560;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DGr3XOLFv8vV7+ZkTA73lewKsSaSOW2t97q/2DlG0Vc=;
 b=BWtYZsMaueDo+Y/cFIT2SCHHNUXvCs5jSOu4B3OolSBtjsf8v8sbCubdTNUgvfsSDb
 l4CEvk+U+828xdCexkb+S4yS7SO4Bpbf9hN5X8fDBaNdOibeJI8EKA1OGw3XjAJH5BUn
 5qvwLtts8L57jJZFQwuRcHRLSTBwnc03BJ1j8Vjp6zR/HCuSCWTB9Vh7JD3nDkVCcnYl
 L6sk2kJLNZfEfane+pfPoydh2cvDca2ylP4I2w7JxAxpUtQn28RH4uDd6eG+DGNbh7a0
 Kxc4+rIfq9fmxmaW5JkyGTWRqmCa8ivsKwt/pnWWw9AiRk/irFs3eQTmZgysv6tYAlpT
 wvlg==
X-Gm-Message-State: AC+VfDxLWePlA6nzVBxytxt8Bdkq8yUOWUPbRvQdGDl54gKVoHGs1HaO
 4tA3NEkJZeXky+TS39DaYpk07g==
X-Google-Smtp-Source: ACHHUZ7i2p+vGUjaXFRJL6z7YcO3hrmd3NBZAuzGDNm/7fSjpIzEp8wiX00iPIXBPlinzvS10ArBoA==
X-Received: by 2002:a7b:ce8d:0:b0:3f7:e660:cdc5 with SMTP id
 q13-20020a7bce8d000000b003f7e660cdc5mr3465256wmj.9.1688024560200; 
 Thu, 29 Jun 2023 00:42:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a1c7718000000b003fba9db141esm5591905wmi.38.2023.06.29.00.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 00:42:39 -0700 (PDT)
Message-ID: <a064065d-217d-af70-9e44-a08a41e24575@linaro.org>
Date: Thu, 29 Jun 2023 09:42:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 02/16] hw/pci-host/q35: Fix double, contradicting
 .endianness assignment
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230628195204.1241-1-shentey@gmail.com>
 <20230628195204.1241-3-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230628195204.1241-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 28/6/23 21:51, Bernhard Beschow wrote:
> Fixes the following clangd warning (-Winitializer-overrides):
> 
>    q35.c:297:19: Initializer overrides prior initialization of this subobject
>    q35.c:292:19: previous initialization is here
> 
> Settle on little endian which is consistent with using pci_host_conf_le_ops.
> 
> Fixes: bafc90bdc594 ("q35: implement TSEG")
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/pci-host/q35.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



