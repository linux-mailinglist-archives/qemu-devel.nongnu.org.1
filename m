Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFB47441CB
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:06:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIVL-00024Y-Hy; Fri, 30 Jun 2023 14:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFIVI-0001kq-1N
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:05:56 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFIVG-0000BU-2N
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:05:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso12825465e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148352; x=1690740352;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4UFoZtSSc9HTqWl+KBZ0BWNVyFZhzc9T8p1DRnKM4m0=;
 b=jedyI+wFtBsjxJfhw6ijofMAfmCM3FhfoorGR7dbrfJPt0Nj4NMIojdgw77GKztGHq
 z+S7TstMZWsQu5t0M+k/txtX3CheGNLR63KZAbP67Plga1PxqtBtkwIwnSYti+4frY8A
 XWn7PRKA7+KjO766T4CqKw26x3zdZ77ikgUKTHh27FtJCsVUYGFV2/7ansRUDAb6XGOH
 l3f85QUkhNCmktv5Ed2bvEi+0wv+gAsM+mgr9B+7PWh20MVD6OyNHLUyQwrx4Gi6deRx
 kZLpXgZ71cfe03ehyP3Z6xmiQ8iEn9nKDpa2Oi7C1kNs68iuU5zJhSAg6r7VzrZS1DAA
 ZA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148352; x=1690740352;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4UFoZtSSc9HTqWl+KBZ0BWNVyFZhzc9T8p1DRnKM4m0=;
 b=j1dxp0qqzVNMMwrPmeaCRGhJz1t39k0txpiq9sjod42qsnznFMhs7rctXs6kcFXEDN
 Iezw2MlQCshrL9QcQX/ypPOQdULFoqNGhVt7sOlGa7r/yRm6UeYB2HKWaw3JYCRoTop6
 NaxE0aY3oxI/jtdYC3Z2iTme4gKUwHfoEwgXU92112GV1Vpobl88XVhO9PD22WIwis5h
 PTJSdLpOKnTfTVFrupKz0wf7JYb9Pim4fYktd+KQtqbzpKcLZrztMcX18OuezmRP8yJb
 yV3O/WYvJ/ZeuMeZBib6IcgLPnC528QEQRhb6l0UuDdPDaYextqf0bZY8nOT/X3+c5As
 ux9w==
X-Gm-Message-State: AC+VfDyrJ+mBCRDeQF0NIyOA5ddzptybcOVAfqlBqiW7oUAfgK0jvcv4
 Dc2jp9wtfEmwJ0wrFoKScz6lP0Kk3su10jHmrHp90g==
X-Google-Smtp-Source: ACHHUZ6uMIukLogPM8Q21bEiKHGftf4oe8KBMf7qM9cXWqKdEX14xJXbO5doLWMVZk0RDfy7fxAm7w==
X-Received: by 2002:a05:600c:b59:b0:3f8:f4f3:82ec with SMTP id
 k25-20020a05600c0b5900b003f8f4f382ecmr2666209wmr.8.1688148352441; 
 Fri, 30 Jun 2023 11:05:52 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a7bc851000000b003fbc89af035sm1767017wml.17.2023.06.30.11.05.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 11:05:52 -0700 (PDT)
Message-ID: <1266753f-b973-2600-f5f5-b9576bb53f98@linaro.org>
Date: Fri, 30 Jun 2023 20:05:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] target/sparc: Enable MTTCG
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
References: <20230620164040.912490-1-richard.henderson@linaro.org>
 <2044463e-24eb-722e-9cc1-a5a90c3f7ea3@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2044463e-24eb-722e-9cc1-a5a90c3f7ea3@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/22/23 16:36, Mark Cave-Ayland wrote:
> On 20/06/2023 17:40, Richard Henderson wrote:
> 
>> With the addition of TCG_GUEST_DEFAULT_MO, there's nothing in
>> the cpu emulation preventing this from working.  There is some
>> board model work to be done for sparc64, where max_cpus = 1.
> 
> I've tried testing this with the Advent Calendar image at 
> https://qemu-advent-calendar.org/2018/download/day11.tar.xz and even without these patches 
> applied I'm seeing hangs with -smp 2. When applied on top of the other "target/sparc: Use 
> tcg_gen_lookup_and_goto_ptr" series I get assert() after a minute or two:

Would you try again, now that we've solved the issues with lookup_and_goto_ptr?


r~

