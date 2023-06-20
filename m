Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 781E77370F8
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:52:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBddY-0007m4-Jk; Tue, 20 Jun 2023 11:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBddV-0007lq-GS
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBddT-0003fg-CG
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687276274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0qkii4M+UClxwBZABaTrozc2d9DqniP4E3jnyirnhB8=;
 b=Uyw2u8ZYmPKjfQYz+JIdizKGmLQT/M5OdMYWM6qIFoqqwW5CEGnvQXA9JXJ2+TuWU5reyR
 ZMpseghp6dj5f7zyDil3d9SqY4erN48MGr2kmscK9HO8of5iEBhzewJmIU1fy2o5jQQyVt
 filFcsKC+v6OMPd5AEn1jHb8X0cbKA4=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-qeelBoE8OkeQIpcW3zrTvA-1; Tue, 20 Jun 2023 11:51:06 -0400
X-MC-Unique: qeelBoE8OkeQIpcW3zrTvA-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-78f1b0510c7so1014331241.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687276265; x=1689868265;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0qkii4M+UClxwBZABaTrozc2d9DqniP4E3jnyirnhB8=;
 b=jGsuW5Fa4M8tthik8FflsmWeAgGblBt5jobAjWJAsjzUlQul3d9f9+9MVRZG8jP/do
 /elu5fS0V/jCiGaTEsiXcNlBGfY8wQy3d1efxPRGMjNZ49H2EyuUUQAdh23bNbJvm2hM
 zyGcLO97/L1yx9iRu2Y3J5JyToCjctRrD/P9NZxPhpO+dI7yf1bbVm0DC+856/n1HOiD
 IOtg3muKD7CizylHaZaAdWB3/og6DUaq6KM/kAf4mhoGDdPZET7dgwCNugn/P8AfcbfC
 RP2tOcgHnRDnJWPyGb/4B0WxAEYIixAyN305awDEhUYeoD8RRFhEKHVkQE/0EONLMp/I
 A0dw==
X-Gm-Message-State: AC+VfDw3BzHcUEK+I20NM1/FNeq76+f8NWx6s0XyJWLSXeBdVxfRyNXe
 fP/MwBZ16e/d5YOtjftwXi5biuz/EkT9FiOs7azxYnfEpKHHiMPccwLKP52WJa+6JzD6aWtpwTQ
 VEkV5ZHOGq2rdfCSCLW9m4tgzJNGkH34=
X-Received: by 2002:a67:e983:0:b0:437:d6b8:8baf with SMTP id
 b3-20020a67e983000000b00437d6b88bafmr2851183vso.15.1687276265099; 
 Tue, 20 Jun 2023 08:51:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5P4UGcxnZNMMpxjQWniczi75ptZLTHZUaZcZoLq6wtj7iv2175n9PlTvkoMuAKwUMe8ZZMnOR0WBS62av4OAw=
X-Received: by 2002:a67:e983:0:b0:437:d6b8:8baf with SMTP id
 b3-20020a67e983000000b00437d6b88bafmr2851170vso.15.1687276264791; Tue, 20 Jun
 2023 08:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230619171437.357374-1-alex.bennee@linaro.org>
 <20230619171437.357374-6-alex.bennee@linaro.org>
In-Reply-To: <20230619171437.357374-6-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 20 Jun 2023 17:50:53 +0200
Message-ID: <CABgObfZLcNjmi4j9Bo4Fpp2XMP1cQPtWgWfqvG1wHL12xdsOsQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] docs/devel: introduce some key concepts for QOM
 development
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Juan Quintela <quintela@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jun 19, 2023 at 7:15=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> Using QOM correctly is increasingly important to maintaining a modern
> code base. However the current documentation skips some important
> concepts before launching into a simple example. Lets:
>
>   - at least mention properties
>   - mention TYPE_OBJECT and TYPE_DEVICE
>   - talk about why we have realize/unrealize
>   - mention the QOM tree
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/devel/qom.rst | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
> index 98a4f178d5..53633fbd35 100644
> --- a/docs/devel/qom.rst
> +++ b/docs/devel/qom.rst
> @@ -13,6 +13,53 @@ features:
>  - System for dynamically registering types
>  - Support for single-inheritance of types
>  - Multiple inheritance of stateless interfaces
> +- Mapping internal members to publicly exposed properties
> +
> +The root object class is TYPE_OBJECT which provides for the basic
> +object methods.

Very nice, but I would suggest some changes here.

> +The Device Class
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The TYPE_DEVICE class is the parent class for all modern devices
> +implemented in QEMU and adds some specific methods to handle QEMU
> +device model. This includes managing the lifetime of devices from
> +creation through to when they become visible to the guest and
> +eventually unrealized.

Place this paragraph before "Alternatively several static types".

> +Device Life-cycle
> +-----------------


Make this "=3D=3D=3D=3D=3D" level and move it at the very end of the docume=
nt.

Replace these two lines:

The first example of such a QOM method was #CPUClass.reset,
another example is #DeviceClass.realize.

with

One example of such methods is ``DeviceClass.reset``. More examples
can be found at [link to Device Life-Cycle].

> +As class initialisation cannot fail devices have an two additional
> +methods to handle the creation of dynamic devices. The ``realize``
> +function is called with ``Error **`` pointer which should be set if
> +the device cannot complete its setup. Otherwise on successful
> +completion of the ``realize`` method the device object is added to the
> +QOM tree and made visible to the guest.
> +
> +The reverse function is ``unrealize`` and should be were clean-up
> +code lives to tidy up after the system is done with the device.
> +
> +All devices can be instantiated by C code, however only some can
> +created dynamically via the command line or monitor. Likewise only
> +some can be unplugged after creation and need an explicit
> +``unrealize`` implementation. This is determined by the
> +``user_creatable`` and ``hotpluggable`` variables in the root
> +``DeviceClass`` structure.

Move the second sentence (the one starting with "Likewise") to a
separate paragraph. Unpluggability is determined by the HotplugHandler
rather than by "user_creatable" and "hotpluggable".

> +The QOM tree
> +------------
> +
> +The QOM tree is a composition tree which represents all of the objects
> +that make up a QEMU "machine". You can view this tree by running
> +``info qom-tree`` in the :ref:`QEMU monitor`. It will contain both
> +objects created by the machine itself as well those created due to
> +user configuration.

Also make this "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D".

> +Creating a minimal device
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Name this "Creating a QOM class", and change "Class Initialization",
"Interfaces" and "Methods" to "-------------".

> +A simple minimal device implementation may look something like bellow:

"below".

Paolo


