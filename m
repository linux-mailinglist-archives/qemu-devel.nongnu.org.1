Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5D37F70F7
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 11:11:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6T95-0001DD-8u; Fri, 24 Nov 2023 05:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6T8i-00018k-1x
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:10:25 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6T8c-0002z9-0w
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:10:22 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c72e275d96so22646981fa.2
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 02:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700820612; x=1701425412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hnxah0bDOygUKTy/KArMgq1c86fYPdHHBP231U9ow1k=;
 b=Me44kUkVR3xh3C5qu6drCI1LUPWYLC8prPB9/FC5ou2+BzEWIv0sT8e0s47fmsm96J
 88zsWcvixETbr1zl2cwzqI6zhfffP3oXmtm4j82Ao682m88yKaViwRsUZVm7Rnady0Hw
 ATNzVy+tvk8iAWgiwSNx9CpHWjeNiqD0/CiOt96GUqPS4OtZElcs2qIM6PuZtQRgi401
 6tlv1JrXqIu2oJYkfWvn4BJ/N2AcdpKfP0OjIzpS7fNsV4Ke8CFYqXjSYnlpXY9YVAXu
 CkWopcOSj1xTucXPB6L/anbpvave5i7md2lHxNYBworBcMXY3Mfn16nMXqUeGAgrpd59
 SakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700820612; x=1701425412;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hnxah0bDOygUKTy/KArMgq1c86fYPdHHBP231U9ow1k=;
 b=ifvNxB0QC7HPj6x3W7x01RWHhEayg42uThYwH5IYTsgl2W7XD8SMfUVAbOL/BA4Q6J
 /YH6Lfeb54rM3i8NpcZ1piLnHmvdiuA4Hzxb0ZJRWH+pJRNLF9eeDOwY0Y8biaalcXYb
 PPfFf/T4PmNiRDjYb4NTpfyq2q+1xTaYPeUURGxjO7GHa3aCL3DSr6WNj4sSpJjhmyH9
 7GiT7fqOKr60LyVkMx/FDlJ0VLTVGeKSTn0x/AeqTcvq5bo/xL/j4/ap99x+QAQpDF/p
 1TTn7+h13wm018qi4fAPWRH9pkFvnoZVl48T64nd9fVbtIJRqiYRAZNvvhFIg1s3dyw4
 eQpg==
X-Gm-Message-State: AOJu0Yy1bLmoYv9hs/B3fm2u/oNiY8I8H3wP15Hqplxl/6G2twHAiS/l
 i7K8yiWryjHKHl9paS1HhnnqrA==
X-Google-Smtp-Source: AGHT+IF8UkR+K4p1WrX4afYEDUdY6mTdI3166ASs5s4g4VsXfU+8WnW3x3EUTTdbsAtHsF35wQB5Zg==
X-Received: by 2002:a2e:91c3:0:b0:2b6:a804:4cc with SMTP id
 u3-20020a2e91c3000000b002b6a80404ccmr1764077ljg.53.1700820611797; 
 Fri, 24 Nov 2023 02:10:11 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a5d5107000000b00332c6a52040sm3885531wrt.100.2023.11.24.02.10.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 02:10:11 -0800 (PST)
Message-ID: <f77896fc-18b5-4f85-b621-89b84dc26b63@linaro.org>
Date: Fri, 24 Nov 2023 11:10:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ppc/Kconfig: Imply VFIO_PCI
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20231124080658.893770-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231124080658.893770-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

On 24/11/23 09:06, Cédric Le Goater wrote:
> When the legacy and iommufd backends were introduced, a set of common
> vfio-pci routines were exported in pci.c for both backends to use :
> 
>    vfio_pci_pre_reset
>    vfio_pci_get_pci_hot_reset_info
>    vfio_pci_host_match
>    vfio_pci_post_reset
> 
> This introduced a build failure on PPC when --without-default-devices
> is use because VFIO is always selected in ppc/Kconfig but VFIO_PCI is
> not.
> 
> Use an 'imply VFIO_PCI' in ppc/Kconfig and bypass compilation of the
> VFIO EEH hooks routines defined in hw/ppc/spapr_pci_vfio.c with
> CONFIG_VFIO_PCI.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/ppc/spapr_pci_vfio.c | 36 ++++++++++++++++++++++++++++++++++++
>   hw/ppc/Kconfig          |  2 +-
>   2 files changed, 37 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks for reworking it without adding more stubs :)

