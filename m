Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B337A5BEC7
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 12:20:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxdo-00070r-8N; Tue, 11 Mar 2025 07:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1trxdl-00070c-2o
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:19:17 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1trxdi-0003XR-Pc
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=waAVVlq805tcrSB5VrWsTTJYMuNY9rBc1Qneq8SfVjU=; b=RHZmtPSZTcFYs1Mn92IM6cQ+MD
 gLN4HwEwTyABwzdrDS6BZuaAaU5j5AelqmLuKsi4hBXXClsql2kCKF0drPb4CTjEgutQZri7eOnEX
 U+wcQGMeVVm5T/wsRL+tPNMLQlLWRiSbB8dYb6GOpOI8eemONWAnfXEUoWG6wUq7NnNRpRRTbc3iE
 N1uLKHDHxB0ebdQYjoX/LcDusmWC9qUmpK7jpCCOrBNn6I4Rx9s/ynHzk244XkoQ5j0cxW4SM5Z7h
 Fr8M7fqBkrrpu0u8TRSRrlAJbt2JiCNvWf5T4Wze+wGPLGV4YQZ5fisjm4GizlCgc1PKsaFWwKy6C
 9zQQeAlZDsOy06ZN/57C72+kcZvwOskBC86VS4XmbiU8CBGAjlyNWGFJx0DItLF7wuUvqE0cGW2qv
 RjDxgx7DzwHE0/g9qfL/l7D7xc7GtnQ3r/H9nPfksEXXjJU5kKrp50ahZJXSC23rn9iqNmewpOyIv
 CIdKlozlRoJejsUZXGkaFTVbUQiSIudsze0WhjwgF8jTZ8PUc65NtmLCJvmhvOz5a46n+ckMYLEC+
 u62/sEASu7138JbmL5EAhT8n20yug3LSDoqnPr+mItp2VZtjapJeNZDY5WU653Fn8Akr19PnWkMTH
 asU12/QsU6LZ2uw5kHM9JSxzFlVSpIZDQom8RuVto=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 3/4] 9pfs: Introduce ftruncate file op
Date: Tue, 11 Mar 2025 12:19:10 +0100
Message-ID: <2585592.NyoZre6gin@silver>
In-Reply-To: <20250310171101.138380-4-groug@kaod.org>
References: <20250310171101.138380-1-groug@kaod.org>
 <20250310171101.138380-4-groug@kaod.org>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Monday, March 10, 2025 6:11:00 PM CET Greg Kurz wrote:
> Add an ftruncate operation to the fs driver and use if when a fid has
> a valid file descriptor. This is required to support more cases where
> the client wants to do an action on an unlinked file which it still
> has an open file decriptor for.
> 
> Only 9P2000.L was considered.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  fsdev/file-op-9p.h |  2 ++
>  hw/9pfs/9p-local.c |  9 +++++++++
>  hw/9pfs/9p-synth.c |  8 ++++++++
>  hw/9pfs/9p.c       |  6 +++++-
>  hw/9pfs/cofs.c     | 18 ++++++++++++++++++
>  hw/9pfs/coth.h     |  2 ++
>  6 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index 39fee185f4ce..40a40f7d8af8 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -165,6 +165,8 @@ struct FileOperations {
>                      V9fsPath *newdir, const char *new_name);
>      int (*unlinkat)(FsContext *ctx, V9fsPath *dir, const char *name, int flags);
>      bool (*has_valid_handle)(int fid_type, V9fsFidOpenState *fs);
> +    int (*ftruncate)(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
> +                     off_t size);
>  };
>  
>  #endif
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index 03e5304ef888..fa763b0662f5 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1046,6 +1046,14 @@ static int local_truncate(FsContext *ctx, V9fsPath *fs_path, off_t size)
>      return ret;
>  }
>  
> +static int local_ftruncate(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
> +                           off_t size)
> +{
> +    int fd = local_fid_fd(fid_type, fs);
> +
> +    return ftruncate(fd, size);
> +}
> +
>  static int local_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
>  {
>      char *dirpath = g_path_get_dirname(fs_path->data);
> @@ -1619,4 +1627,5 @@ FileOperations local_ops = {
>      .renameat  = local_renameat,
>      .unlinkat = local_unlinkat,
>      .has_valid_handle = local_has_valid_handle,
> +    .ftruncate = local_ftruncate,
>  };
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index fa0b187a1b80..7f0e13f0ddd8 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -356,6 +356,13 @@ static int synth_truncate(FsContext *ctx, V9fsPath *path, off_t offset)
>      return -1;
>  }
>  
> +static int synth_ftruncate(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
> +                           off_t size)
> +{
> +    errno = ENOSYS;
> +    return -1;
> +}
> +
>  static int synth_chmod(FsContext *fs_ctx, V9fsPath *path, FsCred *credp)
>  {
>      errno = EPERM;
> @@ -656,4 +663,5 @@ FileOperations synth_ops = {
>      .renameat     = synth_renameat,
>      .unlinkat     = synth_unlinkat,
>      .has_valid_handle = synth_has_valid_handle,
> +    .ftruncate    = synth_ftruncate,
>  };
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 969fb2f8c494..35b2ed900a01 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -1733,7 +1733,11 @@ static void coroutine_fn v9fs_setattr(void *opaque)
>          }
>      }
>      if (v9iattr.valid & (P9_ATTR_SIZE)) {
> -        err = v9fs_co_truncate(pdu, &fidp->path, v9iattr.size);
> +        if (fid_has_valid_handle(pdu->s, fidp)) {
> +            err = v9fs_co_ftruncate(pdu, fidp, v9iattr.size);
> +        } else {
> +            err = v9fs_co_truncate(pdu, &fidp->path, v9iattr.size);
> +        }
>          if (err < 0) {
>              goto out;
>          }
> diff --git a/hw/9pfs/cofs.c b/hw/9pfs/cofs.c
> index 67e3ae5c5ccd..893466fb1a44 100644
> --- a/hw/9pfs/cofs.c
> +++ b/hw/9pfs/cofs.c
> @@ -184,6 +184,24 @@ int coroutine_fn v9fs_co_truncate(V9fsPDU *pdu, V9fsPath *path, off_t size)
>      return err;
>  }
>  
> +int coroutine_fn v9fs_co_ftruncate(V9fsPDU *pdu, V9fsFidState *fidp, off_t size)
> +{
> +    int err;
> +    V9fsState *s = pdu->s;
> +
> +    if (v9fs_request_cancelled(pdu)) {
> +        return -EINTR;
> +    }
> +    v9fs_co_run_in_worker(
> +        {
> +            err = s->ops->ftruncate(&s->ctx, fidp->fid_type, &fidp->fs, size);
> +            if (err < 0) {
> +                err = -errno;
> +            }
> +        });
> +    return err;
> +}
> +
>  int coroutine_fn v9fs_co_mknod(V9fsPDU *pdu, V9fsFidState *fidp,
>                                 V9fsString *name, uid_t uid, gid_t gid,
>                                 dev_t dev, mode_t mode, struct stat *stbuf)
> diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
> index 2c54249b3577..0b8ee4c56495 100644
> --- a/hw/9pfs/coth.h
> +++ b/hw/9pfs/coth.h
> @@ -109,5 +109,7 @@ int coroutine_fn v9fs_co_name_to_path(V9fsPDU *, V9fsPath *,
>                                        const char *, V9fsPath *);
>  int coroutine_fn v9fs_co_st_gen(V9fsPDU *pdu, V9fsPath *path, mode_t,
>                                  V9fsStatDotl *v9stat);
> +int coroutine_fn v9fs_co_ftruncate(V9fsPDU *pdu, V9fsFidState *fidp,
> +                                   off_t size);
>  
>  #endif

Nit: I would move v9fs_co_ftruncate() close to v9fs_co_truncate() to make it
easier preserving the overview on this header file.

Rest looks fine:

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

/Christian



