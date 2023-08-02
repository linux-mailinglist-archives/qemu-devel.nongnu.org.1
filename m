Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F401E76D99C
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 23:34:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRJTO-0002v9-3s; Wed, 02 Aug 2023 17:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qRJT2-0002rk-T1
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:33:17 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qRJT1-00065t-6H
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:33:16 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe1a17f983so3151465e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 14:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691011992; x=1691616792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NzuEe7B0zsnIK6Xs+h2hb3HUup7dcHx3nD2l/wcc7xw=;
 b=cXkfW9TDP99BxHSlIGkFwGyE8ascoTJvkqL2ur0Fna/Oq6dzp3l3RvETQ05LOIfgVn
 zhe7FHFr4+Y+aE6tDe3+rctJP4pbfEzcZVlMB6/ihsTG8K1pJWG3T0eF/NgJMgQ+oFYe
 S7wNT83+LVA6QoaTeAhY+mxwx1e+Vq+X10rbrQl5G+xNogioP1A5Eb8Dnny7yvpRSjyp
 wMkEnkbo8dYnjfAY0mQV8YTY50OdK3dkC7F5wfkELcqbfQy1c6cC1dRqcYXZCbRWCeJe
 wCrL8W7xcsqdW6jMaRTJ+uDAVXs8GlMjMorStuu2K729w/jHibtTW7haEPfO4gF0UrIC
 1kRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691011992; x=1691616792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NzuEe7B0zsnIK6Xs+h2hb3HUup7dcHx3nD2l/wcc7xw=;
 b=KYNy5LeZoc9nsqEFqBgBwNycCbP01u7jIvYYkX2yvz4U/AIN7O4iaUDoYt7NpGEot+
 YaoMDaUrVLhlLPCU1+X3Pdvd0BqPqDlMF8PovgqM0IkrvQqNcsddV03OI53TmdgycKF9
 gWLxmIRUO4Sz2S518l523NSMY6I7YVqfzE7F3QWXYVplg6QzuE3Y9OnUxZvipqEcvqMn
 YvhOTPzRI9GY/BDUtCvmbNZG6A9JzJhpeq3GMPpprSWlDkVYXgpPNEg/B6D6WtnX//Ju
 4K++VGK+V4Nk+MJq/oAMEjtb0Wxk+mSKqv8z1esBjqp8L0Jc5tmjBG5VgOYj2MmtgPRn
 Du3w==
X-Gm-Message-State: ABy/qLYeG1bkK34mVb/rYNEuJVb6VzbKJ5D2RcCZFKS/UIyqerlY6mg0
 6dWPn3qYKRRtQqj280mRwDLQTg==
X-Google-Smtp-Source: APBJJlFbznh9ieF5fdS7TtYLgBneAwl9T9ER1uYsbQho6pLB7qiqgM4pBkpSwknGM7Q58buJK+12mQ==
X-Received: by 2002:adf:e7ce:0:b0:317:5bde:e6de with SMTP id
 e14-20020adfe7ce000000b003175bdee6demr5671450wrn.8.1691011992454; 
 Wed, 02 Aug 2023 14:33:12 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.229])
 by smtp.gmail.com with ESMTPSA id
 y18-20020adff152000000b0031779a6b451sm19932174wro.83.2023.08.02.14.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 14:33:12 -0700 (PDT)
Message-ID: <1c94622d-45fc-bfdc-0b0a-6c7e5d64a3b6@linaro.org>
Date: Wed, 2 Aug 2023 23:33:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/5] Add i.MX6UL TZ missing devices.
Content-Language: en-US
To: Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
References: <cover.1691010283.git.jcd@tribudubois.net>
 <0abce3d1d663301684ad7553c6f78064f4781c6c.1691010283.git.jcd@tribudubois.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <0abce3d1d663301684ad7553c6f78064f4781c6c.1691010283.git.jcd@tribudubois.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On 2/8/23 23:08, Jean-Christophe Dubois wrote:
> * Add TZASC as unimplemented device.
>    - Allow bare metal application to access this (unimplemented) device
> * Add CSU as unimplemented device.
>    - Allow bare metal application to access this (unimplemented) device
> 
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---
>   hw/arm/fsl-imx6ul.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


