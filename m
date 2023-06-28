Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E107740BB3
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 10:39:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEQh7-0000UJ-Ax; Wed, 28 Jun 2023 04:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEQh4-0000Tj-Rw
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:38:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEQh3-0004kl-9U
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:38:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fa7512e599so66287515e9.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 01:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687941507; x=1690533507;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W/XpKXvP62dKscJ32XVUD0R+qNXsILZ9xTkZ/daFwu4=;
 b=nekdtCm41gKFJRW+ZxRrbZXaN7cAQZ5SzaieTmLPbsR1nw8IdQPJztv0rGiKAd1OV7
 tZo3cfKLkufRjaLXJVQn6t9+Ab3IRbngyCTvEZYGr7qaHUSrW/KBsfeGPg9cOOq3VLwu
 fdtA6LirLs0WAIqwENb+u9YdbdMGAYFkOHag4tx1yxquNceaGwWWjvS2owOoer8EkIN1
 YMHR386Fk0vjebyfBvnwiAZepK8eDDyqQ9InJyZKCqr8MG2EkiPgvgI9r5AfM24THFNN
 9KjxDsc/aO4lhUMkBw4g0kgmEma1IBeoPzOM/9qBfUvEe9PIj2HgIV4gKOT/Cu4vznKt
 Vf9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687941507; x=1690533507;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W/XpKXvP62dKscJ32XVUD0R+qNXsILZ9xTkZ/daFwu4=;
 b=Z8qxsa14VnyR4Go6uTVYTNtiP/8Fwqy0NL4OLGzrLV39LDOm1zXZbi8FHm5B6DVUFI
 4ugMmERJpra+77jTaGo/nNalNgRm45QlMoNpV4bmZQfL2FnwuzPN6yFCuQ9LnnQKHhoG
 hrwtjK+0zBRYFRySOfNyD0UTzuA6oGRTkN05rlL2S38JvMrTc780BL1YLRoDTetrYBMq
 1vhII6kQimNeFuWrlXyGFlHVCHGjYeSmBqchB6TBUdS1NgSFsfv/xWaXuCeO1a7kj14W
 lsks4nRi9nimDugb7IH4/ivDQP0zyCQReaCLZFafwUY1NIosWBaTfhLaYMNPry40H28X
 4iVA==
X-Gm-Message-State: AC+VfDyqUBwJo+aIaKadr2wBHWfZYPjsw3sH3eY93mH4MqzbBiet1kBF
 yED/g/n3OxfK8bzvcBaiFIha4Q==
X-Google-Smtp-Source: ACHHUZ4nNzGKdhNcnC5eEQl6KRDb+Q/S5pYGe3x09a0lx5JjcRhnlQAS7io9SLzsOmXeZe2SraXOxg==
X-Received: by 2002:a05:600c:29a:b0:3fb:a8ef:edfe with SMTP id
 26-20020a05600c029a00b003fba8efedfemr2783441wmk.18.1687941507354; 
 Wed, 28 Jun 2023 01:38:27 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a05600c364c00b003f7f249e7dfsm16174140wmq.4.2023.06.28.01.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 01:38:27 -0700 (PDT)
Message-ID: <fd860df5-f8d0-77ef-f99f-629f1631d577@linaro.org>
Date: Wed, 28 Jun 2023 10:38:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 15/36] tests/docker: convert riscv64-cross to lcitool
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
 Bandan Das <bsd@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
 <20230627160943.2956928-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230627160943.2956928-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 6/27/23 18:09, Alex Bennée wrote:
> --- a/tests/lcitool/projects/qemu-minimal.yml
> +++ b/tests/lcitool/projects/qemu-minimal.yml
> @@ -4,6 +4,8 @@ packages:
>    - bash
>    - bc
>    - bison
> + - ccache
> + - findutils
>    - flex
>    - g++
>    - gcc
> @@ -21,3 +23,5 @@ packages:
>    - pkg-config
>    - python3
>    - python3-venv
> + - sed
> + - tar

Same comment as against v2: Why not squash this patch with previous, which adds 
qemu-minimal.yml.  Especially since you're changing it here in the next patch.


r~

