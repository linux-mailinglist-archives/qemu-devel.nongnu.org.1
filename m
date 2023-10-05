Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A23157B9AD9
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 07:04:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGWs-00008b-HL; Thu, 05 Oct 2023 01:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGWr-000081-1S
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 01:04:05 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGWp-0001b0-65
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 01:04:04 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40684f53bfcso5021965e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 22:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696482241; x=1697087041; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jzEKfXVX0+58rDdXtVzlcdO7Myyj7usmO3hpLxb3Hh8=;
 b=DkmzEKKoUJUBj6DQVNV74uSSxcEgbCPZKrp8pHHygw/rjP5VQKEghe6vmUBBejAmN+
 TVDySTuAsblKq+IkNrrpdK9I1uga403No42xyCj2syOnDAmbrrUHf9l1q5Yw9XWe5SmS
 JBqnOD5QJfaAohm9LsaTxAKpZvFYcRqmHfSiRC4OLQBXFV7/kmT56GKJrdImH4BaWOEI
 4h3EUN2wTcTAeMPMhsLVg0FTVgB00jzqXq9iAEE613YHcCjvxRX9epLz4hTsfoIK2meX
 kKXkYkBEubl3NgWRrTxVy3jIQ73/A+ix3fLdUPn881mjY2IdMuc0gTCQLalAcQwp+MUX
 q6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696482241; x=1697087041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jzEKfXVX0+58rDdXtVzlcdO7Myyj7usmO3hpLxb3Hh8=;
 b=tFa/m22dtKYRkTsPIJEg56RbNxX+YFj/Ohp0quOTp1NTI9j66tnxxEWcbth1mWMP5W
 SLKBAd8rbh+q88Jtb7UaWCOMdCHN0sM4A82T2fphelynpr1GDqU7I9vNhh7PP0kOULFS
 oCjMxvs6Rm5KvOKAy1dqI+Ptc1g19cz6KT++LNbUTfQ1zBWJDpYupXPmngQb4tgSokQ1
 vMNMwhYoj4FQKBQWPFbhTWxnLlP1YCLgAVQYvxusWBeukyBhLNuBmqd+PY577nzeVU2i
 Z8IuO3N7i1A0dlbVK5OvW7Sx0fFXr+4DmYRwwvbWRwXvVMviQ4lxH2msctGliMj5fIiN
 gP7A==
X-Gm-Message-State: AOJu0YxyPXv1EJawZSXVPGlYNXR9M30nRgHJqLJWteHyr8N3K/BPAOcP
 5GrLQ4wCjLjk+NgNXSOOLliu6A==
X-Google-Smtp-Source: AGHT+IEVq6Sqn/U1jiZ6twky0xLJXfPbEcqgPIs2ihAfqOGs1kwQEwsp19S83xZ5zdvGiYn10ewLqw==
X-Received: by 2002:a7b:cd0a:0:b0:405:3ae6:2400 with SMTP id
 f10-20020a7bcd0a000000b004053ae62400mr4137711wmj.23.1696482241429; 
 Wed, 04 Oct 2023 22:04:01 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a05600c219100b0040646a708dasm643947wme.15.2023.10.04.22.03.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 22:04:01 -0700 (PDT)
Message-ID: <344dcdcb-cb10-9cca-df24-5451c444475c@linaro.org>
Date: Thu, 5 Oct 2023 07:03:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/rdma: Deprecate the pvrdma device and the rdma
 subsystem
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Zhijian Li
 <lizhijian@fujitsu.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 libvir-list@redhat.com, Juan Quintela <quintela@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20230927133019.228495-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230927133019.228495-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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

On 27/9/23 15:30, Thomas Huth wrote:
> This subsystem is said to be in a bad shape (see e.g. [1], [2]
> and [3]), and nobody seems to feel responsible to pick up patches
> for this and send them via a pull request. For example there is
> a patch for a CVE-worthy bug posted more than half a year ago [4]
> which has never been merged.
> 
> Quoting Markus: "Given the shape it is in, I wouldn't let friends
> use it in production" - we shouldn't expose this to our users in
> the current state. Thus let's mark it as deprecated and finally
> remove it unless somebody steps up and improves the code quality
> and adds proper regression tests.
> 
> [1] https://lore.kernel.org/qemu-devel/20230918144206.560120-1-armbru@redhat.com/
> [2] https://lore.kernel.org/qemu-devel/ZQnojJOqoFu73995@redhat.com/
> [3] https://lore.kernel.org/qemu-devel/1054981c-e8ae-c676-3b04-eeb030e11f65@tls.msk.ru/
> [4] https://lore.kernel.org/qemu-devel/20230301142926.18686-1-yuval.shaia.ml@gmail.com/
> [5] https://lore.kernel.org/qemu-devel/8734z9f086.fsf@pond.sub.org/
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS               | 2 +-
>   docs/about/deprecated.rst | 8 ++++++++
>   hw/rdma/vmw/pvrdma_main.c | 2 ++
>   3 files changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


