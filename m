Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0A6784255
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 15:48:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYRjG-0008Ok-LC; Tue, 22 Aug 2023 09:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qYRjD-0008OC-T9
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qYRjB-0007wp-Ef
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 09:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692712044;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=rxNAre89UwuMSi+LlEy7g70Bnvr3TZ0GLW8CcZ1s+I8=;
 b=RMB4ZrKDI84uvxCO+XNRNwDsOVJJYNZfTVfZmIaBgjla0J/fu0T/AI2/9+22E0DHgH6zLk
 Pwo5WNzeUNuU4ltWwKoCNRtmfDg7EiQnMAu4Io1Z2ZkhAFMD2tQIwz+4GGtOj3SUSyQd5/
 wqI3ibw5RLOdxri/EvE2HA97FM/gsKY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-rwC34q5ONcmn6tgBdeTdIQ-1; Tue, 22 Aug 2023 09:47:21 -0400
X-MC-Unique: rwC34q5ONcmn6tgBdeTdIQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAE89101CC60;
 Tue, 22 Aug 2023 13:47:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BD551121314;
 Tue, 22 Aug 2023 13:47:18 +0000 (UTC)
Date: Tue, 22 Aug 2023 14:47:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 9/9] docs: Start documenting VM templating
Message-ID: <ZOS8ZNaRrcrNNNOe@redhat.com>
References: <20230822114504.239505-1-david@redhat.com>
 <20230822114504.239505-10-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230822114504.239505-10-david@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 22, 2023 at 01:44:57PM +0200, David Hildenbrand wrote:
> Let's add some details about VM templating, focusing on the VM memory
> configuration only.
> 
> There is much more to VM templating (VM state? block devices?), but I leave
> that as future work.

Then there's the supposedly "unique" hardware identifiers, most notably
VM UUID & NIC MAC addr that don't change if you create many VMs from
a "template". Or from the guest OS there are "unique" things like
/etc/machine-id, SSH host keys, web server certificates, etc.

The vmgenid device at least provides a way for guest OS to get notified
to update its unique resources/identifiers, but doesn't solve the overall
VM UUID. NIC MAC addr could be solved by hotunplug+plug either side of
creating the template & instantiating the template.

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  docs/vm-templating.txt | 109 +++++++++++++++++++++++++++++++++++++++++

Can you make this doument RST from the start and link to it from
somewhere appropriate in our documentation. Perhaps it should live
under the docs/system/ directory ?

>  1 file changed, 109 insertions(+)
>  create mode 100644 docs/vm-templating.txt
> 
> diff --git a/docs/vm-templating.txt b/docs/vm-templating.txt
> new file mode 100644
> index 0000000000..419362c1ea
> --- /dev/null
> +++ b/docs/vm-templating.txt
> @@ -0,0 +1,109 @@
> +QEMU VM templating
> +==================
> +
> +This document explains how to use VM templating in QEMU.
> +
> +For now, the focus is on VM memory aspects, and not about how to save and
> +restore other VM state (i.e., migrate-to-file with 'x-ignore-shared').
> +
> +Overview
> +--------
> +
> +With VM templating, a single template VM serves as the starting point for
> +new VMs. This allows for fast and efficient replication of VMs, resulting
> +in fast startup times and reduced memory consumption.
> +
> +Conceptually, the VM state is frozen, to then be used as a basis for new
> +VMs. The Copy-On-Write mechanism in the operating systems makes
> +sure that new VMs are able to read template VM memory; however, any
> +modifications stay private and don't modify the original template VM or any
> +other created VM.

I feel like we should have a paragraph at the top here explicitly calling
out the dangers of templating, wrt to unique data in the hardware and guest
OS. Don't have to provide solutions, just more of a scarcy "here be dragons"
warning to users who might be tempted to try this.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


