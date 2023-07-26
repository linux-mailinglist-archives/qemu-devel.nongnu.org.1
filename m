Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C02CA763B33
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:36:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOfkN-0000OO-8i; Wed, 26 Jul 2023 10:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOfjb-0000CM-Kf
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOfjY-0003wy-N7
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 10:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690382603;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C91FeIOQRhCOmZD3lutrglnUSIV63wjKxlCsprwZbHQ=;
 b=bAxaJqFx5d9BuGyqEML9joQSDwn2CwpeR05ury8ugqy7NR5RLZVz2W5T8FeWxewob5vQsu
 LDe8OcWfV/CDoEOim+qZh2qmuFHiEZtBPzjFsG/PaabIWj7RzzwQRfNZD5l/ziKBF5klMY
 p5IzF8kmsJe1Pgt9gHuwatGZ8amzyS0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-no2ewYuZOLqAwDqCpfL9ZA-1; Wed, 26 Jul 2023 10:43:19 -0400
X-MC-Unique: no2ewYuZOLqAwDqCpfL9ZA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 020DE381AE47;
 Wed, 26 Jul 2023 14:43:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5375B46A3A7;
 Wed, 26 Jul 2023 14:43:18 +0000 (UTC)
Date: Wed, 26 Jul 2023 15:43:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org
Subject: Re: How to tame CI?
Message-ID: <ZMExBKCIlvdJqq9t@redhat.com>
References: <87fs5aho6e.fsf@secure.mitica>
 <CAFEAcA89zgd+ZFBcMasTZErH6eTknXJhnDaXyW_LWj_vAYKrnw@mail.gmail.com>
 <ZMEq3Uzl+/7ACa9v@redhat.com> <87bkfyhh8v.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bkfyhh8v.fsf@secure.mitica>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 26, 2023 at 04:36:32PM +0200, Juan Quintela wrote:
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> > On Wed, Jul 26, 2023 at 02:00:03PM +0100, Peter Maydell wrote:
> >> On Wed, 26 Jul 2023 at 13:06, Juan Quintela <quintela@redhat.com> wrote:
> >> > To make things easier, this is the part that show how it breaks (this is
> >> > the gcov test):
> >> >
> >> > 357/423 qemu:block / io-qcow2-copy-before-write                            ERROR           6.38s   exit status 1
> >> > >>> PYTHON=/builds/juan.quintela/qemu/build/pyvenv/bin/python3
> >> > MALLOC_PERTURB_=44
> >> > /builds/juan.quintela/qemu/build/pyvenv/bin/python3
> >> > /builds/juan.quintela/qemu/build/../tests/qemu-iotests/check -tap
> >> > -qcow2 copy-before-write --source-dir
> >> > /builds/juan.quintela/qemu/tests/qemu-iotests --build-dir
> >> > /builds/juan.quintela/qemu/build/tests/qemu-iotests
> >> > ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> >> > stderr:
> >> > --- /builds/juan.quintela/qemu/tests/qemu-iotests/tests/copy-before-write.out
> >> > +++ /builds/juan.quintela/qemu/build/scratch/qcow2-file-copy-before-write/copy-before-write.out.bad
> >> > @@ -1,5 +1,21 @@
> >> > -....
> >> > +...F
> >> > +======================================================================
> >> > +FAIL: test_timeout_break_snapshot (__main__.TestCbwError)
> >> > +----------------------------------------------------------------------
> >> > +Traceback (most recent call last):
> >> > +  File "/builds/juan.quintela/qemu/tests/qemu-iotests/tests/copy-before-write", line 210, in test_timeout_break_snapshot
> >> > +    self.assertEqual(log, """\
> >> > +AssertionError: 'wrot[195 chars]read 1048576/1048576 bytes at
> >> > offset 0\n1 MiB,[46 chars]c)\n' != 'wrot[195 chars]read failed:
> >> > Permission denied\n'
> >> > +  wrote 524288/524288 bytes at offset 0
> >> > +  512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >> > +  wrote 524288/524288 bytes at offset 524288
> >> > +  512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >> > ++ read failed: Permission denied
> >> > +- read 1048576/1048576 bytes at offset 0
> >> > +- 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >> > +
> >> 
> >> This iotest failing is an intermittent that I've seen running
> >> pullreqs on master. I tend to see it on the s390 host. I
> >> suspect a race condition somewhere where it fails if the host
> >> is heavily loaded.
> 
> What is weird to me is that I was unable to reproduce it on the previous
> commit.  But with this one happened always.  No, I have no clue why, and
> as said, it makes zero sense, it is for a binary that it is not used on
> the block test.

Your commit changes the migration test, which could change the overall
tests running time, and thus impact what tests are running in parallel.
This could be enough to trigger the race more reliably.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


