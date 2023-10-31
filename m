Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 062C37DD76E
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 22:02:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxvrw-00056G-6j; Tue, 31 Oct 2023 17:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxvru-00054u-Hz
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 17:01:46 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxvrt-0003Ag-1S
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 17:01:46 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5af5b532d8fso56129137b3.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 14:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698786104; x=1699390904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+DTsQ99RyLvWC+kdAPoJeEs/zAeYRfIagUj34vpHjLw=;
 b=KvWGLWC6ZRP5SQNdHv9CqMbTbqJDWkDzF5ryoLzskizVRYMrYhogXii2uKfGbzF6Ef
 OxnvgBQlZObRvJq93Q9/HeENebdOwvhf4CMXswmGEf26JmIcTNLCQaPhKaU/BgvIueJg
 bEyPwqI52NQaiZ9YpjoFbyvEJYhB2yF98GGoCiNU1V4V/uDtySXECQ43mRqMLmwIrdBI
 D4RQlzzCSmHI7aHv22lz3Fgc0khg6Gebt2MZpI+wJyZ+rmDn9ftgOH2iAPTV4/PnqZnO
 ksvPS53/NHEwYzjaaiHKJ4x1VosglSY4Nk6h/d9jLcf4YtNNGge10soofdH4EwE2tcxw
 Oumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698786104; x=1699390904;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+DTsQ99RyLvWC+kdAPoJeEs/zAeYRfIagUj34vpHjLw=;
 b=hEGI5qnTONnchX/qdd3BwUKY1qEYjFNw5Q56b6yxSDHANtxHykGCHS4OSpRjuPa/Em
 inlky3hcYtzbvimv+WeA0JQKKyGN2Q3gKOHyfNC4MJ7Ddv6TIFWu5obEu17UaUxoFr/v
 xGGbzhKqzOh8W54R1C4/ayoIdFkc/5WTLndEzPO3gp2BDDHqAxocb56NP7qM7Gw7QqiL
 jciPBjzThfMk7B61UZwhfJFyjIhFoRKd7xWmzrIfhmZQ/82bdiZtTjpETwlO3jxTcOUj
 iMJJt2D0DXDMBvvEv09k8PTbaFvlDyBCcNo2Z6KdO2eNzah/SO1P1m33jM0lxbvfd/KA
 ejgw==
X-Gm-Message-State: AOJu0YyilIPTPA41GVzqa03p6iEyAj5xxf4NFSOYAOFfIRFc8cTiJMNk
 Ghhe0WVAtJz0+mz2+VB+iE2VSGAzziwZ4hNW9M0=
X-Google-Smtp-Source: AGHT+IGwvybzH4bHeIAPEwuDcLDRmaXR7W9syNLva/X1nQWdh5KbRr+KYXNHcJ0FU3Q+xtrWR+bTWA==
X-Received: by 2002:a81:5756:0:b0:5a7:a817:be43 with SMTP id
 l83-20020a815756000000b005a7a817be43mr14587177ywb.6.1698786104181; 
 Tue, 31 Oct 2023 14:01:44 -0700 (PDT)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a819108000000b005a8eadbadbesm1327863ywg.19.2023.10.31.14.01.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 14:01:43 -0700 (PDT)
Message-ID: <fda08267-28e6-45a9-bc98-a683e776078e@ventanamicro.com>
Date: Tue, 31 Oct 2023 18:01:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] hw/ppc/e500: QOM-attach CPUs to the machine container
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Luc Michel <luc.michel@amd.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20231030143957.82988-1-philmd@linaro.org>
 <20231030143957.82988-4-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231030143957.82988-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 10/30/23 11:39, Philippe Mathieu-Daudé wrote:
> Instead of having CPUs dangling in the /unattached/device
> bucket, attach them to the machine container.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/ppc/e500.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index e04114fb3c..f8177c0280 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -946,6 +946,7 @@ void ppce500_init(MachineState *machine)
>               exit(1);
>           }
>   
> +        object_property_add_child(OBJECT(machine), "cpu[*]", OBJECT(cs));
>           /*
>            * Secondary CPU starts in halted state for now. Needs to change
>            * when implementing non-kernel boot.

