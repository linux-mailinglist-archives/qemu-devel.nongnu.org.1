Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F74705967
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 23:23:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz276-0004Ud-3K; Tue, 16 May 2023 17:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pz274-0004Th-3B
 for qemu-devel@nongnu.org; Tue, 16 May 2023 17:21:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1pz272-0000kB-Ah
 for qemu-devel@nongnu.org; Tue, 16 May 2023 17:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684272098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4f5UqKeYU72htf6xcJddM3qDx/kuu2jT7RNzs0NeCB8=;
 b=QknN+Es77u2ceylDGzhyHSknsCisi6AcLffMise5npK0EUOYqELXNsjNDugzLVTPpspAkf
 SXvJIol5uw1K9VX2pfsE2CBfj4TlxSYSKgdvZYvSJDRPHz8PUTv/T4kjJ+2c8ITtRToJrv
 D1rtznKm3zAo5uTnac+KjeEA7tvaGnE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-ewwoSSuwPI-_QMKv1eBBHA-1; Tue, 16 May 2023 17:21:36 -0400
X-MC-Unique: ewwoSSuwPI-_QMKv1eBBHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C04E3C0C882;
 Tue, 16 May 2023 21:21:36 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 880CE1121314;
 Tue, 16 May 2023 21:21:35 +0000 (UTC)
Date: Tue, 16 May 2023 16:21:33 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Andrew Melnychenko <andrew@daynix.com>, jasowang@redhat.com, 
 mst@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, 
 yuri.benditovich@daynix.com, yan@daynix.com
Subject: Re: [PATCH v2 3/6] virtio-net: Added property to load eBPF RSS with
 fds.
Message-ID: <n7bonyyib5d5d7pehlj6gly4fnu2k2sjkgwlq6lrcaoiee7spq@hgseblonnwl4>
References: <20230512122902.34345-1-andrew@daynix.com>
 <20230512122902.34345-4-andrew@daynix.com>
 <ZGH9pBm08TzJgUfJ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGH9pBm08TzJgUfJ@redhat.com>
User-Agent: NeoMutt/20230512
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On Mon, May 15, 2023 at 10:38:44AM +0100, Daniel P. Berrangé wrote:
> 
> > -static bool virtio_net_load_ebpf(VirtIONet *n)
> > +static bool virtio_net_load_ebpf_fds(VirtIONet *n, Error **errp)
> >  {
> > -    if (!virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
> > -        /* backend does't support steering ebpf */
> > -        return false;
> > +    int fds[EBPF_RSS_MAX_FDS] = { [0 ... EBPF_RSS_MAX_FDS - 1] = -1};
> 
> Interesting, I didn't realize this initialization syntax was possible !

It's not standard, but if both gcc and clang support it, it would not
be the first time we've relied on useful compiler extensions.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


