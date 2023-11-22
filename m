Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A70E37F44B4
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 12:08:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5l4z-0000wR-5Y; Wed, 22 Nov 2023 06:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5l4w-0000vs-Ib
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 06:07:34 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5l4u-0001A3-Pl
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 06:07:34 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507bd19eac8so8703405e87.0
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 03:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700651249; x=1701256049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hNxDhhCIH8NlpH8XHPURRCmGBLxe0AMGsttC4hlkS4g=;
 b=FjNxMCmNGUZ2lHyJKacbmangUDaCJTvWhcZMrUYEkkXYbdzzj9W2STIviRfdqpwkRz
 Zjk1WSnf66zkbpz+1MmunTmfgg30+RIg1ZS3/SHifIUgAw0OWy9v29sybnuGk/ejyYm0
 oNGPIZBDir0YRlnJ4BeUyfpxXRknOz3jLBJnwA1nRVVvxzc70i3DE7vMvhlkV+7PdDnY
 A/QPXeDahDZAmYHenSmUgA76BshsrZZAAg9nk+PjVehzITbnNU7J+WbDqwde85utiQq9
 fYUptS+Y9biOIdHPwsAi8+XeIDRhsoEtWiebYyt+nMSXNq2drbM81K0Iv3Ynlw4szSXO
 Zc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700651249; x=1701256049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hNxDhhCIH8NlpH8XHPURRCmGBLxe0AMGsttC4hlkS4g=;
 b=PXuKJfNUOCZk7uAo73MBZvTvDcRLo0kGcynUNZ5y61NlH70QdpWN9dtCPq1RtrSLxk
 2X/EUvV7NLOLGzKCqjslL7cVrUVNh91yTcTI0R1Bqp8teBvYLGCJcIO6M5siXZM4ngPg
 UwdCXnnqnkepFqg7dgcOzumxF3Xyrsmgq8n2ii1kjObfYCDNHo5WRZcjLSscNsgzM67H
 hn50Ysb29IOA8UBiXfxdSR2/N1VulLYww6vZJcF+ZdBlkk/UCeVfVBAUMchi0F5dNY9A
 2DQEcpjpgkP6uSoPWHdbPdOqbQF83OT/IKNYf62W4XFCoRLnpx2OuGkOHjbdZkAKjrv5
 SkkQ==
X-Gm-Message-State: AOJu0YwQSBzBsy5JjaX2M6UumE4MvJ7QiCIiAqHUD6qBxp5yEdPX8/Mz
 Svw8i0MocAK+62WS/r/bgrKaUbAKuMcuYIPjawA=
X-Google-Smtp-Source: AGHT+IGYNLvrEeIf4l5dhNfo9PLr/A5Ox6GzMWAevPIallmwrkFlAOq4+ezPJDEfyMf13hLwgxpTjQ==
X-Received: by 2002:a05:6512:1591:b0:50a:bb04:2321 with SMTP id
 bp17-20020a056512159100b0050abb042321mr1582427lfb.1.1700651249433; 
 Wed, 22 Nov 2023 03:07:29 -0800 (PST)
Received: from [192.168.69.100] (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 v11-20020adfe28b000000b0032d09f7a713sm16962331wri.18.2023.11.22.03.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 03:07:29 -0800 (PST)
Message-ID: <19f6fcaf-ac2b-4cc3-b226-27ec659d7478@linaro.org>
Date: Wed, 22 Nov 2023 12:07:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] xen: backends: touch some XenStore nodes only if
 device...
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>,
 Stefano Stabellini <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Paul Durrant <xadimgnik@gmail.com>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
 <20231121221023.419901-3-volodymyr_babchuk@epam.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231121221023.419901-3-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Volodymyr,

On 21/11/23 23:10, Volodymyr Babchuk wrote:
> was created by QEMU

Please do not split lines between subject and content. Rewrite the
full line. Preferably restrict the subject to 72 chars. Otherwise
your patch isn't displayed correctly in git tools.

Thanks,

Phil.

> Xen PV devices in QEMU can be created in two ways: either by QEMU
> itself, if they were passed via command line, or by Xen toolstack. In
> the latter case, QEMU scans XenStore entries and configures devices
> accordingly.
> 
> In the second case we don't want QEMU to write/delete front-end
> entries for two reasons: it might have no access to those entries if
> it is running in un-privileged domain and it is just incorrect to
> overwrite entries already provided by Xen toolstack, because toolstack
> manages those nodes. For example, it might read backend- or frontend-
> state to be sure that they are both disconnected and it is safe to
> destroy a domain.
> 
> This patch checks presence of xendev->backend to check if Xen PV
> device is acting as a backend (i.e. it was configured by Xen
> toolstack) to decide if it should touch frontend entries in XenStore.
> Also, when we need to remove XenStore entries during device teardown
> only if they weren't created by Xen toolstack. If they were created by
> toolstack, then it is toolstack's job to do proper clean-up.
> 
> Suggested-by: Paul Durrant <xadimgnik@gmail.com>
> Suggested-by: David Woodhouse <dwmw@amazon.co.uk>
> Co-Authored-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>   hw/block/xen-block.c  | 16 +++++++++-------
>   hw/char/xen_console.c |  2 +-
>   hw/net/xen_nic.c      | 18 ++++++++++--------
>   hw/xen/xen-bus.c      | 14 +++++++++-----
>   4 files changed, 29 insertions(+), 21 deletions(-)


