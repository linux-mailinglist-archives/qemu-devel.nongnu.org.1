Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD13775B0D0
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 16:07:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMUIR-0005Cn-OA; Thu, 20 Jul 2023 10:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qMUIP-0005Cd-QO
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qMUIN-0006y2-DU
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689861969;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Ud0y+h/Y7u1GczWMxkPRN4IBeQfk2gKBDuUPGUwr0eE=;
 b=L4GwKy1HxVDcD5EeokI9oB5sJx7fIKSitHLH8eVqN623lJ+kap3395qfUISf0rjVztNrzL
 QHz4xNfOej5xjt0x6jUXZUqaB1psvYk247Ce/U8zPJbfDChuAUGYy9dwjJfbaMzMIICKSt
 +bNy6H3Hxb52tmx3G63xo61qUjcS3yU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-NP9ZdbcaNKmsJZEYXIQ46g-1; Thu, 20 Jul 2023 10:05:42 -0400
X-MC-Unique: NP9ZdbcaNKmsJZEYXIQ46g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CE3128EA71C;
 Thu, 20 Jul 2023 14:04:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67F68C585A0;
 Thu, 20 Jul 2023 14:04:56 +0000 (UTC)
Date: Thu, 20 Jul 2023 15:04:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 4/4] python/machine: remove unused console socket
 configuration arguments
Message-ID: <ZLk/BmwoxLhJ26Sj@redhat.com>
References: <20230720130448.921356-1-jsnow@redhat.com>
 <20230720130448.921356-5-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720130448.921356-5-jsnow@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 20, 2023 at 09:04:48AM -0400, John Snow wrote:
> By using a socketpair for the console, we don't need the sock_dir
> argument for the base class anymore, remove it.
> 
> The qtest subclass still uses the argument for the qtest socket for now.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine/machine.py             | 18 ------------------
>  python/qemu/machine/qtest.py               |  6 +++---
>  tests/qemu-iotests/tests/copy-before-write |  3 +--
>  3 files changed, 4 insertions(+), 23 deletions(-)

A couple of callers to be updated to remove 'sock_dir=':

$ git grep 'sock_dir=' tests
tests/avocado/acpi-bits.py:                         sock_dir=sock_dir, qmp_timer=qmp_timer)
tests/avocado/avocado_qemu/__init__.py:                         sock_dir=self._sd.name, log_dir=self.logdir)
tests/qemu-iotests/iotests.py:                         sock_dir=sock_dir, qmp_timer=timer)
tests/qemu-iotests/tests/copy-before-write:                              sock_dir=iotests.sock_dir)

presume the avocado_qemu/__init__.py one is what caused the
failure Peter reported.

> 
> diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
> index ef9b2dc02e..350aa8bb26 100644
> --- a/python/qemu/machine/machine.py
> +++ b/python/qemu/machine/machine.py
> @@ -127,7 +127,6 @@ def __init__(self,
>                   name: Optional[str] = None,
>                   base_temp_dir: str = "/var/tmp",
>                   monitor_address: Optional[SocketAddrT] = None,
> -                 sock_dir: Optional[str] = None,
>                   drain_console: bool = False,
>                   console_log: Optional[str] = None,
>                   log_dir: Optional[str] = None,
> @@ -141,7 +140,6 @@ def __init__(self,
>          @param name: prefix for socket and log file names (default: qemu-PID)
>          @param base_temp_dir: default location where temp files are created
>          @param monitor_address: address for QMP monitor
> -        @param sock_dir: where to create socket (defaults to base_temp_dir)
>          @param drain_console: (optional) True to drain console socket to buffer
>          @param console_log: (optional) path to console log file
>          @param log_dir: where to create and keep log files
> @@ -163,7 +161,6 @@ def __init__(self,
>              Tuple[socket.socket, socket.socket]] = None
>          self._temp_dir: Optional[str] = None
>          self._base_temp_dir = base_temp_dir
> -        self._sock_dir = sock_dir
>          self._log_dir = log_dir
>  
>          self._monitor_address = monitor_address
> @@ -189,9 +186,6 @@ def __init__(self,
>          self._console_index = 0
>          self._console_set = False
>          self._console_device_type: Optional[str] = None
> -        self._console_address = os.path.join(
> -            self.sock_dir, f"{self._name}.con"
> -        )
>          self._console_socket: Optional[socket.socket] = None
>          self._remove_files: List[str] = []
>          self._user_killed = False
> @@ -334,9 +328,6 @@ def args(self) -> List[str]:
>          return self._args
>  
>      def _pre_launch(self) -> None:
> -        if self._console_set:
> -            self._remove_files.append(self._console_address)
> -
>          if self._qmp_set:
>              if self._monitor_address is None:
>                  self._sock_pair = socket.socketpair()
> @@ -900,15 +891,6 @@ def temp_dir(self) -> str:
>                                                dir=self._base_temp_dir)
>          return self._temp_dir
>  
> -    @property
> -    def sock_dir(self) -> str:
> -        """
> -        Returns the directory used for sockfiles by this machine.
> -        """
> -        if self._sock_dir:
> -            return self._sock_dir
> -        return self.temp_dir
> -
>      @property
>      def log_dir(self) -> str:
>          """
> diff --git a/python/qemu/machine/qtest.py b/python/qemu/machine/qtest.py
> index 1c46138bd0..22f8045ef6 100644
> --- a/python/qemu/machine/qtest.py
> +++ b/python/qemu/machine/qtest.py
> @@ -115,8 +115,8 @@ def __init__(self,
>                   wrapper: Sequence[str] = (),
>                   name: Optional[str] = None,
>                   base_temp_dir: str = "/var/tmp",
> -                 sock_dir: Optional[str] = None,
> -                 qmp_timer: Optional[float] = None):
> +                 qmp_timer: Optional[float] = None,
> +                 sock_dir: Optional[str] = None):
>          # pylint: disable=too-many-arguments
>  
>          if name is None:
> @@ -125,7 +125,7 @@ def __init__(self,
>              sock_dir = base_temp_dir
>          super().__init__(binary, args, wrapper=wrapper, name=name,
>                           base_temp_dir=base_temp_dir,
> -                         sock_dir=sock_dir, qmp_timer=qmp_timer)
> +                         qmp_timer=qmp_timer)
>          self._qtest: Optional[QEMUQtestProtocol] = None
>          self._qtest_path = os.path.join(sock_dir, name + "-qtest.sock")
>  
> diff --git a/tests/qemu-iotests/tests/copy-before-write b/tests/qemu-iotests/tests/copy-before-write
> index 2ffe092b31..d3987db942 100755
> --- a/tests/qemu-iotests/tests/copy-before-write
> +++ b/tests/qemu-iotests/tests/copy-before-write
> @@ -44,8 +44,7 @@ class TestCbwError(iotests.QMPTestCase):
>  
>          opts = ['-nodefaults', '-display', 'none', '-machine', 'none']
>          self.vm = QEMUMachine(iotests.qemu_prog, opts,
> -                              base_temp_dir=iotests.test_dir,
> -                              sock_dir=iotests.sock_dir)
> +                              base_temp_dir=iotests.test_dir)
>          self.vm.launch()
>  
>      def do_cbw_error(self, on_cbw_error):
> -- 
> 2.41.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


