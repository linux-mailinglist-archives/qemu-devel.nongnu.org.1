Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D992A56447
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Mar 2025 10:49:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqUIv-0007sd-Ip; Fri, 07 Mar 2025 04:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tqUIs-0007sP-S8; Fri, 07 Mar 2025 04:47:39 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tqUIq-0000vr-Ro; Fri, 07 Mar 2025 04:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=qY2IuMBT01FOC9RrR78BnLimhXagPLFhg+tp43sY9wY=; b=Aaid/L2RzphfO4jFRY+sNvm4DL
 CcwjqTFN4mRFE16OOIy9SFcIIC9nDGqd8XPznRPJ4TNMqtFZdzveVEn1gLSc057WHnLQts4mg0aWP
 5LoIII+Dp0Gy6zNnqyJxYn8Dhn5Sd3Y672Y7i0M5iJphkr5B35cBoXtykAYd6bQH4V6ClHAg6pfFE
 oktv4dPE2Re6rSlqpUFTHWiEPaZDTRxzgT3MoXI+zmLUirRZ3WVIRQHGn6LJEvBbiRStLwWcB70x5
 fbgtdWVvKrI6ncqZ3nn6iYOcLMlrWumTp1yJHZkUOWLuphivqzrMC1FEQZlTAn3z8viK/2kGZVZNu
 MUjPX+8dsVMsfpotIDnlfBTdve/nngk3dIGKExYK445i1Ko41eXi8YHK0xTPpGW1ekwWpCV3dLhwk
 ku9WAHsTAP1Ecv6wMDR/zYNexrz5jCAKxJ0LRCq7nflSigjwZPvBJZnfIswuI/EvqxKqwnwzH6Dty
 YM6dimAzKTc2GdWLlt9+NW4+Cphu5seY90pTR4Mwh2FBiCaLs8HWr8pRa9PFbD9yZZ06Fu9jjfADQ
 NEgKv4nOPoCib86GjSzaF2WPKMSjyYnJahQsaaUZP7pDQ4/ugB7+sWVZy+6DXXYIORdvOSAwnFKzP
 rs3n/gE1lMAKU5UODXW0OLNIiR+En40KX7y8AaltY=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, qemu-stable@nongnu.org
Subject: Re: [PATCH v2 2/2] 9pfs: fix FD leak and reduce latency of
 v9fs_reclaim_fd()
Date: Fri, 07 Mar 2025 10:47:33 +0100
Message-ID: <30024595.HyFKvjELBK@silver>
In-Reply-To: <5747469d3f039c53147e850b456943a1d4b5485c.1741339452.git.qemu_oss@crudebyte.com>
References: <cover.1741339452.git.qemu_oss@crudebyte.com>
 <5747469d3f039c53147e850b456943a1d4b5485c.1741339452.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Friday, March 7, 2025 10:23:02 AM CET Christian Schoenebeck wrote:
> This patch fixes two different bugs in v9fs_reclaim_fd():
> 
> 1. Reduce latency:
> 
> This function calls v9fs_co_close() and v9fs_co_closedir() in a loop. Each
> one of the calls adds two thread hops (between main thread and a fs driver
> background thread). Each thread hop adds latency, which sums up in
> function's loop to a significant duration.
> 
> Reduce overall latency by open coding what v9fs_co_close() and
> v9fs_co_closedir() do, executing those and the loop itself altogether in
> only one background thread block, hence reducing the total amount of
> thread hops to only two.
> 
> 2. Fix file descriptor leak:
> 
> The existing code called v9fs_co_close() and v9fs_co_closedir() to close
> file descriptors. Both functions check right at the beginning if the 9p
> request was cancelled:
> 
>     if (v9fs_request_cancelled(pdu)) {
>         return -EINTR;
>     }
> 
> So if client sent a 'Tflush' message, v9fs_co_close() / v9fs_co_closedir()
> returned without having closed the file descriptor and v9fs_reclaim_fd()
> subsequently freed the FID without its file descriptor being closed, hence
> leaking those file descriptors.
> 
> This 2nd bug is fixed by this patch as well by open coding v9fs_co_close()
> and v9fs_co_closedir() inside of v9fs_reclaim_fd() and not performing the
> v9fs_request_cancelled(pdu) check there.
> 
> Fixes: 7a46274529c ('hw/9pfs: Add file descriptor reclaim support')
> Fixes: bccacf6c792 ('hw/9pfs: Implement TFLUSH operation')
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  hw/9pfs/9p.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 4f9c2dde9c..80b190ff5b 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -434,6 +434,8 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
>      V9fsFidState *f;
>      GHashTableIter iter;
>      gpointer fid;
> +    int err;
> +    int nclosed = 0;
>  
>      /* prevent multiple coroutines running this function simultaniously */
>      if (s->reclaiming) {
> @@ -446,10 +448,10 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
>      QSLIST_HEAD(, V9fsFidState) reclaim_list =
>          QSLIST_HEAD_INITIALIZER(reclaim_list);
>  
> +    /* Pick FIDs to be closed, collect them on reclaim_list. */
>      while (g_hash_table_iter_next(&iter, &fid, (gpointer *) &f)) {
>          /*
> -         * Unlink fids cannot be reclaimed. Check
> -         * for them and skip them. Also skip fids
> +         * Unlinked fids cannot be reclaimed, skip those, and also skip fids
>           * currently being operated on.
>           */
>          if (f->ref || f->flags & FID_NON_RECLAIMABLE) {
> @@ -499,17 +501,26 @@ void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu)
>          }
>      }
>      /*
> -     * Now close the fid in reclaim list. Free them if they
> -     * are already clunked.
> +     * Close the picked FIDs altogether on a background I/O driver thread. Do
> +     * this all at once to keep latency (i.e. amount of thread hops between main
> +     * thread <-> fs driver background thread) as low as possible.
>       */
> +    v9fs_co_run_in_worker({
> +        QSLIST_FOREACH(f, &reclaim_list, reclaim_next) {
> +            err = (f->fid_type == P9_FID_DIR) ?
> +                s->ops->closedir(&s->ctx, &f->fs_reclaim) :
> +                s->ops->close(&s->ctx, &f->fs_reclaim);
> +            if (!err) {
> +                /* total_open_fd must only be mutated on main thread */
> +                nclosed++;
> +            }
> +        }
> +    });
> +    total_open_fd -= nclosed;

So here is another thing: looking at 'man 2 close' I would say that
decrementing 'total_open_fd' conditionally based on what close() returned is
wrong. The man page suggest that the return value of close() should only be
used for diagnostic purposes, as an error on close() often indicates just an
error on a previous write() and hence the return value should only be used for
catching a data loss related to writes.

So this should probably changed here, as well as in v9fs_co_close() /
v9fs_co_closedir(), part of a separate patch though, so I haven't addressed it
here yet.

Does this make sense?

/Christian

> +    /* Free the closed FIDs. */
>      while (!QSLIST_EMPTY(&reclaim_list)) {
>          f = QSLIST_FIRST(&reclaim_list);
>          QSLIST_REMOVE(&reclaim_list, f, V9fsFidState, reclaim_next);
> -        if (f->fid_type == P9_FID_FILE) {
> -            v9fs_co_close(pdu, &f->fs_reclaim);
> -        } else if (f->fid_type == P9_FID_DIR) {
> -            v9fs_co_closedir(pdu, &f->fs_reclaim);
> -        }
>          /*
>           * Now drop the fid reference, free it
>           * if clunked.
> 



