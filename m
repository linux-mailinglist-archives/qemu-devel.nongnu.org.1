Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C61C769281
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 11:57:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQPeO-0001mX-Nd; Mon, 31 Jul 2023 05:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQPeN-0001ls-D0
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:57:15 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQPeK-0001wH-T3
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 05:57:15 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3175f17a7baso3895567f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 02:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690797431; x=1691402231;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=edAW32t+wwU/BxJd/SXYAyoBX3gb2R3Q8/aX/6/XyJo=;
 b=dYfM0B+ZGbgmOcmYkhZubodbB0HfaOnnzDAFLRGUXySAulvrhQSwDVIbPX/4jA7qFR
 J92cS1vSYzvf54/7eyLZ2vR+O0I8IXiIkiFltfbSOP3Xa+AtN/rgmmOAAXHmv2umQ5xn
 IoTDEEnVahzlHf+fFrDOO6gvSeNx7coyDp17CIbkRrkCMsfP/bIAO0Dwi66/CWxAFQ+6
 W43xoMFnIWy2RcZC98HeTVidl9tMMDxLj4EeWp/9y/ZlYwXpuVFqmUpfd43/vteT5Bnp
 ios9kfnAdnKx8ZCGnRxXl2vcPPgvIyCGqT7F44xKHLa/3GU6T9vXQkqR99HP0BsJhSQP
 TY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690797431; x=1691402231;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=edAW32t+wwU/BxJd/SXYAyoBX3gb2R3Q8/aX/6/XyJo=;
 b=ArQRB0Xt8lCOMCslyVErxO7J4SJohilUPLr1JQUa4mEuCoBhFwF6pVLlRF5lGQ64pw
 2NFsOivr4kZDhJOX1fsELhFiBpx70hBtzioO+pck67ekP9CUWnE6URLyYIZ1v02MQ/to
 vSQKSUCf6tXRu08K8nEli6K+svWuD/O9LvoopLMfXazhtg5JwW5OqL+BnY0eN7MfQwYf
 jbUxu0ed+c/rzQbBFaj9jMEb7GDCw+vRgQlnpE2F5IF0zmOdOPlE9vTvwj3XDJ9BgOep
 xVEE+AgwXXZcieXv5KR3Z+rBRL1Kw6xjFT1cljvX3NEQids9Ac5mVWCaEndaBaSKEpGx
 Ac0w==
X-Gm-Message-State: ABy/qLZXc4QMrew8xskOdMBL/8rHOaLxMJkIka5e9OMw//RlQlomXPz9
 2V1zEzXmOkthQc4H7bPuO4ViOw==
X-Google-Smtp-Source: APBJJlH9eQkXgbFNwzLC+urqqYjsDbn9vp6NCDsCOnLIA0NG1WPYBhqNnrt+w2IlX+tX9t9eQnTHXQ==
X-Received: by 2002:adf:e690:0:b0:317:5ba0:5c19 with SMTP id
 r16-20020adfe690000000b003175ba05c19mr5414959wrm.33.1690797431250; 
 Mon, 31 Jul 2023 02:57:11 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.143.207])
 by smtp.gmail.com with ESMTPSA id
 i15-20020adffdcf000000b003145559a691sm12532998wrs.41.2023.07.31.02.57.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 02:57:10 -0700 (PDT)
Message-ID: <e34a4919-130e-9993-313d-9c15bdfc6fdc@linaro.org>
Date: Mon, 31 Jul 2023 11:57:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] Fix some typos in documentation and comments
Content-Language: en-US
To: Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: libvir-list@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20230730180329.851576-1-sw@weilnetz.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230730180329.851576-1-sw@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 30/7/23 20:03, Stefan Weil wrote:
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
> 
> This patch was triggered by a spelling check for the generated
> QEMU documentation using codespell. It does not try to fix all
> typos which still exist in the QEMU code, but has a focus on
> those required to fix the documentation. Nevertheless some code
> comments with the same typos were fixed, too.
> 
> I think the patch is trivial, so maybe it can still be included
> in the upcoming release, but that's not strictly necessary.
> 
> Stefan
> 
>   docs/about/deprecated.rst    | 2 +-
>   docs/devel/qom.rst           | 2 +-
>   docs/system/devices/nvme.rst | 2 +-
>   hw/core/loader.c             | 4 ++--
>   include/exec/memory.h        | 2 +-
>   ui/vnc-enc-tight.c           | 2 +-
>   6 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


