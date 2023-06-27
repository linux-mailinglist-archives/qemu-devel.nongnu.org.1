Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBBD740576
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 23:08:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEFvC-0001b2-92; Tue, 27 Jun 2023 17:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEFvA-0001aT-Ea
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 17:08:20 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEFv8-0001e6-O4
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 17:08:20 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f95bf5c493so6830853e87.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 14:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687900097; x=1690492097;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jPXqBjJQB6zR5aw2KxKMxwWAb2URZlZwWQZH6PKptXc=;
 b=Azm+eQM2DiLG8fFP9qKM94l/knuW2MHwkDDsm06Bg42SmlCPTZRJ6ktmYO+szrC1jL
 VyiZ3tKIf6dD7Evjrnr/0JvyLwOAnjUsSgPyY7m4lW/5oqoFb8/6eeLgVkT5CoiBz+n2
 LMG1OmpUvlUXiy40qE0RXCWSZpD3BlOF7Wy76olxr4/o9NDdMtlv0g+dYRGNlR3e+0Cy
 MTFDdmxoztx8KryVDm9vxjg6ch5KrMxh3FhXNZ8+BWFYpOitxxhifUrW56KMb1n5+PiJ
 VgAjKTXpS0M464ATF0CmaFO//XQkRYDpiitw6E5gKNyEpe3iZncyQZhas30GQhLk0UeR
 p7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687900097; x=1690492097;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jPXqBjJQB6zR5aw2KxKMxwWAb2URZlZwWQZH6PKptXc=;
 b=dSxuK68eQCLV87dRJjPw68mx+vg3U/GEE+5p5dpVUtBC9cXWch5KI2NKMvanNW7ll0
 n98AAkBOpzwsACLQwFXVNaCOT6FGI2zLy4ZnaFY1zuDih+6m/BrDS4smNiHYtDCcSe9e
 QyIHRLSg3IiZM0ouQfESM+ScMpTyH85Mn8wd+/O5FxQj31B2/Kr5bWu2TcYU2xPYK6Kz
 Ww+mXaPWxQD/SXZQeJRUkcCBdGzF51po+o0PAvTrrRBT77D+J1FxrFuyFie9I9Op7GhX
 a3t7RgFKgYn4tGP20ivohxS6MndN7vjMRFbDOxasuw2j+PvrntP8PAKYMstt9RioTijl
 xtLA==
X-Gm-Message-State: AC+VfDw7HESvhlG2J1pZ6qch3phj0wXkFTHMabHszWQL0aot9U3TIDjt
 CBhj9/jeapnkkLSLv6SF7+IXCQ==
X-Google-Smtp-Source: ACHHUZ6qlVbqi35MtXrToV6/Mi19nQVm35qAzeGjRxAoAv3f8dJChlRL1pe2wWuS6KEquo90SBKbOQ==
X-Received: by 2002:a19:6402:0:b0:4f9:51ac:41eb with SMTP id
 y2-20020a196402000000b004f951ac41ebmr12500440lfb.16.1687900096973; 
 Tue, 27 Jun 2023 14:08:16 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a05600c364c00b003f7f249e7dfsm14945949wmq.4.2023.06.27.14.08.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 14:08:16 -0700 (PDT)
Message-ID: <cd9eaa82-2b29-8913-9cdf-22e845f4baab@linaro.org>
Date: Tue, 27 Jun 2023 23:08:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 03/36] gitlab: reduce testing scope of check-gcov
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Bandan Das
 <bsd@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
 <20230627160943.2956928-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230627160943.2956928-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 27/6/23 18:09, Alex Bennée wrote:
> This keeps timing out on gitlab due to some qtests taking a long time.
> As this is just ensuring the gcov machinery is working and not
> attempting to be comprehensive lets skip qtest in this run.
> 
> Message-Id: <20230623122100.1640995-4-alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/buildtest.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


