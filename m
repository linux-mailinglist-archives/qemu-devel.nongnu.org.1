Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE5879D509
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 17:36:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg5Pk-0007EP-GM; Tue, 12 Sep 2023 11:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg5PV-0007Dp-4n
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:34:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg5PR-0001Vw-I4
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694532875;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ofcat+cOSvYESCd22wgqphJvUb8OP4dzJzYf7itFmQ=;
 b=ZSNXpBvLxPDhYcb2MtPz4DAXFe/yjuv3X7NKeHutoxEfo+oCcmLYWnkM2WOHsBAEQhyD8d
 p/Q0PEA2EAGDC2v0QXVCpIB5sJG/StpFBZlNklDYDuT0dVNP10FsN9IklkUlSEU2a1G92B
 OO6x2v+eGU/VeCLZCF/a65SshFaIVY0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-9lperCd3N3CsKqMs54dDhg-1; Tue, 12 Sep 2023 11:34:32 -0400
X-MC-Unique: 9lperCd3N3CsKqMs54dDhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 071ED181A602;
 Tue, 12 Sep 2023 15:34:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0C332026D4B;
 Tue, 12 Sep 2023 15:34:30 +0000 (UTC)
Date: Tue, 12 Sep 2023 16:34:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH] tests/avocado: Fix console data loss
Message-ID: <ZQCFBFJUr6zllKNk@redhat.com>
References: <20230912131340.405619-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912131340.405619-1-npiggin@gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

On Tue, Sep 12, 2023 at 11:13:40PM +1000, Nicholas Piggin wrote:
> Occasionally some avocado tests will fail waiting for console line
> despite the machine running correctly. Console data goes missing, as can
> be seen in the console log. This is due to _console_interaction calling
> makefile() on the console socket each time it is invoked, which must be
> losing old buffer contents when going out of scope.
> 
> It is not enough to makefile() with buffered=0. That helps significantly
> but data loss is still possible. My guess is that readline() has a line
> buffer even when the file is in unbuffered mode, that can eat data.
> 
> Fix this by providing a console file that persists for the life of the
> console.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> 
> For some reason, ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_192m
> was flakey for me due to this bug. I don't know why that in particular,
> 3 calls to wait_for_console_pattern probably helps.
> 
> I didn't pinpoint when the bug was introduced because the original
> was probably not buggy because it was only run once at the end of the
> test. At some point after it was moved to common code, something would
> have started to call it more than once which is where potential for bug
> is introduced.

I'm suspecting this patch might also fix many other failures we
see in avocado, all with wait_for_console_pattern in their trace

https://gitlab.com/qemu-project/qemu/-/issues/1884

>  python/qemu/machine/machine.py         | 19 +++++++++++++++++++
>  tests/avocado/avocado_qemu/__init__.py |  2 +-
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
> index c16a0b6fed..35d5a672db 100644
> --- a/python/qemu/machine/machine.py
> +++ b/python/qemu/machine/machine.py
> @@ -191,6 +191,7 @@ def __init__(self,
>              self.sock_dir, f"{self._name}.con"
>          )
>          self._console_socket: Optional[socket.socket] = None
> +        self._console_file: Optional[socket.SocketIO] = None
>          self._remove_files: List[str] = []
>          self._user_killed = False
>          self._quit_issued = False
> @@ -509,6 +510,11 @@ def _early_cleanup(self) -> None:
>          # If we keep the console socket open, we may deadlock waiting
>          # for QEMU to exit, while QEMU is waiting for the socket to
>          # become writable.
> +        if self._console_file is not None:
> +            LOG.debug("Closing console file")
> +            self._console_file.close()
> +            self._console_file = None
> +
>          if self._console_socket is not None:
>              LOG.debug("Closing console socket")
>              self._console_socket.close()
> @@ -874,12 +880,25 @@ def console_socket(self) -> socket.socket:
>          Returns a socket connected to the console
>          """
>          if self._console_socket is None:
> +            LOG.debug("Opening console socket")
>              self._console_socket = console_socket.ConsoleSocket(
>                  self._console_address,
>                  file=self._console_log_path,
>                  drain=self._drain_console)
>          return self._console_socket
>  
> +    @property
> +    def console_file(self) -> socket.SocketIO:
> +        """
> +        Returns a file associated with the console socket
> +        """
> +        if self._console_file is None:
> +            LOG.debug("Opening console file")
> +            self._console_file = self.console_socket.makefile(mode='rb',
> +                                                              buffering=0,
> +                                                              encoding='utf-8')
> +        return self._console_file
> +
>      @property
>      def temp_dir(self) -> str:
>          """
> diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
> index 33090903f1..0172a359b7 100644
> --- a/tests/avocado/avocado_qemu/__init__.py
> +++ b/tests/avocado/avocado_qemu/__init__.py
> @@ -137,7 +137,7 @@ def _console_interaction(test, success_message, failure_message,
>      assert not keep_sending or send_string
>      if vm is None:
>          vm = test.vm
> -    console = vm.console_socket.makefile(mode='rb', encoding='utf-8')
> +    console = vm.console_file
>      console_logger = logging.getLogger('console')
>      while True:
>          if send_string:

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


