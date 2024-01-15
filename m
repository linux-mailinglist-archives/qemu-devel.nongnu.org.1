Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9331582D805
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 12:04:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKlM-0004KA-9H; Mon, 15 Jan 2024 06:04:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPKlK-0004I4-EQ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:04:14 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPKlI-0003fX-SG
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:04:14 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5534dcfdd61so15228657a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 03:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705316651; x=1705921451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qgIE1C6hamnZpC9bCU2oJzs0gnd2pUHsfR4ZOKC43tQ=;
 b=mgwceBq2fjHvDsx89ezWsxxFerLY03GqAji3hG6hIWWL9bZVIyMI2aXbk3MFRrGjdE
 gt1y/0CLbXFLNb3eO+4iOP4La41JKDRABgRu3BGe3HkIZXWlG3AJUkvm6u+w02YCF5tE
 0hl4bYRFPa98K/CqGwPeRtoAembGb06HXgPQVtkJ+tZ7k3rsj9XmO3tR7gzAUOq/YxOq
 2qf9Vr2k+QKQEhV4uPAe+16XyKTEUrK870EkXoSVmjQrg8hYzqb4rro6sKIAt8bHpsLU
 Df66AK2mmTHnLfkKEH8/QAwpPZBU8OzbDm+uTi+8/4+wrVJEgfBRUmqzypUSuKn6FFzT
 Rzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705316651; x=1705921451;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qgIE1C6hamnZpC9bCU2oJzs0gnd2pUHsfR4ZOKC43tQ=;
 b=jxuP8Z0ZmbfZio3n+wDhLhPNcFVGMoDjZ9pK2v+qc+LWweXNtBFI6YjQYxP16n1IUi
 4CLn6pO9P0BSdgDJmTqt2c5Y5bmaxXZcNh6F84PybxlaumQYqxG9/odGSmYNkAbV9YxO
 HYBZldw7IJHk4VcwlLSktP2+ZuKP3qOUcwIp160CoK+Yak8jneRa9pGEKIL/NZFHv0kh
 c+rZCA94gvWv/MnbyW9tUf0bS8va6WIFy9cDHoEwWAJVXPNMHnvYDjOcsyyAgosw9OHL
 gG1v5PHq31Ud7yQqCRGFtvGvaUdUJMmVKpSNQX+D/PgQzNBOjvWFufA3GC0yjMO91rTb
 9LIA==
X-Gm-Message-State: AOJu0Yy4VdYt2/MsRpqbXkGcDfPvN2aWC1MbKL8A+FdAStc9sAtUy908
 Yj8eu14LCUzwOYCorO6YouIFqxkGiXADPQ==
X-Google-Smtp-Source: AGHT+IHu9n7uVwAkWknP+hKjC8N+g79so4S632RkTkbETtr2zwV+qAF35nhTYN9yWsPwYun0Eg/G3Q==
X-Received: by 2002:a05:6402:64c:b0:559:1ff3:d05e with SMTP id
 u12-20020a056402064c00b005591ff3d05emr2157070edx.10.1705316651422; 
 Mon, 15 Jan 2024 03:04:11 -0800 (PST)
Received: from [192.168.1.102] ([176.187.209.30])
 by smtp.gmail.com with ESMTPSA id
 r25-20020aa7d159000000b005585d2361d3sm5330191edo.48.2024.01.15.03.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 03:04:11 -0800 (PST)
Message-ID: <bdedb379-d672-4813-9585-1147e71d9b16@linaro.org>
Date: Mon, 15 Jan 2024 12:04:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/arm: Add AHCI/SATA controller to Allwinner R40 and
 Bananapi board
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20240113191651.1313226-1-linux@roeck-us.net>
 <20240113191651.1313226-3-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240113191651.1313226-3-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 13/1/24 20:16, Guenter Roeck wrote:
> Allwinner R40 supports an AHCI compliant SATA controller.
> Add support for it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   docs/system/arm/bananapi_m2u.rst |  1 +
>   hw/arm/Kconfig                   |  1 +
>   hw/arm/allwinner-r40.c           | 12 +++++++++++-
>   include/hw/arm/allwinner-r40.h   |  3 +++
>   4 files changed, 16 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


