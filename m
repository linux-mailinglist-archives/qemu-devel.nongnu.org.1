Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 687F17AB3FE
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:44:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjhNE-0000yy-5E; Fri, 22 Sep 2023 10:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qjhNA-0000xi-2Z
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qjhN4-0006vi-R2
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695393784;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fcKHD5Yn8WuN5B5skBVngC9UZrWiOXNWVaaSNVZqLUE=;
 b=PnKJ92AC8eilsjmrFglPDVLGdu+fvrPUCdvg4pMgtv+4fLlI63ZLlIu8Hvq8UeYZKldjmM
 ku0un1q6RE5LCcDiKsLC0EZf8/v92Oy0NdusFjW4olPUJq7HEnBmcu7GM3IsCnf4xa9CK7
 CraAazwxO47MHPewDDYWfxlNAEDz9i4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-taaObLM7M-qHx23qYvy4Sg-1; Fri, 22 Sep 2023 10:43:00 -0400
X-MC-Unique: taaObLM7M-qHx23qYvy4Sg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67DD93C23FF0;
 Fri, 22 Sep 2023 14:43:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BC9E492C37;
 Fri, 22 Sep 2023 14:42:58 +0000 (UTC)
Date: Fri, 22 Sep 2023 15:42:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/2] configure: support passthrough of -Dxxx args to meson
Message-ID: <ZQ2n8KBN86PvKZ30@redhat.com>
References: <20230922135555.241809-1-berrange@redhat.com>
 <20230922135555.241809-2-berrange@redhat.com>
 <CAFEAcA8gPOx6hH9gZxHOvcTwpSuLO5mCc0zqpTEBSidf0_QaaA@mail.gmail.com>
 <7949b0a2-c05e-2b8e-b10f-b1e5ac910501@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7949b0a2-c05e-2b8e-b10f-b1e5ac910501@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, Sep 22, 2023 at 04:36:00PM +0200, Thomas Huth wrote:
> On 22/09/2023 16.00, Peter Maydell wrote:
> > On Fri, 22 Sept 2023 at 14:56, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > 
> > > This can be useful for setting some meson global options, such as the
> > > optimization level or debug state, which don't have an analogous
> > > option explicitly defined in QEMU's configure wrapper script.
> > > 
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > The commit message says it's adding support for a new feature...
> > 
> > > ---
> > >   configure | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/configure b/configure
> > > index e08127045d..cbd7e03e9f 100755
> > > --- a/configure
> > > +++ b/configure
> > > @@ -931,6 +931,8 @@ cat << EOF
> > >     bsd-user        all BSD usermode emulation targets
> > >     pie             Position Independent Executables
> > > 
> > > +  -Dmesonoptname=val      passthrough option to meson unmodified
> > > +
> > >   NOTE: The object files are built at the place where configure is launched
> > >   EOF
> > >   exit 0
> > 
> > ...but the patch is only updating the --help text. Is there
> > a missing piece of code here ?
> 
> The patch has already been merged, see commit ff136d2a99253483f ... and IIRC
> I slightly modified it when picking it up (according to the patch
> description), so this here is likely a left-over of a rebase. Daniel, I
> think you can drop this patch here.

Opps, yes, a mistake updating an old branch.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


