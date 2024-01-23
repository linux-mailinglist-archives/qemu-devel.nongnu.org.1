Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A18A3837947
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 01:34:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS4jP-0000gR-5U; Mon, 22 Jan 2024 19:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rS4jN-0000gH-2c
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 19:33:33 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rS4jK-0005SE-DD
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 19:33:32 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a308e6824ccso96633466b.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 16:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1705970003; x=1706574803; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ab/DrwmIK554nGxki08m1T3U/a0aMMg/SYGe+mxKlIs=;
 b=ZweC9Ja7apqj3wH1kZw/7bb2gbYZ63E1i2KNzUMpAPZvW/wN2318T0J8U2xlrJvio9
 cj0gI3ZzOT3RG3YzNKnOdR8+fsHG/9QdDBp+5XoaBV5ygsITikVgX9Hjc0bYYR+UGym5
 nnMZ1b245io2ZqtkYevgbV0CLbfYtDG6JmRlvYDMr/YjfRE9KaSEmfPaCVUzxAQ2rXZo
 5cmts/gLAbh7heXbhc7yS+VkPUSleb0UTgx2tK3TSgQ1aIAfX3JlVG2hyjQ1slUhMs5S
 bXAqraLDmCB2GZIVJvz3JqeasPeqV0dev8LFpGI7xnKN6bE1pXcH9RjaBaiyvFCega4h
 H8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705970003; x=1706574803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ab/DrwmIK554nGxki08m1T3U/a0aMMg/SYGe+mxKlIs=;
 b=Cy35h1qo31BQrhw+fq4oS5EWKLrNulm2m54S6tmJF+5u2GeupIL2t2I0iJqeDrUTuv
 3+90Ur5ABDY2DVIoTT853AG3wsZtyD5jMwSIpvdxV/BssW69QX8w6PAY7ypV+6ESraxf
 t6skylt/LJvO1U9/ocqyI6ZkQk7hRARuyIrVDyU2t/W1D2nMqjsMWEtIIRyW9QesB+N4
 n8rxKWYfm22ChKpwzLqIZLOpdX2r92tDwgV8Cem39cZXwlNih28fuqrhbdjB2RXlG0ml
 oASGrqPQq6f9xzCVO8yYfS4iNHA0p8HPCLdr5NAl/tdPdM66dzsr1UpUfz03cxWijmQK
 S8Fw==
X-Gm-Message-State: AOJu0YyYFyzpCBdqdAnzGVJFLrrguBf8VYSPqq4dG6Bd1FwufQ1+gJyy
 ZIS3sgYS6H660cRydDukfAIGHkFq7X6nnzvIfIEPfeo7gF5uAE4YMbfM6euw48nQcpSm4igiesk
 rTZVra/Fgg7XHZj0rdyJ45HOtr8JADSRh+FtJBw==
X-Google-Smtp-Source: AGHT+IEpPPzCvbSEjiT89DtVLkTU+cXZZOsJBThHX/RnIhOJvfv/rWg0+M8SCyAIHrx2mmjijMSaSAsanZHH5uqI1nU=
X-Received: by 2002:a17:906:8466:b0:a2d:dde:9ff4 with SMTP id
 hx6-20020a170906846600b00a2d0dde9ff4mr2226708ejc.13.1705970003349; Mon, 22
 Jan 2024 16:33:23 -0800 (PST)
MIME-Version: 1.0
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-2-hao.xiang@bytedance.com>
 <22969801-AEDE-46EB-86E8-0E6F26E23397@nutanix.com>
In-Reply-To: <22969801-AEDE-46EB-86E8-0E6F26E23397@nutanix.com>
From: Hao Xiang <hao.xiang@bytedance.com>
Date: Mon, 22 Jan 2024 16:33:12 -0800
Message-ID: <CAAYibXjw42iB=5YgKsXy4erj6RsGuqDqFnhuOZxkfBit7S5TtA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 01/20] multifd: Add capability to
 enable/disable zero_page
To: Shivam Kumar <shivam.kumar1@nutanix.com>
Cc: "farosas@suse.de" <farosas@suse.de>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, 
 "peterx@redhat.com" <peterx@redhat.com>, 
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, 
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ej1-x62f.google.com
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

On Sun, Jan 14, 2024 at 10:02=E2=80=AFPM Shivam Kumar <shivam.kumar1@nutani=
x.com> wrote:
>
>
>
> > On 04-Jan-2024, at 6:14 AM, Hao Xiang <hao.xiang@bytedance.com> wrote:
> >
> > From: Juan Quintela <quintela@redhat.com>
> >
> > We have to enable it by default until we introduce the new code.
> >
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> > migration/options.c | 15 +++++++++++++++
> > migration/options.h |  1 +
> > qapi/migration.json |  8 +++++++-
> > 3 files changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/migration/options.c b/migration/options.c
> > index 8d8ec73ad9..0f6bd78b9f 100644
> > --- a/migration/options.c
> > +++ b/migration/options.c
> > @@ -204,6 +204,8 @@ Property migration_properties[] =3D {
> >     DEFINE_PROP_MIG_CAP("x-switchover-ack",
> >                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
> >     DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIM=
IT),
> > +    DEFINE_PROP_MIG_CAP("main-zero-page",
> > +            MIGRATION_CAPABILITY_MAIN_ZERO_PAGE),
> >     DEFINE_PROP_END_OF_LIST(),
> > };
> >
> > @@ -284,6 +286,19 @@ bool migrate_multifd(void)
> >     return s->capabilities[MIGRATION_CAPABILITY_MULTIFD];
> > }
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
> > bool migrate_pause_before_switchover(void)
> > {
> >     MigrationState *s =3D migrate_get_current();
> > diff --git a/migration/options.h b/migration/options.h
> > index 246c160aee..c901eb57c6 100644
> > --- a/migration/options.h
> > +++ b/migration/options.h
> > @@ -88,6 +88,7 @@ int migrate_multifd_channels(void);
> > MultiFDCompression migrate_multifd_compression(void);
> > int migrate_multifd_zlib_level(void);
> > int migrate_multifd_zstd_level(void);
> > +bool migrate_use_main_zero_page(void);
> > uint8_t migrate_throttle_trigger_threshold(void);
> > const char *migrate_tls_authz(void);
> > const char *migrate_tls_creds(void);
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index eb2f883513..80c4b13516 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -531,6 +531,12 @@
> > #     and can result in more stable read performance.  Requires KVM
> > #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
> > #
> > +#
> > +# @main-zero-page: If enabled, the detection of zero pages will be
> > +#                  done on the main thread.  Otherwise it is done on
> > +#                  the multifd threads.
> > +#                  (since 8.2)
> > +#
> Should the capability name be something like "zero-page-detection" or jus=
t =E2=80=9Czero-page=E2=80=9D?
> CC: Fabiano Rosas

I think the same concern was brought up last time Juan sent out the
original patchset. Right now, the zero page detection is done in the
main migration thread and it is always "ON". This change added a
functionality to move the zero page detection from the main thread to
the multifd sender threads. Now "main-zero-page" is turned "OFF" by
default, and zero page checking is done in the multifd sender thread
(much better performance). If user wants to run the zero page
detection in the main thread (keep current behavior), user can change
"main-zero-page" to "ON".

Renaming it to "zero-page-detection" or just =E2=80=9Czero-page=E2=80=9D ca=
n not
differentiate the old behavior and the new behavior.

Here are the options:
1) Keep the current behavior. "main-zero-page" is OFF by default and
zero page detection runs on the multifd thread by default. User can
turn the switch to "ON" if they want old behavior.
2) Make "main-zero-page" switch ON as default. This would keep the
current behavior by default. User can set it to "OFF" for better
performance.

> > # Features:
> > #
> > # @deprecated: Member @block is deprecated.  Use blockdev-mirror with
> > @@ -555,7 +561,7 @@
> >            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
> >            'validate-uuid', 'background-snapshot',
> >            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> > -           'dirty-limit'] }
> > +           'dirty-limit', 'main-zero-page'] }
> >
> > ##
> > # @MigrationCapabilityStatus:
> > --
> > 2.30.2
> >
> >
> >
>

