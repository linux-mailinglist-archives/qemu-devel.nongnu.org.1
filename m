Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8CF70BFF7
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:45:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15qQ-0002IK-BC; Mon, 22 May 2023 09:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q15qM-0002EH-JE
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:44:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q15qK-0004wa-Cf
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:44:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f603ff9c02so8860055e9.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 06:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684763095; x=1687355095;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=svwc0/+5RYZKdDUZoP5cNkRoOhXHI35PI5ZOYlLAeHM=;
 b=JbXJP7Zxb8MvdfQYjmj2mMnsjYWLVI4N35TyAhHAiSqXYMEObsBbO6z0Y5GP3ir28H
 Ol1DhlfiXE3VVIQLlil9L/YOKfQ0LiO2mJyORiY7pIRqadrVoGTL+57eokuGqUibZPO5
 05g2AgCA3IWZourc2hrON+enw45muISvzoR3dJtIcfetkx4C5ZmfsQSpoCgPz4rFndy2
 57wGrvdQtgnsGefF4r0VMC1es4uqEKlsf469gq/FVl1JEi1Yj1ZWqptL8cJDCyKVZYDC
 0q4ZAC4rcevtiiMNqZAvoOAYugPPcZ4tlYyCWwtl8oDGNlVR4iLgfKKINjora2KT/C1G
 ZmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684763095; x=1687355095;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=svwc0/+5RYZKdDUZoP5cNkRoOhXHI35PI5ZOYlLAeHM=;
 b=eTdEL4QJ61du/pqJAknW/eOs1SOpMn840cTYTe8mqW5jrbaM1l0NyfH+JzSW42EGpE
 WLqEm3IUp0F1NiGoX4YHL+LrXWWnmU5lMpnvXlxizLQeyA1aIriwIB8DcOf8mvVn1N0R
 cRjRXmLLeWObaqoUXSXwjIhOP6bnc1kX6D6JxD7DTcQj1zYY9z70uCmOOaLcpX+/stH4
 XQvXpofqOm7FwpWxchQXukn3TTReKS4Nb0gqUZydc0NI045IvTRqYyZE3NTjfzJGDgrO
 5xhXe24YZoYzETMsfOWcXGNU2wLuzB6VhBgaeqsLzl4XelogGL+dU7EjXv6Jc4tt0J21
 vmzw==
X-Gm-Message-State: AC+VfDzcgVfUvUIF+PMDxym8DaJCxJzKbYvdo6f0QBU2W/b/AEV9zcvy
 Py2QWOr8wyl9oMxsGhY8i81Pe3tS5rVyd3VanGw=
X-Google-Smtp-Source: ACHHUZ52CvlPhjuFHyE+dfKgBkui4qF+r1BhXLrJpb5YH0Umx5hSCKq/rZrWDMLiOdU+eOVk43vBqg==
X-Received: by 2002:a05:600c:2146:b0:3f6:4f1:cfbf with SMTP id
 v6-20020a05600c214600b003f604f1cfbfmr2095194wml.20.1684763094760; 
 Mon, 22 May 2023 06:44:54 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 22-20020a05600c231600b003f421979398sm11499443wmo.26.2023.05.22.06.44.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 06:44:54 -0700 (PDT)
Message-ID: <e184fa06-9ce4-1ab9-4680-58aa6c4200b9@linaro.org>
Date: Mon, 22 May 2023 15:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes
Content-Language: en-US
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen
 <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: QEMU devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
 <20230521102307.87081-2-jiaxun.yang@flygoat.com>
 <CAAhV-H4kx5cDcswkHpCYH9UZhh7PDEndP+NvwNgdZaZji6BFLA@mail.gmail.com>
 <CA74488A-DB92-4D13-8BAC-5E853F187419@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CA74488A-DB92-4D13-8BAC-5E853F187419@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 22/5/23 13:47, Jiaxun Yang wrote:
> 
> 
>> 2023年5月22日 04:52，Huacai Chen <chenhuacai@kernel.org> 写道：
>>
>> Hi, Jiaxun,
>>
>> Rename loongarch_ipi to loongson_ipi? It will be shared by both MIPS
>> and LoongArch in your series.
> 
> Hi Huacai,
> 
> Thanks for the point, what’s the opinion from LoongArch mainatiners?
> 
> Or perhaps rename it as loong_ipi to reflect the nature that it’s shared
> by MIPS based Loongson and LoongArch based Loongson?

I'm not a LoongArch maintainer, but a model named "loong_ipi" makes
sense to me.

Please add it to the two Virt machine sections in MAINTAINERS.

> Thanks
> - Jiaxun
> 
>>
>>
>> Huacai


