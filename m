Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24597753B27
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 14:40:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKI5M-0001Mp-5F; Fri, 14 Jul 2023 08:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qKI5J-0001LA-91; Fri, 14 Jul 2023 08:39:45 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1qKI5H-0000xQ-47; Fri, 14 Jul 2023 08:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=XRwpfbYlu9Z7ZQ+dwkVY01n+FD2CTRH8gJMfm63X2Eg=; b=ezSp7eqc8Yp0qfOnZOLSSLD+yE
 wZd+gPfUR2jMuK21RmuQSfTfVZP0yhx5UMNEpf7CWZrlqzr4NqUG05wN75SK7By6AT0HnQujiwL/s
 bmv0wJQDEoj37VUPeyXeay04DOGFonJF+liXxg+C99sWOnvM//ablqnsFvLgJbwanRw2Q+SQY1RWW
 RELS/HKMtSdt+cmevYwC4NcmS4MoXaWKY4tXq8rh0wDAhs08ewqvP+F6WeM92lz/xL0veCVljhwN9
 VdYZu3Zs6QDhybN/twKStcp2APsiVXUZNKbEtzx/lnnq5F3kPhQM8r+pcbQbR9mvs1fPtDX9mjwGC
 AIR6lg34gcG6EouYqEvYhEAI5R2o/MeMC7X+GNx6WxPl9GXCbbBZYQf6NTDKyyYUEuRbibcEpLue5
 qypW/cP7wKou1ZHY0La2CbNVL4Q4b7ytR9Ao4i+Vwg2tdRpkiQAl2qs6zUg0L0f4HPUXEJSOgJCWk
 8R8AnLsrSF/XliawF2z27+XTpPrXrSRrxB/Lm6TmSeucba51sg5ZujknI8tU678dxkmH/eSrfHnTJ
 Yza7uLtCSuvC5Nejzg8bGow7DECVZo9Zjc5BkchzswcrUCbGzAy+B/x1Mu/1vp6GvfnCqg/+/8Zmn
 FM8UpiTsgi21u1sC9Oqqm882GYTemEwii5q9OSEbY=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH,
 trivial 07/29] tree-wide spelling fixes in comments and some messages:
 hw/9pfs
Date: Fri, 14 Jul 2023 14:39:16 +0200
Message-ID: <5231587.LrHBZLct7H@silver>
In-Reply-To: <20230714113834.1186117-9-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
 <20230714113834.1186117-9-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Friday, July 14, 2023 1:38:12 PM CEST Michael Tokarev wrote:
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  hw/9pfs/9p-local.c | 8 ++++----
>  hw/9pfs/9p-proxy.c | 2 +-
>  hw/9pfs/9p-synth.c | 2 +-
>  hw/9pfs/9p-util.h  | 2 +-
>  hw/9pfs/9p.c       | 4 ++--
>  hw/9pfs/9p.h       | 2 +-
>  6 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 9d07620235..1b1f3b9ec8 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -626,3 +626,3 @@ static ssize_t local_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
>           * We want to ensure that we don't leave dirty pages in the cache
> -         * after write when writeout=immediate is sepcified.
> +         * after write when writeout=immediate is specified.
>           */
> @@ -845,3 +845,3 @@ static int local_open2(FsContext *fs_ctx, V9fsPath *dir_path, const char *name,
>          if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
> -            /* Set cleint credentials in xattr */
> +            /* Set client credentials in xattr */
>              err = local_set_xattrat(dirfd, name, credp);
> @@ -914,3 +914,3 @@ static int local_symlink(FsContext *fs_ctx, const char *oldpath,
>          }
> -        /* Set cleint credentials in symlink's xattr */
> +        /* Set client credentials in symlink's xattr */
>          credp->fc_mode = credp->fc_mode | S_IFLNK;
> @@ -1420,3 +1420,3 @@ static int local_ioc_getversion_init(FsContext *ctx, LocalData *data, Error **er
>      /*
> -     * use ioc_getversion only if the ioctl is definied
> +     * use ioc_getversion only if the ioctl is defined
>       */
> diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
> index 905cae6992..7aac49ad4a 100644
> --- a/hw/9pfs/9p-proxy.c
> +++ b/hw/9pfs/9p-proxy.c
> @@ -769,3 +769,3 @@ static ssize_t proxy_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
>           * We want to ensure that we don't leave dirty pages in the cache
> -         * after write when writeout=immediate is sepcified.
> +         * after write when writeout=immediate is specified.
>           */
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index f62c40b639..0ac79a500b 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -495,3 +495,3 @@ static int synth_name_to_path(FsContext *ctx, V9fsPath *dir_path,
>      }
> -    /* search for the name in the childern */
> +    /* search for the name in the children */
>      rcu_read_lock();
> diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> index df1b583a5e..51c94b0116 100644
> --- a/hw/9pfs/9p-util.h
> +++ b/hw/9pfs/9p-util.h
> @@ -50,3 +50,3 @@ static inline uint64_t makedev_dotl(uint32_t dev_major, uint32_t dev_minor)
>   * device number format. As both the size of type dev_t and encoding of
> - * dev_t is system dependant, we have to convert them for Linux guests if
> + * dev_t is system dependent, we have to convert them for Linux guests if
>   * host is not running Linux.

That particular one is American English vs. British English, but OK, patch
LGTM:

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 991645adca..323f042e65 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -646,3 +646,3 @@ static inline uint64_t mirror64bit(uint64_t value)
>  /*
> - * Parameter k for the Exponential Golomb algorihm to be used.
> + * Parameter k for the Exponential Golomb algorithm to be used.
>   *
> @@ -1041,3 +1041,3 @@ static void coroutine_fn pdu_complete(V9fsPDU *pdu, ssize_t len)
>       * rather than a consequence of the cancellation. However, if
> -     * the operation completed (succesfully or with an error other
> +     * the operation completed (successfully or with an error other
>       * than caused be cancellation), we do send out that reply, both
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index 1b0d805b9c..a6f59abccb 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -306,3 +306,3 @@ typedef struct VariLenAffix {
>      /*
> -     * Lenght of the affix, that is how many (of the lowest) bits of ``value``
> +     * Length of the affix, that is how many (of the lowest) bits of ``value``
>       * must be used for appending/prepending this affix to its final resulting,
> 



