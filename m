Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A59687BE128
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:47:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpqbL-0006yz-UV; Mon, 09 Oct 2023 09:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpqbK-0006yQ-7W
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:47:14 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpqbI-000223-Kt
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:47:13 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5334d78c5f6so7885125a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696859228; x=1697464028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5ydDy+YPNhU+80dL8Twg02LooI+4fzkEjKHkhpsrz78=;
 b=qhu1ZBZZ0gWdD61Odqa1nyUKVYYDBjJ1d9oGknY/CfPAKh5e+wxI4QtGRZ9uMPW1CT
 8FKd9FUgJJg95Tw9KKpYO07P18Ufyb4+UJZRPsfi8CjRKcoDKMiV66nlrCTZ/oKaQOhU
 078t+higM0O8ejIn3cAfq+PJY+7OoqXvSf1z8Szxg8fOWIT71hDWURCY0c4mGxTl8RG7
 zXxrA/nEhQAbaKxi3ytb7lQidtYu0SEtIK+HDub9a2eoICwGflu7o2bOVtD6hNn56cSf
 hY5qtq1F2Dn8ZrfsvwReuhVhE38+oU/U+IkYio3ovdw3Xp+PqSMCbeXoIzqaUBMFyWOX
 N35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696859228; x=1697464028;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ydDy+YPNhU+80dL8Twg02LooI+4fzkEjKHkhpsrz78=;
 b=wdIutUPiOKYp2Ejr4TV/9jWk16MPhN1uzgwqe4vOuvuLSLT7HKS/xyTFUGU88+DcK8
 xT4GfCBnTs2OL7Sw2UE2CxY7fAv0RB5SKtr6iwQNVe1oa7ewPB3HT1tjs+cbhpmz6YmE
 gv54zhloHYf9gqnjJxSurwXhZxm56j9fjUJM+f5IbLZeylUdet64aOqolj4GPr+rxVl0
 Lk7wP3fS4w048o20lvMSUbjlBmn89RmZv+18yp29gkP54xB/ooCa9IYWYIlRK5IslKI9
 xHns4KQ6reSmNeI3xTe37QKoqPEZaewG7pHg9tSmE/qgX1qzVCdtzYwBDjNkncnSfIaa
 npVw==
X-Gm-Message-State: AOJu0YwbeWG3OUnygwBubS4BviCi5+wTGdIgC6IrXzQlFz6XQ9yOchnP
 Zk94nmH5RMI3KxPpkuiohrfwNyKOZEezRN24aFY=
X-Google-Smtp-Source: AGHT+IFHFeMR/gqawQ14OdDrOO23N1O7aWhqmc+KMmRK3M/oHGYGdyfu2qfTikiC2EvzlCiVgHlb0Q==
X-Received: by 2002:a17:906:301a:b0:9a5:b814:8254 with SMTP id
 26-20020a170906301a00b009a5b8148254mr13663789ejz.24.1696859228384; 
 Mon, 09 Oct 2023 06:47:08 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a1709061b0c00b009a1fef32ce6sm6918826ejg.177.2023.10.09.06.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 06:47:08 -0700 (PDT)
Message-ID: <817dc2a2-c2ee-f836-3333-51789ce3b45e@linaro.org>
Date: Mon, 9 Oct 2023 15:47:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PULL 0/2] Dirty page rate and dirty page limit 20231009 patches
Content-Language: en-US
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
References: <cover.1696855875.git.yong.huang@smartx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <cover.1696855875.git.yong.huang@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

Hi Hyman,

On 9/10/23 14:57, Hyman Huang wrote:
> The following changes since commit 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d:
> 
>    Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2023-10-05 09:01:01 -0400)
> 
> are available in the Git repository at:
> 
>    https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-pull-request-20231009
> 
> for you to fetch changes up to 84719f6d0b75448400068adb78d85000e884f0cd:
> 
>    migration/dirtyrate: use QEMU_CLOCK_HOST to report start-time (2023-10-08 15:06:12 +0800)
> 
> ----------------------------------------------------------------
> Dirtylimit and dirtyrate 20231009 patches PULL request
> 
> Dirty page rate measurement optimization.
> Please apply, thanks, Yong.
> 
> ----------------------------------------------------------------
> Andrei Gudkov via (2):
>    migration/calc-dirty-rate: millisecond-granularity period
>    migration/dirtyrate: use QEMU_CLOCK_HOST to report start-time

Invalid author Andrei Gudkov via <qemu-devel@nongnu.org> in patches :/

Please correct and repost.


