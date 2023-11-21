Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B9F7F287E
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 10:16:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Mqr-00088O-5Q; Tue, 21 Nov 2023 04:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r5Mqi-00088B-Jh
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 04:15:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r5Mqg-0000cG-MJ
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 04:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700558113;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LOczEKH16QEC3ZM4kumFDuZTkaYnYMXuS7z1i7txbSs=;
 b=FykIfZuf7wcNMGWhfO3tgs9D16uxR7ne1w5W/P6v75FtsIlbpd4QAalv4L+mEN0TRLV7ZM
 DIXHPh6BAWM9GjrOXB8p+YDVcNzENO5+UM/GRwWJeCQg2g5e3cgSRSGs+JzTfN/5tA0TCk
 xjGTM+j7Nj/h5Ue1LryaNB/pqr3+vu4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-ZUO4UDSGPc-Pep_f5SRuXA-1; Tue,
 21 Nov 2023 04:15:10 -0500
X-MC-Unique: ZUO4UDSGPc-Pep_f5SRuXA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 876CF38130C0;
 Tue, 21 Nov 2023 09:15:09 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EB922166B27;
 Tue, 21 Nov 2023 09:15:01 +0000 (UTC)
Date: Tue, 21 Nov 2023 09:14:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 3/3] tests/avocado: Enable reverse_debugging.py tests in
 gitlab CI
Message-ID: <ZVx1EkxpK1ZH-nDn@redhat.com>
References: <20231116115354.228678-1-npiggin@gmail.com>
 <20231116115354.228678-3-npiggin@gmail.com>
 <24a194bc-81c6-44ae-9113-94ed28cc4f71@redhat.com>
 <CX0WX30H69LM.3MYDJODZ4LQWF@wheely>
 <31850f05-7849-402d-b3ae-623e76b52953@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31850f05-7849-402d-b3ae-623e76b52953@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 21, 2023 at 09:56:24AM +0100, Thomas Huth wrote:
> On 17/11/2023 08.35, Nicholas Piggin wrote:
> > On Fri Nov 17, 2023 at 4:11 AM AEST, Thomas Huth wrote:
> > > On 16/11/2023 12.53, Nicholas Piggin wrote:
> > > > Let's try enable reverse_debugging.py in gitlab CI.
> > > > 
> > > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > > ---
> > > > Maybe we could try this again at some point? The bug might have been
> > > > noticed sooner.
> > > > 
> > > > They only take a couple of seconds to run so should not take too much
> > > > overhead. But my gitlab CI pipeline doesn't run the avocado tests for
> > > > some reason, so I can't see if it's still causing problems.
> > > > 
> > > > Thanks,
> > > > Nick
> > > > ---
> > > > 
> > > >    tests/avocado/reverse_debugging.py | 7 -------
> > > >    1 file changed, 7 deletions(-)
> > > 
> > > FYI, I gave it a try, and it survived my CI run:
> > > 
> > >    https://gitlab.com/thuth/qemu/-/jobs/5552213972#L403
> > > 
> > > So I went ahead and put it (together with the first patch) in my current
> > > pull request, let's see how it goes...
> > 
> > Great, thank you.
> 
> ... and here it's failing again (current master branch):
> 
> https://gitlab.com/thuth/qemu/-/jobs/5582657378#L404
> 
> According to the debug.log in the artifacts, it's failing here:
> 
> 08:28:32 DEBUG| [    0.230392217,5] OPAL v7.0 starting...
> 
> 08:28:32 DEBUG| [    0.230674939,7] initial console log level: memory 7, driver 5
> 
> 08:28:32 DEBUG| [    0.231048494,6] CPU: P9 generation processor (max 4 threads/core)
> 
> 08:28:32 DEBUG| [
> 08:28:32 DEBUG| [    0.231412547,7] CPU: Boot CPU PIR is 0x0000 PVR is 0x004e1202
> 
> 08:28:32 DEBUG| [
> 08:28:32 ERROR|
> 08:28:32 ERROR| Reproduced traceback from: /builds/thuth/qemu/build/pyvenv/lib64/python3.8/site-packages/avocado/core/test.py:770
> 08:28:32 ERROR| Traceback (most recent call last):
> 08:28:32 ERROR|   File "/builds/thuth/qemu/build/tests/avocado/reverse_debugging.py", line 262, in test_ppc64_powernv
> 08:28:32 ERROR|     self.reverse_debugging()
> 08:28:32 ERROR|   File "/builds/thuth/qemu/build/tests/avocado/reverse_debugging.py", line 178, in reverse_debugging
> 08:28:32 ERROR|     g.cmd(b'c')
> 08:28:32 ERROR|   File "/builds/thuth/qemu/build/pyvenv/lib64/python3.8/site-packages/avocado/utils/gdb.py", line 783, in cmd
> 08:28:32 ERROR|     response_payload = self.decode(result)
> 08:28:32 ERROR|   File "/builds/thuth/qemu/build/pyvenv/lib64/python3.8/site-packages/avocado/utils/gdb.py", line 738, in decode
> 08:28:32 ERROR|     raise InvalidPacketError
> 08:28:32 ERROR| avocado.utils.gdb.InvalidPacketError
> 08:28:32 ERROR|
> 08:28:32 DEBUG| Local variables:
> 08:28:32 DEBUG|  -> self <class 'reverse_debugging.ReverseDebugging_ppc64'>: 79-tests/avocado/reverse_debugging.py:ReverseDebugging_ppc64.test_ppc64_powernv
> 08:28:32 DEBUG| Shutting down VM appliance; timeout=30
> 08:28:32 DEBUG| Attempting graceful termination
> 08:28:32 DEBUG| Closing console socket
> 08:28:32 DEBUG| Politely asking QEMU to terminate
> 
> So unless someone has a clue how to fix that, I guess it's
> likely best to revert this enablement patch again...

A little further in the log we see

08:28:32 DEBUG| Politely asking QEMU to terminate
08:28:32 DEBUG| --> {
  "execute": "quit"
}
08:28:32 DEBUG| <-- {
  "timestamp": {
    "seconds": 1700555312,
    "microseconds": 86122
  },
  "event": "RESUME"
}
08:28:32 ERROR| Task.Reader: BrokenPipeError: [Errno 32] Broken pipe



With seeing a bad packet from GDB and seeing Broken pipe from QMP,
my impression is that the QEMU process is no longer present, most
likely it has SEGV'd I reckon.

IOW, I think we might well have a genuine bug here, not merely an
unreliable test suite.

None the less, unless someone can guess what the problem is, we'll
need to disable the test to get reliable CI.

A bug should be opened though with the CI logs.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


