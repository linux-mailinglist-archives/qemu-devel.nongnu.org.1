Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4647266A0
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:58:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wUJ-00031H-O6; Wed, 07 Jun 2023 12:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q6wUH-0002zJ-NF
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q6wUG-0001sq-3I
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686157099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HB4zUzdcc5Cy23yHp483WXgKZOOcJGiEDGreI1UkoU4=;
 b=GqPsTBKBieBOCCZXhvrQaIyYYUvC5dAapPPnmi+cnBZoHJi5fP2ah8Yt1fZErU5Dkycdcu
 XnSf3WR4/XFsyNwHCRvfH/NYYEhpYCE8cXVV4MFPaUUZq3Ae9oitUUx9kn0t01ZqxwQooX
 UM5aBENZKZ1IqSLNy4w/sNykQa84zW8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-slyehykLMVOGs9c04y_acw-1; Wed, 07 Jun 2023 12:58:17 -0400
X-MC-Unique: slyehykLMVOGs9c04y_acw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-256419413a3so605060a91.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 09:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686157096; x=1688749096;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HB4zUzdcc5Cy23yHp483WXgKZOOcJGiEDGreI1UkoU4=;
 b=g8/4Ch15wZElR2NTGNCC9rvVlUgaJd91kEiv+7oTBsnz9iDDRZiyycq6bVgj31vCNn
 4W31JjkwM6hPGnyan4rEVf3DqM3x3zrGwiCyZxkL4Nt3dtsvW26nXu5CeyYsGEocSb4X
 n1WZodU5AZFAxpKv5pZz4cuwFLydzWDq2cZ7U/+7QE9/iIMtassyoWAmczYw8KzOUTTJ
 9C+uzAaDr+vY/2ZiKqWF1rIiA2ddLY9TtT6LHyuVxq7eNlVYrf4j7GmzYdIK3+XNdrmP
 YjzfuR2yfHDgAZvy7dEUQvoUUYVbPFVH9xIBWx8kfwbk0FaX71SfoWJggHTHDWIbs972
 8MPQ==
X-Gm-Message-State: AC+VfDxcoS7PRVqIo386/hbLt2P2R2J/gEdgpeMucNWEpdOj1ityp6Al
 N6cEtuz3JogIB6J0kGWazmDvBEHsJesNaaijnqVDZjCUOkRZ6Kt64AnU0+kdvkw7d7Jap3rDu6v
 7Ox1vZriTSsTawgXuFSSLoGLYTdJvegcbLeWmY3MvCw==
X-Received: by 2002:a17:90b:350d:b0:258:c3e9:e9c4 with SMTP id
 ls13-20020a17090b350d00b00258c3e9e9c4mr7151765pjb.15.1686157096484; 
 Wed, 07 Jun 2023 09:58:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5jQAdkmQfK/idbM4yjrVqqKX5RKbYGCLXnnGCeT74Lwca+Y4+ilA/5PggTNyzzX6FVlY7QJ0TH5WzdHE49e/c=
X-Received: by 2002:a17:90b:350d:b0:258:c3e9:e9c4 with SMTP id
 ls13-20020a17090b350d00b00258c3e9e9c4mr7151745pjb.15.1686157096052; Wed, 07
 Jun 2023 09:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-3-farosas@suse.de>
 <87y1kvoezi.fsf@secure.mitica> <87o7lrh48h.fsf@suse.de> <ZICFWm+qTOHBgzzN@x1n>
In-Reply-To: <ZICFWm+qTOHBgzzN@x1n>
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 7 Jun 2023 18:58:05 +0200
Message-ID: <CAGiv1-W=i6hgNHjrHaeuCsjX=_EnkLdQ0Xas7drYUK-ybSdDsA@mail.gmail.com>
Subject: Re: [PATCH 2/3] migration/multifd: Protect accesses to
 migration_threads
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Jiang Jiacheng <jiangjiacheng@huawei.com>, Leonardo Bras <leobras@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000bf00b105fd8d0a51"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000bf00b105fd8d0a51
Content-Type: text/plain; charset="UTF-8"

Sounds good.

On Wed, Jun 7, 2023, 18:28 Peter Xu <peterx@redhat.com> wrote:

> On Wed, Jun 07, 2023 at 09:00:14AM -0300, Fabiano Rosas wrote:
> > >> diff --git a/migration/migration.c b/migration/migration.c
> > >> index e731fc98a1..b3b8345eb2 100644
> > >> --- a/migration/migration.c
> > >> +++ b/migration/migration.c
> > >> @@ -1146,6 +1146,7 @@ static void migrate_fd_cleanup(MigrationState
> *s)
> > >>          qemu_mutex_lock_iothread();
> > >>
> > >>          multifd_save_cleanup();
> > >> +        qmp_migration_threads_cleanup();
> > >
> > > I think I will spare this one as the mutex is static, so we are not
> > > winning any memory back.
> > >
> >
> > Ok
>
> We could consider __attribute__((__constructor__)) in this case.
>
> --
> Peter Xu
>
>
>

--000000000000bf00b105fd8d0a51
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Sounds good.=C2=A0</div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 7, 2023, 18:28 Peter Xu &lt=
;<a href=3D"mailto:peterx@redhat.com">peterx@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">On Wed, Jun 07, 2023 at 09:00:14AM -030=
0, Fabiano Rosas wrote:<br>
&gt; &gt;&gt; diff --git a/migration/migration.c b/migration/migration.c<br=
>
&gt; &gt;&gt; index e731fc98a1..b3b8345eb2 100644<br>
&gt; &gt;&gt; --- a/migration/migration.c<br>
&gt; &gt;&gt; +++ b/migration/migration.c<br>
&gt; &gt;&gt; @@ -1146,6 +1146,7 @@ static void migrate_fd_cleanup(Migratio=
nState *s)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_mutex_lock_iothread();=
<br>
&gt; &gt;&gt;=C2=A0 <br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 multifd_save_cleanup();<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_migration_threads_cleanup();=
<br>
&gt; &gt;<br>
&gt; &gt; I think I will spare this one as the mutex is static, so we are n=
ot<br>
&gt; &gt; winning any memory back.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Ok<br>
<br>
We could consider __attribute__((__constructor__)) in this case.<br>
<br>
-- <br>
Peter Xu<br>
<br>
<br>
</blockquote></div>

--000000000000bf00b105fd8d0a51--


