Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE23762133
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 20:18:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOMbz-0005AX-B5; Tue, 25 Jul 2023 14:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOMbx-00059c-2a
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qOMbt-00043s-Vr
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690309093;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QFeo4169o3VzOSsDIJ1PbH/jQWk3Py2Zqju87A1HEok=;
 b=bDbv7F3ZJ7SvslRXF8oJlRQX/AoBBvvA6cuCkJ1DQs3kivty7tsHuZng7vbxIV43TX4ksP
 Ip8PdD5O/I+HxR7G90nfYlq4u132kZjKIhiPlquo3EjTORM9d0TZuzU1CHOyJmqrmGJerx
 Qr2FRRl2MAa4bPEyp5AsWe4eQx9E56w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-GUGB1_q6PieE8B-WZa63Sg-1; Tue, 25 Jul 2023 14:18:09 -0400
X-MC-Unique: GUGB1_q6PieE8B-WZa63Sg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B44AE803FDC;
 Tue, 25 Jul 2023 18:18:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D3AC1121339;
 Tue, 25 Jul 2023 18:18:06 +0000 (UTC)
Date: Tue, 25 Jul 2023 19:18:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Kevin Wolf <kwolf@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/6] python/machine: close sock_pair in cleanup path
Message-ID: <ZMAR3L4O9sSEV4AL@redhat.com>
References: <20230725180337.2937292-1-jsnow@redhat.com>
 <20230725180337.2937292-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725180337.2937292-3-jsnow@redhat.com>
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

On Tue, Jul 25, 2023 at 02:03:33PM -0400, John Snow wrote:
> If everything has gone smoothly, we'll already have closed the socket we
> gave to the child during post_launch. The other half of the pair that we
> gave to the QMP connection should, likewise, be definitively closed by
> now.
> 
> However, in the cleanup path, it's possible we've created the socketpair
> but flubbed the launch and need to clean up resources. These resources
> *would* be handled by the garbage collector, but that can happen at
> unpredictable times. Nicer to just clean them up synchronously on the
> exit path, here.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine/machine.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
> index 8be0f684fe..26f0fb8a81 100644
> --- a/python/qemu/machine/machine.py
> +++ b/python/qemu/machine/machine.py
> @@ -395,6 +395,11 @@ def _post_shutdown(self) -> None:
>          finally:
>              assert self._qmp_connection is None
>  
> +        if self._sock_pair:
> +            self._sock_pair[0].close()
> +            self._sock_pair[1].close()
> +            self._sock_pair = None
> +

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


