Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBD9A5DECE
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Mar 2025 15:22:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMy0-0007mm-SC; Wed, 12 Mar 2025 10:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tsMxl-0007m5-1k
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:21:37 -0400
Received: from 3.mo548.mail-out.ovh.net ([188.165.32.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1tsMxh-0002bH-Rz
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:21:36 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.140.99])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4ZCXqk0r29z10ds;
 Wed, 12 Mar 2025 14:21:22 +0000 (UTC)
Received: from kaod.org (37.59.142.109) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 12 Mar
 2025 15:21:21 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S0033cae644e-50fc-43c3-85cf-76321d372641,
 504EDC0C94310F6A3F54FBF2D573176B3056D9B9) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Wed, 12 Mar 2025 15:21:12 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, Fabiano Rosas <farosas@suse.de>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 3/6] 9pfs: Introduce ftruncate file op
Message-ID: <20250312152112.5ff5df6b@bahia>
In-Reply-To: <2348866.qVP5gfYQ7p@silver>
References: <20250311172809.250913-1-groug@kaod.org>
 <20250311172809.250913-4-groug@kaod.org>
 <2348866.qVP5gfYQ7p@silver>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.109]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: 0c5784d8-1e4c-4706-b807-df18d58c4ff1
X-Ovh-Tracer-Id: 10980338845603240355
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgihesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgeekjedtveegkeeileffvdetvddvgedtudduiefghffhgfdvhfegjeetkeehfeeknecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdelpdekkedrudejledrledrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopeehpdhrtghpthhtohepqhgvmhhupghoshhssegtrhhuuggvsgihthgvrdgtohhmpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehfrghrohhsrghssehsuhhsvgdruggvpdhrtghpthhtohepphgsohhniihinhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlvhhivhhivghrsehrvgguhhgrthdrtghomhdpoffvtefjohhsthepmhhoheegkegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=3uTuXH3lGOzFsYSDn6iSTkK7+bt7ZdkWD+ZV+s1m5oA=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1741789282; v=1;
 b=n30Jz+O06PWdlgMWSMJzrM2Ze1DN7rIqEib4PzknDLK/XgBgXGgXuMvdM5phQ/MMhPTaCxSx
 hrpdQ9Eaf7Xn0Do/8zXkAykeSdm8+VNbIVepBQbqFMr1vka00K9kxflmA9rZsqdKCa5Lr7uSVc0
 B8myRFIWDs3u3sRKcNVVl1IQ5HubR5mnrZyP0Xq8xXGI+WUK3XILWZODE5K+u44MqNj0MuHb7q1
 EE8DWP/aD49/0U9gBtc28+lTHgNJbZJ1HVpze4tsBlwDBRGikxRAQA3mg/ABxEOZE5ifHZ09Jos
 VApLSqi7h7ieZ0wqZYDtX67eQXyuHHvdC6f3RXZh/onnw==
Received-SPF: pass client-ip=188.165.32.156; envelope-from=groug@kaod.org;
 helo=3.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 12 Mar 2025 15:07:20 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Tuesday, March 11, 2025 6:28:06 PM CET Greg Kurz wrote:
> > Add an ftruncate operation to the fs driver and use if when a fid has
> > a valid file descriptor. This is required to support more cases where
> > the client wants to do an action on an unlinked file which it still
> > has an open file decriptor for.
> > 
> > Only 9P2000.L was considered.
> > 
> > Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > 
> > v2: - moved v9fs_co_ftruncate() near v9fs_co_truncate() in coth.h
> >     - similar change in file-op-9p.h
> > ---
> >  fsdev/file-op-9p.h |  2 ++
> >  hw/9pfs/9p-local.c |  9 +++++++++
> >  hw/9pfs/9p-synth.c |  8 ++++++++
> >  hw/9pfs/9p.c       |  6 +++++-
> >  hw/9pfs/cofs.c     | 18 ++++++++++++++++++
> >  hw/9pfs/coth.h     |  2 ++
> >  6 files changed, 44 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> > index b815cea44e85..26ba1438c0ed 100644
> > --- a/fsdev/file-op-9p.h
> > +++ b/fsdev/file-op-9p.h
> > @@ -152,6 +152,8 @@ struct FileOperations {
> >      int (*fstat)(FsContext *, int, V9fsFidOpenState *, struct stat *);
> >      int (*rename)(FsContext *, const char *, const char *);
> >      int (*truncate)(FsContext *, V9fsPath *, off_t);
> > +    int (*ftruncate)(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
> > +                     off_t size);
> >      int (*fsync)(FsContext *, int, V9fsFidOpenState *, int);
> >      int (*statfs)(FsContext *s, V9fsPath *path, struct statfs *stbuf);
> >      ssize_t (*lgetxattr)(FsContext *, V9fsPath *,
> > diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> > index b16132299f2c..0b33da8d2a46 100644
> > --- a/hw/9pfs/9p-local.c
> > +++ b/hw/9pfs/9p-local.c
> > @@ -1042,6 +1042,14 @@ static int local_truncate(FsContext *ctx, V9fsPath *fs_path, off_t size)
> >      return ret;
> >  }
> >  
> > +static int local_ftruncate(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
> > +                           off_t size)
> > +{
> > +    int fd = local_fid_fd(fid_type, fs);
> > +
> > +    return ftruncate(fd, size);
> > +}
> > +
> >  static int local_chown(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
> >  {
> >      char *dirpath = g_path_get_dirname(fs_path->data);
> > @@ -1617,4 +1625,5 @@ FileOperations local_ops = {
> >      .renameat  = local_renameat,
> >      .unlinkat = local_unlinkat,
> >      .has_valid_file_handle = local_has_valid_file_handle,
> > +    .ftruncate = local_ftruncate,
> >  };
> > diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> > index be0492b400e1..3d28afc4d03d 100644
> > --- a/hw/9pfs/9p-synth.c
> > +++ b/hw/9pfs/9p-synth.c
> > @@ -356,6 +356,13 @@ static int synth_truncate(FsContext *ctx, V9fsPath *path, off_t offset)
> >      return -1;
> >  }
> >  
> > +static int synth_ftruncate(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
> > +                           off_t size)
> > +{
> > +    errno = ENOSYS;
> > +    return -1;
> > +}
> > +
> >  static int synth_chmod(FsContext *fs_ctx, V9fsPath *path, FsCred *credp)
> >  {
> >      errno = EPERM;
> > @@ -656,4 +663,5 @@ FileOperations synth_ops = {
> >      .renameat     = synth_renameat,
> >      .unlinkat     = synth_unlinkat,
> >      .has_valid_file_handle = synth_has_valid_file_handle,
> > +    .ftruncate    = synth_ftruncate,
> >  };
> > diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> > index 10363f1a1df8..4616bd763012 100644
> > --- a/hw/9pfs/9p.c
> > +++ b/hw/9pfs/9p.c
> > @@ -1733,7 +1733,11 @@ static void coroutine_fn v9fs_setattr(void *opaque)
> >          }
> >      }
> >      if (v9iattr.valid & (P9_ATTR_SIZE)) {
> > -        err = v9fs_co_truncate(pdu, &fidp->path, v9iattr.size);
> > +        if (fid_has_valid_handle(pdu->s, fidp)) {
> > +            err = v9fs_co_ftruncate(pdu, fidp, v9iattr.size);
> > +        } else {
> > +            err = v9fs_co_truncate(pdu, &fidp->path, v9iattr.size);
> > +        }
> 
> Like with previous patch, s/fid_has_valid_handle/fid_has_valid_file_handle/,
> the rest is fine.
> 

Oops... my bad. I'll fix that !

> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> 
> >          if (err < 0) {
> >              goto out;
> >          }
> > diff --git a/hw/9pfs/cofs.c b/hw/9pfs/cofs.c
> > index 67e3ae5c5ccd..893466fb1a44 100644
> > --- a/hw/9pfs/cofs.c
> > +++ b/hw/9pfs/cofs.c
> > @@ -184,6 +184,24 @@ int coroutine_fn v9fs_co_truncate(V9fsPDU *pdu, V9fsPath *path, off_t size)
> >      return err;
> >  }
> >  
> > +int coroutine_fn v9fs_co_ftruncate(V9fsPDU *pdu, V9fsFidState *fidp, off_t size)
> > +{
> > +    int err;
> > +    V9fsState *s = pdu->s;
> > +
> > +    if (v9fs_request_cancelled(pdu)) {
> > +        return -EINTR;
> > +    }
> > +    v9fs_co_run_in_worker(
> > +        {
> > +            err = s->ops->ftruncate(&s->ctx, fidp->fid_type, &fidp->fs, size);
> > +            if (err < 0) {
> > +                err = -errno;
> > +            }
> > +        });
> > +    return err;
> > +}
> > +
> >  int coroutine_fn v9fs_co_mknod(V9fsPDU *pdu, V9fsFidState *fidp,
> >                                 V9fsString *name, uid_t uid, gid_t gid,
> >                                 dev_t dev, mode_t mode, struct stat *stbuf)
> > diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
> > index 2c54249b3577..62e922dc12e3 100644
> > --- a/hw/9pfs/coth.h
> > +++ b/hw/9pfs/coth.h
> > @@ -73,6 +73,8 @@ int coroutine_fn v9fs_co_chmod(V9fsPDU *, V9fsPath *, mode_t);
> >  int coroutine_fn v9fs_co_utimensat(V9fsPDU *, V9fsPath *, struct timespec [2]);
> >  int coroutine_fn v9fs_co_chown(V9fsPDU *, V9fsPath *, uid_t, gid_t);
> >  int coroutine_fn v9fs_co_truncate(V9fsPDU *, V9fsPath *, off_t);
> > +int coroutine_fn v9fs_co_ftruncate(V9fsPDU *pdu, V9fsFidState *fidp,
> > +                                   off_t size);
> >  int coroutine_fn v9fs_co_llistxattr(V9fsPDU *, V9fsPath *, void *, size_t);
> >  int coroutine_fn v9fs_co_lgetxattr(V9fsPDU *, V9fsPath *,
> >                                     V9fsString *, void *, size_t);
> > 
> 
> 



-- 
Greg

