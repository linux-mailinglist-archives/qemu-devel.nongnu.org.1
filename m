Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ADE7D9280
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 10:45:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwISS-0006dx-5H; Fri, 27 Oct 2023 04:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qwISP-0006dJ-RI
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 04:44:41 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qwISO-0001xO-Ap
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 04:44:41 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c5720a321aso24088741fa.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 01:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698396278; x=1699001078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UCP8wQt4xflYE0ySkQOSdPIMw+rC57CcZSbS11lxJ6w=;
 b=UjiQM7jS2KTv5O5wCizTWfNoqflW3SbovHZiG4vQmEca1O/nRIyQx0AEne26hsQJct
 yOnLnm51uI+9X8ULZi/+syftfB7RhIvssqXJHTjVS65ZAAQXZlhyBlVYnYGWSy2hrXyG
 0c4/mgwevEHtX4E09fLPVEfQrz4uK4TatHPSl5i0HKxqQK9LtPuJfv9cTiAL/WIFw1ce
 mV7y2h6OMgrg2UVSnqOlDMnsQcGVBJiYpRjkCHJNhvA8vrU51Tpu34JSusxPUd1rQ+1Q
 Tq287NRyFuHFxygjRXhnpo2u7GmTuICX1jFf6BwaKC4hNPw3l/vwSXIHzKv4F+mJj4+K
 Tdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698396278; x=1699001078;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UCP8wQt4xflYE0ySkQOSdPIMw+rC57CcZSbS11lxJ6w=;
 b=bjM62a+bATAqkvxXoz4zp8T/y7xdjC/gZ5/cY82VjdT4VUoj6svc8C11dKQJi5U4xE
 o2dqBELN00RoCtQ5+glrkjegb0/636YVum83saNWuaQcyQloO8JWZAuqTMMlyTUmxnJs
 wQaMO/8NcMoMa4uSAAXhzzXdGyCYDxaiubkOg34MhfdiU9wkdH0zH3/q0u1/aLugxZP+
 y4XmgvQaTahR5rG7jnpXDCKMCz9L0iR/3RpUPBzU8FF9JLxMcFOSIZhOrvPM1qEJaMXk
 BKH8MuakWYzMDauCx7HBaRU/He/1xWL5KgAXExRPY6KdvcuVslwOVxsEHBsRscqvSaCK
 ooGg==
X-Gm-Message-State: AOJu0YyfNsRnNodmWHOKEj8DOO/Z9VVp5S0RmfmokmNglerjkE+kJbnl
 T2A6/TbG1SM/9XSgNvjMXer51u+acxskLlsiGnE=
X-Google-Smtp-Source: AGHT+IEkM7PUd//Jbu/SyxUbfmxwPvauOseB2xrhW8LJcSR6oP4H68JXuEtThyBJhpY5gJTrOAQd3w==
X-Received: by 2002:a19:5503:0:b0:507:a12a:7753 with SMTP id
 n3-20020a195503000000b00507a12a7753mr1214814lfe.22.1698396277970; 
 Fri, 27 Oct 2023 01:44:37 -0700 (PDT)
Received: from [192.168.69.115] ([176.171.220.131])
 by smtp.gmail.com with ESMTPSA id
 hn33-20020a05600ca3a100b003fd2d3462fcsm265755wmb.1.2023.10.27.01.44.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 01:44:37 -0700 (PDT)
Message-ID: <76180120-130b-9a86-b86d-ba3bec43d9fc@linaro.org>
Date: Fri, 27 Oct 2023 10:44:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Add the can documenation file to the CAN
 section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Vikram Garhwal <fnu.vikram@xilinx.com>
Cc: qemu-trivial@nongnu.org
References: <20231027060931.242491-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231027060931.242491-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

On 27/10/23 08:09, Thomas Huth wrote:
> Add can.rst to the corresponding section in MAINTAINERS, so that
> the maintainers get CC:-ed on corresponding patches.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


