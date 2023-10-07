Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A069E7BC978
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 19:56:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpBWA-00060s-6u; Sat, 07 Oct 2023 13:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qpBW5-000605-LF; Sat, 07 Oct 2023 13:55:05 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qpBW2-00046K-SF; Sat, 07 Oct 2023 13:55:05 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d90da64499cso3474733276.0; 
 Sat, 07 Oct 2023 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696701300; x=1697306100; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vA1CY3pqCWDWa73bWJB56ywJQ1o+AAHsIsnT6+THOgI=;
 b=LW3kD0uGsLldJ/rTVrGU+MeFxih/+XFwUTYakJL7m2oEHiLgjfi6L6Ki/MjHH496JN
 c4CR1A7hNHllkdviZeassMuiGi2sPq4w4J6m41c7qfU9vBcSlXkWVVfbmATseHWKZtlE
 sucnBBMAKQmwVQ9id4q/f5LCQRjeemAXqHFJnSC15/4JAIjA8PkNfWvDqsCmPJB3srxW
 o8t+31YI60VvsycRp10eJZHGF+Kn1dU30NjsFw5Ho+Ne/zIB+e0pMGO94+ErBc4HzAeN
 yUa7+rljU0S7IMCBVO81PAGXaAJ0WT1i8U/ZEmha7mbKXQa4RF8WRICQwDR4u5mRXFEc
 y3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696701300; x=1697306100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vA1CY3pqCWDWa73bWJB56ywJQ1o+AAHsIsnT6+THOgI=;
 b=OL0uA1z0IQH3exY3vLQUAngPwQXIq1ydkH6X1kZuaC1jEfsH8Ja6Mk1qLZ8oFM+sCQ
 gTAtIQ8lZMF/+qQRGuptRznVjj52QGdQzpRcMIyg0jLeyWiiIT1BzygmSpOP69g1rwF8
 vA2IRaRf+zGeXyVOoEbLw/686qiBOU6cagerRzVTdoZQO9n8zgzokwU6QtF8Sfyh8pzj
 zetDfjXjI9ene61HY42CXyq5XVGr4MEr4gDmYIP19UPIsty+X1OW5AZQiFkjMfPOfLDb
 odHKsDoBPeM9o1PCtMFIXHpkQpUigLwSgS7fxTSms5TBgP4NgJJFO/s1UzO9hP1VKcsf
 MGkw==
X-Gm-Message-State: AOJu0YxpC58H5/eXNtfFSzYRd6IRKsKZiktaZkIVTn4nmn60gD4dduxu
 w257RhWl4KIiirIxLYlbFjYdI847aPORaxxyo3Y=
X-Google-Smtp-Source: AGHT+IHG2UwMvqC5kWCJ4tFCByyW9icDfXikKwvrHGUIjfk7cW+F7xpDLxUf6t2C2AL1x5JNjV/59h53REmPiAqSIeE=
X-Received: by 2002:a25:acd2:0:b0:d4a:d2e2:afe0 with SMTP id
 x18-20020a25acd2000000b00d4ad2e2afe0mr11379905ybd.14.1696701300030; Sat, 07
 Oct 2023 10:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
 <20231002085738.369684-16-alexander.ivanov@virtuozzo.com>
 <CAL77WPCgbWch6TqjBucJJ_MfG2nOFtoA=oT9EbAE+V_kDTfCgA@mail.gmail.com>
 <f050b078-1f8d-41d1-a469-4f92d4248580@virtuozzo.com>
 <CAL77WPB37-y4GeWXgy2xQ93_riZkR0q50Gs0apqvFoC6kZwDZg@mail.gmail.com>
 <9240b820-9d8f-42bc-a4f1-7a69656635a4@virtuozzo.com>
In-Reply-To: <9240b820-9d8f-42bc-a4f1-7a69656635a4@virtuozzo.com>
From: Mike Maslenkin <mike.maslenkin@gmail.com>
Date: Sat, 7 Oct 2023 20:54:24 +0300
Message-ID: <CAL77WPC4ae+YzxBwNg9jLn93FUAuC8-b3vwzge7ktYBm62_1SQ@mail.gmail.com>
Subject: Re: [PATCH 15/19] parallels: Remove unnecessary data_end field
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com, 
 stefanha@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com, 
 hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-yb1-xb2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sat, Oct 7, 2023 at 5:30=E2=80=AFPM Alexander Ivanov
<alexander.ivanov@virtuozzo.com> wrote:
>
>
>
> On 10/7/23 13:21, Mike Maslenkin wrote:
> > On Sat, Oct 7, 2023 at 1:18=E2=80=AFPM Alexander Ivanov
> > <alexander.ivanov@virtuozzo.com>  wrote:
> >>
> >> On 10/6/23 21:43, Mike Maslenkin wrote:
> >>> On Mon, Oct 2, 2023 at 12:01=E2=80=AFPM Alexander Ivanov
> >>> <alexander.ivanov@virtuozzo.com>  wrote:
> >>>> Since we have used bitmap, field data_end in BDRVParallelsState is
> >>>> redundant and can be removed.
> >>>>
> >>>> Add parallels_data_end() helper and remove data_end handling.
> >>>>
> >>>> Signed-off-by: Alexander Ivanov<alexander.ivanov@virtuozzo.com>
> >>>> ---
> >>>>    block/parallels.c | 33 +++++++++++++--------------------
> >>>>    block/parallels.h |  1 -
> >>>>    2 files changed, 13 insertions(+), 21 deletions(-)
> >>>>
> >>>> diff --git a/block/parallels.c b/block/parallels.c
> >>>> index 48ea5b3f03..80a7171b84 100644
> >>>> --- a/block/parallels.c
> >>>> +++ b/block/parallels.c
> >>>> @@ -265,6 +265,13 @@ static void parallels_free_used_bitmap(BlockDri=
verState *bs)
> >>>>        g_free(s->used_bmap);
> >>>>    }
> >>>>
> >>>> +static int64_t parallels_data_end(BDRVParallelsState *s)
> >>>> +{
> >>>> +    int64_t data_end =3D s->data_start * BDRV_SECTOR_SIZE;
> >>>> +    data_end +=3D s->used_bmap_size * s->cluster_size;
> >>>> +    return data_end;
> >>>> +}
> >>>> +
> >>>>    int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
> >>>>                                             int64_t *clusters)
> >>>>    {
> >>>> @@ -275,7 +282,7 @@ int64_t parallels_allocate_host_clusters(BlockDr=
iverState *bs,
> >>>>
> >>>>        first_free =3D find_first_zero_bit(s->used_bmap, s->used_bmap=
_size);
> >>>>        if (first_free =3D=3D s->used_bmap_size) {
> >>>> -        host_off =3D s->data_end * BDRV_SECTOR_SIZE;
> >>>> +        host_off =3D parallels_data_end(s);
> >>>>            prealloc_clusters =3D *clusters + s->prealloc_size / s->t=
racks;
> >>>>            bytes =3D prealloc_clusters * s->cluster_size;
> >>>>
> >>>> @@ -297,9 +304,6 @@ int64_t parallels_allocate_host_clusters(BlockDr=
iverState *bs,
> >>>>            s->used_bmap =3D bitmap_zero_extend(s->used_bmap, s->used=
_bmap_size,
> >>>>                                              new_usedsize);
> >>>>            s->used_bmap_size =3D new_usedsize;
> >>>> -        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
> >>>> -            s->data_end =3D (host_off + bytes) / BDRV_SECTOR_SIZE;
> >>>> -        }
> >>>>        } else {
> >>>>            next_used =3D find_next_bit(s->used_bmap, s->used_bmap_si=
ze, first_free);
> >>>>
> >>>> @@ -315,8 +319,7 @@ int64_t parallels_allocate_host_clusters(BlockDr=
iverState *bs,
> >>>>             * branch. In the other case we are likely re-using hole.=
 Preallocate
> >>>>             * the space if required by the prealloc_mode.
> >>>>             */
> >>>> -        if (s->prealloc_mode =3D=3D PRL_PREALLOC_MODE_FALLOCATE &&
> >>>> -                host_off < s->data_end * BDRV_SECTOR_SIZE) {
> >>>> +        if (s->prealloc_mode =3D=3D PRL_PREALLOC_MODE_FALLOCATE) {
> >>>>                ret =3D bdrv_pwrite_zeroes(bs->file, host_off, bytes,=
 0);
> >>>>                if (ret < 0) {
> >>>>                    return ret;
> >>>> @@ -757,13 +760,7 @@ parallels_check_outside_image(BlockDriverState =
*bs, BdrvCheckResult *res,
> >>>>            }
> >>>>        }
> >>>>
> >>>> -    if (high_off =3D=3D 0) {
> >>>> -        res->image_end_offset =3D s->data_end << BDRV_SECTOR_BITS;
> >>>> -    } else {
> >>>> -        res->image_end_offset =3D high_off + s->cluster_size;
> >>>> -        s->data_end =3D res->image_end_offset >> BDRV_SECTOR_BITS;
> >>>> -    }
> >>>> -
> >>>> +    res->image_end_offset =3D parallels_data_end(s);
> >>>>        return 0;
> >>>>    }
> >>>>
> >>>> @@ -806,7 +803,6 @@ parallels_check_leak(BlockDriverState *bs, BdrvC=
heckResult *res,
> >>>>                res->check_errors++;
> >>>>                return ret;
> >>>>            }
> >>>> -        s->data_end =3D res->image_end_offset >> BDRV_SECTOR_BITS;
> >>>>
> >>>>            parallels_free_used_bitmap(bs);
> >>>>            ret =3D parallels_fill_used_bitmap(bs);
> >>>> @@ -1361,8 +1357,7 @@ static int parallels_open(BlockDriverState *bs=
, QDict *options, int flags,
> >>>>        }
> >>>>
> >>>>        s->data_start =3D data_start;
> >>>> -    s->data_end =3D s->data_start;
> >>>> -    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
> >>>> +    if (s->data_start < (s->header_size >> BDRV_SECTOR_BITS)) {
> >>>>            /*
> >>>>             * There is not enough unused space to fit to block align=
 between BAT
> >>>>             * and actual data. We can't avoid read-modify-write...
> >>>> @@ -1403,11 +1398,10 @@ static int parallels_open(BlockDriverState *=
bs, QDict *options, int flags,
> >>>>
> >>>>        for (i =3D 0; i < s->bat_size; i++) {
> >>>>            sector =3D bat2sect(s, i);
> >>>> -        if (sector + s->tracks > s->data_end) {
> >>>> -            s->data_end =3D sector + s->tracks;
> >>>> +        if (sector + s->tracks > file_nb_sectors) {
> >>>> +            need_check =3D true;
> >>>>            }
> >>>>        }
> >>>> -    need_check =3D need_check || s->data_end > file_nb_sectors;
> >>>>
> >>>>        ret =3D parallels_fill_used_bitmap(bs);
> >>>>        if (ret =3D=3D -ENOMEM) {
> >>>> @@ -1461,7 +1455,6 @@ static int parallels_truncate_unused_clusters(=
BlockDriverState *bs)
> >>>>            end_off =3D (end_off + 1) * s->cluster_size;
> >>>>        }
> >>>>        end_off +=3D s->data_start * BDRV_SECTOR_SIZE;
> >>>> -    s->data_end =3D end_off / BDRV_SECTOR_SIZE;
> >>>>        return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_O=
FF, 0, NULL);
> >>>>    }
> >>>>
> >>>> diff --git a/block/parallels.h b/block/parallels.h
> >>>> index 18b4f8068e..a6a048d890 100644
> >>>> --- a/block/parallels.h
> >>>> +++ b/block/parallels.h
> >>>> @@ -79,7 +79,6 @@ typedef struct BDRVParallelsState {
> >>>>        unsigned int bat_size;
> >>>>
> >>>>        int64_t  data_start;
> >>>> -    int64_t  data_end;
> >>>>        uint64_t prealloc_size;
> >>>>        ParallelsPreallocMode prealloc_mode;
> >>>>
> >>>> --
> >>>> 2.34.1
> >>>>
> >>> Is it intended behavior?
> >>>
> >>> Run:
> >>> 1. ./qemu-img create -f parallels $TEST_IMG 1T
> >>> 2. dd if=3D/dev/zero of=3D$TEST_IMG oseek=3D12  bs=3D1M count=3D128 c=
onv=3Dnotrunc
> >>> 3. ./qemu-img check  $TEST_IMG
> >>>          No errors were found on the image.
> >>>          Image end offset: 150994944
> >>>
> >>> Without this patch `qemu-img check` reports:
> >>>          ERROR space leaked at the end of the image 145752064
> >>>
> >>>         139 leaked clusters were found on the image.
> >>>         This means waste of disk space, but no harm to data.
> >>>         Image end offset: 5242880
> >> The original intention is do nothing at this point if an image is open=
ed as
> >> RO. In the next patch parallels_check_leak() was rewritten to detect
> >> unused clusters at the image end.
> >>
> >> But there is a bug: (end_off =3D=3D s->used_bmap_size) case is handled=
 in an
> >> incorrect way. Will fix it, thank you.
> >>> Note: there is another issue caused by previous commits exists.
> >>> g_free asserts from parallels_free_used_bitmap() because of
> >>> s->used_bmap is NULL.
> >> Maybe I don't understand your point, but if you meant that g_free() co=
uld be
> >> called with NULL argument, it's not a problem. GLib Manual says:
> >>
> >>      void g_free (/|gpointer
> >>      <https://www.manpagez.com/html/glib/glib-2.56.0/glib-Basic-Types.=
php#gpointer>
> >>      mem|/);
> >>
> >>      If /|mem|/ is|NULL|
> >>      <https://www.manpagez.com/html/glib/glib-2.56.0/glib-Standard-Mac=
ros.php#NULL:CAPS>
> >>      it simply returns, so there is no need to check /|mem|/ against
> >>      |NULL|
> >>      <https://www.manpagez.com/html/glib/glib-2.56.0/glib-Standard-Mac=
ros.php#NULL:CAPS>
> >>      before calling this function.
> >>
> >>> To reproduce this crash at revision before or without patch 15/19, ru=
n commands:
> >>> 1. ./qemu-img create -f parallels $TEST_IMG 1T
> >>> 2. dd if=3D/dev/zero of=3D$TEST_IMG oseek=3D12  bs=3D1M count=3D128 c=
onv=3Dnotrunc
> >>> 3. ./qemu-img check -r leaks $TEST_IMG
> >> Sorry, but I couldn't reproduce it. Reset to 14/19, made the three ste=
ps
> >> and had such output:
> >>
> >>      $ ./qemu-img create -f parallels $TEST_IMG 1T
> >>      Formatting 'test.img', fmt=3Dparallels size=3D1099511627776
> >>      cluster_size=3D1048576
> >>
> >>      $ dd if=3D/dev/zero of=3D$TEST_IMG seek=3D12  bs=3D1M count=3D128=
 conv=3Dnotrunc
> >>      128+0 records in
> >>      128+0 records out
> >>      134217728 bytes (134 MB, 128 MiB) copied, 0.0797576 s, 1.7 GB/s
> >>
> >>      $ ./qemu-img check -r leaks $TEST_IMG
> >>      Repairing space leaked at the end of the image 141557760
> >>      The following inconsistencies were found and repaired:
> >>
> >>      135 leaked clusters
> >>      0 corruptions
> >>
> >>      Double checking the fixed image now...
> >>      No errors were found on the image.
> >>      Image end offset: 5242880
> > My comment regarding patch 15 is about 'check' operation is not able
> > to detect leaked data anymore.
> > So, after this patch I see:
> >
> > $ ./qemu-img info   leak.bin
> > image: leak.bin
> > file format: parallels
> > virtual size: 1 TiB (1099511627776 bytes)
> > disk size: 145 MiB
> > Child node '/file':
> >      filename: leak.bin
> >      protocol type: file
> >      file length: 146 MiB (153092096 bytes)
> >      disk size: 145 MiB
> >
> > $ ./qemu-img check -r leaks leak.bin
> > No errors were found on the image.
> > Image end offset: 153092096
> >
> > After reverting this patch  'check' reports about:
> > ERROR space leaked at the end of the image 148897792
> >
> > So, after reverting patch 15 I tried to repair such image
> > and got abort trap.
> Yes, I understand this part. OK, I think, I could place 16 patch before
> 15 and
> leaks would handle in the correct way at any point of the patch sequence.
> >
> > I rechecked with downloaded patches, rebuild from scratch and can tell
> > that there is no abort on master branch, but it appears after applying
> > patches[1-9].
> Maybe I do something wrong, but I reset to the top of mainstream, applied
> 1-9 patches, rebuilt QEMU and didn't see any abort.
>
> > Obviously It can be debugged and the reason is that
> > parallels_fill_used_bitmap() returns after
> >
> >   s->used_bmap_size =3D DIV_ROUND_UP(payload_bytes, s->cluster_size);
> >      if (s->used_bmap_size =3D=3D 0) {
> >          return 0;
> >      }
> >
> > Because DIV_ROUND_UP(payload_bytes, s->cluster_size); gives a 0;
> >
> > So subsequent parallels_free_used_bitmap() called from
> > parallels_close() causes an assert.
> >
> > So, the first invocation of parallels_free_used_bitmap is:
> >    * frame #0: 0x0000000100091830 qemu-img`parallels_check_leak
> > [inlined] parallels_free_used_bitmap(bs=3D0x0000000101011600) at
> > parallels.c:263:33 [opt]
> >      frame #1: 0x0000000100091830
> > qemu-img`parallels_check_leak(bs=3D0x0000000101011600,
> > res=3D0x000000016fdff5d8, fix=3DBDRV_FIX_LEAKS, explicit=3Dtrue) at
> > parallels.c:811:9 [opt]
> >      frame #2: 0x0000000100090d80
> > qemu-img`parallels_co_check(bs=3D0x0000000101011600,
> > res=3D0x000000016fdff5d8, fix=3DBDRV_FIX_LEAKS) at parallels.c:1014:15
> > [opt]
> >      frame #3: 0x0000000100014f6c
> > qemu-img`bdrv_co_check_entry(opaque=3D0x000000016fdff560) at
> > block-gen.c:556:14 [opt]
> >
> > And the second generates abort from there:
> >    * frame #0: 0x000000010008fef8 qemu-img`parallels_close [inlined]
> > parallels_free_used_bitmap(bs=3D<unavailable>) at parallels.c:263:33
> In this line we have:
>
>     BDRVParallelsState *s =3D bs->opaque;
>
> So there is only one possibility to abort - incorrect bs. I don't know
> how it
> could be possible.
>
> > [opt]
> >      frame #1: 0x000000010008fef8
> > qemu-img`parallels_close(bs=3D0x0000000101011600) at parallels.c:1501:5
> > [opt]
> >      frame #2: 0x0000000100019d3c qemu-img`bdrv_unref [inlined]
> > bdrv_close(bs=3D0x0000000101011600) at block.c:5164:13 [opt]
> >
> > After the first parallels_free_used_bitmap(), there is an actual image
> > truncation happens, so there is no payload at the moment of the next
> > parallels_fill_used_bitmap(),
> >
> > PS: there are a chances that some patches were not applied clearly,
> > I'll recheck this later.
> I just reset to the mainstream top and apply 1-9 patches:
>
>     $ git reset --hard 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d
>     HEAD is now at 2f3913f4b2 Merge tag 'for_upstream' of
>     https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging
>     $ git am *.eml
>     Applying: parallels: Move inactivation code to a separate function
>     Applying: parallels: Add mark_unused() helper
>     Applying: parallels: Move host clusters allocation to a separate
>     function
>     Applying: parallels: Set data_end value in parallels_check_leak()
>     Applying: parallels: Recreate used bitmap in parallels_check_leak()
>     Applying: parallels: Add a note about used bitmap in
>     parallels_check_duplicate()
>     Applying: parallels: Create used bitmap even if checks needed
>     Applying: parallels: Make mark_used() and mark_unused() global functi=
ons
>     Applying: parallels: Add dirty bitmaps saving
>
> > It would be nice if it was possible to fetch changes from some repo,
> > rather than extracting  it from gmail.
> You can fetch it here (branch "parallels") -
> https://github.com/AlexanderIvanov-Virtuozzo/qemu.git
> >
> > Regards,
> > Mike.
>
> --
> Best regards,
> Alexander Ivanov
>
Thanks for the link. I've fetched your repo and reverted "parallels:
Remove unnecessary data_end field" as it hides reproduction,
because it makes 'check' blind for the case we are discussing.
So the situation is the same:
1. parallels_open calls parallels_fill_used_bitmap(). A this time file
size is 145M (i.e leaked clusters are there) and s->used_bmap_size =3D
139.
2  Then parallels_co_check()->parallels_check_leak () is invoked.
     At the first parallels_check_leak calls
bdrv_co_truncate(offset=3D5242880), that is true as we have only empty
BAT on the image.
     At this step image truncated to 5M i.e. contains only empty BAT.
     So, on line 809 s->data_end =3D 10240 i.e 5M (10240<<9)
      809:         s->data_end =3D res->image_end_offset >> BDRV_SECTOR_BIT=
S;

      811:        parallels_free_used_bitmap(bs);
      812:        ret =3D parallels_fill_used_bitmap(bs);

Line 811 invalidates used_bmap and sets used_bmap_size to 0.
parallels_fill_used_bitmap Invoked on line 812  returns 0, because
payload_bytes =3D 0 (current file size 5M - s->data_start *
BDRV_SECTOR_SIZE ),
and s->used_bmap_size is NOT initialized.

3. parallels_close() invoked to finish work and exit process.
   parallels_close() calls  parallels_free_used_bitmap() unconditionally.

static void parallels_free_used_bitmap(BlockDriverState *bs)
{
    BDRVParallelsState *s =3D bs->opaque;
    s->used_bmap_size =3D 0;
ASSERT IS HERE >>>>  g_free(s->used_bmap);
}

The fix is trivial...

if (s->used_bmap_size) {
   g_free(s->used_bmap);
   s->used_bmap_size =3D 0;
}

PS: I retuned to your HEAD. Killed gdb thus made image marked is
incorrectly closed.
But 'qemu-img check' only removed  incorrectly closed flags and didn't
remove leaked clusters.

Regards,
Mike.

