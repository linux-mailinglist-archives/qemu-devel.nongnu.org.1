Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C088A7490F8
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 00:25:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHAvb-0000FP-HN; Wed, 05 Jul 2023 18:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHAvZ-0000FG-P3
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 18:24:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHAvY-0001H0-4d
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 18:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688595886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vm0GPZT3hBIqPlnZg0kB/M09MCZt7tCXc0SNHGO4cVQ=;
 b=cCMrlgKXNS4sqhbc535ynpU/mDuZd5oTOoRfrRNqhmd1ROCQ290T3AvzJNhudiMTO4sbu2
 wPU0QdZnn/RfEm83nAVBbHBop3ZJEfiv93hGyM5CLcvA5YG2Y/CFjXs+u25ViKTx7cYFX/
 QaRmY/xOBKrzVGy/DmgnFhivxvNWWRY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-b3rAM8u8O5qM6TRdyXKnKA-1; Wed, 05 Jul 2023 18:24:45 -0400
X-MC-Unique: b3rAM8u8O5qM6TRdyXKnKA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-635eb5b04e1so377276d6.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 15:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688595884; x=1689200684;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vm0GPZT3hBIqPlnZg0kB/M09MCZt7tCXc0SNHGO4cVQ=;
 b=eS2pgDZGnCzE/0y57rZ5EhQU/r8Y9NxfBeeev1289hTBZN/8M8/4Cx1lKkwmONmq2s
 j/j//Zk8VPU4Fkz29+aqQau7tZHGKU/DVcJ2AMZFAOzGukP6eK0BNliMYjna2GJyS7ym
 3yPcwUHaIdOjJB0Yc8XzsaFPSZZK0ojC/yx7dwNUDwNRPJubElZOKra/RAqJdo5qS6Rp
 xt1/MK9Q5Ac5Jlbc4KRVSuAppOohgzTVablRy/Wpvw77Ou/FdwZH+xB61fdnb6G6evty
 5POzU6rOdXKpZvZjevHMBNXEQJY7MNEEGLZXKxna/0wMMt/GM94VZM0h5Lz3t2qTAHVr
 Y7Bw==
X-Gm-Message-State: ABy/qLaHfwRX+Sevv1HKL67DyzzGk5aMzRu5F5EKbUHMeLYvQgu+6c6L
 vw/Fn05t9G77cx+argWwWjpt1FtwI6hFpYoFCpx5sgrY17ntqeOcAqgq4nMIptbBXWyZSoatWCb
 MPfx68SCyFoNLed4=
X-Received: by 2002:a0c:fac2:0:b0:635:da19:a680 with SMTP id
 p2-20020a0cfac2000000b00635da19a680mr18180679qvo.2.1688595884737; 
 Wed, 05 Jul 2023 15:24:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGGapIUabM35gJ4BVECS0v3KvcRTo32sdpCimnM8tP3sajyYquMAKVi7lXD9T+cmLsJUSk4NA==
X-Received: by 2002:a0c:fac2:0:b0:635:da19:a680 with SMTP id
 p2-20020a0cfac2000000b00635da19a680mr18180663qvo.2.1688595884477; 
 Wed, 05 Jul 2023 15:24:44 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z4-20020a0cf244000000b0063762ab2f90sm7356qvl.83.2023.07.05.15.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 15:24:44 -0700 (PDT)
Date: Wed, 5 Jul 2023 18:24:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v2 6/7] qemufile: Always return a verbose error
Message-ID: <ZKXtqxmCp2cnHf8h@x1n>
References: <20230705163502.331007-1-peterx@redhat.com>
 <20230705163502.331007-7-peterx@redhat.com>
 <87bkgq3tya.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bkgq3tya.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jul 05, 2023 at 06:54:37PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > There're a lot of cases where we only have an errno set in last_error but
> > without a detailed error description.  When this happens, try to generate
> > an error contains the errno as a descriptive error.
> >
> > This will be helpful in cases where one relies on the Error*.  E.g.,
> > migration state only caches Error* in MigrationState.error.  With this,
> > we'll display correct error messages in e.g. query-migrate when the error
> > was only set by qemu_file_set_error().
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/qemu-file.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> > index acc282654a..419b4092e7 100644
> > --- a/migration/qemu-file.c
> > +++ b/migration/qemu-file.c
> > @@ -156,15 +156,24 @@ void qemu_file_set_hooks(QEMUFile *f, const QEMUFileHooks *hooks)
> >   *
> >   * Return negative error value if there has been an error on previous
> >   * operations, return 0 if no error happened.
> > - * Optional, it returns Error* in errp, but it may be NULL even if return value
> > - * is not 0.
> >   *
> > + * If errp is specified, a verbose error message will be copied over.
> >   */
> >  int qemu_file_get_error_obj(QEMUFile *f, Error **errp)
> >  {
> > +    if (!f->last_error) {
> > +        return 0;
> > +    }
> > +
> > +    /* There is an error */
> >      if (errp) {
> > -        *errp = f->last_error_obj ? error_copy(f->last_error_obj) : NULL;
> > +        if (f->last_error_obj) {
> > +            *errp = error_copy(f->last_error_obj);
> > +        } else {
> > +            error_setg_errno(errp, -f->last_error, "Channel error");
> 
> There are a couple of places that do:
> 
>     ret = vmstate_save(f, se, ms->vmdesc);
>     if (ret) {
>         qemu_file_set_error(f, ret);
>         break;
>     }
> 
> and vmstate_save() can return > 0 on error. This would make this message
> say "Unknown error". This is minor.
> 
> But take a look at qemu_fclose(). It can return f->last_error while the
> function documentation says it should return negative on error.
> 
> Should we make qemu_file_set_error() check 'ret' and always set a
> negative value for f->last_error?

Yeah, maybe we can add a sanity check, but logically it's better we just
fix vmstate_save() to make sure it always returns a <0 error.

It seems to me there're so many hooks in vmstate_save_state_v() that it can
return random things.  What's the one you spot?  If it's an obvious issue
we can fix them.

-- 
Peter Xu


