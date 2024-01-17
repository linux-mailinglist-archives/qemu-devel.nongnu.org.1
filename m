Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA299830296
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 10:45:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ2Sl-0006nl-If; Wed, 17 Jan 2024 04:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rQ2Sj-0006nX-Mo
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:43:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rQ2Sh-0002mY-KY
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 04:43:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705484634;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlMylBTx+Yem5N7+FQQk8g8MGHCyzBIdLl1wpSCwSYE=;
 b=VAC8kT8ySr1eaa1CXya6VtKaQwH7TCoECijEhakQ0kA8nypeFp0vMMrzcBWA5nb2pOQUfO
 J7Af4mVJIFV3dNC+HLaPrBuGzrm6e36oIg01Kdo/Jl0pXS+9ytwPdxDZJkCb0TK/r+c8UE
 otR2G7hp4HxKW3mWvHXCPKYtvP00a5s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-DFI6UGcmP5uod39SLYti-g-1; Wed,
 17 Jan 2024 04:43:52 -0500
X-MC-Unique: DFI6UGcmP5uod39SLYti-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC7913C0F235;
 Wed, 17 Jan 2024 09:43:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AF9BF2166B35;
 Wed, 17 Jan 2024 09:43:50 +0000 (UTC)
Date: Wed, 17 Jan 2024 09:43:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] acpi/tests/avocado/bits: wait for 200 seconds for
 SHUTDOWN event from bits VM
Message-ID: <ZaehVFa9O6XfuL85@redhat.com>
References: <20240117042556.3360190-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240117042556.3360190-1-anisinha@redhat.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

On Wed, Jan 17, 2024 at 09:55:56AM +0530, Ani Sinha wrote:
> By default, the timeout to receive any specified event from the QEMU VM is 60
> seconds set by the python avocado test framework. Please see event_wait() and
> events_wait() in python/qemu/machine/machine.py. If the matching event is not
> triggered within that interval, an asyncio.TimeoutError is generated. Since the
> timeout for the bits avocado test is 200 secs, we need to make event_wait()
> timeout of the same value as well so that an early timeout is not triggered by
> the avocado framework.
> 
> CC: peter.maydell@linaro.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2077
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  tests/avocado/acpi-bits.py | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> changelog:
> v2: cosmetic comment updates in code and patch description.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


