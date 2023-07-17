Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBD8756299
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:20:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNBh-0005fp-3W; Mon, 17 Jul 2023 08:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLNBe-0005fM-Al
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLNBc-0001Pu-7C
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689596322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FBPWwQ9W+vt1PHf0dWwihMeUEvg1WmV3Zjxkv0QOVRs=;
 b=TXN1dwJRiW0aonIN7PR+ydWypPsvfC/NVNk8pQ8ZWaxCb7hTg9OLdZYdjF0JNZ5IEfQXot
 6n/e9LcLlbBIdT3OoqJmwRunJtaO0fRq9dIC9zsfBmhpsJTOrldwluALiSpbt1xkNNBTlV
 VupK3ZdQHlkxvKp1OB/Ic5gVNX05AfY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-z2A5nFjzOn2g1281bqPNDQ-1; Mon, 17 Jul 2023 08:18:39 -0400
X-MC-Unique: z2A5nFjzOn2g1281bqPNDQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7682705c039so22590385a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 05:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689596318; x=1692188318;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FBPWwQ9W+vt1PHf0dWwihMeUEvg1WmV3Zjxkv0QOVRs=;
 b=NCBA8xHsgG5WYhSUzJHdCJLFB1BNOBiMmcawfAYvvIJAjbY28n6u5esoZXxVe2iSEu
 At9PiJ0YcgadMJB05fMBFkqooI5EC4yMJ1k3IuIGMF5jiYZxZ/xL5iqhbExm9M5Xv4B/
 1IxhJHA4ckvRRGQvUYHS+6GJCN3zePEQGUqudFIq3KmR8iDPhisMeXrVie4cmkj0ajPi
 Te/YYDt5F7BqpJAg/4/eyzfiY16fiUeeKfnw/HTU99r7nNApHlcgT7V5aUaSbfJxLjpJ
 icwM3SUVVbJZJw3e3EQUAtCXwF9ui45W5+oPKAJ8kTte1BpoRRnkxCAYXifnc+MPs1Ux
 KChQ==
X-Gm-Message-State: ABy/qLb79V7zFFuNCL7cnFrRjOENN2Mr0v6L5b+wakINH1rKnF3W1h7S
 VJ0vOrcM4yYsUjo0YzL71mtGh9XAHSMu+8/+S4mi6KntGdRirS9IdOXTMjgJRvuZZVbgU8ygpj1
 GQNobXg9cIDJWqn8=
X-Received: by 2002:a05:620a:1a8e:b0:767:dbe5:1f2f with SMTP id
 bl14-20020a05620a1a8e00b00767dbe51f2fmr14414147qkb.35.1689596318602; 
 Mon, 17 Jul 2023 05:18:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF+QhJkmkSqY6ZD6Z/w58ABBYfLrgO9TUVT63AX+sflaNxSeuFecURo7i1fpBbD9KSMhhDB+Q==
X-Received: by 2002:a05:620a:1a8e:b0:767:dbe5:1f2f with SMTP id
 bl14-20020a05620a1a8e00b00767dbe51f2fmr14414120qkb.35.1689596318244; 
 Mon, 17 Jul 2023 05:18:38 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-137.web.vodafone.de.
 [109.43.177.137]) by smtp.gmail.com with ESMTPSA id
 o12-20020a05620a130c00b007339c5114a9sm6052850qkj.103.2023.07.17.05.18.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 05:18:37 -0700 (PDT)
Message-ID: <96e8c829-74fe-f5ce-0fb0-26de60b9416e@redhat.com>
Date: Mon, 17 Jul 2023 14:18:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>
References: <20230711144922.67491-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 0/4] tests/vm/freebsd: Get up-to-date package list from
 lcitool
In-Reply-To: <20230711144922.67491-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.097, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 11/07/2023 16.49, Philippe Mathieu-Daudé wrote:
> Inspired by this patch from Thomas:
> https://lore.kernel.org/qemu-devel/20230531090415.40421-1-thuth@redhat.com/
> 
> Instead of updating the package list manually, use lcitool vars file.
> 
> Since v2:
> - Commit generated json (Daniel)
> 
> Since v1:
> - Addressed Erik & Daniel comments (generate in JSON)
> 
> Philippe Mathieu-Daudé (4):
>    tests/lcitool: Generate distribution packages list in JSON format
>    tests/lcitool: Refresh generated files
>    tests/vm: Introduce get_qemu_packages_from_lcitool_json() helper
>    tests/vm/freebsd: Get up-to-date package list from lcitool vars file
> 
>   tests/docker/dockerfiles/debian-amd64.docker |  2 -
>   tests/docker/dockerfiles/ubuntu2004.docker   |  2 -
>   tests/docker/dockerfiles/ubuntu2204.docker   |  2 -

Thanks, I'm queuing your patches for my next pull request - but I'm dropping 
the hunks that change libpmem-dev and libxen-dev in the docker files - 
otherwise this would just get reverted once somebody using a x86 host runs 
the refresh step again. I hope this issue can be tackled by a future lcitool 
update instead.

  Thomas


