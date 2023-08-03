Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 273AB76EDED
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:21:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRa8O-0007Gp-Iy; Thu, 03 Aug 2023 11:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRa8N-0007Gg-6c
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:21:03 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRa8J-0007mW-IT
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:21:02 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2681223aaacso773386a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691076058; x=1691680858;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S8n71elZ/Hku9zZdbTXGiNpZtbh7nSNpftMfK2/yp0c=;
 b=v0vg+xGND0Jbb5u/CeAmTz4t3yvvZeRvuxUkCi0yWIds+1W3FJT9NKI4Aywd0kQeH7
 V5xXTC1ZXzxi3SZBM902bVaJebWCKEub/CiVZbaVONAOh5c6m5pVK9hD0HscjbSaR61j
 1GkjjYmvyB6zXiwIBMHWJmaBlinvFuOjDUOEFNygpbfJ0JKRoBhxr+38U1Qiz35TkSxz
 ARlkgO9+Y7RUtW4s4V+au5IRCXBNmr1wPIL+aBcLxnmE3z50BmJZWFQIyk3JRz+auoXt
 lyBUdqWD83xgwBtvjlTDB+Zr5gtsXiNNi1y9/+WFj6QBjgwFs6VfgvnhI5PxiGYsmwG2
 IKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691076058; x=1691680858;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S8n71elZ/Hku9zZdbTXGiNpZtbh7nSNpftMfK2/yp0c=;
 b=LXjydZUGPvC2QAaAy9aQFMuu4VyBBlRxiw0mUQ1GjKl2rXsd1Ls8J1HvmQNYoDdFGv
 wGcJPHOjqCA0GIsKX+RsJUUShi7qMh6qnoPWFjWwr3BOY1O3IJyuJpqIYfUNZqQXKGEe
 z3nddUoJ200rT/Pkv8UUjctmpPenBa1M6CEYWGJUIUqfrBlVW1PMC2d7qOUK5eQh9plp
 p6OWQ7TtJ0O7r8PJ2E3lak57oCvBYM0rPjyGO8MCfXMNsUSdLj4iff8NAkeKHVgYN73J
 Ty6p0KBVt/5YmK5oBGEw7sirM/oPBWAH600hejCxGMJT3hxFjXDUC3k3im2zZa1a+810
 6QkQ==
X-Gm-Message-State: ABy/qLa/bMGrX2lRoYM/2v7OO/11n3qMvXvovjQo9v39RvWWpVUNU8WR
 zIfzDd5yIjLICCUUci+U836+lA==
X-Google-Smtp-Source: APBJJlFILEuCgev3VVX5vl0s+a9pFvZhfo78xCThHaZczMKUpAX+DLkJkoNI9CRc8IPxlMHojJfCCA==
X-Received: by 2002:a17:90b:3b8a:b0:268:8ff2:5c0d with SMTP id
 pc10-20020a17090b3b8a00b002688ff25c0dmr23002514pjb.17.1691076057879; 
 Thu, 03 Aug 2023 08:20:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.144.105])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a17090aca8d00b0025be7b69d73sm92774pjt.12.2023.08.03.08.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 08:20:57 -0700 (PDT)
Message-ID: <a023f15a-9e6c-1975-a395-c8fac0340ba0@linaro.org>
Date: Thu, 3 Aug 2023 08:20:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 00/14] linux-user: brk fixes
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Joel Stanley <joel@jms.id.au>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: akihiko.odaki@daynix.com
References: <20230803015302.407219-1-richard.henderson@linaro.org>
 <CACPK8XfNiGiprxYd-J+E-oFqPsRVPfQa7+e5hX8DFw0OudT85A@mail.gmail.com>
 <cd9b0651-475d-1b11-d648-594b52d48bd1@gmx.de>
 <CACPK8XcdO4KpBfUZmxLNRLLcAOfM9D39be=m4O72kO0+_GiuQQ@mail.gmail.com>
 <ZMvBTMpi9jDVWDiP@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZMvBTMpi9jDVWDiP@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 8/3/23 08:01, Helge Deller wrote:
> If it does, it replaces patches 1,2 & 4-6 from Richard's v7 patch
> series.

The patch you gave below has no overlap with 1,2,4,5 at all.


r~

