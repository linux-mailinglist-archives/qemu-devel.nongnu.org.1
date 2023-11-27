Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4587F9D22
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 11:11:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7YZa-0002Cm-7h; Mon, 27 Nov 2023 05:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1r7YZY-0002CK-4X
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 05:10:36 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1r7YZW-0006kO-7b
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 05:10:35 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a00a9d677fcso546743866b.0
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 02:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701079832; x=1701684632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=eSlsrjh3rjkA1fj9eXpWQYTFukp6J7XnYqMOvCcASGE=;
 b=ol+bd4bK0hDRTuxByLdA14pISmBCPcIRcztzpq7/vKKnfHgP6LSwjITAg2Vyniweb8
 yPAiGpYKviYQeNKGG4Zh41QajXeFGc5S+YA5lZgxRcmHDbk5NlsVfDM50LAawgY4mGGc
 YwoHZKuiTBi7ZSWJZxkx+Ex5iiVAb5EJSR6ilumKd5coxbA+Jmhd9vJJWr+7ym/1zByg
 Jxi/Ul1tAokZ2Ld28C8euDSxCI8Q7WJypbWcVGX+lEEoMJKDxeJnNLcrRwxxQ7juCah7
 VkK3SnMbfySeqmldkqRHfI++BpOAZ0VBrJnAKe6RbIGScGcOWGIhTFSby2gtSNVOunt2
 gVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701079832; x=1701684632;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eSlsrjh3rjkA1fj9eXpWQYTFukp6J7XnYqMOvCcASGE=;
 b=rwUTMtu8eoXpfzHjRcvc76KWXOh0ECOTGZF5FtXj3i1xKIsUq5UajBuYIXwsWpPE1d
 A8jWiWFWQbXh9aOAhzx67/y7xM41IOSgnFyJ2kzJfbZag9Zy9b29HQXS6oY1lukY+USE
 pLfSEJmmHw3fbCBJ5WFrrL8F2u18C/XG7NlFarJF6/F8eti+IHDJCMt7j/iIduiTi+rh
 HvG3xx8LlD5VAyEgSpy6ILfSfIK9wC6PwlR1MhphgSrePQ8Hyi3DqmEOBfUwQZqIrJVc
 0HCKlkarFLAiuM7xaY5o5QZkDirFNzmtGMrtLcPBI4BihIpXFzc9QERCkgEeS7tPxR70
 nc1w==
X-Gm-Message-State: AOJu0YyWBDTj5Qt+pP6ld88E8s7HsMRN64zowPqL4SMKYuNxbGKlCGRf
 Hu7SPExJ2N55Hf5EQ/38ITB5Uw==
X-Google-Smtp-Source: AGHT+IEAalPsfA4i604+rwZfnjXhfingGj3NKnYkHTWa1g9tbb71550d0nypTFiApdj4vOcV+DhX3Q==
X-Received: by 2002:a17:907:c8f:b0:9c6:8190:359f with SMTP id
 gi15-20020a1709070c8f00b009c68190359fmr6629714ejc.33.1701079832448; 
 Mon, 27 Nov 2023 02:10:32 -0800 (PST)
Received: from [192.168.200.206] (83.11.23.160.ipv4.supernova.orange.pl.
 [83.11.23.160]) by smtp.gmail.com with ESMTPSA id
 h1-20020a170906590100b00a0c68d3f486sm2553586ejq.94.2023.11.27.02.10.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 02:10:31 -0800 (PST)
Message-ID: <35c87631-062c-43e8-bf46-67aa3cef5b30@linaro.org>
Date: Mon, 27 Nov 2023 11:10:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/8] Unified CPU type check
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, richard.henderson@linaro.org,
 quic_llindhol@quicinc.com, b.galvani@gmail.com,
 strahinja.p.jankovic@gmail.com, kfting@nuvoton.com, wuhaotsh@google.com,
 nieklinnenbank@gmail.com, rad@semihalf.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 vijai@behindbytes.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com
References: <20231126231210.112820-1-gshan@redhat.com>
Content-Language: pl-PL, en-GB, en-HK
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20231126231210.112820-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62d.google.com
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

W dniu 27.11.2023 o 00:12, Gavin Shan pisze:
> After the series is applied:
> 
>    [gshan@gshan q]$ ./build/qemu-system-aarch64 -M virt -cpu cortex-a8
>    qemu-system-aarch64: Invalid CPU type: cortex-a8
>    The valid types are: cortex-a7, cortex-a15, cortex-a35, cortex-a55,     \
>                         cortex-a72, cortex-a76, cortex-a710, a64fx,        \
>                         neoverse-n1, neoverse-v1, neoverse-n2, cortex-a53, \
>                         cortex-a57, max

Can this list have some better order? A35, A53, A55, A57, A72 feels 
better than current one.

