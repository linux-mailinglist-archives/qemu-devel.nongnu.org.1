Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B072715C18
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 12:44:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3wot-00017k-10; Tue, 30 May 2023 06:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3wor-000170-I9
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:43:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3wop-0000Zo-VZ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 06:43:13 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6d3f83d0cso45340855e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 03:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685443390; x=1688035390;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3qvcBD0f7wDEeXT1o76sFs0BOpdoKV3VGfTLMUZVGds=;
 b=ogDcPfYitXqQrJB0EXUXHgGTjg5/rSDCGCaRXR9PS/H6F9MAH5kthNlB6AlXKXjmwc
 fEw83hvR5rrFMLfPJiOryEkhf/fVMe77b5YEAROD8FREkz+xVFCEKMvTHXgsMtjiN118
 YLmaOKpBwfJIdN/1tAjPgYqExO2pgIkITb4q1hjSYyU008OU2NlpguXEXKHwQm4IY/oU
 cXYcfZLc2fdvTjkLwHg+MWYdelZCDnS8bgu3kK4XhdO450FEVfJ1SjR1gpTrCWOXVK24
 9xZZnXCpAuGoj41wbSgWAH9uyDW8cdBMkC0enTMWOHdd/lrLeko+rcpFBz+h/HFeaXpt
 YsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685443390; x=1688035390;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3qvcBD0f7wDEeXT1o76sFs0BOpdoKV3VGfTLMUZVGds=;
 b=EGQUmoZCz0zF4hbP1XlvBcQsLhbNdmZQw2o6qo2ne7O9WPq5VwQFoBoYdKrGk9anqt
 4py0kWEnHK7GOOEH3zERBSpbW5pvDYtmcnfu0o/iPtqkcdee7i4pcU1qxBx5ONAGtBRL
 EVVmqhUwNkuh/Fa0mT0gz+JbbXdsx/jmdBY6RgdaXaSnkT5e2+Bv2svRgCuK7nkEJaJl
 ERpVEuMB9y0XA/Pa8MhIej2H/OLnRDAPsmXgDbiJXzsc0d0ri3xALMqv02ikndCSiegF
 lqCxrFtHa9TnAa/IzmIbzGWMsCkmixdlKsu0ZynNQYq3gaNJDwrM8orKociMY0j0jrt8
 eBuw==
X-Gm-Message-State: AC+VfDztiIyDGBjAbqftFVF6wgBPNHoapvOQ6pKWSpg2JAhKmwnfJfcb
 fU3z8npa9NZBho0PxnH86NyOlQ==
X-Google-Smtp-Source: ACHHUZ6o01ZBj0U9sDIhh4dimq1F79zCx+GveKllWq4QBaFHS8qu7KelY8ZplYVFKz0X0k1S46rB4w==
X-Received: by 2002:a1c:cc17:0:b0:3f4:27ff:7d52 with SMTP id
 h23-20020a1ccc17000000b003f427ff7d52mr1339486wmb.2.1685443390276; 
 Tue, 30 May 2023 03:43:10 -0700 (PDT)
Received: from [192.168.203.175] (77.red-88-29-183.dynamicip.rima-tde.net.
 [88.29.183.77]) by smtp.gmail.com with ESMTPSA id
 f7-20020a7bc8c7000000b003f42158288dsm20474533wml.20.2023.05.30.03.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 03:43:09 -0700 (PDT)
Message-ID: <010d4ce0-d6aa-57e2-7401-a2f97296a5eb@linaro.org>
Date: Tue, 30 May 2023 12:43:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] hw/ppc/Kconfig: MAC_NEWWORLD should always select
 USB_OHCI_PCI
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230530102041.55527-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530102041.55527-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 30/5/23 12:20, Thomas Huth wrote:
> The PowerMacs have an OHCI controller soldered on the motherboard,
> so this should always be enabled for the "mac99" machine.
> This fixes the problem that QEMU aborts when the user tries to run
> the "mac99" machine with a build that has been compiled with the
> "--without-default-devices" configure switch.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/ppc/Kconfig | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



