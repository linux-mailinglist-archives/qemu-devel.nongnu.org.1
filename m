Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA089802B10
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 05:52:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA0vo-0002W4-JM; Sun, 03 Dec 2023 23:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0vl-0002Ve-He
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:51:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0vk-0004Zh-3S
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701665499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVRlTxu0mD9DwLJS+D0xXMDxmFO96NNB6cw7qc2YbiM=;
 b=UZWTmXNZQtiXzs2c69LYt6JaDSJgPiIqxqfLyvZg/6+qW350cN51765iuAf/rFsOxPXNvi
 7ovTt1YzJIgxPzuAL7sz7vXXLk9fphTYpNkI3B2o6BvzNvR43VbbhYP0Df9QQADh/1VW44
 8XWQXkJMz0UOy4OBg24GYFNa6/KGayM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-T3b8EP2DPTyF4mxFIiJBsA-1; Sun, 03 Dec 2023 23:51:36 -0500
X-MC-Unique: T3b8EP2DPTyF4mxFIiJBsA-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1d08acaab7fso2278785ad.1
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 20:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701665495; x=1702270295;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fVRlTxu0mD9DwLJS+D0xXMDxmFO96NNB6cw7qc2YbiM=;
 b=s/j3msJk0Iwa/LpEVh9x4WXJeRgbT27T4K1VTllpNQTIFVAUUCNQIzizfkqDsF0d2O
 4ZQ99Y+u3Om6G4CUeSntu2UA3vWnWxSkPauIEdEewWkUkn4U9kSr6q0dgh+7v6QuVnRI
 YaKRqcUkfIaqQzG0plLtvi5l13yAhKkG14EF6srn+V9B3tU7jnXB0yKu3QnXUx98OmOq
 ZhSa+z9aL8Tp8Pv85kP+HQNK/628TxdGK4i4i94KW7XLRQjOIU6smviA+v6dJt+4v6u4
 Yh/a33vBHA/wCXuRn0YJfsZYDwmIKJAt8fDYdooC7EdxJvqHlPDIfQ3PqcZERT1ycHiN
 X3ag==
X-Gm-Message-State: AOJu0YyjRbiL2KMJQV98Uiv4LdLeBYkjgoMlvyeWFUT0tXEiE2NTvnHj
 2dbn7TAW6HgL6viRVm9dUXulZA4c3kfVVm1m5yNDvPuj5Knp0tUEUGwPJXi31+SwOTrViG7L03W
 wtoFazKht6tnoCJE=
X-Received: by 2002:a17:902:a98b:b0:1d0:6ffd:6e8d with SMTP id
 bh11-20020a170902a98b00b001d06ffd6e8dmr1081181plb.133.1701665495109; 
 Sun, 03 Dec 2023 20:51:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyPEw4494u9+8s5+rkLHjpl/X3Ork3LVbFtFW1UkZ7Rnqf1IVDY8e/KCdKRzAQUcJSnSiLIg==
X-Received: by 2002:a17:902:a98b:b0:1d0:6ffd:6e8d with SMTP id
 bh11-20020a170902a98b00b001d06ffd6e8dmr1081170plb.133.1701665494835; 
 Sun, 03 Dec 2023 20:51:34 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.20.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 20:51:34 -0800 (PST)
Message-ID: <472a4199-7d52-405f-a412-cbd8c2551214@redhat.com>
Date: Mon, 4 Dec 2023 14:51:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 10/25] memory: Have
 memory_region_init_rom_device() handler return a boolean
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-11-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/21/23 07:32, Philippe Mathieu-Daudé wrote:
> Following the example documented since commit e3fe3988d7 ("error:
> Document Error API usage rules"), have cpu_exec_realizefn()
> return a boolean indicating whether an error is set or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/memory.h | 4 +++-
>   system/memory.c       | 6 ++++--
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 

With Peter Xu's comments addressed, to s/cpu_exec_realizefn()/memory_region_init_rom_device()
in the commit messages.

Reviewed-by: Gavin Shan <gshan@redhat.com>


