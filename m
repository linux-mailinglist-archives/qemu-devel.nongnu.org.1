Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E3E715FD6
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:33:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yUn-0004gI-35; Tue, 30 May 2023 08:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yUP-0003wQ-OO
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:30:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yUM-0001Fk-Mc
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:30:13 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6d01d390bso45837775e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685449807; x=1688041807;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5aCI4yNqcUK7XYzwGuwgqxLfmdzwJW23J4p5WWeGwAc=;
 b=O2pfDymFA1KVyq3dT7DAMEIwr+XCvexxOBZgysUbi7YOXTBsUTciExxEDi30o+cKIP
 W4pcuzgr18kxb7WnBUAqvmwSduH0Va+Wja5GEgpR3+263hQ73PyyxjGNJZtFXP7VMgVJ
 OkZ8MLow9QwQCvDtVhfoK/K0vb+2pnzM9c6IPuBB2JAIqy3omJawG49nE6wXd0jLhuy/
 Kpriaj/FUOiMG0IUKGw6r377a5FhKWEGqubWTdfx1PU1/v32TTz8aZ33tBeCoLog0ACZ
 EYOsCN1spk7LI0GFu+OxvsFBzRT97bTfdbma+QcwvpLhy93I0MBtbw24JiYY6gbVlxzD
 sbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685449807; x=1688041807;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5aCI4yNqcUK7XYzwGuwgqxLfmdzwJW23J4p5WWeGwAc=;
 b=iK/UfBfmB1129SSWWuYuN1QULD2gFSc1viq7+PCO0mSjZx+ts3XQkbGZ7u0F7RFNcD
 R4nMhJILEi/ZxBUtq8ytSwwgkBKED+r19pRzs9/b76+di+hDVbZW+QPOzoHKeH7qKppX
 Vub7r317xH0Pm0JAWVtoTMS0tY4mD84YdvvXJIpFzmLP+cOvEgl4SqoY76su5Wth1677
 3iqQ5PLn0r+EaDa7wVX2uzybqS38zX13QNSbmv+3BMoV4wARAxnkcni+A9qHrvfs0hKI
 L82BES0WW2pQ7NI0aGi3tFp4viimbjk0xE7Glvbu+rUT8zWYgTGESWWoiby7YAxcHGSf
 MPnw==
X-Gm-Message-State: AC+VfDyGcpwBfY7NY8A3bCUzNXn5TiKPJa90lISx0jRQNZswUEEYa+hs
 b3z3GON+Smi3hM92vppjwewPxpczd1w/U1UNkDHUIA==
X-Google-Smtp-Source: ACHHUZ4T5LGo5Rusp1E1O7tU2Z9fe+TecJzwFFrHOMPw8EWfZBOncrl9fYgXdHDCsscyG7azagmQhA==
X-Received: by 2002:a05:600c:2105:b0:3f4:2ae5:b35d with SMTP id
 u5-20020a05600c210500b003f42ae5b35dmr1962471wml.40.1685449807147; 
 Tue, 30 May 2023 05:30:07 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a1c6a09000000b003f4272c2d0csm17220780wmc.36.2023.05.30.05.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:30:06 -0700 (PDT)
Message-ID: <68163136-0439-cb05-e13f-0aa49c1417dc@linaro.org>
Date: Tue, 30 May 2023 14:30:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 01/10] memory-device: Unify enabled vs. supported error
 messages
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
 <20230530113838.257755-2-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530113838.257755-2-david@redhat.com>
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
> Let's unify the error messages, such that we can simply stop allocating
> ms->device_memory if the size would be 0 (and there are no memory
> devices ever).
> 
> The case of "not supported by the machine" should barely pop up either
> way: if the machine doesn't support memory devices, it usually doesn't
> call the pre_plug handler ...
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/mem/memory-device.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


