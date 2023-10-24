Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C99F27D4F3C
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 13:52:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvFva-0004gl-69; Tue, 24 Oct 2023 07:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvFvX-0004W3-1o
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 07:50:27 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvFvV-0006xh-Dr
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 07:50:26 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9b9faf05f51so629179866b.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 04:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698148223; x=1698753023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tFNkksxJIeSv3+7doL2YjUOz2Bf6puKbX7Oo6QSRG2I=;
 b=zxMn526XMjPggf3ONConbBA/GkSW1bOWt7jlg1NpIexsBznAtUjHtrzuq4y7KGIfSo
 ZtM8e3lNscInLl2ilT7kiY2NfNba9UyKX+Z2Fc862t6GGjQR7LxKzW9o6R1kGf+oFlHR
 7TrHvoLcl3OhrghVbSuseuYXVhV3sSElI2sPms2ECQl8icDMgARAVym3nkDjA4pqZJ64
 tN21BNcbFwE2UlTpzo/f5TdcxR+/mQ1a7U+jIU6WV8W5J8xAeqyUHlzNC2ZFFdLBrDG1
 ZQeP0erZBrCfbbPCq7so+ZfnuHW//wYYiDlDlgPyVVTPdnJmCRiivqK+yCNZxWhTiVSy
 SUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698148223; x=1698753023;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tFNkksxJIeSv3+7doL2YjUOz2Bf6puKbX7Oo6QSRG2I=;
 b=ZJkxAtzp90F3QHrAwsIheH3HxkfEnbnN2OdQQ+RC+MnrdqtJZyH/6Mpop8QpT5yNWz
 +McOrtVmytlU5x4tYdox3IjxjiGxCQNHkMNsBWzKDJFm1bZql9c+eQ+e6Jm3OsELpxYW
 p9B/kcsSyjUYBu9nfxcaaM/KJPmoh257tx/AtA7P5MWgtd0R9zUmUoUjUk2QvLP9zmqX
 gHR8zltMSvCKfziGEEIXwXiqoNJ475QPOg6Fgz/1ui/GUVAP7nEqArpnHn3QlJQSwxAg
 PuhRBW3Ev7BL88iOBJcbkhYElR474RESbFlExsETGiF83kH+C577e0q0MkjBaZkHjYhd
 Ap3w==
X-Gm-Message-State: AOJu0YyIpIvX0MwiXifLJNNhTC42rsFENWZ5qz2XvQCuUC0qeeXCb+RZ
 TRZpemIBTDB1LKysx/jaoxViHg==
X-Google-Smtp-Source: AGHT+IE8+GJzhB/+IeuU/XMieiqGpVYgjT3uKYrPexPExMx3tqZVNcwzWh5ToHzG1MrXuDrnlViF6Q==
X-Received: by 2002:a17:907:749:b0:9b9:325f:9be7 with SMTP id
 xc9-20020a170907074900b009b9325f9be7mr9643028ejb.42.1698148223054; 
 Tue, 24 Oct 2023 04:50:23 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 25-20020a170906005900b009c65e13c33dsm8081879ejg.122.2023.10.24.04.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 04:50:22 -0700 (PDT)
Message-ID: <c87866ad-568b-1917-7617-c63b137a196a@linaro.org>
Date: Tue, 24 Oct 2023 13:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 0/8] PMBus fixes and new functions
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Titus Rwantare <titusr@google.com>
Cc: qemu-arm@nongnu.org, minyard@acm.org, qemu-devel@nongnu.org
References: <20231023180837.91785-1-titusr@google.com>
 <874jih40a3.fsf@linaro.org>
 <CAMvPwGpXZxyoX1WNypgNCW+Uj+bcVPn99vF71Myx7jn_c2Fjdg@mail.gmail.com>
 <87zg082twp.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <87zg082twp.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 24/10/23 12:06, Alex Bennée wrote:

> A pull request is really just a GPG signed tag that you push to a repo.
> You can use the existing git tooling to create the cover letter for it.
> 
> I've included my exact steps at the end of the email but really it comes
> down to:
> 
>    git tag --sign your-pr-tag
>    git push your-pr-tag
>    git format-patch <series details>
>    git request-pull origin/master your_repo_details your-pr-tag
> 
> and finally
> 
>    git send-email
> 
> My personal exact steps are integrated with my editor but are:


> 8 Preparing a QEMU Pull Request
> ═══════════════════════════════

> 9 And send the pull request
> ═══════════════════════════

For these steps I just do:

$ git publish -b origin/master \
     --pull-request --sign-pull --keyid=0xMYKEY

which uses .gitpublish from commit 08bb160e02,
calling get_maintainer.pl for each patch.

Using GSuite, I also have in ~/.gitconfig:

[sendemail]
     smtpServer = smtp.gmail.com
     smtpBatchSize = 1
     smtpReloginDelay = 3

