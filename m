Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38234705526
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 19:40:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyydY-0006ls-M2; Tue, 16 May 2023 13:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pyydW-0006lk-Ko
 for qemu-devel@nongnu.org; Tue, 16 May 2023 13:38:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pyydU-00017W-Ve
 for qemu-devel@nongnu.org; Tue, 16 May 2023 13:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684258736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G7JGMjrkbABMXmudfgjOwEmUZFJhzeLKxKLcXPj6Fso=;
 b=KRA8bo/3JK9izibu72tDcbgNmcoTaS2QDNlvi6idksoR7blblWRtaoUpAEJm+4FaWcibbx
 GAjhBnkG36F4Dbz7ueZmX4wbZpwL+oJ+dhmFd9EpfGJq1JqniHPFxFNzXKms1RX5aAjlDg
 4antL9sef/Pq8V1zHooPyieghQB9Tlk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-EIF2v712OEyoWwhHKkvK1g-1; Tue, 16 May 2023 13:38:54 -0400
X-MC-Unique: EIF2v712OEyoWwhHKkvK1g-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6434336147cso8246264b3a.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 10:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684258733; x=1686850733;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G7JGMjrkbABMXmudfgjOwEmUZFJhzeLKxKLcXPj6Fso=;
 b=S9RDo/b6DSeMECi4yHxHqnZZIPCLVQte1IJ4+ouctJHUiQZVQkQoy5wHF7ux7qZTPi
 UXjMfohi0taAYvoVYTwSIpBBuiBGPbHqC+cwkz+/SyQzsNpKjrJOigJVAEmq/eYD875G
 HU+Gz6B8xsBJNvNNdmqXH+l+bUjF88d1eXOecF52K+NxfxV+c4HQWMO1nM7iI/CS7aYt
 xPzXn7DjivT1DKSFPrUxYslxz1ZtXr3jTgN3goI+qGPdpOeoTzE29xecK7qKxT+e0LE0
 22SX8jeQdMCnvP4Bi2LapIDI74HXLoebVfDlLpi7By3llQ3G4b+HV4C7PiHxfXJzXg+4
 GRnQ==
X-Gm-Message-State: AC+VfDyprzmCnNqjxCTwgeuIBokuLN5vh/bqR0YRNLY0XYsg0+VntXDm
 bADEjg4CxvbZ7YyPoyUyWyk4TpNYcYsm89t4WH1GLQ5Yc24Q6avOKjoiOMs/fXkKD2JZD4XW1+5
 /9ms3EV8xU/CJyspEoMgvLoxJ3i3yv3I=
X-Received: by 2002:a05:6a00:189a:b0:646:7234:cbfc with SMTP id
 x26-20020a056a00189a00b006467234cbfcmr42825197pfh.27.1684258733624; 
 Tue, 16 May 2023 10:38:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5DqjD5Mv/y/nBF5tNjAvtQEFBbZtdinKk9xVA0Nn3QAhyxhf+TjPJwds4k7CJPEPxrICXCVe7WEr6J8AcMekw=
X-Received: by 2002:a05:6a00:189a:b0:646:7234:cbfc with SMTP id
 x26-20020a056a00189a00b006467234cbfcmr42825176pfh.27.1684258733316; Tue, 16
 May 2023 10:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210317070046.17860-1-olaf@aepfle.de>
 <4441d32f-bd52-9408-cabc-146b59f0e4dc@redhat.com>
 <20210325121219.7b5daf76.olaf@aepfle.de>
 <dae251e1-f808-708e-902c-05cfcbbea9cf@redhat.com>
 <20230509225818.GA16290@aepfle.de> <20230510094719.26fb79e5.olaf@aepfle.de>
 <alpine.DEB.2.22.394.2305121411310.3748626@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2305121411310.3748626@ubuntu-linux-20-04-desktop>
From: John Snow <jsnow@redhat.com>
Date: Tue, 16 May 2023 13:38:42 -0400
Message-ID: <CAFn=p-aFa_jFYuaYLMumkX=5zpn228ctBcV=Gch=BhmQs6i2dA@mail.gmail.com>
Subject: Re: [PATCH v2] piix: fix regression during unplug in Xen HVM domUs
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Olaf Hering <olaf@aepfle.de>, Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel@lists.xenproject.org, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

On Fri, May 12, 2023 at 5:14=E2=80=AFPM Stefano Stabellini
<sstabellini@kernel.org> wrote:
>
> On Wed, 10 May 2023, Olaf Hering wrote:
> > Wed, 10 May 2023 00:58:27 +0200 Olaf Hering <olaf@aepfle.de>:
> >
> > > In my debugging (with v8.0.0) it turned out the three pci_set_word
> > > causes the domU to hang. In fact, it is just the last one:
> > >
> > >    pci_set_byte(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */
> > >
> > > It changes the value from 0xc121 to 0x1.
> >
> > If I disable just "pci_set_word(pci_conf + PCI_COMMAND, 0x0000);" it wo=
rks as well.
> > It changes the value from 0x5 to 0.
> >
> > In general I feel it is wrong to fiddle with PCI from the host side.
> > This is most likely not the intention of the Xen unplug protocol.
> > I'm sure the guest does not expect such changes under the hood.
> > It happens to work by luck with pvops kernels because their PCI discove=
ry
> > is done after the unplug.
> >
> > So, what do we do here to get this off the table?
>
> I don't have a concrete suggestion because I don't understand the root
> cause of the issue. Looking back at Paolo's reply from 2021
>
> https://marc.info/?l=3Dxen-devel&m=3D161669099305992&w=3D2
>
> I think he was right. We can either fix the root cause of the issue or
> avoid calling qdev_reset_all on unplug. I am OK with either one.

I haven't touched IDE or block code in quite a long while now -- I
don't think I can help land this fix, but I won't get in anyone's way,
either. Maybe just re-submit the patches with an improved commit
message / cover letter that helps collect the info from the previous
thread, the core issue, etc.

--js


