Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7352748EF1
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 22:27:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH94h-0000T5-DQ; Wed, 05 Jul 2023 16:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH94e-0000SA-JT
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 16:26:04 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH94b-0002FF-GY
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 16:26:02 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-98e39784a85so217954866b.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 13:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688588760; x=1691180760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VJVNNwQEBZ27OV7Q2nq6ui/idP/Xg+POsZCDKdiJMkI=;
 b=MQAXQghqTVTNk/jQSp+7a0KOMHKjzwHi7LtQH6NXQhu5hnppOzScSL4vewgGVcAQ3g
 OtrdItl/rt4Fq30KtsfcxdUgmux9G5U/e767lvpFcgBPWf/rYNa9ne/y5jExFs2lmvK4
 T43+zYbvMi2tuy7yB7OHkD0GUC8cG5oeBkaK+6cajotVLwIWBJtBKzmrwvc04s57wWu0
 qT4ZFg2cjkkWXV6Y8WXedBAAArYHJT8s2a9juSV9wWaoU6p3ImJsXeU+fmgP6qxcjmPG
 G1BXvZYWhDzDUz+NJaxXXwu1LiUQ2p42qmNCpXwJnI3bOfQH7Ka3XjAIyvDhNqz2sD54
 OzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688588760; x=1691180760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VJVNNwQEBZ27OV7Q2nq6ui/idP/Xg+POsZCDKdiJMkI=;
 b=R9LXXAZ3Hd9pRiPu0XeDWRINzpoABq+OnYI5u1KmOqS92nqNRA+aPZ+E8xjZknmpdU
 OJUWqqKNO0MM5qtFqebg1ibSXKHEMVlfu7GI41q7skfd8RzhyPCfvR97xWmLPqTYtyHM
 ZkJwKZkQiF2GdfIAMKN6c8UNMCSGTGyy8WuJK1pUO+PqZ12CeA4chXatHKX5i3T+svAV
 2K9dN6lmDQyA68nat6gO/9DMuJRZaGA/bjwQenonIV2S7sOyAWpArF1ZCW40UhtMDYN/
 ZzEQGgrN4NC1t5E+D0TcX+tVRZKLAbOsoc0VRtmqCEAjyIkvOM6JSV3cYsBj49AJQM/V
 WuUg==
X-Gm-Message-State: ABy/qLbuAnru/65mgFVjIcX5RjCA9DrfcSOcLq/pYzgZzTlPEAaN2240
 emlM30PAPXQOog648aGK+nru9A==
X-Google-Smtp-Source: APBJJlEzMlEFq2xjr8mZJuFGho4v3qCQW5jqN5dPVO/ofzRgfD42noZpWOWAaq0FElgYgHbk9kM/Hg==
X-Received: by 2002:a17:906:77db:b0:992:1ecb:d296 with SMTP id
 m27-20020a17090677db00b009921ecbd296mr215081ejn.12.1688588759733; 
 Wed, 05 Jul 2023 13:25:59 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.225])
 by smtp.gmail.com with ESMTPSA id
 k25-20020a17090666d900b009737b8d47b6sm14933069ejp.203.2023.07.05.13.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 13:25:59 -0700 (PDT)
Message-ID: <70797f02-839e-74d8-6f40-fe1e39861508@linaro.org>
Date: Wed, 5 Jul 2023 22:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3] kconfig: Add PCIe devices to s390x machines
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20230705152301.2850086-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230705152301.2850086-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/7/23 17:23, Cédric Le Goater wrote:
> It is useful to extend the number of available PCI devices to KVM guests
> for passthrough scenarios and also to expose these models to a different
> (big endian) architecture. Include models for Intel Ethernet adapters
> and one USB controller, which all support MSI-X. Devices only supporting
> INTx won't work on s390x.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>   v3: PCI -> PCI_EXPRESS
>   v2: select -> imply
>    
>   hw/s390x/Kconfig | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



