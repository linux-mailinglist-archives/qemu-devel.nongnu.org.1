Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA607508E7
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 14:56:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJZNH-0006LI-3z; Wed, 12 Jul 2023 08:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJZNF-0006L9-BL
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 08:55:17 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJZND-0006Hd-O5
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 08:55:17 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99364ae9596so873860566b.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689166513; x=1691758513;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dMkLLusJCWTr2QprFGeuukjN3gmfhrFCZhU+JwpjdIk=;
 b=aswEC1Ffmbp7S5Uz8NHV7o3U5pdag+CEkXj2t1i+ZaPhyeCOOToV8jBixyCzLf2W8b
 /jg025RTYsFbcjVmN+HrjRQszUgLqgsgsakWSZ9labAJNv7i6qC06crBbBcnGxwC0kpE
 dro6uKXrUi6iS+w4fQPLYL8CzWbnvTFAUrua1qWmG7GpAlGNOHTCE1JdAN0FM/rH5wA6
 8yFM4j641RkKZU8gr0qaEnajW6VhVOYdfVmRB5oL96nrvgffa5N39IaLu4uPlcrMisnK
 cnjPihoOnzoxwCkaSEunzb4Tg3Czw9mZzdN8I9L/yZ4iXX3LUfTSAf//JvaN5QCLVV6g
 QMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689166513; x=1691758513;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dMkLLusJCWTr2QprFGeuukjN3gmfhrFCZhU+JwpjdIk=;
 b=D/9tHDb/DIAjqfYWAB8yxDOJjMtvyMxRHmdzzge0HjHGH8KSX23GwYEwGMqhKfvIai
 oVDO+cHE4NJVe9xRTRUxEhox2zyauOZzYBMeFAHqBtf/MjenfMf0zJEFT/zXzmvNswS7
 CdGy3F1B9nYm3PxIgxWuUSR6O9SW9QYGU/2x8BkWZH2CQjdPgBS4xdbH05ZgJ6QTI1Cq
 EcoqKiKkFZXjwIV8LuN6AydxQZYw6xZThcg4saDt6RuOaYE94BpvH1HwfnNNm93Urk77
 Q4oMvYGnM4Q9OlNER/Y7HtdkFfWaaiCSLLyAKVAp7n5k93oEjvkeWwiOE/GE12OyJNO3
 Zmag==
X-Gm-Message-State: ABy/qLawLkpPGI6/VhkKzJzAAvJ92KjlH8xtsWU1dfy+n3Yh7qTsMwa2
 gQJXHuqrjDZOXYneRqCNeWImvQ==
X-Google-Smtp-Source: APBJJlF8tG9H2y/gRmex8u914PK3qcnvN6hbhay/uTBs8/8Z6bOgWpoxexoK8/OaDxJWWa9qI89fTQ==
X-Received: by 2002:a17:906:2249:b0:993:eef2:5d61 with SMTP id
 9-20020a170906224900b00993eef25d61mr12538457ejr.27.1689166512852; 
 Wed, 12 Jul 2023 05:55:12 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.150.242])
 by smtp.gmail.com with ESMTPSA id
 sd6-20020a170906ce2600b0099275c59bc9sm2540822ejb.33.2023.07.12.05.55.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 05:55:12 -0700 (PDT)
Message-ID: <30d49562-451e-b4c6-679e-0f8d1e0abe72@linaro.org>
Date: Wed, 12 Jul 2023 14:55:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/4] tests/lcitool: Refresh generated files
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Erik Skultety <eskultet@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>
References: <20230711144922.67491-1-philmd@linaro.org>
 <20230711144922.67491-3-philmd@linaro.org> <ZK2YS0v5G3iKyXwJ@redhat.com>
 <41ae7db7-8d80-1749-c89d-025ee30bd73d@linaro.org>
 <ZK6Kn8hB8soQBRsA@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZK6Kn8hB8soQBRsA@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
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

On 12/7/23 13:12, Daniel P. Berrangé wrote:
> On Wed, Jul 12, 2023 at 01:00:38PM +0200, Philippe Mathieu-Daudé wrote:
>> On 11/7/23 19:58, Daniel P. Berrangé wrote:
>>> On Tue, Jul 11, 2023 at 04:49:20PM +0200, Philippe Mathieu-Daudé wrote:
>>>> Refresh the generated files by running:
>>>>
>>>>     $ make lcitool-refresh
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    tests/docker/dockerfiles/debian-amd64.docker |  2 -
>>>>    tests/docker/dockerfiles/ubuntu2004.docker   |  2 -
>>>>    tests/docker/dockerfiles/ubuntu2204.docker   |  2 -
>>>
>>> I don't know why this would be removing xen/pmem from these files. If
>>> I run 'lcitool-refresh' on current git master that doesn't happen
>>>
>>> Do you have any other local changes on top ?

(I just noticed manually updating the libvirt-ci submodule is
  pointless because the 'lcitool-refresh' rule does that)

>> diff --git a/tests/docker/dockerfiles/ubuntu2204.docker
>> b/tests/docker/dockerfiles/ubuntu2204.docker
>> index 1d442cdfe6..5162927016 100644
>> --- a/tests/docker/dockerfiles/ubuntu2204.docker
>> +++ b/tests/docker/dockerfiles/ubuntu2204.docker
>> @@ -73 +72,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>> -                      libpmem-dev \
>> @@ -99 +97,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>> -                      libxen-dev \
> 
> What architecture are you running from ? I'm suspecting it is a non
> x86_64 architecture as these pacakges are both arch conditionalized.

My host is Darwin aarch64, but how is this relevant to what we
generate for guests? Are we missing specifying the target arch
somewhere? (This is not the '--cross-arch' argument, because we
don't want to cross-build). These dockerfiles always targeted x86_64,
in particular the debian-amd64.docker one...

