Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB3E822CDF
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 13:21:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL0Dt-0002jr-BL; Wed, 03 Jan 2024 07:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rL0Dp-0002jT-Ua
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 07:19:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rL0Dm-0006Av-Gs
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 07:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704284381;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4vzcw7xKNK6mWrMTxaU+BLH5+QWHgnxCjT8dTJ2P8XA=;
 b=OP8XNjhx3dsDKBhNoxNJHd7XAH3T9JqgrYdMsNrP8qKF1rU3SjFT6CjU25yFeq6DPc3j6v
 Q0uZlWln6LNAfwXaAqR7AmXRW8auu5TySDJ88Nz4hC8WuzVnFS7Y7zsNSvo5aXqZQCOhjH
 IQ0Vsdhrmzf04IR3dxhSiqcWne54LE4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-pqAC7zpGMXuswRKPanPDIQ-1; Wed, 03 Jan 2024 07:19:39 -0500
X-MC-Unique: pqAC7zpGMXuswRKPanPDIQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CE9C185A784;
 Wed,  3 Jan 2024 12:19:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D02251D5;
 Wed,  3 Jan 2024 12:19:37 +0000 (UTC)
Date: Wed, 3 Jan 2024 12:19:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, sw@weilnetz.de,
 t.lamprecht@proxmox.com
Subject: Re: [PATCH v2] qemu_init: increase NOFILE soft limit on POSIX
Message-ID: <ZZVQ1-QwlwdQBlLu@redhat.com>
References: <20231218101340.35053-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231218101340.35053-1-f.ebner@proxmox.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
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

On Mon, Dec 18, 2023 at 11:13:40AM +0100, Fiona Ebner wrote:
> In many configurations, e.g. multiple vNICs with multiple queues or
> with many Ceph OSDs, the default soft limit of 1024 is not enough.
> QEMU is supposed to work fine with file descriptors >= 1024 and does
> not use select() on POSIX. Bump the soft limit to the allowed hard
> limit to avoid issues with the aforementioned configurations.
> 
> Of course the limit could be raised from the outside, but the man page
> of systemd.exec states about 'LimitNOFILE=':
> 
> > Don't use.
> > [...]
> > Typically applications should increase their soft limit to the hard
> > limit on their own, if they are OK with working with file
> > descriptors above 1023,
> 
> If the soft limit is already the same as the hard limit, avoid the
> superfluous setrlimit call. This can avoid a warning with a strict
> seccomp filter blocking setrlimit if NOFILE was already raised before
> executing QEMU.
> 
> Buglink: https://bugzilla.proxmox.com/show_bug.cgi?id=4507
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


