Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17579797040
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 08:19:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe8MI-0002i0-1F; Thu, 07 Sep 2023 02:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qe8MF-0002hO-RC
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 02:19:15 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qe8MD-0003AE-KO
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 02:19:15 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99bed101b70so60705266b.3
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 23:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694067552; x=1694672352; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DpqY0rCHV7RUKJMSfFukB7LYQRPm0F03skposWZ57R0=;
 b=Y9dQ25Ykx7fhhCf+Igy7uC08Ihkm1hDMvQDizD0OwSqXDyU3CkVSQ0FD/Ljg+AVl13
 x5+B5a4QrzP7L0nh2jO25Wh9Fc0mMVlLnM2Ob+3gjix9W5toWLiCtwN02ZPTg2Ohb4Oh
 X7gwhljqEWxjMkhUUi59tnT88AGnyeu3X0TFCOOAK+QFqAdPnqpIXqrcf0SsE5A6uVjd
 UBtRxM9PUW3KjurAR8r1fWznjdzVnFoafMTvXcLg3rVBlMmOVHBt8X20sFWwhmyCnF7o
 es3AI73QpUAISSYMs0xCu3elUZjH3G7f8rXEOb8PhQI3lj2BmeiaDB86IjgyzNEcExxG
 2IMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694067552; x=1694672352;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DpqY0rCHV7RUKJMSfFukB7LYQRPm0F03skposWZ57R0=;
 b=b2joo//em9+5VppFw1nNvd/WZLLvlQWfXaIWyjRhND5Pmcd8Jqc9v5XxRXztaTaEgj
 +MWgltg/gr+8ojOA9QF45pX++B6Gcs4RB/13ELg2X4BQ8iu3TFzXsvNe7P1RkPGDYM2+
 qToZ/iz2Lx4BnpQINOzWVfPRsK6EEtN5GyjRF2c6yfdHVVqwiipkMhDx1yZOcrXFPHsV
 N+5arzX8MaHFViv6GgEDuFLCtxE1bFQBWCOQa97YNszBCbkygpajao1Xymzoist7f9tj
 98UfpUmmTsTFViXHTJD+jmq/88iu4eE7QIdmzFMcSeAKW3AxmTSlXq5IIWLTA+a9aspj
 /5VQ==
X-Gm-Message-State: AOJu0Yyp8zHhqp7RWiGeaMguv2S34rlE9iZ0p4T0JNQHR1iyb42bnmLq
 Lz78nW0Qo5uwguIX5m4WnY+3Pw==
X-Google-Smtp-Source: AGHT+IED2PYBqZnCd/u68TOVOOT89lnFnaWV2sKsqRbu5xNsnl2+DnEdhNAoWkW0W3b2nT5HTvKp5A==
X-Received: by 2002:a17:907:2bc6:b0:9a1:d400:39e5 with SMTP id
 gv6-20020a1709072bc600b009a1d40039e5mr4009673ejc.4.1694067551864; 
 Wed, 06 Sep 2023 23:19:11 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 jo26-20020a170906f6da00b00982d0563b11sm9869962ejb.197.2023.09.06.23.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 23:19:11 -0700 (PDT)
Message-ID: <a8a2f3cf-4d68-7ffd-23f2-205461ff772f@linaro.org>
Date: Thu, 7 Sep 2023 08:19:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v6 3/3] vhost-user: add shared_object msg
Content-Language: en-US
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com, kraxel@redhat.com,
 marcandre.lureau@gmail.com
References: <20230906111549.357178-1-aesteve@redhat.com>
 <20230906111549.357178-4-aesteve@redhat.com>
 <9d5377ba-c987-dce3-2813-d9c98f162d3f@linaro.org>
 <CADSE00Lv7ry403fE573dRv1xdz_-UEgoj1CA6OABXeXnndoP8g@mail.gmail.com>
 <d256b040-d151-05a5-2654-d3b951074984@linaro.org>
 <CADSE00JCo3H6FZOP7ow9kz-_9FUssaCa8LoTF8ZEKDVZYBkXLA@mail.gmail.com>
 <CADSE00K7=roimgZy4ZnMmQu=vEP13S71BuEctWgfUB0Hv5iF0A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CADSE00K7=roimgZy4ZnMmQu=vEP13S71BuEctWgfUB0Hv5iF0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 6/9/23 18:18, Albert Esteve wrote:

>     So:
>     - Regarding the two functions with the same, seems to be solved with
>     the squash before,
>        and it was probably causing the compile error to begin with, so
>     one less thing to worry about!
>     - Regarding splitting the commit, sure, no problem. I'll ensure they
>     do compile separately.
>     - Regarding the error, I read the long comment in the error file and
>     checked surrounding code. I think
>        you are right and will be better propagating the error.
> 
> 
> But I think I will omit the Error propagation for 
> `vhost_user_backend_handle_shared_object_lookup`.
> In this function returning an error code does not necessarily mean that 
> we should log an error.
> So if we pass the local_err from the backend_read function to the 
> handler, we cannot be sure
> when we should actually print the log.
> `vhost_backend_handle_iotlb_msg` has the same issue and does not 
> propagate the error either,
> relies solely on `error_report` calls.
> 
> Therefore, I will propagate it for `vhost_user_send_resp` and 
> `vhost_user_backend_send_dmabuf_fd` only.

Sounds good!


