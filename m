Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 278F77D24B2
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 19:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qubni-0000Sd-LI; Sun, 22 Oct 2023 12:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qubng-0000Rt-Ur
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 12:59:40 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qubnS-00041g-EX
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 12:59:40 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5b7f3f470a9so1271507a12.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 09:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697993964; x=1698598764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y0TZ9r4vX3TBtdIs85xpd1WKZ7bhucTLaIKeZu9lKw8=;
 b=ovo9yrB69z/fRH4PbStX46AQHYaNt/Ijg5K2hFYqjLZ2CPVZs3NNJImAdmrO/oCWQY
 74ye2c+NXW/oCdEEElnhzn3PclJTVYvbTPnB7BqOf6ns1bKxiyk6y6MG4lZ0Rsj3SZS8
 VS47jAvwJ0osDo5mZJJv9wmiuenCH4CKsHPCGBk06+MPdOmlQiEItvbsYRfMTN1uGmeC
 ygtaofm1jTrzkHm3HOlWchKlVqyZCQftM0Opoi/X3fJK4s8f+W19S+/rrcku5eyTsLLO
 msNmxaEZZ4ENamUPb/4fZCveT962X2zxPDWFVpLUDbS94rTsFeShl1nAUCd77nMLcoXZ
 5a3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697993964; x=1698598764;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y0TZ9r4vX3TBtdIs85xpd1WKZ7bhucTLaIKeZu9lKw8=;
 b=wwPu1y4TTz75UjFzEGZ6Tjp4E6Zvg3ViqqLaOncfR4AF9/dqSWg5+JRT3Az+Be/rkH
 exSnMMjvWfPESD9qU+vnvL1EuvOGvGms0ix7twI8o/Iim33kFCS89gJA9hwx5SPRNJtC
 KCCRssM7JIK7CezPquCx+/zaZo2ljS3GJIguvjyHCxy+gNbTl5maJT1UPe7oTbLgETzL
 EYSy03qbg6txrqW7ZwvxnMyKTUTgADqU5iAO7sV5XKFf0H68sgtuAxh6fEHuAZsvpe1w
 S1jxWS1CoJOVq1er24hweAOyDZy8VGCgpypyXML2ERv8arNYkxb8B/CNETyJJpa3FQJ7
 Y4hQ==
X-Gm-Message-State: AOJu0YyQ26SVggMFgka2/xkwLhIiyzjVH22e7nZG8GHQFq1qFaEzjVNA
 xDzAU+qsblaNoe/dPW5Mrhp0Cg==
X-Google-Smtp-Source: AGHT+IEMJKAGl+ft7DJYhWFDXaxhlScwpAx1Y209cNjergLOYvHT8iISVRwLUbwne/B3/uD9wIZrQw==
X-Received: by 2002:a17:90a:a091:b0:274:9409:bbca with SMTP id
 r17-20020a17090aa09100b002749409bbcamr4540724pjp.3.1697993964598; 
 Sun, 22 Oct 2023 09:59:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 12-20020a17090a034c00b0027909a8994fsm6869881pjf.13.2023.10.22.09.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 09:59:24 -0700 (PDT)
Message-ID: <c5b10f79-cb74-40e5-afc6-f70367c1223e@linaro.org>
Date: Sun, 22 Oct 2023 09:59:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] hw/i386/pc: Pass Error** argument to
 pc_basic_device_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20231020171509.87839-1-philmd@linaro.org>
 <20231020171509.87839-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231020171509.87839-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/20/23 10:15, Philippe Mathieu-Daudé wrote:
> pc_basic_device_init() creates devices which can fail,
> allow to propagate error to caller.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/i386/pc.h | 5 +++--
>   hw/i386/pc.c         | 7 +++++--
>   hw/i386/pc_piix.c    | 2 +-
>   hw/i386/pc_q35.c     | 2 +-
>   4 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

