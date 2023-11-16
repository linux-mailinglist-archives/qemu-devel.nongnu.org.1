Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 453FA7EDFE7
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 12:32:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3abG-0005jn-67; Thu, 16 Nov 2023 06:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3abD-0005fw-6d
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 06:31:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3abB-0001dr-2Z
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 06:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700134310;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6dZ8/5qYIjXvGASDoOHlLK5BcZ39EOFckur0GgjPpE=;
 b=YR3oLkJigwRZJRWdw0g1yAhOLqzqdsNE4A2SgWnnxye8sQ3OGrm8Mqay0BGrLxkyrYifvT
 gSSSAxC/WjwblAEhnAbzNZ3IPjfHMyFpafvZS9gWczTO7GM/ebqwR/MSmh5+c4t4hkXvYF
 ogUDF2+PQPaO8NaTYkPp4hDurfgUbyE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-PobZGoLRPEiTPOaKNEMg3w-1; Thu,
 16 Nov 2023 06:31:49 -0500
X-MC-Unique: PobZGoLRPEiTPOaKNEMg3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2CA33827968;
 Thu, 16 Nov 2023 11:31:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 852E6C15881;
 Thu, 16 Nov 2023 11:31:46 +0000 (UTC)
Date: Thu, 16 Nov 2023 11:31:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] tests/avocado/reverse_debugging: Disable the ppc64 tests
 by default
Message-ID: <ZVX9oDJwifCvLLPl@redhat.com>
References: <9f6247e4-7e81-44f8-a63b-8ee11f722710@redhat.com>
 <CWYYRW53VEPJ.3UL1X7GB1P4H2@wheely>
 <6877d6d6-bfbf-4475-8c61-dd537265b278@redhat.com>
 <ZVTETYrfL8f48qe3@redhat.com> <ZVT-bY9YOr69QTPX@redhat.com>
 <CWZU7DEIX9E4.26PTZ0GK1ZAUP@wheely>
 <9853904F-F5F7-4744-98B0-0B61A60DAD7B@redhat.com>
 <CX01UGZ8PCU9.1TMVG7FPP29YF@wheely> <ZVXY-YnI2TiCFX3V@redhat.com>
 <9CE61EC5-2C8B-4CE3-A34F-4E29E5DFF047@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9CE61EC5-2C8B-4CE3-A34F-4E29E5DFF047@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

On Thu, Nov 16, 2023 at 04:47:48PM +0530, Ani Sinha wrote:
> 
> 
> > On 16-Nov-2023, at 2:25 PM, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > 
> > On Thu, Nov 16, 2023 at 05:14:43PM +1000, Nicholas Piggin wrote:
> >> On Thu Nov 16, 2023 at 1:55 PM AEST, Ani Sinha wrote:
> >>> 
> >>> 
> >>>> On 16-Nov-2023, at 6:45 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> >>>> 
> >>>> On Thu Nov 16, 2023 at 3:22 AM AEST, Daniel P. Berrangé wrote:
> >>>>> On Wed, Nov 15, 2023 at 01:14:53PM +0000, Daniel P. Berrangé wrote:
> >>>>> 
> >>>>> After an absolutely horrendous hours long debugging session I think
> >>>>> I figured out the problem. The QEMU process is blocking in
> >>>>> 
> >>>>>   qemu_chr_write_buffer
> >>>>> 
> >>>>> spinning in the loop on EAGAIN.
> >>>> 
> >>>> Great work.
> >>>> 
> >>>> Why does this make the gdb socket give an empty response? Something
> >>>> just times out?
> >>>> 
> >>>>> 
> >>>>> The Python  Machine() class has passed one of a pre-created socketpair
> >>>>> FDs for the serial port chardev. The guest is trying to write to this
> >>>>> and blocking.  Nothing in the Machine() class is reading from the
> >>>>> other end of the serial port console.
> >>>>> 
> >>>>> 
> >>>>> Before John's change, the serial port uses a chardev in server mode
> >>>>> and crucially  'wait=off', and the Machine() class never opened the
> >>>>> console socket unless the test case wanted to read from it.
> >>>>> 
> >>>>> IOW, QEMU had a background job setting there waiting for a connection
> >>>>> that would never come.
> >>>>> 
> >>>>> As a result when QEMU started executing the guest, all the serial port
> >>>>> writes get sent into to the void.
> >>>>> 
> >>>>> 
> >>>>> So John's patch has had a semantic change in behaviour, because the
> >>>>> console socket is permanently open, and thus socket buffers are liable
> >>>>> to fill up.
> >>>>> 
> >>>>> As a demo I increased the socket buffers to 1MB and everything then
> >>>>> succeeded.
> >>>>> 
> >>>>> @@ -357,6 +360,10 @@ def _pre_launch(self) -> None:
> >>>>> 
> >>>>>        if self._console_set:
> >>>>>            self._cons_sock_pair = socket.socketpair()
> >>>>> +            self._cons_sock_pair[0].setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, 1024*1024);
> >>>>> +            self._cons_sock_pair[0].setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 1024*1024);
> >>>>> +            self._cons_sock_pair[1].setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, 1024*1024);
> >>>>> +            self._cons_sock_pair[1].setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 1024*1024);
> >>>>>            os.set_inheritable(self._cons_sock_pair[0].fileno(), True)
> >>>>> 
> >>>>>        # NOTE: Make sure any opened resources are *definitely* freed in
> >>>> 
> >>>> So perhaps ppc64 fails just because it prints more to the console in early
> >>>> boot than other targets?
> >>>> 
> >>>>> The Machine class doesn't know if anything will ever use the console,
> >>>>> so as is the change is unsafe.
> >>>>> 
> >>>>> The original goal of John's change was to guarantee we capture early
> >>>>> boot messages as some test need that.  
> >>>>> 
> >>>>> I think we need to be able to have a flag to say whether the caller needs
> >>>>> an "early console" facility, and only use the pre-opened FD passing for
> >>>>> that case. Tests we need early console will have to ask for that guarantee
> >>>>> explicitly.
> >>>> 
> >>>> The below patch makes this test work. Maybe as a quick fix it is
> >>>> better than disabling the test.
> >>>> 
> >>>> I guess we still have a problem if a test invokes vm.launch()
> >>>> directly without subsequently waiting for a console pattern or
> >>>> doing something with the console as you say. Your suggesstion is
> >>>> add something like vm.launch(console=True) ? 
> >>> 
> >>> I think what he is saying is to add a new property for QEMUMachine() with which the test can explicitly tell the machine init code that it is going to drain the console logs. By default it can be false. When tests use console_drainer, they can set the property to true and inspect the early console logs after draining it. 
> >> 
> >> Hmm... well we do have QEMUMachine.set_console already. Is this enough?
> >> If the test case is not going to drain or interact with the console
> >> then it could set it to false. Or am I missing something?
> > 
> > Yeah, set_console is enough - i missed that that exists.
> > 
> > Thus problem is more specific. It hits when a test calls
> > set_console(True), but then fails to read from the console.
> 
> So then it is a test issue in that the test requests console to be enabled but does not look at the console o/p.

Yes, any test cases affected by this are broken already, and need to drain
the console. We might easily miss if we only test with x86_64 QEMU and not
other arches, as eg ppc firmware appears more chatty on serial port than
seabios

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


