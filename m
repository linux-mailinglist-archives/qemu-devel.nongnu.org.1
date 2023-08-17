Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B129477F44E
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 12:30:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWaFR-0001za-BU; Thu, 17 Aug 2023 06:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWaFP-0001zE-Lf
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWaFN-0007ap-Al
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692268136;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+C7NO+l8mwYclkpE3yHBTVqpwC+SDhjuIEJDdHA4mMI=;
 b=BdIEYxOnxb9Z3q1JhCN5Dw2BY6k/ybE3L5zucFwgSw8Gj0u658A60FDfWBumgtBeN8cqTK
 SGjVax9BD9P7PorbFQDRsLrXtXl75QPoYrHLZ+lMRqkud4DT/qwhjxv2XgDLC46jt/h4+Q
 kbzl4SsmwajoIbBsPJzHiRGT5u27W3c=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-498yJ57-MkywVSLTjgRfiw-1; Thu, 17 Aug 2023 06:28:53 -0400
X-MC-Unique: 498yJ57-MkywVSLTjgRfiw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC290280D20B;
 Thu, 17 Aug 2023 10:28:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6FED2166B2D;
 Thu, 17 Aug 2023 10:28:51 +0000 (UTC)
Date: Thu, 17 Aug 2023 11:28:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: Efim Shevrin <efim.shevrin@virtuozzo.com>, qemu-devel@nongnu.org,
 michael.roth@amd.com, pbonzini@redhat.com, den@openvz.org
Subject: Re: [PATCH] qga: Start qemu-ga service after NetworkManager start
Message-ID: <ZN32YVFOGSgIATTP@redhat.com>
References: <20230816200446.1408797-1-efim.shevrin@virtuozzo.com>
 <CAPMcbCowQoNn4b-Q+wFeT8m2OTFU+PDkDGq8=U--tdeEcDjk6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPMcbCowQoNn4b-Q+wFeT8m2OTFU+PDkDGq8=U--tdeEcDjk6Q@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Thu, Aug 17, 2023 at 09:15:08AM +0300, Konstantin Kostiuk wrote:
> Hi, Efim
> 
> Thanks for your contribution.
> 
> I think your patch is a partial solution because other network managers can
> be used
> for example systemd-networkd or dhcpcd. Maybe a better solution is
> After=network.target.

network.target does not imply that any NICs are configured with
an IP address, merely that the networking mgmt daemon(s) are
running.  A dep on NetworkManager.service has the same issue.
NetworkManager has started, but this doesn't imply DHCP has
completed

network-online.target has the semantics that an IP is present,
but per my other reply I don't think we should be serializing
QGA startup against network configuration.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


