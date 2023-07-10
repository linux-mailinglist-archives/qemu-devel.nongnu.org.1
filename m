Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E34E374DCC3
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 19:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIv0x-0000Ex-3D; Mon, 10 Jul 2023 13:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1qIv0m-0000CS-Av
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1qIv0k-000890-Mz
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 13:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689011359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ymqNW8BGok24ypIMWdiRrsitEMNDacj9S7wMx7fwpVM=;
 b=DwcPa7WHhWPvcs1M8is3QFVyR9vEl5EkNtwi+Vejh6Gju4ye/YFXmAgpGhtCDmO2ALZe2u
 UOHKtW9hW282m+0I9IiSDJ1hdksqSthW/mPNBzGjhFAuwcGNJXHtLlfLCHQNAratLOFwjN
 e5OcpdGeLNQW+CHSOn0/g04zapaz9qw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-vueKt7dLMwSCMYAc4T4gKw-1; Mon, 10 Jul 2023 13:49:18 -0400
X-MC-Unique: vueKt7dLMwSCMYAc4T4gKw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76752bc38bcso704446485a.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 10:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689011358; x=1691603358;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ymqNW8BGok24ypIMWdiRrsitEMNDacj9S7wMx7fwpVM=;
 b=L8a0X5Ej+DF2qvoW9WWQkPSP5p0KSQ7SmEC4OJkJKiV4ZmCTEo69HFwC09dz9ochmy
 GABIPNdeU7/ABbB65dF/BLQC5/1Jyl71435oipPGVGt6zzblscfUhX4hosx1F6Ms9Hl9
 jxakt56HpcZL+uBB6Ai0GOGTCvlfcV0Qm+cVvYgVnm8kGPM5ty1J6BGDtSBrA++iMnGc
 3b9/oDBIBSAoWZqMUTULk8wHhUyg+g3fyMuE1hr+hNmHpAzkQVF3qG10ge0Cq4Fb008J
 LbOtK1K9gyx18cmo/UOt8n3/q5nF1ThmZtWaEWujCMMbSplpxSg6uG4Ghejki2yAC0KV
 Zw9w==
X-Gm-Message-State: ABy/qLajt03c1Imgsd30Ud7yjq+CVFX7wJBKLO7vKix8kacFqnPAPm3r
 JUHv3Wvu164F+lVpQQTLBg8UgB3iCXe8ddGR9gtB1QQUyO7DtcDyha0PuJl8cCbVhEiiTrLoIK0
 OQFKYM6mnrEYryGA15L27KFCX5NQsb3g=
X-Received: by 2002:a05:622a:3c8:b0:403:3859:d20a with SMTP id
 k8-20020a05622a03c800b004033859d20amr16243847qtx.24.1689011358096; 
 Mon, 10 Jul 2023 10:49:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFghnVlq2CZR77AoBTZIuzEe38ahCQAMoBkovvr3V3xtrh30unuDXkmLuXIziERFFHbTYQTv3ekr55AOQOmbmQ=
X-Received: by 2002:a05:622a:3c8:b0:403:3859:d20a with SMTP id
 k8-20020a05622a03c800b004033859d20amr16243834qtx.24.1689011357861; Mon, 10
 Jul 2023 10:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230706045546.593605-3-leobras@redhat.com> <ZKbRRt8ESGsMz+o7@x1n>
 <CAJ6HWG4iUX=+7FTCkXitFfc1zFNJ9aR5PzDRyPLSZVq1Kos8fA@mail.gmail.com>
 <ZKcEjfTDDgDZWu9Q@x1n> <20230706144844-mutt-send-email-mst@kernel.org>
 <ZKcPr3gueuOM4LGY@x1n> <20230706155936-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230706155936-mutt-send-email-mst@kernel.org>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Mon, 10 Jul 2023 14:49:05 -0300
Message-ID: <CAJ6HWG6hVBCRE3yVF-Yiu8om0YSOiu_iZHPT2KKuOiLbaYtkYw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pcie: Add hotplug detect state register to cmask
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lsoaresp@redhat.com;
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

On Thu, Jul 6, 2023 at 5:00=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Jul 06, 2023 at 03:02:07PM -0400, Peter Xu wrote:
> > On Thu, Jul 06, 2023 at 02:50:20PM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Jul 06, 2023 at 02:14:37PM -0400, Peter Xu wrote:
> > > > On Thu, Jul 06, 2023 at 03:07:40PM -0300, Leonardo Bras Soares Pass=
os wrote:
> > > > > > I asked the same question, and I still keep confused: whether t=
here's a
> > > > > > first bad commit?  Starting from when it fails?
> > > > > >
> > > > > > For example, is this broken on 6.0 binaries too with pc-q35-6.0=
?
> > > > >
> > > > > I tested for qemu 6.0, and it still reproduces, but have not purs=
ued
> > > > > this any further.
> > > >
> > > > I see, thanks!
> > > >
> > > > But then do you know why it's never hit before?  I assume it means =
this bug
> > > > has been there for a long time.
> > >
> > > It's a race - you have to migrate after the bit has been set before
> > > the bit got cleared.
> > > cmask is exactly for bits that qemu modifies itself.
> >
> > Michael, do you mean that Leo's patch is wrong?
>
>
> I mean his patch is exactly right. cmask was designed with this
> kind of use case in mind.
> Will queue.

Thanks Michael!

Any chance this will get in on time for v8.1 ?

>
> > I just got understood why it got cleared - I think Leo didn't mention t=
hat
> > the device was actually offlined before migration, IIUC that's why the =
PDS
> > bit got cleared, if PDS was trying to describe that of the slot.
> >
> > According to:
> >
> >     /* Used to enable checks on load. Note that writable bits are
> >      * never checked even if set in cmask. */
> >     uint8_t *cmask;
> >
> > It does sound reasonable to me to have PDS cleared when device offlined=
.
> > Since hypervisor doesn't really know what the condition the slot presen=
ce
> > bit would be when migrating, it seems we should just clear the bit in
> > cmask.
> >
> > So with the last reply from Leo, the patch looks all right to me.  It's
> > just that as Leo mentioned, we should mention the offline process if th=
at's
> > the case, because that's definitely an important step to reproduce the =
issue.
> >
> > Thanks,
>
> If you want to suggest more text to the commit log, for the benefit
> of backporters, that is fine by me.
>
> > --
> > Peter Xu
>


