Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 132EC740574
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 23:07:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEFtz-0007kq-I9; Tue, 27 Jun 2023 17:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEFtw-0007gi-GT
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 17:07:05 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEFtu-0001Hk-RL
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 17:07:04 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2b699284ff4so53610321fa.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687900020; x=1690492020;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=APVxDd6lgCOHy9cpPK8Ts43N5aR9TxdOrvF2rjEZXgI=;
 b=Yb0C2eKkTp3V2e9OosWmbNq8jorJT5jkwrpqePGtcDz+MlXvb2vVHZfOGXQT+fIW0S
 0+PmHlnuFeCxB/XiEkwjxBnpeMuxU6/MzuXWPbnyz5sa1jIK7PWmpaf7Cpt+YqTAhDCi
 vMbQHJKTR+oAeL34yKd+wWejMeGLfL2U6dXupbmFQzpVZk/LUsaQotyklgRcCrvrawKm
 8aWYqwvI4O68Jwo9yLwRapbLcWJKK7S+XJjGlsypjXNeFK6fkFwBSemyvP7ak1JKdxHp
 J1UhstuikdnYcus/iieRXZy/k500oZCphnd4z8Os1WSZhhf+CaKg4hN7G0JvtOduySKB
 VoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687900020; x=1690492020;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=APVxDd6lgCOHy9cpPK8Ts43N5aR9TxdOrvF2rjEZXgI=;
 b=WfpGar18Y4+rfXTHReezkkb/iYLfmuVQDby3c4fKZKwRqPaxZ14Ff6+V1d2i3lJr7x
 mNEFZdksdtmOxZ3mAm2ueovLBTSM097Eq7mmPA3IBmeZ7Yq17+f8YRssQ8TvnlexpcxY
 p0d6BNzjr1cBFj5pG9jIP6YcQ7NYr7Dvl3utrOnT7rXLtkolQi+y3/Gsq4xv/c/6HQk/
 0EjfT9uwrdQnjnUHrAYpQdea7xXiIrf8oiQD4XbuiXn7enHpGWi9gVz42d+rL9kmg9DY
 U8771glqMNsWSy2MULXYfZJ+054Ekw5aowBb7mkX1vhVl/Yxaz24pItdI6bIZUwB2Qkj
 OO0w==
X-Gm-Message-State: AC+VfDxWrWOo/3F7p8Fo5wfnX+qZWGdWzpXNobGjeaMibpCEEWbJBvDw
 fOthDGNsVf+4ELESrN6So516hQ==
X-Google-Smtp-Source: ACHHUZ6BDKv4+8d0Fo6SS5SJnuE2OgJGSU/64zLoX+0duCe2qdln8VeYqm2b1wRBFW2XihjEfRnXUQ==
X-Received: by 2002:a2e:9b50:0:b0:2b6:9001:e447 with SMTP id
 o16-20020a2e9b50000000b002b69001e447mr5741786ljj.0.1687900020652; 
 Tue, 27 Jun 2023 14:07:00 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a50fb8d000000b0051d80d7a95bsm3990985edq.14.2023.06.27.14.06.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 14:07:00 -0700 (PDT)
Message-ID: <b287b67d-7bd6-6b0f-1cb5-14fd12099175@linaro.org>
Date: Tue, 27 Jun 2023 23:06:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 12/36] tests/lcitool: Bump fedora container versions
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
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Erik Skultety <eskultet@redhat.com>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
 <20230627160943.2956928-13-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230627160943.2956928-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 27/6/23 18:09, Alex Bennée wrote:
> From: Erik Skultety <eskultet@redhat.com>
> 
> Fedora 37 -> 38
> 
> Signed-off-by: Erik Skultety <eskultet@redhat.com>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20230623122100.1640995-14-alex.bennee@linaro.org>
> Message-Id: <c9b00e573a7a80fc6ce5c68595382f5c916a9195.1685528076.git.eskultet@redhat.com>
> [AJB: Dropped alpine (in prev commit), reflow commit msg]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/docker/dockerfiles/fedora-win32-cross.docker | 4 ++--
>   tests/docker/dockerfiles/fedora-win64-cross.docker | 4 ++--
>   tests/docker/dockerfiles/fedora.docker             | 4 ++--
>   tests/lcitool/refresh                              | 6 +++---
>   4 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


