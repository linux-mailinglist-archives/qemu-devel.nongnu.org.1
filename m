Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B1C7FFDBF
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 22:43:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8ooN-0004Vh-IJ; Thu, 30 Nov 2023 16:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r8ooK-0004Uo-Uk
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 16:43:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1r8ooJ-0001o9-E8
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 16:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701380582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MD69coIBlG9VqDYZ0wk5OAoCPvH1GgbHq/HJWPTguzs=;
 b=MR01+E3TAERnVS1O4MI7Cs14skM0ItGTeXgFl7wBTGFBbtuCzBxgsbT9SH9j2KtjIV7+wW
 Q6p77CRUvTcYTjXr+ifHKS1ruBf7kJlclOfQLNoKnqMbLQHWpG9l86TXp+nXOCQ31JD+U9
 sYUGzWV5zZssEG2//XWl/EwT3EoNG/A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-hUhmXwXxNcmZVg8thDKODw-1; Thu, 30 Nov 2023 16:42:59 -0500
X-MC-Unique: hUhmXwXxNcmZVg8thDKODw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DC1C811E7B;
 Thu, 30 Nov 2023 21:42:58 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.190])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B96D210EA5;
 Thu, 30 Nov 2023 21:42:54 +0000 (UTC)
Date: Thu, 30 Nov 2023 15:42:53 -0600
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
Subject: Re: [PATCH 08/12] aio: remove
 aio_context_acquire()/aio_context_release() API
Message-ID: <w4gmlvtpq3makf5selkqgqjn4qnazxcocsd3v2jv4hmq6336bb@7ojdiyvbsjlk>
References: <20231129195553.942921-1-stefanha@redhat.com>
 <20231129195553.942921-9-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129195553.942921-9-stefanha@redhat.com>
User-Agent: NeoMutt/20231103
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, Nov 29, 2023 at 02:55:49PM -0500, Stefan Hajnoczi wrote:
> Delete these functions because nothing calls these functions anymore.
> 
> I introduced these APIs in commit 98563fc3ec44 ("aio: add
> aio_context_acquire() and aio_context_release()") in 2014. It's with a
> sigh of relief that I delete these APIs almost 10 years later.
> 
> Thanks to Paolo Bonzini's vision for multi-queue QEMU, we got an
> understanding of where the code needed to go in order to remove the
> limitations that the original dataplane and the IOThread/AioContext
> approach that followed it.
> 
> Emanuele Giuseppe Esposito had the splendid determination to convert
> large parts of the codebase so that they no longer needed the AioContext
> lock. This was a painstaking process, both in the actual code changes
> required and the iterations of code review that Emanuele eeked out of

s/eeked/eked/

> Kevin and me over many months.
> 
> Kevin Wolf tackled multitudes of graph locking conversions to protect
> in-flight I/O from run-time changes to the block graph as well as the
> clang Thread Safety Analysis annotations that allow the compiler to
> check whether the graph lock is being used correctly.
> 
> And me, well, I'm just here to add some pizzazz to the QEMU multi-queue
> block layer :). Thank you to everyone who helped with this effort,
> including Eric Blake, code reviewer extraordinaire, and others who I've
> forgotten to mention.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/block/aio.h | 17 -----------------
>  util/async.c        | 10 ----------
>  2 files changed, 27 deletions(-)
>

Yay!

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


