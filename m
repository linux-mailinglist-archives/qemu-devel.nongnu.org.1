Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7A77DB8F9
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 12:31:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxQTS-00076Z-BJ; Mon, 30 Oct 2023 07:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxQT9-0006ub-NX
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxQT7-0003LE-Hm
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698665403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N0O5YJfEz74KjymztnXo5jXWwpsKIUtP6vQ4qH0GuQ8=;
 b=MYvEjXQ1hWwfTLVMpbA427hdxkOA8kHU1ux8AcbeL5AlEnX6vB7DVIAn1H398XkEcSS/cQ
 PPL4oHDbPEe1QZqO4WrVTYWPl80azEtKzWNIhyq7ZYA+ouLr8htOl4HFTAXKtP8VugZ/bT
 79eapicYnTKiEIJI0zWQrsufojYRe+Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-_szieYT7Oye7EMrZcnHGhA-1; Mon,
 30 Oct 2023 07:30:00 -0400
X-MC-Unique: _szieYT7Oye7EMrZcnHGhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20E081C0F47C;
 Mon, 30 Oct 2023 11:30:00 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DC432166B29;
 Mon, 30 Oct 2023 11:29:59 +0000 (UTC)
Date: Mon, 30 Oct 2023 12:29:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH 01/11] qdev: Add qdev_prop_set_array()
Message-ID: <ZT+Ttkj1b61mGu4P@redhat.com>
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-2-kwolf@redhat.com>
 <CAFEAcA9nEvr+ALhhMC3L62hyuKo6s3AfsJXb==QOq6_-SRws9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9nEvr+ALhhMC3L62hyuKo6s3AfsJXb==QOq6_-SRws9g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 27.10.2023 um 20:06 hat Peter Maydell geschrieben:
> On Fri, 8 Sept 2023 at 15:37, Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Instead of exposing the ugly hack of how we represent arrays in qdev (a
> > static "foo-len" property and after it is set, dynamically created
> > "foo[i]" properties) to boards, add an interface that allows setting the
> > whole array at once.
> >
> > Once all internal users of devices with array properties have been
> > converted to use this function, we can change the implementation to move
> > away from this hack.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/hw/qdev-properties.h |  3 +++
> >  hw/core/qdev-properties.c    | 21 +++++++++++++++++++++
> >  2 files changed, 24 insertions(+)
> >
> > diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> > index e1df08876c..7fa2fdb7c9 100644
> > --- a/include/hw/qdev-properties.h
> > +++ b/include/hw/qdev-properties.h
> > @@ -206,6 +206,9 @@ void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
> >                             const uint8_t *value);
> >  void qdev_prop_set_enum(DeviceState *dev, const char *name, int value);
> >
> > +/* Takes ownership of @values */
> > +void qdev_prop_set_array(DeviceState *dev, const char *name, QList *values);
> > +
> >  void *object_field_prop_ptr(Object *obj, Property *prop);
> 
> Are we happy enough with this interface that I can take this single
> patch in a series that I'm doing (v2 of
> https://patchew.org/QEMU/20231017122302.1692902-1-peter.maydell@linaro.org/
> "arm/stellaris: convert gamepad input device to qdev"), or should
> I stick to the old style "set length and element properties by hand"
> code until this whole series has passed patch review (thus giving
> you another item to add to the conversion list) ? I went for "include
> this patch" in v1, but this series has spent longer in code review
> than I was anticipating at that point.

As far as I am concerned, feel free to include it in your series.

I'm also planning to send v2 of this series soon, I think I'm only
missing the build time assertion to check the correct alignment that
Markus wants to see.

Kevin


