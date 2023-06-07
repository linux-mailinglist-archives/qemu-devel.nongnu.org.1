Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCB5725674
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 09:53:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ny3-0000xT-53; Wed, 07 Jun 2023 03:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6ny1-0000ww-7R
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:52:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6nxz-0004RY-OQ
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:52:28 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f6e1394060so58995015e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 00:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686124346; x=1688716346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b88gpSW1Ai3K575H9KeVTJk4qxncxrbF+MRJNy50tO4=;
 b=ee4Mz2VKkW2Of2Gq18rWiczBn3BuCtGvbPqNCCS2Ezkv1biZQ6FObhkKvYVDBHGy95
 UtoYLk5iPQ+CRYHWn8+kOOxKoFiKd21GF1/sw19ezztvcyQm6ntd0KMhHuevpRVLyMwV
 PIwCn6eFr7nYJFK0PKyIu2WIv3ZkS0P3uasELF1PeGdpuJIOKAPProwoAq0I/lJrxpCy
 wdC6S7k8dH/fRwhacVxByOyWztNN9e01uT1Qe/ebYh+KejQGKgE/MmffB37lIr8zM3rM
 Ocl9dj6/WY/DGiZy4e8nEmu9aly9q4dtFdCmQ/pI13D+DxiifzP+GBqmcwCNE+mfKPzA
 w4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686124346; x=1688716346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b88gpSW1Ai3K575H9KeVTJk4qxncxrbF+MRJNy50tO4=;
 b=YeyPHr6I2xMUv1Qz9ltAFYaHdqVCsfdBXo+jgipWZ855+yt8GqUOLllUr+uoXJwOIe
 D3hVqzjuZaMQB3Jg3eQnqm18rKzFa36hxak6cU+IhZ0r54h55gb/hqgZN3ZYOJx1YATh
 VUQsY7KqzTsiblPsMz2WF777s+Y1pefx5mgqH2TKCFf+uGi3BJ8jyRJMeb5l82a5/vhx
 XIMm4MbqIEm5+d/8DWGhs3fHV11Ujfxj9FEjwHmGvoyCso/WOQ0BxRSuUMBJ7NhAHsRT
 Ken/kNny2HrZjpIUvNOXAmqLOspc2b4/0KRsLtHofD8yfxRGOcq5RKTFqxJatvQa86GL
 Tu0w==
X-Gm-Message-State: AC+VfDxxbMOUwGIIJIZaWVm+jY5TaSu9OFtC5wVOXRyIZJnnjPk/47Nu
 E1TNbB7yntfUprdeGEYUXpeTHg==
X-Google-Smtp-Source: ACHHUZ4ytiraW5iFHybXbkzybjutWOOcyIxnD2ButynygWLNGZRpIRRUcK71Om4aXGLjjYz695g+wA==
X-Received: by 2002:a7b:cbd9:0:b0:3f7:e70c:8eb0 with SMTP id
 n25-20020a7bcbd9000000b003f7e70c8eb0mr3819602wmi.2.1686124346045; 
 Wed, 07 Jun 2023 00:52:26 -0700 (PDT)
Received: from [192.168.69.115] (bd137-h02-176-184-46-52.dsl.sta.abo.bbox.fr.
 [176.184.46.52]) by smtp.gmail.com with ESMTPSA id
 d17-20020a056000115100b0030af15d7e41sm14764724wrx.4.2023.06.07.00.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 00:52:25 -0700 (PDT)
Message-ID: <ed96f274-9cec-5498-130c-b82d046fe191@linaro.org>
Date: Wed, 7 Jun 2023 09:52:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] target/ppc: Implement gathering irq statistics
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230606220200.7EBCC74635C@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230606220200.7EBCC74635C@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/6/23 00:02, BALATON Zoltan wrote:
> Count exceptions which can be queried with info irq monitor command.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   target/ppc/cpu.h         |  1 +
>   target/ppc/cpu_init.c    | 18 ++++++++++++++++++
>   target/ppc/excp_helper.c |  1 +
>   3 files changed, 20 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


