Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6617A72DDC1
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 11:34:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90On-00022V-9x; Tue, 13 Jun 2023 05:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Ok-000224-CV
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:33:10 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Od-0004ko-Ls
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:33:10 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9788faaca2dso884906466b.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686648766; x=1689240766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CylKb+h/aBtIokX4atzffzYSp0vfmbOsuM6UaEXnMB8=;
 b=Cu6JBI3NGbeetzG7UbMKvpoB67+p9VKv5Vi5faetOG3vxTll6rLoAmbl2d5gihstK6
 P98IkG598PvgWPwmt2WMLtyNZjfCsAvyjN/GFwVUGpHufckxkclG+6mA+C0c5HP+mdYP
 SkfKkw4TEKsRVTZig5twxPPNVoY7JGkEVQz5Q9u+9be718235gqiGZla3a40OC0efm5d
 LYZUD5p9w2GT9M3f1rSZXrtgPlgGiP3BjUKPQQWCsE/K3QhlP1B14dfbIMd06Q010prG
 tCJ9dfxNIv974uTHoskmj782s1gsWfgVRBhGSqoojy4oEHMThNhb0gRthxwS8ajKntit
 fbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686648766; x=1689240766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CylKb+h/aBtIokX4atzffzYSp0vfmbOsuM6UaEXnMB8=;
 b=LUZNQrGwKlLqvkBCOk6GHzi+7J0Q51HXK785V/j0Fw1LRbOM9nacg2UFq/czM+SBrd
 e9E3bMoYIbZbtv/Z/1lSWVx1bP6rgU8k/5VWQcLNZimH+F/qYSSCy715ci7Bkx5GftQ4
 +Vw6IyjdGJZJb0Nme8InDHk9tJjDCARnm3tF+xNvALIlDBcfCM4w0lUtFi4NY/grtirr
 iwiQkpTt4xsr/jcUkzw5H/YnWN5BSg9R9wEn0RHJ3t6JHBGQ5tWk7Igofp8XDie+TZcX
 G2PbREZPtnu5cEwMgjXqHHzlDcEUyAULYBVsWbany8eJiemD2LOqoH+LPXZi0ADO1ohd
 6haA==
X-Gm-Message-State: AC+VfDwzXfXe4xLjdqUygU0zDPZ3m6qHqWAf1ZYlNp1Shpyyu1rXdPCs
 /XvYKUOeJxVYDTief0cnzQLjhA==
X-Google-Smtp-Source: ACHHUZ4r1f0/cXVHv8PHgWLsFOU4+43KgiRsTb9U1NSVCKta+CgaHePqQSBt/iMToQgPEF1nqMsg6g==
X-Received: by 2002:a17:907:6d98:b0:973:d8c4:a4df with SMTP id
 sb24-20020a1709076d9800b00973d8c4a4dfmr12482179ejc.52.1686648766443; 
 Tue, 13 Jun 2023 02:32:46 -0700 (PDT)
Received: from [10.10.0.115] ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a1709060e4200b00982362776cbsm961943eji.118.2023.06.13.02.32.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 02:32:46 -0700 (PDT)
Message-ID: <223298b8-ca57-0121-3be5-79006295ae41@linaro.org>
Date: Tue, 13 Jun 2023 11:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3] linux-user, bsd-user: preserve incoming order of
 environment variables in the target
Content-Language: en-US
To: Andreas Schwab <schwab@suse.de>, Laurent Vivier <laurent@vivier.eu>
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org
References: <mvmlejfsivd.fsf@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <mvmlejfsivd.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 29/3/23 17:00, Andreas Schwab wrote:
> Do not reverse the order of environment variables in the target environ
> array relative to the incoming environ order.  Some testsuites depend on a
> specific order, even though it is not defined by any standard.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>   bsd-user/main.c   | 10 +++++++++-
>   linux-user/main.c | 10 +++++++++-
>   2 files changed, 18 insertions(+), 2 deletions(-)

I'll take this patch in my next PR, thanks!

