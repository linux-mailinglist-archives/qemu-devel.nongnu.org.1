Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA81D7390E1
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 22:38:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC4aR-0000NP-LU; Wed, 21 Jun 2023 16:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC4aB-0008VD-I2
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 16:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC4a7-0000pV-W4
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 16:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687379854;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=SGNt4e9laK8CgTGZPReueyCRkWN+R0nF15NkRMjE5v8=;
 b=GNrS7kMW76Xt5TBZ/9EjXxeQyedB3ld3PmX1LAbsZ8dQnVIcjw8M/Ek+l2NNyo4eyZc6AO
 yRCbzUK+eFbHz4AE1HlRQGa5eDADW0zj4cW//t0lwDd3raAdr1QukE7qMz+hnIqfUXDiLB
 Jc5H7tW2g5cRww8Kpuc/cPWzilY3fWg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-3aNMqSOUPDCiK0PeNkrPlA-1; Wed, 21 Jun 2023 16:37:32 -0400
X-MC-Unique: 3aNMqSOUPDCiK0PeNkrPlA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f7e7cfcae4so34677555e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 13:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687379850; x=1689971850;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGNt4e9laK8CgTGZPReueyCRkWN+R0nF15NkRMjE5v8=;
 b=X9/3f59HPvIPvoeWH/ZUSn68GlhI0OPFmmJvVrbYkjIH93kCmyF36s3As1WH6Gzey2
 CHtb0h0e0pdJ8rOXFiqCdAlUW0muQ7Sg17sOFjt+vxwfsqK2blqYc67G017cSRIMd71V
 ehY0/qByI0vlVHB4x1I64AT3eIgSOk0KfIA7v+mZ44QdkXfK8IdHLecNHlN8f0pUajJv
 srk0qByTmFERCF/3ZoHfuTc3iLkRzZt4IaEDWxCUGtKym0PXC06POU1SbenVqZAMd/Ct
 uBGkh9tQV0jNwTAh5yk0FmqEmVUY/NwDz6QlefQhradbFTAjMhgzzc/IK8t/S0qwLDcv
 TNhg==
X-Gm-Message-State: AC+VfDxINiIAtj1Fn92BNfUR+WZBF+mWxX5HLegT94b5tXuLSA7ZjdqN
 wbWJNhBvBLlcmuVkqEWK1bHfqtmmHpoN0pMHwuvUyRVVlv5bwQOck++aBrSDnZvTegA0TXoG+3l
 By38GjH0WP4kzh6o=
X-Received: by 2002:a7b:ce14:0:b0:3f9:7a15:1716 with SMTP id
 m20-20020a7bce14000000b003f97a151716mr9029797wmc.5.1687379850714; 
 Wed, 21 Jun 2023 13:37:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7mZ1TbPOgz6AZzogWLXb6lQqm580y/AmcT6Tck/xzP1b4Z8VbsvtMPvY4/wVQHHqc5v/v7hw==
X-Received: by 2002:a7b:ce14:0:b0:3f9:7a15:1716 with SMTP id
 m20-20020a7bce14000000b003f97a151716mr9029786wmc.5.1687379850347; 
 Wed, 21 Jun 2023 13:37:30 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 bi20-20020a05600c3d9400b003f7f475c3bcsm78041wmb.1.2023.06.21.13.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 13:37:29 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Yury Kotov
 <yury-kotov@yandex-team.ru>
Subject: Re: [PATCH 12/42] migration-test: Enable back ignore-shared test
In-Reply-To: <ZJNVRQfPRxhbLpfZ@x1n> (Peter Xu's message of "Wed, 21 Jun 2023
 15:53:41 -0400")
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-13-quintela@redhat.com> <ZJHFbgdyd7yj13rp@x1n>
 <87jzvwa9nj.fsf@secure.mitica> <ZJNVRQfPRxhbLpfZ@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 21 Jun 2023 22:37:29 +0200
Message-ID: <87pm5o8sc6.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> On Wed, Jun 21, 2023 at 09:38:08PM +0200, Juan Quintela wrote:
>> Peter Xu <peterx@redhat.com> wrote:
>> > On Fri, Jun 09, 2023 at 12:49:13AM +0200, Juan Quintela wrote:
>> >> It failed on aarch64 tcg, lets see if that is still the case.
>> >> 
>> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> >
>> > According to the history:
>> >
>> > https://lore.kernel.org/all/20190305180635.GA3803@work-vm/
>> >
>> > It's never enabled, and not sure whether Yury followed it up.  Juan: have
>> > you tried it out on aarch64 before enabling it again?  I assume we rely on
>> > the previous patch but that doesn't even sound like aarch64 specific.  I
>> > worry it'll just keep failing on aarch64.

>> On multifd+cancel.
>> 
>> I have no been able to ever get ignore_shared to fail on my machine.
>> But I didn't tested aarch64 TCG in the past so hard, and in x86_64 it
>> has always worked for me.
>
> Thanks a lot, Juan.
>
> Do you mean master is broken with QEMU_TEST_FLAKY_TESTS=1?  And after the
> whole series applied we cannot trigger issue in the few hours test even
> with it?
>
> Shall we wait for another 1-2 days to see whether Yury would comment
> (before you repost)?  Otherwise I agree if it survives your few-hours test
> we should give it a try - at least according to Dave's comment before it
> was failing easily, but it is not now on the test bed.
>
> Maybe it's still just hidden, but in that case I also agree enabling it in
> the repo is the simplest way to reproduce the failure again, if we still
> ever want to enable it one day..

Sending v2.

In that serie both re-enablement of multifd+cancel and ingnore_shared
are the last two patches.

So I am going to wait until all other patches are in and that the people
that complained the most: Peter Maydell, Daniel and Thomas say/test on their
cases.  Hint, Hint.

Later, Juan.


