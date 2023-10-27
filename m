Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B037D8DB6
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 06:08:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwE7t-0000Gs-LR; Fri, 27 Oct 2023 00:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwE7r-0000GT-0q
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 00:07:11 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwE7p-0005co-IL
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 00:07:10 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so1577138b3a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 21:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698379627; x=1698984427; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nOF8MYqKfXigr33ojSoWRwby9EctwfAAtKbzM9wnbTA=;
 b=ckgpCgursNgL0wGHNTciXT1SqyLa6xS8Zsf5BcRRO28ECzn5UH1VfnLaP42SA6jlmO
 gu1iG3UGEnwhjhnVq9dSQiXsx7TjAROGg3I6ZJgjlfnLyVzHsJIfAkVANml1EVKJ/FZc
 ptD0LwmK4t3b7aHHBL+/wk3up8CLGkjmiE97PeWbgF8YTEyvB9S9IIEW6wA7ivRAaFBe
 JevT0/hG7vFKR1HoJ1KAXw1nM4uRajmhk1hTiDEBf7XUwVUwz3KnIdURKLFTmqRViIQx
 MtcqT0NP7hTMKdVoRm/Njx6EdZWKlkalZ5uz2Ho/CzAYTQQZfP0nBMqQK82echm9LQqQ
 j7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698379627; x=1698984427;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nOF8MYqKfXigr33ojSoWRwby9EctwfAAtKbzM9wnbTA=;
 b=jGTRTNQwYb9cMD0CYhF/KcIPA68kEP1LecxuTX/lt7kjx52nXf9G9Q5StNUbJCUtW9
 YiB446ywCIcC6hGtNi+e4BVzLYM3FUXZFO44PK7bIOYWd7f2dYRZNyrNy0oyxPDM5EM/
 4bGTQbq1WuSMY5lTMqm7RUtt9/JnKoT9Mle77n+KidnZv4rL+xBBII77dMOy1Af5n/Vy
 vrIbiS5j86QtxGbiVeIQYnQZ6G0rcrXX9UlsQGlNZibzQBrgtKl62ZHJGmY8TB5npwIn
 NU2ldgDlBZg2yhHqyXiRuaI4/Tsyv3P2fBDYX1t+Qp3vQ7pjQ+gal8P0LdZ+zhtHiHtf
 ujLQ==
X-Gm-Message-State: AOJu0Yw3cEYEeN3KU4AC22hunS9fxR6+1oDlzbG0pFRqrq98duJB99i3
 N+ulYNIJX+36i2DPNbafreYLEg==
X-Google-Smtp-Source: AGHT+IGF2K6EQ3au2V+pd09tQQWzUYWfJdjKc5svGpwAr8NGMB4VrZJjwjWNzLBB5JdVnIxw4a829g==
X-Received: by 2002:a05:6a20:938c:b0:15e:108c:35b0 with SMTP id
 x12-20020a056a20938c00b0015e108c35b0mr2169787pzh.4.1698379626718; 
 Thu, 26 Oct 2023 21:07:06 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a639558000000b005b18c53d73csm316101pgn.16.2023.10.26.21.07.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 21:07:06 -0700 (PDT)
Message-ID: <08059fad-10fd-482e-944a-9a88cbdd4eed@linaro.org>
Date: Thu, 26 Oct 2023 21:07:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/i386: Properly align signal frame
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: fanwj@mail.ustc.edu.cn, laurent@vivier.eu
References: <20230524054647.1093758-1-richard.henderson@linaro.org>
 <37c6c860-7b80-45ce-97e7-74b833a905f7@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <37c6c860-7b80-45ce-97e7-74b833a905f7@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/25/23 23:35, Michael Tokarev wrote:
> 24.05.2023 08:46, Richard Henderson:
>> The beginning of the structure, with pretaddr, should be just below
>> 16-byte alignment.  Disconnect fpstate from sigframe, just like the
>> kernel does.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1648
> 
> Ping? Has this been forgotten? It's been 5 months already..

I have not returned to this problem yet.


r~


