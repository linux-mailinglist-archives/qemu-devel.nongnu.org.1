Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB07A7396E8
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 07:40:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCD1Y-0001IY-Uc; Thu, 22 Jun 2023 01:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCD1W-0001ID-Bf
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 01:38:26 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qCD1U-0004Na-Lp
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 01:38:26 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51a3e6a952aso7904887a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 22:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687412302; x=1690004302;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qobpu5Ck8/G6g6LuBsyXvXxDx8gDB2KlNNdZB9A7mok=;
 b=Z3+jtd2IyCgqHHJbM8XuQ0xRJFFJVh8JFTrCM90wk1hKDPSY60ltfub4fIMA1f1qJ7
 rbd6rk9JWWThKBz0BoW5s6ReQY1Y/Z/adJKBDFSIEyQm7Wk54rOGALsYsdShzUKKIo2n
 +JYweuuT7L4w7Y7j4rRw+vXkwoazKdjel0DBbZrg93tqso2nvYQcP1JxdYaoJZSI9VX0
 06+OoeOKt1sNTuJ1ImlPPTuM/uFa1hAChc4DWRcjGpdpdwofuNEjfeRpxBkUlBt8MQCt
 t3qvLy44t4L0o+SK1K9o0+q9ejqoA8zOKmn8hAH6xTAlBoiTkwEoomG5tS16tB0PRm98
 0L6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687412302; x=1690004302;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qobpu5Ck8/G6g6LuBsyXvXxDx8gDB2KlNNdZB9A7mok=;
 b=aUX0b5b8+tYFO3tVCKTYa2LiN7KMT6sIqSYIeMf/3CTEwmpYr06oU2gVABCQbKx8fy
 dJXKGCU6QZkdUngWfM7xhgrND0kl+qMOO7/U+hVXjnwExhPErbacY/KVQQ375KhpwEth
 ZNlM9Zg78zUKARbx5aJl1NYbdbK4+fuJSMh+EIbQwDW+xqAlE/Wy7gjT9tvI+OmxepDD
 a8FzV99xtGYYczVg48t06TCKqCeuGK77KU3On52QYX/DEufKn8n8mxl1FRdGyiKGUGlD
 J/xuME8C+zBzJg/tfz+m0VD7gYWOpdNujiPffjGMMvqVB21CBQshJ4XpSYYEe6Oya6mB
 tefA==
X-Gm-Message-State: AC+VfDwT2xiu1upsONWtUY+7DvtFQkl9obRYsclTWsZO8cSjhNfSX3Le
 Ku8NWHpPiAzubmD44f7T6zNyWw==
X-Google-Smtp-Source: ACHHUZ6ZHq2vMaZ9snHRXAZ8swnYcw/2JpYzlLIGh9c7sn4IHEvbTsQmXNwmn+OYpVxTwneYpoVYsQ==
X-Received: by 2002:a05:6402:502:b0:51b:ebd3:69a2 with SMTP id
 m2-20020a056402050200b0051bebd369a2mr176087edv.38.1687412301920; 
 Wed, 21 Jun 2023 22:38:21 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.171.45])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a50fa91000000b00514b3dd8638sm3450111edr.67.2023.06.21.22.38.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 22:38:21 -0700 (PDT)
Message-ID: <609d91c6-1690-5f2e-57a7-da6e4b1597e4@linaro.org>
Date: Thu, 22 Jun 2023 07:38:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/30] Next patches
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>
References: <20230622021320.66124-1-quintela@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230622021320.66124-1-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/22/23 04:12, Juan Quintela wrote:
> The following changes since commit 67fe6ae41da64368bc4936b196fee2bf61f8c720:
> 
>    Merge tag 'pull-tricore-20230621-1' ofhttps://github.com/bkoppelmann/qemu  into staging (2023-06-21 20:08:48 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/juan.quintela/qemu.git  tags/next-pull-request
> 
> for you to fetch changes up to c53dc569d0a0fb76eaa83f353253a897914948f9:
> 
>    migration/rdma: Split qemu_fopen_rdma() into input/output functions (2023-06-22 02:45:30 +0200)
> 
> ----------------------------------------------------------------
> Migration Pull request (20230621)
> 
> In this pull request:
> 
> - fix for multifd thread creation (fabiano)
> - dirtylimity (hyman)
>    * migration-test will go on next PULL request, as it has failures.
> - Improve error description (tejus)
> - improve -incoming and set parameters before calling incoming (wei)
> - migration atomic counters reviewed patches (quintela)
> - migration-test refacttoring reviewed (quintela)
> 
> Please apply.

You really need to test at least one 32-bit host regularly.
It should be trivial for you to do an i686 build somewhere.

https://gitlab.com/qemu-project/qemu/-/jobs/4518975360#L4817
https://gitlab.com/qemu-project/qemu/-/jobs/4518975263#L3486
https://gitlab.com/qemu-project/qemu/-/jobs/4518975261#L3145
https://gitlab.com/qemu-project/qemu/-/jobs/4518975298#L3372
https://gitlab.com/qemu-project/qemu/-/jobs/4518975301#L3221

../softmmu/dirtylimit.c:558:58: error: format specifies type 'long' but the argument has 
type 'int64_t' (aka 'long long') [-Werror,-Wformat]
         error_setg(&err, "invalid dirty page limit %ld", dirty_rate);
                                                    ~~~   ^~~~~~~~~~
                                                    %lld


r~

