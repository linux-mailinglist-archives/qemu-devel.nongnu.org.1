Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8D0740570
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 23:07:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEFtU-00070O-N7; Tue, 27 Jun 2023 17:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEFtK-0006yj-Uc
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 17:06:28 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEFtJ-0000vT-Aj
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 17:06:26 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b6adef5c22so19936831fa.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687899983; x=1690491983;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s+mxbvopcN8GhtyLQyosyHXduhB/LupAIEMRtR9S99Q=;
 b=kGS7onlOB4geoA/XdBFX+p9ywgVLF+Ya/yS6AYbiWQ3Xgp6uN1THRCrVkIka9JD4mp
 b70qbTp/o2pi4aEyOgieWX9iRjSyOlECI194uURJy+fl81Y9zly2XBy6RuPQ5ijBYg5c
 M8UKlf3+EhUjg94e4WBLY3oQ3HlUp0uGVTYhkI3G9pAYEN3rFjQCH+nJU91vcMRRKd7C
 7MWmwJa7GuX1EnyuPL1JvXFwZe3sWCfoQfGJu2MHkIFYh2BwwQSw9+YocBrLlXr7h9aP
 wlRm4/lpfie9khCsw78VqX2lMDrU8smc3KCzHfaFCKz4U467lYZF8WjIhKw2lhBTNkWg
 feOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687899983; x=1690491983;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s+mxbvopcN8GhtyLQyosyHXduhB/LupAIEMRtR9S99Q=;
 b=eidhTEeBk9KUpp2yD4wnJuHq0uZQtKjR0mV2MBdYJqrzLFGWXuZ53+VYPU5VzTZpO6
 9wS5ckYdcqmHfHQVfNDF6ZKdu2xsXPOO+Ejxu2nW8G2PSogtQ3w+smRQnRuxx5QheGqI
 0sWr0VAUbQTOIcMYehcu8sb42ufQuzekYlkaIrPJ7j1VUpmw6Kc+ASueSEE/rZ1uVfWm
 zSL9zwV/6Gn5jCE3mawhgNDOtW0qlqAe8ul8zDejVHgjTquCl4VucBmWRcneODA723w5
 eJFuyMJYQ4P5HZA0QJT8BkCWnKpFVWQv7AA5nqMtySu5kghRLaffnZ9ndjd7YxEH65hC
 JgwA==
X-Gm-Message-State: AC+VfDxXJxPFMgVzo4hamcjr5Egm50BgJZof8gstSJmndB935cpCxE3X
 dC5/ri3REnROSbFyPO2i6oOLgw==
X-Google-Smtp-Source: ACHHUZ4f1qVZ7/fRnZpaOeLsDQGLZvHLPTnJxTFvEeLT0DrtxXdqmDDvsfFz2vgB/xxlaYc+bToM2Q==
X-Received: by 2002:a05:651c:90:b0:2b6:b672:5924 with SMTP id
 16-20020a05651c009000b002b6b6725924mr1623810ljq.5.1687899983545; 
 Tue, 27 Jun 2023 14:06:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 ce23-20020a170906b25700b009920f18a5f0sm1266693ejb.185.2023.06.27.14.06.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 14:06:22 -0700 (PDT)
Message-ID: <cafa811a-0212-36c3-4f93-b4937c7617c4@linaro.org>
Date: Tue, 27 Jun 2023 23:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 16/36] tests/avocado: update firmware to enable
 sbsa-ref/max
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
 <20230627160943.2956928-17-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230627160943.2956928-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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
> From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> 
> Update prebuilt firmware images to have TF-A with FEAT_FGT support
> enabled. This allowed us to enable test for "max" cpu in sbsa-ref
> machine.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Message-Id: <20230530152240.79160-1-marcin.juszkiewicz@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v3
>    - re-enable for CI
> ---
>   tests/avocado/machine_aarch64_sbsaref.py | 23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


