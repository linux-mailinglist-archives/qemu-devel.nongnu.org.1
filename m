Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E6F72692E
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 20:50:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6yEF-0007Tt-Af; Wed, 07 Jun 2023 14:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6yEC-0007Te-Oi
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:49:53 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6yEB-0001Q1-4Q
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:49:52 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-390723f815fso4141348b6e.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 11:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686163789; x=1688755789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gERdGlB/T+dx6lEcq74VaSdQYLdT3VE7XyUH7qRXhxo=;
 b=PTOsYxahqFYDOwjtLkatbTMiGLo+1eUfS79rX2zFovpj4o3zjy9qteZGXgecz/yM1c
 wYzjwayw9m+PNCNQfydTXfX4u4G1/A3yttjN+j8FhBVLBhTr9L48YaA+Sh2Q/+EanIN/
 48c+RLkcsKB/QTnn9WruAtAiw7PibFbfDtJ2xZOeSBe+gGf+5uc3v4bOTdWp3c/Ibjo/
 yUSrilN/TQPN9u1Oz60r0OMLMpa63V/u/RFk1zreI+PBx15umS9dfuCPK2WhtmMHbVXu
 EQs44Xx35N8vhwgyaq++NduMo1j3H4JOmS6F7wmDqiNQ+F3v01JXMDlIuOPt3ymA2A1f
 jXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686163789; x=1688755789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gERdGlB/T+dx6lEcq74VaSdQYLdT3VE7XyUH7qRXhxo=;
 b=iPQe7SSgB9+mpHHd0XjXnlvQ04oepSTCWXWySZ9GFryTe27RwNqSVZ2sFR9NhfbLJu
 VghMDJ5MY8VKvZF6TOWRW9mV6c/Tp186P06na5BDAvDuwf4+pfTnZGBGfi1Q2HbCopty
 7AM2C2BiOS2PxuDeblYh8A2GBy8KHMnb0HPWXF62LKF8qJJ9JwIW/C4B7KjzOD6++o8O
 97PSBQHJcGFuqzkx4k72eb1HvoDne15Tgu3X7RV7w021ey5fsABlWhuERV80BjMqrXW7
 cpN8ceYmobwiRue2xP3BWvLE9OZbyuQRzsLO70DWdv5x1A5WWbr25QjnbUWl4ImoXGE8
 tjxQ==
X-Gm-Message-State: AC+VfDyxiYdN+uLih5c+IpZwlqWweNALNV+gbm37Cf79WYcvR2x9gYZ2
 NIO39VGOJFL+mzTjXKPlp4/NmQ==
X-Google-Smtp-Source: ACHHUZ7oymxt0Z3i7Db2IxORaDonjBgBVFDjr7aI/lFoEQml8o6mnLmLPQLYeeynB/LUvL43AJZTiw==
X-Received: by 2002:aca:1904:0:b0:39a:b347:edce with SMTP id
 l4-20020aca1904000000b0039ab347edcemr4160274oii.49.1686163789465; 
 Wed, 07 Jun 2023 11:49:49 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:1f09:2b0b:a56e:7a17?
 ([2602:ae:1598:4c01:1f09:2b0b:a56e:7a17])
 by smtp.gmail.com with ESMTPSA id
 27-20020a17090a031b00b00256bedb4bedsm1765980pje.52.2023.06.07.11.49.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 11:49:48 -0700 (PDT)
Message-ID: <206a3363-6b49-0cda-494f-0d69f7162c6a@linaro.org>
Date: Wed, 7 Jun 2023 11:49:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] iotests: fix 194: filter out racy postcopy-active event
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, berrange@redhat.com, jsnow@redhat.com,
 thuth@redhat.com, philmd@linaro.org
References: <20230607143606.1557395-1-vsementsov@yandex-team.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230607143606.1557395-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 6/7/23 07:36, Vladimir Sementsov-Ogievskiy wrote:
> The event is racy: it will not appear in the output if bitmap is
> migrated during downtime period of migration and postcopy phase is not
> started.
> 
> Fixes: ae00aa239847 "iotests: 194: test also migration of dirty bitmap"
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Queued and applied.


r~

