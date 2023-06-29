Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E13A742775
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 15:33:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qErk5-0007PV-1A; Thu, 29 Jun 2023 09:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qErk2-0007Og-NU
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:31:22 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qErk0-00061X-6S
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:31:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc0609e13so3828005e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688045477; x=1690637477;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vKK56Zz1+4wlfChjLQ9Meej950YkZnAmmv7yuTuGeTs=;
 b=KebTocng5CBuZRp2+fBb5CIIIJ0JH6nGO7oH0Cd4VNpZ9GJyeKnhSBVmKhSX4ugiTa
 iH8avXLSsvi1nvQbyV7+WL4DFr7JHeHgwSHJX/e5I7geT/P70mKSAU4PHWMrFx8a9sJv
 X4Sbl7Pimc/uafo1Z2N9VeAmv5bNM2j2aa4x/o5cNMbzdESGbV8rA4/d2Oh3EQVQyrnW
 5RGSvwKq/LqlhFl1+x8/HbtuSi8s3yCJUTP41cZTWuntsWbLICPnb16h/Y4RzhPDNnc4
 p6Jj3Q8x6iAup4E4FXaBDJB9q4a26p/k7cbzZb9ak/BAXcAcgfqLLyl4Ue27n9eUc7CX
 mypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688045477; x=1690637477;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vKK56Zz1+4wlfChjLQ9Meej950YkZnAmmv7yuTuGeTs=;
 b=RUyLUqbmeo5jdG/t++5wteJJmzEbjYolJVC0Qi1tfDtSdfSFCsNSfaTOG59pWwfl/p
 mDW25sObljnfurlxe5ZvAG544JVzz/BJ6mcy/nE37bH1qhSKNnJGH20LwhklovHZXWG5
 rtahHaaGtwPoqymepEYftk6zGIatwHlh4OqFyzONCQRArzXiEt68BZS5Yyi57zeNyfMW
 arvqCHjsFnIsXGM0NDdFm/fhATrpEOjiG5E5MzMdPNUFheNhd+mPeauFnOwn+C6Hr8ph
 TnGpolRgiSVho+v23bsMJrFYtYDESdtES9VwAp6hRb0HGIqHvxUL3MdO27Np2TE7XDo1
 8XDw==
X-Gm-Message-State: AC+VfDylCPPc0+vdUadA3GxMd/Vz6MwLWNcIQfsgLF67sauQovBdhcCB
 eVi+ZdZkXIL0H+k2TKl9Cp0SSQ==
X-Google-Smtp-Source: ACHHUZ4CiUGEOLsPkvaP/hUsXKCUJxqGSPPAKcqPnaP17BgNmL7Pb594JaSbOLTPb25aFyYsypgLKA==
X-Received: by 2002:a1c:4b10:0:b0:3fb:7724:254b with SMTP id
 y16-20020a1c4b10000000b003fb7724254bmr7206485wma.9.1688045477280; 
 Thu, 29 Jun 2023 06:31:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a1c7911000000b003fbb9339b29sm1622400wme.42.2023.06.29.06.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 06:31:16 -0700 (PDT)
Message-ID: <969b58fe-5b4a-3106-eef3-96e39a9e72a9@linaro.org>
Date: Thu, 29 Jun 2023 15:31:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 20/36] docs/devel: add some front matter to the devel
 index
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
 <20230627160943.2956928-21-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230627160943.2956928-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 27/6/23 18:09, Alex Bennée wrote:
> Give an overview of the most useful bits of the devel documentation to
> read depending on what the developer wants to do.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20230623122100.1640995-22-alex.bennee@linaro.org>
> 
> ---
> v2
>    - removed excessive start
> ---
>   docs/devel/index-process.rst |  2 ++
>   docs/devel/index-tcg.rst     |  2 ++
>   docs/devel/index.rst         | 24 ++++++++++++++++++++++--
>   docs/devel/tcg.rst           |  2 ++
>   4 files changed, 28 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


