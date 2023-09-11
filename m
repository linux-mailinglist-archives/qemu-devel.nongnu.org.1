Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6DF79AA4C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 18:42:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfjzG-0004pe-PR; Mon, 11 Sep 2023 12:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfjzF-0004p1-JF
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 12:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfjzD-0001v6-3V
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 12:42:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694450526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2VnztMFKAzsUnXeNZnTGZ6zsfYPr1762K+8hCZCb06U=;
 b=W89RWriURFXju8Zt1np7R6jxIk3nyI92ZP9Q7F2FtRYYkeJMncL5XTrBvq129+1FeXDaKr
 gUlNtCbcWmvXZ2nI64W/CVwPFqB23k+CknN6BaOB7JouNN2CfVxucvKCNzFZm4/DzpRATP
 xtDaecf7qBJskXyKXugXyUB50By6uhE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-DXBnNQYmPfeMZxLA1a0qOA-1; Mon, 11 Sep 2023 12:42:05 -0400
X-MC-Unique: DXBnNQYmPfeMZxLA1a0qOA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A8732999B20;
 Mon, 11 Sep 2023 16:42:04 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B4C9440C6EC0;
 Mon, 11 Sep 2023 16:42:03 +0000 (UTC)
Date: Mon, 11 Sep 2023 18:42:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH 02/11] hw/i386/pc: Use qdev_prop_set_array()
Message-ID: <ZP9DWucJaGt+hcQ1@redhat.com>
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-3-kwolf@redhat.com>
 <CAFEAcA9a15bhpG1Yj-b+3TC=UxDFdGJA4f1VrxnZsgVUR9O1dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9a15bhpG1Yj-b+3TC=UxDFdGJA4f1VrxnZsgVUR9O1dQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 11.09.2023 um 17:42 hat Peter Maydell geschrieben:
> On Fri, 8 Sept 2023 at 15:37, Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Instead of manually setting "foo-len" and "foo[i]" properties, build a
> > QList and use the new qdev_prop_set_array() helper to set the whole
> > array property with a single call.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  hw/i386/pc.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > index 54838c0c41..0e84e454cb 100644
> > --- a/hw/i386/pc.c
> > +++ b/hw/i386/pc.c
> > @@ -81,6 +81,7 @@
> >  #include "qapi/error.h"
> >  #include "qapi/qapi-visit-common.h"
> >  #include "qapi/qapi-visit-machine.h"
> > +#include "qapi/qmp/qlist.h"
> >  #include "qapi/visitor.h"
> >  #include "hw/core/cpu.h"
> >  #include "hw/usb.h"
> > @@ -1508,9 +1509,10 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
> >          char *resv_prop_str = g_strdup_printf("0xfee00000:0xfeefffff:%d",
> >                                                VIRTIO_IOMMU_RESV_MEM_T_MSI);
> >
> > -        object_property_set_uint(OBJECT(dev), "len-reserved-regions", 1, errp);
> > -        object_property_set_str(OBJECT(dev), "reserved-regions[0]",
> > -                                resv_prop_str, errp);
> > +        QList *reserved_regions = qlist_new();
> > +        qlist_append_str(reserved_regions, resv_prop_str);
> > +        qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
> > +
> 
> The variable declaration should be at the top of the block;

It is at the top of the block, the only thing before it is another
variable declaration. Would you prefer to have the empty line removed or
after the declaration to make this visually clearer?

Kevin


