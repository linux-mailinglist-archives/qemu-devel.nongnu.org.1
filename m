Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B4A78612C
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:07:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYu7K-0002S8-Ph; Wed, 23 Aug 2023 16:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYu79-0002Pn-3G
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:06:03 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYu77-00024k-Bw
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:06:02 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bf078d5f33so47983505ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692821158; x=1693425958;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rjLeSBijtCJIJIs7If0gMi4lc1xP11kjPpJ8IGNh2+w=;
 b=cm13b3U7uaH17ZSAtjBgBjSuPvVt5YS7SLbmSvvOkBhsKImsF6I4QPao8H2ALICmus
 c5lfmT29w1NnzrA6xSAGhcTepWYxq0f0YP+j+WS95Kp3PKxl9+i4BWujGiP/NLyAgz+p
 Mk2321EP09/na0Ufyr+sSYfoQEovUUSPNpQQvyMoWqVPWeOsynEdot9rQ78Kh2FKTuyj
 5QtTVv68qxog4XyO6o+nBCdPDZnGe3KItBPHvXl5xgBoPo7i0q9gRojwOkQVIK0Sl9yQ
 EuJ+7XRF9/zevqtpw4RQI2phO7xgtOC8dEuC2x0f6Ghni1qPl3XZUG+8onkA67cAz9QD
 ELww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692821158; x=1693425958;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rjLeSBijtCJIJIs7If0gMi4lc1xP11kjPpJ8IGNh2+w=;
 b=gkbUX6BSwJWEuNujjhMSqpJwX6TAwX0JbM4PiiYJ+zm24JQeuWr+uafHsc7B0z/5MK
 6EGIk2WwrFZ2mfs+BOb06lH5hA5uftk1FB9WAr+Qhz7Hglr5Y4Rg8bZQ0Ovvb0PjaR8m
 PYLuQurR76jnVfhyTQfdt2uZ2fuYm7XxPI6265Gtt4Yx13V6t88ZaBqTGEu9xUA38Yb/
 +FGRQBxJeTLhd0vb6lYQzk5TbuIcAi1YcGhzcF/nl9ZJzOQ6zqYTq1YiQPd9zsxKO/4s
 Fsf4Qhat3zLMHib44WZwPHl4xyyFWSVzEXImlR6qdZlBP6uiOUXyY7vy3TZzRAOLsuLs
 9t/A==
X-Gm-Message-State: AOJu0YyUkikEZbn56qD3FwFGmDNfNpv5nCvc2Z334lSYYcLhEvYu9892
 J4M0jMzFJ8L4C8UCJk5A9tDOLg==
X-Google-Smtp-Source: AGHT+IEpfk2OoPCaLEcW9bta9Xmu5e/M88cGkNdt4t/+w6rT+juJuqSq07OVwVtiaXbLMlWqNMMvMg==
X-Received: by 2002:a17:902:c191:b0:1c0:aa7c:9017 with SMTP id
 d17-20020a170902c19100b001c0aa7c9017mr2433126pld.60.1692821158307; 
 Wed, 23 Aug 2023 13:05:58 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:72f0:1ea7:85d2:141e?
 ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170903230400b001b9de2b905asm11326175plh.231.2023.08.23.13.05.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 13:05:57 -0700 (PDT)
Message-ID: <64e29bc9-1bee-95ca-5592-f95e605ad315@linaro.org>
Date: Wed, 23 Aug 2023 13:05:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/24] tcg: spelling fixes
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
 <20230823065335.1919380-4-mjt@tls.msk.ru> <87v8d6gnzk.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87v8d6gnzk.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
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

On 8/23/23 01:30, Alex Bennée wrote:
> 
> Michael Tokarev <mjt@tls.msk.ru> writes:
> 
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> 
> Acked-by: Alex Bennée <alex.bennee@linaro.org>
> 

Queued this one patch to tcg-next.


r~

