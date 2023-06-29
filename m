Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC3D742799
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 15:43:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qErto-0001Kt-8O; Thu, 29 Jun 2023 09:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qErtm-0001Jm-Fy
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:41:26 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qErtk-0001oH-Kn
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 09:41:26 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3094910b150so772993f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 06:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688046083; x=1690638083;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dnZTPLoaZx8Nk2z2XqVUeu3zBMJ+VXgYU2pI3EyyALU=;
 b=lVVQRlI4e7t+vBB9rVzKojGN4kU25H1f+xQzkHR9TAFmif2DiOHOXPyqVsiWoO1grG
 erukjuPHPaOh4EWH25N2j9lcjBfjHAmTGYMaOn32lLyI4EeOkCnNddoDctNEnZfLPjEz
 NQ5uzh+na9ythm12pnYZGBIT6RnmsAxiQJDOu3VcQePwXgtCdCHOd2itFwxWVUbK3Gi/
 L0sl/Lh3H3xkE3WUUudvcaW/EyIaeO8ewP4HjEqzzhnPGktTE6DrvfDiCuDUdYH3ilt0
 WYalxOVLVkkqsmRlyuL/ZI0lxWMVq/M2k46TrUfQuuRY7L4NHU8jQJ2sI0YtkBl5IF8j
 jIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688046083; x=1690638083;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dnZTPLoaZx8Nk2z2XqVUeu3zBMJ+VXgYU2pI3EyyALU=;
 b=OvSc8B6VYDb9Bip4JnDJk+ijisr57qt+7A2VUeDEPQyhMNNGmFEJyETBSF3XGU6Z36
 P1alzDJZlo9vPsBjE3fqg0zx/6Odv0TOmOh8NUHjWGT2yQpxzibcpTkEcfTO8hkp34ON
 In4M/nZw5ueJgV8jptNCf4s1S44DcdiUXApHsZbJaHIgzlyUKu7I5cHw2vN6AHXVz8E9
 SGFlr2MtdDbYT1ge2nr4lcxlw/o5MTO7p1M1MSYgGX0kz5s8shD3/uCXC/fsGX/0aPpd
 Sid2R61ulj4fbAwJfdp0u7xZhdysRBYmNk7bhkQp6bUhNq4YBCvjC80aH1CEoHefuong
 0WTw==
X-Gm-Message-State: AC+VfDweKPuwOLIWGf9oOgTJqQFoOX+XaxLUn3tkkwwjujcMekTnEW7W
 ifDzZlsXoLU53etTqbmWw/l7aLqHlWo6ntmpNeM=
X-Google-Smtp-Source: ACHHUZ4EYiDqc/h9ZzKwyQN4znT6jHnZB6a8dhdjX5fniQjgQL0MOXirXzXHuRRJTTqWV2h41tWu3g==
X-Received: by 2002:adf:f98c:0:b0:313:f5fd:62af with SMTP id
 f12-20020adff98c000000b00313f5fd62afmr8204591wrr.18.1688046082791; 
 Thu, 29 Jun 2023 06:41:22 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a5d6782000000b00313f5babb18sm9983596wru.9.2023.06.29.06.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 06:41:22 -0700 (PDT)
Message-ID: <b08189c8-38c2-adbf-7bb3-0304f4845fc0@linaro.org>
Date: Thu, 29 Jun 2023 15:41:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 25/36] docs/devel: introduce some key concepts for QOM
 development
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
 <20230627160943.2956928-26-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230627160943.2956928-26-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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
> Using QOM correctly is increasingly important to maintaining a modern
> code base. However the current documentation skips some important
> concepts before launching into a simple example. Lets:
> 
>    - at least mention properties
>    - mention TYPE_OBJECT and TYPE_DEVICE
>    - talk about why we have realize/unrealize
>    - mention the QOM tree
>    - lightly re-arrange the order we mention things
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20230619171437.357374-6-alex.bennee@linaro.org>
> 
> ---
> v3
>    - moved around as per Paolo's review
> ---
>   docs/devel/qom.rst | 58 +++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 52 insertions(+), 6 deletions(-)


> +Creating a QOM class
> +====================
> +
> +A simple minimal device implementation may look something like bellow:
>   
>   .. code-block:: c
>      :caption: Creating a minimal type
> @@ -48,6 +66,12 @@ In the above example, we create a simple type that is described by #TypeInfo.
>   #TypeInfo describes information about the type including what it inherits
>   from, the instance and class size, and constructor/destructor hooks.
>   
> +The TYPE_DEVICE class is the parent class for all modern devices
> +implemented in QEMU and adds some specific methods to handle QEMU
> +device model. This includes managing the lifetime of devices from
> +creation through to when they become visible to the guest and
> +eventually unrealized.

Good enough but we are mixing QOM vs QDev...

>   Alternatively several static types could be registered using helper macro
>   DEFINE_TYPES()


> +.. _device-life-cycle:
> +
> +Device Life-cycle
> +=================
> +
> +As class initialisation cannot fail devices have an two additional
> +methods to handle the creation of dynamic devices. The ``realize``
> +function is called with ``Error **`` pointer which should be set if
> +the device cannot complete its setup. Otherwise on successful
> +completion of the ``realize`` method the device object is added to the
> +QOM tree and made visible to the guest.
> +
> +The reverse function is ``unrealize`` and should be were clean-up
> +code lives to tidy up after the system is done with the device.

Worth mentioning hotplug devices must implement it?

> +All devices can be instantiated by C code, however only some can
> +created dynamically via the command line or monitor.
>   
> +Likewise only some can be unplugged after creation and need an
> +explicit ``unrealize`` implementation.

Ah, here we go.

> This is determined by the
> +``user_creatable`` variable in the root ``DeviceClass`` structure.
> +Devices can only be unplugged if their ``parent_bus`` has a registered
> +``HotplugHandler``.

TODO on top, mentions the reset() handlers are called after realize(),
and can be called multiple times.

>   API Reference
> --------------
> +=============
>   
>   See the :ref:`QOM API<qom-api>` and :ref:`QDEV API<qdev-api>`
>   documents for the complete API description.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


