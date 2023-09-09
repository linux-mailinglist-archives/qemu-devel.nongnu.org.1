Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2700799C20
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 01:44:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf7bW-0004sc-4D; Sat, 09 Sep 2023 19:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf7bT-0004sU-2X
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 19:43:03 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf7bQ-00027d-7x
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 19:43:02 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-57355a16941so2118088eaf.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 16:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694302979; x=1694907779; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QxOpFX7yTlzC1cGXTA8PLsGHV9LSr/Bk7AJ1zhjvJto=;
 b=id/XGJXkCzMuhlcq8JPt+Wr0K2HXTNYJFzpsXzHkJatzhrJL59fRlMSwuk63suDRyI
 ZPiUF+sV+rx9diD4rrcFapqp/6fkbuo3UO7jJU7695uUVONL9pOFVFpDS8RBbTS9XHMO
 ZU77pg6z0uzvF4sPI+ygsCWA4ai3yzbqLRXo+bVwyE6Hi5X5l6QSM/PhImnSuOVPMF4u
 S2/vuOzDlHb7bgE6N+g4eLRaP8RgEs1H2/5TaiDBthKM38lYXgNvKlTt6x1xH1tkTRJJ
 X7wTwueAHnT9iAsJHm6tDteP+9PbqgyJmu/WS5sYjDN3vqA6X7RMGeB0l++stbpEFFp3
 unaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694302979; x=1694907779;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QxOpFX7yTlzC1cGXTA8PLsGHV9LSr/Bk7AJ1zhjvJto=;
 b=FD2lAeX2ulFggzloRY3rISXLVXqRkGInHU3870O2T8UZcAcbEF4035OIpxWZAkZQJK
 7ieRzk2UJl9WYVWVyIb0Oy/Bi+9yDNFcvm5VowmvHItD3RVsXlrujBfIqW0zQxt5jog/
 y9+9j4V6S9elU58PeMj/n9UrxrITcQKboEFHLU1YLH2nke36MLYQNQ3ckAYzJa3Fb2WQ
 b4/WdTrjCXXIqPeaoWyop7Ia8e/CLR70ISLvz+n5WbKBsBUPtBic0//npsIrKTLO1ZDo
 iZeNjecjI6gc+vWKgT+dplR4OXRZhRw5MKRSupqAPSnirwJbqxwJ0f295eYqZMMIe+6B
 hXZQ==
X-Gm-Message-State: AOJu0Yx5TwCpRF98OFv9LwdUX2ZoZiA4e9H63Ef6pVuep8S4rqMUdiPi
 H0voDMhB81VyIcjXf7pLznwZqQ==
X-Google-Smtp-Source: AGHT+IHYaPpPv+Mrl38IGmOJiuPy9+ntvcFDydkTs3Qtu+7T3K3hMUvRC5ALImoPcM2dYlMR4Vu/DQ==
X-Received: by 2002:a05:6358:91a6:b0:129:d05d:691e with SMTP id
 j38-20020a05635891a600b00129d05d691emr7027064rwa.19.1694302978768; 
 Sat, 09 Sep 2023 16:42:58 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 iz17-20020a170902ef9100b001b9da42cd7dsm3719713plb.279.2023.09.09.16.42.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 16:42:58 -0700 (PDT)
Message-ID: <290eedba-ac95-dcd4-dc86-50b2c67e9956@linaro.org>
Date: Sat, 9 Sep 2023 16:42:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 10/10] target/i386: Autogenerate feature_word_info.c.inc
Content-Language: en-US
To: Tim Wiederhake <twiederh@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <20230908124534.25027-1-twiederh@redhat.com>
 <20230908124534.25027-11-twiederh@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230908124534.25027-11-twiederh@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/8/23 05:45, Tim Wiederhake wrote:
> +++ b/target/i386/feature_word_info.yaml
> @@ -1,3 +1,5 @@
> +# Run `feature_word_info.py` when you make changes to this file.

You should integrate this into the build process instead.


r~

