Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 564C27727A4
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:25:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT1As-0006sx-HI; Mon, 07 Aug 2023 10:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qT1AV-0006sW-UZ
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:25:12 -0400
Received: from 4.mo548.mail-out.ovh.net ([188.165.42.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1qT1AS-0007b4-Ax
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:25:11 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.246])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 0B96122030;
 Mon,  7 Aug 2023 14:24:56 +0000 (UTC)
Received: from kaod.org (37.59.142.110) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 16:24:55 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S004d27b8658-6325-4771-bc94-8590dfa59217,
 047F72E910A2B8B2EAB1B539FBA6DA9AA8DB97EF) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 78.113.105.161
Date: Mon, 7 Aug 2023 16:24:52 +0200
From: Greg Kurz <groug@kaod.org>
To: zhenwei pi <pizhenwei@bytedance.com>
CC: <berto@igalia.com>, <kwolf@redhat.com>, <hreitz@redhat.com>,
 <qemu_oss@crudebyte.com>, <qemu-devel@nongnu.org>, <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 8/9] fsdev: Use ThrottleDirection instread of bool
 is_write
Message-ID: <20230807162452.5160b645@bahia>
In-Reply-To: <20230728022006.1098509-9-pizhenwei@bytedance.com>
References: <20230728022006.1098509-1-pizhenwei@bytedance.com>
 <20230728022006.1098509-9-pizhenwei@bytedance.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.110]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 9f51b6c3-035d-48f6-9395-a29aea5d9763
X-Ovh-Tracer-Id: 18354420281531472233
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrledtgdejtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeegkeejtdevgeekieelffdvtedvvdegtdduudeigffhhffgvdfhgeejteekheefkeenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddutddpjeekrdduudefrddutdehrdduiedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoghhrohhugheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehpihiihhgvnhifvghisegshihtvggurghntggvrdgtohhmpdgsvghrthhosehighgrlhhirgdrtghomhdpkhifohhlfhesrhgvughhrghtrdgtohhmpdhhrhgvihhtiiesrhgvughhrghtrdgtohhmpdhqvghmuhgpohhsshestghruhguvggshihtvgdrtghomhdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpqhgvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdpoffvtefjohhsthepmhhoheegkedpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=188.165.42.229; envelope-from=groug@kaod.org;
 helo=4.mo548.mail-out.ovh.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 28 Jul 2023 10:20:05 +0800
zhenwei pi <pizhenwei@bytedance.com> wrote:

> 'bool is_write' style is obsolete from throttle framework, adapt
> fsdev to the new style.
> 
> Cc: Greg Kurz <groug@kaod.org>
> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>

Reviewed-by: Greg Kurz <groug@kaod.org>

> ---
>  fsdev/qemu-fsdev-throttle.c | 14 +++++++-------
>  fsdev/qemu-fsdev-throttle.h |  4 ++--
>  hw/9pfs/cofile.c            |  4 ++--
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
> index 1c137d6f0f..d912da906d 100644
> --- a/fsdev/qemu-fsdev-throttle.c
> +++ b/fsdev/qemu-fsdev-throttle.c
> @@ -94,22 +94,22 @@ void fsdev_throttle_init(FsThrottle *fst)
>      }
>  }
>  
> -void coroutine_fn fsdev_co_throttle_request(FsThrottle *fst, bool is_write,
> +void coroutine_fn fsdev_co_throttle_request(FsThrottle *fst,
> +                                            ThrottleDirection direction,
>                                              struct iovec *iov, int iovcnt)
>  {
> -    ThrottleDirection direction = is_write ? THROTTLE_WRITE : THROTTLE_READ;
> -
> +    assert(direction < THROTTLE_MAX);
>      if (throttle_enabled(&fst->cfg)) {
>          if (throttle_schedule_timer(&fst->ts, &fst->tt, direction) ||
> -            !qemu_co_queue_empty(&fst->throttled_reqs[is_write])) {
> -            qemu_co_queue_wait(&fst->throttled_reqs[is_write], NULL);
> +            !qemu_co_queue_empty(&fst->throttled_reqs[direction])) {
> +            qemu_co_queue_wait(&fst->throttled_reqs[direction], NULL);
>          }
>  
>          throttle_account(&fst->ts, direction, iov_size(iov, iovcnt));
>  
> -        if (!qemu_co_queue_empty(&fst->throttled_reqs[is_write]) &&
> +        if (!qemu_co_queue_empty(&fst->throttled_reqs[direction]) &&
>              !throttle_schedule_timer(&fst->ts, &fst->tt, direction)) {
> -            qemu_co_queue_next(&fst->throttled_reqs[is_write]);
> +            qemu_co_queue_next(&fst->throttled_reqs[direction]);
>          }
>      }
>  }
> diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
> index a21aecddc7..daa8ca2494 100644
> --- a/fsdev/qemu-fsdev-throttle.h
> +++ b/fsdev/qemu-fsdev-throttle.h
> @@ -23,14 +23,14 @@ typedef struct FsThrottle {
>      ThrottleState ts;
>      ThrottleTimers tt;
>      ThrottleConfig cfg;
> -    CoQueue      throttled_reqs[2];
> +    CoQueue      throttled_reqs[THROTTLE_MAX];
>  } FsThrottle;
>  
>  int fsdev_throttle_parse_opts(QemuOpts *, FsThrottle *, Error **);
>  
>  void fsdev_throttle_init(FsThrottle *);
>  
> -void coroutine_fn fsdev_co_throttle_request(FsThrottle *, bool ,
> +void coroutine_fn fsdev_co_throttle_request(FsThrottle *, ThrottleDirection ,
>                                              struct iovec *, int);
>  
>  void fsdev_throttle_cleanup(FsThrottle *);
> diff --git a/hw/9pfs/cofile.c b/hw/9pfs/cofile.c
> index 9c5344039e..71174c3e4a 100644
> --- a/hw/9pfs/cofile.c
> +++ b/hw/9pfs/cofile.c
> @@ -252,7 +252,7 @@ int coroutine_fn v9fs_co_pwritev(V9fsPDU *pdu, V9fsFidState *fidp,
>      if (v9fs_request_cancelled(pdu)) {
>          return -EINTR;
>      }
> -    fsdev_co_throttle_request(s->ctx.fst, true, iov, iovcnt);
> +    fsdev_co_throttle_request(s->ctx.fst, THROTTLE_WRITE, iov, iovcnt);
>      v9fs_co_run_in_worker(
>          {
>              err = s->ops->pwritev(&s->ctx, &fidp->fs, iov, iovcnt, offset);
> @@ -272,7 +272,7 @@ int coroutine_fn v9fs_co_preadv(V9fsPDU *pdu, V9fsFidState *fidp,
>      if (v9fs_request_cancelled(pdu)) {
>          return -EINTR;
>      }
> -    fsdev_co_throttle_request(s->ctx.fst, false, iov, iovcnt);
> +    fsdev_co_throttle_request(s->ctx.fst, THROTTLE_READ, iov, iovcnt);
>      v9fs_co_run_in_worker(
>          {
>              err = s->ops->preadv(&s->ctx, &fidp->fs, iov, iovcnt, offset);



-- 
Greg

