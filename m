Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BA474707C
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:10:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGeqo-0005Qh-LA; Tue, 04 Jul 2023 08:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGeqm-0005Pz-3G
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:09:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGeqk-0004Bz-1V
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:09:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbc54caad5so50573815e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688472580; x=1691064580;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=18Y4eZWtTdRkabjtGGT0SruVFphlbyVq2+WwpHWURkE=;
 b=kuAkpFekGcjVIzaHG2M3+NwiEliDRk7u439ntKc6mP/orh/9FCjZilDrAUXRHzqHX0
 Vzu5wFY9NsNBmTRmPBgDMTKVzH6QRYWNYiWU+tIiRa9rMOm3/nid9ufJwTXWYCXUePwY
 N3hb60X614FL6YQ5EoRpVYA27/H4FKpIKShsUjUfLoE7/GCiJ/QT+xHJSo94vWpExKWl
 5qT1DHIVeUl9qMEfrvxP8ohGF/wlXv1cPestrZtzCj7jm6kEYmdSn/OLXWbznDpquIrq
 HWfSHgnBEQmI4bihc6iygm0gLyEnnGp++6xX6ZHntz5db7xGxOKFbV06sWZHodvh56cy
 5CKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688472580; x=1691064580;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=18Y4eZWtTdRkabjtGGT0SruVFphlbyVq2+WwpHWURkE=;
 b=TV2gf/UawVR2jbhy/zYTt9QzDjBou2yYyK5Hx4gk/oHvWU1/6KDyb+7durSFwsrjaP
 XpAtjU+IT5NoLsla0pP60FvxjuwOo6RWvdg1N2oVCYtVTXR0U3MtIZFngN4uJnIbNldi
 bxe2AV8EMER8RF888FeJk/LqCR3FUvn5vNw1XsYnqW1/13KNW2sIlDNThdKbJyi0uMVh
 l58aR7BOdLPBLdbx+AjjomdKAwCStDXkQyTZAfe4Iy7nkGuivzxtch2QP3RtWLcMkLAq
 Ki8N8jKL9X6QGC+o8zCOAwf1GvIKcbe1ra5DE44NrTVX6hLcS+CkFKs2xiNW5i1tVd/T
 GaCQ==
X-Gm-Message-State: AC+VfDzzFG/dvlQnYZlO2bb27UXqfgxy0gDnAdKUyeqlFvfASnVXbPTo
 Zcq8R0BLTYXBL52e/i2ZiBC6Vw==
X-Google-Smtp-Source: ACHHUZ6I68Mf5prFPg7O2PaRCxembJ2vUlGDMT/H5Yh4fnA3PunO678eJar2WRARt1/NnzWvXXkH8w==
X-Received: by 2002:a1c:770c:0:b0:3fb:b5dc:dab1 with SMTP id
 t12-20020a1c770c000000b003fbb5dcdab1mr9964168wmi.39.1688472580211; 
 Tue, 04 Jul 2023 05:09:40 -0700 (PDT)
Received: from [192.168.1.102] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 24-20020a05600c229800b003fa98908014sm24708459wmf.8.2023.07.04.05.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 05:09:39 -0700 (PDT)
Message-ID: <6fb9e146-7ace-0db6-305b-f6fc135878c1@linaro.org>
Date: Tue, 4 Jul 2023 14:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2] kconfig: Add PCIe devices to s390x machines
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20230704120137.2604646-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230704120137.2604646-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 4/7/23 14:01, Cédric Le Goater wrote:
> It is useful to extend the number of available PCI devices to KVM guests
> for passthrough scenarios and also to expose these models to a different
> (big endian) architecture. Include models for Intel Ethernet adapters
> and one USB controller, which all support MSI-X. Devices only supporting
> INTx won't work on s390x.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>   Tested under KVM as a machine device, under KVM nested as a passthrough
>   device
> 
>   hw/s390x/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
> index 5e7d8a2bae8b..7a82c58cdf6e 100644
> --- a/hw/s390x/Kconfig
> +++ b/hw/s390x/Kconfig
> @@ -10,3 +10,7 @@ config S390_CCW_VIRTIO
>       select SCLPCONSOLE
>       select VIRTIO_CCW
>       select MSI_NONBROKEN
> +    imply PCI_EXPRESS

No, PCIe is a bus, which is implemented in s390-pci-bus.c;
S390_CCW_VIRTIO exposes this bus, so we Kconfig SELECT it.

> +    imply E1000E_PCI_EXPRESS
> +    imply IGB_PCI_EXPRESS
> +    imply USB_XHCI_PCI

These are devices you can plug on a PCIe bus, so Kconfig
IMPLY is correct.

