Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF1074DD30
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 20:18:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIvRK-00064A-DF; Mon, 10 Jul 2023 14:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIvRG-000633-E6
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 14:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIvRE-0008Hu-Lp
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 14:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689013002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gJUM4XPgnfoXsI2lwP614aXh7T2XKCBnIRGXXSTypX4=;
 b=gxUnHGwsxOvFx5oLPOaEzabBgBV18SjojfnLb7CfzuNpdzswVfVrYvg34/bOhUCj3dY70K
 plEktVcc4MWe+tEAV/+2joLUBl+uWu/AXiRB2PEcacxA+CPqoLBaKGcNu7F+g7HDkvjzNU
 +Abd2XO4yH/fU/R0DMy9FQzvGSaxqY4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-TqUKTstdMjilWOehxXskRA-1; Mon, 10 Jul 2023 14:16:41 -0400
X-MC-Unique: TqUKTstdMjilWOehxXskRA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fc0627eafbso11704925e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 11:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689012999; x=1691604999;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gJUM4XPgnfoXsI2lwP614aXh7T2XKCBnIRGXXSTypX4=;
 b=Zv/KPekDUQlyceSfUVzWIP5yL6T1F2f6dAUhGiO5SgL5Hq0n/y0B93SL5mz5j0q6bP
 db2vMnydzSB+66qVPVH4roWtM9F2gx8cwNuXjoVf50sUhN34CvfzHqoh/qbxjXI8mzEb
 jkblSHbYxQUzwO/GWrDWmCtQmMk+UkgfkPFfslpN6Rf2QbFDUBGx+LGo0VFWeD+/612J
 dWZTzy6wVgoZ9fkJ6qd+3vG45NH6IvJyy0aDwuwsbVz1+DHzHCoyjIXG23FNPJUHe0MJ
 sZKtbdoDodYDCxBlEHFbSggEXfDRgmtJ6jpzQ2lHlYpXOWNoRGXbqWQfJLIk5/hmUTun
 QvCA==
X-Gm-Message-State: ABy/qLYAV++B8MPW8ccz0yZHFjwxcjdzsr4yCSI/sDrfpDae8aSEgrK/
 i5ZKfbm5IhAcQ3rZ+W9qRrf3z8ckOj3Ux0X2qHjsToJIA8NPvoSPBIzsDLap2Wi2MgyzRIqi2ia
 G/O/zkfnoEhqeep8=
X-Received: by 2002:a05:600c:3501:b0:3fa:7c6b:86e with SMTP id
 h1-20020a05600c350100b003fa7c6b086emr15732925wmq.12.1689012999502; 
 Mon, 10 Jul 2023 11:16:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFIEwB4MP5ioLWfc/USn8VSvAljv7vuMbMkp7oLJsGgOyPQXI5yAPYSaxNPEQWFgFZArXZ7GA==
X-Received: by 2002:a05:600c:3501:b0:3fa:7c6b:86e with SMTP id
 h1-20020a05600c350100b003fa7c6b086emr15732916wmq.12.1689012999164; 
 Mon, 10 Jul 2023 11:16:39 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 y18-20020adffa52000000b00313f031876esm82350wrr.43.2023.07.10.11.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 11:16:38 -0700 (PDT)
Date: Mon, 10 Jul 2023 14:16:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Leonardo Bras Soares Passos <leobras@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] pcie: Add hotplug detect state register to cmask
Message-ID: <20230710141622-mutt-send-email-mst@kernel.org>
References: <20230706045546.593605-3-leobras@redhat.com> <ZKbRRt8ESGsMz+o7@x1n>
 <CAJ6HWG4iUX=+7FTCkXitFfc1zFNJ9aR5PzDRyPLSZVq1Kos8fA@mail.gmail.com>
 <ZKcEjfTDDgDZWu9Q@x1n>
 <20230706144844-mutt-send-email-mst@kernel.org>
 <ZKcPr3gueuOM4LGY@x1n>
 <20230706155936-mutt-send-email-mst@kernel.org>
 <CAJ6HWG6hVBCRE3yVF-Yiu8om0YSOiu_iZHPT2KKuOiLbaYtkYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ6HWG6hVBCRE3yVF-Yiu8om0YSOiu_iZHPT2KKuOiLbaYtkYw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Mon, Jul 10, 2023 at 02:49:05PM -0300, Leonardo Bras Soares Passos wrote:
> On Thu, Jul 6, 2023 at 5:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jul 06, 2023 at 03:02:07PM -0400, Peter Xu wrote:
> > > On Thu, Jul 06, 2023 at 02:50:20PM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, Jul 06, 2023 at 02:14:37PM -0400, Peter Xu wrote:
> > > > > On Thu, Jul 06, 2023 at 03:07:40PM -0300, Leonardo Bras Soares Passos wrote:
> > > > > > > I asked the same question, and I still keep confused: whether there's a
> > > > > > > first bad commit?  Starting from when it fails?
> > > > > > >
> > > > > > > For example, is this broken on 6.0 binaries too with pc-q35-6.0?
> > > > > >
> > > > > > I tested for qemu 6.0, and it still reproduces, but have not pursued
> > > > > > this any further.
> > > > >
> > > > > I see, thanks!
> > > > >
> > > > > But then do you know why it's never hit before?  I assume it means this bug
> > > > > has been there for a long time.
> > > >
> > > > It's a race - you have to migrate after the bit has been set before
> > > > the bit got cleared.
> > > > cmask is exactly for bits that qemu modifies itself.
> > >
> > > Michael, do you mean that Leo's patch is wrong?
> >
> >
> > I mean his patch is exactly right. cmask was designed with this
> > kind of use case in mind.
> > Will queue.
> 
> Thanks Michael!
> 
> Any chance this will get in on time for v8.1 ?

Yes, working on pull request now.


> >
> > > I just got understood why it got cleared - I think Leo didn't mention that
> > > the device was actually offlined before migration, IIUC that's why the PDS
> > > bit got cleared, if PDS was trying to describe that of the slot.
> > >
> > > According to:
> > >
> > >     /* Used to enable checks on load. Note that writable bits are
> > >      * never checked even if set in cmask. */
> > >     uint8_t *cmask;
> > >
> > > It does sound reasonable to me to have PDS cleared when device offlined.
> > > Since hypervisor doesn't really know what the condition the slot presence
> > > bit would be when migrating, it seems we should just clear the bit in
> > > cmask.
> > >
> > > So with the last reply from Leo, the patch looks all right to me.  It's
> > > just that as Leo mentioned, we should mention the offline process if that's
> > > the case, because that's definitely an important step to reproduce the issue.
> > >
> > > Thanks,
> >
> > If you want to suggest more text to the commit log, for the benefit
> > of backporters, that is fine by me.
> >
> > > --
> > > Peter Xu
> >


