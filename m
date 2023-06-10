Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 032F372ACAB
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 17:45:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q80lo-0002wr-BM; Sat, 10 Jun 2023 11:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q80lm-0002wB-8j
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 11:44:50 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q80lj-0001mz-Q6
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 11:44:50 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6642e056d7fso252210b3a.1
 for <qemu-devel@nongnu.org>; Sat, 10 Jun 2023 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686411886; x=1689003886;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xqO54wpGd3cshpXyp45gHaePm2/aagp21p7Hy3aYcX8=;
 b=ZLENVdn+XFKdTxSs+tbFqXuMfh17SBoi3X7lHtgCfF/9z/1+8qswpGXdUvEzKw+a8k
 UsLB3u71nz5YS+PlH3tafUGphkTJXmeHdmXagI+n6uh/waGCG/ne/gMaZumT3lFVKwaW
 n24L9d5a2fUmv4cLtH6fkmT+37LEDCvyb2wZwIzl+RuDJLiYYXeFdZWIO9WTWfkHPHgo
 yn72gTeQLAZiNsj1mTBuss1G1e6uZiy8+SR9zahoJqpoZoMd8aiyGqQSkIabocr5bEOP
 13ZuhOPGkvZTeeZBbIuQ+KMoJFkeNgWmM0a6pzBjVojUUH1BCXaJx650x9akyipLmPjE
 tBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686411886; x=1689003886;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xqO54wpGd3cshpXyp45gHaePm2/aagp21p7Hy3aYcX8=;
 b=QXJA+leDkoM18jJdfw5KD1a9VgRpGCP9tBQo6mQ+cc5SHxRs22ZqQvemwUAANmH//S
 rghcgkZ9u9BWMxFg2kudcxVmFGzaIYXB2p8co4/xwUIG5iT/xe0clYXsbGNFOyP8nQs0
 9kZ8CLX5kUETjPmvUAVhCxSiSVuH7S01am+eEQ2mday8cdvd6GU4Yfpzymv87seg5hBC
 3KVtfXOOwoyCSotu3ki9dKFIoQTHRIr91sb5n7wkmJJBju4tSwjPHK/EIbz5Ucb0C3fU
 y69CAeJ9HKTLu9EwBGCQ3ivkeZ9ZQ+AetU4yjVm04Eo/5hhxgaVfcNGGPpP5oCLT+bNd
 AfOA==
X-Gm-Message-State: AC+VfDzB4jqtgDdcTU8RFoh20YnGH/RE132ip4/HzY+c61pM+6LhupKq
 uBfI6YTuLsXs5pXmUSytdio9lRC0k3XPMBBcIAc=
X-Google-Smtp-Source: ACHHUZ6PuLtWb1MSrsyEFFaHDUxx+XvkKb9C3xjOq0yOkDWSNIQcFYKpqeelZXqEiNqhoS2yvfBj5g==
X-Received: by 2002:a05:6a00:14c2:b0:658:12ca:385b with SMTP id
 w2-20020a056a0014c200b0065812ca385bmr5570946pfu.22.1686411886135; 
 Sat, 10 Jun 2023 08:44:46 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:2db6:3c02:bd87:f559?
 ([2602:ae:1598:4c01:2db6:3c02:bd87:f559])
 by smtp.gmail.com with ESMTPSA id
 b21-20020aa78715000000b0064378c52398sm4338263pfo.25.2023.06.10.08.44.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jun 2023 08:44:45 -0700 (PDT)
Message-ID: <ea6f67d0-fd97-4d00-ff94-eb79402c4b5e@linaro.org>
Date: Sat, 10 Jun 2023 08:44:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/16] trivial patches 2023-06-10
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <cover.1686379708.git.mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1686379708.git.mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/9/23 23:57, Michael Tokarev wrote:
> Hi here!
> 
> This is my first pullreq in quite some years.
> 
> It looks like there has been quite some trivial patches which were forgotten,
> so I thought I'd give it a shot at least.
> 
> And since I haven't done a PR in a while, I basically forgot how to do it
> properly :)
> 
> Please note: there are 2 patches in there which are*not*  reviewed.  Being
> a trivial-patch collection, they're "obviously correct", - namely these are
> spelling fixes ("information") and adding comments in linux-user/syscall.c.
> If that's not okay, let's remove these 2 changes and apply the rest.
> 
> Thanks,
> 
> /mjt
> 
> The following changes since commit 5f9dd6a8ce3961db4ce47411ed2097ad88bdf5fc:
> 
>    Merge tag 'pull-9p-20230608' ofhttps://github.com/cschoenebeck/qemu  into staging (2023-06-08 08:47:35 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mjt0k/qemu.git  tags/trivial-patches-20230610
> 
> for you to fetch changes up to e928907105cfeb48b68cedce232bbd4784536707:
> 
>    linux-user: elfload: Specify -R is an option for qemu-user binaries (2023-06-10 09:40:46 +0300)
> 
> ----------------------------------------------------------------
> trivial-patches-20230610

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


