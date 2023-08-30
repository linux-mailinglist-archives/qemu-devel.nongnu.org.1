Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3487C78E23A
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 00:20:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbTX3-0001H2-7d; Wed, 30 Aug 2023 18:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbTX1-0001GZ-0K
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:19:23 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbTWx-0003hU-5P
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 18:19:22 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-53482b44007so218851a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 15:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693433944; x=1694038744; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xSgN2hP3woKq9bq3MGk4IpkYwmmLEUhWXNmp0r5KTW4=;
 b=DyfZQyKoUxjaViXiwkdJnPCDH9Pi/ShNBJiHEOAsUHCBndiRqeX1eeFpittHHAmxZ8
 QoaqziYRgrf6DdM/GagXlXADd0zxpNNCKsIegZDigY0GVOVLAWmGI9xKy/AiXlgrvfHL
 jHsutPltC+jwkepOh7ypd9xVu9R58YMFw+zHK/jwZTZSu4IbjeTLoFk8wwJp1HI6IE0D
 0t2jD2ifJO+HiIespqBBBzGWXmTV7sLhjDEgCxpD2Qrw8/9Qch0q8lx2wI891HxOV/Q4
 DuqCtwP28XtMifY9W2LF6L62IL/pjgAXqqLPZgLsUHgQAwT271kaZbXtsI3K1q9rGe66
 gbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693433944; x=1694038744;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xSgN2hP3woKq9bq3MGk4IpkYwmmLEUhWXNmp0r5KTW4=;
 b=laNZUWpp6kvJ7TbdJx3yv7OsuG9kcqrLdAIbJkAV8YzKh8TBo2HbGbGer9IexH5f5V
 0FW7ZQgWLk5DLZseRuvFVQnRzLM8/45IGF0NPysaZCwdH2u/A6V2x6toP2BHA+juW7nQ
 JzoOJt/K/Gfk2AcXJj/Eyb8SVFSpupYqkdpVM467fWyLjW6XtoQmeSm3katWJZZ/5YBN
 7KptONFpu7Y+x3MsqZdn9yPxi59wK86ghIfxtRI5X//WQUrG4r1Ow6ylsJCL/ESFj54c
 Gqf3rf+jPJ34kQhnz5IfcVWKzssFcCcnhFEI+0pbNpx0x97n9mPP6ShggcyE3yDJGOl9
 70Jg==
X-Gm-Message-State: AOJu0Yy4NbXc8NCAAfWuutTaAoGijCvwRymg8am9xBh55eauRXJJE7PQ
 aNUsoRs844hi/gcdkhQvJvRTtVsveq8LkdHkyi4=
X-Google-Smtp-Source: AGHT+IG1Cva/yBC3atiZyUbkRNPQ+b2a7ZIjjLcxDnRORik9MM2rl6W3rjgFFH9+pJhYq0pCQ4ypfA==
X-Received: by 2002:a17:90b:384a:b0:268:5203:b8b7 with SMTP id
 nl10-20020a17090b384a00b002685203b8b7mr3420808pjb.21.1693433944245; 
 Wed, 30 Aug 2023 15:19:04 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 fa22-20020a17090af0d600b0026b6d0a68c5sm87422pjb.18.2023.08.30.15.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 15:19:03 -0700 (PDT)
Message-ID: <bc1da1c2-25fc-ebd5-e79a-67c46ecf476c@linaro.org>
Date: Wed, 30 Aug 2023 15:19:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 20/48] target/loongarch: Implement xvsat
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-21-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-21-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> This patch includes:
> - XVSAT.{B/H/W/D}[U].
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode                |  9 ++++
>   target/loongarch/disas.c                     |  9 ++++
>   target/loongarch/vec_helper.c                | 48 ++++++++++----------
>   target/loongarch/insn_trans/trans_lasx.c.inc |  9 ++++
>   4 files changed, 52 insertions(+), 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

