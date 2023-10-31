Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 837107DC6C5
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 07:55:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxieX-0002QA-4k; Tue, 31 Oct 2023 02:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qxieR-0002PX-3d
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 02:54:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qxieP-0000bi-J0
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 02:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698735296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKUaec2vzRu/CgExBf2LVLzK6+czP+JROGdOozAgVXA=;
 b=ZRl7IFWH92SVuSVNUCI8ZZr6rP8tID7F0o6t5y/0CAEemdPytXcipRW+KbngGYIoCKaKOg
 NS2wmRXb3oLA/Ops0Q1cC8FBPBsdcikCZK5VY0Il+iekq+QQZ0yY6Bj+xWxKYrwA/HefBa
 r7bNPrp8rBALVuwUuXV6keNLwSbhgq8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-GlAX7KIXMpigGl7MY3Q8HQ-1; Tue, 31 Oct 2023 02:54:45 -0400
X-MC-Unique: GlAX7KIXMpigGl7MY3Q8HQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9c7f0a33afbso361989366b.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 23:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698735283; x=1699340083;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qKUaec2vzRu/CgExBf2LVLzK6+czP+JROGdOozAgVXA=;
 b=JX0TIum/X2ucBu9AK4yP4Oi4Tz4f2uvgbWXr2U6BMKLsQfndJfUf4/Y9R30W93edh9
 vA+VEGJuzmFXyejQjVNxqJYA5ZUN0N2crAo2aPBtb4JM0LlCcCJ5lBUQJJpz5iU5Fd3u
 EbOcPzf2FkLDcBUzucu4diaLfpPFJhX6ewrj722HHaTU+Er0/E9ruHzyAyoZ7QTI1YLA
 VlREhzdmbuzSYiGMyFzgFZsxr9kNpbNqHfdpkuijUgyfyLTqu+KDQzyNXHjPRnhgHBy6
 y39smFEIvDAKOgygq/ZdpY1z4EZ8krBi5blPiUA5V3yzMxb157sR8WOWSxlgb2GKJaQL
 08Kw==
X-Gm-Message-State: AOJu0YwXMVQXcxhF6eK5G7/n41sIVoxXPiWV2hL/kXSG1RMDLzwl42il
 5Bu6lOv75zA0oVISRiQMihTaPcCHc9QJ+xr8NxlEc4gDiKhn+MxUJgOpZoPZ5iXqMLRbqgp61FU
 8OknX+VLnxL4/W4dNEXC2CwHEYR/tsOQhaUyZbrkgjQ==
X-Received: by 2002:a05:6402:124e:b0:53e:1375:33ce with SMTP id
 l14-20020a056402124e00b0053e137533cemr9922479edw.30.1698735283483; 
 Mon, 30 Oct 2023 23:54:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcX9X9mow2kNvTDk8eck1cqbT1IgKmRn2CSaf6ifkq7eeaLqyRWd4cP6g+MygCcV421rQtsRF8rzFeoawJAXo=
X-Received: by 2002:a05:6402:124e:b0:53e:1375:33ce with SMTP id
 l14-20020a056402124e00b0053e137533cemr9922474edw.30.1698735283312; Mon, 30
 Oct 2023 23:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231030133712.2822276-1-armbru@redhat.com>
 <20231030133712.2822276-2-armbru@redhat.com>
In-Reply-To: <20231030133712.2822276-2-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Oct 2023 10:54:31 +0400
Message-ID: <CAMxuvawhyJ3OWNrf=g2=irHdh9_pdfrc2K57T1ZPoHx_wmv+Kg@mail.gmail.com>
Subject: Re: [PATCH 1/5] dump: Rename qmp_dump_guest_memory() parameter to
 match QAPI schema
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

On Mon, Oct 30, 2023 at 5:37=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> The name of the second parameter differs between QAPI schema and C
> implementation: it's @protocol in the former and @file in the latter.
> Potentially confusing.  Change the C implementation to match the QAPI
> schema.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  dump/dump.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index d355ada62e..a1fad17f9c 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -2061,11 +2061,12 @@ DumpQueryResult *qmp_query_dump(Error **errp)
>      return result;
>  }
>
> -void qmp_dump_guest_memory(bool paging, const char *file,
> +void qmp_dump_guest_memory(bool paging, const char *protocol,
>                             bool has_detach, bool detach,
> -                           bool has_begin, int64_t begin, bool has_lengt=
h,
> -                           int64_t length, bool has_format,
> -                           DumpGuestMemoryFormat format, Error **errp)
> +                           bool has_begin, int64_t begin,
> +                           bool has_length, int64_t length,
> +                           bool has_format, DumpGuestMemoryFormat format=
,
> +                           Error **errp)
>  {
>      ERRP_GUARD();
>      const char *p;
> @@ -2128,7 +2129,7 @@ void qmp_dump_guest_memory(bool paging, const char =
*file,
>      }
>
>  #if !defined(WIN32)
> -    if (strstart(file, "fd:", &p)) {
> +    if (strstart(protocol, "fd:", &p)) {
>          fd =3D monitor_get_fd(monitor_cur(), p, errp);
>          if (fd =3D=3D -1) {
>              return;
> @@ -2136,7 +2137,7 @@ void qmp_dump_guest_memory(bool paging, const char =
*file,
>      }
>  #endif
>
> -    if  (strstart(file, "file:", &p)) {
> +    if  (strstart(protocol, "file:", &p)) {
>          fd =3D qemu_open_old(p, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,=
 S_IRUSR);
>          if (fd < 0) {
>              error_setg_file_open(errp, errno, p);
> --
> 2.41.0
>


