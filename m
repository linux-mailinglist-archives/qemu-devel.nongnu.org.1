Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AF278FBBE
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 12:24:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc1JA-0005GI-Uz; Fri, 01 Sep 2023 06:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qc1J8-0005G8-5D
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:23:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qc1J5-0004HW-IU
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693563794;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXniX2YO6iVdD4+SOoexpsXDuhY2S3K9EN7J8V0lFHE=;
 b=aZa3B+yrRDXb8lw6RjhWFku1mgZUOSUQb82bo59oMVBsCOxVgfsXZB2H5grLF7Mu5/o9yZ
 DfOFj8V0Oa7MufyWVI3ciErZiXr1/y3yDqtQyJwZ72fp9V7jD01CccoPkak43s4UKYczt+
 bYAHWZkls8XOZvE7GTDH4srNbJjQKpA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-FR7OUnhFPYuv7_mXlPi-Xg-1; Fri, 01 Sep 2023 06:23:11 -0400
X-MC-Unique: FR7OUnhFPYuv7_mXlPi-Xg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 126451C170DB;
 Fri,  1 Sep 2023 10:23:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 075D16B5AA;
 Fri,  1 Sep 2023 10:23:08 +0000 (UTC)
Date: Fri, 1 Sep 2023 11:23:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, fam@euphon.net, f4bug@amsat.org,
 aurelien@aurel32.net, pbonzini@redhat.com, stefanha@redhat.com,
 crosa@redhat.com, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 06/13] docs/devel: simplify the minimal checklist
Message-ID: <ZPG7i36+ppw1pbh8@redhat.com>
References: <20221117172532.538149-1-alex.bennee@linaro.org>
 <20221117172532.538149-7-alex.bennee@linaro.org>
 <82434e83-d156-1a29-fb82-d6127162c185@linaro.org>
 <1aae8aab-8f92-e30a-7b40-e090aecdcd8e@linaro.org>
 <87edjip5j1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87edjip5j1.fsf@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Fri, Sep 01, 2023 at 11:08:15AM +0100, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
> > Ping?
> >
> > On 5/7/23 13:44, Philippe Mathieu-Daudé wrote:
> >> Hi Alex,
> >> On 17/11/22 18:25, Alex Bennée wrote:
> >>> The bullet points are quite long and contain process tips. Move those
> >>> bits of the bullet to the relevant sections and link to them. Use a
> >>> table for nicer formatting of the checklist.
> >>>
> >>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> >>> Message-Id: <20221111145529.4020801-8-alex.bennee@linaro.org>
> >>> ---
> >>>   docs/devel/submitting-a-patch.rst | 75 ++++++++++++++++++++-----------
> >>>   1 file changed, 49 insertions(+), 26 deletions(-)
> >> 
> >>> @@ -314,10 +320,12 @@ git repository to fetch the original commit.
> >>>   Patch emails must include a ``Signed-off-by:`` line
> >>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>> -For more information see `SubmittingPatches 1.12
> >>> -<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches?id=f6f94e2ab1b33f0082ac22d71f66385a60d8157f#n297>`__.
> >>> -This is vital or we will not be able to apply your patch! Please use
> >>> -your real name to sign a patch (not an alias or acronym).
> >> Revisiting this patch, asking for some real name instead of alias
> >> was at least helpful during patch review, we could address the
> >> contributor by its name. Addressing an acronym is socially weird
> >> (at least in my culture netiquette).
> 
> Is it that weird? We use nicks all the time on IRC.
> 
> The only driver for real names for the signoff is its harder to have
> confidence the contribution is valid because you might not be able to
> find who is behind an anonymous nick if something comes up later.

The Signed-off-by is intended as a legal attestation of permission
to contribute. Having the signoff use an obviously anonymous nick
could be said to undermine the legal value of the Signed-off-by.

That's not to say something that /looks/ like a real name is
actually the persons real name - we can't prove that without ID
checks which we're not going to do.

Something that looks like a real name is at least plausible to
accept as a persons' real world identity, where as a nick is
clearly just an online persona where there is an explicit intent
to hide the real identify. This kind of distinction / intent often
matters in the legal arena.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


