Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABFE7B7AF3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:01:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxeX-00036N-NG; Wed, 04 Oct 2023 04:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxeT-0002zr-Ri
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:54:41 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxeR-0001bb-4b
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:54:40 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-405505b07dfso3725915e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696409677; x=1697014477; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ovgClf4L331W0xhcDjLJLOTgkITxTnjgVNWkSmKgIn0=;
 b=fbNxV74ARTOYLiCv3QOLvAOqV65wosf1vMh+gPFVi/cUUfyfaGnie60EPhb1pez/uR
 wriFxr6Bi0fpG0likGvZVHp1+1Nbwifv9tKmvyNRkzDqPzBZlUY7UwcNGcRwJC2qs/pz
 tBzqQ07zaTIG/yBiGndQodpIFkwYlhQvvpg3Za2DgkmX0hWQZeztKGf25F1CXyT+2gOv
 nAjzFA+fUR9MXmSbtG7LVm8tLmqQhI5ttop7UcQ7qNeZqb+NvdtYE+sRn2xKLFN4BI/1
 zjvbYYaUOANbya+8l/Rt4nEY+2LvsantnaFcM2LkOGELudgvpkA8LnzL+kNZYTDun58I
 HDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409677; x=1697014477;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ovgClf4L331W0xhcDjLJLOTgkITxTnjgVNWkSmKgIn0=;
 b=RAOAqhSmVRQJ82LfS1tH+L/ax2VNouM976iO40Rdqjhwm7p8aEaYv6h9hESFMA9NbI
 a4CnGtPbE8UbRjvos94UkBF7VsEsFuBbRmk3yIdpgsL+bfiCTn8o20U/pbUsW/xaA7k1
 sZ3+JxRGaQUd6sxG95WxTlpRAOjQtaaXvkUCZk8+e6uncuV/3qzsV3fef7lw/tuaWMQw
 QialNtb11X5ceTZ4auz66UzJc11laH98h3iX/LjqZKWBice9/bGdcrOk0/U6206u1XKJ
 9PDeu4B9x5GWNTUwZXtCquriG/WJINKlSAxEsdH5YgUXtlAVu4OwQh6F1ERbqqLm9IMp
 VLbw==
X-Gm-Message-State: AOJu0Yyla4VwTFbzNYbPgGNey5QVaTFYNoB34JLWrb/oBBkzu/8EDAn1
 bX3M0I4idKaB4PIm41dqTDbMYg==
X-Google-Smtp-Source: AGHT+IFRLtvcg+V51L8gOzMBodPHSfpLfq/ShIywsh6a0n2NqFRYWyWL7D44w15u6XOJ9/fIcwspAw==
X-Received: by 2002:adf:f8c3:0:b0:31f:e7f9:628e with SMTP id
 f3-20020adff8c3000000b0031fe7f9628emr3934179wrq.17.1696409677286; 
 Wed, 04 Oct 2023 01:54:37 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 p21-20020a05600c205500b003fefaf299b6sm957822wmg.38.2023.10.04.01.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 01:54:36 -0700 (PDT)
Message-ID: <aa1bc6ef-e444-7ec4-683d-5f437007bfe0@linaro.org>
Date: Wed, 4 Oct 2023 10:54:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PULL 00/63] virtio,pci: features, cleanups
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1696408966.git.mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 4/10/23 10:43, Michael S. Tsirkin wrote:

> ----------------------------------------------------------------
> virtio,pci: features, cleanups
> 
> vdpa:
>        shadow vq vlan support
>        net migration with cvq
> cxl:
>       dummy ACPI QTG DSM
>       support emulating 4 HDM decoders
>       serial number extended capability
> virtio:
>        hared dma-buf
> 
> Fixes, cleanups all over the place.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------


> Philippe Mathieu-Daudé (6):
>        hw/virtio: Propagate page_mask to vhost_vdpa_listener_skipped_section()
>        hw/virtio: Propagate page_mask to vhost_vdpa_section_end()
>        hw/virtio/vhost-vdpa: Inline TARGET_PAGE_ALIGN() macro
>        hw/virtio/vhost-vdpa: Use target-agnostic qemu_target_page_mask()
>        hw/virtio: Build vhost-vdpa.o once
>        hw/virtio/meson: Rename softmmu_virtio_ss[] -> system_virtio_ss[]

Woohoo \o/ thanks for merging this!

