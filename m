Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00ACF717F5B
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:59:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4KSt-0006Je-Jf; Wed, 31 May 2023 07:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1q4KSh-0006JP-HQ
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mzamazal@redhat.com>)
 id 1q4KSe-0004kn-77
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685534271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tQ7SJAlFdq6+ow9jzlSiYdnTTVMD5SM99dx3KG1rTe4=;
 b=J4msMyJaOgkdysluVW0dUOb+bRD46FhElqli6K4tTMCus1vvl7OTRf7WbJp+zl5VXfqEgX
 e2cofTGKw1UVhnYMbQKHMpyrSwUpiFMy0d6u/IEQ4YoGMnnXe8TyQyub4px3KdWRw0VIHk
 Ut82tNKxdhKUFlpQSx4EoaMlvfZ+Pl4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-xVhWtHtmO9K6PKvmazDc4A-1; Wed, 31 May 2023 07:57:47 -0400
X-MC-Unique: xVhWtHtmO9K6PKvmazDc4A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-2f2981b8364so3152736f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 04:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685534266; x=1688126266;
 h=content-transfer-encoding:mime-version:user-agent:message-id
 :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tQ7SJAlFdq6+ow9jzlSiYdnTTVMD5SM99dx3KG1rTe4=;
 b=kx3K22lGmwuaroZZUKCVTHvKGDbp1pk9p+OAmSVlv85nD+8uZTMY+nHWt3l1PxVWNk
 phVGgOmu1wupUnO+F9TKzriyVRvlgJB6lSnkL+F4PRRwrql970fkN7EOxwT39V0h89Yc
 3xoctqCNx+zzeFkW8EsffI6oC0e4D+WNF9qf+5F2JE9DSjK58vb+t1OmB55IYEbZeAZf
 VEecnlgPviRpBlMj8H5wgZSmKYG42n3Ca+TbktCEIbtNSg0p8/NhQTx/BoMjU6ieIGtG
 ZSwyUFdHJaMohUiZqP7WCxGVbuLVqVVGejNjBZQN/8x6GXvJ7lRqiqwxkgvjwnthSVli
 SzUQ==
X-Gm-Message-State: AC+VfDwBQABOKFXhXjoVG1BEQpSxwd5gCBqSKICX1O6b4tT5//pSzJrY
 Zvq/Ghcn7/N6vnbTJsrwW1kBQmo1XxB6FAvcv3V48vth49FeyQmbHygiI4GUz3sceLk13MyTaim
 MlLzIqKNGDJ1aF58=
X-Received: by 2002:a5d:67d1:0:b0:309:3e48:f400 with SMTP id
 n17-20020a5d67d1000000b003093e48f400mr4514267wrw.18.1685534265896; 
 Wed, 31 May 2023 04:57:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Um49mkn+WAU2+eBnwKe7kFwdeAOXl/K4CXV3E2LtN33vyk1nx4URTfNhfs0WZMEPsaR5xng==
X-Received: by 2002:a5d:67d1:0:b0:309:3e48:f400 with SMTP id
 n17-20020a5d67d1000000b003093e48f400mr4514250wrw.18.1685534265488; 
 Wed, 31 May 2023 04:57:45 -0700 (PDT)
Received: from nuthatch (ip-77-48-47-2.net.vodafone.cz. [77.48.47.2])
 by smtp.gmail.com with ESMTPSA id
 d15-20020a056000114f00b0030af72bca98sm4408541wrx.103.2023.05.31.04.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 04:57:44 -0700 (PDT)
From: Milan Zamazal <mzamazal@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,  mst@redhat.com,  stefanha@redhat.com,  Vincent
 Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/4] Add SCMI vhost-user VIRTIO device
References: <cover.1685476786.git.mzamazal@redhat.com>
 <871qiwd9uq.fsf@linaro.org>
Date: Wed, 31 May 2023 13:57:41 +0200
In-Reply-To: <871qiwd9uq.fsf@linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Wed, 31 May 2023 12:19:19 +0100")
Message-ID: <87edmw7lxm.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mzamazal@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Milan Zamazal <mzamazal@redhat.com> writes:
>
>> This patch series adds a vhost-user VIRTIO device for SCMI.
>> It's similar to other similar vhost-user VIRTIO devices.
>>
>> I'm aware of the work in progress by Alex Benn=C3=A9e to simplify simila=
r devices
>> and avoid excessive code duplication.  I think the SCMI device support
>> doesn't bring anything special and it can be rebased on the given work
>> if/once it is merged.
>
> \o/ - I'll try and get the next iteration done in the next few weeks.

Great, looking forward.

> Out of interest have you tested your scmi backend with those patches? Oh
> and also which backend are you using?

I have tested the patches with my proof-of-concept SCMI backend
(emulating a fake sensor) based on rust-vmm and a Linux guest OS.  I
plan to change the prototype into something publishable in the next
weeks and to post patches to rust-vmm/vhost-device.

> Vincent did a bunch of work over the last year or so on SCMI although in
> his case the backend was a RTOS running in a separate domain using some
> shared memory between the SCMI domain and a couple of guests.

I have seen recordings of some related presentations.  The work is
primarily based on crosvm, right?  I'd be interested in what kind of
SCMI interface the domain provides and whether it would make sense to be
able to connect it with the QEMU SCMI device via some vhost-user daemon,
an already existing one, if any, and/or the one I work on.

>> Milan Zamazal (4):
>>   hw/virtio: Add boilerplate for vhost-user-scmi device
>>   hw/virtio: Add vhost-user-scmi-pci boilerplate
>>   tests/qtest: Fix a comment typo in vhost-user-test.c
>>   tests/qtest: enable tests for virtio-scmi
>>
>>  MAINTAINERS                         |   7 +
>>  hw/virtio/Kconfig                   |   5 +
>>  hw/virtio/meson.build               |   2 +
>>  hw/virtio/vhost-user-scmi-pci.c     |  68 +++++++
>>  hw/virtio/vhost-user-scmi.c         | 306 ++++++++++++++++++++++++++++
>>  include/hw/virtio/vhost-user-scmi.h |  30 +++
>>  tests/qtest/libqos/meson.build      |   1 +
>>  tests/qtest/libqos/virtio-scmi.c    | 174 ++++++++++++++++
>>  tests/qtest/libqos/virtio-scmi.h    |  34 ++++
>>  tests/qtest/vhost-user-test.c       |  46 ++++-
>>  10 files changed, 672 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/virtio/vhost-user-scmi-pci.c
>>  create mode 100644 hw/virtio/vhost-user-scmi.c
>>  create mode 100644 include/hw/virtio/vhost-user-scmi.h
>>  create mode 100644 tests/qtest/libqos/virtio-scmi.c
>>  create mode 100644 tests/qtest/libqos/virtio-scmi.h


