Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC5F7D4D1D
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:00:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvEBC-000078-Pw; Tue, 24 Oct 2023 05:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvEBB-00006g-6C
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 05:58:29 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvEB8-0004hF-My
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 05:58:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40837ebba42so31435035e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 02:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698141504; x=1698746304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FrSFN4vrRIuqPbVHOQX03ektoS/cVZEhBXrZLhujZ84=;
 b=NH2ZNRfcVrrbhipujexRkEclbGRzW3Nzq60GUlJ1M7yWD1L9CYHPnfxBYpaX8hjS6x
 0kCUr7xqIiocxZU7pYN25EAOC2720Li7okTxSXTKuA3NO5+pbe7i//xoZj2X7P2/ChzH
 dB/h/u05mIFKVqEtn3ZbWw6w5p33jyU8m+KtVikyk9hWI0FLiEZgEm3MfKsuMSZgjQM5
 0tJKUbY42aurMfHUNjY7NPODw5XuLA78hM97Mpa7H9m5gsazquz6d9qOAYXyt12KfgkX
 6Grq5UB4HDRKjHFSKKYph6OsubEpPt3sfaMFodvGMlgphAmcwo5oREwIhyVF4xl2lr5V
 GLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698141504; x=1698746304;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FrSFN4vrRIuqPbVHOQX03ektoS/cVZEhBXrZLhujZ84=;
 b=LCBA3kiOiici2hsutpjGkM65Vc1o8iFIgArHxReFfN0khLRRg1waCf6DChlpE0Ux11
 JTA2qd+LuG8woWkNkIBq0DJiuwZ2HWtGwtPjgfwBy1eAy9xFVrkDmVX1o6Zzn/B0KqHX
 KVEdL5vGu8vH0XkxG0BilM6NYI42YDTKB8qy2ChXt67OsQ+tMZBSyOwIG6j1pAV0evTs
 QfuGLTT2e4IXSbZUdGKlirZS0QgKwcKd2iq3ihgWMjOOwluDJKQpgHaqd3GEY6B7w395
 6UuoURT1979glw+nC6HhO2aq/2jZ/EEHVbBC4VOCj0jcfNJGJduiwy7WR3p2q1LkH2Ms
 HW4g==
X-Gm-Message-State: AOJu0Yzf8zj+8WGjxdiu7D3YHoO2Gmib9Vf8DjRlJ4GLnoAY5Te7PIuu
 eOaZPo2CM8QHVNmHXuuiXzsYUA==
X-Google-Smtp-Source: AGHT+IH2An8f3arTHoiGVERuwlG5PA2XlPveqcfBOuhrFnsIYb10sZxbg++vCOSh9SSNlXGj3cH7Jg==
X-Received: by 2002:a05:600c:4fc7:b0:407:5b54:bb10 with SMTP id
 o7-20020a05600c4fc700b004075b54bb10mr9445449wmq.8.1698141504378; 
 Tue, 24 Oct 2023 02:58:24 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 fm15-20020a05600c0c0f00b004090ca6d785sm1471641wmb.2.2023.10.24.02.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 02:58:24 -0700 (PDT)
Message-ID: <e7877808-0e51-da61-071d-4e74f7cb4249@linaro.org>
Date: Tue, 24 Oct 2023 11:58:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v4 0/8] PMBus fixes and new functions
Content-Language: en-US
To: titusr@google.com, minyard@acm.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>, 
 Corey Minyard <cminyard@mvista.com>,
 Stephen Longfield <slongfield@google.com>, Benjamin Streb
 <bstreb@google.com>, Patrick Venture <venture@google.com>
References: <20231023-staging-pmbus-v3-v4-0-07a8cb7cd20a@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231023-staging-pmbus-v3-v4-0-07a8cb7cd20a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/10/23 01:46, titusr@google.com wrote:
> This patch series contains fixes and improvements to PMBus support in QEMU.

> ---
> Titus Rwantare (8):
>        hw/i2c: pmbus add support for block receive
>        hw/i2c: pmbus: add vout mode bitfields
>        hw/i2c: pmbus: add fan support
>        hw/i2c: pmbus: add VCAP register
>        hw/sensor: add ADM1266 device model
>        tests/qtest: add tests for ADM1266
>        hw/i2c: pmbus: immediately clear faults on request
>        hw/i2c: pmbus: reset page register for out of range reads

Thanks, series queued.

