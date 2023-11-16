Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCD77EDBB7
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:00:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3WMN-0003xS-EV; Thu, 16 Nov 2023 02:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WMB-0003x2-CA
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:00:08 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WM7-0003ls-Bn
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:00:06 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c50906f941so6220141fa.2
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700118000; x=1700722800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fISJbt7KotyP+E8DosiLgBZeDm+6QMTcDOnlX7dlBu0=;
 b=lm/WSfvz58JUFSVzqqN97NFYGoZUahv6R8YCqlZohvBtyU/4ATV+Wx/wfARbr8auzf
 arHz2MUttruRjvWUUOSnbYCSJWmMKF4GN7dM+nzVfmQW2xwH0I8S09+Peiix4FoMVoHO
 XEhTH0X4QjEmcajTHYlBbPiEkCUdo6ETLPVpQ+2pTQvICn70ZbFxT2XaxNvzqFaXocNv
 NrOouFbQM0oJ6FDzGNTBNk52/Yl+YVgsToSNoJxGNrFWz7GOm1F/kzen0f7LoAXR+xl+
 RKUMlX049EGz/eNkUYy+7+kVKN3EDX37+siVwGrtrve8TNe3B7r54HE6FNMjQAQHb6Gg
 VgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700118000; x=1700722800;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fISJbt7KotyP+E8DosiLgBZeDm+6QMTcDOnlX7dlBu0=;
 b=GCXQHYJsOg4qeV0wA2pYzQZ4c6+MoEM33ZhWznaGmiV96ufpYAhJwnM9AZRK2Hxqy6
 GbUnRBFQKZjNv5oPskNvVMVpweqce0TnjvjqWPCgmKxcMz+oqXCH5TWIX7DxyvjQxWFn
 UeoUaXNwuqMwbYIX7R2ea+TVRnpnD5YtMGAvKyUuuBpv3AC/FwgCXgnK6zMImjqk3TTb
 iCsz122jnpcGxXsZMoG62ehexDn7V5C5IZRzfO6p7dGvWZB8BLW2hLlVViSwhnOGkyfl
 6Bwkf4PvS7nB2cX/f9isiewWwR+PEiJV28R3R7xQOCLHW465DK9Qu20jySEFhhGLozoE
 NmrA==
X-Gm-Message-State: AOJu0YxfJ+fUQA/XBmNtae6jQ+0Ilgc98+BjF1YToB06eMWILyAs/mfs
 cWE/O4ReS/CHUe0W6tZy2HJxUg==
X-Google-Smtp-Source: AGHT+IHHarEs67pTuQhfqDnLcHWrM+xXm1CmU8o+996EZ7+sbbdGqvCfLYEJTOnShrMS6aKRKP/SJw==
X-Received: by 2002:a2e:8842:0:b0:2c5:47f:8ff7 with SMTP id
 z2-20020a2e8842000000b002c5047f8ff7mr7605373ljj.18.1700117999628; 
 Wed, 15 Nov 2023 22:59:59 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a1709067e1100b009ca522853ecsm7889681ejr.58.2023.11.15.22.59.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 22:59:59 -0800 (PST)
Message-ID: <b9ba33cc-9bfc-476c-a280-f3abebf47036@linaro.org>
Date: Thu, 16 Nov 2023 07:59:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/mem-addr-space-check: Replace
 assertEquals() for Python 3.12
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20231116061956.14676-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231116061956.14676-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 16/11/23 07:19, Thomas Huth wrote:
> assertEquals() has been removed in Python 3.12 and should be replaced by
> assertEqual(). See: https://docs.python.org/3.12/whatsnew/3.12.html#id3
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   Note: The test has just been merged, that's why I missed this file in
>   my earlier patch that replaces the assertEquals()

Ah my bad! I was also wondering...

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
>   tests/avocado/mem-addr-space-check.py | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)


