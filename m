Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B88E27C566F
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:11:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZv9-0002nK-Ig; Wed, 11 Oct 2023 10:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZun-0002ia-HO
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:10:21 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZuf-00083C-Pd
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:10:20 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40666aa674fso64677825e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697033410; x=1697638210; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/1+Mqew4YbCbo1Bdjzo2MrhR6N9crU/vFN8awxPHXzc=;
 b=bPVdg2rUkiGIAm+Evu20cSKKCiaQWbszjZ3wH8j9DJaEjKewqo2lfxMW6B/EXNg15+
 cB4ni436OsQjFdV+FHrxdfK6nivCkOfKTKmrvSWK9XGw9DJU5fjqqDZns2wJ90Ik1WRu
 OlEsSKNxIqbkAxiegffba/q9MF/yi7LxLjYYLdF4CqSW94qaKmiPPuiMVyfxIL0UMDq5
 /2twE4ZXYIrXlPTCy0ADyZUMp0kqddbScgj/jgWL/mR5ww2ybgUhvrKqPFXBvym5rCHI
 OKWC1n1XoQzalg30khWuQivm9JJiIgsigLajipICN1Iowjp9HmXU2lShxTkG+eg9kp5i
 LQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697033410; x=1697638210;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/1+Mqew4YbCbo1Bdjzo2MrhR6N9crU/vFN8awxPHXzc=;
 b=LyreF6r+75iibA8HpqIoNWgcrmQIrjB1YIHfnzw2dATWsSzPfqOqR9o+NtugtO4elG
 WykI2ZCTguUOs7BZCUYAw7KOXpck8qxSI3c1BJG4saUpFUZe/XhzH8XMEKpCuhekycvQ
 7ONwDFq1PP5B0Lza97n99xndwOlSUpN4d1Y4mzMAfcdeL3/EUIIi37yOsPK/hcM9g1Z4
 7Xu/Ks6J4ZpML8HlBgK0rBjpoQ73MfHLbMY+MjrPjTe+ktT8U65U+kY3qWBgCy4gOyik
 B2Tz02vS/lIb8d8ginBwz7hsqj+2kavjDWHRjoVqgltU9hf8ZC0VOTvKaQKK1I+z5grE
 tjzg==
X-Gm-Message-State: AOJu0YxLvff8c0Qp0+JIM85PiHpILSzRHZAMv1qEN74G0U5cEBcJRX+I
 RBZUU+oFweS9z7KAoVM+gfcDdQ==
X-Google-Smtp-Source: AGHT+IHe0yHVBunmgB/RJ68Wb+8Lbiny+88s2l57u8QKt1MKra5ikK8RmddYbZzM7QfpGHsorSWNQw==
X-Received: by 2002:a7b:cb89:0:b0:406:54e4:359c with SMTP id
 m9-20020a7bcb89000000b0040654e4359cmr18548799wmi.19.1697033409998; 
 Wed, 11 Oct 2023 07:10:09 -0700 (PDT)
Received: from [192.168.69.115] (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 m19-20020a7bcb93000000b003fe61c33df5sm19285023wmi.3.2023.10.11.07.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 07:10:09 -0700 (PDT)
Message-ID: <a3020663-29b7-7de8-8efb-d3adb032de50@linaro.org>
Date: Wed, 11 Oct 2023 16:10:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/5] hw/ppc/ppc4xx_pci: Declare PPC4XX_PCI in Kconfig
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20231011132427.65001-1-philmd@linaro.org>
 <20231011132427.65001-4-philmd@linaro.org>
 <763c0675-5f72-5b53-0770-dba5f52692d8@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <763c0675-5f72-5b53-0770-dba5f52692d8@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 11/10/23 15:42, BALATON Zoltan wrote:
> On Wed, 11 Oct 2023, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Should this be squashed with next patch? It looks strange to have config 
> defined in hw/pci-host/Kconfig but used in hw/ppc/meson.build.

OK.

> Regards,
> BALATON Zoltan


