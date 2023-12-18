Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE16817574
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 16:37:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFFfi-000650-NQ; Mon, 18 Dec 2023 10:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rFFfa-0005lC-29
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 10:36:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rFFfU-0005rG-TV
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 10:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702913791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4bvx/ZML+G395CK8q8MutVS+t0ZGfK/ntYAEwj/TaGY=;
 b=AM91Iv0RfVWjoFYaeKIkv0XjUym+zF7w3Tz0IRNFnGGTE4ekujavn8g+NEkqMSao/tE42C
 753W4j0goLaBhJsCqdYZI3HXFhIeH/GQIb43s23xLByUXz+MjhTT2F8x5ZD9lQGZ/3Shtw
 y6vyxL6tfU88g6IvYGdeyeQ72/8jamA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-YrA_eJyzOHe5pX8xUfYcgw-1; Mon, 18 Dec 2023 10:36:30 -0500
X-MC-Unique: YrA_eJyzOHe5pX8xUfYcgw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 284978F7763;
 Mon, 18 Dec 2023 15:36:29 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 136572166B31;
 Mon, 18 Dec 2023 15:36:24 +0000 (UTC)
Date: Mon, 18 Dec 2023 16:36:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Cleber Rosa <crosa@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 Paul Durrant <paul@xen.org>, Ari Sundholm <ari@tuxera.com>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Wen Congyang <wencongyang2@huawei.com>, Alberto Garcia <berto@igalia.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Peter Xu <peterx@redhat.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 Fam Zheng <fam@euphon.net>, Leonardo Bras <leobras@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 10/14] aio: remove
 aio_context_acquire()/aio_context_release() API
Message-ID: <ZYBm9_Qpyt1-of30@redhat.com>
References: <20231205182011.1976568-1-stefanha@redhat.com>
 <20231205182011.1976568-11-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205182011.1976568-11-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.083,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 05.12.2023 um 19:20 hat Stefan Hajnoczi geschrieben:
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
> required and the iterations of code review that Emanuele eked out of
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
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


