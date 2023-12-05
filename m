Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D4A804DE3
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 10:30:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rARkV-0001YZ-TF; Tue, 05 Dec 2023 04:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rARkT-0001XW-KR
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 04:29:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rARkR-0006FR-Uk
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 04:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701768586;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a2Vm6ridzV2bHJokv+H2391e+Z+yYssMCxinWzYVQuI=;
 b=BIfpxPJqsh6C2mvDUQq3Gb7ooT1B6b0naJK5xBfsHIHDoSNCgzlfM6SDyC5/zwqNHQIkDd
 yBPX3KzQtdzzxWGuz0KHRHEhu7ASyaV1JzWJSbvDZg12DV+on3ZYHpffewclNRHfMvxhez
 DJdRxgsURIisoSIrHYFbg7bzKYExGTQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-xukWpWcIOw6Q0QUs-OcWmg-1; Tue, 05 Dec 2023 04:29:43 -0500
X-MC-Unique: xukWpWcIOw6Q0QUs-OcWmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFEF5885647;
 Tue,  5 Dec 2023 09:29:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BB593C27;
 Tue,  5 Dec 2023 09:29:41 +0000 (UTC)
Date: Tue, 5 Dec 2023 09:29:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: tianren@smartx.com
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
	pbonzini@redhat.com
Subject: Re: [PATCH v3] qemu: send stop event after bdrv_flush_all
Message-ID: <ZW7tgt4z1g5UwB7N@redhat.com>
References: <20231205091903.3640-1-tianren@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231205091903.3640-1-tianren@smartx.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

On Tue, Dec 05, 2023 at 04:19:03AM -0500, tianren@smartx.com wrote:
> From: Tianren Zhang <tianren@smartx.com>
> 
> The stop process is not finished until bdrv_flush_all
> is done. Some users (e.g., libvirt) detect the STOP
> event and invokes some lock release logic to revoke
> the disk lock held by current qemu when such event is
> emitted. In such case, if the bdrv_flush_all is after
> the stop event, it's possible that the disk lock is
> released while the qemu is still waiting for I/O.
> Therefore, it's better to have the stop event generated
> after the whole stop process is done, so we can
> guarantee to users that the stop process is finished
> when they get the STOP event.
> 
> Signed-off-by: Tianren Zhang <tianren@smartx.com>
> ---
> v2: do not call runstate_is_running twice
> v3: remove irrelevant info from commit msg
> ---
>  system/cpus.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


