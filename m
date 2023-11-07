Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CFB7E41A8
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:16:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Ms8-0006VG-4U; Tue, 07 Nov 2023 09:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r0Ms5-0006U3-So
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:16:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r0Mrx-000608-V8
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699366543;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=22ZIseN2hHGKBbdGPE10+FZa4BgHL2bQMERE2IvuRIU=;
 b=NYOeYKxyEwdhoUKmL1tRwPoNQW8W6+2MdpI6eTUOzdJvGtNa9Nyipo/D+rBrW/bFh8sRME
 VkfFENfKWZ4hWk6RxfFtr5f3jitkM0TjlLxhQTw/Ixtxuz6SS1UDv3nTBY+slaiW6tbqVE
 muJutu6Tt+a8C04PvzdJa+QQj83SRtQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-hpxkxjQaO-iGi8M9QzX17w-1; Tue,
 07 Nov 2023 09:15:38 -0500
X-MC-Unique: hpxkxjQaO-iGi8M9QzX17w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 143043C23FD8;
 Tue,  7 Nov 2023 14:15:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0540502A;
 Tue,  7 Nov 2023 14:15:36 +0000 (UTC)
Date: Tue, 7 Nov 2023 14:15:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] scripts/cpu-x86-uarch-abi.py: Fix parameter error of cmd
Message-ID: <ZUpGhkYngtFRyGKs@redhat.com>
References: <20231018100011.685867-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018100011.685867-1-zhao1.liu@linux.intel.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Oct 18, 2023 at 06:00:11PM +0800, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> When run this script, there's the error:
> 
> python3 scripts/cpu-x86-uarch-abi.py /tmp/qmp
> Traceback (most recent call last):
>   File "/path-to-qemu/qemu/scripts/cpu-x86-uarch-abi.py", line 96, in <module>
>     cpu = shell.cmd("query-cpu-model-expansion",
> TypeError: QEMUMonitorProtocol.cmd() takes 2 positional arguments but 3 were given
> 
> Commit 7f521b023bc28 ("scripts/cpu-x86-uarch-abi.py: use .command()
> instead of .cmd()") converts the the original .cmd() to .command()
> (which was later renamed to "cmd" to replace the original one).
> 
> But the new .cmd() only accepts typing.Mapping as the parameter instead
> of typing.Dict (see _qmp.execute()).
> 
> Change the paremeters of "query-cpu-model-expansion" to typing.Mapping
> format to fix this error.
> 
> Fixes: 7f521b023bc28 ("scripts/cpu-x86-uarch-abi.py: use .command() instead of .cmd()")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  scripts/cpu-x86-uarch-abi.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

I'll queue this one and sent a PULL before the final release.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


