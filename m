Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BF782DEE2
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 19:08:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPRMd-0003Ti-Um; Mon, 15 Jan 2024 13:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rPRMb-0003RO-CT
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 13:07:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rPRMZ-0004On-OX
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 13:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705342026;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JPzBrA93dWzGip5TXwmYe9YVCyMaBQD5F4EhaCZCyAw=;
 b=XPJ/Ai5Pt6e91VKvQUDdmIpqqnvJJLj57SK19olapKt3JQIxlAZLrYmrcuAb4beh/p4mUL
 KsA6bPwtbdiFxxVE+eJT4HJhsqku6G7WLn8DeAyHjGcOI5iyQCxllEqdNW9vtkGhCAsNJB
 7EWZ/ohUfTVNleL26Y3lphzG4Dveptg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-UkB0KzrbOnSevwd5ZHpIlA-1; Mon,
 15 Jan 2024 13:07:03 -0500
X-MC-Unique: UkB0KzrbOnSevwd5ZHpIlA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9676A29ABA1C;
 Mon, 15 Jan 2024 18:07:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41C4C5B7B;
 Mon, 15 Jan 2024 18:07:01 +0000 (UTC)
Date: Mon, 15 Jan 2024 18:06:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH 5/5] qemu-options: Remove the deprecated -singlestep option
Message-ID: <ZaV0QxdfQJDnICdF@redhat.com>
References: <20240112100059.965041-1-thuth@redhat.com>
 <20240112100059.965041-6-thuth@redhat.com>
 <7f24e391-e3ba-462c-ba30-2ea7ddb62795@linaro.org>
 <fdbe4b2d-b63a-4fcd-9747-08d713e17d22@redhat.com>
 <CAFEAcA-9EnvXKcrECsAKCMHPobLch4mKU0Yvb2+ZKALcFSiqaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-9EnvXKcrECsAKCMHPobLch4mKU0Yvb2+ZKALcFSiqaQ@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Jan 15, 2024 at 05:39:19PM +0000, Peter Maydell wrote:
> On Mon, 15 Jan 2024 at 13:54, Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 12/01/2024 16.39, Philippe Mathieu-Daudé wrote:
> > > Hi Thomas
> > >
> > > +Laurent & Peter
> > >
> > > On 12/1/24 11:00, Thomas Huth wrote:
> > >> It's been marked as deprecated since QEMU 8.1, so it should be fine
> > >> to remove this now.
> > >>
> > >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> > > StatusInfo::singlestep was deprecated at the same time,
> > > can we remove it?
> > >
> > > IOW could we complete your patch with this?
> 
> > > diff --git a/qapi/run-state.json b/qapi/run-state.json
> > > index ca05502e0a..08bc99cb85 100644
> > > --- a/qapi/run-state.json
> > > +++ b/qapi/run-state.json
> > > @@ -106,25 +106,15 @@
> > >   #
> > >   # @running: true if all VCPUs are runnable, false if not runnable
> > >   #
> > > -# @singlestep: true if using TCG with one guest instruction per
> > > -#     translation block
> > > -#
> > >   # @status: the virtual machine @RunState
> > >   #
> > >   # Features:
> > >   #
> > > -# @deprecated: Member 'singlestep' is deprecated (with no
> > > -#     replacement).
> > > -#
> > >   # Since: 0.14
> > >   #
> > > -# Notes: @singlestep is enabled on the command line with '-accel
> > > -#     tcg,one-insn-per-tb=on', or with the HMP 'one-insn-per-tb'
> > > -#     command.
> > >   ##
> > >   { 'struct': 'StatusInfo',
> > >     'data': {'running': 'bool',
> > > -           'singlestep': { 'type': 'bool', 'features': [ 'deprecated' ]},
> > >              'status': 'RunState'} }
> >
> > Uh, oh, that's a bigger change already ... can we safely remove the field
> > here without upsetting 3rd party apps that rely on this interface?
> 
> That was the whole point of marking it 'deprecated' in the JSON,
> I thought? We don't think anybody's using it, we've given fair
> warning, isn't the next step "remove it"? Markus, you're the
> expert on QAPI deprecations...

Yes, it is fine to delete it without thinking further about possible usage,
unless someone steps forward quickly with new information that wasn't known
when the deprecation was added....

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


