Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C36792232
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 13:39:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdUOl-0004Bk-53; Tue, 05 Sep 2023 07:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdUOh-0004BD-KX
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:39:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdUOf-0008IA-HW
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:39:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-401da71b85eso23607685e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 04:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693913944; x=1694518744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7G9muceHhkh6Eiwn/gKmfO3bfTsGmcceyWKO0o+rDSc=;
 b=sH3FRzDgJMGrnbubpHNeZvFYQoCNH3aRZZG4Eyb0NaUP2mGvcamsHQJTtXRAsDkIkq
 kJa2zyCZSI10JCB5q3KB8nq9Il7/bEFLiwTU0j/8CmEJVMuT+vP4XbUAPetRTML8MWBt
 Jy1l8+C4m54nnqLS9Rv7m21Gr9JnAfd5m+1rBZRn2bJMipSkoB2q/Ecbhh+cKyMb2rjH
 ZTDZKwNHRBpSzC0cn0dHJ+DLTgqD7HytJa9ur2SE9mFbgPukW2nWC0yKQ7HEF9STpEOB
 +aGtMVK0dgOnmjoxxFHxmoq5ZNhcZB/ubo8Da3TLrUXj/YOu0Sd1c74/SyulrPre6lBs
 Herw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693913944; x=1694518744;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7G9muceHhkh6Eiwn/gKmfO3bfTsGmcceyWKO0o+rDSc=;
 b=OV0CdzSKb1ZnpkjpY+jPhH41BOA54/ZB9vVRmb8jQ7Aqt2H70qReSESR9qmnMBtZBC
 XEKOhHUr5W2NCH8FHq7dwTkEs+2rnSup3kYQ3tnIaR2AqZjZVWH4UDA6lsDVVN5L7855
 zPrpH52oobD7f1HlXIl0YPfhvQ5lyV9/emIaNsiSFuYjs5xGmeCcaaVaCB5+EK9Ltzuy
 0fvbd0FRoi1NRfwC94KW+pPdEH/8DS6UQcsIBMT6nBVPQWjs3JMjntxd9w3A2qECaCtk
 mJaUF7iZ1lPWIVjlxoqbLD06cyB1P6q9/dOGaYicD9ZDwt2uIfkonXe2h3ZQ0UOxNYn9
 EmqQ==
X-Gm-Message-State: AOJu0YxbJnq9tl5ZErA4ohH8OgUG5rqdgsIepHzoTvVZKPfWchIykar3
 /BP0C49Ob6LfWjL6+avLDnvV9PWeh5ErtNTmK38=
X-Google-Smtp-Source: AGHT+IE/Y+ZmAnUArUckKJBy0/qC2JcsIeS0aQZrt4D0+rEylu6h4/XyQkUuqUnK61kYlZcQPpz6Gg==
X-Received: by 2002:a7b:cb8f:0:b0:3fc:e1:24b5 with SMTP id
 m15-20020a7bcb8f000000b003fc00e124b5mr9637379wmi.23.1693913943930; 
 Tue, 05 Sep 2023 04:39:03 -0700 (PDT)
Received: from [192.168.1.34] ([37.69.27.38]) by smtp.gmail.com with ESMTPSA id
 a28-20020a5d457c000000b00317f70240afsm17275400wrc.27.2023.09.05.04.39.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 04:39:03 -0700 (PDT)
Message-ID: <b7a7dbd4-cfdd-de9b-bf56-407c67156c1e@linaro.org>
Date: Tue, 5 Sep 2023 13:39:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 14/14] scripts/analyse-locks-simpletrace.py: changed
 iteritems() to items()
Content-Language: en-US
To: Mads Ynddal <mads@ynddal.dk>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-15-mads@ynddal.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230823085429.20519-15-mads@ynddal.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 23/8/23 10:54, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
> 
> Python 3 removed `dict.iteritems()` in favor of `dict.items()`. This
> means the script curerntly doesn't work on Python 3.

"currently"

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>   scripts/analyse-locks-simpletrace.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


