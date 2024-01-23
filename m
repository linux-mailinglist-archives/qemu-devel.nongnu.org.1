Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2E6838659
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 05:29:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS8Om-0000G9-UU; Mon, 22 Jan 2024 23:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rS8Ok-0000Ft-CL
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 23:28:30 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rS8OX-0003XT-Oq
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 23:28:30 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a308e6824ccso108219066b.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 20:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1705984093; x=1706588893; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=576pgT2LSTQtdUzbDHhkUuX4zWt5sNC2pPK6phsFtLM=;
 b=WsivQjwpF9SKMzhui6/T4NaO01KOmAloPSCwpHl+HpNg4FJY8RnhcmCT8cV3rionPU
 zVhqgCXfby/a08mVwMVAGZV1v12dTXNxdpawh2DSnbud0f+6dSYySDLuI8ELKy5dUmh1
 1MfA4Wd5nL6lh44tOZzmlfk7ZY7dQCFIJKjcX8wFwwJ4wsgIyP6omjkUfaewWOHJSrpf
 9t817r+Q12gBvm5q6axT+kTUdxnUARpU9hEUD838hOx35qzLx6I4kfHKPJ9tsuunMC/c
 8AVr5OYec/ZXf8VkSMUxSoA8ZoQMdWScbinRh26uD67MRGpveBDW2T60BcJlwFPpapDn
 ZT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705984093; x=1706588893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=576pgT2LSTQtdUzbDHhkUuX4zWt5sNC2pPK6phsFtLM=;
 b=IF4pub/snOjwAqywpTAt0mvYy9EQpHkVmeJumNzA9DAp/eZ2avt+PiYSViCnMT4Pib
 SIR1n2lzR+JujT6/WhFtQ9DwLA0Au9ulc9llitY0QwsS4kFqX+vHNGxt/lSfSE8ZuZEi
 z7NJTh/pWGVuk0JKSbTixI6FTvecRf7P34mFK1VSBEDV/ri4R/+aIPhqf0AqmDpUvBVK
 ZN7zT9qL1uAjFkee68vdfdoUUG20m59Mk6eQQFSJeEv4TI8dSI8HdVVv3z/JGrB7xzAN
 JdkZ5Hhn+5RoWhnM5ifd8VNsm6gnAvx073jWROqCBW4ijZsTE1JaTmpq+KObQ6hK33cT
 Vm7g==
X-Gm-Message-State: AOJu0YzIIYLf0mIHFx9dLgJg2XBghDfhnK4FRs9kJLhCkzK0UtJb0AuL
 fHrO71LNZLCafYutgdItaaIfAH9/As6RJ3g3h+hf0l7sYm3un40CV62DckWa//oyPvQnqOwJReb
 naLv2NJUNmqJnLyYScyCMs6LXxj1Y8HbHX2dh4Q==
X-Google-Smtp-Source: AGHT+IGJfIjpsTblrjbwoN/ZE6R5kxoXiNsNzROnnmBX1uHcnM6/+LnkEpqc3MNUCo4PP4wrz+A4oyIWImt1SIRl6AY=
X-Received: by 2002:a17:907:2d0a:b0:a2c:bc3e:1f31 with SMTP id
 gs10-20020a1709072d0a00b00a2cbc3e1f31mr3535376ejc.76.1705984093533; Mon, 22
 Jan 2024 20:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-5-hao.xiang@bytedance.com> <87pm09ennn.fsf@suse.de>
In-Reply-To: <87pm09ennn.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Mon, 22 Jan 2024 20:28:02 -0800
Message-ID: <CAAYibXiD5Ni4Dh8=K-iXAuv9sx_LpxXd8ZkA3XP_dJy+P7J7Sw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 04/20] So we use multifd to transmit
 zero pages.
To: Fabiano Rosas <farosas@suse.de>
Cc: peter.maydell@linaro.org, quintela@redhat.com, peterx@redhat.com, 
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com, qemu-devel@nongnu.org, 
 Leonardo Bras <leobras@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Nov 16, 2023 at 7:14=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > From: Juan Quintela <quintela@redhat.com>
> >
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > Reviewed-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  migration/multifd.c |  7 ++++---
> >  migration/options.c | 13 +++++++------
> >  migration/ram.c     | 45 ++++++++++++++++++++++++++++++++++++++-------
> >  qapi/migration.json |  1 -
> >  4 files changed, 49 insertions(+), 17 deletions(-)
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 1b994790d5..1198ffde9c 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -13,6 +13,7 @@
> >  #include "qemu/osdep.h"
> >  #include "qemu/cutils.h"
> >  #include "qemu/rcu.h"
> > +#include "qemu/cutils.h"
> >  #include "exec/target_page.h"
> >  #include "sysemu/sysemu.h"
> >  #include "exec/ramblock.h"
> > @@ -459,7 +460,6 @@ static int multifd_send_pages(QEMUFile *f)
> >      p->packet_num =3D multifd_send_state->packet_num++;
> >      multifd_send_state->pages =3D p->pages;
> >      p->pages =3D pages;
> > -
> >      qemu_mutex_unlock(&p->mutex);
> >      qemu_sem_post(&p->sem);
> >
> > @@ -684,7 +684,7 @@ static void *multifd_send_thread(void *opaque)
> >      MigrationThread *thread =3D NULL;
> >      Error *local_err =3D NULL;
> >      /* qemu older than 8.2 don't understand zero page on multifd chann=
el */
> > -    bool use_zero_page =3D !migrate_use_main_zero_page();
> > +    bool use_multifd_zero_page =3D !migrate_use_main_zero_page();
> >      int ret =3D 0;
> >      bool use_zero_copy_send =3D migrate_zero_copy_send();
> >
> > @@ -713,6 +713,7 @@ static void *multifd_send_thread(void *opaque)
> >              RAMBlock *rb =3D p->pages->block;
> >              uint64_t packet_num =3D p->packet_num;
> >              uint32_t flags;
> > +
> >              p->normal_num =3D 0;
> >              p->zero_num =3D 0;
> >
> > @@ -724,7 +725,7 @@ static void *multifd_send_thread(void *opaque)
> >
> >              for (int i =3D 0; i < p->pages->num; i++) {
> >                  uint64_t offset =3D p->pages->offset[i];
> > -                if (use_zero_page &&
> > +                if (use_multifd_zero_page &&
>
> We could have a new function in multifd_ops for zero page
> handling. We're already considering an accelerator for the compression
> method in the other series[1] and in this series we're adding an
> accelerator for zero page checking. It's about time we make the
> multifd_ops generic instead of only compression/no compression.

Sorry I overlooked this email earlier.
I will extend the multifd_ops interface and add a new API for zero
page checking.

>
> 1- [PATCH v2 0/4] Live Migration Acceleration with IAA Compression
> https://lore.kernel.org/r/20231109154638.488213-1-yuan1.liu@intel.com
>
> >                      buffer_is_zero(rb->host + offset, p->page_size)) {
> >                      p->zero[p->zero_num] =3D offset;
> >                      p->zero_num++;
> > diff --git a/migration/options.c b/migration/options.c
> > index 00c0c4a0d6..97d121d4d7 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -195,6 +195,7 @@ Property migration_properties[] =3D {
> >      DEFINE_PROP_MIG_CAP("x-block", MIGRATION_CAPABILITY_BLOCK),
> >      DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_P=
ATH),
> >      DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_MULTIFD),
> > +    DEFINE_PROP_MIG_CAP("x-main-zero-page", MIGRATION_CAPABILITY_MAIN_=
ZERO_PAGE),
> >      DEFINE_PROP_MIG_CAP("x-background-snapshot",
> >              MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT),
> >  #ifdef CONFIG_LINUX
> > @@ -288,13 +289,9 @@ bool migrate_multifd(void)
> >
> >  bool migrate_use_main_zero_page(void)
> >  {
> > -    //MigrationState *s;
> > -
> > -    //s =3D migrate_get_current();
> > +    MigrationState *s =3D migrate_get_current();
> >
> > -    // We will enable this when we add the right code.
> > -    // return s->enabled_capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_P=
AGE];
> > -    return true;
> > +    return s->capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE];
>
> What happens if we disable main-zero-page while multifd is not enabled?

In ram.c
...
if (migrate_multifd() && !migrate_use_main_zero_page()) {
migration_ops->ram_save_target_page =3D ram_save_target_page_multifd;
} else {
migration_ops->ram_save_target_page =3D ram_save_target_page_legacy;
}
...

So if main-zero-page is disabled and multifd is also disabled, it will
go with the "else" path, which is the legacy path
ram_save_target_page_legacy() and do zero page checking from the main
thread.

>
> >  }
> >
> >  bool migrate_pause_before_switchover(void)
> > @@ -457,6 +454,7 @@ INITIALIZE_MIGRATE_CAPS_SET(check_caps_background_s=
napshot,
> >      MIGRATION_CAPABILITY_LATE_BLOCK_ACTIVATE,
> >      MIGRATION_CAPABILITY_RETURN_PATH,
> >      MIGRATION_CAPABILITY_MULTIFD,
> > +    MIGRATION_CAPABILITY_MAIN_ZERO_PAGE,
> >      MIGRATION_CAPABILITY_PAUSE_BEFORE_SWITCHOVER,
> >      MIGRATION_CAPABILITY_AUTO_CONVERGE,
> >      MIGRATION_CAPABILITY_RELEASE_RAM,
> > @@ -534,6 +532,9 @@ bool migrate_caps_check(bool *old_caps, bool *new_c=
aps, Error **errp)
> >              error_setg(errp, "Postcopy is not yet compatible with mult=
ifd");
> >              return false;
> >          }
> > +        if (new_caps[MIGRATION_CAPABILITY_MAIN_ZERO_PAGE]) {
> > +            error_setg(errp, "Postcopy is not yet compatible with main=
 zero copy");
> > +        }
>
> Won't this will breaks compatibility for postcopy? A command that used
> to work now will have to disable main-zero-page first.

main-zero-page is disabled by default.

>
> >      }
> >
> >      if (new_caps[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT]) {
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 8c7886ab79..f7a42feff2 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -2059,17 +2059,42 @@ static int ram_save_target_page_legacy(RAMState=
 *rs, PageSearchStatus *pss)
> >      if (save_zero_page(rs, pss, offset)) {
> >          return 1;
> >      }
> > -
> >      /*
> > -     * Do not use multifd in postcopy as one whole host page should be
> > -     * placed.  Meanwhile postcopy requires atomic update of pages, so=
 even
> > -     * if host page size =3D=3D guest page size the dest guest during =
run may
> > -     * still see partially copied pages which is data corruption.
> > +     * Do not use multifd for:
> > +     * 1. Compression as the first page in the new block should be pos=
ted out
> > +     *    before sending the compressed page
> > +     * 2. In postcopy as one whole host page should be placed
> >       */
> > -    if (migrate_multifd() && !migration_in_postcopy()) {
> > +    if (!migrate_compress() && migrate_multifd() && !migration_in_post=
copy()) {
> > +        return ram_save_multifd_page(pss->pss_channel, block, offset);
> > +    }
>
> This could go into ram_save_target_page_multifd like so:
>
> if (!migrate_compress() && !migration_in_postcopy() && !migration_main_ze=
ro_page()) {
>     return ram_save_multifd_page(pss->pss_channel, block, offset);
> } else {
>   return ram_save_target_page_legacy();
> }
>
> > +
> > +    return ram_save_page(rs, pss);
> > +}
> > +
> > +/**
> > + * ram_save_target_page_multifd: save one target page
> > + *
> > + * Returns the number of pages written
> > + *
> > + * @rs: current RAM state
> > + * @pss: data about the page we want to send
> > + */
> > +static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus=
 *pss)
> > +{
> > +    RAMBlock *block =3D pss->block;
> > +    ram_addr_t offset =3D ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
> > +    int res;
> > +
> > +    if (!migration_in_postcopy()) {
> >          return ram_save_multifd_page(pss->pss_channel, block, offset);
> >      }
> >
> > +    res =3D save_zero_page(rs, pss, offset);
> > +    if (res > 0) {
> > +        return res;
> > +    }
> > +
> >      return ram_save_page(rs, pss);
> >  }
> >
> > @@ -2982,9 +3007,15 @@ static int ram_save_setup(QEMUFile *f, void *opa=
que)
> >      }
> >
> >      migration_ops =3D g_malloc0(sizeof(MigrationOps));
> > -    migration_ops->ram_save_target_page =3D ram_save_target_page_legac=
y;
> > +
> > +    if (migrate_multifd() && !migrate_use_main_zero_page()) {
> > +        migration_ops->ram_save_target_page =3D ram_save_target_page_m=
ultifd;
> > +    } else {
> > +        migration_ops->ram_save_target_page =3D ram_save_target_page_l=
egacy;
> > +    }
>
> This should not check main-zero-page. Just have multifd vs. legacy and
> have the multifd function defer to _legacy if main-zero-page or
> in_postcopy.

I noticed that ram_save_target_page_legacy and
ram_save_target_page_multifd have a lot of overlap and are quite
confusing. I can refactor this path and take-in your comments here.

1) Remove ram_save_multifd_page() call from
ram_save_target_page_legacy(). ram_save_multifd_page() will only be
called in ram_save_target_page_multifd().
2) Remove save_zero_page() and ram_save_page() from
ram_save_target_page_multifd().
3) Postcopy will always go with the ram_save_target_page_legacy() path.
4) Legacy compression will always go with the
ram_save_target_page_legacy() path.
5) Call ram_save_target_page_legacy() from within
ram_save_target_page_multifd() if postcopy or legacy compression.

>
> >
> >      qemu_mutex_unlock_iothread();
> > +
> >      ret =3D multifd_send_sync_main(f);
> >      qemu_mutex_lock_iothread();
> >      if (ret < 0) {
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 09e4393591..9783289bfc 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -531,7 +531,6 @@
> >  #     and can result in more stable read performance.  Requires KVM
> >  #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
> >  #
> > -#
> >  # @main-zero-page: If enabled, the detection of zero pages will be
> >  #                  done on the main thread.  Otherwise it is done on
> >  #                  the multifd threads.

