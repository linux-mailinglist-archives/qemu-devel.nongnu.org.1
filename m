Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C3173BB3D
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 17:12:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCiQl-0003sh-AO; Fri, 23 Jun 2023 11:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCiQj-0003rX-IX
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:10:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCiQi-0001xd-0D
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:10:33 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fa23c3e618so9603745e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687533029; x=1690125029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P+Os7HA8ehxWwLwi/8yftirexa2vFomcZEFJ7Dyfx9I=;
 b=q09nR9gFP/N+6BA4yzW3d4H5b8c4iMv4sa4tO/b8t2mYRtS1msUUWO7OzpsJ8joOyU
 DuM+cxBkix0MVGdJ5y2e0C7T99z8cAtiZBY2ljPnXLLMtnb8t+Z8vcmT39VwF8CWNUfV
 16vmy8z/83MlHJqMgHF09Wd2YMzyzZywbdIUMt+0FayihoiiUAy3VjxTAmYBpmSwYYH0
 y+vQuJFnwz4m2cP3T42QjB7/U/SEP3h95DOuABlXqOLNrlhp5+c4LqhUYDaEOWzCF7dT
 hHoGELQnzm43B/afT5npl8dPNb6+61YuI+qBGCSad25ysXdQiEbZSs1xre5z7Luf9WP7
 A3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687533029; x=1690125029;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P+Os7HA8ehxWwLwi/8yftirexa2vFomcZEFJ7Dyfx9I=;
 b=HJtVQ91RUXEc42u7Xt8wdY4oXNgW3wImb28Eqn4ATu2+nFRs7xF/zNhdtKiMFYnxP2
 WQUgpMg5ofFFor2SJWPqsQV4n4cA+82K/fUdnl3bNsjgvjRUMCakpeBsgou6McJuqQBS
 AHJ3JhnPaTzusKdVFu6eYInXJC9lGrd+QXedgxSSXMGo1dLiESD5IpQiDGLP5b5JriGJ
 DKzLiWauNAt3tI+k1N/wXQ5Ij028KSLmxwIINdxBuAUIxALxd/+0L+8x2NfijmtFz2Od
 El2+VUzUmZlALg0DnUHoMjTYIiPSIqrlnoAlA4anEAEhl2ITFCgZaJkyhAGsSDTIdh26
 yPQg==
X-Gm-Message-State: AC+VfDyXxSu3uEtkdZrd8YbpfqNn34Himbz2lX+3cCtfo0cFaRymaKWN
 fDXi3U/jP26pVpofJq4Pg0cQ3Q==
X-Google-Smtp-Source: ACHHUZ4xySbNfdymxvCDpIMdVlSZhWDsKl2WKfDMeJFHcE/1iBhPaHavMX79I+gVSWIy2/FKhYP9WQ==
X-Received: by 2002:adf:f601:0:b0:30c:2bbf:bf8b with SMTP id
 t1-20020adff601000000b0030c2bbfbf8bmr17718908wrp.69.1687533029106; 
 Fri, 23 Jun 2023 08:10:29 -0700 (PDT)
Received: from [192.168.93.175] (94.red-88-29-173.dynamicip.rima-tde.net.
 [88.29.173.94]) by smtp.gmail.com with ESMTPSA id
 m4-20020a5d56c4000000b003078354f774sm9747696wrw.36.2023.06.23.08.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 08:10:28 -0700 (PDT)
Message-ID: <f93d8ea7-ddf8-fa90-2fc8-d37ed27cde21@linaro.org>
Date: Fri, 23 Jun 2023 17:10:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 11/26] Makefile: add lcitool-refresh to UNCHECKED_GOALS
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Riku Voipio <riku.voipio@iki.fi>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Qiuhao Li
 <Qiuhao.Li@outlook.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-12-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230623122100.1640995-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 23/6/23 14:20, Alex Bennée wrote:
> This is yet another make target you usually run in the top level of
> the source directory.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



