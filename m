Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 326637AB2CB
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 15:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjgGe-0004YZ-Lr; Fri, 22 Sep 2023 09:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjgGc-0004Xi-Cq
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 09:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjgGa-0008FV-Na
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 09:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695389539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+GZzAT5UF3G7xxEp2Y+aeWVvkgHKyhNyohZ3fE0Mg5M=;
 b=bHlHPw2hMnxU24r7WS5AkHg8hCnomuqvwh7E8RzZjZbnHf2DL8ZoHQL+l3AlcIz3e8MCuA
 j+n1j2JHjCp7GxU2d2zM3qaZoZ0vDOB1DN68vTTlxr0dnSvzgli9ZNfk3xIacpWBaSoZxB
 xUYk66mQndmC3xSPxTnszuEmSFS++MU=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-qgujNfhjNzC8fG6Si02r7Q-1; Fri, 22 Sep 2023 09:32:17 -0400
X-MC-Unique: qgujNfhjNzC8fG6Si02r7Q-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7a8b9999ea6so678185241.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 06:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695389537; x=1695994337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+GZzAT5UF3G7xxEp2Y+aeWVvkgHKyhNyohZ3fE0Mg5M=;
 b=vqTBrXjq4ujsi79DfsRvoS9TVj1qjLR2cbdS9ti9TrpZU4lo3M6v6jCpawLT9HRjS6
 UCXq+RJ/hVo+4FpMqB7NIFjQ4StANaBbxR6u+2hvtutUThreBfs4AdQU+5yTLlHJKsQY
 pU4IMpfYBSVBcDJEA54pS7UJ2R08lxyhg2hB/1YOJCra5oXCNdyjXTAKoKJA3sCRuKpJ
 /1Uh4WvGdBV1VSl1o8hnWfAfRqNGYaXkM+XoL+hkV2dUQGY4tNTlN/Dfpu/V6HRuKH5b
 T3aPpp+f+jkIuNH2p7/acXN+MX3sjnPgr/pOupfPzUAvkokDnc1LyScU9cYJ4hr5dceO
 JiFA==
X-Gm-Message-State: AOJu0YzyGlgkgi4lYltV6uI0d6WMyZdcUQkZPliI2k0kFrCQXD42KdW7
 s92Uh++AbPE3jiCLuLnP0k8RSKvLy5yVLcmJdr997IEuzJFWp8BoSPX9O4bL0QSpjcGvG9WPVAG
 s1Wh2R5Z6sIx4BMDm6gpX88iNz5rJwqo=
X-Received: by 2002:a1f:ca46:0:b0:495:bf04:8a05 with SMTP id
 a67-20020a1fca46000000b00495bf048a05mr7300345vkg.9.1695389536888; 
 Fri, 22 Sep 2023 06:32:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/vmaYObsk9mMaKJSQhRadp5YWqY3AXKhVFcB+fysn5axbTSppQ2uaZ6KfqXLSKFJUGVpE4ij1aC6kI6ER/Rs=
X-Received: by 2002:a1f:ca46:0:b0:495:bf04:8a05 with SMTP id
 a67-20020a1fca46000000b00495bf048a05mr7300328vkg.9.1695389536594; Fri, 22 Sep
 2023 06:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230922094459.265509-1-pbonzini@redhat.com>
 <20230922094459.265509-7-pbonzini@redhat.com>
 <fa8a8e3f-b17c-f5fc-a4ae-13a0fa233fb7@eik.bme.hu>
In-Reply-To: <fa8a8e3f-b17c-f5fc-a4ae-13a0fa233fb7@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Sep 2023 15:32:05 +0200
Message-ID: <CABgObfaz+kzZkx_Xb-3rB27fkrefmE_P5=gF_LU9gF=y-rATAw@mail.gmail.com>
Subject: Re: [PATCH 6/9] vt82c686: Support machine-default audiodev with
 fallback
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, mkletzan@redhat.com
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

On Fri, Sep 22, 2023 at 2:17=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
> >     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("460exb");
> >     mc->default_ram_size =3D 512 * MiB;
> >     mc->default_ram_id =3D "ppc4xx.sdram";
> > +
> > +    machine_add_audiodev_property(mc);
>
> This hunk has nothing to do with vt82686 so probably should be in
> previoius patch. Also sam460ex embedded sound part is not emulated and ca=
n
> only use PCI sound cards. What this line is needed for?

No, this line shouldn't be there.

> If every machine
> now needs this call, can it be added in some generic machine init func in
> hw/core/machine.c instead?

It is not needed by every machine, only by every machine that has
embedded sound.

> I'm not sure about this whole series. Looks like it gets rid of 71 lines
> but adding 158 and makes the users' life harder by requireing them to
> specify drivers they may not even know about. What's the point? Is there
> still a default to use the normally used audiodev for the platform or
> people will now get errors and no sound unless they change their command
> lines?

I think you're right, I should have sent this series without the last
two patches.

The first seven add more functionality, because they let you use
-audiodev for configuration of embedded boards. This is why they add
some lines of code.

The last two patches instead are the ones that make -audio or
-audiodev mandatory. They should be separate and they may not be a
good idea without something like "-audio default". And if no "-audio
default" is added, there is more code that can go (for example the
--audio-drv-list option to configure and CONFIG_AUDIO_DRIVERS).

Paolo


