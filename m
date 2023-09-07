Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 294F17971AF
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 13:23:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeD5F-0000hz-1I; Thu, 07 Sep 2023 07:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qeD59-0000fq-Bw
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qeD55-0001xa-2S
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694085708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5b72p/1fAa021jTeYpCYtgnZXd0XHIxrAMqI4rrNe4E=;
 b=gghmmh/IguHw6iJjNWEXk6NWYIx8V8SqEXv6Kss14GjB/PC1TTMhfxX0hjYTzVux2Qr4Sc
 9DJAYm7dzbcBs1RNRY483SEdHZ7kQzZD0jXLwTd0r5WEhgQlLaLnaBchUQzIySGEvtEfW4
 HkCkf2OQ6aJKO4eRsvkhFcA+csnm384=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-Vbrf9BCANPOM66CYfRA-tg-1; Thu, 07 Sep 2023 07:21:47 -0400
X-MC-Unique: Vbrf9BCANPOM66CYfRA-tg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-978a991c3f5so52060666b.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 04:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694085706; x=1694690506;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5b72p/1fAa021jTeYpCYtgnZXd0XHIxrAMqI4rrNe4E=;
 b=O2sP4Ul0jXGpNE7qxtK7w1XUL38Uc4ejXvKvOhJUHsKD6vwDzgXIp/bUnf8jj69mV4
 UplzNM9JKRxHhrxi9nSf1UrrMz6EvHItS9+d3+/7/3P3PHAMV4IgkFxW+0ohvzUSevn+
 EGzBUkF9Ba7VO3E0UJWpWZwi3E8LSafFiAE3gm5bQxDb2DJAsrcRxcnvNR4XIHnu+j04
 SL+VcNdUrwSA75XgtPAC+k8TlNUMX3Kp8qE8q7iQ7Bq9WavR+y5GjLLhmlkJLt9xRZkb
 2njz56+pN3UyUVkOhKNgf4ZE0OnzUlRMtSYC7TXKelo0Xj1HZoaUEi+1MeXMjGtvWrq+
 TeBA==
X-Gm-Message-State: AOJu0YzVEcfqRfXdL0vLsH7LC69F1oBlG+5bGb7nQbS/rh7BO+p22sZO
 JaQ/JFrVy9GfdFqmoQQxHr129lg0vYbPZSyMTcnb7F80oBeq8DcP3FBI5LX7bL0IXlEIhYXL2d9
 H60B3Dqx58VUNhdMKHv8yIxk=
X-Received: by 2002:a17:906:ef8f:b0:9a9:d5dd:dacd with SMTP id
 ze15-20020a170906ef8f00b009a9d5dddacdmr3243951ejb.26.1694085706184; 
 Thu, 07 Sep 2023 04:21:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlS6z6kiVjtjTLyZGXg7GQEmO/1GKvNeoCUn69R1AEQOfuu8lHf+9zVOvoBTwJeQPk40WXCA==
X-Received: by 2002:a17:906:ef8f:b0:9a9:d5dd:dacd with SMTP id
 ze15-20020a170906ef8f00b009a9d5dddacdmr3243935ejb.26.1694085705879; 
 Thu, 07 Sep 2023 04:21:45 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 j24-20020a170906051800b0099bcdfff7cbsm10227786eja.160.2023.09.07.04.21.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 04:21:45 -0700 (PDT)
Message-ID: <4dfb202f-5bd5-57f9-0aeb-6121b0697a6c@redhat.com>
Date: Thu, 7 Sep 2023 13:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 00/14] Block patches
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20230901081804.31377-1-hreitz@redhat.com>
 <CAJSP0QV4-dR2-2r+4E0N+yWHdzNF0A+FkHGU7Q3uiEg3wxR5Fg@mail.gmail.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJSP0QV4-dR2-2r+4E0N+yWHdzNF0A+FkHGU7Q3uiEg3wxR5Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 06.09.23 15:18, Stefan Hajnoczi wrote:
> On Fri, 1 Sept 2023 at 04:18, Hanna Czenczek <hreitz@redhat.com> wrote:
>> The following changes since commit f5fe7c17ac4e309e47e78f0f9761aebc8d2f2c81:
>>
>>    Merge tag 'pull-tcg-20230823-2' of https://gitlab.com/rth7680/qemu into staging (2023-08-28 16:07:04 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/hreitz/qemu.git tags/pull-block-2023-09-01
> Hi Hanna,
> Please push a signed tag (git tag -s). Thanks!

Is it not signed?  I don’t think gitlab has support to show that, but 
github shows it as verified: 
https://github.com/XanClic/qemu/releases/tag/pull-block-2023-09-01

And when I clone it:
```
$ git clone https://gitlab.com/hreitz/qemu -b pull-block-2023-09-01 
--depth=1
[...]
$ cd qemu
$ git tag -v pull-block-2023-09-01
LANG=C git tag -v pull-block-2023-09-01
object 380448464dd89291cf7fd7434be6c225482a334d
type commit
tag pull-block-2023-09-01
tagger Hanna Reitz <hreitz@redhat.com> 1693555853 +0200

Block patches

- Fix for file-posix's zoning code crashing on I/O errors
- Throttling refactoring
gpg: Signature made Fri Sep  1 10:11:46 2023 CEST
gpg:                using RSA key CB62D7A0EE3829E45F004D34A1FA40D098019CDF
gpg:                issuer "hreitz@redhat.com"
gpg: Good signature from "Hanna Reitz <hreitz@redhat.com>" [ultimate]
Primary key fingerprint: CB62 D7A0 EE38 29E4 5F00  4D34 A1FA 40D0 9801 9CDF
```

Hanna


