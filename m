Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3AA7DCA6D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 11:11:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxlh6-0004xI-Nc; Tue, 31 Oct 2023 06:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qxlh4-0004x9-Iu
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qxlh3-0002QG-3P
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698746991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T3sQeuCcas9ze6vO7TADdW4h1CkIunW9RiOYbakl8cA=;
 b=OjGkwtR7u1GrQOD8B2lCI7IX5GvO92HVDG18ac8h6ZLZK8PboPY3DtIhYBrFjpfvG8Cnq4
 3843FsLFy8EXjg6ue258sviUH7EFqsaaZQZ5saApzmoxxmY+HA/5cX8YFPcFReWEoi+yFe
 zCO9K2UaIbqMGa5YDSB4GCRfBqzWkvE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-w7ZBhAB5NkKy9FdZgSTbSw-1; Tue, 31 Oct 2023 06:09:50 -0400
X-MC-Unique: w7ZBhAB5NkKy9FdZgSTbSw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-53e2acda9d6so4088128a12.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 03:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698746989; x=1699351789;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3sQeuCcas9ze6vO7TADdW4h1CkIunW9RiOYbakl8cA=;
 b=VYFdU9pshdrntRkRQ223BmQgv9PVYimme5WrvOgKvTV8uHd2lOTImnIgMx+oA+fV0A
 qjzXPbPi51UPTZw9wAWNwGHfJrkiCSM+zeNnyb2EtkHpgiC5ubGNkDVrlATYTXmHh5cP
 ZW/yBvniM5EGLq6hqOpHZytwb5fRHt3geIIE2AsKx0Sr59EL19nG8yuOsEX+jBOZ5kgO
 if5Wm6ZHyme+vL9Y9RlCYjZALMdMrR+UVBr063Jt/Gb3my1TkHqjKN5cYa3ScGZ+5UP0
 ZLMEeE0pRzRY8WpPWQbhIInCxqAcVHVhl/DiZma1GEKgMk3i0RWivEZANx324dCCE1La
 U6oA==
X-Gm-Message-State: AOJu0Yytx5KwNVbLwyzSy202D8kQ5nk9F9sWHTsgGHwVphLffI/0EAZ9
 wSLN/chEBWrSRaBmeTdom1+SSLTU47QDMnZvKjRsnoZndzSB/JdBLkm0BRRgSBoh7XjLi0G5GPN
 smvRuPqcvZiq4XD+q84CxVhj1mQP1M5M=
X-Received: by 2002:a05:6402:12ca:b0:540:b1fb:b630 with SMTP id
 k10-20020a05640212ca00b00540b1fbb630mr10525304edx.27.1698746989011; 
 Tue, 31 Oct 2023 03:09:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA77lQLtPiKFIt9B3lEdxJnRdIJytyyZGSqJwGapc01KkNdKX3bwSVbFSHd8EQrMet99ay2pwzWiqgQvz2NDU=
X-Received: by 2002:a05:6402:12ca:b0:540:b1fb:b630 with SMTP id
 k10-20020a05640212ca00b00540b1fbb630mr10525287edx.27.1698746988704; Tue, 31
 Oct 2023 03:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231030133712.2822276-1-armbru@redhat.com>
 <20231030133712.2822276-3-armbru@redhat.com>
 <CAMxuvaxy_mwut2rH0cAOaOgiRTTeBBBCKprTS4bmetHqb7C8Ww@mail.gmail.com>
 <87zfzzkvv5.fsf@pond.sub.org> <87lebjkvol.fsf@pond.sub.org>
In-Reply-To: <87lebjkvol.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Oct 2023 14:09:36 +0400
Message-ID: <CAMxuvayaiB2O_=FOCY8vGQXjmHUFA4Fj2vbMFqgGp9e7KZmihw@mail.gmail.com>
Subject: Re: [PATCH 2/5] dump: Fix g_array_unref(NULL) in dump-guest-memory
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Tue, Oct 31, 2023 at 1:06=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Markus Armbruster <armbru@redhat.com> writes:
>
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >
> >> Hi
> >>
> >> On Mon, Oct 30, 2023 at 5:37=E2=80=AFPM Markus Armbruster <armbru@redh=
at.com> wrote:
> >>>
> >>> When dump_init()'s check for non-zero @length fails, dump_cleanup()
> >>> passes null s->string_table_buf to g_array_unref(), which spews "GLib=
:
> >>> g_array_unref: assertion 'array' failed" to stderr.
> >>>
> >>> Guard the g_array_unref().
> >>>
> >>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >>
> >> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>
> >>> ---
> >>>  dump/dump.c | 4 +++-
> >>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/dump/dump.c b/dump/dump.c
> >>> index a1fad17f9c..d8ea364af2 100644
> >>> --- a/dump/dump.c
> >>> +++ b/dump/dump.c
> >>> @@ -100,7 +100,9 @@ static int dump_cleanup(DumpState *s)
> >>>      memory_mapping_list_free(&s->list);
> >>>      close(s->fd);
> >>>      g_free(s->guest_note);
> >>> -    g_array_unref(s->string_table_buf);
> >>> +    if (s->string_table_buf) {
> >>> +        g_array_unref(s->string_table_buf);
> >>> +    }
> >>
> >> or:
> >> g_clear_pointer(&s->string_table_buf, g_array_unref)
> >
> > Since dump_cleanup() doesn't clear any of the other members of @s, I'll
> > stick to g_array_unref() for consistency and simplicity.
>
> Wait!  You suggest *unconditional*
>
>          g_clear_pointer(&s->string_table_buf, g_array_unref)
>
> don't you?
>
> Got a preference?

Yes, I think it's safe and more future proof in general. Up to you if
you respin.

thanks

>
> >>>      s->guest_note =3D NULL;
> >>>      if (s->resume) {
> >>>          if (s->detached) {
> >>> --
> >>> 2.41.0
> >>>
> >
> > Thanks!
>


