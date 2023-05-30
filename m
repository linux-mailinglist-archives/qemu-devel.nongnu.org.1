Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE46715EDE
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:20:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yJt-0007CX-7L; Tue, 30 May 2023 08:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yJg-00079f-9I
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:19:17 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yJc-0006wX-CW
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:19:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6da07feb2so45243015e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685449138; x=1688041138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v4t1Wxe3NyuaT4BwvxtqUCLC+60B0bgxTbCFrTqs/oY=;
 b=hGrTUe+cOFJQomLU0/hyAMqvY2y1hhX6eMUwY2RM2bdg2zxrKmONWZV4tmmgsxHzmJ
 2pBEIVwG/60MVrCMEYbz6vnKkaUlnMLaD0aX5wj34jVNPqryVlHe9BlKVmBvCerDqvxs
 iTWP/Yti8dgbgCmluZPYlClktmZFUT9NdJWLm5rw1+sucM27vHGP4UH5tx9Ycg5v072W
 sL1hDnVY9a6Ftpg+TFlXZGEYwyKfg1TcMq4Ld1U7wHBTzR/p7L3l/I5ehiluWMHztX5W
 ecFG4untRQI25U2oQotSoup7eqI2fvMMO/5Rzxw6z4PcUlAb3DTqImNlhhpVTyvK2wry
 7u2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685449138; x=1688041138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v4t1Wxe3NyuaT4BwvxtqUCLC+60B0bgxTbCFrTqs/oY=;
 b=GH5ufjScUN907/rML5RMWTljSB5ieJMcjZpBZtThtlCIvVKhr0srX9PHIIWx7r4KFE
 o17aaq8o28K9QYJzXXLm7zbVeFjiRvPW9XfQTqgyqWQa69lEZtWx+rBSqMUQSIElQ7cB
 R1zLBICwvDFaa1LR1sReHEa4Z8SFaeLMsr19Jm0pzaHwE2GLF/Cuqv41XLNAeSqdQgHv
 pNi77BOkeqE/G/P/t/QmreX3f2Dokfc6YzirId40iqBNSeMtKWtMtEUuszSReCgrtAIh
 cmOysx2LQ8DEURAp7GUpiYjnbXsZaCQhHdhDO15UNaEs2HX4Jq613uNeyOSbBLZWRkkJ
 5Jkg==
X-Gm-Message-State: AC+VfDxnNU81d0iw9IlyWeXOuWweg4L+Zb5rkSUP2OZX2fLH/H+0vtUN
 7/HqYynq2RhFLk8sHd8DWPFPaA==
X-Google-Smtp-Source: ACHHUZ4Mn2cwNQS0gbsUcEdN67Hu0ocMQVdTZCk8azFtbYugqWcnmV505jE4wUdQR+WVYSQXCAkmEQ==
X-Received: by 2002:a05:600c:ad7:b0:3f2:549b:3ef2 with SMTP id
 c23-20020a05600c0ad700b003f2549b3ef2mr1671485wmr.17.1685449138157; 
 Tue, 30 May 2023 05:18:58 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 z26-20020a05600c221a00b003f60101074dsm20908772wml.33.2023.05.30.05.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:18:57 -0700 (PDT)
Message-ID: <01dfb308-febf-6def-47b2-29484b04c616@linaro.org>
Date: Tue, 30 May 2023 14:18:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 02/10] memory-device: Introduce memory_devices_init()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230530113838.257755-1-david@redhat.com>
 <20230530113838.257755-3-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530113838.257755-3-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 30/5/23 13:38, David Hildenbrand wrote:
> Let's intrduce a new helper that we will use to replace existing memory
> device setup code during machine initialization. We'll enforce that the
> size has to be > 0.
> 
> Once all machines were converted, we'll only allocate ms->device_memory
> if the size > 0.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/mem/memory-device.c         | 14 ++++++++++++++
>   include/hw/mem/memory-device.h |  2 ++
>   2 files changed, 16 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


