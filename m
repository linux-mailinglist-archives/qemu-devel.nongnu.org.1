Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C69786CA0
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 12:14:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ7LB-0006X1-9U; Thu, 24 Aug 2023 06:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZ7Kw-0006WG-7V
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 06:13:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZ7Kl-0004pv-Fh
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 06:13:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3ff006454fdso15109405e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 03:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692871957; x=1693476757;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=04PL+EOr6O50wAN5UAQjUAAvzhPy42UR0TrFQyDx0nI=;
 b=mOoKwRrNbLJQhJj31iKYae/ddzKdJhPLXcrtm5gZzY5fjNxJ99g74a+37sA1YT+tWr
 W3SVLIs9si7UR9voXiS5XphrjfBy861OtvfPtkLDg18HCq0aM/ElFs+RIrrrMwU9BOgl
 r1DpnsG1z48SAo/mWIdDPSpIk2LKzbDdR5ZRzPrUu8urZlreFhpp4AF44Lv4RfBMh6QH
 m/5R0H+wCAa3AKMp0RZYAWAjXOEqRyBPgMVeExa6Q0JXHU7ve/n2a1FvI79V+1hheQWn
 qoYI+6gkT0L1aJBb6Y7WlNVuotv10gr9Jrhrn4QGWNhyGuoQsEKPRUV5OAFUwLntlSFJ
 tU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692871957; x=1693476757;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=04PL+EOr6O50wAN5UAQjUAAvzhPy42UR0TrFQyDx0nI=;
 b=cqoslgnAuo4Rh1UPv0xDeypXlL8TDp1HB3ncA7j9Cjng/D1UWUPK4lyHqe/iyGcwax
 S3o1U47w9aRTld+7rIjoYzX0YXZdNrj0eXeTT8L9Kiy2n4gdv/h29OHeiweTQRh+/iEC
 gD1tNQ0EzRmlWZTaRZ58ORnh+bnFU1dOZIQqm5VQLyKy64p0Pl7QTQNqBbiLyr0erXWT
 mxsLt/n3L1ALlx+xU5mDTlzjUVSr4IxCnEeAD4v1l0/o3D9l8uyd891w7KdTEcRQhBGh
 EJrtMjAgPGBrhPHeck6vUJWjEbd+K3WjJ7FINd7j312CBPKoc+42su5kX4vwOJP709kT
 gL1Q==
X-Gm-Message-State: AOJu0YxNVCI8KwpPcItThf6jAqEc9/e1ySEfWrGvEdF3OJ1LVAmfR8WK
 OpcrMaGn7vI+fL/zR6hfNbSKVX/ZA5gADaiVjzM=
X-Google-Smtp-Source: AGHT+IHtG0AvWBk9H9xE4goVVWEGBTLV6O3ZcD1NC19cP9cEYXcJXuT90IyFzDiPWx4TKFO8WlRu+w==
X-Received: by 2002:adf:fcca:0:b0:319:85e2:6972 with SMTP id
 f10-20020adffcca000000b0031985e26972mr10438062wrs.42.1692871957257; 
 Thu, 24 Aug 2023 03:12:37 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.238.90])
 by smtp.gmail.com with ESMTPSA id
 k9-20020adff289000000b003179d5aee67sm20223068wro.94.2023.08.24.03.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 03:12:36 -0700 (PDT)
Message-ID: <056b2e32-4443-bdb8-a9f4-5b08a5ef2b52@linaro.org>
Date: Thu, 24 Aug 2023 12:12:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 16/24] hw/display: spelling fixes
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
 <20230823065335.1919380-15-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230823065335.1919380-15-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
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

On 23/8/23 08:53, Michael Tokarev wrote:
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   hw/display/bochs-display.c | 2 +-
>   hw/display/qxl.c           | 2 +-
>   hw/display/ssd0303.c       | 2 +-
>   hw/display/ssd0323.c       | 2 +-
>   hw/display/xlnx_dp.c       | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)

>       /*
> -     * Get some data from the DPDMA and compute these datas.
> +     * Get some data from the DPDMA and compute these data.
>        * Then wait for QEMU's audio subsystem to call this callback.
>        */

TIL 'data' is plural, thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


