Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B325378AFBD
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 14:11:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qab4w-0004Lx-Rb; Mon, 28 Aug 2023 08:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qab4q-0004K7-Vl
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:10:41 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qab4n-0003uu-1z
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 08:10:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fef56f7222so30123255e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 05:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693224635; x=1693829435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZIqWbnYvYQGJhxHrs2hkMymk5ZhG+tpHyV3Ya/bbLZs=;
 b=pqoANqR4pntSBGRdu0n3juSxkUozChe+14FcWxoOKLJS2edLj7cEY6743vnLdctTsP
 wJp+RaUFLWLGmyALZIMKghyB6WfppRXsjmlA0R5z9Q7NfaG2aeiTcdw57nDzK+lQxkRD
 oCjPi9uLXEsyd7RZP4V2jkFm7p/Az5Vpb/FBHNyYt8qYvMERTKqODiSwqerTM0YMCeHN
 C5UZ/+lO/E6v+6dpz8ZnMZxmEL3BQ3ONjDDwAGwbyEopkxThmZ7x+ctJ+s065zumBF6+
 +c9mFu0b5NvL0xkyzU4MiT6vgN/gg01tX6h2GdTb9JMChCLPpzDqD+3VYMHkPh7lORCh
 06lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693224635; x=1693829435;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIqWbnYvYQGJhxHrs2hkMymk5ZhG+tpHyV3Ya/bbLZs=;
 b=BjmBXAMNamQRwH6JasCCtIy85lscXSnzN165OFzVuuN134a8VUA+cQYiSNUjI2D6KS
 yP1c/w500B0cRSYNmjhmd/fRADF8JAd/2yU4ljckHZzoxa29cLBNMLtAPbk7BUPBJRJI
 AUcjXMQqyRTmUxfIH5AAsP+A/lRFgbXYW2/DV7LLP/BBF3KoenFlZIX19pCXA5UekFwc
 VhllQisv2qTpxckrV5got7S3sVUz2PTTUnVflKoN3eSDhEh9dqkWYBisBwtGqzLJLmoQ
 Qatw+HGi6FG01w6Bb/ib3Eb7Z1vSzyf1x1mdbAVRoqM6YT8DiVwjjydu1NV63b35na/r
 gHlA==
X-Gm-Message-State: AOJu0YwfZl/tJTuF1045QcBx54Wc7TRLctvccEuI8wbcYgPbPVwacequ
 kYDSpdSch4ZWJY8BY2pRuJ6SZA==
X-Google-Smtp-Source: AGHT+IE78WPHCqPEUWBMfT9joAPsIISQSOEoP4/WXHCoFf0tGjjY4znWSr4p5aw9wTT8ZcqI/ZXF2Q==
X-Received: by 2002:a05:600c:b42:b0:3fe:db1b:8c39 with SMTP id
 k2-20020a05600c0b4200b003fedb1b8c39mr19492898wmr.41.1693224635425; 
 Mon, 28 Aug 2023 05:10:35 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.201.64])
 by smtp.gmail.com with ESMTPSA id
 hn23-20020a05600ca39700b003fee8793911sm10567335wmb.44.2023.08.28.05.10.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 05:10:35 -0700 (PDT)
Message-ID: <25ee9d8b-7c84-adcd-d026-43fa049d8083@linaro.org>
Date: Mon, 28 Aug 2023 14:10:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 6/8] hw/i386/acpi-build: Determine SMI command port just
 once
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
References: <20230828073609.5710-1-shentey@gmail.com>
 <20230828073609.5710-7-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230828073609.5710-7-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 28/8/23 09:36, Bernhard Beschow wrote:
> The SMI command port is currently hardcoded by means of the ACPI_PORT_SMI_CMD
> macro. This hardcoding is Intel specific and doesn't match VIA, for example.
> There is already the AcpiFadtData::smi_cmd attribute which is used when building
> the FADT. Let's also use it when building the DSDT which confines SMI command
> port determination to just one place. This allows it to become a property later,
> thus resolving the Intel assumption.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/acpi-build.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


