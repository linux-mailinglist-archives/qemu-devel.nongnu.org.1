Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F664798B84
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:35:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qefMu-0003D9-DV; Fri, 08 Sep 2023 13:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qefMr-0003Cr-PU
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:34:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qefMp-0000fV-JQ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694194442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b5X7hryHWWocVb5ACKae9baQcRgLWkw6J2y3gilegy0=;
 b=QpnlavUusXNnzBrVID2qxvdaDBhMA5AQMBkMAj3zDv7fxMfy3rd9/DpVoM8PGpe0W5n0DC
 7zhAimMdiyuvg5CYRLDCQXo45D/FMliaRFN3R+xypjWqo66cbulzM6U/X+JLwyCVxfAuX+
 1ogW/isOWj/FqSk1DPU/bvrgdmIMgng=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-mxoqMFWfPfCdlsGp2gFR0g-1; Fri, 08 Sep 2023 13:33:57 -0400
X-MC-Unique: mxoqMFWfPfCdlsGp2gFR0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 847673802AD9;
 Fri,  8 Sep 2023 17:33:57 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A2BDC1460FE7;
 Fri,  8 Sep 2023 17:33:56 +0000 (UTC)
Date: Fri, 8 Sep 2023 19:33:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
 pbonzini@redhat.com
Subject: Re: [PATCH 11/11] qdev: Rework array properties based on list visitor
Message-ID: <ZPtbAw18MfRpZDY4@redhat.com>
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-12-kwolf@redhat.com>
 <CAFEAcA9N3c1=Q-75iA-k4r-5FK0b3=yj+FtPFaj3Fg8aT4J3ZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9N3c1=Q-75iA-k4r-5FK0b3=yj+FtPFaj3Fg8aT4J3ZA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 08.09.2023 um 17:18 hat Peter Maydell geschrieben:
> On Fri, 8 Sept 2023 at 15:37, Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Until now, array properties are actually implemented with a hack that
> > uses multiple properties on the QOM level: a static "foo-len" property
> > and after it is set, dynamically created "foo[i]" properties.
> >
> > In external interfaces (-device on the command line and device_add in
> > QMP), this interface was broken by commit f3558b1b ('qdev: Base object
> > creation on QDict rather than QemuOpts') because QDicts are unordered
> > and therefore it could happen that QEMU tried to set the indexed
> > properties before setting the length, which fails and effectively makes
> > array properties inaccessible. In particular, this affects the 'ports'
> > property of the 'rocker' device.
> >
> > This patch reworks the external interface so that instead of using a
> > separate top-level property for the length and for each element, we use
> > a single true array property that accepts a list value. In the external
> > interfaces, this is naturally expressed as a JSON list and makes array
> > properties accessible again.
> >
> > Creating an array property on the command line without using JSON format
> > is currently not possible. This could be fixed by switching from
> > QemuOpts to a keyval parser, which however requires consideration of the
> > compatibility implications.
> 
> Could we have a specific example in the commit message of:
> 
> The old (currently broken) syntax for setting the ports
> property on the rocker device is:
>  -device rocker,len-ports=2,ports[0]=dev0,ports[1]=dev1
> The new syntax that works as of this commit is:
>  [whatever]
> 
> ?

Sure, that's a good idea.

> I would expect most users have no idea what the JSON list
> syntax is.

To fill in your "[whatever]", it's something like this:

-device '{"driver":"rocker","ports":["dev0","dev1"]}'

If we can eventually get -device converted to the keyval parser instead
of QemuOpts, the non-JSON syntax will look like this:

-device rocker,ports.0=dev0,ports.1=dev1

But I assume we'll have to solve some compatibility problems with other
devices before this can be done.

Kevin


