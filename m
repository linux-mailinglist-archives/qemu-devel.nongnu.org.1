Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B615E7224E7
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:50:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68iu-0000Qu-Ok; Mon, 05 Jun 2023 07:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q68ip-0000OI-HR
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q68in-0003Ge-Ft
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685965800;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A+Y8Htq0+gJlMH+8FRlIB9etHFo3rbc2n6DqrfzKVf8=;
 b=UVUBGhAR7ki4cai9+6BiBFhg4psx4vcRoCNabsz/C28UY+XNiBjf/o8WrhqewVf/DeswXK
 mHjtOrvMX4CD5CkwGfPYR8vszk0tvD4uRvJh+mgoxXG84Sl8Sr8NOUiIHyS/5rbVERGeMv
 zi7b5DBZdkJRn2zLkFTrL5qf9KhUPzc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-pwONxRSLMVu_iUhXqll0Pw-1; Mon, 05 Jun 2023 07:49:59 -0400
X-MC-Unique: pwONxRSLMVu_iUhXqll0Pw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 265FA811E78;
 Mon,  5 Jun 2023 11:49:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.224])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1AA52026D49;
 Mon,  5 Jun 2023 11:49:57 +0000 (UTC)
Date: Mon, 5 Jun 2023 12:49:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 5/6] qtest: bump bios-table-test timeout to 6 minutes
Message-ID: <ZH3L4domo5OM49ro@redhat.com>
References: <20230601163123.1805282-1-berrange@redhat.com>
 <20230601163123.1805282-6-berrange@redhat.com>
 <2e7081ee-0ee7-0e39-59eb-32bcaf59dda8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e7081ee-0ee7-0e39-59eb-32bcaf59dda8@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jun 05, 2023 at 01:37:39PM +0200, Thomas Huth wrote:
> On 01/06/2023 18.31, Daniel P. Berrangé wrote:
> > This is reliably hitting the current 2 minute timeout in GitLab CI
> > for the TCI job, and even hits a 4 minute timeout. At 6 minutes it
> > looks sufficiently reliable.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/qtest/meson.build | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index d9fa30edbc..4f45369421 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -1,6 +1,6 @@
> >   slow_qtests = {
> >     'aspeed_smc-test': 120,
> > -  'bios-tables-test' : 120,
> > +  'bios-tables-test' : 360,
> >     'migration-test' : 300,
> >     'npcm7xx_pwm-test': 150,
> >     'qom-test' : 420,
> 
> Seems not to be enough for the CI (in the TCI job which is very slow in
> running the tests):
> 
>  https://gitlab.com/thuth/qemu/-/jobs/4412460439
> 
> An earlier run needed 403 seconds here already:
> 
>  https://gitlab.com/thuth/qemu/-/jobs/4411373383

Guess gitlab CI was less heavily loaded when i ran my many tests at the
end of last week.

9 minutes it is.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


