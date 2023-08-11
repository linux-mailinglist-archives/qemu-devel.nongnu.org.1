Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0D9779623
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 19:31:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVyH-00086P-TB; Fri, 11 Aug 2023 13:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qUVxz-00085j-Cl
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:30:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qUVxq-0001Oe-J6
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 13:30:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fe8a1591c8so5850555e9.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 10:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691775017; x=1692379817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nLc7FbLhOnq2DIpEXkd5oX3SDFqmQkc87Ir3u2nOo0Q=;
 b=eGNLs0D+gSKeANK+bRRqlH2twcyDQ+2ATenZIoBU/O7lBwGHgM8RK/PQSfn8gGG4WO
 CoDVaBqltMRgJHS4JR1nhcu2MixoUoEfdEP0BIfiLYTA/QKdv3kjeQ9ebNvyouLub8WF
 uGovQRWyNRp9kq0CG9eNDkvsc92/kEolpFAEpc4RdK8Fl5hGkphkuQOR0swKmhVAO9+S
 Jyww4AJLBQGRl9L83s7Uw/5cZsr8Hk/KHcjtbuABtwWG2cLR8RxVjFm3pBkj2sn0c0vG
 AxHGU66PUvcq6jJerp6vD2CqpYQWyHn4v0p08bOGd3U4KkqjDwjjzf6f8Yf8jcf2ngvS
 1Opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691775017; x=1692379817;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nLc7FbLhOnq2DIpEXkd5oX3SDFqmQkc87Ir3u2nOo0Q=;
 b=k7n4eupzqSRsS6iMljuvzb/f6+rnHhhGzXomwqg3FSrTa9udmZ47YzUKIWy2MmIKqC
 WuBCQAWUSA/ayT2+8wTia6/Dorj5HSAmPfx4nrtGynnKCCviTynLk27x2/tNKCcHYmZm
 TmRMCVtK+k9EP0xcH9T+o//UWKGxq0o3TlDZ84w2K63zfO+FZ0pXSNZkXCi+TDFhoP/J
 ZVs8o+sLPncUdeqe8MZCtnjw/Q+erSZ6G3jaYd78FT4h0cdEzv0FbnWkY5fZiHgnaHs7
 kMn8EaRwrnU0x9ZVs3/Pzq+UpP+Fil0bX5M9Rwg7HrwrlMAi8ghjBUeBMOWZxSQGCEft
 j5BQ==
X-Gm-Message-State: AOJu0YzppER81XHn279v0bqjfdouj0Tlj+RVkM9KPUNshULzY0Hrp5+8
 4jf32qrzzVmxvSluYPnIFMgSbg==
X-Google-Smtp-Source: AGHT+IFCb6gc4sPPmaBkL3EvRcMTvgvPJn9W5oTSywMQqA6o4CBejFjdUiJ+L7HtbRNZaw7guw1JNQ==
X-Received: by 2002:a05:6000:137c:b0:317:5c82:10c2 with SMTP id
 q28-20020a056000137c00b003175c8210c2mr2086439wrz.59.1691775016767; 
 Fri, 11 Aug 2023 10:30:16 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.219.164])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a5d5089000000b0031434c08bb7sm6069567wrt.105.2023.08.11.10.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Aug 2023 10:30:16 -0700 (PDT)
Message-ID: <410cf104-74a8-08d1-2907-7c015a156327@linaro.org>
Date: Fri, 11 Aug 2023 19:30:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PULL 1/2] hw/pci-host: Allow extended config space access for
 Designware PCIe host
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jason Chien <jason.chien@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jason Wang <jasowang@redhat.com>, Chien@redhat.com, &lt@redhat.com,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
References: <cover.1691770630.git.mst@redhat.com>
 <3d449bc6030904ead784a4e4644c9640c2152796.1691770630.git.mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <3d449bc6030904ead784a4e4644c9640c2152796.1691770630.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.972,
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

On 11/8/23 18:18, Michael S. Tsirkin wrote:
> From: Jason Chien <jason.chien@sifive.com>
> 
> In pcie_bus_realize(), a root bus is realized as a PCIe bus and a non-root
> bus is realized as a PCIe bus if its parent bus is a PCIe bus. However,
> the child bus "dw-pcie" is realized before the parent bus "pcie" which is
> the root PCIe bus. Thus, the extended configuration space is not accessible
> on "dw-pcie". The issue can be resolved by adding the
> PCI_BUS_EXTENDED_CONFIG_SPACE flag to "pcie" before "dw-pcie" is realized.
> 
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> Message-Id: <20230809102257.25121-1-jason.chien@sifive.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Jason Chien &lt;<a href="mailto:jason.chien@sifive.com" target="_blank">jason.chien@sifive.com</a>&gt;<br>

<8^)

> ---
>   hw/pci-host/designware.c | 1 +
>   1 file changed, 1 insertion(+)



