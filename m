Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AED79C9E2
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 10:28:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfyjN-00018f-Ng; Tue, 12 Sep 2023 04:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qfyjJ-00018N-M7
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:26:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qfyjG-0007PZ-Ib
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694507195;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jhmke+dGn8Kyd2GVWFpaViofWfgkfL6LGx7bEbBVGW4=;
 b=jORl/e1fzVVTucPjsCGUwlV7FjHvwYR8/MBapZBjPLPnxNMBaoWwf0G+B+m9EyM9vfQCK9
 CSAv0vtkw8r7VrozTaBo0CthSgyXuCCv4q6ZfGpa//1pshwkyR/FQZJDhW9cb9CzYoTf5Z
 BufCjzeySurlYjOHItM9HqIQTgE08DM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-x81DcOawMm-pFJ7Hcrt9fA-1; Tue, 12 Sep 2023 04:26:31 -0400
X-MC-Unique: x81DcOawMm-pFJ7Hcrt9fA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A65F6101FAA0;
 Tue, 12 Sep 2023 08:26:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBCF87B62;
 Tue, 12 Sep 2023 08:26:28 +0000 (UTC)
Date: Tue, 12 Sep 2023 09:26:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org,
 joao.m.martins@oracle.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH qemu 2/2] dump: Only use the makedumpfile flattened
 format when necessary
Message-ID: <ZQAgsmXRYFqRx7dI@redhat.com>
References: <20230717163855.7383-1-stephen.s.brennan@oracle.com>
 <20230717163855.7383-3-stephen.s.brennan@oracle.com>
 <CAJ+F1C+VFpU=xpqOPjJU1VLt4kofVqV8EN4pj5MjkkwWvVuxZw@mail.gmail.com>
 <87edl4d9wi.fsf@oracle.com> <87fs4aha4t.fsf@oracle.com>
 <CAJ+F1CKCdy3J8AD9EGvVO+CU6-yFPrLZ2Lum1SDgdj_kghFdQw@mail.gmail.com>
 <CAJ+F1CK0PTM-wHaK90EiuvvsG5OBVXQ4X8iV-AbBxdc6_=RvPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CK0PTM-wHaK90EiuvvsG5OBVXQ4X8iV-AbBxdc6_=RvPQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Sep 12, 2023 at 10:34:04AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Aug 23, 2023 at 2:03 PM Marc-André Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > Hi
> >
> > On Wed, Aug 23, 2023 at 4:31 AM Stephen Brennan
> > <stephen.s.brennan@oracle.com> wrote:
> > >
> > > Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> > > > Marc-André Lureau <marcandre.lureau@gmail.com> writes:
> > > >> I am a bit reluctant to change the dump format by default. But since the
> > > >> flatten format is more "complicated" than the "normal" format, perhaps we
> > > >> can assume all users will handle it.
> > > >>
> > > >> The change is probably late for 8.1 though..
> > > >
> > > > Thank you for your review and testing!
> > > >
> > > > I totally understand the concern about making the change by default. I
> > > > do believe that nobody should notice too much because the normal format
> > > > should be easier to work with, and more broadly compatible. I don't know
> > > > of any tool which deals with the flattened format that can't handle the
> > > > normal format, except for "makedumpfile -R" itself.
> > > >
> > > > If it's a blocker, I can go ahead and add a new flag to the command to
> > > > enable the behavior. However there are a few good justifications not to
> > > > add a new flag. I think it's going to be difficult to explain the
> > > > difference between the two formats in documentation, as the
> > > > implementation of the formats is a bit "into the weeds". The libvirt API
> > > > also specifies each format separately (kdump-zlib, kdump-lzo,
> > > > kdump-snappy) and so adding several new options there would be
> > > > unfortunate for end-users as well.
> > > >
> > > > At the end of the day, it's your judgment call, and I'll implement it
> > > > how you prefer.
> > >
> > > I just wanted to check back on this to clarify the next step. Are you
> > > satisfied with this and waiting to apply it until the right time? Or
> > > would you prefer me to send a new version making this opt-in?
> > >
> >
> > Nobody seems to raise concerns. If it would be just me, I would change
> > it. But we should rather be safe, so let's make it this opt-in please.
> 
> Alex, Daniel, Thomas .. Do you have an opinion on changing the dump format?

I think it is a bad idea for the command to output data in a different
format, silently switching based on whether it is passed a pipe or and
file FD.

Libvirt may pass either a plain file FD or a pipe FD, depending on
whether the user set the VIR_DUMP_BYPASS_CACHE API flag. IMHO it
is unacceptable for that to result in a change of data format as a
silent side effect.

Looking back at the history, the patches originally did NOT use the
flatten makedumpfile format, but to ensure it was able to work with
non-seekable files, it jumped through hoops to write to a temporary
file first process it and then write to the real file. Switching to
makedumpfile format was to enable it to avoid temp files and always
be compatible with non-seekable FDs.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


