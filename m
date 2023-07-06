Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DFC74A3DC
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 20:39:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHTri-0006gj-R1; Thu, 06 Jul 2023 14:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1qHTrf-0006gU-PB
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1qHTrd-0005KW-Qi
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688668680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o1Aej7Pgvvhbgtm6+O++ixwM0i0bggEXgnRS6utJyys=;
 b=DVZMwGd4TMIUEfCvbjfD832TCrJwkWagdm6rESik+2D9F9ttQx9C8joCXrVA/KkF2S37wX
 8upxaSBHBiVFP0G7dYDOVNCaRKYXmUXMBCSQ3CknxKkOMVkwNffUP01klQfCMTssqIEOYg
 a5VNsKjq5UuHdkiWeX1tzW+tQcIJvUQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-1uDKkRQ5MrKqLpvsN-B0Ag-1; Thu, 06 Jul 2023 14:37:59 -0400
X-MC-Unique: 1uDKkRQ5MrKqLpvsN-B0Ag-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-40351198686so11067881cf.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 11:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688668679; x=1691260679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1Aej7Pgvvhbgtm6+O++ixwM0i0bggEXgnRS6utJyys=;
 b=KEdAiGxeUQ3vTGxjj6TOkB6mFwRGTZMB4LiN0XSgtpny6PjzoxNfWPWCWUQb+UfAdI
 RpdaJFv9TLJTICWHIZ+cki7cNlm/iV9H2rhG4GqkqgP3wF7F8PPESRxVVwUgTQ7n4gAU
 bLjAcBqU9hDjh8DzkT9hO3Q/P//owUsZte4Vb/8wPdaoeRMwWfLoEFol9AvUWenn67yn
 qBdPoXlpIvYl8dmYt6eU0TCHT0sLkjYDIf5Fjxiq9mDoFJThCdfZmZXmyEa07k7jLjnd
 t+xIVx7IxlihXlnhjmLywg/n3DAZv7e9CS5Pyy/NF7a23nTr2wlVkJ5f+XOoDnwtt2nB
 AUKg==
X-Gm-Message-State: ABy/qLb3u7+lnt1t303CgpdPqIK0RwnDdIq7dO0uFemBVPFoI2hOnEJv
 rCnIqD+Vrt3PBr45HVowdi1xZDLskx+U0E1Z1DVZwROWNvkU86KTFg6rPaXWZqWmlKHX6BHmLnG
 lNiIyDha+pODXLkMmsiOc0yEE0K31OU4=
X-Received: by 2002:a05:622a:82:b0:403:3a32:2b53 with SMTP id
 o2-20020a05622a008200b004033a322b53mr3330676qtw.50.1688668679071; 
 Thu, 06 Jul 2023 11:37:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGVGfuaB9HXv32ipqYyR7M8QJzDVnGUuz07H/Fsi8rix9feW+4KTxLLK25ys5cFy9ccxC9iCKeABDXhtnz+Juc=
X-Received: by 2002:a05:622a:82:b0:403:3a32:2b53 with SMTP id
 o2-20020a05622a008200b004033a322b53mr3330661qtw.50.1688668678850; Thu, 06 Jul
 2023 11:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230706045546.593605-3-leobras@redhat.com> <ZKbRRt8ESGsMz+o7@x1n>
 <CAJ6HWG4iUX=+7FTCkXitFfc1zFNJ9aR5PzDRyPLSZVq1Kos8fA@mail.gmail.com>
 <ZKcEjfTDDgDZWu9Q@x1n>
In-Reply-To: <ZKcEjfTDDgDZWu9Q@x1n>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Thu, 6 Jul 2023 15:37:48 -0300
Message-ID: <CAJ6HWG7LPC=xwiYM7NuAQJAr8jYaVY=XbpdT6tZg+TxF9YaQjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pcie: Add hotplug detect state register to cmask
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
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

On Thu, Jul 6, 2023 at 3:24=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Jul 06, 2023 at 03:07:40PM -0300, Leonardo Bras Soares Passos wro=
te:
> > > I asked the same question, and I still keep confused: whether there's=
 a
> > > first bad commit?  Starting from when it fails?
> > >
> > > For example, is this broken on 6.0 binaries too with pc-q35-6.0?
> >
> > I tested for qemu 6.0, and it still reproduces, but have not pursued
> > this any further.
>
> I see, thanks!
>
> But then do you know why it's never hit before?  I assume it means this b=
ug
> has been there for a long time.


Oh, I totally missed updating the commit msg  on this:

---
In this scenario, hotplug_handler_plug() calls pcie_cap_slot_plug_cb(),
which sets dev->config byte 0x6e with bit PCI_EXP_SLTSTA_PDS to signal PCI
- hotplug for the guest. After a while the guest will deal with this hotplu=
g
- and qemu will clear the above bit.
+ hotplug for the guest. After a while, if the guest powers down the device
+ qemu will clear the above bit.
---

The whole idea is that the guest powers down the device, which causes
qemu to hot-remove it, and clear PCI_EXP_SLTSTA_PDS.

---
 /*
     * If the slot is populated, power indicator is off and power
     * controller is off, it is safe to detach the devices.
     *
     * Note: don't detach if condition was already true:
     * this is a work around for guests that overwrite
     * control of powered off slots before powering them on.
     */
    if ((sltsta & PCI_EXP_SLTSTA_PDS) && pcie_sltctl_powered_off(val) &&
        !pcie_sltctl_powered_off(old_slt_ctl))
    {
        pcie_cap_slot_do_unplug(dev); // clear PCI_EXP_SLTSTA_PDS
    }
---

Since the bit is different on source & target qemu, the migration is aborte=
d.


>
> --
> Peter Xu
>

Thanks for reviewing Peter!
I will send a v3 with the updated commit msg and add the comments
suggested by Juan in the source code.

Thanks!
Leo


