Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A23182B17A
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:11:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNwhJ-0001qn-Cd; Thu, 11 Jan 2024 10:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rNwhG-0001og-9a
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:10:18 -0500
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rNwhE-00089a-Q0
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:10:18 -0500
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4298bd85e33so29663301cf.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 07:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704985815; x=1705590615; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6UlqTKv4fw/yfjCPrqY9+/AmdQWijzb6GvZRXamfiyU=;
 b=MMYXwRxVlfCM70RqAN/sH+nwC6SyB4oGAWCQPgiuYG2v7aTizwTN6q04bItzu5g9cM
 W2mhjR7IBZhj8jmrNatymNg/HFxp01WA42siSKV7GNo2A4n7bXzEJyGqchRPOtFfKe82
 qVpxKNhgkImeb7pzP3RYa7GV8tponRS3tRy3kS4ZT1Fh2dA52hhBHD2ioDEvoE5pDSco
 PYQP0Cqg1yX+7yJtwwWvzi1mKDh7V9hqUpddfF0/KEcFuUwGIQfXIHUAU3HJ2f0WxVKO
 zUqV7YzZSTpyEVIzv9ZqWtdXTQzpZc5+PTgq8ghtj1eEsjRUmnJ75pQsMf2CtPZmVh6V
 355g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704985815; x=1705590615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6UlqTKv4fw/yfjCPrqY9+/AmdQWijzb6GvZRXamfiyU=;
 b=TzqFhEJuOH5oEVOh1zq/7ip4dIya+q580xKYuJmXVtbrA3Ln2cM84mK6D5ZJZr7Zlt
 fLh6gD6JlkjKaue1UuKaUQi7H2DkKT4wbCd6gFQmocfu+JCo7Fo0IweuiB/el5ynOb4w
 71DIs6c1p8ktwx2f72FdHi4pagO8TmpWNr5/BvdvZL71yoHrNiO5P6FhZSoHg4zzMqKQ
 x6sXMEb6jny2Ol71XWEMoVQzJ2xEwl+SJ2vdsZfrUyYHy8fIMiOgs+9YevFaS0eDf9JP
 uBJe989+6MsgK0lxuWXQGeoqwhbHhNwXvfvZVupc5+hl92obsdqVl212OsOTGZvasxUk
 GtqQ==
X-Gm-Message-State: AOJu0Yw7l6OExvaGSmAI5aUHA7YUvabcJOGLAOoKkfOg7LHAdbbVhp31
 HZSVmTMCOK1wwq6YMzriygBDRmSmqL2KtZVYmXs=
X-Google-Smtp-Source: AGHT+IH7YBJ9FIPppEXIabJfM0S8FCfUxopc3Z/9C+uhzrY84yi18u1iqNsTdAbnaFX1//7tcrV2l3eHqnQq0wUO8eo=
X-Received: by 2002:ac8:5bd5:0:b0:429:c960:e525 with SMTP id
 b21-20020ac85bd5000000b00429c960e525mr377804qtb.25.1704985815276; Thu, 11 Jan
 2024 07:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20231222093827.951039-1-armbru@redhat.com>
 <20231222093827.951039-2-armbru@redhat.com>
 <87cyu8vyj4.fsf@pond.sub.org>
In-Reply-To: <87cyu8vyj4.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 11 Jan 2024 19:10:03 +0400
Message-ID: <CAJ+F1C+c1VPOE8umoSED2EeKQcttcv=Y=3UQ=gGP6_hOCGL8Sg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dump: Fix HMP dump-guest-memory -z without -R
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stephen Brennan <stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Markus

On Thu, Jan 11, 2024 at 4:36=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Any takers?
>

I have it in my "dump" queue, but it's the only patch I got so far (I
could have missed others).

If it can go through my other means, that's fine with me

> Markus Armbruster <armbru@redhat.com> writes:
>
> > -z without -R has no effect: the dump format remains @elf.  Fix the
> > logic error so it becomes @kdump-zlib.
> >
> > Fixes: e6549197f7ed (dump: Add command interface for kdump-raw formats)
> > Fixes: CID 1523841
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  dump/dump-hmp-cmds.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/dump/dump-hmp-cmds.c b/dump/dump-hmp-cmds.c
> > index b428ec33df..d9340427c3 100644
> > --- a/dump/dump-hmp-cmds.c
> > +++ b/dump/dump-hmp-cmds.c
> > @@ -41,7 +41,7 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict =
*qdict)
> >          dump_format =3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP;
> >      }
> >
> > -    if (zlib && raw) {
> > +    if (zlib) {
> >          if (raw) {
> >              dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_ZLIB;
> >          } else {
>
>


--=20
Marc-Andr=C3=A9 Lureau

