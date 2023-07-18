Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE97E757C02
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 14:42:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLk1z-0005fd-1x; Tue, 18 Jul 2023 08:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLk1r-0005Zh-Sj
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 08:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLk1p-0004XB-LU
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 08:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689684127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Nej6pf+K5dYVvr8g80uz0W16SSPpHOWIMmgR8YYcYs=;
 b=bIAF81xbcGxJ+CzxsA67/tVmX1n3ihA91BaZHXMF+72KkLlMA0TA1MtDQY7DLSTDtNDeRy
 Oieae+A6m4oHxC5/17Z68Hwe8V+Vp4goYY11pZFBun+Rc0lLOaiQIyRlqytXUFJ9wLb5uu
 eRC7VU2O50JGDV2mtjh0dCmMWWwpRSo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-Bhe4bCjOOaeDx0D9pRU1tQ-1; Tue, 18 Jul 2023 08:42:05 -0400
X-MC-Unique: Bhe4bCjOOaeDx0D9pRU1tQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-403aa344d39so53749321cf.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 05:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689684125; x=1692276125;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5Nej6pf+K5dYVvr8g80uz0W16SSPpHOWIMmgR8YYcYs=;
 b=LXXbd/I50QbkQge0D5BsCRmWzm7kMWScCNc0Kv0NtvWhV44/4rIv2sMdnNZg8U7/nq
 26eeNedH8yFNIEncRL4YNjDtliZGakK6zTsC2CnFsoL9fk340JH7EM2/s5Ld488Bb6ap
 tBMBXQq+Ub5HClkuFWNNE1pyu2UH/661WcU7bAVigQ3sR2phwSCmVUQms6WVt/smHZOG
 Xh7E1DqZW86eSxZiVoRvyfZTXG8r2rq1g+WOWJh9QNroNU6kiLfcN0zRXoK0T1zR9/gB
 +nAkjj9iWeDbIPEsS2whxYOfJSciZC537vOPfM7NLEqlVYxmx1dcYxAVUjUbPKJ4cEyI
 7H6Q==
X-Gm-Message-State: ABy/qLa4s7rgEKLQlQHFTAL5cS9fQ4CvDAtZdP6D0JgsopadnazxbU44
 vgToRQTipRZN3aRtDOLYPsb0D1PRMbCJRHnZElq7PEDVCB4xHTwErORDtPtot7FZQpH3Mso8BhB
 jQJELK7y8ru1HRp4=
X-Received: by 2002:ac8:7c4e:0:b0:400:7bb9:45cb with SMTP id
 o14-20020ac87c4e000000b004007bb945cbmr17591129qtv.27.1689684125304; 
 Tue, 18 Jul 2023 05:42:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0t5sLVfR7lPZ73GSZevGuKOQLy0BFy6biWOH+Lxo5/Uh92kEgtyjVcHy7criEr8JPtQhWpw==
X-Received: by 2002:ac8:7c4e:0:b0:400:7bb9:45cb with SMTP id
 o14-20020ac87c4e000000b004007bb945cbmr17591111qtv.27.1689684125072; 
 Tue, 18 Jul 2023 05:42:05 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-122.web.vodafone.de.
 [109.43.177.122]) by smtp.gmail.com with ESMTPSA id
 d16-20020ac851d0000000b00401f7f23ab6sm602429qtn.85.2023.07.18.05.42.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jul 2023 05:42:04 -0700 (PDT)
Message-ID: <22589b2f-8dcf-b86b-2d77-bf27bf81ce27@redhat.com>
Date: Tue, 18 Jul 2023 14:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Milan Zamazal <mzamazal@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <cover.1689030052.git.mst@redhat.com>
 <b6f53ae005a1c05034769beebf799e861b82d48a.1689030052.git.mst@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 10/66] tests/qtest: enable tests for virtio-scmi
In-Reply-To: <b6f53ae005a1c05034769beebf799e861b82d48a.1689030052.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 11/07/2023 01.02, Michael S. Tsirkin wrote:
> From: Milan Zamazal <mzamazal@redhat.com>
> 
> We don't have a virtio-scmi implementation in QEMU and only support a
> vhost-user backend.  This is very similar to virtio-gpio and we add the same
> set of tests, just passing some vhost-user messages over the control socket.
> 
> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20230628100524.342666-4-mzamazal@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   tests/qtest/libqos/virtio-scmi.h |  34 ++++++
>   tests/qtest/libqos/virtio-scmi.c | 174 +++++++++++++++++++++++++++++++
>   tests/qtest/vhost-user-test.c    |  44 ++++++++
>   MAINTAINERS                      |   1 +
>   tests/qtest/libqos/meson.build   |   1 +
>   5 files changed, 254 insertions(+)
>   create mode 100644 tests/qtest/libqos/virtio-scmi.h
>   create mode 100644 tests/qtest/libqos/virtio-scmi.c

  Hi!

I'm seeing some random failures with this new scmi test, so far only on 
non-x86 systems, e.g.:

  https://app.travis-ci.com/github/huth/qemu/jobs/606246131#L4774

It also reproduces on a s390x host here, but only if I run "make check 
-j$(nproc)" - if I run the tests single-threaded, the qos-test passes there. 
Seems like there is a race somewhere in this test?

No clue how to debug this, but since it currently only happens on non-x86 
architectures, maybe we should limit it to x86 hosts for now?

  Thomas


