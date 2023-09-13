Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C56E879E702
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 13:39:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgOCa-0007ZR-Rq; Wed, 13 Sep 2023 07:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qgOCS-0007Z9-8d
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 07:38:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qgOCQ-00085H-0l
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 07:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694605104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nAjLpIR9xVtBthAhCAr16sY6Fga434YI/CvpKHyWAso=;
 b=Xh38+gA+u605z7MH4ANK6XLh4r3eL3yfSumiCR21Gjfo6PmxDcLUZQbNt3DYgSafiCYUzT
 aR1TcOkP6k/w+asghEheJVTlcElK7a9J38sESUrw0jxgn5DKMmgt0w6TS7vJGjdgc6uQ12
 0+/HPtX4NvQtJGbuQgSI36D6nmLaQ0E=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-lKJmcvRVPKKHoHpVhSNkzg-1; Wed, 13 Sep 2023 07:38:22 -0400
X-MC-Unique: lKJmcvRVPKKHoHpVhSNkzg-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-44d5dba1d47so2580258137.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 04:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694605102; x=1695209902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nAjLpIR9xVtBthAhCAr16sY6Fga434YI/CvpKHyWAso=;
 b=NdkAeSQkkekwHtQX1GPspi5fD24Ca+3Oeu3UMLNLgRD7jtP5ij3oEumRO3F39QDxuf
 2H0M/EdASx0YlZK9wiZo0aOS8mIjo6VEeHvpnFCTWc4xxdsEoYxtUW75Vwdbp//oUk+g
 e4TnivLVeCaIprYd/eHKU+P7jpYvq4YNxS3h6l0BjpNNAqx6txQd16RAbEbuxgtxYKLx
 pxljH6BH52vXNK1KSZQn7cMS0/MyFAPEXIvqBInOWCxtq4cE06KI2J0REXykFZqDtelR
 GBWxaHDFX5ClsECtSTSM58b0mp/TLbfJsihqNPM/KQ8mt5NQQY8JiEPI9wk7NQVdRTZn
 TeuA==
X-Gm-Message-State: AOJu0YxKoRvWNpVCuER6ySjN1DFn0cl84EfE5VGf9Bqp/dcOa58+bGwJ
 B/N43qrxvLVWmbs2DFUWyksyVj2IbMiaS9v26Z8GIVu5KWU9KYYO6HzG7QfVRxId1ZNGQynR4T6
 ZW9GWR1VuFVbTqAyx/x5fBirnmsP3cWk=
X-Received: by 2002:a05:6102:11f3:b0:44d:547d:7e84 with SMTP id
 e19-20020a05610211f300b0044d547d7e84mr1837606vsg.28.1694605102410; 
 Wed, 13 Sep 2023 04:38:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiCWwaDaB6Tvmincr5zXRUuueQfqamIuQ+N3BqMn1VvotsHjtljMaP2tUgmv3D6jlyOiuEstadFikN7kVNc/U=
X-Received: by 2002:a05:6102:11f3:b0:44d:547d:7e84 with SMTP id
 e19-20020a05610211f300b0044d547d7e84mr1837601vsg.28.1694605102192; Wed, 13
 Sep 2023 04:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230906190141.1286893-1-stefanha@redhat.com>
 <1fa3ad95-c335-7e97-42f0-00dca5c5ba48@redhat.com>
 <20230907140006.GA1363873@fedora>
 <CABgObfZXE+AupVGZTbm-W4RXbQPBiqSAgo+U4k1Eza=U1sortA@mail.gmail.com>
 <ZQCa/DxAAQnau3JR@redhat.com>
In-Reply-To: <ZQCa/DxAAQnau3JR@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 13 Sep 2023 13:38:10 +0200
Message-ID: <CABgObfYMhwDO=5zgxtJo7o697K_+gFdFZu7b1OXV1-1Dp+4kAw@mail.gmail.com>
Subject: Re: [RFC 0/3] qmp: make qmp_device_add() a coroutine
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
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

On Tue, Sep 12, 2023 at 7:08=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:
> > Any caller of qmp_dispatch() knows if it is in a coroutine or not.
> > qemu-ga uses neither a coroutine dispatcher nor coroutine commands.
> > QEMU uses non-coroutine dispatch for out-of-band commands (and we can
> > forbid coroutine + allow-oob at the same time), and coroutine dispatch
> > for the others.
> >
> > So, moving out of coroutine context (through a bottom half) should be
> > done by monitor_qmp_dispatch(), and likewise moving temporarily out of
> > the iohandler context in the case of coroutine commands. In the case
> > of !req_obj->req you don't need to do either of those. qmp_dispatch()
> > can still assert that the coroutine-ness of the command matches the
> > context in which qmp_dispatch() is called.
> >
> > Once this is done, I think moving out of coroutine context can use a
> > BH that runs in the iohandler context.
>
> Non-coroutine handlers could probably stay in iothread_ctx, but I don't
> think we can avoid switching to a different for coroutine handlers.

Agreed.

> So maybe we can just move the rescheduling down to the coroutine case in
> qmp_dispatch().

Not sure about qmp_dispatch (see above: any caller of the function
knows if it is in a coroutine or not, and qemu-ga need not know about
coroutines at all). But what you said also applies if the rescheduling
is only pushed to monitor_qmp_dispatch(), which would be my first
option.

Thanks!

Paolo


