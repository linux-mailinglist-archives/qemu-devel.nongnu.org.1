Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CCD8277BC
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:36:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuSr-0006Lx-2g; Mon, 08 Jan 2024 13:35:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuSe-0006L3-Mx
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:34:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuSV-0008C0-GF
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738886;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7Vo1pmLBovjraaw+9ew6mM9QdIkIODcKE0/26rYCeo=;
 b=Fi6CvDNM5CyZYgyoRqVcGhVSz+AXCR3pOK4dUj0o2E0+hgpLwXRzV6ZJXQ6rnXMiTxVuoJ
 lYkhCSHcZECJt8ONmrX6uY1WCa9SsEgLl0AkmAMlJWx3bDVBV34sNhblHe13KK0Hvoe0im
 EeekJjqt478GK5JMmq4f3sHw9EfZ3z8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-mIi9Qm01Olu0-GiZA9CxHw-1; Mon,
 08 Jan 2024 13:34:37 -0500
X-MC-Unique: mIi9Qm01Olu0-GiZA9CxHw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03C901C05AA3;
 Mon,  8 Jan 2024 18:34:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B181C1596E;
 Mon,  8 Jan 2024 18:34:35 +0000 (UTC)
Date: Mon, 8 Jan 2024 18:34:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] softmmu: remove obsolete comment about libvirt timeouts
Message-ID: <ZZxAOiGQwUYBlOek@redhat.com>
References: <20240103123042.2400677-1-berrange@redhat.com>
 <ZZVz8Mt3InMvl5WO@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZVz8Mt3InMvl5WO@intel.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 03, 2024 at 10:49:20PM +0800, Zhao Liu wrote:
> On Wed, Jan 03, 2024 at 12:30:42PM +0000, Daniel P. Berrangé wrote:
> > Date: Wed,  3 Jan 2024 12:30:42 +0000
> > From: "Daniel P. Berrangé" <berrange@redhat.com>
> > Subject: [PATCH] softmmu: remove obsolete comment about libvirt timeouts
> > 
> > For a long time now, libvirt has pre-created the monitor connection
> > socket and passed the pre-opened FD into QEMU during startup. Thus
> > libvirt does not have any timeouts waiting for the monitor socket
> > to appear, it is immediately connected.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  system/vl.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/system/vl.c b/system/vl.c
> > index 6b87bfa32c..1d1508e28f 100644
> > --- a/system/vl.c
> > +++ b/system/vl.c
> > @@ -1911,7 +1911,6 @@ static bool object_create_early(const char *type)
> >       * Allocation of large amounts of memory may delay
> >       * chardev initialization for too long, and trigger timeouts
> >       * on software that waits for a monitor socket to be created
> > -     * (e.g. libvirt).
> 
> From the commit message of 6546d0dba6c2 ("vl: Delay initialization of
> memory backends"), and related bugzilla, I understand the only software
> Eduardo wanted to describe is libvirt.
> 
> Do you know of any other software that has the similar timeout mechanism?
> If there is no other software, the description of "trigger timeouts on
> software ..." in the comment could be deleted as well.

I haven't checked any other users recently, but waiting for the monitor
socket with a timeout has been a common usage pattern, so I expect there
are other users still besides libvirt which do this.

> 
> Otherwise,
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
> 
> Regards,
> Zhao
> 
> >       */
> >      if (g_str_has_prefix(type, "memory-backend-")) {
> >          return false;
> > -- 
> > 2.43.0
> > 
> > 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


