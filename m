Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8571717D11
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 12:19:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Iua-0003hV-N0; Wed, 31 May 2023 06:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robin@streamhpc.com>)
 id 1q4IuS-0003fX-RP
 for qemu-devel@nongnu.org; Wed, 31 May 2023 06:18:28 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robin@streamhpc.com>)
 id 1q4IuI-0000mv-Pi
 for qemu-devel@nongnu.org; Wed, 31 May 2023 06:18:24 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51456392cbbso1636974a12.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=streamhpc-com.20221208.gappssmtp.com; s=20221208; t=1685528295; x=1688120295;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yQPZApZUHrlURH76WVE7QejAYbuKboH7gX2ZgMPEfio=;
 b=OugAHWzKouzv80a5PCoFG2jvTOT1NcRxQic6TD/LXMDYqPPywPKpQ6V/aLnElgStfb
 yHb31uGPBnbxU8DLnqp5uxeMhY7DwfB1eux0gEZ/cUmXK7UqXjGXmPS75SEzfezxhsdV
 wjrRpipxwujQsRcpnk3Ccw3dadlEWhoStOfVruxFGiFGLYFqSZou5hKJP5zaDpikm8cf
 yv895evHTjh6H76MbNzaprZmPdfJuZqcB5zTLJJgH3gPc+4rTEWhwsbUG913YI0HC6yE
 NR61aEcv+2XE1JvhS7VJy4/LtQWUbIO7nX4WlXnhGy5rfhvzz4TrT77iYspeP1JfZggB
 XSBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685528295; x=1688120295;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yQPZApZUHrlURH76WVE7QejAYbuKboH7gX2ZgMPEfio=;
 b=eOGwB6nMEtl/b+7GJHIYMiEnm+gua8Q5/UXoiq7qDsdS5WG6WDzo0pf4YbBPCrlACK
 JOQxm5Yn3me0W5FAUi0fb78wiZyVbsXSnrQptpnn3cVrIGZQYDCmSL5IVv3s+NNbiPIl
 Br6YhPDxm167UaNPzX+eod841md1kXQpCZwDGK6TGGAo750rrakB+pjlJgdVDJG6Z3Dz
 FzLMnAQj+IjzZkn6bdbts+Di14c/W24QDocEOTB0EM+QkkAto+mcH26I+6XkwuJd9pyW
 Yo+YD5hypbFp9RSi+YkU5TBvaTgM943ggUqYSQhqPPlOoxrVXV3E+i56hD++8h1neOBi
 JeNw==
X-Gm-Message-State: AC+VfDzGjkCowmsbtDYC/yT8iF+2IE77MC9aXVIkMlMXAtXIeioJJKLl
 VU3dEZ07dzlhIs3Cwzo3ay/soQ==
X-Google-Smtp-Source: ACHHUZ56NWUQ/xDP3ocCHTdfawKAUiyeemofsLgAOADVMpbaWNjiusJ3yWjBG5+7ilDKJTwRMrroAA==
X-Received: by 2002:a17:907:3dab:b0:96f:7b8b:df9c with SMTP id
 he43-20020a1709073dab00b0096f7b8bdf9cmr4618851ejc.14.1685528294801; 
 Wed, 31 May 2023 03:18:14 -0700 (PDT)
Received: from [192.168.178.121] (dhcp-077-251-030-138.chello.nl.
 [77.251.30.138]) by smtp.gmail.com with ESMTPSA id
 d12-20020a1709067f0c00b0093313f4fc3csm8723760ejr.70.2023.05.31.03.18.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 03:18:14 -0700 (PDT)
Message-ID: <f64b3a82-a5b6-2f3f-74a1-062db2112224@streamhpc.com>
Date: Wed, 31 May 2023 12:18:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH v2 2/4] vfio: Implement a common device info helper
To: Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
 marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, clg@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
 <20230526231558.1660396-3-alex.williamson@redhat.com>
Content-Language: en-US
From: Robin Voetter <robin@streamhpc.com>
In-Reply-To: <20230526231558.1660396-3-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=robin@streamhpc.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/27/23 01:15, Alex Williamson wrote:
> -static struct vfio_device_info *get_device_info(S390PCIBusDevice *pbdev,
> -                                                uint32_t argsz)
> +static struct vfio_device_info *get_device_info(S390PCIBusDevice *pbdev);
>  {

There is an extraneous semicolon here behind the function declaration
that should be removed.

Kind regards,

Robin Voetter, Stream HPC

