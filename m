Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E037C7983D1
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:15:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeWdf-0004GH-QN; Fri, 08 Sep 2023 04:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qeWdd-0004G9-Jn
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qeWdb-0003My-3a
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694160886;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mdzmq6JYHug2A4jLdov540G/eJbju3iJM9GekDrKLLw=;
 b=VnRnxFjN8kcPqpEcIpsjPE5WIzhpFBjV40mQopuFx2/eLNMswsUewnLYatAzSFgoj3Wfd6
 rIyr87QNotxESTOEumzoRSvMa9xk5bVyNFEu3SVnbfx6OI9KQqSV6HO/4/iCnDi/x5EPCt
 iaXE5Ab3zDUicf1SqQnuExVGCLqXQ4U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-GEZppK2eOpKqE5XICUmBIg-1; Fri, 08 Sep 2023 04:14:45 -0400
X-MC-Unique: GEZppK2eOpKqE5XICUmBIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B06923C0ED41;
 Fri,  8 Sep 2023 08:14:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0F6740C2070;
 Fri,  8 Sep 2023 08:14:43 +0000 (UTC)
Date: Fri, 8 Sep 2023 09:14:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Victor Toso <victortoso@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 0/7] Validate and test qapi examples
Message-ID: <ZPrX8cRntyrvZ05h@redhat.com>
References: <20230905194846.169530-1-victortoso@redhat.com>
 <ZPhDkJ+RvPauLfG6@redhat.com>
 <ixihnxsvwqtozpdfb5kavkjymflhdktgiq3bddpqqqjbnwyaid@cjgi7bofphbc>
 <440707e4-c855-99ce-0ca3-03250a0bd3d2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <440707e4-c855-99ce-0ca3-03250a0bd3d2@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

On Fri, Sep 08, 2023 at 09:51:35AM +0200, Philippe Mathieu-Daudé wrote:
> On 7/9/23 20:17, Victor Toso wrote:
> > Hi,
> 
> > >    File "/home/berrange/src/virt/qemu/scripts/qapi/dumpexamples.py", line 118, in parse_examples_of
> > >      assert((obj.doc is not None))
> > >              ^^^^^^^^^^^^^^^^^^^
> > > AssertionError
> > > ninja: build stopped: subcommand failed.
> > > 
> > > not sure if that's related to the examples that still need fixing or not ?
> > 
> > This is related to the script being fed with data without
> > documentation. In general, asserting should be the right approach
> > because we don't want API without docs but this failure comes
> > from the tests, that is, adding the following diff:
> > 
> > diff --git a/scripts/qapi/dumpexamples.py b/scripts/qapi/dumpexamples.py
> > index c14ed11774..a961c0575d 100644
> > --- a/scripts/qapi/dumpexamples.py
> > +++ b/scripts/qapi/dumpexamples.py
> > @@ -115,6 +115,10 @@ def parse_examples_of(self:
> > QAPISchemaGenExamplesVisitor,
> > 
> >       assert(name in self.schema._entity_dict)
> >       obj = self.schema._entity_dict[name]
> > +    if obj.doc is None:
> > +        print(f"{name} does not have documentation")
> > +        return
> > +
> >       assert((obj.doc is not None))
> >       module_name = obj._module.name
> > 
> > gives:
> > 
> >      user-def-cmd0 does not have documentation
> >      user-def-cmd does not have documentation
> [...]
> 
> > So, not sure if we should:
> >   1. Avoid asserting when running with tests
> 
> This seems the most sensible option, adding an argument to
> the 'command' invoked by meson's test_qapi_files() target in
> tests/meson.build.
> 
> >   2. Avoid running this generator with tests
> >   3. Add some minimal docs to the tests
> > 
> > Both (1) and (2) are quite simple. Not sure if there is real
> > benefit in (3). If we should tweak qemu tests with this, should
> > be related to using the JSON output itself, to keep examples
> > correct.
> 
> IMO (3) is a waste of time.

Agreed, I think we shouuld just skip the docs check as this is not
loading a real QAPI schema, just a dummy test one.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


