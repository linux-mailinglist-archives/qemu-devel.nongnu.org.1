Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B15715F06
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:22:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yLv-0001kT-7R; Tue, 30 May 2023 08:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yLQ-0001a8-Mq
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:21:02 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yLO-0007WZ-MT
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:20:56 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f6ffc2b314so15629915e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685449251; x=1688041251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DFtZntuEl1to71WY1h4Q8k2NANDLHZYkiiH+L8N/vek=;
 b=l4rNGmhwwjm0FuoTpbC6CI1/Ks59+Prjr6+cI/jLIs3y7h0VvUu2MAkUoPmPtcGvdQ
 zjgbjm9evt+mYkZzTkexUa8EtwHD4zyJFN6ZAglQbUCcfQ8K+J0aHU2yOypjk6hYZgXN
 dkw8NtbTSSqaQuE/WA6fp56VR+wlrAPyPK646lAlaYZmKgANHQOSVXqVocB7Co5Y+ZmU
 56TCLUo5D1dEALpjbl/wK1M9tcb1+8kTFQkV6lDEXm3GI5ly8lh2k5uL6f7q9FEx1Ngd
 9499Gn/RV5RvOy2qPIoQPW5qw96KqyShFQLtWHWgsee4hnGrZidC+OXwh45P9i6KTuwB
 E38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685449251; x=1688041251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DFtZntuEl1to71WY1h4Q8k2NANDLHZYkiiH+L8N/vek=;
 b=BsTQ4yqYUbJnwEm+ubqZCWyAMYfyvoh9aEFjcNIDOHjhmgPVQsJw0uBiH8L0+RoZg8
 ZhdSfJVdqIC/fsocM3w9/pRV1vJMT2R2mrNOK/V4ZDfKKO+Epiy3eMD5nfr19kGdHNAB
 6CYmRhFK8lYYKKvgWQM1J9wNvuDJ7B2liJO7j+dwvBqwJKY1dHy/XOPmF70VaZDvsVAC
 5QopYNdyOXBLPZguwGnZYhzFLxPjvha0A01DRGqE8JkZ91TVYQWtvpncLdNkPRE/V8QW
 S6SbBVryETQdaouZBjvKdQGDIxwAbvE0QYWEqrgMz5D7myae4SU4oM2VIbt5wwXzwN6N
 NDgQ==
X-Gm-Message-State: AC+VfDyUc/Aj1DLzDLvYDXxC1Xry5+7Su1x45puhhPGukQZSuyz4ZgmT
 1Ro8wiGxgI7FFHwRiPvIcbaiGQ==
X-Google-Smtp-Source: ACHHUZ6Jn32rs4Rnx/FA/WW9zERI9/XkuO/9DhU631RqfkEL0ZCXuhQbUsFSAcVk0/tU1iE2w3zdVw==
X-Received: by 2002:a05:600c:3551:b0:3f7:15:ad37 with SMTP id
 i17-20020a05600c355100b003f70015ad37mr5806037wmq.4.1685449251375; 
 Tue, 30 May 2023 05:20:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a1c4b0c000000b003f4290720d0sm20720665wma.47.2023.05.30.05.20.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:20:51 -0700 (PDT)
Message-ID: <56ea1eb5-34fb-8650-0d3d-4a63b196658f@linaro.org>
Date: Tue, 30 May 2023 14:20:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 05/10] hw/loongarch/virt: Use memory_devices_init()
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
 <20230530113838.257755-6-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530113838.257755-6-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
> Let's use our new helper.
> 
> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> Cc: Song Gao <gaosong@loongson.cn>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/loongarch/virt.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


