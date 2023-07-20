Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B9875B0A5
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 16:03:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMUE1-0001mj-Hb; Thu, 20 Jul 2023 10:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qMUDx-0001hC-MQ
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:01:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qMUDt-0005hQ-0D
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 10:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689861689;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3v2i7hSwfPauKoi32xWw0dN9nfYg0IKm9MmkfblrMNc=;
 b=T0F63PyjM3rkWFIsjiHiOCGpQHCrvWVYKMivsy7JLNe4WQklRuFuAoFYzfvVx16Lqehj52
 l67vyASYmEhFF0hSr2SPvoqfL2c1ZKEd/xnlgsxPNKR+W1bkqgrpP1WmL2Qi1Qt87wxxVK
 Q9VqzqxPD2u8pAodfUVNyAU+zC6n91w=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-eYHPtwFDM_eDWtircT0V4w-1; Thu, 20 Jul 2023 10:01:26 -0400
X-MC-Unique: eYHPtwFDM_eDWtircT0V4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A8593C1A6E7;
 Thu, 20 Jul 2023 14:01:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42CBF1121314;
 Thu, 20 Jul 2023 14:01:24 +0000 (UTC)
Date: Thu, 20 Jul 2023 15:01:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH 2/4] python/console_socket: accept existing FD in
 initializer
Message-ID: <ZLk+Mg5F8QnOuU1d@redhat.com>
References: <20230720130448.921356-1-jsnow@redhat.com>
 <20230720130448.921356-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720130448.921356-3-jsnow@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

On Thu, Jul 20, 2023 at 09:04:46AM -0400, John Snow wrote:
> Useful if we want to use ConsoleSocket() for a socket created by
> socketpair().
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine/console_socket.py | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/python/qemu/machine/console_socket.py b/python/qemu/machine/console_socket.py
> index 4e28ba9bb2..42bfa12411 100644
> --- a/python/qemu/machine/console_socket.py
> +++ b/python/qemu/machine/console_socket.py
> @@ -17,7 +17,7 @@
>  import socket
>  import threading
>  import time
> -from typing import Deque, Optional
> +from typing import Deque, Optional, Union
>  
>  
>  class ConsoleSocket(socket.socket):
> @@ -30,13 +30,16 @@ class ConsoleSocket(socket.socket):
>      Optionally a file path can be passed in and we will also
>      dump the characters to this file for debugging purposes.
>      """
> -    def __init__(self, address: str, file: Optional[str] = None,
> +    def __init__(self, address: Union[str, int], file: Optional[str] = None,
>                   drain: bool = False):

IMHO calling the pre-opened FD an "address" is pushing the
interpretation a bit.

It also makes the behaviour non-obvious from a caller. Seeing a
caller, you have to work backwards to find out what type it has,
to figure out the semantics of the method call.

IOW, I'd prefer to see

   address: Optional[str], sock_fd: Optional[int]

and then just do a check

   if (address is not None and sock_fd is not None) or
      (address is None and sock_fd is None):
      raise Exception("either 'address' or 'sock_fd' is required")

thus when you see

   ConsoleSocket(sock_fd=xxx)

it is now obvious it has different behaviour to

   ConsoleSocket(address=yyy)


>          self._recv_timeout_sec = 300.0
>          self._sleep_time = 0.5
>          self._buffer: Deque[int] = deque()
> -        socket.socket.__init__(self, socket.AF_UNIX, socket.SOCK_STREAM)
> -        self.connect(address)
> +        if isinstance(address, str):
> +            socket.socket.__init__(self, socket.AF_UNIX, socket.SOCK_STREAM)
> +            self.connect(address)
> +        else:
> +            socket.socket.__init__(self, fileno=address)
>          self._logfile = None
>          if file:
>              # pylint: disable=consider-using-with
> -- 
> 2.41.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


