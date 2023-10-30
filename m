Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 096A87DB272
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 05:12:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxJcb-00081U-28; Mon, 30 Oct 2023 00:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxJcQ-0007xo-1t
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 00:11:15 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxJcL-0005p1-Ab
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 00:11:12 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507f1c29f25so5545621e87.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 21:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698639066; x=1699243866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uCAF7+5h2JNv9jDIOphTA/+PoR3E+57mMmsuZ8hwwkU=;
 b=kYhdvSuTqlynOz9efePUuIFVdszrp4XMVP6MjS7PYZEGI75DVY9x0QGb2AcJt/KIrR
 bJtDJ3Jg5rfJa+U6keFGWSTXvrvTjPo4eEEb3qqtfERleoqywy7BO9D1zKp/+oAWMBuQ
 vFKtBs2OiXTTLp0+eGy+ZLI4tJVNXAc4K0yeArYKP2TA+Cnm4jJxmsHywcXkSvZfi+9e
 0HI/94SW9mcEG5ZaTCkmUoOB9HsSP6KTKiyKxPtODtHkJs+/kZasULp6w6PhChxI2WLv
 vY8z38YWo+5BopC6mwfuDEZGtRW+IxD3zD1Jv51E2C8xsqxqHQE9dK/O5E00r4UWrP/7
 YPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698639066; x=1699243866;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uCAF7+5h2JNv9jDIOphTA/+PoR3E+57mMmsuZ8hwwkU=;
 b=sEg6y+Vh93yepM/x7R/zd6QobpgoR4m0AhXCdCTugQlpqdVZvtm4xqZ+T2QjkfZdRE
 2UbjcTS4gmI2GKcWfZF/evM0eXrbQxUDOeKPm6Cqi/x9C8dtowJV9WPNAiwsTqU4GD6s
 +uOvvoChM8CwLYGEXpWFldtdwGdfH9mqMTTBbTwAZ1nQXlQdu0fVsnCMqidXuh1EJ6Yl
 lEc1sKti4oEMb1jnmFc/j2GSYvfTVU6tguw6mEuorhtSvw8bThfoc4U/ShrRkZtAIWEA
 0O5/nGpvwxxPyBn+vbtxAufFK7NNaDsk652FBJNx0RDnaCBLq+D2ql5++xYvh6/zNriW
 jDgQ==
X-Gm-Message-State: AOJu0YzXlq9cWNc3Hj/ukc+USmpwVDu+YWaIfx9F62QDCPkPWZp/vsI6
 RRy3951zow4XG0HwvTQ8CXRKaQ==
X-Google-Smtp-Source: AGHT+IEf+NrQRIp69gqL7w1wVhrFh0VtK70ZKXc4QtYn4va/drqob/pjM1TXVvngLSi7G1fE1gdxGQ==
X-Received: by 2002:a05:6512:2256:b0:503:1aae:eca0 with SMTP id
 i22-20020a056512225600b005031aaeeca0mr7874230lfu.44.1698639066470; 
 Sun, 29 Oct 2023 21:11:06 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a1709063b4a00b009adcb6c0f0esm5279033ejf.193.2023.10.29.21.11.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 21:11:06 -0700 (PDT)
Message-ID: <53a87de9-6586-5a66-de53-152dc4cb4d1d@linaro.org>
Date: Mon, 30 Oct 2023 05:11:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/ufs: Modify lu.c to share codes with SCSI subsystem
Content-Language: en-US
To: Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, kwolf@redhat.com, hreitz@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com, fam@euphon.net,
 qemu-block@nongnu.org
References: <9fd0dc1f55724fa79011be231cc27bf4aab11157.1697764912.git.jeuk20.kim@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <9fd0dc1f55724fa79011be231cc27bf4aab11157.1697764912.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.972,
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

Hi Jeuk,

On 20/10/23 03:51, Jeuk Kim wrote:
> This patch removes the code that ufs-lu was duplicating from
> scsi-hd and allows them to share code.
> 
> It makes ufs-lu have a virtual scsi-bus and scsi-hd internally.
> This allows scsi related commands to be passed thorugh to the scsi-hd.
> The query request and nop command work the same as the existing logic.
> 
> Well-known lus do not have a virtual scsi-bus and scsi-hd, and
> handle the necessary scsi commands by emulating them directly.
> 
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> ---
>   hw/ufs/lu.c            | 1473 +++++++---------------------------------

I liked this patch intent, but almost 1500 lines changed in a single
patch make it impossible to review. Ideally each patch shouldn't modify
more than 100 lines, otherwise reviewers are either exhausted or can't
be careful enough and miss possible bugs or design issues.

Regards,

Phil.

>   hw/ufs/trace-events    |   25 -
>   hw/ufs/ufs.c           |  202 +-----
>   hw/ufs/ufs.h           |   36 +-
>   include/block/ufs.h    |    2 +-
>   tests/qtest/ufs-test.c |   37 +-
>   6 files changed, 315 insertions(+), 1460 deletions(-)


