Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBD77A5CB8
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 10:36:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiWD9-0008NF-R2; Tue, 19 Sep 2023 04:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiWD5-0008Me-Bi
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiWD3-00057n-QG
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 04:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695112552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rQqVXZKnhzjpQ6w/ua5rD8nqLJWYpdqbVL99x7KpzHs=;
 b=UhBBnef959QaXjpXzCH6v7pi6vc2haqVkhVgEcxDJT1/RSqOjnx6M6uc37kRGxj2EZbY96
 iwnYqEbCN/P+O44BRXLkXEWFRxj9CYPooPBw7qVkAEMCiTuRD9AsG9SmZad17AE/QspuUe
 gQ9ujweISrc/F/sf9gQdu5mlp5YqfsU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-WvkFg1goPVO9EkR3wiV4dw-1; Tue, 19 Sep 2023 04:35:50 -0400
X-MC-Unique: WvkFg1goPVO9EkR3wiV4dw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80ADE803498;
 Tue, 19 Sep 2023 08:35:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E5D22156701;
 Tue, 19 Sep 2023 08:35:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 23C2C21E6900; Tue, 19 Sep 2023 10:35:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>,  qemu-devel@nongnu.org,
 berrange@redhat.com,  pbonzini@redhat.com
Subject: Re: [PATCH 02/11] hw/i386/pc: Use qdev_prop_set_array()
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-3-kwolf@redhat.com>
 <CAFEAcA9a15bhpG1Yj-b+3TC=UxDFdGJA4f1VrxnZsgVUR9O1dQ@mail.gmail.com>
 <ZP9DWucJaGt+hcQ1@redhat.com>
 <CAFEAcA8zxRwivwv2xSQUFUdJgZv80a5_87pqHvcKj0XkRiuDPA@mail.gmail.com>
Date: Tue, 19 Sep 2023 10:35:49 +0200
In-Reply-To: <CAFEAcA8zxRwivwv2xSQUFUdJgZv80a5_87pqHvcKj0XkRiuDPA@mail.gmail.com>
 (Peter Maydell's message of "Tue, 12 Sep 2023 10:17:53 +0100")
Message-ID: <87fs3a1rx6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 11 Sept 2023 at 17:42, Kevin Wolf <kwolf@redhat.com> wrote:
>>
>> Am 11.09.2023 um 17:42 hat Peter Maydell geschrieben:
>> > On Fri, 8 Sept 2023 at 15:37, Kevin Wolf <kwolf@redhat.com> wrote:
>> > >
>> > > Instead of manually setting "foo-len" and "foo[i]" properties, build a
>> > > QList and use the new qdev_prop_set_array() helper to set the whole
>> > > array property with a single call.
>> > >
>> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> > > ---
>> > >  hw/i386/pc.c | 8 +++++---
>> > >  1 file changed, 5 insertions(+), 3 deletions(-)
>> > >
>> > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> > > index 54838c0c41..0e84e454cb 100644
>> > > --- a/hw/i386/pc.c
>> > > +++ b/hw/i386/pc.c
>> > > @@ -81,6 +81,7 @@
>> > >  #include "qapi/error.h"
>> > >  #include "qapi/qapi-visit-common.h"
>> > >  #include "qapi/qapi-visit-machine.h"
>> > > +#include "qapi/qmp/qlist.h"
>> > >  #include "qapi/visitor.h"
>> > >  #include "hw/core/cpu.h"
>> > >  #include "hw/usb.h"
>> > > @@ -1508,9 +1509,10 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>> > >          char *resv_prop_str = g_strdup_printf("0xfee00000:0xfeefffff:%d",
>> > >                                                VIRTIO_IOMMU_RESV_MEM_T_MSI);
>> > >
>> > > -        object_property_set_uint(OBJECT(dev), "len-reserved-regions", 1, errp);
>> > > -        object_property_set_str(OBJECT(dev), "reserved-regions[0]",
>> > > -                                resv_prop_str, errp);
>> > > +        QList *reserved_regions = qlist_new();
>> > > +        qlist_append_str(reserved_regions, resv_prop_str);
>> > > +        qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
>> > > +
>> >
>> > The variable declaration should be at the top of the block;
>>
>> It is at the top of the block, the only thing before it is another
>> variable declaration. Would you prefer to have the empty line removed or
>> after the declaration to make this visually clearer?
>
> Sorry, I think I just misread the diff somehow. I guess that having
> the blank line after the variable declarations would be more usual,
> but it doesn't really matter.

I really like to have a blank line between declarations and statements,
because declaration vs. statement can be difficult to decide at a
glance, and the blank line convention helps.


