Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B989B988
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Apr 2024 09:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtju5-0005si-EB; Mon, 08 Apr 2024 03:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rtju2-0005ry-Kk
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rtjtz-0005QC-ML
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712563130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YnoJj8U5XLHYFICcKVyTvDINlgNIYWcz1do88abojoA=;
 b=hft2/5PnEm1tz09yyY5KWlQ63/ITCD2hkBiCnJITcghEIYvVvefIioCd3PWqIQhd+Tp6rG
 Komwufz898DFkUc9WZulj8B+3n6HCrL3PggEBTWjuWpARRX0m2GUFeoNIrRgjsyKn3bmcd
 DH4t5aSRHr1SOUs7CNHqjPY3MThXVsA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-ILBkGKuPOR23A21DQhHe2w-1; Mon, 08 Apr 2024 03:58:47 -0400
X-MC-Unique: ILBkGKuPOR23A21DQhHe2w-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-69941ace2d9so23102176d6.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 00:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712563127; x=1713167927;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YnoJj8U5XLHYFICcKVyTvDINlgNIYWcz1do88abojoA=;
 b=f4veR/z/79GBmN+iKglnuU1B4lOIVb5Mmg9j5Wukq6TzdhBW1eK2YA2wNNnRCSnAhN
 QwC7Y1JKwods0KHs3t4G1nDbm6o+yBmtpKUE3gTpq6yYHrLw8iA39XXbDqy9enKqmtXJ
 EvDc3TPhmTuUpUU2JxN4Fdv42+1pDMACcYRiZCgJUQJw7morBCp3LUCuM3ppahXEHHsZ
 ocmjxZf26foKgJjNgcuQS7KdrGlqc8BKjQnnRwW+US4LPNJegWl7ULQRtRnK0fEDXEMh
 xmF9LV1OA+KGHTMIHDfuU1X7gXQHj7OdEYzbbkCBF7W6ZeDB3Ip1qN3dWMZSt3d6pwNb
 rZdg==
X-Gm-Message-State: AOJu0YxitECtJsd2wI0ONmv6qh/bNIM1T7nfTwncU12FmoLvh0lLGYWI
 QW3g7dHxKo+GSsZU0AVCMDmGaxCzwI+o67Of7D1SJPwq0Y2C/xYGcBe0KnVwyZNYQfEWP1fLc1V
 w+A3jAdXH/T0EJcemxj77/2B5ikLI44KTR2mEAj3mPWpiJYAz3g8k
X-Received: by 2002:ad4:5763:0:b0:699:15b3:efd2 with SMTP id
 r3-20020ad45763000000b0069915b3efd2mr9199949qvx.3.1712563127265; 
 Mon, 08 Apr 2024 00:58:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHidCLWRM6RZdS96SB4j8Us1snPlUbs9kzgK9/64/ns6bSSUszOgo4diDf8Sdo+DnFkF1M1ZQ==
X-Received: by 2002:ad4:5763:0:b0:699:15b3:efd2 with SMTP id
 r3-20020ad45763000000b0069915b3efd2mr9199941qvx.3.1712563126970; 
 Mon, 08 Apr 2024 00:58:46 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.101.253])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a0cf2c8000000b00698f7eb9997sm2979693qvm.54.2024.04.08.00.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 00:58:46 -0700 (PDT)
Date: Mon, 8 Apr 2024 09:58:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com, 
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 gmaglione@redhat.com, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH for-9.1 v3 09/11] hostmem: add a new memory backend based
 on POSIX shm_open()
Message-ID: <gs6o25gxe22j3uptywtadcujnwqexfgc3drthrgzn44m44pder@zugei2amphni>
References: <20240404122330.92710-1-sgarzare@redhat.com>
 <20240404122330.92710-10-sgarzare@redhat.com>
 <c5c89a6e-adf7-4f25-b9b5-2979e4367dfd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c5c89a6e-adf7-4f25-b9b5-2979e4367dfd@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Apr 04, 2024 at 04:09:34PM +0200, David Hildenbrand wrote:
>On 04.04.24 14:23, Stefano Garzarella wrote:
>>shm_open() creates and opens a new POSIX shared memory object.
>>A POSIX shared memory object allows creating memory backend with an
>>associated file descriptor that can be shared with external processes
>>(e.g. vhost-user).
>>
>>The new `memory-backend-shm` can be used as an alternative when
>>`memory-backend-memfd` is not available (Linux only), since shm_open()
>>should be provided by any POSIX-compliant operating system.
>>
>>This backend mimics memfd, allocating memory that is practically
>>anonymous. In theory shm_open() requires a name, but this is allocated
>>for a short time interval and shm_unlink() is called right after
>>shm_open(). After that, only fd is shared with external processes
>>(e.g., vhost-user) as if it were associated with anonymous memory.
>>
>>In the future we may also allow the user to specify the name to be
>>passed to shm_open(), but for now we keep the backend simple, mimicking
>>anonymous memory such as memfd.
>>
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>v3
>>- enriched commit message and documentation to highlight that we
>>   want to mimic memfd (David)
>>---
>>  docs/system/devices/vhost-user.rst |   5 +-
>>  qapi/qom.json                      |  17 +++++
>>  backends/hostmem-shm.c             | 118 +++++++++++++++++++++++++++++
>>  backends/meson.build               |   1 +
>>  qemu-options.hx                    |  11 +++
>>  5 files changed, 150 insertions(+), 2 deletions(-)
>>  create mode 100644 backends/hostmem-shm.c
>>
>>diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
>>index 9b2da106ce..35259d8ec7 100644
>>--- a/docs/system/devices/vhost-user.rst
>>+++ b/docs/system/devices/vhost-user.rst
>>@@ -98,8 +98,9 @@ Shared memory object
>>  In order for the daemon to access the VirtIO queues to process the
>>  requests it needs access to the guest's address space. This is
>>-achieved via the ``memory-backend-file`` or ``memory-backend-memfd``
>>-objects. A reference to a file-descriptor which can access this object
>>+achieved via the ``memory-backend-file``, ``memory-backend-memfd``, or
>>+``memory-backend-shm`` objects.
>>+A reference to a file-descriptor which can access this object
>>  will be passed via the socket as part of the protocol negotiation.
>>  Currently the shared memory object needs to match the size of the main
>>diff --git a/qapi/qom.json b/qapi/qom.json
>>index 85e6b4f84a..5252ec69e3 100644
>>--- a/qapi/qom.json
>>+++ b/qapi/qom.json
>>@@ -721,6 +721,19 @@
>>              '*hugetlbsize': 'size',
>>              '*seal': 'bool' } }
>>+##
>>+# @MemoryBackendShmProperties:
>>+#
>>+# Properties for memory-backend-shm objects.
>>+#
>>+# The @share boolean option is true by default with shm.
>>+#
>>+# Since: 9.1
>>+##
>>+{ 'struct': 'MemoryBackendShmProperties',
>>+  'base': 'MemoryBackendProperties',
>>+  'data': { } }
>>+
>
>Acked-by: David Hildenbrand <david@redhat.com>
>
>One comment: we should maybe just forbid setting share=off. it doesn't 
>make any sense and it can even result in an unexpected double memory 
>consumption. We missed doing that for memfd, unfortunately.

Good point!

IIUC the `share` property is defined by the parent `hostmem`, so I 
should find a way to override the property here and disable the setter, 
or add an option to `hostmem` to make the property non-writable.

Thanks,
Stefano


