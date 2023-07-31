Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCBE769991
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:32:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTvZ-0008SH-37; Mon, 31 Jul 2023 10:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTvX-0008Rm-9x
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:31:15 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTvV-0002Ea-NH
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:31:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe20e7e5caso11266015e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 07:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690813871; x=1691418671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3HySA3W+K1+tfTye0CohDBSCFD3dSPCVOaxmgIA/hsE=;
 b=AzZo+uKtrjQ0CXM+n0MEdKhLSCOFQggQ5amnEedqOAa9PAKPO+EW+xzBWFgaY7D+Lz
 xIKecPSUjNBqcgONGfoaH5ZykEzXARDDzvgbmlP2JrbYmYy7F6ifiC4e27EgbrgUikC4
 isuT84K9koWUsNqzULZKfY75j/juah3+nkKY2F8OejEZUwdwTz0zW8jPfhyFNiFKeUvy
 DQ92gjnmmMUroo0WJjBGNPZ4CGswuISvQdv4U8edGkCd1n5nNVka7qtGHyrV89QjtKvQ
 AbJ5qQTY1gtrUzepFh1WFjlLWVWN7lz96Dxc6oNbGswI4D/cmW0BNth2eI97IxH81d66
 xMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690813871; x=1691418671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3HySA3W+K1+tfTye0CohDBSCFD3dSPCVOaxmgIA/hsE=;
 b=Fv/srQo2bSvky5lsktl9Lyrzqe7J2+wNcHasdiQQz4Dx2BlsVXzfXfICGhd33MMl7u
 kfmr66m+pOAHaj29VEKwXOgDRdqT+sV1k7hrnw6tzdUXGdBIlfwxA8HyMi5QGjfVKJmK
 ltc/0qbK5EvlxeVrckkIbLrqcTZ7ZgnxbnRYiBKjoQi8iXViXtW3mn95WxFNmP+bXBcM
 mqLUxs37ChBzz1DpOxBGIQ/Vv5ckEdI7eoPsc1CjKeAPvx75UsJVE5PQ4G6PP+XltXjk
 zIWCzI9DR7NndznEBTiTvo2I9y+IWYzhAo2UF8dw3612o4Jq7PGPBoKgnI2yBlug9YWt
 I4cw==
X-Gm-Message-State: ABy/qLZxkLRad8i2lYaFHrJw4sOIxN0fVoJ2frZHPGkayA6BICZPdj3S
 sz37XZx/pgFQIXsmnl5qmNi5h8lV0ms6tI1bNBs=
X-Google-Smtp-Source: APBJJlEPQNIzHCmZ56Dd2t69Arbk93xlC3MBexeOaYffzVSq7pxOkridgWUfj4JVS+mrdZmeU08x1w==
X-Received: by 2002:adf:e98e:0:b0:317:5c82:10c2 with SMTP id
 h14-20020adfe98e000000b003175c8210c2mr9258242wrm.59.1690813871265; 
 Mon, 31 Jul 2023 07:31:11 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.198.42])
 by smtp.gmail.com with ESMTPSA id
 l11-20020adfe9cb000000b00314329f7d8asm13256202wrn.29.2023.07.31.07.31.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 07:31:10 -0700 (PDT)
Message-ID: <95b7fe87-0a0d-7182-7706-e119769d4d59@linaro.org>
Date: Mon, 31 Jul 2023 16:31:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/5] Refactor i.MX6UL processor code
Content-Language: en-US
To: Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
References: <cover.1690663106.git.jcd@tribudubois.net>
 <6795fbc55daf5bdf196bf98f1ff8ac1891fe5a1e.1690663106.git.jcd@tribudubois.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <6795fbc55daf5bdf196bf98f1ff8ac1891fe5a1e.1690663106.git.jcd@tribudubois.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

Hi Jean-Christophe,

On 29/7/23 23:17, Jean-Christophe Dubois wrote:
> * Add Addr and size definition for all i.MX6UL devices in i.MX6UL header file.
> * Use those newly defined named constants whenever possible.
> * Standardize the way we init a familly of unimplemented devices
>    - SAI
>    - PWM (add missing PWM instances)
>    - CAN
> * Add/rework few comments
> 
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---
>   hw/arm/fsl-imx6ul.c         | 149 ++++++++++++++++++++++++------------
>   include/hw/arm/fsl-imx6ul.h | 149 +++++++++++++++++++++++++++++++++---
>   2 files changed, 239 insertions(+), 59 deletions(-)


>   enum FslIMX6ULMemoryMap {
>       FSL_IMX6UL_MMDC_ADDR            = 0x80000000,
> -    FSL_IMX6UL_MMDC_SIZE            = 2 * 1024 * 1024 * 1024UL,
> +    FSL_IMX6UL_MMDC_SIZE            = (2 * 1024 * 1024 * 1024UL),
>   
>       FSL_IMX6UL_QSPI1_MEM_ADDR       = 0x60000000,
> +    FSL_IMX6UL_QSPI1_MEM_SIZE       = (256 * 1024 * 1024UL),
> +
>       FSL_IMX6UL_EIM_ALIAS_ADDR       = 0x58000000,
> +    FSL_IMX6UL_EIM_ALIAS_SIZE       = (128 * 1024 * 1024UL),
> +
>       FSL_IMX6UL_EIM_CS_ADDR          = 0x50000000,
> +    FSL_IMX6UL_EIM_CS_SIZE          = (128 * 1024 * 1024UL),
> +
>       FSL_IMX6UL_AES_ENCRYPT_ADDR     = 0x10000000,
> +    FSL_IMX6UL_AES_ENCRYPT_SIZE     = (1024 * 1024UL),
> +
>       FSL_IMX6UL_QSPI1_RX_ADDR        = 0x0C000000,
> +    FSL_IMX6UL_QSPI1_RX_SIZE        = (32 * 1024 * 1024UL),

Please use the KiB / MiB definitions from "qemu/units.h" (the
resulting code is easier to read. No need for parenthesis.

