Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3522D802AFF
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 05:47:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA0ry-0007dr-IQ; Sun, 03 Dec 2023 23:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0rv-0007co-Ql
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:47:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1rA0ru-0000uj-Dq
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 23:47:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701665261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52sPItKnBDkxN0F8Nos/EvjNIyHcWxROAsYirelQtMs=;
 b=Hz9KwkoRIr+ICAyZUcq9kuXvvogIsKS8gpuanFB9k6IST25YZLPJ1gDdOaQtI6DpsLad0G
 dOIJo2ULIWL7mbAOaMkR9u5jkhNtoqX8xrrD12+/9IXKwtgdBaEYOb5pMaayUhMBOOjzkx
 klEnqiF3O2kfq1zybijINMG+EyOkyJM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-fwnk5E4LMhWva5_zlX6cqw-1; Sun, 03 Dec 2023 23:47:40 -0500
X-MC-Unique: fwnk5E4LMhWva5_zlX6cqw-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1d092b42fb4so4985925ad.0
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 20:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701665259; x=1702270059;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=52sPItKnBDkxN0F8Nos/EvjNIyHcWxROAsYirelQtMs=;
 b=EDSHQi2DAJQYSTnAn61B5jCpmCJYVIlIOhzSskFgkY/2Oy6O5eYVgDbCHaLxkH2BRC
 9SqWssnVar1xQ6Smtv2a35qkvcA/aGUBh4afKrqR8EaOrn1LVv1xSq5QKcKVWWQi6iLU
 Yk+fDRF/2JiloQgl1dC02QExoJ2PtU64jbP7G937/lCKKGaUzxhqo0kOn0XSQNkVf7Dn
 tbLti9XFW5niuYl6rpHxy7RFK+XHov5xIc1N2qDpGJKitzPyegvAkrcSc9cks98P1dKy
 p58/IHBjKeAiY9jGZ7qwmZ5VmwjFBw5UUyYgpcmJOWpAMgXA6II/6zhqxpEbPr7od8xZ
 KnEg==
X-Gm-Message-State: AOJu0YwQv4+4jvKzOqn4Q7JRttis+/j5pml12SBBwppoMp4pOdCpUWDi
 XXJPuRifaTpWQIsKMYhi0UhK0jS+9BAlrBMw+AB4FQYZjpAObxbtihuk78H8RF88td/6fXCyyIx
 eI8gzNLrGjgWf+Ek=
X-Received: by 2002:a17:903:2309:b0:1d0:15d9:f4cd with SMTP id
 d9-20020a170903230900b001d015d9f4cdmr4408572plh.33.1701665259222; 
 Sun, 03 Dec 2023 20:47:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFamiSpeXfVUfuXncInn6MuR99b9f2AmFKoE2h9VxOWYp/2pvLFn0hfHsDfDZBab1pt3iIww==
X-Received: by 2002:a17:903:2309:b0:1d0:15d9:f4cd with SMTP id
 d9-20020a170903230900b001d015d9f4cdmr4408558plh.33.1701665258954; 
 Sun, 03 Dec 2023 20:47:38 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001d058ad8770sm5298193plw.306.2023.12.03.20.47.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 20:47:38 -0800 (PST)
Message-ID: <84aa83bc-5f90-4ca3-a594-56bf052cd3a5@redhat.com>
Date: Mon, 4 Dec 2023 14:47:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 06/25] memory: Have memory_region_init_ram()
 handler return a boolean
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
 <20231120213301.24349-7-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231120213301.24349-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

With Peter Xu's comments addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>


