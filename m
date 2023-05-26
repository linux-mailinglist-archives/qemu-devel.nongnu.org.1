Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D74B712A17
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 17:58:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zpe-0005wC-C9; Fri, 26 May 2023 11:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2Zpd-0005vz-31
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:58:21 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2Zpb-0000cY-Gu
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:58:20 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-51b33c72686so577409a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685116698; x=1687708698;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DmcPZLe4B9Hbx4OpD18rHZ9yLwXuM9h4/2gT14dh50I=;
 b=KULGiC/QubphpgIkp1Od5RcwkwSh+TSxTvgI3ay2fBbZjURHgvJUOEH5nuzYjkEynd
 S/vsqLVCo4eXLc/JuE6CwoqGRYa64LT0QOS190lmdswJ9YXf4QYWHMGDVn9aIi1Flwmb
 08F1vNUQr+4XYWpqv8PHRdg6RJkwk/NzNGWfHbeEwT57H8qouuP1QVQNpGRVOludiaXD
 vRqDKIRQD7kC4F6KAgd8d/ucPSvzAT2yTvNpdIQeVYJ9SN/OGIQcliefXEVt728xBVgm
 CZjIu71lrFYhZUt1tStle6uPsIEzi9snls8el0iQXJU5OThHcrDdXvhf2WCdeOW9E1Ge
 SdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685116698; x=1687708698;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DmcPZLe4B9Hbx4OpD18rHZ9yLwXuM9h4/2gT14dh50I=;
 b=QE7aoss4r4IeORyjLGiUm26+asuWt6p3+q2WusCpIxYEHKLMxU2HbBcX3BlrTfuXr3
 JG1icT0iGvVFG/hzDJ5lzlG0e+95RL49ila6d1MvKfcWh/OWqcsLlb3OCYIXhA3J9MmF
 AqI+cocIyXr4n9/S+wWJCDLV0t4yg4no7J1VRjgYOTCJ3cDnOnXH87TeQhEwnEUu3VSq
 Da4SfKK0IsLmdsgEPex+HAi1Px85oaUEwEtJktMtPSz+f5u3Bv7nqkNsPOxvjOw6pKE9
 EU4qsUHckwhUs+7gCKAVuzASAMy/BTf6QLfVdPsBck0NyeZZAQ/01tZS1XuZcRbsiiTK
 Jw+w==
X-Gm-Message-State: AC+VfDyocttzqDibzbEz5Nmjr2dZCmUT2N64cht+uv24H8ScgucmbHxK
 cZA8KKJqRd+5oUgQ1LkWL+YFNw==
X-Google-Smtp-Source: ACHHUZ64EQ7pHBKqS5arxHe5aduPHvZ1jTYATFDcEWcSwm1HtK8maB/o+GxnKJfsT6ilCLROKlKHsQ==
X-Received: by 2002:a17:902:bb87:b0:1ae:4bbb:e958 with SMTP id
 m7-20020a170902bb8700b001ae4bbbe958mr2835964pls.14.1685116697999; 
 Fri, 26 May 2023 08:58:17 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 ij30-20020a170902ab5e00b001adbb8991b3sm3499534plb.89.2023.05.26.08.58.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 08:58:17 -0700 (PDT)
Message-ID: <ae71eab9-de2e-22ab-7b36-4241a369ae90@linaro.org>
Date: Fri, 26 May 2023 08:58:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/5] gitlab: allow overriding name of the upstream
 repository
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230526101934.935969-1-berrange@redhat.com>
 <20230526101934.935969-3-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230526101934.935969-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 5/26/23 03:19, Daniel P. Berrangé wrote:
> The CI rules have special logic for what happens in upstream. To enable
> contributors who modify CI rules to test this logic, however, they need
> to be able to override which repo is considered upstream. This
> introduces the 'QEMU_CI_UPSTREAM' variable
> 
>    git push gitlab <branch> -o ci.variable=QEMU_CI_UPSTREAM=berrange
> 
> to make it look as if my namespace is the actual upstream. Namespace in
> this context refers to the path fragement in gitlab URLs that is above
> the repository. Typically this will be the contributor's gitlab login
> name.
> 
> Reviewed-by: Michael Tokarev<mjt@tls.msk.ru>
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   .gitlab-ci.d/base.yml      | 19 ++++++++++++-------
>   docs/devel/ci-jobs.rst.inc |  6 ++++++
>   2 files changed, 18 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

