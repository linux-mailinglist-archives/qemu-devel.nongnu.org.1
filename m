Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FFE7CDC9C
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:05:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6F1-0001vg-9T; Wed, 18 Oct 2023 09:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6Es-0001o5-DC
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:05:36 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6Eq-0007eO-7P
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:05:30 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso7254607a12.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697634324; x=1698239124; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qJJBz23ZKLaNGx5toSeISCczR8yY7igwrYHbxAA2MSM=;
 b=d5EEGEjIR2jMu3U5GWlOLnbKyo1nyHlji0WdHomjNXSmulDwJPAn4RCIStJa9GzHDu
 NP/HEV6oUfJmICJ21g9RPFsJgG2sgv1hQ3C6o36KfoACm6mWu7FdwAYBYXqBHULur7uZ
 dwa2rvs26JO5giqT1A1ysBH9rXNw5F0rgLOoSy/q6ZwLku/ndelFkIL1c5/ICUaBynat
 xM8hxxNSp6qrOG0OBu8D5B6rZjt9f1C7ksbfLiORgTqpYG+wHv9w9sx4NW0vO/2UbkO2
 K2vS6wkMO6EGNyfkzy4kTn64d1F2QYGoEGUIhBAY4EUfE0GFpGEw0xXOp7vQolAgKQ0R
 EYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697634324; x=1698239124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qJJBz23ZKLaNGx5toSeISCczR8yY7igwrYHbxAA2MSM=;
 b=s+6GoT7QjeSjcDToOb/o5ws9+jEDH/B/ZOF9o3TyxeeJwfZVQjrXhhgT6osf8I7I4J
 4XmNcn9Acq4mHzmgT1K1qa57m5pH/WX3C3U6Elh4qqF6r3RedKPRmndUhKkQL0+G5C2C
 MBLIuROk+Whm2BtMiqk4iS8kcqh6nA0TjClE2cpi9vhAwFeNATK1SJoVgEFPOzcHutrE
 vOx2lpb7MOVwLsa4UIMh4ekaE7hevs9dGS/Y9r+s5p1+S+smhaTlIdTr43+FlTh4Y1Q/
 7OMncxL/2qHN/LvwfutMZdhAwJf69Wjh/l0FPyh4jC0wsun2XCZsaw8Aymp0yxR5J/bp
 KxZA==
X-Gm-Message-State: AOJu0YzN9ZbDUGUp4zTxNTX1jCn5Wz8uvy4SG9beYrOxOxTmpKYb0OZJ
 ydpMzKtqRBZgO8oyeIlKMp9UjA==
X-Google-Smtp-Source: AGHT+IHghcbF56wUGCZ8FKx7R395n68DgaRn8qQwngyRQeLq9k2LoKgY1QS0a61oFjAVTI9Qmvmt5A==
X-Received: by 2002:a17:907:26cc:b0:9c4:4b20:44a4 with SMTP id
 bp12-20020a17090726cc00b009c44b2044a4mr4161997ejc.48.1697634324392; 
 Wed, 18 Oct 2023 06:05:24 -0700 (PDT)
Received: from [192.168.69.115]
 (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr. [176.171.218.149])
 by smtp.gmail.com with ESMTPSA id
 i27-20020a170906115b00b009b2ba067b37sm1588733eja.202.2023.10.18.06.05.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 06:05:23 -0700 (PDT)
Message-ID: <231e91da-5db6-33dd-cfd4-4b11b06089cf@linaro.org>
Date: Wed, 18 Oct 2023 15:05:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Add include/hw/intc/loongson_liointc.h to
 the Loongson-3 virt section
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Huacai Chen <chenhuacai@kernel.org>
Cc: qemu-trivial@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>
References: <20231017153345.233807-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017153345.233807-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/10/23 17:33, Thomas Huth wrote:
> The corresponding .c file is already listed here, so we should
> mention the header here, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


