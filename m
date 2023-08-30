Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A65678D6D9
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:14:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMsn-00034U-EF; Wed, 30 Aug 2023 11:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbMsl-00034E-M1
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:13:23 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbMsj-0005jv-GU
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:13:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fef56f7248so53748365e9.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693408399; x=1694013199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NX21Uj55k3Z0fAhH22nUETgzLdTU9GMK9J0KT1CNAb4=;
 b=r4s4arBOoOqJbhwZYGveC44NczPfv9akTt7j0z2U6zPOIXCL+FDRPOatjoSi8XpTRj
 5zSOoMKObnLZC46ldKOZXbO2pTW6/D25x0gAqoktG5H8laTAAF9OE5v3BkuBHSseCXiZ
 TnEoJma9YfRIoytDbsSHzror5Wo8/YlA1PyMPQmHOhr48Xh32BzZamHBYPOGkYGsv+ew
 /Y1kOK/iWjyF7u9h0IqR2FED3tlg4lG6TtUZV/SgQx8EVzr7w66NgH9ip3Ln1IVXJLhX
 FypBVL0BXWwP7m/01iDqSnlIYddv6I1hVHarNaBpY3ygWgMONVfi8zJBmbhvUT31r+4o
 6WCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693408399; x=1694013199;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NX21Uj55k3Z0fAhH22nUETgzLdTU9GMK9J0KT1CNAb4=;
 b=VDtHU5JEL1Y+ziQwdSFSjlFfCqvMGtI3ZBHf3EqGbm1zP7Lm7CFcug+obWFrhd578o
 gGoIGFFIvWM4RI6KmRr7d75ERpOU71GFdJVqiCz8VS1kvzxBqJAvX/H/MatKGQvPbRSV
 W2xP30qlI9XBUGH40sKF9oUoXRQyOc7X8BKE3jWFbibMjPZuhpBxb1TbRPCb5qM6Lb4a
 O5c42Jzauhp0FdusgLyLsll9fZFicZC9vvUquSM9veaKWwsTXj5MDcmzdQs98oYF3zQa
 5/u8oD9so/x41D9Ha7A2i7EXyxpYJ49rmNPgNO1xAqS00nrxB1zImdLhlk9dhQJsHhH/
 wdnA==
X-Gm-Message-State: AOJu0Yy8sNgguFacSNrI22/CP5dy5ID9c0+kGNQ11ebeoELANhEW0NuT
 IzSKjxLSmpIfXx14sS3pwtRs+Q==
X-Google-Smtp-Source: AGHT+IHFFTrQixqZv56o9suKPJwo07MUCHisqsHWYu1DcWz+dEgWWuTlZfcMF9adBEodjDU9SkXZ7Q==
X-Received: by 2002:adf:e64e:0:b0:317:eee2:6fba with SMTP id
 b14-20020adfe64e000000b00317eee26fbamr2250232wrn.40.1693408399271; 
 Wed, 30 Aug 2023 08:13:19 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 b16-20020a5d4d90000000b0030fd03e3d25sm16982959wru.75.2023.08.30.08.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 08:13:18 -0700 (PDT)
Message-ID: <896384ac-7fde-1535-a85f-17ba4ec962f4@linaro.org>
Date: Wed, 30 Aug 2023 17:13:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 36/67] ui/console: use QEMU_PIXMAN_COLOR helpers
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-37-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830093843.3531473-37-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 30/8/23 11:38, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> QEMU_RGB macro is actually defining a pixman color. Make this explicit
> in the macro name. Move it to qemu-pixman.h so it can be used elsewhere,
> as done in the following patch. Finally, define
> QEMU_PIXMAN_COLOR_{BLACK,GRAY}, to avoid need to look up the VGA color
> table from the QemuConsole placeholder surface rendering.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/qemu-pixman.h |  6 ++++++
>   ui/console.c             | 39 ++++++++++++++++++---------------------
>   2 files changed, 24 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


