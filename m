Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 958F382A74F
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 06:48:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNnue-0004p0-QQ; Thu, 11 Jan 2024 00:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rNnuc-0004ol-AN
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 00:47:30 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rNnuU-0001Mn-Dm
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 00:47:23 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5589cfe4b88so162003a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 21:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704952039; x=1705556839; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s6nluNoFG/LD7gTfbq0RZgNsbo2/X6L/QnvCZAfZwDI=;
 b=kj+BEoBBPqNqsgKPy3/asTeHrgZscbBvKIie4oVtAQDoaNU/GH2Dd1ygTEDL5QYA33
 DwGTzrkgxk2CT11kS+8MOiVPvnUrsnX8vVP87TMGcgSFZkdTTCGqpi3pwlyGZ+C9a3pc
 C6Y/hS/h1EwMvkGMHsBrYROAfpgOt3rZeZh0UCwNADNq2u/KeISmY+LnKFQJrXi1bE8y
 I6Z0x5ZIPGswpFQmiT6KymkK+Fr56csBn7WyTp40nKXRFvRCsmu2GMUkIZiOeYu7QMqV
 VzntBxI6IUAoAcOj3Kp1QDsn/48WJvq7MSMJqTxXYN7pCXOUx/h0hTmh7YpU5txc8sE7
 QiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704952039; x=1705556839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s6nluNoFG/LD7gTfbq0RZgNsbo2/X6L/QnvCZAfZwDI=;
 b=ffsMHjBvlGkV3zkgovGIbl258B4sObE/f7fai6tLfOqwzxUHLKzz2LxpQsIcFolAZW
 eH4v/YVCAb+GUNHQ4+RcHxGTzDOOl7yFbyjZiRA1z/qL17wxzYPbGb3Ub8S7a9bfu/oq
 fXnT475eGmBfL0Q+DpBY9a7F6PG2QooRb57XXCO/x7hDQKPxpTosq183H9UUBGZzqT4s
 S5nOQ38N2XbfDQefvwjcAWDCTxrMlwGv3sHgblB+HsDA//oFiFaXGlZ5m/5+6zIh9z/j
 C6W64u0v24jrC+wUaK4dWDHU8TtfQnFYcMaeIvspGIpXu//9vxAaz2Ni1W13Dl4umhpM
 G37A==
X-Gm-Message-State: AOJu0YzhO9uyK/YuhTM1Ul2Ll4X21/Ms6AFMUy8QkFp3D6jYedlOmF2o
 MaFYXDOLSE4UU/sCoP61RuZ92fTE9TbOAUqceX2zM9tsVXKbmg==
X-Google-Smtp-Source: AGHT+IHD/TPFik7wtxju4XVCGug/MIfSB2VqYW/xdPA+2kg4pGNdRhTm0wPy208ZQJHjBJrQ38E5fuXkQhflsoEBHo0=
X-Received: by 2002:aa7:c419:0:b0:557:bee6:48ed with SMTP id
 j25-20020aa7c419000000b00557bee648edmr289832edq.65.1704952039194; Wed, 10 Jan
 2024 21:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-2-hao.xiang@bytedance.com> <87r0irsgp2.fsf@suse.de>
In-Reply-To: <87r0irsgp2.fsf@suse.de>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Wed, 10 Jan 2024 21:47:08 -0800
Message-ID: <CAAYibXgfa7ExypAKP5AVjgYWajVgqh=mn4Ph4m8_v5=q6p-aQw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 01/20] multifd: Add capability to
 enable/disable zero_page
To: Fabiano Rosas <farosas@suse.de>
Cc: peter.maydell@linaro.org, peterx@redhat.com, marcandre.lureau@redhat.com, 
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org, 
 Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ed1-x52f.google.com
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

On Mon, Jan 8, 2024 at 12:39=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Hao Xiang <hao.xiang@bytedance.com> writes:
>
> > From: Juan Quintela <quintela@redhat.com>
> >
> > We have to enable it by default until we introduce the new code.
> >
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> >  migration/options.c | 15 +++++++++++++++
> >  migration/options.h |  1 +
> >  qapi/migration.json |  8 +++++++-
> >  3 files changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/migration/options.c b/migration/options.c
> > index 8d8ec73ad9..0f6bd78b9f 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -204,6 +204,8 @@ Property migration_properties[] =3D {
> >      DEFINE_PROP_MIG_CAP("x-switchover-ack",
> >                          MIGRATION_CAPABILITY_SWITCHOVER_ACK),
> >      DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LI=
MIT),
> > +    DEFINE_PROP_MIG_CAP("main-zero-page",
> > +            MIGRATION_CAPABILITY_MAIN_ZERO_PAGE),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > @@ -284,6 +286,19 @@ bool migrate_multifd(void)
> >      return s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
> >  }
> >
> > +bool migrate_use_main_zero_page(void)
> > +{
> > +    /* MigrationState *s; */
> > +
> > +    /* s =3D migrate_get_current(); */
> > +
> > +    /*
> > +     * We will enable this when we add the right code.
> > +     * return s->enabled_capabilities[MIGRATION_CAPABILITY_MAIN_ZERO_P=
AGE];
> > +     */
> > +    return true;
> > +}
> > +
> >  bool migrate_pause_before_switchover(void)
> >  {
> >      MigrationState *s =3D migrate_get_current();
> > diff --git a/migration/options.h b/migration/options.h
> > index 246c160aee..c901eb57c6 100644
> > --- a/migration/options.h
> > +++ b/migration/options.h
> > @@ -88,6 +88,7 @@ int migrate_multifd_channels(void);
> >  MultiFDCompression migrate_multifd_compression(void);
> >  int migrate_multifd_zlib_level(void);
> >  int migrate_multifd_zstd_level(void);
> > +bool migrate_use_main_zero_page(void);
> >  uint8_t migrate_throttle_trigger_threshold(void);
> >  const char *migrate_tls_authz(void);
> >  const char *migrate_tls_creds(void);
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index eb2f883513..80c4b13516 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -531,6 +531,12 @@
> >  #     and can result in more stable read performance.  Requires KVM
> >  #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
> >  #
> > +#
> > +# @main-zero-page: If enabled, the detection of zero pages will be
> > +#                  done on the main thread.  Otherwise it is done on
> > +#                  the multifd threads.
> > +#                  (since 8.2)
> > +#
> >  # Features:
> >  #
> >  # @deprecated: Member @block is deprecated.  Use blockdev-mirror with
> > @@ -555,7 +561,7 @@
> >             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
> >             'validate-uuid', 'background-snapshot',
> >             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> > -           'dirty-limit'] }
> > +           'dirty-limit', 'main-zero-page'] }
> >
> >  ##
> >  # @MigrationCapabilityStatus:
>
> I'll extract this zero page work into a separate series and submit for
> review soon. I want to get people's opinion on it independently of this
> series.

Sounds good. Thanks.

