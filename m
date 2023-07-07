Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F26374AEBB
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 12:29:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHigx-0004mv-VF; Fri, 07 Jul 2023 06:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qHigt-0004mf-Gl
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qHigr-0004ve-NM
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688725671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54p/PmWGHWokTtblzt6CfBjeUnBZM3+DK3iF3H3NqGI=;
 b=TAMk+LyLCCqxa1dVMNDzJsJfw+1MxhHdBtVPWpbSm64MEZBLWXiLeSLHF4CWdE0EoxTbCU
 5vyNqDtpGNu3X23h51lYWVd1Wesb0+p6aRm4t+ujj3BYqN00MKEoJd7u2/q9fIkq3EVywA
 FBPMXwhh3+ajzlCya4SpXvtCxzCKCIk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-KY7U-9d0MmSA8nZxtX5KbQ-1; Fri, 07 Jul 2023 06:27:50 -0400
X-MC-Unique: KY7U-9d0MmSA8nZxtX5KbQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4033e4d51ecso18629201cf.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 03:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688725669; x=1691317669;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=54p/PmWGHWokTtblzt6CfBjeUnBZM3+DK3iF3H3NqGI=;
 b=A0H5Err/qSukSp7KVue1Zg3D3++wXfNTT+khUwSt+aem+t+/2qdRhAS20xJkKYhCjx
 +9ggBUdOwiShSXePHZ9L7bcDYs3IOm78r/XwtzlGQWnrN7393/JPEU71OkHNppj64jdu
 q6LQcQ4YqFvuC6qPHoi45ZibmarR0kLC8nYhEVwOdZMIx7v63685zYbj64c7eqMxWEw+
 XQnZzzM9lwxykscUl7t0KnePiiMbPH9xuqe6yL3dyEUthjAu31TwtueTiEixKHqW4IeQ
 jl4IByS51ZJBDMQaGyvwTDjf/BrZVeUVgyjpKqpGxeYYGUFSRvfV+4Nqlw7QB/Vy33m5
 9vBA==
X-Gm-Message-State: ABy/qLZp52QijhcnLruqfowT/R7yb/mWFwzMQvRxXAg116TV7Wm+F2rE
 9oMlVU837YiU/oAhuzD4HhiW6QWi1zJI8oGs1qs2R/yES71f2d1hLmc7ybFNrElTCLzslTd8dJI
 UmqvVEkrfQKPskPQ=
X-Received: by 2002:ac8:5895:0:b0:3f4:e1b4:e45 with SMTP id
 t21-20020ac85895000000b003f4e1b40e45mr4850611qta.60.1688725669600; 
 Fri, 07 Jul 2023 03:27:49 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH6b+U3LMgCwW3PWA8NX5vI6q/KHQchzLhLkXTI9jlf/a9KUVhIkJHlnxLCF+fl4NpyVvg5Iw==
X-Received: by 2002:ac8:5895:0:b0:3f4:e1b4:e45 with SMTP id
 t21-20020ac85895000000b003f4e1b40e45mr4850601qta.60.1688725669338; 
 Fri, 07 Jul 2023 03:27:49 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-163.retail.telecomitalia.it.
 [79.46.200.163]) by smtp.gmail.com with ESMTPSA id
 r12-20020a05620a03cc00b0076750a5503csm1680841qkm.63.2023.07.07.03.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 03:27:48 -0700 (PDT)
Date: Fri, 7 Jul 2023 12:27:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com, 
 mst@redhat.com, marcandre.lureau@redhat.com, stefanha@redhat.com, 
 viresh.kumar@linaro.org, takahiro.akashi@linaro.org, erik.schilling@linaro.org,
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Subject: Re: [virtio-dev] [RFC PATCH] docs/interop: define STANDALONE
 protocol feature for vhost-user
Message-ID: <qmwvywoy7lfkgr7kcc6cxghulgd5g2gvnv76mvkuxbqclbwmti@4qyiktfiu2ej>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <3ogh7u3ezp7vlrp3ticquoajgsnpnglplm44osrsd7gvxv2lyn@g22qgf4vwgp5>
 <87o7krg0sn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o7krg0sn.fsf@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Tue, Jul 04, 2023 at 04:02:42PM +0100, Alex Bennée wrote:
>
>Stefano Garzarella <sgarzare@redhat.com> writes:
>
>> On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Bennée wrote:
>>>Currently QEMU has to know some details about the back-end to be able
>>>to setup the guest. While various parts of the setup can be delegated
>>>to the backend (for example config handling) this is a very piecemeal
>>>approach.
>>>
>>>This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
>>>which the back-end can advertise which allows a probe message to be
>>>sent to get all the details QEMU needs to know in one message.
>>>
>>>Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>
>>>---
>>>Initial RFC for discussion. I intend to prototype this work with QEMU
>>>and one of the rust-vmm vhost-user daemons.
>>
>> Thanks for starting this discussion!
>>
>> I'm comparing with vhost-vdpa IOCTLs, so my questions may be
>> superficial, but they help me understand the differences.
>
>I did have a quick read-through to get a handle on vhost-vdpa but the
>docs are fairly empty. However I see there is more detail in the linux
>commit so after looking at that I do wonder:
>
> * The kernel commit defines a subset of VIRTIO_F feature flags. Should
>   we do the same for this interface?

Sorry, I didn't get this.

Do you mean that the kernel is filtering some features?
Or are you talking about backend features?

>
> * The VDPA GET/SET STATUS and GET/SET CONFIG ioctls are already covered
>   by the equivalent VHOST_USER messages?

Yep, I think so.

>
>>>---
>>> docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
>>> hw/virtio/vhost-user.c      |  8 ++++++++
>>> 2 files changed, 45 insertions(+)
>>>
>>>diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>>>index 5a070adbc1..85b1b1583a 100644
>>>--- a/docs/interop/vhost-user.rst
>>>+++ b/docs/interop/vhost-user.rst
>>>@@ -275,6 +275,21 @@ Inflight description
>>>
>>> :queue size: a 16-bit size of virtqueues
>>>
>>>+Backend specifications
>>>+^^^^^^^^^^^^^^^^^^^^^^
>>>+
>>>++-----------+-------------+------------+------------+
>>>+| device id | config size |   min_vqs  |   max_vqs  |
>>>++-----------+-------------+------------+------------+
>>>+
>>>+:device id: a 32-bit value holding the VirtIO device ID
>>>+
>>>+:config size: a 32-bit value holding the config size (see ``VHOST_USER_GET_CONFIG``)
>>>+
>>>+:min_vqs: a 32-bit value holding the minimum number of vqs supported
>>
>> Why do we need the minimum?
>
>We need to know the minimum number because some devices have fixed VQs
>that must be present.

But does QEMU need to know this?

Or is it okay that the driver will then fail in the guest if there
are not the right number of queues?

>
>>
>>>+
>>>+:max_vqs: a 32-bit value holding the maximum number of vqs supported, must be >= min_vqs
>>
>> Is this overlap with VHOST_USER_GET_QUEUE_NUM?
>
>Yes it does and I considered implementing a bunch of messages to fill in
>around what we already have. However that seemed like it would add a
>bunch of complexity to the interface when we could get all the initial
>data in one go.

Yes I understand, though if we need to add new things to return in the
future how do we do it? Do we need to provide features for this
structure?

>
>>
>>>+
>>> C structure
>>> -----------
>>>
>>>@@ -296,6 +311,7 @@ In QEMU the vhost-user message is implemented with the following struct:
>>>           VhostUserConfig config;
>>>           VhostUserVringArea area;
>>>           VhostUserInflight inflight;
>>>+          VhostUserBackendSpecs specs;
>>>       };
>>>   } QEMU_PACKED VhostUserMsg;
>>>
>>>@@ -316,6 +332,7 @@ replies. Here is a list of the ones that do:
>>> * ``VHOST_USER_GET_VRING_BASE``
>>> * ``VHOST_USER_SET_LOG_BASE`` (if ``VHOST_USER_PROTOCOL_F_LOG_SHMFD``)
>>> * ``VHOST_USER_GET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
>>>+* ``VHOST_USER_GET_BACKEND_SPECS`` (if ``VHOST_USER_PROTOCOL_F_STANDALONE``)
>>>
>>> .. seealso::
>>>
>>>@@ -885,6 +902,13 @@ Protocol features
>>>   #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>>>   #define VHOST_USER_PROTOCOL_F_STATUS               16
>>>   #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>>>+  #define VHOST_USER_PROTOCOL_F_STANDALONE           18
>>>+
>>>+Some features are only valid in the presence of other supporting
>>>+features. In the case of ``VHOST_USER_PROTOCOL_F_STANDALONE`` the
>>>+backend must also support ``VHOST_USER_PROTOCOL_F_CONFIG`` and
>>>+``VHOST_USER_PROTOCOL_F_STATUS``.
>>>+
>>
>> What about adding a new section where we will describe what we mean
>> with "standalone" devices?
>>
>> For example that the entire virtio device is emulated in the backend,
>> etc.
>>
>> By the way, I was thinking more about F_FULL_DEVICE, but I'm not good
>> with names, so I'll just throw out an idea :-)
>
>Naming things is hard ;-)

I know :-)

>
>I could add a new section although AIUI there is nothing really in
>existing daemons which is split between the front-end and back-end. The
>stubs are basically boilerplate and ensure DT/PCIe hubs make the device
>appear so once things are discovered QEMU never really gets involved
>aside from being a dumb relay.

For the backend I don't think there is much to say, but for the frontend
it changes a lot in my opinion if this new feature is supported, since
we basically offlaod the whole virtio device to the external process.

Thanks,
Stefano


