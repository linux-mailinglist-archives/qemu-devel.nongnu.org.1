Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 335A07B77A7
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 08:12:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnv6B-00065g-Ou; Wed, 04 Oct 2023 02:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnv66-00065S-1h
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:11:02 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnv63-0007sE-Eu
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 02:11:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40675f06f1fso2688465e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 23:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696399856; x=1697004656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YPdgir9L1lBlStzCO7BFam0uxRngyoGrN8NP/EQpUQw=;
 b=OnL1RbhYUm4rLB3q3nx1kgx4l6SYmQz35L6DXKzuoX0IkSK07RnNCkEKy63SXUwJ9N
 Q44HxqOUg3lSBSFlK10NjTOcNpA9kdHAvyJlsZbfzvXIuPQM3F+G0qxzX7ZgjplYQsQA
 UrszgI2Adxy6YOCodrLtYhKuz0SBMkmLD72ELH+WmVn0bA9nOX+XnGwD6wZtXuE0utrZ
 DWojQ8LEBuhyQJ6WZf7Kuz2hp++In7aLCyROSp4rfM55p5uJwww6z3yh0dd3a4Td2ne2
 Eo67RXlSHVPL1GemUE5QCfmgtGyKYMbjGfXg16eN/uhwbXrsEPwPOPLBNWa+sG5QtjJo
 NFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696399856; x=1697004656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YPdgir9L1lBlStzCO7BFam0uxRngyoGrN8NP/EQpUQw=;
 b=oytve9k9F5nNiFbV2py4/hgaPMQz1bWoqLt+UoqOiF/scmvy/gPiXT16Gid0LITdBJ
 OYACihaeTzHit9rM//as3JRIpzHGoNMGXzi2X4IQPa5RX8xVQq6iY0Xh0QPi0f5TDp2q
 mMQjpUe34tpdaPmsaax/iqfuLYqP1hSI+gHCPYcB1+Vg/vW4vXCeqvfjyKvpBbx/8wpz
 BVTsbS40Xwd2xoqBIYmD9SJ3CjBYxi8tAW/kb1f3nSpiNiRLF9oQNNAMR8y5yiQ6sbDy
 lUHurUXYfcV4YxDkY/T5WYo4fiNinKMKnqx9P7s5CSIFbjGhuzEt9xPH4Z7ArVWywL5e
 rFqw==
X-Gm-Message-State: AOJu0YwoYcRoVhb2fr/k5YbYcUXHyP1aOe7nvrrJSN6CUsEIgBwMa/7L
 pODLk8G8jGKzWSHuMjxczkUB1Q==
X-Google-Smtp-Source: AGHT+IGLEuMfvhoKu8ky1f0JjxHZ1PyGyk9cFibA5RYjD2KYhFDVztHPdyaHT0EIrvmIHqu8EvzBSw==
X-Received: by 2002:a5d:424d:0:b0:319:8c99:989a with SMTP id
 s13-20020a5d424d000000b003198c99989amr901489wrr.8.1696399856528; 
 Tue, 03 Oct 2023 23:10:56 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 a10-20020adfeeca000000b0032008f99216sm3132246wrp.96.2023.10.03.23.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 23:10:56 -0700 (PDT)
Message-ID: <126a94cc-3b21-6324-3448-69c20feddfd4@linaro.org>
Date: Wed, 4 Oct 2023 08:10:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3] hw/i386/acpi-build: Remove build-time assertion on
 PIIX/ICH9 reset registers being identical
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20231003211658.14327-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003211658.14327-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 3/10/23 23:16, Bernhard Beschow wrote:
> Commit 6103451aeb74 ("hw/i386: Build-time assertion on pc/q35 reset register
> being identical.") introduced a build-time check where the addresses of the
> reset registers are expected to be equal. Back then the code to generate AML for
> the reset register in the FADT was common. However, since commit 937d1b58714b
> ("pc: acpi: isolate FADT specific data into AcpiFadtData structure") the AML
> gets generated for ICH9 only. There is no need any loger for the assertion, so

"longer"

> remove it.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/acpi-build.c | 5 -----
>   1 file changed, 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


