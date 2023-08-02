Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5338776D946
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 23:13:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRJ93-0008Or-3b; Wed, 02 Aug 2023 17:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qRJ8v-0008OT-Qc
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:12:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qRJ8t-00017P-DD
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 17:12:29 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fe2bc2702cso3250495e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 14:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691010745; x=1691615545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+IEn78ekGxFk1VW1GXfwQ8nYIpU1d5CTL8bBZiz8rxs=;
 b=QvC5D9+05UM6oF6FOKZ1sJ7jDR1eM0hdqYZq/1hUPMDNplwRBwRZRyrj0VlN+SY2UP
 VKPVBVSFbVWxDc5vXApvtwifbzOqR8QRKaqySI5QfT3uqGMsaDo2WuVvkWIAnoq7iDry
 77ZJtsZMF77BHgqJlVh8pifN/5+ihdExP7HvGhXA2AVeMAUx0Qyh0Olr44ty9HpaPSSe
 4AcCb1iRXGUDDnRfZUeu2njhKzZgS5/SyVBSmmFFFtLlhQHZ6kZHeuVjgR1/2A70OkeG
 qRp+FR7aPTgxnvDeMqrpfUktdPY6i264a2jMFxMR3VEuF0CScHItYHkoerYH1M8VrYhm
 9R4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691010745; x=1691615545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+IEn78ekGxFk1VW1GXfwQ8nYIpU1d5CTL8bBZiz8rxs=;
 b=HuEQ4YEcIxp7nFDnMEhl/nNwU22wJ985qljfBH0l3/f3yUZOTuvog+2wD+zRqrO3UT
 ZekEQQTEBD7LyfnlYQPAh+baP3nphkNJLlWqupdkhLkyoctpFKI2e02OvcWDd+Is43Ex
 9WdNq0cHm95jdZMWrSZFv82ZzSz7QSSxAIA4LMaNUoj/IG963snpLI2fD1F6o2mpyA+Z
 kmEmzChOwiW4rVO9mifJu/Hztgye15INgNX3IY6Xx4/PilHO/Zud6Bp+1JldKz9azV3E
 2lvKqFJZAm38y37vmbjfoD5mDXA0QlQPwrtpRR12MA0isR1af30WwiErlqjtdodq2Hyt
 Up5A==
X-Gm-Message-State: ABy/qLYmG5czwryt6+6kzwx+xkUCPYqNrwPauajzMPRZUwCpHGJOwpkQ
 pkcd+FJC0wL+w+OOD8EaJQUASA==
X-Google-Smtp-Source: APBJJlGRpNNwrNc9OTu+ciO653HYxiP0KjqN2MWRcL6tlNvZe5midDyroLTgEaDWk7RU67CdRQzKeg==
X-Received: by 2002:a7b:c3d2:0:b0:3fa:934c:8356 with SMTP id
 t18-20020a7bc3d2000000b003fa934c8356mr5670674wmj.10.1691010745407; 
 Wed, 02 Aug 2023 14:12:25 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.229])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adffa0e000000b003177e9b2e64sm19779407wrr.90.2023.08.02.14.12.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 14:12:24 -0700 (PDT)
Message-ID: <433babe5-a99b-d46e-dd09-e6649af60383@linaro.org>
Date: Wed, 2 Aug 2023 23:12:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] hw/i386/intel_iommu: Fix index calculation in
 vtd_interrupt_remap_msi()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20230802135723.178083-1-thuth@redhat.com>
 <20230802135723.178083-5-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230802135723.178083-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.102,
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

On 2/8/23 15:57, Thomas Huth wrote:
> The values in "addr" are populated locally in this function in host
> endian byte order, so we must not swap the index_l field here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



