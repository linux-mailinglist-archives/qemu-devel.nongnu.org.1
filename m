Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D577BA20B
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 17:12:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoQ0C-0008CD-87; Thu, 05 Oct 2023 11:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoPzk-00088X-E9
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:10:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoPzj-0000JR-1C
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 11:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696518613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aKftOfvSvqSHYlgT+Fba504Ofia/MLPLI1WdPKFHjGo=;
 b=QGJIPrfjjFA11ceR6JsYtMV1tgnQ7c/CqwBmc9YzxPDYR4/aCA113ZaTauGLnq+jW7u0Tc
 OlB0VFha8YGnQvS7DmXhjMx9FpK6PUmE7gJHW9fsb5GG+x9Jwbule4jNHHkEzSbvoZoVjk
 gJtud8reO92kY54aHbMmmYMbXEe4R2s=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-WRsdrtR3N-aEAEEvvI5l5A-1; Thu, 05 Oct 2023 11:10:11 -0400
X-MC-Unique: WRsdrtR3N-aEAEEvvI5l5A-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-59f61a639b9so15468337b3.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 08:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696518611; x=1697123411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKftOfvSvqSHYlgT+Fba504Ofia/MLPLI1WdPKFHjGo=;
 b=h+VNeZORv4yNY8ZkM7HyUskcAapFL2XrB0QpVxI8Mffp15CWB72N3u/taEPzyoaKDr
 1zEIYxckTjk/8e8z7wrZwoUFAy7xh/Rt5CTbys8HGfJzdG2ON02u9dWDX5JVBRpn7uRp
 dCSnZ3mQ+Lgch6ByNfCIa2jeP4TUJJxOuDX9Dhh58ZM7h1QsMZ56M0Vxfow9vSKy4bZ0
 AxC9dcExOCAtRchmCQUxr1bCERK9tns0rpreF9h57pzd3dRVLNfOTc2s8yAPcKFOcg+3
 /s+sZ0y8TKas738PDVH6YwjfC+91rPViBS5fpUibSR8Rh2gFxe/OJAUM/oU9DydVBlgD
 WCQw==
X-Gm-Message-State: AOJu0YzVxvy0nTXln3aP1l6aB3uzWRxnYNXYL852DzIHMmcGQ0RbZIjj
 9LyeoLo/TUjjSZE7tw4Erl+RvL8SiDK7juak6xQ+F5BNHp1mibU7tuBaDYVUyusCwfT6yvgHY6G
 5/ux7fgE8YqUsaQFvNnTngp3CWjBqYKs=
X-Received: by 2002:a81:484b:0:b0:59f:7fb0:d0d0 with SMTP id
 v72-20020a81484b000000b0059f7fb0d0d0mr5495666ywa.22.1696518610984; 
 Thu, 05 Oct 2023 08:10:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1n99bbeRJ+SfzZ6RPzEYB7D8+YgdyUCXDQV1LhjXjYKMoLmIjzjmbGZR0LB6udHWEEZ7j/h9PHJBO8CurCY4=
X-Received: by 2002:a81:484b:0:b0:59f:7fb0:d0d0 with SMTP id
 v72-20020a81484b000000b0059f7fb0d0d0mr5495647ywa.22.1696518610694; Thu, 05
 Oct 2023 08:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231005125815.66082-1-pbonzini@redhat.com>
 <20231005125815.66082-6-pbonzini@redhat.com>
 <d8327a5f-9a06-2c35-a0c8-372707ea0c4a@eik.bme.hu>
 <18a7de6d-b542-9bf6-2128-d005e2e08a64@eik.bme.hu>
In-Reply-To: <18a7de6d-b542-9bf6-2128-d005e2e08a64@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 5 Oct 2023 17:09:59 +0200
Message-ID: <CABgObfa9yfxr7LTKcCBeRN=KToE860sEdNGG5OjUD1CdVU4a0A@mail.gmail.com>
Subject: Re: [PATCH 5/7] audio: do not use first -audiodev as default audio
 device
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 5, 2023 at 3:39=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
> >> QEMU does not create default audio backends anymore if any of the
> >> ``-audiodev``, ``-audio`` or ``-nodefaults`` options are used on the
> >> command line.
> >
> > Maybe this needs further updating because -audio can now define the def=
ault
> > and is what should be used instead of -audiodev but this is not clear f=
rom
> > this documentation.
>
> And while at it, maybe also mention machine audiodev property here as a
> way to set audiodev of embedded devices.

Sure, here is my next attempt:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Using ``-audiodev`` to define the default audio backend (removed in 8.2)
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
If no audiodev property is specified, previous versions would use the
first ``-audiodev`` command line option as a fallback.  Starting with
version 8.2, audio backends created with ``-audiodev`` will only be
used by clients (sound cards, machines with embedded sound hardware, VNC)
that refer to it in an ``audiodev=3D`` property.

In order to configure a default audio backend, use the ``-audio``
command line option without specifying a ``model``; while previous
versions of QEMU required a model, starting with version 8.2
QEMU does not require a model and will not create any sound card
in this case.

Note that the default audio backend must be configured on the command
line if the ``-nodefaults`` options is used.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


