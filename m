Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE4F7BC719
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 13:23:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp5Nx-0006rs-OR; Sat, 07 Oct 2023 07:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qp5Nv-0006rP-Br; Sat, 07 Oct 2023 07:22:15 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.maslenkin@gmail.com>)
 id 1qp5Nt-0003R3-6e; Sat, 07 Oct 2023 07:22:15 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d818d65f23cso3238720276.3; 
 Sat, 07 Oct 2023 04:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696677731; x=1697282531; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GuDohRkVG/3P/nHJlBzg+BMiPq2a9sUoKkuYA9jtL3I=;
 b=OAlpBq6YxYfF5iwUNJYuKy4Y/6N3V4KEJYHH7CvWd8W2nibJXiVGE4p3x0GyiTruLK
 3dwF31yFWOXMrYvNfTEPUUsRM55B1F8CS/D2/ji3BGRguiqOg4cVHW16CnNGOYcL3RgV
 JkLbMtMBrzlZcgJbU85p93QR/B1AB+2s2SsU7CX3w9Wsi9m0fNilMlUe5xMJBR8Eaamv
 uSiIfR3w6ZjUNYjudbrQbSJcP5TFK1eZDHpoPq9DsbWrWrsMEQ1Xyb/HKyMuzw0UthH6
 Efq+o3XwNAVAEXjrOdC5JK9L/mfgBNCLIkWzcl1rgr1kiRPL2sc5wJ6owre2XHwYf0mG
 eqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696677731; x=1697282531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GuDohRkVG/3P/nHJlBzg+BMiPq2a9sUoKkuYA9jtL3I=;
 b=Bn73ZwFEq+hrosmvw00wBLEoQTZ/tjQ392K3iTpnYXgARUyNIXdE1XBcEc0KrRDeUT
 zy6NFT+whBY7tgRVcpEWs6hKmRiamrBm92yXq7voKUyYdUQ9bBIIptox9y4WwiBnAF2L
 H+injdgP8S4ywLSE9jMNM3AaCJ1VjlucJxI7VPeBMtaFfs3ghrCKtlqZsTqz7n5pf317
 GXKsrvdvemaBkJ9vV0TSv+1Znn5A+UoDIWL9YrAvEOTKsyRVLkIv9KgTdzDyCtyGHQlb
 sx/IDRJJTz53a6vFaFI148QTCvj/YL7n3ZdHrqf/Oo3RckTHS3S2RTV0ZydbbOx2JBy4
 16RA==
X-Gm-Message-State: AOJu0YwmoBk6Yu4v7rEr2xGOI4osJNNSPhsXpS14x49ymTXX2dcWLI2m
 5ecFy7GvZ7sW2Ft9HVteB6ow0AONjWubUFm4e60=
X-Google-Smtp-Source: AGHT+IE2iqDvcWRQ5zcTyh+vfw2rsD0bjGzsGuP8pzooeEvluaK5FsUlxz5ZXv6BUBqgdNa4+oGc9VWHHsvE30J1p8Q=
X-Received: by 2002:a25:238e:0:b0:d81:b9f0:455e with SMTP id
 j136-20020a25238e000000b00d81b9f0455emr10094053ybj.51.1696677731500; Sat, 07
 Oct 2023 04:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
 <20231002085738.369684-16-alexander.ivanov@virtuozzo.com>
 <CAL77WPCgbWch6TqjBucJJ_MfG2nOFtoA=oT9EbAE+V_kDTfCgA@mail.gmail.com>
 <f050b078-1f8d-41d1-a469-4f92d4248580@virtuozzo.com>
In-Reply-To: <f050b078-1f8d-41d1-a469-4f92d4248580@virtuozzo.com>
From: Mike Maslenkin <mike.maslenkin@gmail.com>
Date: Sat, 7 Oct 2023 14:21:35 +0300
Message-ID: <CAL77WPB37-y4GeWXgy2xQ93_riZkR0q50Gs0apqvFoC6kZwDZg@mail.gmail.com>
Subject: Re: [PATCH 15/19] parallels: Remove unnecessary data_end field
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com, 
 stefanha@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com, 
 hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=mike.maslenkin@gmail.com; helo=mail-yb1-xb35.google.com
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

On Sat, Oct 7, 2023 at 1:18=E2=80=AFPM Alexander Ivanov
<alexander.ivanov@virtuozzo.com> wrote:
>
>
>
> On 10/6/23 21:43, Mike Maslenkin wrote:
> > On Mon, Oct 2, 2023 at 12:01=E2=80=AFPM Alexander Ivanov
> > <alexander.ivanov@virtuozzo.com> wrote:
> >> Since we have used bitmap, field data_end in BDRVParallelsState is
> >> redundant and can be removed.
> >>
> >> Add parallels_data_end() helper and remove data_end handling.
> >>
> >> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> >> ---
> >>   block/parallels.c | 33 +++++++++++++--------------------
> >>   block/parallels.h |  1 -
> >>   2 files changed, 13 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/block/parallels.c b/block/parallels.c
> >> index 48ea5b3f03..80a7171b84 100644
> >> --- a/block/parallels.c
> >> +++ b/block/parallels.c
> >> @@ -265,6 +265,13 @@ static void parallels_free_used_bitmap(BlockDrive=
rState *bs)
> >>       g_free(s->used_bmap);
> >>   }
> >>
> >> +static int64_t parallels_data_end(BDRVParallelsState *s)
> >> +{
> >> +    int64_t data_end =3D s->data_start * BDRV_SECTOR_SIZE;
> >> +    data_end +=3D s->used_bmap_size * s->cluster_size;
> >> +    return data_end;
> >> +}
> >> +
> >>   int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
> >>                                            int64_t *clusters)
> >>   {
> >> @@ -275,7 +282,7 @@ int64_t parallels_allocate_host_clusters(BlockDriv=
erState *bs,
> >>
> >>       first_free =3D find_first_zero_bit(s->used_bmap, s->used_bmap_si=
ze);
> >>       if (first_free =3D=3D s->used_bmap_size) {
> >> -        host_off =3D s->data_end * BDRV_SECTOR_SIZE;
> >> +        host_off =3D parallels_data_end(s);
> >>           prealloc_clusters =3D *clusters + s->prealloc_size / s->trac=
ks;
> >>           bytes =3D prealloc_clusters * s->cluster_size;
> >>
> >> @@ -297,9 +304,6 @@ int64_t parallels_allocate_host_clusters(BlockDriv=
erState *bs,
> >>           s->used_bmap =3D bitmap_zero_extend(s->used_bmap, s->used_bm=
ap_size,
> >>                                             new_usedsize);
> >>           s->used_bmap_size =3D new_usedsize;
> >> -        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
> >> -            s->data_end =3D (host_off + bytes) / BDRV_SECTOR_SIZE;
> >> -        }
> >>       } else {
> >>           next_used =3D find_next_bit(s->used_bmap, s->used_bmap_size,=
 first_free);
> >>
> >> @@ -315,8 +319,7 @@ int64_t parallels_allocate_host_clusters(BlockDriv=
erState *bs,
> >>            * branch. In the other case we are likely re-using hole. Pr=
eallocate
> >>            * the space if required by the prealloc_mode.
> >>            */
> >> -        if (s->prealloc_mode =3D=3D PRL_PREALLOC_MODE_FALLOCATE &&
> >> -                host_off < s->data_end * BDRV_SECTOR_SIZE) {
> >> +        if (s->prealloc_mode =3D=3D PRL_PREALLOC_MODE_FALLOCATE) {
> >>               ret =3D bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0)=
;
> >>               if (ret < 0) {
> >>                   return ret;
> >> @@ -757,13 +760,7 @@ parallels_check_outside_image(BlockDriverState *b=
s, BdrvCheckResult *res,
> >>           }
> >>       }
> >>
> >> -    if (high_off =3D=3D 0) {
> >> -        res->image_end_offset =3D s->data_end << BDRV_SECTOR_BITS;
> >> -    } else {
> >> -        res->image_end_offset =3D high_off + s->cluster_size;
> >> -        s->data_end =3D res->image_end_offset >> BDRV_SECTOR_BITS;
> >> -    }
> >> -
> >> +    res->image_end_offset =3D parallels_data_end(s);
> >>       return 0;
> >>   }
> >>
> >> @@ -806,7 +803,6 @@ parallels_check_leak(BlockDriverState *bs, BdrvChe=
ckResult *res,
> >>               res->check_errors++;
> >>               return ret;
> >>           }
> >> -        s->data_end =3D res->image_end_offset >> BDRV_SECTOR_BITS;
> >>
> >>           parallels_free_used_bitmap(bs);
> >>           ret =3D parallels_fill_used_bitmap(bs);
> >> @@ -1361,8 +1357,7 @@ static int parallels_open(BlockDriverState *bs, =
QDict *options, int flags,
> >>       }
> >>
> >>       s->data_start =3D data_start;
> >> -    s->data_end =3D s->data_start;
> >> -    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
> >> +    if (s->data_start < (s->header_size >> BDRV_SECTOR_BITS)) {
> >>           /*
> >>            * There is not enough unused space to fit to block align be=
tween BAT
> >>            * and actual data. We can't avoid read-modify-write...
> >> @@ -1403,11 +1398,10 @@ static int parallels_open(BlockDriverState *bs=
, QDict *options, int flags,
> >>
> >>       for (i =3D 0; i < s->bat_size; i++) {
> >>           sector =3D bat2sect(s, i);
> >> -        if (sector + s->tracks > s->data_end) {
> >> -            s->data_end =3D sector + s->tracks;
> >> +        if (sector + s->tracks > file_nb_sectors) {
> >> +            need_check =3D true;
> >>           }
> >>       }
> >> -    need_check =3D need_check || s->data_end > file_nb_sectors;
> >>
> >>       ret =3D parallels_fill_used_bitmap(bs);
> >>       if (ret =3D=3D -ENOMEM) {
> >> @@ -1461,7 +1455,6 @@ static int parallels_truncate_unused_clusters(Bl=
ockDriverState *bs)
> >>           end_off =3D (end_off + 1) * s->cluster_size;
> >>       }
> >>       end_off +=3D s->data_start * BDRV_SECTOR_SIZE;
> >> -    s->data_end =3D end_off / BDRV_SECTOR_SIZE;
> >>       return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF,=
 0, NULL);
> >>   }
> >>
> >> diff --git a/block/parallels.h b/block/parallels.h
> >> index 18b4f8068e..a6a048d890 100644
> >> --- a/block/parallels.h
> >> +++ b/block/parallels.h
> >> @@ -79,7 +79,6 @@ typedef struct BDRVParallelsState {
> >>       unsigned int bat_size;
> >>
> >>       int64_t  data_start;
> >> -    int64_t  data_end;
> >>       uint64_t prealloc_size;
> >>       ParallelsPreallocMode prealloc_mode;
> >>
> >> --
> >> 2.34.1
> >>
> > Is it intended behavior?
> >
> > Run:
> > 1. ./qemu-img create -f parallels $TEST_IMG 1T
> > 2. dd if=3D/dev/zero of=3D$TEST_IMG oseek=3D12  bs=3D1M count=3D128 con=
v=3Dnotrunc
> > 3. ./qemu-img check  $TEST_IMG
> >         No errors were found on the image.
> >         Image end offset: 150994944
> >
> > Without this patch `qemu-img check` reports:
> >         ERROR space leaked at the end of the image 145752064
> >
> >        139 leaked clusters were found on the image.
> >        This means waste of disk space, but no harm to data.
> >        Image end offset: 5242880
> The original intention is do nothing at this point if an image is opened =
as
> RO. In the next patch parallels_check_leak() was rewritten to detect
> unused clusters at the image end.
>
> But there is a bug: (end_off =3D=3D s->used_bmap_size) case is handled in=
 an
> incorrect way. Will fix it, thank you.
> >
> > Note: there is another issue caused by previous commits exists.
> > g_free asserts from parallels_free_used_bitmap() because of
> > s->used_bmap is NULL.
> Maybe I don't understand your point, but if you meant that g_free() could=
 be
> called with NULL argument, it's not a problem. GLib Manual says:
>
>     void g_free (/|gpointer
>     <https://www.manpagez.com/html/glib/glib-2.56.0/glib-Basic-Types.php#=
gpointer>
>     mem|/);
>
>     If /|mem|/ is |NULL|
>     <https://www.manpagez.com/html/glib/glib-2.56.0/glib-Standard-Macros.=
php#NULL:CAPS>
>     it simply returns, so there is no need to check /|mem|/ against
>     |NULL|
>     <https://www.manpagez.com/html/glib/glib-2.56.0/glib-Standard-Macros.=
php#NULL:CAPS>
>     before calling this function.
>
> > To reproduce this crash at revision before or without patch 15/19, run =
commands:
> > 1. ./qemu-img create -f parallels $TEST_IMG 1T
> > 2. dd if=3D/dev/zero of=3D$TEST_IMG oseek=3D12  bs=3D1M count=3D128 con=
v=3Dnotrunc
> > 3. ./qemu-img check -r leaks $TEST_IMG
> Sorry, but I couldn't reproduce it. Reset to 14/19, made the three steps
> and had such output:
>
>     $ ./qemu-img create -f parallels $TEST_IMG 1T
>     Formatting 'test.img', fmt=3Dparallels size=3D1099511627776
>     cluster_size=3D1048576
>
>     $ dd if=3D/dev/zero of=3D$TEST_IMG seek=3D12  bs=3D1M count=3D128 con=
v=3Dnotrunc
>     128+0 records in
>     128+0 records out
>     134217728 bytes (134 MB, 128 MiB) copied, 0.0797576 s, 1.7 GB/s
>
>     $ ./qemu-img check -r leaks $TEST_IMG
>     Repairing space leaked at the end of the image 141557760
>     The following inconsistencies were found and repaired:
>
>     135 leaked clusters
>     0 corruptions
>
>     Double checking the fixed image now...
>     No errors were found on the image.
>     Image end offset: 5242880

My comment regarding patch 15 is about 'check' operation is not able
to detect leaked data anymore.
So, after this patch I see:

$ ./qemu-img info   leak.bin
image: leak.bin
file format: parallels
virtual size: 1 TiB (1099511627776 bytes)
disk size: 145 MiB
Child node '/file':
    filename: leak.bin
    protocol type: file
    file length: 146 MiB (153092096 bytes)
    disk size: 145 MiB

$ ./qemu-img check -r leaks leak.bin
No errors were found on the image.
Image end offset: 153092096

After reverting this patch  'check' reports about:
ERROR space leaked at the end of the image 148897792

So, after reverting patch 15 I tried to repair such image
and got abort trap.

I rechecked with downloaded patches, rebuild from scratch and can tell
that there is no abort on master branch, but it appears after applying
patches[1-9].
Obviously It can be debugged and the reason is that
parallels_fill_used_bitmap() returns after

 s->used_bmap_size =3D DIV_ROUND_UP(payload_bytes, s->cluster_size);
    if (s->used_bmap_size =3D=3D 0) {
        return 0;
    }

Because DIV_ROUND_UP(payload_bytes, s->cluster_size); gives a 0;

So subsequent parallels_free_used_bitmap() called from
parallels_close() causes an assert.

So, the first invocation of parallels_free_used_bitmap is:
  * frame #0: 0x0000000100091830 qemu-img`parallels_check_leak
[inlined] parallels_free_used_bitmap(bs=3D0x0000000101011600) at
parallels.c:263:33 [opt]
    frame #1: 0x0000000100091830
qemu-img`parallels_check_leak(bs=3D0x0000000101011600,
res=3D0x000000016fdff5d8, fix=3DBDRV_FIX_LEAKS, explicit=3Dtrue) at
parallels.c:811:9 [opt]
    frame #2: 0x0000000100090d80
qemu-img`parallels_co_check(bs=3D0x0000000101011600,
res=3D0x000000016fdff5d8, fix=3DBDRV_FIX_LEAKS) at parallels.c:1014:15
[opt]
    frame #3: 0x0000000100014f6c
qemu-img`bdrv_co_check_entry(opaque=3D0x000000016fdff560) at
block-gen.c:556:14 [opt]

And the second generates abort from there:
  * frame #0: 0x000000010008fef8 qemu-img`parallels_close [inlined]
parallels_free_used_bitmap(bs=3D<unavailable>) at parallels.c:263:33
[opt]
    frame #1: 0x000000010008fef8
qemu-img`parallels_close(bs=3D0x0000000101011600) at parallels.c:1501:5
[opt]
    frame #2: 0x0000000100019d3c qemu-img`bdrv_unref [inlined]
bdrv_close(bs=3D0x0000000101011600) at block.c:5164:13 [opt]

After the first parallels_free_used_bitmap(), there is an actual image
truncation happens, so there is no payload at the moment of the next
parallels_fill_used_bitmap(),

PS: there are a chances that some patches were not applied clearly,
I'll recheck this later.
It would be nice if it was possible to fetch changes from some repo,
rather than extracting  it from gmail.

Regards,
Mike.

