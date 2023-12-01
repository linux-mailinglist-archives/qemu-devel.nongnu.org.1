Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6B5801216
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:51:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r97ep-0002r5-Cx; Fri, 01 Dec 2023 12:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r97em-0002lb-KD
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:50:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r97ej-00046H-SJ
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:50:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701453015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gVzSOJaOURMhSPu/ykMOhMUOlZ5huh+Np23QMDeR1QM=;
 b=SMkGZZQjVBL4bdoK+EzSzw3+ILGo8/VzO9z9vdrMqJblsnh/uDaNm5ayXgkBrbtRfUXmyD
 kbqCYkhtfGVpzF7o7Jk6KYHIrLxfpPoGGtQoAL6CJlhiCY86RRRsJTPPEVuEpSK6g7uw+u
 4/vgUsftbg65BdJSwNv87WijW3NqAu0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-wiJksplgOqK26WQxCrz9YQ-1; Fri, 01 Dec 2023 12:50:08 -0500
X-MC-Unique: wiJksplgOqK26WQxCrz9YQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4EB2811E86;
 Fri,  1 Dec 2023 17:50:07 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C7731121307;
 Fri,  1 Dec 2023 17:50:04 +0000 (UTC)
Date: Fri, 1 Dec 2023 11:50:02 -0600
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alberto Garcia <berto@igalia.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>, 
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Wen Congyang <wencongyang2@huawei.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, 
 Coiby Xu <Coiby.Xu@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Xie Changlong <xiechanglong.d@gmail.com>, Ari Sundholm <ari@tuxera.com>, 
 Li Zhijian <lizhijian@fujitsu.com>, Cleber Rosa <crosa@redhat.com>, 
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhang Chen <chen.zhang@intel.com>, Peter Xu <peterx@redhat.com>, 
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Leonardo Bras <leobras@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Fam Zheng <fam@euphon.net>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 11/12] job: remove outdated AioContext locking comments
Message-ID: <7ppmz3puvasog2osajahmk2frxmdyfmiqphtlktcjw4ovif65z@mvbwdmhlgq77>
References: <20231129195553.942921-1-stefanha@redhat.com>
 <20231129195553.942921-12-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129195553.942921-12-stefanha@redhat.com>
User-Agent: NeoMutt/20231103
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Nov 29, 2023 at 02:55:52PM -0500, Stefan Hajnoczi wrote:
> The AioContext lock no longer exists.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/qemu/job.h | 20 --------------------
>  1 file changed, 20 deletions(-)
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


