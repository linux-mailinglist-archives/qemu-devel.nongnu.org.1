Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FD07056E7
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:17:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz09o-0000EY-UV; Tue, 16 May 2023 15:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz09l-0000Dy-TZ
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:16:21 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz09k-0004l2-BE
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:16:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1ab032d9266so493465ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684264579; x=1686856579;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Az2m+JoSUtL274EWCyYnlqOzCnL0NRH0ISrZYngK6U=;
 b=gETifI9SS8dNDqe2RTPrTwJhFDNQWyE7w51Csp1V1dFu5fOMxzCWdRvDba7RNozFmI
 U2XPJctkzIYCjMgdmy8u2icNv+f5FJUGWWcuxc4cwCFMqZkB/icfsbqbI94Vt4RAZQtt
 YaxTUkbkz8U26OswyIe3GqkiwQ+4yIXrwoxPzquQa5AjYn4hIXmByPeobYBo8FfyHGZz
 hu5vPzAcpYxPZb03Y11128SLFmjk5ee5ErQdNzrGkEjwX8lPdr0/j8nNmhcbKOpQIsAF
 sPDXRtwu+dL6sJ8j7QS/sk8ykAGUSTrxDgYrIFgpz+iHxhbwxF61aCFiPGyWIcdcB1jZ
 yhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684264579; x=1686856579;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Az2m+JoSUtL274EWCyYnlqOzCnL0NRH0ISrZYngK6U=;
 b=WaOb6PCCJ0aS6PocAdfXr3cdehJDXpfrWvmOUrY9U273OMTrYiTVOcj7B+WcAnNTZe
 YZimkk69DiGLIBXvPoH2LBLiJS1GcBqv9I65nB4B2ymLSywJHp9HoSMkyoLSiJPtkZg4
 CY1UgsRZplGSz/SDdq7aPqx7ahRX1aeRQ5OuVVPaPRyMxJACyN58PVcgo5qPgclDgqxA
 mSD1QyqwHkrclq8LlcmVGB5FWKWpWZnZJKck6WI3glO9ycsBrDuNjUGT1fHDkhcnHGyR
 +9HjZKNkBTQD223QzThLQG8DblTtcxob0FF84tpdfnCZf6WBCJQ2iyc6dvRy3chTTIlN
 uJtA==
X-Gm-Message-State: AC+VfDzrnvRNEShWRoD0P+39i+bJIWIUvsjyo7wB6rQ/Z1sVFxMqoopn
 FtAYVgdCrCiOr3y+e5/1npLn0w==
X-Google-Smtp-Source: ACHHUZ7u1z7fzEExKOVS/lcJvD6wYmPeSDwjabc6nMyQUZ7DBcuJY7l9sePC4stmJA0pHxfi+MHYKA==
X-Received: by 2002:a17:903:22c7:b0:1a6:71b1:a0b9 with SMTP id
 y7-20020a17090322c700b001a671b1a0b9mr47997585plg.47.1684264578856; 
 Tue, 16 May 2023 12:16:18 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:ec81:440e:33a4:40b9?
 ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a17090311ce00b001ab0a30c895sm5913932plh.202.2023.05.16.12.16.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 12:16:18 -0700 (PDT)
Message-ID: <4dbf7d95-46b6-b6d1-e3b0-f940a86ffe06@linaro.org>
Date: Tue, 16 May 2023 12:16:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 0/4] 9p queue 2023-05-16
Content-Language: en-US
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>,
 Peter Foley <pefoley@google.com>, Jason Andryuk <jandryuk@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>
References: <cover.1684250463.git.qemu_oss@crudebyte.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1684250463.git.qemu_oss@crudebyte.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.666,
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

On 5/16/23 08:21, Christian Schoenebeck wrote:
> The following changes since commit ab4c44d657aeca7e1da6d6dcb1741c8e7d357b8b:
> 
>    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu  into staging (2023-05-15 13:54:33 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/cschoenebeck/qemu.git  tags/pull-9p-20230516
> 
> for you to fetch changes up to 3887702e5f8995638c98f9d9326b4913fb107be7:
> 
>    configure: make clear that VirtFS is 9p (2023-05-16 16:21:54 +0200)
> 
> ----------------------------------------------------------------
> 9pfs: fixes
> 
> * Fixes for Xen, configure and a theoretical leak.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


