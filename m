Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A95BD72C2CC
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 13:32:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8fmB-000499-Dx; Mon, 12 Jun 2023 07:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8flu-00045X-8o
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:31:43 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8fls-0006YA-PC
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:31:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f81b449357so8980435e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 04:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686569499; x=1689161499;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mM2szU5AtQDAj5aArZYnojQGnsPAdfVbtSg9PPa9epU=;
 b=oO/jq0Xw1qdw2VCg8HlHo0fO2CbbFJTV7LJaWB92qdfNQEvYt5y3aBVXs+9rQqQ+ha
 IGNvfbD3dHncpDSVbp2uGHoPEUtuNKwcqfqRgz1Vf2pYypw5eI7APxQ0JCjU55PYskiG
 jxni8faOhsNl/iR6yo2OvN2emc8t8aGHIWrit/KsL4inijAzTMtfkLPQNXhOpGB+alge
 /jFcmzGRSx1s03zjJ+WL1CeXv2JMeJ8oIltCrfYogrGX5u4263lU6UAWTjzF+MQRubs/
 yaBf9Rf9u7ONtVG4HraxxGR1dlDy2r2tjJyjWVPtEdJ7L6irkkbCNZufVZYjW2zl0kCi
 t3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686569499; x=1689161499;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mM2szU5AtQDAj5aArZYnojQGnsPAdfVbtSg9PPa9epU=;
 b=d64nY6inziW+O0WIvZfFe7vEqF5LWqZ3qJaeeySYccBj1aJSJ5YfY0ZjeS7DWf2l3g
 +AgpwapSHqWOKRUaw8beMch0lZyH6jKJ0FPAErjQixym2T2Kgns/quhPOuRMqoBPqfi+
 qhxsZqb/QMU+RnJXy749Re2yn6/wcNFCV6Bf3y1f+f8amUuuzlYexjc/seWm5YeaTxbq
 QeBk5QwQgT+OGcNwggaU2eEt3EIm6ZGEqbHnJiyvStf2hxBmwnCq62u7bQ7CpNkhND2A
 zsTfEN+xIm5C+zVQPRmoq6cfpXXbycWfEnpxZ2Zok5vS0JZV5LHCZS50K9MS8Ivtspfd
 992g==
X-Gm-Message-State: AC+VfDwaPu3PYCX+Uum/31j1eLJbdkyZLvLTEHxuvCOXZA+0OgDR5MNZ
 HZ1uAQwlqHp6aBZpvyIYxtbZpw==
X-Google-Smtp-Source: ACHHUZ6Wzwmh3yADYecWFvPrTC+hYhvkfN0Dclq7XR3rd9Ke3beCSDVfBw5Nq3Rdrl9r97hgzGqZMA==
X-Received: by 2002:a1c:4c0b:0:b0:3f7:fcca:5e32 with SMTP id
 z11-20020a1c4c0b000000b003f7fcca5e32mr6832712wmf.17.1686569499240; 
 Mon, 12 Jun 2023 04:31:39 -0700 (PDT)
Received: from [192.168.112.175] (176.red-88-28-1.dynamicip.rima-tde.net.
 [88.28.1.176]) by smtp.gmail.com with ESMTPSA id
 o40-20020a05600c512800b003f4283f5c1bsm12636629wms.2.2023.06.12.04.31.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 04:31:38 -0700 (PDT)
Message-ID: <4724771c-4243-91da-462d-8817e2f8ea86@linaro.org>
Date: Mon, 12 Jun 2023 12:25:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 07/15] hw/pci-host/i440fx: Replace magic values by
 existing constants
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-8-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230611103412.12109-8-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/pci-host/i440fx.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

:)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


