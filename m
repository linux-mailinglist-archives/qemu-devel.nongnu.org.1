Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8AC7196ED
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:28:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ebr-0004V2-JJ; Thu, 01 Jun 2023 05:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4ebq-0004Ud-1Z
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4ebn-0006L8-Tn
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685611716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UwcAAnHV+W1SVEWS+4LJaMQw0AVGnecqXHkSUrcuMQE=;
 b=FC//MuQ6M9IqdMOUwZKDskErSm2SQmSDN70POMGZcMrlC/PzwaT0vt5xaNly8/3XgW0am0
 h0jqEHVQM3bfy9PR6JjD4zzP+PZELvirTCeziQKKv7FuOp36Xp5OSTyVeP9U+y4eWCaRGI
 m1S868kOsvrdJAapy1sF3rVflgaTI3g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-k0_7dlxyM8iXFaB-HD61uQ-1; Thu, 01 Jun 2023 05:28:34 -0400
X-MC-Unique: k0_7dlxyM8iXFaB-HD61uQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2af20808e06so5387581fa.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685611713; x=1688203713;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UwcAAnHV+W1SVEWS+4LJaMQw0AVGnecqXHkSUrcuMQE=;
 b=GumLcDvoRQvQVR4KbYrIuF1H3hpp55DyomJMlNB68U5oVs3ylTxRVgDR0NzqTFw030
 MW4mqgHjtgdzbFGoQieCYtv2NxzQKYjS8HsvJ5CxJGOWdrcyKVGK1iy22BfHYXT8ww4b
 1Vm6druAUrSLMaker9o4lz45yZoI9NuIhNJTK6fYKxaQYS09Wip+DxjxtOyZHX8/KOqs
 K8afXc9YmwgE/A0z/dz3imXKK/qDEw3qZf56A4PYR7gC9XKPVZWx++k6SxSESDGQFQKc
 7XHJBhycRlITWlQwqkA3D+LVVjmwwLRpbo/zY1akw66PF0KFnQ5zyMgZ/DKZneWogq7N
 PEXA==
X-Gm-Message-State: AC+VfDz6bHFZJlJRlXECdn7pm9DWejoFfo7D5yfp5Zq0c5VZyABZFTJZ
 XUFlxxKvWTMhNQqhZnPhTr3uzKBtBXm4cDDZsYekWP6MHZWCcERJn+WiAkVI/ZOh1mxzhImFHiU
 LBgDMuiz4hnUPUOU+bn/6Ts8=
X-Received: by 2002:a2e:360e:0:b0:2af:19dd:ecda with SMTP id
 d14-20020a2e360e000000b002af19ddecdamr4211689lja.45.1685611713107; 
 Thu, 01 Jun 2023 02:28:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7uxAhdZFrr7Bza48pAxPV1c4nqmi332NOjsHxRNjsInkdpI3if3x7UwXgLYGDNUIfksd8MLA==
X-Received: by 2002:a2e:360e:0:b0:2af:19dd:ecda with SMTP id
 d14-20020a2e360e000000b002af19ddecdamr4211682lja.45.1685611712836; 
 Thu, 01 Jun 2023 02:28:32 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-86.web.vodafone.de.
 [109.43.178.86]) by smtp.gmail.com with ESMTPSA id
 f1-20020a1c6a01000000b003f423508c6bsm1641576wmc.44.2023.06.01.02.28.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 02:28:32 -0700 (PDT)
Message-ID: <7b9f28cd-86e9-8ab6-50c8-5b11bcce3379@redhat.com>
Date: Thu, 1 Jun 2023 11:28:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 4/9] tests/qtest: get rid of some 'qtest_qmp' usage in
 migration test
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-5-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230531132400.1129576-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31/05/2023 15.23, Daniel P. Berrangé wrote:
> Some of the usage is just a verbose way of re-inventing the
> qtest_qmp_assert_success(_ref) methods.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qtest/migration-helpers.c |  8 ++---
>   tests/qtest/migration-test.c    | 52 ++++++++++++---------------------
>   2 files changed, 21 insertions(+), 39 deletions(-)


Reviewed-by: Thomas Huth <thuth@redhat.com>


