Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8EA7460D0
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:38:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGMYH-0003UX-Q4; Mon, 03 Jul 2023 12:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGMYG-0003UP-49
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGMYE-0007Qt-KN
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 12:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688402240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZVOq3p7WFukWSPmpXzBai66oHNKAACKZAexYm5pM9wE=;
 b=b0f0YMGylQR9adehGvf7HhvXDb5qcd0Nkzzl1l6g9LZFyb/DQG/HvJlorqZ9nJBc8TDZyg
 1LtRDYtV8ylEiQeIw2zHhae7GltkBVePc3hBsaglP1y/gRUdO9iq/BRUOYsyhvQYRrkDa+
 zN+kDP2kkZz+s6s4GD7snzs6NBaywF8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-AcYUnHS9M92tylkQHE1Gtg-1; Mon, 03 Jul 2023 12:37:19 -0400
X-MC-Unique: AcYUnHS9M92tylkQHE1Gtg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-635d9e482f1so47945206d6.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 09:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688402239; x=1690994239;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZVOq3p7WFukWSPmpXzBai66oHNKAACKZAexYm5pM9wE=;
 b=a6zGGiCmHMTzV56mHDVe38/ULPrL1st5wUe1YcEXceti3GGpkuweiXyNNcLAlb9tv9
 fSPfZBgHZDpR9Qbo6geMYVGapUW9EPjNNZ0hIB67nto9NWt9qbLSOXB8KUqDzS+2JSkF
 Nbl0fnQlLPscbBz8zXzlZl01N5GvF5eD8KjnJ9sdVOWr92htfV/YKgTccedV8rV1HPPL
 9dWfBTJFj2E/R+TNgYC5iQy2akNwkSnojj/EyACXn4OSGdF38tS738xCDh//wfmDZH/7
 JHwVFara3SgusR9SfQTIYY8Py3uJXy/qFJL0CVbLODWmujQp7kS9OtAuKi1KsYcm/LQw
 dpSQ==
X-Gm-Message-State: ABy/qLa68skIonpSlez97kh7PGTwKTXJmSFXgJZGKUgsHB/clf4k09E/
 X8YEtddbfa814MuZH+H4m97OPFahiw6fofPFacJDXiP/R7Uq/dp62uLg1O4erR/w0BiDu8DR2tc
 NZ4TCaLgYTM91NnFNox6JOHY=
X-Received: by 2002:ad4:5f0f:0:b0:635:e528:5213 with SMTP id
 fo15-20020ad45f0f000000b00635e5285213mr14425208qvb.23.1688402238942; 
 Mon, 03 Jul 2023 09:37:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHfb9eJhAAjMO42ZbGn3GzsmdFc9gK7NfsPpAzEMYNgyUBdD1/sU3QexjnHEPY47CbM4OWaaQ==
X-Received: by 2002:ad4:5f0f:0:b0:635:e528:5213 with SMTP id
 fo15-20020ad45f0f000000b00635e5285213mr14425195qvb.23.1688402238706; 
 Mon, 03 Jul 2023 09:37:18 -0700 (PDT)
Received: from [192.168.8.101] (tmo-099-133.customers.d1-online.com.
 [80.187.99.133]) by smtp.gmail.com with ESMTPSA id
 l15-20020ad4444f000000b0062439f05b87sm11609465qvt.45.2023.07.03.09.37.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 09:37:18 -0700 (PDT)
Message-ID: <ae60befe-5d36-eb8b-eaae-bd3ec6722b00@redhat.com>
Date: Mon, 3 Jul 2023 18:37:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 00/10] tests/qtest: make migration-test massively faster
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>
References: <20230601161347.1803440-1-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230601161347.1803440-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01/06/2023 18.13, Daniel P. Berrangé wrote:
> This makes migration-test faster by observing that most of the pre-copy
> tests don't need to be doing a live migration. They get sufficient code
> coverage with the guest CPUs paused.
> 
> On my machine this cuts the overall execution time of migration-test
> from 13 minutes, down to 8 minutes, without sacrificing any noticeable
> code coverage.
> 
> Of the tests which do still run in live mode, some need to guarantee
> a certain number of iterions. This is achieved by running the 1
> iteration with an incredibly small bandwidth and max downtime to
> prevent convergance, and watching query-migrate for the reported
> iteration to increment. This guarantees that all the tests take at
> least 30 seconds to run per iteration required.
> 
> Watching for the iteration counter to flip is inefficient and not
> actually needed, except on the final iteration before starting
> convergance. On this final iteration we merely need to prove that
> some amount of already transferred data has been made dirty again.
> This in turn will guarantee that a further iteration is required
> beyond the current one. This proof is easy to achieve by monitoring
> the values at two distinct addresses in guest RAM, and can cut the
> 30 second duration down to 1 second for one of the iterations.
> 
> After this this second optimization the runtime is reduced from
> 8 minutes, down to 1 minute 40 seconds, which is pretty decent given
> the amount of coverage we're getting.

It's now ~1 week until the soft freeze, and the migration test still run for 
~8 minutes. This is still quite annoying. Could we please get one of the 
solutions merged before the soft freeze, either Daniel's or Peter's ?

  Thanks,
   Thomas


