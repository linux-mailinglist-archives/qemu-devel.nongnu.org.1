Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E682F7DB24D
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 04:40:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxJ84-0005Kz-P0; Sun, 29 Oct 2023 23:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxJ82-0005KO-Db
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:39:50 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxJ80-0000nT-VO
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:39:50 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c59a4dcdacso58854061fa.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 20:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698637187; x=1699241987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CLbnV4tOw6DA3WcwtkTlioe4LZD7T9M1jQqf5mnagl0=;
 b=mL/HoMRSQHKgfdLLV6AqMlqkfKQjnHXkIEfyw8ZtwmcYRieLklYwXqe79mIvu+ZtVo
 eHG6CRrps/T5MZh6zehmVT13M4qvRzlE+7+TszeVeFJjudAuIiYq7lLAfAQ/csYhVROF
 X++d8UbKwugpa7z/nnbPN289y/ljzcA14yIc5reWPL8GbNkeOHXkWWP8RCK+6rgJF3rL
 3oOvUXogEj+0qQJvrM996QOTglFUf3DrpxbI2LrhNXK26W+4jXC9risR8lp3StoKvzHN
 s9VZY+AlfJolWeUD3DiAdsqFPMb1FitnDgxfeZ9TiEVIr1ugXEFUeRXRBcV11dByGoNO
 ftGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698637187; x=1699241987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CLbnV4tOw6DA3WcwtkTlioe4LZD7T9M1jQqf5mnagl0=;
 b=Yysv2xP8ZkqGoH9il1O1NncI5YPMqa1/EdNiyQbVtLvQjOqTM/8FsUwn2Tubi8iSkN
 GWRIWyXvE/MHYQ9DN2nsiQ8NCSEjT5QXMwbcKFtN13oYNotEFkW0bjCNamE1QF/IOW24
 V26dbvOPKByWnoDewnCoKzlrh/RaZ5h4TzFugbrL9rWqQB3MbqDwyuKtYSvbIVX/whdq
 YOfmG0Bq/Nhh+HFB2yJ5gAaxD+wYkm9FmUhjIAn+DVLWbPT+D44wwiXYFMW/4tXm4H+6
 TSax5sP47VQnryW77+hE9LoT40sR6XY2duIavdMTDZNXti5+x50FWgcbBVciRf0YoEW9
 fKDg==
X-Gm-Message-State: AOJu0YxFKEt7j2satLQpggY4N/mWiOBF57/DaaKfoW1QcbWrs2XFnW6Z
 zz0cY5psI25yFKLF+xxJrvuzzHJXoREYvga8oaY=
X-Google-Smtp-Source: AGHT+IFZWBBUtlDCZGaLDsxJR56nk+bXxNzKjc7lQCP7xixqosf/6FfKmQhAU+qAGslmLLDsMdZDzg==
X-Received: by 2002:a2e:9154:0:b0:2c2:8efd:a52b with SMTP id
 q20-20020a2e9154000000b002c28efda52bmr5584293ljg.36.1698637186979; 
 Sun, 29 Oct 2023 20:39:46 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 p21-20020a05600c431500b003fe61c33df5sm11389641wme.3.2023.10.29.20.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 20:39:46 -0700 (PDT)
Message-ID: <797a7fb9-6987-525d-cc0f-442a308357a9@linaro.org>
Date: Mon, 30 Oct 2023 04:39:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] linux-user/elfload: Add missing arm64 hwcap values
Content-Language: en-US
To: Marielle Novastrider <marielle@novastrider.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20231029210058.38986-1-marielle@novastrider.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231029210058.38986-1-marielle@novastrider.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.972,
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

On 29/10/23 22:00, Marielle Novastrider wrote:
> Specifically DIT, LSE2, and MTE3.
> 
> We already expose detection of these via the CPUID interface, but
> missed these from ELF hwcaps.
> 
> Signed-off-by: Marielle Novastrider <marielle@novastrider.com>
> ---
>   linux-user/elfload.c | 3 +++
>   target/arm/cpu.h     | 5 +++++
>   2 files changed, 8 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


