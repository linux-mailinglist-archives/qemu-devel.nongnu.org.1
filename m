Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCF774E06D
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 23:49:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIyk0-0005Nv-Ks; Mon, 10 Jul 2023 17:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1qIyjy-0005Nl-Rj
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 17:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1qIyjx-0007YD-AP
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 17:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689025696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPQ56Iw959TpJdq0C/FpY2Haxyv3PjUmIVEGg5Vz8t8=;
 b=ZHY/S4dqRUOoCeI8cyytGDSI7L23BIrdkzlMNa476D90l+9qyelqmaNq3eX3jxl7xxDIub
 yRNdSA+/V+T1ty5+ezroc17kh6zeN29MTd2MJ8ejPZDB7Jip5Isfi5OozfPEy12d16e6/e
 7jjUDPDqqDYXZdtd3aatjZ6uZ6pxtso=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-AbiFKac4MOW-RaRhaKALjg-1; Mon, 10 Jul 2023 17:48:14 -0400
X-MC-Unique: AbiFKac4MOW-RaRhaKALjg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-767cf9caaa9so104465785a.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 14:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689025694; x=1691617694;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DPQ56Iw959TpJdq0C/FpY2Haxyv3PjUmIVEGg5Vz8t8=;
 b=ZMzE0dYdDynW9E2dzz/oMkRnpiZh6lwXxq6xvzVhtHtsDtdXYDJ1S5iYWB9ch9i/ba
 j6Kvu9Tcfhl0yGK42IkvocOhyVCowHZCsW7OaSUKaCRf4O+aWJRAeK3dylKhXJRqEfvy
 A+f/9qwhci/fJ5JWoBkZ6H41f5X2RWsMFZyTEvxTTm0UnBpg8HR8vMR37H/KbCFwzKeS
 DEJJglgWdhuGsh0Xxg2QMvtBVp+z1tHhzDqnwIut+S7jETL2mX4zOIuCm4GARgZzUiry
 XI2XTZV27Uth2aD9AvEbOgOTwbPJIDnZ+ny+jtuF/PBoS5ILukmxpnizdgewGfcjqKSf
 FVQw==
X-Gm-Message-State: ABy/qLYs8FjzE9k/AvhM/zp/IOuXsnRq8HLMPXFifLJ8OJXcv1D8knqy
 bAhCXyAuwPizBSh4/c+d1b9KclzFOX7+Y3B0W8j/WhTVmzmHBaccpGr825JMH4YJ9Rs8hmbhGKg
 SsLVYO8qQSXba/ft23/2qwWwXrHcUU08=
X-Received: by 2002:ac8:5a95:0:b0:3f8:2a37:20f with SMTP id
 c21-20020ac85a95000000b003f82a37020fmr17698048qtc.34.1689025693985; 
 Mon, 10 Jul 2023 14:48:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEe9fB9Jf3DdRzSIc1ai4cgYHBkzOUWHf7wJEtNCRNhhuuRshDzY2wLrZVJvfADeGombp+qgehyQcm1I9H3Uvg=
X-Received: by 2002:ac8:5a95:0:b0:3f8:2a37:20f with SMTP id
 c21-20020ac85a95000000b003f82a37020fmr17698035qtc.34.1689025693743; Mon, 10
 Jul 2023 14:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230706045546.593605-3-leobras@redhat.com> <ZKbRRt8ESGsMz+o7@x1n>
 <CAJ6HWG4iUX=+7FTCkXitFfc1zFNJ9aR5PzDRyPLSZVq1Kos8fA@mail.gmail.com>
 <ZKcEjfTDDgDZWu9Q@x1n> <20230706144844-mutt-send-email-mst@kernel.org>
 <ZKcPr3gueuOM4LGY@x1n> <20230706155936-mutt-send-email-mst@kernel.org>
 <CAJ6HWG6hVBCRE3yVF-Yiu8om0YSOiu_iZHPT2KKuOiLbaYtkYw@mail.gmail.com>
 <20230710141622-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230710141622-mutt-send-email-mst@kernel.org>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Mon, 10 Jul 2023 18:48:02 -0300
Message-ID: <CAJ6HWG7HHwf2HcDXJYbJgDRPhTWQDv8OF85mEe+Tpfn-cU7WAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pcie: Add hotplug detect state register to cmask
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lsoaresp@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jul 10, 2023 at 3:16=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Jul 10, 2023 at 02:49:05PM -0300, Leonardo Bras Soares Passos wro=
te:
> > On Thu, Jul 6, 2023 at 5:00=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Thu, Jul 06, 2023 at 03:02:07PM -0400, Peter Xu wrote:
> > > > On Thu, Jul 06, 2023 at 02:50:20PM -0400, Michael S. Tsirkin wrote:
> > > > > On Thu, Jul 06, 2023 at 02:14:37PM -0400, Peter Xu wrote:
> > > > > > On Thu, Jul 06, 2023 at 03:07:40PM -0300, Leonardo Bras Soares =
Passos wrote:
> > > > > > > > I asked the same question, and I still keep confused: wheth=
er there's a
> > > > > > > > first bad commit?  Starting from when it fails?
> > > > > > > >
> > > > > > > > For example, is this broken on 6.0 binaries too with pc-q35=
-6.0?
> > > > > > >
> > > > > > > I tested for qemu 6.0, and it still reproduces, but have not =
pursued
> > > > > > > this any further.
> > > > > >
> > > > > > I see, thanks!
> > > > > >
> > > > > > But then do you know why it's never hit before?  I assume it me=
ans this bug
> > > > > > has been there for a long time.
> > > > >
> > > > > It's a race - you have to migrate after the bit has been set befo=
re
> > > > > the bit got cleared.
> > > > > cmask is exactly for bits that qemu modifies itself.
> > > >
> > > > Michael, do you mean that Leo's patch is wrong?
> > >
> > >
> > > I mean his patch is exactly right. cmask was designed with this
> > > kind of use case in mind.
> > > Will queue.
> >
> > Thanks Michael!
> >
> > Any chance this will get in on time for v8.1 ?
>
> Yes, working on pull request now.

Thanks!

>
>
> > >
> > > > I just got understood why it got cleared - I think Leo didn't menti=
on that
> > > > the device was actually offlined before migration, IIUC that's why =
the PDS
> > > > bit got cleared, if PDS was trying to describe that of the slot.
> > > >
> > > > According to:
> > > >
> > > >     /* Used to enable checks on load. Note that writable bits are
> > > >      * never checked even if set in cmask. */
> > > >     uint8_t *cmask;
> > > >
> > > > It does sound reasonable to me to have PDS cleared when device offl=
ined.
> > > > Since hypervisor doesn't really know what the condition the slot pr=
esence
> > > > bit would be when migrating, it seems we should just clear the bit =
in
> > > > cmask.
> > > >
> > > > So with the last reply from Leo, the patch looks all right to me.  =
It's
> > > > just that as Leo mentioned, we should mention the offline process i=
f that's
> > > > the case, because that's definitely an important step to reproduce =
the issue.
> > > >
> > > > Thanks,
> > >
> > > If you want to suggest more text to the commit log, for the benefit
> > > of backporters, that is fine by me.
> > >
> > > > --
> > > > Peter Xu
> > >
>


