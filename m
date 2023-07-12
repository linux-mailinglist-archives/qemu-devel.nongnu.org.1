Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B43D750D8E
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 18:07:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJcLu-0002r6-WA; Wed, 12 Jul 2023 12:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qJcLl-0002qc-Hy
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 12:05:59 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qJcLj-0005oj-QY
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 12:05:57 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-314417861b9so7244362f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 09:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689177952; x=1691769952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/nbbZ3nYGDLw/eAVGG+lUHhGNDf+4CTj9CZKGsxIzzw=;
 b=r+dcPlbSCZDME3Q12m3yAndfe71jGRvpFkOvwSs6ySwQw4Q+rYXHj0xgVBwmxC4jJm
 2a3QXKB8bgnWflIS1u5fPY+en14NRNWPfXuwIeiXa5rRrPZyAngDFLWMaegtpYFCnIuf
 sLWZxDYO/1cqHg0WDd+A9oRk8NHoVb3O2NUEzy/xWZwlGNiJXKKLeOYBdvKhYbec6EeF
 1laIedct2ONX3+EHbYk+7bgCy7aO3+4SrUSUwSubxZjfikZyGfOZatz0Ps3RvZ8e6AiV
 wnHbCK/HYOi0CPhB6WezSP23+VkHwLFjRdQ0r28i9fcRyDaDaswNr8pCmki8BNH/p59X
 xq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689177952; x=1691769952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/nbbZ3nYGDLw/eAVGG+lUHhGNDf+4CTj9CZKGsxIzzw=;
 b=ALgm0tTFM3Qexm62GZeHvUit5P3WRtVSNVqtOmExk7KezcOAccKPvfoBET6DSmmug8
 9CiH3mrEpEBRzBhEPKb04ZJBhC1PvgPkZ6e5LCFJV+MC9TGlyCddgQHJCBWn9xhvzaLB
 zTYkqOcKxCfy+kLM9vvdfVN5t9Usx299+qJWpMJLk1DO6tfzZPkgGN4vfc91/H0jAgAX
 jo6BK1szw70EUlGyeQdyj7gSI2votOmbIP1JIcghcCydcPu3MSnnvYk4uJ6tKHo57afy
 Vf5mEKEXWBLa01WYAAxbSpb9gn2GX1/00zqOWD81lYLBKNHJwNMznsga/JOmn5O+gDaW
 eWWw==
X-Gm-Message-State: ABy/qLaGmQsNz7KkvFidxFewtZyioZRB9h8XjgWOQHpOnU2sSUMfsE1I
 thOuP+sgOxCjQAXk/cowf26zow==
X-Google-Smtp-Source: APBJJlFFvpfdRf5WmB+1p2VXA0YroVOpQ8y9tonFNKPm8VFw2g5RxH6LDpI06s+MLsb0mogRPiitjg==
X-Received: by 2002:a5d:6b46:0:b0:313:ee69:fb21 with SMTP id
 x6-20020a5d6b46000000b00313ee69fb21mr19705437wrw.62.1689177951672; 
 Wed, 12 Jul 2023 09:05:51 -0700 (PDT)
Received: from [192.168.11.252] ([185.65.165.31])
 by smtp.gmail.com with ESMTPSA id
 c3-20020adffb03000000b0031432f1528csm5406328wrr.45.2023.07.12.09.05.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 09:05:51 -0700 (PDT)
Message-ID: <78b236b1-175a-8177-49c3-e4cf11a2b266@linaro.org>
Date: Wed, 12 Jul 2023 17:05:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [GIT PULL 00/21] Host Memory Backends and Memory devices queue
 2023-07-12
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230712081750.80852-1-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230712081750.80852-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
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

On 7/12/23 09:17, David Hildenbrand wrote:
> The following changes since commit 887cba855bb6ff4775256f7968409281350b568c:
> 
>    configure: Fix cross-building for RISCV host (v5) (2023-07-11 17:56:09 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/davidhildenbrand/qemu.git  tags/mem-2023-07-12
> 
> for you to fetch changes up to 339a8bbdfed910d0baa392c2071fd0e09b30aed9:
> 
>    virtio-mem-pci: Device unplug support (2023-07-12 09:27:32 +0200)
> 
> ----------------------------------------------------------------
> Hi,
> 
> "Host Memory Backends" and "Memory devices" queue ("mem"):
> - Memory device cleanups (especially around machine initialization)
> - "x-ignore-shared" migration support for virtio-mem
> - Add an abstract virtio-md-pci device as a common parent for
>    virtio-mem-pci and virtio-pmem-pci (virtio based memory devices)
> - Device unplug support for virtio-mem-pci

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


