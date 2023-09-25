Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0427AD3DD
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 10:56:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkhNQ-0008T5-QJ; Mon, 25 Sep 2023 04:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qkhNO-0008So-Lm
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 04:55:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qkhNN-0001rQ-6P
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 04:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695632132;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jjlnLbfijMrd1uhxLLZHNa02iX1o+O2Qb27E/kbK+/s=;
 b=TSZVGUpvrxw/Ihh1laszt3sZqgjKyX4FAJIzdlI+T6sElT93EvTzyT6JNs+H71tkQuVGHm
 ahwDjkhPHUYA2Yf0abg3wdyeL8vBtvo+lWJOQXEoJ5ditU7DSR043ZEJGKA252FK4ANmQ5
 li31Bx+iX31bM+d9yNsBZHw9N/L99oo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-310-ajyQgkgeOmCfwOQL3CmKng-1; Mon, 25 Sep 2023 04:55:30 -0400
X-MC-Unique: ajyQgkgeOmCfwOQL3CmKng-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4720A29AA2F6;
 Mon, 25 Sep 2023 08:55:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94D46711286;
 Mon, 25 Sep 2023 08:55:28 +0000 (UTC)
Date: Mon, 25 Sep 2023 09:55:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/i386: changes towards enabling -Wshadow=local
Message-ID: <ZRFK/rB2sA0hRak/@redhat.com>
References: <20230923023334.41537-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230923023334.41537-1-anisinha@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sat, Sep 23, 2023 at 08:03:34AM +0530, Ani Sinha wrote:
> Code changes that addresses all compiler complaints coming from enabling
> -Wshadow flags. Enabling -Wshadow catches cases of local variables shadowing
> other local variables or parameters. These makes the code confusing and/or adds
> bugs that are difficult to catch.
> 
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Philippe Mathieu-Daude <philmd@linaro.org>
> CC: mst@redhat.com
> Message-Id: <87r0mqlf9x.fsf@pond.sub.org>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/i386/acpi-microvm.c | 12 ++++++------
>  hw/i386/intel_iommu.c  |  8 ++++----
>  hw/i386/pc.c           |  1 -
>  hw/i386/x86.c          |  2 --
>  4 files changed, 10 insertions(+), 13 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


