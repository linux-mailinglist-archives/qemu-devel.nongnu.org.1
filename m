Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACEC715F0B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:22:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yMU-0002FG-67; Tue, 30 May 2023 08:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yML-0002Ee-Pm
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:21:53 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yMK-0007fw-Cu
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:21:53 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f6094cb2d2so45854015e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685449311; x=1688041311;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/iwjt5UzZyS/5OOqSTr1TjEPUXgE61Zu31mA7m8RfYY=;
 b=iUdlziyCl4CBxT3sO6ElqxsIzo4/ZCpzB4LtA3fIZQrsvfFVfrjzC2nvHCqzWV5089
 yuC8pnDenxEoHHDSekmN7RhvnVqR/+pxTo1aSBiDLul7hVdpGtfK8UN0aeqs2AaFcXjU
 aVFaBeFEU0BVXLo5fwnzoEbOnW1RVSK0gQp3Nt253R8ffr1Tg5T6WjzltAnMAMifRImP
 tFAI9j9o7qdrkPQluRppf0e3H7eIj2FJT4igIkMLSlUdHtPNlCsEtkCh6XSgZn1xJ/W0
 /U2+4AuAVaodLGyFWgtcbjRYtJXOfNSsrFBJ0zec+Oeq5ZEGw0aMr+N4oHtc2/FksvuI
 T+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685449311; x=1688041311;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/iwjt5UzZyS/5OOqSTr1TjEPUXgE61Zu31mA7m8RfYY=;
 b=A0yhC/2LhMctcPL13IZ2UE1rVrQm6z4+Tyt/f1Iuy0U8kLrCItOZ3pmf1y6fMtZSD5
 Gj591obuJk8KWNcFJuahU4F6ghPjtbhp/1+9kalLwKgyl0A+LRR6Q5cRHwgSY2vFmTpa
 D7lEqHUyGIWrPQT2ciklc8NF/HY4oPtgsD6cE8qr5rYXd6hvoiODgAuiD4UPjGde0qVQ
 9sSXYnHkNJFZQ5sRYko+2vSrAZcxp2/n6MnPX1N9awPh29xtT68irGjv+D4CSvmpFqTk
 I2ddVMhLNWrUe0npis1/nQooplC8zci/45zWJriA5GZdv2wpGtfjk99sb7eTESvzKeHh
 angA==
X-Gm-Message-State: AC+VfDwDhECmkwgendm56H4ylNiFtabglEmVJRGHC47YRiCTip9jV6Vh
 9bi+N+vA8GvnBJBFN6VfTy0YKg==
X-Google-Smtp-Source: ACHHUZ4Y0Hj5zlxHoB+cFCgSwgig8Ljx+K6AR4vY82L5r4cv2md+ktf0hcIFi0FDfHd6PRmDuS5V5g==
X-Received: by 2002:a1c:7516:0:b0:3f7:5d:4a0b with SMTP id
 o22-20020a1c7516000000b003f7005d4a0bmr1612494wmc.1.1685449310939; 
 Tue, 30 May 2023 05:21:50 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 k14-20020a5d6e8e000000b003068f5cca8csm3081140wrz.94.2023.05.30.05.21.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:21:50 -0700 (PDT)
Message-ID: <78c33a17-c3a7-134c-c2f2-0f4a46e38768@linaro.org>
Date: Tue, 30 May 2023 14:21:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 07/10] hw/i386/acpi-build: Rely on machine->device_memory
 when building SRAT
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230530113838.257755-1-david@redhat.com>
 <20230530113838.257755-8-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530113838.257755-8-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 30/5/23 13:38, David Hildenbrand wrote:
> We're already looking at machine->device_memory when calling
> build_srat_memory(), so let's simply avoid going via
> PC_MACHINE_DEVMEM_REGION_SIZE to get the size and rely on
> machine->device_memory directly.
> 
> Once machine->device_memory is set, we know that the size > 0. The code now
> looks much more similar the hw/arm/virt-acpi-build.c variant.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/i386/acpi-build.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


