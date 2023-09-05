Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC117921F2
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 12:47:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdTZS-0005yZ-VJ; Tue, 05 Sep 2023 06:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdTZQ-0005yA-Lt
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:46:08 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdTZL-000544-Kj
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:46:08 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-401c90ed2ecso23963015e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 03:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693910762; x=1694515562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jObNrs6JMJwdrbyl5CFUVN9vOVh6iUppq7CGKT4gBRw=;
 b=BLXJ522QNKX/C4raS9saFUEj484INQL12kg8YKUUwOuvBWTD/lpEKHZwHJnYezmNp6
 vCzgFmpWaBQxZxI6EdOQ/5yHigWoOECoJNOH22uvXrph+YcnpHgXdLXNZ/2Jrn5CXHir
 ChOhSpohziH5BsIulJvTGw0baWXFM0Hw84fbT116mr2LHMNjjFLcV4uJ92mDG/Fn31Ow
 HwdtNQI5e5YGhTMqSUyaY8HXoXVUzADnihUG75SVNG+wclgPTPcXgW6HL/jb12B1Jj1c
 qG6535pZ1j69ZNUHf4dd3ezmA/ejsTBaZisppjtqgSOANNRwH4G6/B5oQtS1orBjAcgj
 087Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693910762; x=1694515562;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jObNrs6JMJwdrbyl5CFUVN9vOVh6iUppq7CGKT4gBRw=;
 b=fTIpYQWsVXkWNJP7EMWaRQgK+ML3NpA3kOf9YL6YzEfk2DeoOKXLgNoaXKi1c4s6ME
 auDE59utCChubuaBCrpedY6mz06CXefJCWxMCxVTlXkWoW3XhoJEX91F/YA/zWqWV+TJ
 atc+1iPNl8EiKzIYCKfux0fA6gkhykYU57d492j0baN3JFT+a7tlTTqGFyz1QoVjRZgH
 WOEvSh4UHUQSneRziXxiSbX7NWgGpLdid5/FXIdmyf7gN8hSQPMaxgNHr7JoJmcTXDIL
 GYiCy75H2jFzgGQqGu9TAogmT1X0roHhROgegTSYHsfL7S4Ybr7omWSJ2vRFNQZKR1WH
 4KDA==
X-Gm-Message-State: AOJu0YwsLtGAi55JDp5QGrqutT4Ku0l+pVywNEf/y+zpxtc42nstZS/B
 EBeBAaH6jLZKxDrN9R+yAOlncenbiuMGXgqy2M8=
X-Google-Smtp-Source: AGHT+IFYIE1iRtBhObBhc6koK1hYhp6cBlaCPE3eiwKfB95tD4ferb1STvftzZr+S8TTG0M3WXpKkA==
X-Received: by 2002:a05:600c:3b8a:b0:402:bcac:5773 with SMTP id
 n10-20020a05600c3b8a00b00402bcac5773mr7389261wms.38.1693910761992; 
 Tue, 05 Sep 2023 03:46:01 -0700 (PDT)
Received: from [192.168.1.34] ([37.69.27.38]) by smtp.gmail.com with ESMTPSA id
 e2-20020a05600c218200b003fef5402d2dsm19839232wme.8.2023.09.05.03.46.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 03:46:01 -0700 (PDT)
Message-ID: <08c7b39a-0bfc-4891-8cdb-76a188b84758@linaro.org>
Date: Tue, 5 Sep 2023 12:46:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] docs/system/replay: do not show removed command line
 option
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20230905100757.298689-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230905100757.298689-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/9/23 12:07, Paolo Bonzini wrote:
> Cc: qemu-trivial@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   docs/system/replay.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


