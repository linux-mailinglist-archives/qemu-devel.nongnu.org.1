Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9AC7ACA2C
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Sep 2023 16:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkQYF-0004Md-FE; Sun, 24 Sep 2023 10:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qkQYB-0004Lz-Fo
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 10:57:35 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qkQY6-0006Cd-3i
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 10:57:35 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40572aeb673so14064165e9.0
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 07:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695567448; x=1696172248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UcZcMfrbmOHyaV1oGmDgeTnYK9FIoyarn8ThHTcWbo0=;
 b=R5wmqHTu3hiODGv5rV4DDtvN8a9BYpnEwpQXY3/GkMrINUgN/1bXmYvMyH2LcnluFB
 JHklpe9ZCkgD9cPA478nwzdD8x48YjJdfU2IHrZ1cz3/CmrG3lyXcd9lNn16lJu5EXUU
 w3muBV865iWvm8YdVb/3T7kKyFXbRoNa04l8mVgi0ndTpPvxX9PLxqRJhTGjSZyXe5jF
 BJdlMCesBft1eE5I/L/mfX0NjBfq96vHX9dQtXh/GneD/TuNANHFHRvx4Xk+KL+aBk58
 zW39Y2CXLYoU0V3+B4Ume3m1ftppimtAKx6COkAga/lg7fD4ZXFj2OEX3MgIxCAg0UYs
 DKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695567448; x=1696172248;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UcZcMfrbmOHyaV1oGmDgeTnYK9FIoyarn8ThHTcWbo0=;
 b=uweQt1QLKJ6KfgmZmLO58cyH0wXQgcDdYUB4rlU4Ig/OkFwzZHBfu6wGMDfq2p1VAt
 KlSWWxN2BAa0ivuWvJTsWHjU23xyaTG6jnWkaQ2plVp2ykIW+x4vzIPfXSDrDZS63467
 XNnlTGKCsQllUMNh1/1jr1tAwhYrhUQ3qqjGo5wbDp7ty5E+7/BdgXuc9EZx/gFaI2ha
 okxZ2ldcMA/mJEIUrznIJviZu3ktg3MwpJqGOnd0Xfws7hznoKNQ2MiHm8oOjaed9VR8
 8tMzuHgpNZNPyguxtWSO0BhI1Ug0Q9k2dVl+PxyPLy8Rko2Rtn6yujdDt5A4QTi+vZJj
 Ry/Q==
X-Gm-Message-State: AOJu0Yy7vCYNA+6TQFpyQQEGUnkYPYpxZ5cdwzZ0rEJwblHKHJ0QiEEN
 dUj5DfHm3tNs5YDNFfW2mbs0CILxsAjHPsGV1/Q=
X-Google-Smtp-Source: AGHT+IFySJAwLyj8rBaJFPauYpZgiH9KtyeqKEz/3t/lKzZilP0B8pllKHC+YkUIMOAqj+3Py0ufkQ==
X-Received: by 2002:a1c:f70c:0:b0:405:1c19:476d with SMTP id
 v12-20020a1cf70c000000b004051c19476dmr3656299wmh.39.1695567447657; 
 Sun, 24 Sep 2023 07:57:27 -0700 (PDT)
Received: from [192.168.69.115] (and27-h01-176-172-57-73.dsl.sta.abo.bbox.fr.
 [176.172.57.73]) by smtp.gmail.com with ESMTPSA id
 x17-20020a5d6b51000000b0031980294e9fsm9445720wrw.116.2023.09.24.07.57.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Sep 2023 07:57:27 -0700 (PDT)
Message-ID: <1a6c49b1-5e5e-481d-96d8-8c08d5aefcdc@linaro.org>
Date: Fri, 22 Sep 2023 20:28:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] aspeed/i3c: Rename variable shadowing a local
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>
References: <20230922155924.1172019-1-clg@kaod.org>
 <20230922155924.1172019-4-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230922155924.1172019-4-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 22/9/23 17:59, Cédric Le Goater wrote:
> to fix warning :
> 
>    ../hw/i3c/aspeed_i3c.c: In function ‘aspeed_i3c_realize’:
>    ../hw/i3c/aspeed_i3c.c:1959:17: warning: declaration of ‘dev’ shadows a parameter [-Wshadow=local]
>     1959 |         Object *dev = OBJECT(&s->devices[i]);
>          |                 ^~~
>    ../hw/i3c/aspeed_i3c.c:1942:45: note: shadowed declaration is here
>     1942 | static void aspeed_i3c_realize(DeviceState *dev, Error **errp)
>          |                                ~~~~~~~~~~~~~^~~
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/misc/aspeed_i3c.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/misc/aspeed_i3c.c b/hw/misc/aspeed_i3c.c
> index f54f5da522b3..d1ff61767167 100644
> --- a/hw/misc/aspeed_i3c.c
> +++ b/hw/misc/aspeed_i3c.c
> @@ -296,13 +296,13 @@ static void aspeed_i3c_realize(DeviceState *dev, Error **errp)

Alternatively:

-- >8 --

-static void aspeed_i3c_realize(DeviceState *dev, Error **errp)
+static void aspeed_i3c_realize(DeviceState *ctrl, Error **errp)
  {
      int i;
-    AspeedI3CState *s = ASPEED_I3C(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedI3CState *s = ASPEED_I3C(ctrl);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(ctrl);

---

>       memory_region_add_subregion(&s->iomem_container, 0x0, &s->iomem);
>   
>       for (i = 0; i < ASPEED_I3C_NR_DEVICES; ++i) {
> -        Object *dev = OBJECT(&s->devices[i]);
> +        Object *i3c_dev = OBJECT(&s->devices[i]);
>   
> -        if (!object_property_set_uint(dev, "device-id", i, errp)) {
> +        if (!object_property_set_uint(i3c_dev, "device-id", i, errp)) {
>               return;
>           }
>   
> -        if (!sysbus_realize(SYS_BUS_DEVICE(dev), errp)) {
> +        if (!sysbus_realize(SYS_BUS_DEVICE(i3c_dev), errp)) {
>               return;
>           }
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


