Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E76C47B8158
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:50:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2GM-0006Xs-3m; Wed, 04 Oct 2023 09:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qo2GA-0006Oj-Du
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:49:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qo2G4-0000Oj-M3
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696427385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04v1Y2ap8PgeFJZuk9aFB8ktqtsNW3EnF+uSxtf2btw=;
 b=UtCq+k5u+9mYxWvdYhikvjhbN4UFX6aHOyH+Izdy3bIRrssEO1PJbGJItaeaeSivanUvJm
 +aBTVMDk6tx9fenr8rYRrdgw2F2Yda8a9CCEzOVHGqN4jYgm+4k3yZ9A7Vi4qBnWKt0gz8
 lRXgD1PU3sxW7JGQ6tRC+g07f4CCZT4=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-FVyT7j1bOEaPigBMIEuKWA-1; Wed, 04 Oct 2023 09:49:44 -0400
X-MC-Unique: FVyT7j1bOEaPigBMIEuKWA-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7af53ed577fso680209241.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 06:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696427384; x=1697032184;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04v1Y2ap8PgeFJZuk9aFB8ktqtsNW3EnF+uSxtf2btw=;
 b=DzXGsN6RJHhMmy91QPTReoK9JyFqqZeGdWPnjZA0KHXV1FGu/GlgBJdtuRSX0WKfGI
 y/fm5BEm1RcMgec7xFFzjCOiB1JV4yEjPxpRoO9Lz3hQlo4nI7lLyBC+Bf8XfNa9Sxmb
 M6iCC6nVEp67JVcvKwjei2nwUAvmDyK8pDrNb54LPvJyighFIgtx1ry76yFRRr9r1TR1
 Z/IaEfap5uAmt2/z1Ah3td87ApL/mg1KQTVnLz87UD+FxvTDHdnJYOcNLvxINwZ2r3O+
 kzK2T4Zx3tGt5WAvJ3NZ6qTY/QapBwFKPE92Xntj1FbzLGuEqlxIWvl3gxrHfyqpala6
 /NRw==
X-Gm-Message-State: AOJu0Yw1JlFC/yYGfoQ0/Rk22d4nZTVPcIJ8P0edx6tNy8ni/8xsap4d
 +UTr2RgV6jSZ5GSSNgah0UbtwKUpGa70u1n+JCfN7ea9YrcFbKsQFmuZBvtValEUUcARIV/X9QG
 HWLlMPph71c0jFxLmVUsjHGtjjhuCbs0=
X-Received: by 2002:a05:6102:34f1:b0:44e:8353:e86a with SMTP id
 bi17-20020a05610234f100b0044e8353e86amr1908483vsb.24.1696427383859; 
 Wed, 04 Oct 2023 06:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrrKqP+M5hrFXvi1zNunZl8wvLusbFwWv65LHWYfzcwWNA4Hj78RFJqBabd8Ty1apI5MjzBX8iD8qCBHpNWVA=
X-Received: by 2002:a05:6102:34f1:b0:44e:8353:e86a with SMTP id
 bi17-20020a05610234f100b0044e8353e86amr1908439vsb.24.1696427383128; Wed, 04
 Oct 2023 06:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231004090629.37473-1-philmd@linaro.org>
 <ZR1bjpEi5HdFp2xj@redhat.com>
 <85be2979-c0ca-3eb4-dae9-bbabf256c201@redhat.com>
 <00b2ec16-162e-9204-3a04-f45e0edeeb15@suse.de>
In-Reply-To: <00b2ec16-162e-9204-3a04-f45e0edeeb15@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 4 Oct 2023 15:49:31 +0200
Message-ID: <CABgObfZBTZZvcSPcMSRLWscyEz7B-2h9g28FJx7t7Ggux6E9cA@mail.gmail.com>
Subject: Re: [PATCH 00/13] misc: Rename 'softmmu' -> 'system'
To: Claudio Fontana <cfontana@suse.de>
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
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

On Wed, Oct 4, 2023 at 3:41=E2=80=AFPM Claudio Fontana <cfontana@suse.de> w=
rote:
>
> On 10/4/23 14:37, Thomas Huth wrote:
> > On 04/10/2023 14.33, Daniel P. Berrang=C3=A9 wrote:
> >> Am I mis-understanding what you mean by 'finishes' here, as
> >> I see many references to softmmu remaining
> >> In particular under configs/
> >>
> >> I was also hoping it meant that we'd be changing configure
> >> to allow
> >>
> >>      configure --target-list=3Dx86_64-system
> >>      configure --target-list=3Dx86_64-vm
> >>
> >> for less typing
> >
> > Maybe we should also bikeshed about the naming first... "system" is a q=
uite
> > overloaded word in this context already, and "vm" sounds rather like
> > hardware-accelerated stuff ... what about using something like "sysemu"=
? Or
> > "fullsys" for "full system emulation" (in contrast to "user space"-only
> > emulation)?

I agree that changing other remnants should be done right
after this patch, for example $softmmu in configure. Changing
all targets is a very large and very user-visible change, it is
required but it should be planned very well.

As to the actual target names, I think system is the only
consistent choice since we have --enable/--disable-system
(as pointed out by Claudio) and qemu-system-*.  sysemu
may make a little more sense in the codebase (we have
include/sysemu after all), but maybe that ship has sailed
since we have many occurrences of "system", for example
system_ss and other related sourcesets.

Paolo


