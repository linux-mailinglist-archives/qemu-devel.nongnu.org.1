Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B13827F01
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 08:04:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN68E-0007Dw-O4; Tue, 09 Jan 2024 02:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN68C-0007Dg-Ej
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN689-0004Xp-AB
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704783752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAeYyFHQzjn2ivIVBOcJS0U4XCHW89Kt0gDL0sK2sHI=;
 b=gOAmNg+GoswBib3VE9Pv3W01hTQQcJLw5IT+8ABbpJjdNdwFHyemlp50jGl125gREsL4xm
 4MJN5GaM8L3cOs+6s0rUzBiI7dfJYFMDONAkR1Vwi0JTN4m6Sk4ROXX8X8/dNU9EADqN0G
 tYyAjrcwTw3wArdCng6QRWvISGn84fY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-UdSCDsEiMEeQXlzNbpIvMw-1; Tue, 09 Jan 2024 02:02:31 -0500
X-MC-Unique: UdSCDsEiMEeQXlzNbpIvMw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-42780de6a7eso36993201cf.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 23:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704783750; x=1705388550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bAeYyFHQzjn2ivIVBOcJS0U4XCHW89Kt0gDL0sK2sHI=;
 b=eDn7jNMZ2HgGQjYz/4xWJEni856A1A3hbTZx6juNS0X0iWkAW5IKtopxaDsLR9o3FB
 tXIV4fFZ74FrqUYuj+GKjCDs5pYv1UtOEr5gSUPX+bDekIMjMrziLTIy5T9Qk8oAPjny
 gljzVYz19GH6trMDbvLJMaAIjLuU2/TXF9jlR62TeRpwdevUsw3Gatr/lb14yCmm36Q3
 obRLD3YNfKyW6F0KJGi4sREe5YdFpZsbNrznXvW0cz7PL/X32iTHH41nioiSUBLDECxp
 cuxNLEx/TBb1OZsxYkKM1EJmhqnDK/RJ1SOcGu4OfFw9qTsrrkKv/3s74yQiK9hNlYy3
 s1Ag==
X-Gm-Message-State: AOJu0YzGqi4yWAV+DbeYgvIoqGLmg4rUOJPwC8iU4LDJCZyNBSQ3KUiM
 m/VVcKpnN9q21XQIJpHPQW8YXwaxZD7APMuIO2yNBWx2Uox6WvJXlFQV7XycDl+FaexQe1r7l+T
 o93648K4XRWKkNWZczLug/cU=
X-Received: by 2002:ac8:598b:0:b0:429:87b9:b8ca with SMTP id
 e11-20020ac8598b000000b0042987b9b8camr5947300qte.117.1704783750580; 
 Mon, 08 Jan 2024 23:02:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRYFHBhgxH/7rQnu8xE8c0stHSqLuUkq21l71CDKm2oMESaK7sCrdz80rrWHzBxnMSoUv2ug==
X-Received: by 2002:ac8:598b:0:b0:429:87b9:b8ca with SMTP id
 e11-20020ac8598b000000b0042987b9b8camr5947290qte.117.1704783750300; 
 Mon, 08 Jan 2024 23:02:30 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 cr14-20020a05622a428e00b0042997333149sm605370qtb.63.2024.01.08.23.02.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 23:02:29 -0800 (PST)
Message-ID: <770e7e60-e972-4120-b3e7-b5203337c9c0@redhat.com>
Date: Tue, 9 Jan 2024 08:02:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] docs/migration: Convert virtio.txt into rST
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240109064628.595453-1-peterx@redhat.com>
 <20240109064628.595453-4-peterx@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240109064628.595453-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> Convert the plain old .txt into .rst, add it into migration/index.rst.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   docs/devel/migration/index.rst  |   1 +
>   docs/devel/migration/virtio.rst | 115 ++++++++++++++++++++++++++++++++
>   docs/devel/migration/virtio.txt | 108 ------------------------------
>   3 files changed, 116 insertions(+), 108 deletions(-)
>   create mode 100644 docs/devel/migration/virtio.rst
>   delete mode 100644 docs/devel/migration/virtio.txt
> 
> diff --git a/docs/devel/migration/index.rst b/docs/devel/migration/index.rst
> index 02cfdcc969..2cb701c77c 100644
> --- a/docs/devel/migration/index.rst
> +++ b/docs/devel/migration/index.rst
> @@ -9,3 +9,4 @@ QEMU live migration works.
>   
>      main
>      vfio
> +   virtio
> diff --git a/docs/devel/migration/virtio.rst b/docs/devel/migration/virtio.rst
> new file mode 100644
> index 0000000000..611a18b821
> --- /dev/null
> +++ b/docs/devel/migration/virtio.rst
> @@ -0,0 +1,115 @@
> +=======================
> +Virtio device migration
> +=======================
> +
> +Copyright 2015 IBM Corp.
> +
> +This work is licensed under the terms of the GNU GPL, version 2 or later.  See
> +the COPYING file in the top-level directory.
> +
> +Saving and restoring the state of virtio devices is a bit of a twisty maze,
> +for several reasons:
> +
> +- state is distributed between several parts:
> +
> +  - virtio core, for common fields like features, number of queues, ...
> +
> +  - virtio transport (pci, ccw, ...), for the different proxy devices and
> +    transport specific state (msix vectors, indicators, ...)
> +
> +  - virtio device (net, blk, ...), for the different device types and their
> +    state (mac address, request queue, ...)
> +
> +- most fields are saved via the stream interface; subsequently, subsections
> +  have been added to make cross-version migration possible
> +
> +This file attempts to document the current procedure and point out some
> +caveats.
> +
> +Save state procedure
> +====================
> +
> +::
> +
> +  virtio core               virtio transport          virtio device
> +  -----------               ----------------          -------------
> +
> +                                                      save() function registered
> +                                                      via VMState wrapper on
> +                                                      device class
> +  virtio_save()                                       <----------
> +               ------>      save_config()
> +                            - save proxy device
> +                            - save transport-specific
> +                              device fields
> +  - save common device
> +    fields
> +  - save common virtqueue
> +    fields
> +               ------>      save_queue()
> +                            - save transport-specific
> +                              virtqueue fields
> +               ------>                               save_device()
> +                                                     - save device-specific
> +                                                       fields
> +  - save subsections
> +    - device endianness,
> +      if changed from
> +      default endianness
> +    - 64 bit features, if
> +      any high feature bit
> +      is set
> +    - virtio-1 virtqueue
> +      fields, if VERSION_1
> +      is set
> +
> +Load state procedure
> +====================
> +
> +::
> +
> +  virtio core               virtio transport          virtio device
> +  -----------               ----------------          -------------
> +
> +                                                      load() function registered
> +                                                      via VMState wrapper on
> +                                                      device class
> +  virtio_load()                                       <----------
> +               ------>      load_config()
> +                            - load proxy device
> +                            - load transport-specific
> +                              device fields
> +  - load common device
> +    fields
> +  - load common virtqueue
> +    fields
> +               ------>      load_queue()
> +                            - load transport-specific
> +                              virtqueue fields
> +  - notify guest
> +               ------>                               load_device()
> +                                                     - load device-specific
> +                                                       fields
> +  - load subsections
> +    - device endianness
> +    - 64 bit features
> +    - virtio-1 virtqueue
> +      fields
> +  - sanitize endianness
> +  - sanitize features
> +  - virtqueue index sanity
> +    check
> +                                                     - feature-dependent setup
> +
> +Implications of this setup
> +==========================
> +
> +Devices need to be careful in their state processing during load: The
> +load_device() procedure is invoked by the core before subsections have
> +been loaded. Any code that depends on information transmitted in subsections
> +therefore has to be invoked in the device's load() function _after_
> +virtio_load() returned (like e.g. code depending on features).
> +
> +Any extension of the state being migrated should be done in subsections
> +added to the core for compatibility reasons. If transport or device specific
> +state is added, core needs to invoke a callback from the new subsection.
> diff --git a/docs/devel/migration/virtio.txt b/docs/devel/migration/virtio.txt
> deleted file mode 100644
> index 98a6b0ffb5..0000000000
> --- a/docs/devel/migration/virtio.txt
> +++ /dev/null
> @@ -1,108 +0,0 @@
> -Virtio devices and migration
> -============================
> -
> -Copyright 2015 IBM Corp.
> -
> -This work is licensed under the terms of the GNU GPL, version 2 or later.  See
> -the COPYING file in the top-level directory.
> -
> -Saving and restoring the state of virtio devices is a bit of a twisty maze,
> -for several reasons:
> -- state is distributed between several parts:
> -  - virtio core, for common fields like features, number of queues, ...
> -  - virtio transport (pci, ccw, ...), for the different proxy devices and
> -    transport specific state (msix vectors, indicators, ...)
> -  - virtio device (net, blk, ...), for the different device types and their
> -    state (mac address, request queue, ...)
> -- most fields are saved via the stream interface; subsequently, subsections
> -  have been added to make cross-version migration possible
> -
> -This file attempts to document the current procedure and point out some
> -caveats.
> -
> -
> -Save state procedure
> -====================
> -
> -virtio core               virtio transport          virtio device
> ------------               ----------------          -------------
> -
> -                                                    save() function registered
> -                                                    via VMState wrapper on
> -                                                    device class
> -virtio_save()                                       <----------
> -             ------>      save_config()
> -                          - save proxy device
> -                          - save transport-specific
> -                            device fields
> -- save common device
> -  fields
> -- save common virtqueue
> -  fields
> -             ------>      save_queue()
> -                          - save transport-specific
> -                            virtqueue fields
> -             ------>                               save_device()
> -                                                   - save device-specific
> -                                                     fields
> -- save subsections
> -  - device endianness,
> -    if changed from
> -    default endianness
> -  - 64 bit features, if
> -    any high feature bit
> -    is set
> -  - virtio-1 virtqueue
> -    fields, if VERSION_1
> -    is set
> -
> -
> -Load state procedure
> -====================
> -
> -virtio core               virtio transport          virtio device
> ------------               ----------------          -------------
> -
> -                                                    load() function registered
> -                                                    via VMState wrapper on
> -                                                    device class
> -virtio_load()                                       <----------
> -             ------>      load_config()
> -                          - load proxy device
> -                          - load transport-specific
> -                            device fields
> -- load common device
> -  fields
> -- load common virtqueue
> -  fields
> -             ------>      load_queue()
> -                          - load transport-specific
> -                            virtqueue fields
> -- notify guest
> -             ------>                               load_device()
> -                                                   - load device-specific
> -                                                     fields
> -- load subsections
> -  - device endianness
> -  - 64 bit features
> -  - virtio-1 virtqueue
> -    fields
> -- sanitize endianness
> -- sanitize features
> -- virtqueue index sanity
> -  check
> -                                                   - feature-dependent setup
> -
> -
> -Implications of this setup
> -==========================
> -
> -Devices need to be careful in their state processing during load: The
> -load_device() procedure is invoked by the core before subsections have
> -been loaded. Any code that depends on information transmitted in subsections
> -therefore has to be invoked in the device's load() function _after_
> -virtio_load() returned (like e.g. code depending on features).
> -
> -Any extension of the state being migrated should be done in subsections
> -added to the core for compatibility reasons. If transport or device specific
> -state is added, core needs to invoke a callback from the new subsection.


