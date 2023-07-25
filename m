Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0597C7618B8
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 14:48:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOHRI-0007Tx-Nk; Tue, 25 Jul 2023 08:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOHRD-0007Rt-CJ
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 08:46:52 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOHRB-00055X-2o
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 08:46:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742bso55038965e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 05:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690289204; x=1690894004;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vGZfR87BHs9oeqzgBVuatJQdA+4mkMBaJLIsLtfbPMk=;
 b=IdvQAPz4rzNdx7OL8RFglwYMiu6cp6MbguEYYalyfgi7NSkgrAQkZpthCM0XwLInGr
 j+/HMKAampiViKRO0eA54kSBi6rADyaLSAcZ6PIL+dZxJ1OpkBjHUXWCNlcC9x+nmf7k
 Qe6LCbezvt4NmXC7dnEKILuHWIvd7gnimZnCPnZGJD6POnyJq3u/FOgi1lfhqFhA6M3b
 ReDzcZ5jHHVzu6ySPu41T497968lBBU2YeIdArFulHFOzROh91lwlVqxbhVxtsw9rX9o
 F66+lw5Q8qkCKf3OR25EyClr9Eo8QEalfqR3kYtZGGTLjwWIFXlSE5r9OPNoDGLuP2L1
 NWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690289204; x=1690894004;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vGZfR87BHs9oeqzgBVuatJQdA+4mkMBaJLIsLtfbPMk=;
 b=jrTEP3SVUAY33kCOCudmUxiAJt/OxP4yAHaT8AOwjHiAYHDXLTBgJqNgy6w+V9e98e
 AZA5fd5rnPgLE9fLbTtXk4O37/b4VcVtAXNEDzf9vNf/6ioU04Sq71iNMkT+dFLoE09p
 +C/MERsO/Qaf8+YQKvqQexCqQ1l2YW/kXF4uo3j0qvyUrgSr09D5G1mbEiSdTfnXgDls
 O+0SxKi9kvSzLuxiAaQMSPitZuNOZRnFclxy5QEkVOqPJvSKuL6LjcHpVqt1J0/uoq2i
 QlcmdAmoECvoUwwC54bi3ngfbLqclgiEGu+7SZ9xGwmnzhC9wh5ijkVroNMeF7T2UYj9
 ntlg==
X-Gm-Message-State: ABy/qLYQmRsPsluDq1K+hn3q82WR9W+aPmELCzDKS6WG5MIDbOBVrTdL
 QB8CRY2OL52m+BmKRkiqFWPbfw==
X-Google-Smtp-Source: APBJJlH7WkK29a1HlMg6KsiP2yOw/oo3i/E0wfXrqpWMfC///b2qFLXwgOEIQBSoqt5Hwa+hxrpOXg==
X-Received: by 2002:a7b:c4d8:0:b0:3fb:d1db:545b with SMTP id
 g24-20020a7bc4d8000000b003fbd1db545bmr10280852wmk.20.1690289204286; 
 Tue, 25 Jul 2023 05:46:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a05600c21c300b003fa95890484sm13210500wmj.20.2023.07.25.05.46.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 05:46:43 -0700 (PDT)
Message-ID: <c090e018-9761-4cc0-61ce-780ff70e318a@linaro.org>
Date: Tue, 25 Jul 2023 14:46:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] kvm: Remove KVM_CREATE_IRQCHIP support assumption
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, peter.maydell@linaro.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 dbarboza@ventanamicro.com, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
References: <20230725122601.424738-2-ajones@ventanamicro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230725122601.424738-2-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 25/7/23 14:26, Andrew Jones wrote:
> Since Linux commit 00f918f61c56 ("RISC-V: KVM: Skeletal in-kernel AIA
> irqchip support") checking KVM_CAP_IRQCHIP returns non-zero when the
> RISC-V platform has AIA. The cap indicates KVM supports at least one
> of the following ioctls:
> 
>    KVM_CREATE_IRQCHIP
>    KVM_IRQ_LINE
>    KVM_GET_IRQCHIP
>    KVM_SET_IRQCHIP
>    KVM_GET_LAPIC
>    KVM_SET_LAPIC
> 
> but the cap doesn't imply that KVM must support any of those ioctls
> in particular. However, QEMU was assuming the KVM_CREATE_IRQCHIP
> ioctl was supported. Stop making that assumption by introducing a
> KVM parameter that each architecture which supports KVM_CREATE_IRQCHIP
> sets. Adding parameters isn't awesome, but given how the
> KVM_CAP_IRQCHIP isn't very helpful on its own, we don't have a lot of
> options.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
> 
> While this fixes booting guests on riscv KVM with AIA it's unlikely
> to get merged before the QEMU support for KVM AIA[1] lands, which
> would also fix the issue. I think this patch is still worth considering
> though since QEMU's assumption is wrong.
> 
> [1] https://lore.kernel.org/all/20230714084429.22349-1-yongxuan.wang@sifive.com/
> 
> v2:
>    - Move the s390x code to an s390x file. [Thomas]
>    - Drop the KVM_CAP_IRQCHIP check from the top of kvm_irqchip_create(),
>      as it's no longer necessary.
> 
>   accel/kvm/kvm-all.c    | 16 ++++------------
>   include/sysemu/kvm.h   |  1 +
>   target/arm/kvm.c       |  3 +++
>   target/i386/kvm/kvm.c  |  2 ++
>   target/s390x/kvm/kvm.c | 11 +++++++++++
>   5 files changed, 21 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


