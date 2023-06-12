Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D5D72C2CB
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 13:32:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8fm9-00045T-LC; Mon, 12 Jun 2023 07:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8flr-00044x-GH
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:31:39 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8flp-0006Xv-TK
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:31:39 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4f660e57123so2764013e87.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 04:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686569496; x=1689161496;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9sd16XkW0nCSWlkbOnXyJm1deYYnwZLz8/mzXOvkmbU=;
 b=b9DG/MabyN3mFQLauCWpypnJ79LXE5JP5gwlaSTEnyCKY4XTcPf2a0SHM9ztw3TS7h
 tGuIrWI/FTeDxNi2cwqqHfzNYMSUVk9SPh8T8XPB8kKPqpWXaIFLURqIA8tQuCBInuF6
 N1ALNTS2BMDCVcg18fApalfQJNM/A+TGM/JyKheEY58l0vpXKb/nj0andohbKaziigVV
 G5ZoZ8nORn7OdkJ5I50UspYnnO2BsqzVErzReT7XreVYUc22EPC+OKG0x6JUDJf/MV+U
 VipuLepfWZt+JWJ5HHz6c2bO4rsjK7GaPk9SOLRRd+BjY7rEoORahwrnMhlyKBMjN099
 KGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686569496; x=1689161496;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9sd16XkW0nCSWlkbOnXyJm1deYYnwZLz8/mzXOvkmbU=;
 b=ONZLSAMpRfHo0rMej6s5AamExGOiHkRjlTHXgBipydRemIHDQl1hScBPy4YddSsVTQ
 qgqhchR/VvgWxUHl0CXJJok9mzvXzAhN9TEj9p/hS5RYyWKZvZ7JjVl3b7Mt11WOa7e3
 WuC6Q4F3i4fgtJcbRNpgmbNp2nIcefijvnnPZfAmS1u8/Xyl9k1q9mhf+5B1xJhm8svx
 wxP8cP+27wgqzRL3+A/VfRBaNSYoz3jlVoPk2oOVS0XLvfmnSHjs7O36G4SqvzShMwBZ
 HKx4X3nyZ4Gm/GIC0uXhk4idEd7c8ORjcmSPFyYf/yeMaCZITulLDTfCEuYjJzBeyuSK
 vWQA==
X-Gm-Message-State: AC+VfDzvEL3VKDUEqJfK8N5SrZ37GQREFqwE173d/6s9zJaCqF1OWiU9
 dIcSbg5WJWHnglo9vUo6q3wCdA==
X-Google-Smtp-Source: ACHHUZ7dF6X4f9VwtNAWciXFmrOnYw4gMghz+ge/qBXd3uYk7UKy1CjTC4RuYtYBwXM4A98xXl3Vbg==
X-Received: by 2002:a19:5619:0:b0:4f3:8196:80cb with SMTP id
 k25-20020a195619000000b004f3819680cbmr3708543lfb.41.1686569495730; 
 Mon, 12 Jun 2023 04:31:35 -0700 (PDT)
Received: from [192.168.112.175] (176.red-88-28-1.dynamicip.rima-tde.net.
 [88.28.1.176]) by smtp.gmail.com with ESMTPSA id
 o6-20020a05600c378600b003f42d8dd7d1sm11229763wmr.7.2023.06.12.04.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 04:31:35 -0700 (PDT)
Message-ID: <f89de39c-adda-706e-e976-74e675218c63@linaro.org>
Date: Mon, 12 Jun 2023 12:25:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 08/15] hw/pci-host/i440fx: Have common names for some
 local variables
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-9-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230611103412.12109-9-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 11/6/23 12:34, Bernhard Beschow wrote:
> `PCIHostState` is often referred to as `phb`, own device state usually as `s`.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/pci-host/i440fx.c | 26 ++++++++++++--------------
>   1 file changed, 12 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


