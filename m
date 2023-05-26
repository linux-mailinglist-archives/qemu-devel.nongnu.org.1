Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDFB712CDC
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 20:52:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2cWu-00067m-OE; Fri, 26 May 2023 14:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1q2cWs-00066u-Th
 for qemu-devel@nongnu.org; Fri, 26 May 2023 14:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1q2cWp-0007DQ-Rn
 for qemu-devel@nongnu.org; Fri, 26 May 2023 14:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685127066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ruqHerJBc+Zz5dbS8OoBa37ROvFT/UJizITpia+7IcE=;
 b=crhX0b0EMRFZX4uzjZuq2PDlPKJmd+SdoFx7jpicR7cO/+qSRL/XTix2EeI7aTv4UGgkfI
 RGzMpBVnzKVhAVlQZE4mu3OurKAAlgythd+9x8THOLjHi6HfIO4SLL+Rb3Gox+dkErcyBz
 eIfiZWqned/MnVH5SgWIT4uBTFvOpGw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-tVHRsGuDNga1-Ci-0wihxQ-1; Fri, 26 May 2023 14:51:04 -0400
X-MC-Unique: tVHRsGuDNga1-Ci-0wihxQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f6aaa6df23so7148911cf.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 11:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685127064; x=1687719064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ruqHerJBc+Zz5dbS8OoBa37ROvFT/UJizITpia+7IcE=;
 b=erG/8nXeT21+D56QMOgox/+xFRHU1QKHGKH9iL83K+7g+UL1ksxGZj+5w5XZFUcGDI
 VMlzz9oEsbePFi6NLZipVK+W3cPay/rHA8SJS6xp4ZUl3z+Dbrmh63XZNUEEYczr06kn
 wN3f3+uCKrmZTt14vEwpaDchRHPbnJh/wMdo5+gwHr5BfJ8oPWWxcbx1N7sK7jRaWBBw
 msCZccNg5Cu5w1jMZWMVyijbWo75WvFFjuB56rit2Xxb4bHndP30cYIj856LYUUgGeyi
 NB00qL6KY1jIqz2Nd5I8AyRhAAkNnYfPA7uQAUf/OCX3QEqImwGJtX677zNF9Ca3HcJj
 hEbw==
X-Gm-Message-State: AC+VfDzhgf4n9Ic9DscRkPbHzxN5VXjdHCqzTapxjQPdWRNo1xEeHRii
 +jbSAc4Nk7YrkvqRO4Vuj23YyvrLvb9VZXoOPOCMYk1pUVCUgtt4Lp8IDs+rnkhx0IHtEnk8M4w
 SSP+2QdW2zlQzUHwEEsqLgHYehnpb5KU=
X-Received: by 2002:ac8:7d51:0:b0:3f5:2341:5435 with SMTP id
 h17-20020ac87d51000000b003f523415435mr2937834qtb.61.1685127064139; 
 Fri, 26 May 2023 11:51:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6tfmq4XfYomB9rlhdQZq7KNA2cSJw4WHGm3kqJaJzKpLaSTsve6+buOR/l0Q5OPBfgPbpMKdFHBAUSkT2qzwE=
X-Received: by 2002:ac8:7d51:0:b0:3f5:2341:5435 with SMTP id
 h17-20020ac87d51000000b003f523415435mr2937818qtb.61.1685127063887; Fri, 26
 May 2023 11:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-3-quintela@redhat.com>
 <1e3a3735a5ba81abb562e8f6c21ab33f38992af5.camel@redhat.com>
 <87a5xr4iy8.fsf@secure.mitica>
In-Reply-To: <87a5xr4iy8.fsf@secure.mitica>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Fri, 26 May 2023 15:50:52 -0300
Message-ID: <CAJ6HWG7N_YGNxU4dd4DMumFjqWWhQRqP=RngkAUYQ52E-29G5g@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] migration: Correct transferred bytes value
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Greg Kurz <groug@kaod.org>, 
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, 
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, 
 David Hildenbrand <david@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, qemu-block@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lsoaresp@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, May 26, 2023 at 5:04=E2=80=AFAM Juan Quintela <quintela@redhat.com>=
 wrote:
>
> Leonardo Br=C3=A1s <leobras@redhat.com> wrote:
> > On Mon, 2023-05-15 at 21:56 +0200, Juan Quintela wrote:
> >> We forget several places to add to trasferred amount of data.  With
> >> this fixes I get:
> >>
> >>    qemu_file_transferred() + multifd_bytes =3D=3D transferred
> >>
> >> The only place whrer this is not true is during devices sending.  But
> >> going all through the full tree searching for devices that use
> >> QEMUFile directly is a bit too much.
> >>
> >> Multifd, precopy and xbzrle work as expected. Postocpy still misses 35
> >> bytes, but searching for them is getting complicated, so I stop here.
> >>
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  migration/ram.c       | 14 ++++++++++++++
> >>  migration/savevm.c    | 19 +++++++++++++++++--
> >>  migration/vmstate.c   |  3 +++
> >>  migration/meson.build |  2 +-
> >>  4 files changed, 35 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index f69d8d42b0..fd5a8db0f8 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -337,6 +337,7 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
> >>
> >>      g_free(le_bitmap);
> >>
> >> +    stat64_add(&mig_stats.transferred, 8 + size + 8);
> >>      if (qemu_file_get_error(file)) {
> >>          return qemu_file_get_error(file);
> >>      }
> >> @@ -1392,6 +1393,7 @@ static int find_dirty_block(RAMState *rs, PageSe=
archStatus *pss)
> >>                      return ret;
> >>                  }
> >>                  qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> >> +                stat64_add(&mig_stats.transferred, 8);
> >>                  qemu_fflush(f);
> >>              }
> >>              /*
> >> @@ -3020,6 +3022,7 @@ static int ram_save_setup(QEMUFile *f, void *opa=
que)
> >>      RAMState **rsp =3D opaque;
> >>      RAMBlock *block;
> >>      int ret;
> >> +    size_t size =3D 0;
> >>
> >>      if (compress_threads_save_setup()) {
> >>          return -1;
> >> @@ -3038,16 +3041,20 @@ static int ram_save_setup(QEMUFile *f, void *o=
paque)
> >>          qemu_put_be64(f, ram_bytes_total_with_ignored()
> >>                           | RAM_SAVE_FLAG_MEM_SIZE);
> >>
> >> +        size +=3D 8;
> >>          RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >>              qemu_put_byte(f, strlen(block->idstr));
> >>              qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block-=
>idstr));
> >>              qemu_put_be64(f, block->used_length);
> >> +            size +=3D 1 + strlen(block->idstr) + 8;
> >
> > I was thinking some of them would look better with sizeof()s instead of=
 given
> > literal number, such as:
> >
> > size +=3D sizeof(Byte) + strlen(block->idstr) + sizeof(block->used_leng=
th);
> >
> > Maybe too much?
>
> I dropped this patch for two reasons:
>
> - reviewers gave me a bad time with it O:-)
> - it was there only so if anyone was meassuring that new counters are
>   the same that old counters.
>
> But as I have already checked that, we don't need it.
>
> I drop it on the next round that I send.
> > Maybe, it would be nice to have qemu_put_* to return the value, and in =
this
> > case:
> >
> > size +=3D qemu_put_be64(...)
> >
> > What do you think?
>
> Even more important than that is to return an error value, but that
> is a very long project.
>
> See on my next series that qemu_fflush() return errors, so code gets
> simplifed:
>
> qemu_fflush(file);
> if (qemu_file_get_error(file)) {
>     handle error;
> }
>
> to:
>
> qemu_fflush(file);
> if (qemu_file_get_error(file)) {
>     handle error;
> }
>

They look the same to me, what changed?

> We need to do basically all qemu_put_*() and qemu_get_*() functions, but
> it is a step on the right direction.
>
> Later, Juan.
>


