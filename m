Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD66757C4B
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 14:56:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLkEp-0002u8-Q8; Tue, 18 Jul 2023 08:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qLkEn-0002tl-EG
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 08:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1qLkEf-0000rl-Mx
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 08:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689684922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VqHDFEYauDF1gSdZAi3CcoREI8mCFu+ndywIeceN29M=;
 b=T9f870zz/JAImHhmC6g3y5yEyPZOhDTUw4kSNudgGBf8Es1j12RrhnHVBCr8QTmn9rSypC
 OoA6xqr7rxnswkpqO6ZcqDo0Ma6x1PeabkD7tjFOdLjUi83v2oF+f2PfFfZ4k5XCyU0YOH
 1XucyHIlRHnSjOHVvMMfpmo5aGGlutA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-z9N7aFaIOyKC48kMtBcxGQ-1; Tue, 18 Jul 2023 08:55:20 -0400
X-MC-Unique: z9N7aFaIOyKC48kMtBcxGQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51836731bfbso3616466a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 05:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689684919; x=1692276919;
 h=mime-version:user-agent:message-id:in-reply-to:date:references
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VqHDFEYauDF1gSdZAi3CcoREI8mCFu+ndywIeceN29M=;
 b=V3cx4Tj5nZheHypy1xJQiAcDlkyDgI14JrQnIcob1uvYWVmVHwPWO1GMq/PaDjd+tl
 kWzVJO8LIO2U2BlUVEpdFXhrXs2jQhPu2Bow+mhWbDaSKj0D5T0BHSVeRUnxZ77jSAHg
 TOqDg0INXUeiqmBCr8+6N6V/H88Zsb88u51XuMx5LqblVfF9/qw4qLRU6zzHlRy5wcd4
 LTCMgyHxU7pvtPkTHoAnBGDjyHhUzydgnFZeyDJAh3Fqnt4DsUlBcEyPUpk8ngTh0PvE
 9JOckMg/pDlPw18DoR85V2RX/rZZ8rDZFOxeismk9CnC6+Krv3L1L6L+rqjL0CugsF6D
 0ToA==
X-Gm-Message-State: ABy/qLZIqvMHH7SwO15IjrlW1yvpbzBw5cj6U89yBP0Rp669ToU3ZDyW
 v91eXiEmp3FdSDQm5GypTMLWDAAgP8jjRvdRxhIuYeeD7r67LlF0aNPVeBwQl9DKIuXtusEKE9M
 6ViWkxF3jaNGq3WE=
X-Received: by 2002:aa7:d751:0:b0:51f:e92a:62ba with SMTP id
 a17-20020aa7d751000000b0051fe92a62bamr12570841eds.9.1689684919207; 
 Tue, 18 Jul 2023 05:55:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHeuLmHqeA4yMEbWA3u+q/x8xVxrNH3GB/EeBEXAH3yxNyxAFx4FMojd1SwNscBFoO4OyMbDw==
X-Received: by 2002:aa7:d751:0:b0:51f:e92a:62ba with SMTP id
 a17-20020aa7d751000000b0051fe92a62bamr12570827eds.9.1689684918920; 
 Tue, 18 Jul 2023 05:55:18 -0700 (PDT)
Received: from nuthatch (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 t2-20020a05640203c200b0051debcb1fa2sm1203156edw.69.2023.07.18.05.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 05:55:18 -0700 (PDT)
From: Milan Zamazal <mzamazal@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  qemu-devel@nongnu.org,  Peter
 Maydell <peter.maydell@linaro.org>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PULL 10/66] tests/qtest: enable tests for virtio-scmi
References: <cover.1689030052.git.mst@redhat.com>
 <b6f53ae005a1c05034769beebf799e861b82d48a.1689030052.git.mst@redhat.com>
 <22589b2f-8dcf-b86b-2d77-bf27bf81ce27@redhat.com>
Date: Tue, 18 Jul 2023 14:55:17 +0200
In-Reply-To: <22589b2f-8dcf-b86b-2d77-bf27bf81ce27@redhat.com> (Thomas Huth's
 message of "Tue, 18 Jul 2023 14:42:01 +0200")
Message-ID: <87pm4pcrbe.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mzamazal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> On 11/07/2023 01.02, Michael S. Tsirkin wrote:
>> From: Milan Zamazal <mzamazal@redhat.com>
>> We don't have a virtio-scmi implementation in QEMU and only support
>
>> a
>> vhost-user backend.  This is very similar to virtio-gpio and we add the same
>> set of tests, just passing some vhost-user messages over the control socket.
>> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
>> Acked-by: Thomas Huth <thuth@redhat.com>
>> Message-Id: <20230628100524.342666-4-mzamazal@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>   tests/qtest/libqos/virtio-scmi.h |  34 ++++++
>>   tests/qtest/libqos/virtio-scmi.c | 174 +++++++++++++++++++++++++++++++
>>   tests/qtest/vhost-user-test.c    |  44 ++++++++
>>   MAINTAINERS                      |   1 +
>>   tests/qtest/libqos/meson.build   |   1 +
>>   5 files changed, 254 insertions(+)
>>   create mode 100644 tests/qtest/libqos/virtio-scmi.h
>>   create mode 100644 tests/qtest/libqos/virtio-scmi.c
>
>  Hi!
>
> I'm seeing some random failures with this new scmi test, so far only
> on non-x86 systems, e.g.:
>
>  https://app.travis-ci.com/github/huth/qemu/jobs/606246131#L4774
>
> It also reproduces on a s390x host here, but only if I run "make check
> -j$(nproc)" - if I run the tests single-threaded, the qos-test passes
> there. Seems like there is a race somewhere in this test?

Hmm, it's basically the same as virtio-gpio.c test, so it should be OK.
Is it possible that the two tests (virtio-gpio.c & virtio-scmi.c)
interfere with each other in some way?  Is there possibly a way to
serialize them to check?

> No clue how to debug this, but since it currently only happens on
> non-x86 architectures, maybe we should limit it to x86 hosts for now?
>
>  Thomas


