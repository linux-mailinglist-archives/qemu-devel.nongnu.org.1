Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C4077029C
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 16:10:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRvUg-0005Q1-9B; Fri, 04 Aug 2023 10:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRvUY-0005PK-P2
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:09:23 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRvUX-0004DP-Cc
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:09:22 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bbd2761f1bso18117955ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 07:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691158159; x=1691762959;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D1Bn/RGTkAKbClGDG/WlhHOQyemCYC3KuZRbrbPvFb8=;
 b=v9uVr11rsR/UFGctNpfURbiDSIdz8k7XdZ5oRF4/Myvr6kolN8957TFVC5tMT8TWAK
 YlnVjJ8TE8BYK4Q8sF8KgdsrlLt1RPO8PV28nEr3HA3j2jX61htsjr7c4SaksjNmwp7k
 aFnib1DovC8a7BF+6CtCiAPWTAPm+hTFBdtWHbXgSwTLc3+BcSpx+Kuu3WGAGVov4/xs
 kfR9TJiQTkHPGcS7FrambETpDuKD1NtFcEa5lxjMhkPK5d773wN/YeoVVDUd7IbWm0+C
 aYgXoRUZNiTR6L83F07BKfOIy//nq/CKjXJbB7q3kx2IP4XLX3bAKe16d8x+FU31vJ7S
 yPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691158159; x=1691762959;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D1Bn/RGTkAKbClGDG/WlhHOQyemCYC3KuZRbrbPvFb8=;
 b=HFKOTHUwpbMLXlCt3eWLfwpPffW/NRiGShJxfUeLQxGnZvQaAHYSS0Lk3gmoUi1lKJ
 TW6NGg1gaemyXLrQavFFSu8mJa3aR1E1ejzw8YJO+g+6VYHmp4WKyXts1GRdb6DT58Xy
 quDPDhs34rKBsEQlCsLCHkj1llP408ly2hSK8Pz5nVuqSa8Z9nG5gJMZNpovha8HwOv3
 2/l63CwL9lJrfcUhum6lXBuBNDw+BgtFHgkIj3ER9nMfmtY0/WZeUfGcvESmBhQZI1KY
 knMnZQqP/b1NcF3xm/OkhwF3scgfBeq+3PQ9v3qTQmulSFd6oJyqqRYpDRzeeAfPkoZp
 0JOg==
X-Gm-Message-State: AOJu0YwRPhvJl3yjqakp1zTTAj+/0wI+JiwQ1gdhkKo5EmQUoaGtd32/
 zXDc1D04OBpHfZV+Xl15i/5Jdg==
X-Google-Smtp-Source: AGHT+IEddRA5zrrITr0CaBlU4En2ROarPmsEXtikk+pPAlSFik12hU3/mXyQTD5tUr0jezR6TNYAmg==
X-Received: by 2002:a17:902:ab86:b0:1b8:400a:48f2 with SMTP id
 f6-20020a170902ab8600b001b8400a48f2mr1877099plr.62.1691158159651; 
 Fri, 04 Aug 2023 07:09:19 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:1eed:f77f:f320:8b14?
 ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 o22-20020a17090ac09600b002638e5d2986sm4216138pjs.17.2023.08.04.07.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Aug 2023 07:09:19 -0700 (PDT)
Message-ID: <aeacf283-ea9a-e0f9-dc89-e967a5695b38@linaro.org>
Date: Fri, 4 Aug 2023 07:09:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 10/17] linux-user: Define ELF_ET_DYN_BASE in
 $guest/target_mman.h
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: joel@jms.id.au, akihiko.odaki@daynix.com, laurent@vivier.eu
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-11-richard.henderson@linaro.org>
 <9a5d6672-72ed-e5bf-2585-6b718e5ab632@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9a5d6672-72ed-e5bf-2585-6b718e5ab632@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 8/4/23 02:50, Helge Deller wrote:
> In this regard, could you please include my latest patch titled:
> 
>     linux-user: Show heap address in /proc/pid/maps
> 
> in your patch series?

No, as it's not a bug fix.  It can wait for 8.2.


> If applied, the "[heap]" entry is visible in /proc/cpuinfo output, and
> it's much easier to see potential future memory isses, e.g.

Anyway, changing the guest /proc/cpuinfo output seems much less useful than improving -d 
page (which misses out on logging lots of the PAGE_* bits).


r~

