Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFAA827EEE
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 07:53:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN5zO-0004rX-9r; Tue, 09 Jan 2024 01:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN5zM-0004r6-5j
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:53:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN5zK-0000SX-Hg
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704783205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1UimebcUsKtOOvwtAcqdem0Lu2TPDxNpDW71fm4aeU=;
 b=MZ+d+QLaHXk8lYsJLsK72noXNwmdOXtCB85tvuqKD9mfAvIqauhyqgic1mY+zIMAH+aMrn
 D4oC/kDIwwQ5PtRA6UBBLWy9ByoEuPOkeRi8uZxhneYxNJzPwqdqo9qbOtq0IIl6GeCqFv
 /8ve60ZKf38Z4xBYZ9VDa5r+n9c4pY4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-y2YHmcxdMwGu24X2ABlXmw-1; Tue, 09 Jan 2024 01:53:24 -0500
X-MC-Unique: y2YHmcxdMwGu24X2ABlXmw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7816bea8d28so641484285a.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 22:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704783204; x=1705388004;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f1UimebcUsKtOOvwtAcqdem0Lu2TPDxNpDW71fm4aeU=;
 b=dbpMz7nryASXUajpqLeTVjeo1ra0Xf3HtcQ8FW7/vt7hzra2Lpv3E7m//uLKFwPzQ4
 Xt2LIObEnoYIC+J13qHyF/h2aGwH5eoKOcILdFAWDh1jikJJhZeoXoGReK8NvWF+8fhm
 GwMcm/7nHfRazW94j6vXgDii9t0cWMbyn7X95sqwh/HfPFf8UB8Z64noaa8XhXi2wHyA
 hplywzCTZHhqoNkwzIgRwA3+wUOED3CtdJbHDfbhkMxxrUEcT5gaa6VRK9/BxXQd5874
 OP3bMapUt7FJKpxUayJLjknrcvjDYS1YRpqykLqIO6++CsURQNzDMeN2uyzFQ7/im9RA
 HrXg==
X-Gm-Message-State: AOJu0Yy3zyZl2dj3936A1nJ0MDgOrmh4Mj482lerxvy1FUcVfeXyQmf0
 Top/MqlP/HcayY7pC3V+sPF5lG45yobXMJUTJJf6fUBsUQBaU3u92/Tc/Huj+SXKp+zQntFnbJR
 EkYZrIUf2UG3qJJdYextw+8E=
X-Received: by 2002:ae9:c209:0:b0:783:25f0:a421 with SMTP id
 j9-20020ae9c209000000b0078325f0a421mr321683qkg.21.1704783203899; 
 Mon, 08 Jan 2024 22:53:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtSOH6dkVMiciUowaL5snFy2ALzTTWiLjBK1ap6FrYwTXl8iq+lJaVY7rXBptKbVt7SCMLow==
X-Received: by 2002:ae9:c209:0:b0:783:25f0:a421 with SMTP id
 j9-20020ae9c209000000b0078325f0a421mr321672qkg.21.1704783203676; 
 Mon, 08 Jan 2024 22:53:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 a6-20020a05620a102600b00781b37f8468sm569026qkk.13.2024.01.08.22.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 22:53:23 -0800 (PST)
Message-ID: <ca009af9-2319-42fe-a360-4023e6c8ee36@redhat.com>
Date: Tue, 9 Jan 2024 07:53:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] docs/migration: Create index page
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240109064628.595453-1-peterx@redhat.com>
 <20240109064628.595453-3-peterx@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240109064628.595453-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
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

On 1/9/24 07:46, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Create an index page for migration module.  Move VFIO migration there too.
> A trivial touch-up on the title to use lower case there.
> 
> Since then we'll have "migration" as the top title, make the main doc file
> renamed to "migration framework".
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   docs/devel/index-internals.rst |  3 +--
>   docs/devel/migration/index.rst | 11 +++++++++++
>   docs/devel/migration/main.rst  |  6 +++---
>   docs/devel/migration/vfio.rst  |  2 +-
>   4 files changed, 16 insertions(+), 6 deletions(-)
>   create mode 100644 docs/devel/migration/index.rst
> 
> diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
> index a41d62c1eb..5636e9cf1d 100644
> --- a/docs/devel/index-internals.rst
> +++ b/docs/devel/index-internals.rst
> @@ -11,13 +11,12 @@ Details about QEMU's various subsystems including how to add features to them.
>      block-coroutine-wrapper
>      clocks
>      ebpf_rss
> -   migration/main
> +   migration/index
>      multi-process
>      reset
>      s390-cpu-topology
>      s390-dasd-ipl
>      tracing
> -   vfio-migration
>      vfio-iommufd
>      writing-monitor-commands
>      virtio-backends
> diff --git a/docs/devel/migration/index.rst b/docs/devel/migration/index.rst
> new file mode 100644
> index 0000000000..02cfdcc969
> --- /dev/null
> +++ b/docs/devel/migration/index.rst
> @@ -0,0 +1,11 @@
> +Migration
> +=========
> +
> +This is the main entry for QEMU migration documentations.  It explains how
> +QEMU live migration works.
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   main
> +   vfio
> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> index 95351ba51f..62bf027fb4 100644
> --- a/docs/devel/migration/main.rst
> +++ b/docs/devel/migration/main.rst
> @@ -1,6 +1,6 @@
> -=========
> -Migration
> -=========
> +===================
> +Migration framework
> +===================
>   
>   QEMU has code to load/save the state of the guest that it is running.
>   These are two complementary operations.  Saving the state just does
> diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
> index 605fe60e96..c49482eab6 100644
> --- a/docs/devel/migration/vfio.rst
> +++ b/docs/devel/migration/vfio.rst
> @@ -1,5 +1,5 @@
>   =====================
> -VFIO device Migration
> +VFIO device migration
>   =====================
>   
>   Migration of virtual machine involves saving the state for each device that


