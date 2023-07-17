Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD21475685E
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 17:54:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLQYC-0006se-Gm; Mon, 17 Jul 2023 11:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLQYA-0006sU-Eu
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 11:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qLQY8-0002aG-IX
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 11:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689609251;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qctLVYoeTMGAe+lGDXHI/qPDzzYoRf45MVm4nkrHPMM=;
 b=ARTy/4+TvD+SJGQKAB4v7z8WBzL3YwDUxgiLAK/JF3mko3+7avhsvCAXemgS/8X56V4GAA
 FpE3IQaN2sgwW5t6d3XhtTwsQe01fiYJ5f9VWJlMKAbGPhZEH84ZNZIGP+pB+c/TxVR5sR
 5/ovLgW2QhrHCbppI8LmPphB/kJz0eU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-E_NQsCFvNeaBAlNwMpKyKA-1; Mon, 17 Jul 2023 11:54:08 -0400
X-MC-Unique: E_NQsCFvNeaBAlNwMpKyKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B50BD85A58A;
 Mon, 17 Jul 2023 15:54:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDC35C2C85C;
 Mon, 17 Jul 2023 15:54:06 +0000 (UTC)
Date: Mon, 17 Jul 2023 16:54:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: avocado test: log shows initial chunk of terminal output is
 missing
Message-ID: <ZLVkHOGbbqFnN66G@redhat.com>
References: <CAFEAcA-fos6Agg09mtZJDdcStpCqdnLpyW4=MQnKRkZA_Tt9Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-fos6Agg09mtZJDdcStpCqdnLpyW4=MQnKRkZA_Tt9Zw@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Mon, Jul 17, 2023 at 04:42:30PM +0100, Peter Maydell wrote:
> I'm looking at an avocado test that's failing intermittently
> on s390 host:
> machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_edk2_firmware
> 
> This test looks for various things on the terminal output,
> and it's failing because it hasn't seen the first thing it looks
> for. The avocado log seems to show that the guest has booted
> past that point and has produced a later chunk of the output,
> and avocado appears to have simply lost the earlier output that
> the test case is trying to match on.

Having had a quick look at the test code the test is calling
wait_for_console_pattern() to match console output. This
method calls _console_interaction(), which accesses the property
vm.console_socket. The code in this method does a lazy create
of the socket:

    @property
    def console_socket(self) -> socket.socket:
        """
        Returns a socket connected to the console
        """
        if self._console_socket is None:
            self._console_socket = console_socket.ConsoleSocket(
                self._console_address,
                file=self._console_log_path,
                drain=self._drain_console)
        return self._console_socket

We're configuring the VM with a UNIX socket for the console. Even
if we moved the console_socket.ConsoleSocket() call directly into
the 'launch()' method this would still be inherantly racy.

The solution is the same as we prviously did for the QMP socket.
the QEMUMachine class needs to pre-create the UNIX socket and
pass the pre-opened FD into QEMU, which will guarantee no race
condition.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


