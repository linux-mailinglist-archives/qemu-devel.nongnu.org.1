Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9416A72C2D3
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 13:33:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8fmC-0004BZ-C8; Mon, 12 Jun 2023 07:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8fly-000466-TP
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:31:58 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8flw-0006YM-0G
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:31:45 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30e4eec95c8so3824027f8f.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686569502; x=1689161502;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0lRSa8uXgbU2vS7vn3P34QBWuu/YgzpUHCegaOcpYAg=;
 b=VfaJLunSLRPPwOLgca0LYUU06aG7cGmBZK7eZ4ksj8Eaue8+MkMcMya+fglBgIncbb
 3Ey/Q/cHkUeaNzEymHfaf2Oa55uo6Iv5DSjjygsVg9cUg8rs0Vp4DNHmteskYhXglCia
 hq72Hj21GB3pU3IGjrs/3hQsOS+bwfv01D5v53LoXa9eKXBOuG+5F+8ssFYzjyvUR74a
 Dxed1nnBXN/0bUn2xT+XGkFhQhYQdbbHCh9Zv1RT3iznh9TNAJuEyw3hq6naPVHZuTh4
 3zhAKDH+qFbgoyJ+0DxgX+XoJOWZ+l2Dkur/EtKG59q1mhvdc1bK89BK7BceKW3/hbsM
 ai1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686569502; x=1689161502;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0lRSa8uXgbU2vS7vn3P34QBWuu/YgzpUHCegaOcpYAg=;
 b=WIx7h41XMXmKMK+wb/CipYXW++SnqOihBri9R0BSC5lxiKuGdT/MNMhAdPBZSQyJpo
 S0wadW4yIm66tHDFkWNTq6oSMYw+A19k11EFl8Q+J3iHn1Yyx91xw+lYRiqVjMzxcKH2
 GDXnyZp/aEUIpEyZz8ecgymhq2VLc5wHrSX7EoLbNaVBX0B0jI7azJzDkcb4JDdYcyK7
 Ap0KCHUSy+Qgp9mel9/rytnu2oC77wyx9Wl6pdKDgdlhwpxgSptTdL/5dTOUpF5KjwS3
 PboCkLCvFQIsJlctWfDx3L58ufHKPXBvtoj+cZoOeLhyfeE9p0CwzxQ9X3V4zmOtW5js
 aAdg==
X-Gm-Message-State: AC+VfDyWbUaqHrjtGI4WBWr/2R/0nvUDMA7Fegd1ywFFiY1Zfyt/eUe4
 F5jfSyMUgY8E5WkL+LAX2YVVqA==
X-Google-Smtp-Source: ACHHUZ6s6Ula1OYB5JXa/+HQ7+uEdM6NW/T4y+rWk0q5O0HEWuL8zJCebln3Ikk7qE6TzTht4rcIeQ==
X-Received: by 2002:a5d:58d0:0:b0:30f:be04:5b60 with SMTP id
 o16-20020a5d58d0000000b0030fbe045b60mr2726953wrf.56.1686569502692; 
 Mon, 12 Jun 2023 04:31:42 -0700 (PDT)
Received: from [192.168.112.175] (176.red-88-28-1.dynamicip.rima-tde.net.
 [88.28.1.176]) by smtp.gmail.com with ESMTPSA id
 m7-20020a7bca47000000b003f80b96097esm8501637wml.31.2023.06.12.04.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 04:31:42 -0700 (PDT)
Message-ID: <4559743a-51c5-9269-d360-f8cee96b597c@linaro.org>
Date: Mon, 12 Jun 2023 12:27:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 05/15] hw/pci-host/q35: Initialize PCI_HOST_BYPASS_IOMMU
 property from board code
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-6-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230611103412.12109-6-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 11/6/23 12:34, Bernhard Beschow wrote:
> The Q35 PCI host already has a PCI_HOST_BYPASS_IOMMU property. However, the
> host initializes this property itself by accessing global machine state,
> thereby assuming it to be a PC machine. Avoid this by having board code
> set this property.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/pc_q35.c  | 2 ++
>   hw/pci-host/q35.c | 3 +--
>   2 files changed, 3 insertions(+), 2 deletions(-)

:)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


