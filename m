Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BC0A64E7A
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Mar 2025 13:19:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu9RF-0004cX-H6; Mon, 17 Mar 2025 08:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1tu9RC-0004bK-6t; Mon, 17 Mar 2025 08:19:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zoudongjie@huawei.com>)
 id 1tu9R8-0003js-27; Mon, 17 Mar 2025 08:19:21 -0400
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZGYn60P1gz2RTyG;
 Mon, 17 Mar 2025 20:14:34 +0800 (CST)
Received: from kwepemk500007.china.huawei.com (unknown [7.202.194.92])
 by mail.maildlp.com (Postfix) with ESMTPS id 1A1B1180214;
 Mon, 17 Mar 2025 20:19:02 +0800 (CST)
Received: from huawei.com (10.246.99.19) by kwepemk500007.china.huawei.com
 (7.202.194.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 17 Mar
 2025 20:19:00 +0800
To: <stefanha@redhat.com>
CC: <fam@euphon.net>, <hreitz@redhat.com>, <kwolf@redhat.com>,
 <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>,
 <zhuyangyang14@huawei.com>, <luolongmin@huawei.com>,
 <suxiaodong1@huawei.com>, <wangyan122@huawei.com>, <yebiaoxiang@huawei.com>,
 <wangjian161@huawei.com>, <mujinsheng@huawei.com>, <alex.chen@huawei.com>,
 <eric.fangyi@huawei.com>, <zoudongjie@huawei.com>, <chenjianfei3@huawei.com>, 
 <renxuming@huawei.com>
Subject: Re: [PATCH 1/2] io/block: Refactoring the bdrv_drained_begin()
 function and implement a timeout mechanism.
Date: Mon, 17 Mar 2025 20:18:28 +0800
Message-ID: <20250317121828.4069621-1-zoudongjie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250313040945.GB1074020@fedora>
References: <20250313040945.GB1074020@fedora>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.246.99.19]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk500007.china.huawei.com (7.202.194.92)
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zoudongjie@huawei.com; helo=szxga04-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  zoudongjie <zoudongjie@huawei.com>
From:  zoudongjie via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, 13 Mar, 2025 at 12:09:45 +0800, Stefan Hajnoczi wrote:
> On Sat, Mar 08, 2025 at 06:16:17PM +0800, zoudongjie wrote:
> > From: Zhu Yangyang <zhuyangyang14@huawei.com>
> > 
> > The bdrv_drained_begin() function is a blocking function. In scenarios where network storage
> > is used and network links fail, it may block for a long time.
> > Therefore, we add a timeout parameter to control the duration of the block.
> > 
> > Since bdrv_drained_begin() has been widely adopted, both bdrv_drained_begin()
> > and bdrv_drained_begin_timeout() will be retained.
> > 
> > Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
> > ---
> >  block/io.c               | 55 ++++++++++++++++++++++++++++++-------
> >  include/block/aio-wait.h | 58 ++++++++++++++++++++++++++++++++++++++++
> >  include/block/block-io.h |  7 +++++
> >  util/aio-wait.c          |  7 +++++
> >  4 files changed, 117 insertions(+), 10 deletions(-)
> > 
> > diff --git a/block/io.c b/block/io.c
> > index d369b994df..03b8b2dca7 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -255,6 +255,8 @@ typedef struct {
> >      bool begin;
> >      bool poll;
> >      BdrvChild *parent;
> > +    int ret;
> > +    int64_t timeout;
> 
> Please put the units (milliseconds) into the variable name here and
> everywhere else in the patch to avoid confusion about units:
> 
>   int64_t timeout_ms;

Ok, I'm going to modify it in patch V2.

> 
> >  } BdrvCoDrainData;
> >  
> >  /* Returns true if BDRV_POLL_WHILE() should go into a blocking aio_poll() */
> > @@ -283,6 +285,8 @@ static bool bdrv_drain_poll_top_level(BlockDriverState *bs,
> >      return bdrv_drain_poll(bs, ignore_parent, false);
> >  }
> >  
> > +static int bdrv_do_drained_begin_timeout(BlockDriverState *bs,
> > +    BdrvChild *parent, bool poll, int64_t timeout);
> >  static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
> >                                    bool poll);
> >  static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent);
> > @@ -296,7 +300,8 @@ static void bdrv_co_drain_bh_cb(void *opaque)
> >      if (bs) {
> >          bdrv_dec_in_flight(bs);
> >          if (data->begin) {
> > -            bdrv_do_drained_begin(bs, data->parent, data->poll);
> > +            data->ret = bdrv_do_drained_begin_timeout(
> > +                bs, data->parent, data->poll, data->timeout);
> >          } else {
> >              assert(!data->poll);
> >              bdrv_do_drained_end(bs, data->parent);
> > @@ -310,10 +315,11 @@ static void bdrv_co_drain_bh_cb(void *opaque)
> >      aio_co_wake(co);
> >  }
> >  
> > -static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
> > -                                                bool begin,
> > -                                                BdrvChild *parent,
> > -                                                bool poll)
> > +static int coroutine_fn bdrv_co_yield_to_drain_timeout(BlockDriverState *bs,
> > +                                                         bool begin,
> > +                                                         BdrvChild *parent,
> > +                                                         bool poll,
> > +                                                         int64_t timeout)
> >  {
> >      BdrvCoDrainData data;
> >      Coroutine *self = qemu_coroutine_self();
> > @@ -329,6 +335,8 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
> >          .begin = begin,
> >          .parent = parent,
> >          .poll = poll,
> > +        .timeout = timeout,
> > +        .ret = 0
> >      };
> >  
> >      if (bs) {
> > @@ -342,16 +350,25 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
> >      /* If we are resumed from some other event (such as an aio completion or a
> >       * timer callback), it is a bug in the caller that should be fixed. */
> >      assert(data.done);
> > +    return data.ret;
> >  }
> >  
> > -static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
> > -                                  bool poll)
> > +static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
> > +                                                bool begin,
> > +                                                BdrvChild *parent,
> > +                                                bool poll)
> > +{
> > +    bdrv_co_yield_to_drain_timeout(bs, begin, parent, poll, -1);
> 
> Is this safe on 32-bit platforms?

I'm sorry, can it be more specific here, I didn't get it.

> 
> > +}
> > +
> > +static int bdrv_do_drained_begin_timeout(BlockDriverState *bs,
> > +    BdrvChild *parent, bool poll, int64_t timeout_ms)
> >  {
> >      IO_OR_GS_CODE();
> >  
> >      if (qemu_in_coroutine()) {
> > -        bdrv_co_yield_to_drain(bs, true, parent, poll);
> > -        return;
> > +        return bdrv_co_yield_to_drain_timeout(bs, true, parent, poll,
> > +                                              timeout_ms);
> >      }
> >  
> >      GLOBAL_STATE_CODE();
> > @@ -375,8 +392,20 @@ static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
> >       * nodes.
> >       */
> >      if (poll) {
> > -        BDRV_POLL_WHILE(bs, bdrv_drain_poll_top_level(bs, parent));
> > +        if (timeout_ms < 0) {
> > +            BDRV_POLL_WHILE(bs, bdrv_drain_poll_top_level(bs, parent));
> > +        } else {
> > +            return BDRV_POLL_WHILE_TIMEOUT(
> > +                bs, bdrv_drain_poll_top_level(bs, parent), timeout_ms);
> > +        }
> 
> Any reason to handle timeout_ms < 0 here instead of in
> BDRV_POLL_WHILE_TIMEOUT()? It would be more consistent to support -1 in
> BDRV_POLL_WHILE_TIMEOUT() so that you don't need to remember which
> functions/macros support timeout_ms=-1 and which dont.

Previously, BDRV_POLL_WHILE_TIMEOUT() was not done very well, aio_poll() exits
frequently because interval is used in the timer. but now I will support -1 in
BDRV_POLL_WHILE_TIMEOUT().

> 
> >      }
> > +    return 0;
> > +}
> > +
> > +static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
> > +                                  bool poll)
> > +{
> > +    bdrv_do_drained_begin_timeout(bs, parent, poll, -1);
> >  }
> >  
> >  void bdrv_do_drained_begin_quiesce(BlockDriverState *bs, BdrvChild *parent)
> > @@ -390,6 +419,12 @@ bdrv_drained_begin(BlockDriverState *bs)
> >      IO_OR_GS_CODE();
> >      bdrv_do_drained_begin(bs, NULL, true);
> >  }
> > +int coroutine_mixed_fn
> > +bdrv_drained_begin_timeout(BlockDriverState *bs, int64_t timeout_ms)
> > +{
> > +    IO_OR_GS_CODE();
> > +    return bdrv_do_drained_begin_timeout(bs, NULL, true, timeout_ms);
> > +}
> >  
> >  /**
> >   * This function does not poll, nor must any of its recursively called
> > diff --git a/include/block/aio-wait.h b/include/block/aio-wait.h
> > index cf5e8bde1c..efbcb9777a 100644
> > --- a/include/block/aio-wait.h
> > +++ b/include/block/aio-wait.h
> > @@ -28,6 +28,8 @@
> >  #include "block/aio.h"
> >  #include "qemu/main-loop.h"
> >  
> > +#define AIO_WAIT_INTERVAL 10  /* ms */
> > +
> >  /**
> >   * AioWait:
> >   *
> > @@ -56,6 +58,11 @@ typedef struct {
> >      unsigned num_waiters;
> >  } AioWait;
> >  
> > +typedef struct {
> > +    struct QEMUTimer *timer;
> 
> struct is not necessary since QEMUTimer is a typedef:
> 
>   QEMUTimer *timer;
> 
> Also, can this be a struct field instead of a pointer by using
> aio_timer_init_ms() instead of aio_timer_new()?

Ok, I'm going to modify it in patch V2.

> 
> > +    int64_t interval;
> > +} AioWaitTimer;
> > +
> >  extern AioWait global_aio_wait;
> >  
> >  /**
> > @@ -99,6 +106,55 @@ extern AioWait global_aio_wait;
> >      qatomic_dec(&wait_->num_waiters);                              \
> >      waited_; })
> >  
> > +/**
> > + * AIO_WAIT_WHILE_TIMEOUT:
> > + *
> > + * Refer to the implementation of AIO_WAIT_WHILE_INTERNAL,
> > + * the timeout parameter is added.
> > + */
> > +#define AIO_WAIT_WHILE_TIMEOUT(ctx, cond, timeout) ({                    \
> > +    int ret_ = 0;                                                        \
> > +    AioWait *wait_ = &global_aio_wait;                                   \
> > +    AioContext *ctx_ = (ctx);                                            \
> > +    int64_t start_ = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);             \
> > +    int64_t deadline_ = start_ + (timeout);                              \
> > +    /* Ensure that the aio_poll exits periodically to check timeout. */  \
> > +    AioWaitTimer *s_ = g_malloc0(sizeof(AioWaitTimer));                  \
> 
> Can this be allocated on the stack instead of the heap?

Yes, it's certainly better.

> 
> > +    s_->interval = AIO_WAIT_INTERVAL;                                    \
> > +    /* Increment wait_->num_waiters before evaluating cond. */           \
> > +    qatomic_inc(&wait_->num_waiters);                                    \
> > +    /* Paired with smp_mb in aio_wait_kick(). */                         \
> > +    smp_mb__after_rmw();                                                 \
> > +    if (ctx_ && in_aio_context_home_thread(ctx_)) {                      \
> > +        s_->timer = aio_timer_new(ctx_, QEMU_CLOCK_REALTIME,             \
> > +                        SCALE_MS, aio_wait_timer_retry, s_);             \
> > +        aio_wait_timer_retry(s_);                                        \
> > +        while ((cond)) {                                                 \
> > +            aio_poll(ctx_, true);                                        \
> > +            if (qemu_clock_get_ms(QEMU_CLOCK_REALTIME) > deadline_) {    \
> > +                ret_ = -ETIMEDOUT;                                       \
> > +                break;                                                   \
> > +            }                                                            \
> > +        }                                                                \
> 
> What is the purpose of interval?
> 
> I expected the timer's callback function to be an empty function that is
> called when the deadline expires. The while loop here would use
> timer_pending() to check for expiry instead of explicitly checking
> against the deadline.

This was really a good idea; it resolved some of my doubts and made everything
look better.

> 
> > +    } else {                                                             \
> > +        s_->timer = aio_timer_new(qemu_get_aio_context(),                \
> > +            QEMU_CLOCK_REALTIME, SCALE_MS, aio_wait_timer_retry, s_);    \
> > +        aio_wait_timer_retry(s_);                                        \
> > +        while ((cond)) {                                                 \
> > +            assert(qemu_get_current_aio_context() ==                     \
> > +                   qemu_get_aio_context());                              \
> > +            aio_poll(qemu_get_aio_context(), true);                      \
> > +            if (qemu_clock_get_ms(QEMU_CLOCK_REALTIME) > deadline_) {    \
> > +                ret_ = -ETIMEDOUT;                                       \
> > +                break;                                                   \
> > +            }                                                            \
> > +        }                                                                \
> > +    }                                                                    \
> > +    qatomic_dec(&wait_->num_waiters);                                    \
> > +    timer_free(s_->timer);                                               \
> 
> This will need to be timer_del() when the QEMUTimer is moved onto the
> stack.
> 
> > +    g_free(s_);                                                          \
> > +    ret_; })
> > +
> >  #define AIO_WAIT_WHILE(ctx, cond)                                  \
> >      AIO_WAIT_WHILE_INTERNAL(ctx, cond)
> >  
> > @@ -149,4 +205,6 @@ static inline bool in_aio_context_home_thread(AioContext *ctx)
> >      }
> >  }
> >  
> > +void aio_wait_timer_retry(void *opaque);
> > +
> >  #endif /* QEMU_AIO_WAIT_H */
> > diff --git a/include/block/block-io.h b/include/block/block-io.h
> > index b49e0537dd..84f92d2b09 100644
> > --- a/include/block/block-io.h
> > +++ b/include/block/block-io.h
> > @@ -354,6 +354,11 @@ bdrv_co_copy_range(BdrvChild *src, int64_t src_offset,
> >      AIO_WAIT_WHILE(bdrv_get_aio_context(bs_),              \
> >                     cond); })
> >  
> > +#define BDRV_POLL_WHILE_TIMEOUT(bs, cond, timeout) ({      \
> > +    BlockDriverState *bs_ = (bs);                          \
> > +    AIO_WAIT_WHILE_TIMEOUT(bdrv_get_aio_context(bs_),      \
> > +                           cond, timeout); })
> > +
> >  void bdrv_drain(BlockDriverState *bs);
> >  
> >  int co_wrapper_mixed_bdrv_rdlock
> > @@ -431,6 +436,8 @@ bdrv_drain_poll(BlockDriverState *bs, BdrvChild *ignore_parent,
> >   */
> >  void bdrv_drained_begin(BlockDriverState *bs);
> >  
> > +int bdrv_drained_begin_timeout(BlockDriverState *bs, int64_t timeout_ms);
> > +
> >  /**
> >   * bdrv_do_drained_begin_quiesce:
> >   *
> > diff --git a/util/aio-wait.c b/util/aio-wait.c
> > index b5336cf5fd..9aed165529 100644
> > --- a/util/aio-wait.c
> > +++ b/util/aio-wait.c
> > @@ -84,3 +84,10 @@ void aio_wait_bh_oneshot(AioContext *ctx, QEMUBHFunc *cb, void *opaque)
> >      aio_bh_schedule_oneshot(ctx, aio_wait_bh, &data);
> >      AIO_WAIT_WHILE_UNLOCKED(NULL, !data.done);
> >  }
> > +
> > +void aio_wait_timer_retry(void *opaque)
> > +{
> > +    AioWaitTimer *s = opaque;
> > +
> > +    timer_mod(s->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + s->interval);
> > +}
> > -- 
> > 2.33.0
> > 

