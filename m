Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC4F7E6FE1
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:11:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r18Xz-0002w6-UH; Thu, 09 Nov 2023 12:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r18Xy-0002vg-G4
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:10:26 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r18Xv-0006U2-NC
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:10:25 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53e3b8f906fso1765042a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 09:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699549821; x=1700154621; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pKn2wFNiNtiYtY2NRSgRfnoKVvquaS14kyseYtAQ+R4=;
 b=lBPSUsdMHFVw9nScYl+Sdrylk32BRjNlBPaRh4OZ3tEqOKAUlbWNLOP/FQDR3CO3Es
 0TIsy0AwahJ5RRqpQYtlP4WqWXMUqXtWYsh6t3Fo0QXVHpV8NzeBJQeaoSDsmXrVJ5sX
 jVSDf+Hr4KbVym6h7jGuRGk72gAR7BBkMrMBUCgGzdeq+Ty6svYxlLfZvEnalsvHlShY
 /FlDwPQpAjd/9ylAGztUGxdu8mf7aib94gg9e/F/tJijGROGx90hagM9JlaWYp+erWTI
 3d+JuF4ClgOFkOzNeVBpdL+7LcX4smEK2wYrqk+WsY57H5j7sv2oIuaXlQTcCs8yvVJK
 /V8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699549821; x=1700154621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pKn2wFNiNtiYtY2NRSgRfnoKVvquaS14kyseYtAQ+R4=;
 b=cOFxGiCWP+sl1o5rc0SY30D2Jf9DiySzf7w05Ni9omFvtO29a7rjZY0yepizOcz+qJ
 iExkjC43uqY5oWife1khxoyyolBpxWbT6pfSDfYdyp8GkX0mNWAWU4B3aABkjCotC4DB
 nzjod9wmS0VmDEbsevOw7xbOmkFgoO7+jIRLWjAMzMrVoGE57TZOdzdfUTNACmUP8zke
 LtaNYQA36axjZBpoDzJphq02CeAMgNLU/xLueQHfzo89kdQ49Odcn1BdhrsIVGMrDxWs
 1sIMZiCNIaxxV2Ot/t+Ez/X7Pt3jKc5DJVN3uGlRLf+EGcnmF7aoWVXpbZRzUdpgk5hB
 mY7g==
X-Gm-Message-State: AOJu0YyzqBIToNhvi7vcoAzORWeDd6CqhVVqbZmJXrKA8YcUBAzvfRkI
 8BzHoSjk49PZzzGhM1xvYjN7817B5T11EQ+F7RChAg==
X-Google-Smtp-Source: AGHT+IFbH6CAVXH7ADs5Rexsg2FS03eddq9jcbNcFPSNY/KE+KcLSuHQrZrEEyLAUZZpzzlUbm/Djm6P6dRKH45Hu3I=
X-Received: by 2002:a50:cdc1:0:b0:543:7c3d:6ab0 with SMTP id
 h1-20020a50cdc1000000b005437c3d6ab0mr4703974edj.13.1699549821243; Thu, 09 Nov
 2023 09:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20231102114054.44360-1-quintela@redhat.com>
 <20231102114054.44360-22-quintela@redhat.com>
In-Reply-To: <20231102114054.44360-22-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 17:10:09 +0000
Message-ID: <CAFEAcA_LrLsJ_4PnWLW0cuuTQRP5J7yq48xm8=kLDL39MObn9g@mail.gmail.com>
Subject: Re: [PULL 21/40] migration: per-mode blockers
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>, 
 Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, 
 Corey Minyard <cminyard@mvista.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Li Zhijian <lizhijian@fujitsu.com>, Eric Blake <eblake@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-arm@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Corey Minyard <minyard@acm.org>, John Snow <jsnow@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, 
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Steve Sistare <steven.sistare@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, 2 Nov 2023 at 11:43, Juan Quintela <quintela@redhat.com> wrote:
>
> From: Steve Sistare <steven.sistare@oracle.com>
>
> Extend the blocker interface so that a blocker can be registered for
> one or more migration modes.  The existing interfaces register a
> blocker for all modes, and the new interfaces take a varargs list
> of modes.
>
> Internally, maintain a separate blocker list per mode.  The same Error
> object may be added to multiple lists.  When a block is deleted, it is
> removed from every list, and the Error is freed.
>
> No functional change until a new mode is added.

Hi; Coverity worries about this code:

> -static GSList *migration_blockers;
> +static GSList *migration_blockers[MIG_MODE__MAX];
>
>  static bool migration_object_check(MigrationState *ms, Error **errp);
>  static int migration_maybe_pause(MigrationState *s,
> @@ -1043,7 +1043,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>  {
>      MigrationState *s = migrate_get_current();
>      int state = qatomic_read(&s->state);
> -    GSList *cur_blocker = migration_blockers;
> +    GSList *cur_blocker = migration_blockers[migrate_mode()];

because it thinks that migrate_mode() might return a value that's
too big for the migration_blockers[] array. (CID 1523829, 1523830.)

I think Coverity complains mostly because it doesn't understand
that the MIG_MODE__MAX in the enum is not a valid enum value
that a function returning a MigMode might return. But we can
help it out by assert()ing in migrate_mode() that the value
we're about to return is definitely a valid mode.

thanks
-- PMM

