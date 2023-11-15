Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4920F7EC361
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 14:16:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Fji-0005CB-7U; Wed, 15 Nov 2023 08:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3FjV-0005BH-Ho
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 08:15:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3FjT-0000s2-Ln
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 08:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700054103;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=osh4pZWdUL/g3KqUHVzmD+menKp42myQE/QBDwSAuqg=;
 b=BWNyDLE8i2Lb3FihMBQuBEKIlB8QSKXeXZdeyX/K72wOBROIRMgIWmfaoM8clyzGoX3NZF
 moE9hQES9uU3+5BJHWvPtdkLPykgsurV28zynPYgtG7AVbcUF4KfoFgAN8KNibNfisrdJA
 QT67kSg8T4FpnkvW8DKO41cVlPRXwvc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-U84qTTp4PUaglhN-biG_zw-1; Wed,
 15 Nov 2023 08:14:59 -0500
X-MC-Unique: U84qTTp4PUaglhN-biG_zw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 420F4380627C;
 Wed, 15 Nov 2023 13:14:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EDF940C6EB9;
 Wed, 15 Nov 2023 13:14:55 +0000 (UTC)
Date: Wed, 15 Nov 2023 13:14:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] tests/avocado/reverse_debugging: Disable the ppc64 tests
 by default
Message-ID: <ZVTETYrfL8f48qe3@redhat.com>
References: <20231114163115.298041-1-thuth@redhat.com>
 <12b4420e-1440-4516-8276-e0e907003c16@linaro.org>
 <9f6247e4-7e81-44f8-a63b-8ee11f722710@redhat.com>
 <CWYYRW53VEPJ.3UL1X7GB1P4H2@wheely>
 <6877d6d6-bfbf-4475-8c61-dd537265b278@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6877d6d6-bfbf-4475-8c61-dd537265b278@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 15, 2023 at 07:23:01AM +0100, Thomas Huth wrote:
> On 15/11/2023 02.15, Nicholas Piggin wrote:
> > On Wed Nov 15, 2023 at 4:29 AM AEST, Thomas Huth wrote:
> > > On 14/11/2023 17.37, Philippe Mathieu-Daudé wrote:
> > > > On 14/11/23 17:31, Thomas Huth wrote:
> > > > > The tests seem currently to be broken. Disable them by default
> > > > > until someone fixes them.
> > > > > 
> > > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > > ---
> > > > >    tests/avocado/reverse_debugging.py | 7 ++++---
> > > > >    1 file changed, 4 insertions(+), 3 deletions(-)
> > > > 
> > > > Similarly, I suspect https://gitlab.com/qemu-project/qemu/-/issues/1961
> > > > which has a fix ready:
> > > > https://lore.kernel.org/qemu-devel/20231110170831.185001-1-richard.henderson@linaro.org/
> > > > 
> > > > Maybe wait the fix gets in first?
> > > 
> > > No, I applied Richard's patch, but the problem persists. Does this test
> > > still work for you?
> > 
> > I bisected it to 1d4796cd008373 ("python/machine: use socketpair() for
> > console connections"),
> 
> Maybe John (who wrote that commit) can help?

I find it hard to believe this commit is a direct root cause of the
problem since all it does is change the QEMU startup sequence so that
instead of QEMU listening for a monitor connection, it is given a
pre-opened monitor connection.

At the very most that should affect the startup timing a little.

I notice all the reverse debugging tests have a skip on gitlab
with a comment:

    # unidentified gitlab timeout problem

this makes be suspicious that John's patch has merely made this
(henceforth undiagnosed) timeout more likely to ocurr.

> > which causes this halfway through the test:
> > 
> > 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR| Traceback (most recent call last):
> > 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|   File "/home/npiggin/src/qemu/build/pyvenv/lib/python3.11/site-packages/avocado/core/decorators.py", line 90, in wrapper
> > 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|     return function(obj, *args, **kwargs)
> > 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|   File "/home/npiggin/src/qemu/build/tests/avocado/reverse_debugging.py", line 264, in test_ppc64_powernv
> > 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|     self.reverse_debugging()
> > 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|   File "/home/npiggin/src/qemu/build/tests/avocado/reverse_debugging.py", line 173, in reverse_debugging
> > 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|     g.cmd(b'c')
> > 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|   File "/home/npiggin/src/qemu/build/pyvenv/lib/python3.11/site-packages/avocado/utils/gdb.py", line 783, in cmd
> > 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|     response_payload = self.decode(result)
> > 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|                        ^^^^^^^^^^^^^^^^^^^
> > 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|   File "/home/npiggin/src/qemu/build/pyvenv/lib/python3.11/site-packages/avocado/utils/gdb.py", line 738, in decode
> > 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR|     raise InvalidPacketError
> > 2023-11-15 10:37:04,600 stacktrace       L0045 ERROR| avocado.utils.gdb.InvalidPacketError
> > 2023-11-15 10:37:04,600 stacktrace       L0046 ERROR|
> > 
> > It doesn't always fail the same gdb command
> > (I saw a bc on line 182 as well). It seems to be receiving a
> > zero length response?
> > 
> > No idea what's happening or why ppc seems to be more fragile.
> > Or why changing console connection affects gdb connection?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


