Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D117161A2
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:24:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zKK-0002py-TJ; Tue, 30 May 2023 09:23:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q3zJh-0000kF-0u
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:23:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q3zJd-000072-IF
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685452988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=paoOWoRp/3otlgIAgpwRBL/dAxaz2g8vyLl/NfCWtiM=;
 b=E9SmRDSJYpPd/mmdAoIT4nwsQwl2pSRJwMZprfzblSNjaKTNwkhTmpiNB6F5ozM8/esilU
 LWaYUhBBgf62mgM9qquml93IfYQPtpW1Z3JgC50pZOjan27t4FL85gKQkgv5wI0+cO24Nr
 p0Fds4d19zNrgq6Q+janqAy4znaCEqI=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-lk0knFg4P0i88VtGOrCMbA-1; Tue, 30 May 2023 09:23:06 -0400
X-MC-Unique: lk0knFg4P0i88VtGOrCMbA-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7837dfe3b00so3710359241.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685452986; x=1688044986;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=paoOWoRp/3otlgIAgpwRBL/dAxaz2g8vyLl/NfCWtiM=;
 b=DKKnt+AUE/ygu0OBjm8o1MpCIvvmfkRrH5JL9YHJuc8lbte/DyultqzLVH2DXBJxZs
 R1O19nJ1oLlWvKSkIp9jaWOXrGYD9uQdn3+V6Fzl1vEmtu3bOL1nF4JNk30GQ/0K+mEl
 wGPGSWl0nxaH+n+JuwRm1vleQkr3X/geAk79TO7s4KEQoGsJdPIWLYdq7I7trzj6Tvps
 cGorY0DIxVb0NAZKbr8zxYGz5u0wSQv6X6ntFdOMYSBAcIP1y084IVqu8OTYzfXseAzo
 ULQAytJCoUhQO3q1D4UHyGsK64abc0eYyQOZuqk8V9OMarbaUi+7Pre1S0iJfs/cfLFQ
 Kvdg==
X-Gm-Message-State: AC+VfDzW0PMYpMSdEEbcIIfWZrfJsvau/uyjUjk5pGbAtX7uuW98Zqm2
 vZMTIxOD9BCwiGocwo12CHX0K3OUKjKfXyELclNNff+vpcqoKjUv5Q1fOHrLDLVjoFyLWZFIL99
 NQVlN/kWii79yeveuouI0hNnWOG9UXuw=
X-Received: by 2002:a05:6102:3e29:b0:439:3e26:990e with SMTP id
 j41-20020a0561023e2900b004393e26990emr3954608vsv.6.1685452986461; 
 Tue, 30 May 2023 06:23:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4r+uowCxIUYO1xYKRpN6tqB+DqZ/qUgNPtszf1iaGQP+YRewnNEqqwRC0hZ7Gp8E14ayfhFlmVD/24xDtKdf4=
X-Received: by 2002:a05:6102:3e29:b0:439:3e26:990e with SMTP id
 j41-20020a0561023e2900b004393e26990emr3954604vsv.6.1685452986264; Tue, 30 May
 2023 06:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230527092851.705884-1-pbonzini@redhat.com>
 <3188708d-f7ae-27c2-7bb2-0ac50b08c79a@redhat.com>
 <ZHXyqdwAW38ZWk7Y@redhat.com>
In-Reply-To: <ZHXyqdwAW38ZWk7Y@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 May 2023 15:22:55 +0200
Message-ID: <CABgObfagAp_L6w+fkA8=9TRs_=ZKHp24TYZgQLxom7-o=SY7bQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] meson: replace submodules with wrap files
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, qemu-s390x <qemu-s390x@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, May 30, 2023 at 2:57=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> > > I'm not sure what's the best way to proceed for roms/SLOF.  Some
> > > possibilities, in no particular order, include:
> > >
> > > * doing nothing
> > >
> > > * merging --with-git-submodules with --enable-download, and
> > >    moving the git-submodule.sh rules from the main Makefile to
> > >    pc-bios/s390-ccw/ (my favorite option)
> > >
> > > * copying the relevant SLOF files into pc-bios/
> >
> > Considering that SLOF is also rather on life support already (there is =
now
> > VOF for the sPAPR machine instead, Alexey left IBM, ...), I also wouldn=
't
> > mind the third option, I think.
> >
> > But of course we can also start with option 2 and go for option 3 later=
.
>
> My inclination would be for option 3 too, just copy the relevant files
> into s390-ccw dir, so the two distinct ROMs are fully separated from
> each other.

Note that the amount of code is not small (7.000 lines of source for the
network stack and 1.000 for libc); but yeah, that can be done.

Paolo


