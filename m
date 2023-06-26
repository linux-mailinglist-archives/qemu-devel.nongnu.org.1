Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDBB73E367
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:33:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoCq-0004l1-Ih; Mon, 26 Jun 2023 11:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoCo-0004iu-67
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:32:42 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoCm-0001VX-7C
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:32:41 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-313f04ff978so1186417f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793558; x=1690385558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=07YmmpvryE8y31GJXhjqvprJFldKjd8V6psOPC1D40Y=;
 b=lHxlYbXvhMTOjK6tIT9uX385aNNgyjxyghsvNlM6S5QcceeJOd/sZlbjj5BYKZKwQo
 T45QazsdS5YD4DzuYeehsoAb2DFX6URC/M/+BFbMWp/JOeTR/H+aTQFPwjPfVggr9RXW
 +99RWAbcUDXlkO5nQtM9kFlnVDzx9Wihv11+eHnHm59iQfdWNcYZmT42VRQu2P9fjenu
 PHunlsEp3IpE/O0JKPSSnL4TYs0WKwnEnOAMV99NJ7EeKMCG6RdSrJbie6pBSmic5IKx
 RPRG94Bh4d3arBEw/uy3tNVCNLYPap8dS7w9D/l1Oh7AXtjEonSVPbOeJQITG9LWDmNI
 qm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793558; x=1690385558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=07YmmpvryE8y31GJXhjqvprJFldKjd8V6psOPC1D40Y=;
 b=IEEPJsUCiX3vpEy4YxBK8QFQzrngsQPuIr9mp5dRFEGYlgkfsciJCfBpQextV0Bq9l
 T5jdXBzQc9a2ljhLWu01G9HzWLaQZNrO4E89vzZNLIdu6wK7WafegSGn9bEbCbSDjiiu
 r6uLJEc0xpbJSx0A6ritlRignBj4MijOJGFDHsxQD/P9NAV2DoBDAz5E9k1jrBGmXbbI
 4KCBB57cgitg6IIxzYCfhPOT+aWq+Tb8djvsSw+LDjbKyX7jtqJrf1TkdZUX/XtMQyCw
 9an29u0mvCBqabMqagrobtkrNBZ33bypHeNQET5bVaNjBH0g/zvjsn2hZjG2hMaYZ4Dh
 cM0w==
X-Gm-Message-State: AC+VfDynHypFm19joXmEX1Ljw33zzfF2hGUrjMIcUMy9So/1n47UzMX4
 4y0KwFCLDvVMtJtpiWBEHX6G1X+mRqGXl+lJHg3IBEA3
X-Google-Smtp-Source: ACHHUZ43s2cj1AbLQvYUwSKKWtSheEGQI/MJfQ5n23jwJMoxenImiAXypMVl+vgtkkEW06mpU17N1w==
X-Received: by 2002:adf:cd06:0:b0:306:46c4:d313 with SMTP id
 w6-20020adfcd06000000b0030646c4d313mr20171511wrm.28.1687793558146; 
 Mon, 26 Jun 2023 08:32:38 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a5d6250000000b003068f5cca8csm7659023wrv.94.2023.06.26.08.32.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 08:32:37 -0700 (PDT)
Message-ID: <eb81441d-da77-e846-4aee-fe7b232e7781@linaro.org>
Date: Mon, 26 Jun 2023 17:32:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/53] virtio,pc,pci: fixes, features, cleanups
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1687782442.git.mst@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/26/23 14:27, Michael S. Tsirkin wrote:
> The following changes since commit b455ce4c2f300c8ba47cba7232dd03261368a4cb:
> 
>    Merge tag 'q800-for-8.1-pull-request' ofhttps://github.com/vivier/qemu-m68k  into staging (2023-06-22 10:18:32 +0200)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git  tags/for_upstream
> 
> for you to fetch changes up to 3d90d47995b83bd1edf6e756c00e74fd5ec16aee:
> 
>    vhost-vdpa: do not cleanup the vdpa/vhost-net structures if peer nic is present (2023-06-26 08:26:40 -0400)
> 
> ----------------------------------------------------------------
> virtio,pc,pci: fixes, features, cleanups
> 
> asymmetric crypto support for cryptodev-vhost-user
> rom migration when rom size changes
> poison get, inject, clear; mock cxl events and irq support for cxl
> shadow virtqueue offload support for vhost-vdpa
> vdpa now maps shadow vrings with MAP_SHARED
> max_cpus went up to 1024 and we default to smbios 3.0 for pc
> 
> Fixes, cleanups all over the place. In particular
>      hw/acpi: Fix PM control register access
> works around a very long standing bug in memory core.
> 
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


