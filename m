Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFB7822A36
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 10:21:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKxPr-0001HK-E0; Wed, 03 Jan 2024 04:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKxPc-0001GH-KR
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 04:19:46 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKxPa-0007TU-PJ
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 04:19:44 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3374d309eebso270142f8f.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 01:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704273581; x=1704878381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5ooNoPjL26IpKded8UKXPH4td0bzmVxNmp3Fp+OcrNE=;
 b=y9dye0NHp0vgRAyk2TZ4cz+V3gJgGcvCQFbK7vT+BmBZ38VNx8dwro9B+TeUhXdTSG
 Gt387PqhOYBbHD11TXRa6y3FhD1uEsz/bne9Ha+ld4FfQ0ZxISf7JHDxAQH/e5FeyOw3
 Fap9LI48uFOEFwMzfword4mZWKqTsswyZ0/8Dvi6V7H6+0IMD2hfTLvH2Z/GzJEM1R2A
 x62xXsHMk7xJ1Z1mfb8WU/IQk8s1/7+KEjp7z1IFS5Gtz+fYkeCkQf6a9vVDkG16b3m5
 XwD9UP2KGFOLycXzxMiA4OkMcNH0EYEGNOc6B/s4SRAthtM0iDDrVqsB9+orb8gZ2Gz4
 8hvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704273581; x=1704878381;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ooNoPjL26IpKded8UKXPH4td0bzmVxNmp3Fp+OcrNE=;
 b=HhWbFM5KxjbKiioyU9g2f/QfRV6DLMFSJPzKe6lwXBg0Qe3YvfDiR+WpICir+9WNYS
 2c3i6ywdZAk6qIIcHX9vOpanImEQuTCIHtxqXNsQMIHdWELB8LdO4ZHSjy2yHFpZPg+h
 gYoUbxdWPuAIJUTyR65PPQN3K5SQ9GT1XRvcpbPvpvBmYyBDlL2ljxrg7YtNiKqaWdNJ
 xe7fk+drA+cJP1IGYgSrChRR/hEWtE6AQQuVT+kMN6X+nO/59jDtuJJ9lbxRCCfBUyPF
 5B4hIHQM1lb1eo49Bds7xsaMa+L3r+fQHxwrmaWjXXk6uApyXE+2gkbWS8AD9Jr7hxYV
 GRGA==
X-Gm-Message-State: AOJu0YxCFlkd3VmcYvN4MoMoJSxVDMs62la8aESxag2vZkzByiWce2/7
 c7BL6KAtrjA5IRgCwIXoDDf36EurkMqKIQ==
X-Google-Smtp-Source: AGHT+IGSJf8MKcjwqxwbl1bKe5xfiRAki36T8rP8nUpGLQNBb3SGLs2cpiAUvOdKD0ykp0z4plt/Rg==
X-Received: by 2002:adf:f1c5:0:b0:336:6b67:2cc6 with SMTP id
 z5-20020adff1c5000000b003366b672cc6mr10711490wro.126.1704273580932; 
 Wed, 03 Jan 2024 01:19:40 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 c15-20020a5d4ccf000000b00336ebf27d59sm18486753wrt.78.2024.01.03.01.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 01:19:40 -0800 (PST)
Message-ID: <fe4d463f-b646-4b7b-9063-d16ad5dbb128@linaro.org>
Date: Wed, 3 Jan 2024 10:19:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
References: <20231212162935.42910-1-philmd@linaro.org>
 <03b969d3-1947-4186-b3ee-15e3cddc5f34@kaod.org>
 <18a38b88-8f20-420c-9916-a03d1b4930a7@linaro.org>
 <38cfa9de-874b-41dd-873e-5ad1f5a5805e@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <38cfa9de-874b-41dd-873e-5ad1f5a5805e@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

+Peter/Fabiano

On 2/1/24 17:41, Cédric Le Goater wrote:
> On 1/2/24 17:15, Philippe Mathieu-Daudé wrote:
>> Hi Cédric,
>>
>> On 2/1/24 15:55, Cédric Le Goater wrote:
>>> On 12/12/23 17:29, Philippe Mathieu-Daudé wrote:
>>>> Hi,
>>>>
>>>> When a MPCore cluster is used, the Cortex-A cores belong the the
>>>> cluster container, not to the board/soc layer. This series move
>>>> the creation of vCPUs to the MPCore private container.
>>>>
>>>> Doing so we consolidate the QOM model, moving common code in a
>>>> central place (abstract MPCore parent).
>>>
>>> Changing the QOM hierarchy has an impact on the state of the machine
>>> and some fixups are then required to maintain migration compatibility.
>>> This can become a real headache for KVM machines like virt for which
>>> migration compatibility is a feature, less for emulated ones.
>>
>> All changes are either moving properties (which are not migrated)
>> or moving non-migrated QOM members (i.e. pointers of ARMCPU, which
>> is still migrated elsewhere). So I don't see any obvious migration
>> problem, but I might be missing something, so I Cc'ed Juan :>
> We broke migration compatibility by moving the IC object in the QOM
> hierarchy of the pseries machines in the past. These changes might
> be different. Here is the QOM tree of the ast2600 SoC.
> 
> before :
> 
>    /soc (ast2600-a3)
>      /a7mpcore (a15mpcore_priv)
>        /a15mp-priv-container[0] (memory-region)
>        /gic (arm_gic)
>          /gic_cpu[0] (memory-region)
>          /gic_cpu[1] (memory-region)
>          /gic_cpu[2] (memory-region)
>          /gic_dist[0] (memory-region)
>          /gic_vcpu[0] (memory-region)
>          /gic_viface[0] (memory-region)
>          /gic_viface[1] (memory-region)
>          /gic_viface[2] (memory-region)
>      /cpu[0] (cortex-a7-arm-cpu)
>      /cpu[1] (cortex-a7-arm-cpu)
> 
> after :
> 
>    /soc (ast2600-a3)
>      /a7mpcore (a7mpcore_priv)
>        /cpu[0] (cortex-a7-arm-cpu)
>        /cpu[1] (cortex-a7-arm-cpu)
>        /gic (arm_gic)
>          /gic_cpu[0] (memory-region)
>          /gic_cpu[1] (memory-region)
>          /gic_cpu[2] (memory-region)
>          /gic_dist[0] (memory-region)
>        /mpcore-priv-container[0] (memory-region)
> 
> 
> Thanks,
> 
> C.
> 
> 
> 


