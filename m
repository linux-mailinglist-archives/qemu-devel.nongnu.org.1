Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 897CF74E0E5
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:14:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIz7i-0001hr-QZ; Mon, 10 Jul 2023 18:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIz7c-0001gi-Si
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:12:45 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIz7a-0006YW-7X
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:12:44 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3143b72c5ffso5886693f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689027159; x=1691619159;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fL3NNViOUJdtBq+5CvTXHGgoWO2exvz8UvEzOAguTXk=;
 b=aHu9xIX2TtNyR0vKdhRVyvlMalabBqJwx7iQrWsZQpIjWXA+qrkBtCYLiskiKIN32S
 45Hf6obvBxaJx8ilVe9liM0hC3rYB3/wfmmnH4da8E8bECZwM3MYMMoX7LOin4QVGT0t
 DSHdznVYgpL3fS+Ol9UiV6aqdncQxGXXRlJpgdzG6ofdQD84pNSENV9lgFnou5kkei4Q
 njzu9o6ieaHnhh2Dr0tmIgFvEoCjx7LxZfidi03NIcQWYvcFKBSVi3wAxStzsY6Lrc/B
 ONB4V2P9IgLwrVuXwD3xDkiVcr4e9/LgQHSXlDDESz8Y5KjwTbsJJaPRvE43O68sb98L
 4mNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689027159; x=1691619159;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fL3NNViOUJdtBq+5CvTXHGgoWO2exvz8UvEzOAguTXk=;
 b=hnIIu/lKX7DYoRBj9lkO9NmhUIf/GpEi203qJzdGL/GxfD22WnRllDqtgjyP/JLSom
 ipHY1FB7kUgN+R2TzC05I6ZTI13Pe2YeXGK2bQFUZ3RhCr/Q9GwSvHB+j0USRv3OGtlm
 ecClY5tIha3oDVxIXGq9WUuYWpZJomlbIQRgWNAsz7j78PNC2XMguh2bSoNkH5an2WsB
 ZGuZPQFtfU2fh3XN1YiCQ6F2eLbRtB7HXn2Wyso6q+E19ca6IPafIppcFcdffx6gJjee
 jCQK/6LHxylvlyOzRjdD0tUd/6VGLQDZoph0SRDkP8jywkbrTTYLrUZQpHUUGOuyuIlm
 hAqg==
X-Gm-Message-State: ABy/qLYxgPTtpvllPy3r8DpB0aAzPSc0qDDrhahnLXyHXVSr6F9RLkXf
 YXz6mpNCqP87E+GWia4nQQkrUw==
X-Google-Smtp-Source: APBJJlGCZ1bURQ7BzAiN6qRRBF6bPFOoddDG8rmQOAfhwvB3M6hZyCUtFZPnlLl6iuUqCG5tKbyyWg==
X-Received: by 2002:adf:f9c9:0:b0:314:2132:a277 with SMTP id
 w9-20020adff9c9000000b003142132a277mr15743453wrr.9.1689027159455; 
 Mon, 10 Jul 2023 15:12:39 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 ay9-20020a170906d28900b00992bea2e9d2sm270951ejb.62.2023.07.10.15.12.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 15:12:39 -0700 (PDT)
Message-ID: <c69143aa-0e01-882c-7f02-84e7d1ed3b33@linaro.org>
Date: Tue, 11 Jul 2023 00:12:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/7] VIA and general PCI IDE cleanup
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20230531211043.41724-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531211043.41724-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 31/5/23 23:10, Bernhard Beschow wrote:
> This series is split off from a more general PCI IDE refactoring aiming for a
> common implementation of the PCI IDE controller specification for all
> TYPE_PCI_IDE models [1].


> Bernhard Beschow (7):
>    hw/ide/pci: Expose legacy interrupts as named GPIOs
>    hw/ide/via: Wire up IDE legacy interrupts in host device
>    hw/isa/vt82c686: Remove via_isa_set_irq()
>    hw/ide: Extract IDEBus assignment into bmdma_init()
>    hw/ide: Extract bmdma_status_writeb()
>    hw/ide/pci: Replace some magic numbers by constants
>    hw/ide/piix: Move registration of VMStateDescription to DeviceClass

Queued to mips-next, thanks!


