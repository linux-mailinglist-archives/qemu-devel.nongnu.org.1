Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4AAA54E94
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Mar 2025 16:08:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqCon-0007cz-22; Thu, 06 Mar 2025 10:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tqCoi-0007b1-Q9
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:07:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tqCoe-0000DL-0Q
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741273632;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8IsUki1H3oTvzrSFjlZqHBadfXwRgbF20CLQXqWw7o=;
 b=egmKqnEUBATnOpTqvXxqexDoTJOcp0+rEbd3gWfNwZBIKH1rxKbwC9jmZ9DAuxAoOehJVG
 KMA+B1s0OHD+yfluF6m5/JY4sS1FPLIX4ehiE/HkObMSlPt/6owOgvwXvZQt08EPyDYM6r
 Qb0q0K8wnjAuiab9SLDrfz6y3ppnzRE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-CquckYrVNZyisvfkKDblsQ-1; Thu,
 06 Mar 2025 10:07:09 -0500
X-MC-Unique: CquckYrVNZyisvfkKDblsQ-1
X-Mimecast-MFC-AGG-ID: CquckYrVNZyisvfkKDblsQ_1741273628
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 961A8195608D; Thu,  6 Mar 2025 15:07:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 849761801748; Thu,  6 Mar 2025 15:07:04 +0000 (UTC)
Date: Thu, 6 Mar 2025 15:06:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
Cc: qemu-s390x mailing list <qemu-s390x@nongnu.org>,
 Thomas Huth <thuth@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH qemu v2 1/3] hw/s390x: add CPI identifiers to QOM
Message-ID: <Z8m5pV0kPIfp2jo2@redhat.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <Z8h2hNFlNvjWWHqd@redhat.com>
 <b44e0b46f69ee6f86a15ecabecd6942c@imap.linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b44e0b46f69ee6f86a15ecabecd6942c@imap.linux.ibm.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

BTW, your email client is possibly mis-configured - your mail
came through with "From: shalini <shalini@imap.linux.ibm.com>"
and attempting to reply to that gets an error saying that
'imap.linux.ibm.com' does not exist.

On Thu, Mar 06, 2025 at 02:55:27PM +0100, shalini wrote:
> On 2025-03-05 17:06, Daniel P. Berrangé wrote:
> > On Mon, Feb 24, 2025 at 01:04:47PM +0100, Shalini Chellathurai Saroja
> > wrote:
> > > Add Control-Program Identification (CPI) to the QEMU Object
> > > Model (QOM). The CPI identifiers provide information about
> > > the guest operating system. The CPI identifiers are:
> > > system type, system name, system level and sysplex name.
> > > 
> > > The system type provides the OS type of the guest (e.g. LINUX).
> > > The system name provides the name of the guest (e.g. TESTVM).
> > > The system level provides the distribution and kernel version
> > > of the guest OS (e.g. 0x50e00).
> > > The sysplex name provides the sysplex name of the guest
> > > (e.g. SYSPLEX).
> > > 
> > > Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> > > ---
> > >  hw/s390x/s390-virtio-ccw.c         | 29 +++++++++++++++++++++++++++++
> > >  include/hw/s390x/s390-virtio-ccw.h |  8 ++++++++
> > >  qapi/machine.json                  | 24 ++++++++++++++++++++++++
> > >  3 files changed, 61 insertions(+)
> > > 
> > > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > > index 51ae0c133d..13ea8db1b0 100644
> > > --- a/hw/s390x/s390-virtio-ccw.c
> > > +++ b/hw/s390x/s390-virtio-ccw.c
> > > @@ -50,6 +50,7 @@
> > >  #include "hw/s390x/virtio-ccw-md.h"
> > >  #include "system/replay.h"
> > >  #include CONFIG_DEVICES
> > > +#include "qapi/qapi-visit-machine.h"
> > > 
> > >  static Error *pv_mig_blocker;
> > > 
> > > @@ -803,6 +804,26 @@ static void machine_set_loadparm(Object *obj,
> > > Visitor *v,
> > >      s390_ipl_fmt_loadparm(ms->loadparm, val, errp);
> > >  }
> > > 
> > > +static void machine_get_control_program_id(Object *obj, Visitor *v,
> > > +                                           const char *name, void
> > > *opaque,
> > > +                                           Error **errp)
> > > +{
> > > +    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
> > > +    S390ControlProgramId *cpi;
> > > +    cpi = &(S390ControlProgramId){
> > > +        .system_type = g_strndup((char *) ms->cpi.system_type,
> > > +                       sizeof(ms->cpi.system_type)),
> > > +        .system_name = g_strndup((char *) ms->cpi.system_name,
> > > +                       sizeof(ms->cpi.system_name)),
> > > +        .system_level = g_strdup_printf("0x%lx",
> > > ms->cpi.system_level),
> > 
> > If the data is an integer, we must return it in QMP as an integer,
> > not formatted into a hex string.
> > 
> 
> Hello Daniel,
> 
> Thank you very much for the review.
> 
> The system-level, when interpreted as an int provides the output below
> 
> 'system-level': 74872343805430528

Yes, that is correct from a QMP design POV. Data should formatted
in the most appropriate way for machines to consume, using native
JSON data types.

> But the desired output below is obtained only when interpreted as a str.
> 
> 'system-level': '0x10a000000060b00'

If a human wants to read the data in hex format, that should be
formatted by whatever tool is consuming the data from QMP and
presenting it in the user.

> > > +# @system-name: system name of Linux instance
> > 
> > What is a system name ?  Is that a hostname, or is that something
> > else ?
> > 
> 
> Yes, it is the hostname of the guest virtual machine.

Lets rename it to 'system-hostname' to be unambiguous.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


