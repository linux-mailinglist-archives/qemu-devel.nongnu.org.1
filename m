Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D4DA05E89
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Jan 2025 15:26:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVX0Q-0004DN-9j; Wed, 08 Jan 2025 09:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVX0H-0004B9-AM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:25:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVX0E-00029M-KD
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736346345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AXEibKuSVZlpViRtb1cZIFRQexR3IJ/dHIKw/SCt2RM=;
 b=A/C8QenmMRG+bAHLTaPMIIwrk/GScS9zvwn9ivIc8ya2d5cgmkRcF3ALMHCPb3zpr6WQO8
 B12YQwgYDFrI/Vi1VjdSGrUS8/dzm2/ZAXhu/6Kvg1NnP6IN7K6Wjc1aJqcQQVvs/plQlc
 XbTWEzqLSNHdGXO0gI84VWIuaszJGI4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-SU32wcreNf6zjRXXyGii_w-1; Wed, 08 Jan 2025 09:25:44 -0500
X-MC-Unique: SU32wcreNf6zjRXXyGii_w-1
X-Mimecast-MFC-AGG-ID: SU32wcreNf6zjRXXyGii_w
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4361fc2b2d6so54226325e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 06:25:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736346343; x=1736951143;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AXEibKuSVZlpViRtb1cZIFRQexR3IJ/dHIKw/SCt2RM=;
 b=H+KiyUA1eD87GUa2V2yCHj1nty7+zn+LW/svVyjczpWIbQ9gFlu85W29jglaHzZojL
 upLTK1Ph+BdCQxeCeoze6NRbps4Bo5PE7gPEjWwiRJ1FZStEYOzHFOlOBbWiOx7JjGhl
 74LeoD6vvLGMgR8AZxlgG9QNaVwWJj3wW4qSKEU3UAFA0tuSgFawByU7P00AJ51ES0Kz
 9dNljWizqxZ/GU3ZhFAE23WjSzLQG0ElBdUhVn8/j1/l40oboi51epZdnvc2VvCVb6Gw
 qz3uLQMTouLGIUlBR+akSruAnVee5dmsZ4YZnV2nHPmJzVXooUB0qBPaO8Go3ZGps55k
 20rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoNdt8LkzE0XEbDwz1izSSrQrHWykk7e0UK/SDYjG/VXJxqOmOnoHUMoYoh0v9qRAFpcrkWBEk2phK@nongnu.org
X-Gm-Message-State: AOJu0YyCCcgLY8m+rcWl97lMILake/84e8Bkg/opFpxWG3XWpKksaDLc
 ZWe81PSMuHHpWN4YSr0BQJifOM42kPqVcRt1+FR+Mj8cRovaG5ykG+VlTB2baZ+An4SKwZQ9B9q
 G1m75WVPODQX0+FUMFpRhy2ft9GcCLFvnDC4feZTqqZwK7uzxFj55
X-Gm-Gg: ASbGnctP+hkkb3LXnQ9CvwumUlZ4lWShQSwSLM67AwCkOf+PMERuu5UE68xWS5kAtdR
 K1h3ACExbKUk4LrZU/66Jl/zSmjfveHNhVnLdj/icappbxF84de5ru+y8vVzKYzwRFJMeH+J80q
 2rKuZ4vwT5FSj0ifpBhx87sm9OFIDxtXkfzQBxNyKgCSZFOKs5onkf5SRxiVQN6lb8sphqdXUKs
 AIT9o752zm/hj7RlPrOzfqnWsP/e/uKwE0HSW63CX83BiSk/m2mSOTcLm7lS7z9QZ+fxAKsMr70
 hHko4w==
X-Received: by 2002:a05:600c:3c97:b0:436:840b:261c with SMTP id
 5b1f17b1804b1-436e26ab54fmr24511435e9.19.1736346343414; 
 Wed, 08 Jan 2025 06:25:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW/VZmQGCFHL26iHoltEGoa1/hXsmymAFeZ9FozAthutIar/25REbOi0GZdgiL53jYuYNmYA==
X-Received: by 2002:a05:600c:3c97:b0:436:840b:261c with SMTP id
 5b1f17b1804b1-436e26ab54fmr24510775e9.19.1736346342911; 
 Wed, 08 Jan 2025 06:25:42 -0800 (PST)
Received: from [10.33.192.228] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da74dasm22530075e9.2.2025.01.08.06.25.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 06:25:42 -0800 (PST)
Message-ID: <d1dfef85-c830-416e-9ff6-a69c124aa32e@redhat.com>
Date: Wed, 8 Jan 2025 15:25:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 29/32] tests/vm: allow interactive login as root
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Aurelien Jarno <aurelien@aurel32.net>, 
 qemu-riscv@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Laurent Vivier
 <laurent@vivier.eu>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Maydell
 <peter.maydell@linaro.org>, Li-Wen Hsu <lwhsu@freebsd.org>
References: <20250108121054.1126164-1-alex.bennee@linaro.org>
 <20250108121054.1126164-30-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250108121054.1126164-30-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 08/01/2025 13.10, Alex Bennée wrote:
> This is useful when debugging and you want to add packages to an
> image.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/vm/Makefile.include | 3 ++-
>   tests/vm/basevm.py        | 9 +++++++--
>   2 files changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


