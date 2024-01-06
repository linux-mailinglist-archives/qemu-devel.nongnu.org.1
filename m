Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AD3826023
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 16:27:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rM8ZA-0006Z2-D0; Sat, 06 Jan 2024 10:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rM8Z8-0006Ym-4N
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 10:26:26 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rM8Z6-0001UY-8Y
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 10:26:25 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-552d39ac3ccso2592702a12.0
 for <qemu-devel@nongnu.org>; Sat, 06 Jan 2024 07:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704554781; x=1705159581; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hMgpMeixTkShqQJe2jHzQGZaz6xmcr//fqb5WDPCh74=;
 b=dS8YlSXHr4475EtWyec7oREOI00MLS/jStQYduaCPP0D3i303cVLcO7hVyc9UP11So
 fN/aSl80M5whaZDX9lBvlV21gEbtBtjzKvPTcF2x2HeHXszT+k8gkdRRufefJNR74f/y
 aWC1YxdY3BXd8V3Oarv66aWntKl++JjcUfp/PgES1ovm+K5BLshdSAmNJOXqM4/Aj/qx
 SwvOq3NEUUptbSWfvd9Ypxib8oTrD7H5xbyxxtu5zxESFmrEFhUpvQBBeOgLoGJvW8g1
 /gGUH37NaXWTXpNBV177bdNY1u7zHPzlO+zPVOmg6BMTG6NunrEiJBIR8sGqacVstQtW
 0ApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704554781; x=1705159581;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hMgpMeixTkShqQJe2jHzQGZaz6xmcr//fqb5WDPCh74=;
 b=AntHAFEsWOh7bTPZucYjvmeYZtA88x89sNootwdZLrWDmNmYawcrgRym28f5/KEgbJ
 /o0MB5M+FbA1k2t6itSHMMfYAfCKtF87gN9CvepKGyMbNWDh4KM4zA/KG/u2mgK6HAZx
 xWAwHyOIKgLQ9Ngj9kI7ilP7F4JEm/CaRtPBjhWrsRpeRCCauu4DhVm/6siqJ/k74jki
 o63C4Q8Vk+WGsmDIZftFYcvBBPYOfBt7LSS3k1j6RiKU//siXmGUrxVC/nEPjtLdDLN7
 nJFjKRGAMcGNtnBQiSlT6y9AFguO6Na33wVoK28yHfEZE8qEqdUXnMrEoInjEL38ExkV
 +Wqg==
X-Gm-Message-State: AOJu0YwDa283lQU3USWEqt3txaILDdYjYg/qI2TawpSF6pwm+MAyhb7x
 XQH9TB3Y5xJw6gOKbGC1WjLEtjnpyabFsg==
X-Google-Smtp-Source: AGHT+IHx6DoozYNDiJtZqonCVBi74JNH3a8qI4JcZw33eT8eT9DErL/RqXvaYYxTqGebrwt7Gr+Rag==
X-Received: by 2002:a17:906:354b:b0:a28:c8bd:2592 with SMTP id
 s11-20020a170906354b00b00a28c8bd2592mr1000294eja.54.1704554781634; 
 Sat, 06 Jan 2024 07:26:21 -0800 (PST)
Received: from [192.168.69.100] (mab78-h01-176-184-55-22.dsl.sta.abo.bbox.fr.
 [176.184.55.22]) by smtp.gmail.com with ESMTPSA id
 z25-20020a1709060ad900b00a26af6e4604sm2053972ejf.107.2024.01.06.07.26.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jan 2024 07:26:21 -0800 (PST)
Message-ID: <7175ff85-408b-4faa-b7e9-362a16767e34@linaro.org>
Date: Sat, 6 Jan 2024 16:26:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest/virtio-ccw: Fix device presence checking
Content-Language: en-US
To: Samuel Tardieu <sam@rfc1149.net>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20240106130121.1244993-1-sam@rfc1149.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240106130121.1244993-1-sam@rfc1149.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 6/1/24 14:01, Samuel Tardieu wrote:
> An apparent copy-paste error tests for the presence of the
> virtio-rng-ccw device in order to perform tests on the virtio-scsi-ccw
> device.
> 

Fixes: 65331bf5d1 ("tests/qtest: Check for virtio-ccw devices before 
using them")

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> ---
>   tests/qtest/virtio-ccw-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/virtio-ccw-test.c b/tests/qtest/virtio-ccw-test.c
> index f4f5858b84..7a5357c212 100644
> --- a/tests/qtest/virtio-ccw-test.c
> +++ b/tests/qtest/virtio-ccw-test.c
> @@ -85,7 +85,7 @@ int main(int argc, char **argv)
>       if (qtest_has_device("virtio-rng-ccw")) {
>           qtest_add_func("/virtio/rng/nop", virtio_rng_nop);
>       }
> -    if (qtest_has_device("virtio-rng-ccw")) {
> +    if (qtest_has_device("virtio-scsi-ccw")) {
>           qtest_add_func("/virtio/scsi/nop", virtio_scsi_nop);
>           qtest_add_func("/virtio/scsi/hotplug", virtio_scsi_hotplug);
>       }


