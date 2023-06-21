Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8236D737BE7
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 09:09:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBry3-0001vI-JK; Wed, 21 Jun 2023 03:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBry0-0001p1-K8
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBrxy-0007mv-P0
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 03:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687331361;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DV/6JAnJDvw9kwdAsvWoWHEKuZaga7Gc+N3SGojc/Qg=;
 b=h5XYhJMgGj6h2JkoQk+5F/Wa53TqxQcqN+ip7ERpWP0crF8sOASWiL1uoNadPXHMcK0E1W
 lqJBab+lqWxDJFxyao8W4hoYYfL9z/v/oW8yZe4V0FJIk4cb3AH6h604143d8FW1saAZ2X
 Wq5AnKR8W2NrSM6kEZdjuQbwt0IXhPQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-MQdkrp_wNk-riLfbodLKBg-1; Wed, 21 Jun 2023 03:09:15 -0400
X-MC-Unique: MQdkrp_wNk-riLfbodLKBg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A68A3C0DDAB;
 Wed, 21 Jun 2023 07:09:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A0911402C06;
 Wed, 21 Jun 2023 07:09:14 +0000 (UTC)
Date: Wed, 21 Jun 2023 08:09:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Henrik Carlqvist <hc94@poolhem.se>
Cc: hc981@poolhem.se, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org
Subject: Re: [PATCH v7] Emulate dip switch language layout settings on SUN
 keyboard
Message-ID: <ZJKiGBJNQa5Kx+Dg@redhat.com>
References: <20230328191958.3e3eb5e4.hc981@poolhem.se>
 <ZCMq/imcAq0ApLQp@redhat.com>
 <20230328221608.328ab80f.hc981@poolhem.se>
 <20230430225533.1a57879a.hc981@poolhem.se>
 <20230608181439.7ea3a5c5.hc981@poolhem.se>
 <4e8f027a-ca00-c54f-ef2f-f0df1f5b2f9e@ilande.co.uk>
 <20230610122912.0fc157de.hc981@poolhem.se>
 <20230611014751.22f22674.hc94@poolhem.se>
 <ZJFv4Hq8RMVOUum/@redhat.com>
 <20230620215043.6124c450.hc94@poolhem.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230620215043.6124c450.hc94@poolhem.se>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jun 20, 2023 at 09:50:43PM +0200, Henrik Carlqvist wrote:
> On Tue, 20 Jun 2023 10:22:40 +0100
> Daniel P. BerrangÃ© <berrange@redhat.com> wrote:
> 
> Thanks for your feedback!
> 
> > Assuming you have docutils installed, QEMU will build the manual by
> > default and print any issues on console during build. You can point
> > your browser to $BUILD/docs/manual/system/index.html to see the result.
> 
> It seems as if I have docutils version 0.17.1 installed. However the
> build/docs directory only contains a symlink to the config directory in
> ../../docs after make is completed.
> 
> > For future reference, if you want to put some questions/notes in the
> > submission, it is best to keep them separate from the commit message
> > text, as the questions/notes shouldn't end up in git history. To
> > separate them, put questions  immediately after the '---' that separate
> > the commit message from the diffstat
> 
> Thanks! Will do...
> 
> > You need to remove the space between :ref: and `keyboard`.
> > 
> > You'll also need to add it to a ToC (table of contents) otherwise
> > the build system complains.
> > 
> > I'd suggest putting the new file at docs/system/devices/keyboards.rst
> > and adding to the ToC in docs/system/device-emulation.rst
> 
> I will update the .rst files and placements, hopefully the coming weekend and
> come back with an updated patch. However, until I am able to build something
> from those .rst files, I can only follow your instructions to finally get them
> right.

If you're using one of the common Linux distros, you'll find a list of
the full set of packages you need to enable QEMU feuatres in the
dockerfiles at tests/docker/dockerfiles/. Those all have enough to
enable the docs build.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


