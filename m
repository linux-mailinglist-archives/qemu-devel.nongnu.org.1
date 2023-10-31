Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3C07DC6C6
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 07:56:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxifj-0003cC-Vm; Tue, 31 Oct 2023 02:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qxifh-0003bn-MC
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 02:56:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qxifg-00012f-5j
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 02:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698735375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzrfrgA7fJcvJKS9N60Gep7PhGhJ3NE4YcDO0CiNs7g=;
 b=UuclcsLQY/ouPE7Phel0hD7zgq+0Qh7NWVwaEo8HKD1A3crDQXKBHvL9vtO5kEd7M2ZEVK
 tkcoK7NKCNceEL3Z1TUn8TtyxU73Y78wPNB+Q6S6F2Q91v58C8wg0Dd3/dLF3GoSiKK+wT
 P/JPO7UhnpPgk3EBwL90zLGZ2xLaEYc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-XyJzyGU8NN6UR-Q5CQYtVw-1; Tue, 31 Oct 2023 02:56:13 -0400
X-MC-Unique: XyJzyGU8NN6UR-Q5CQYtVw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-53e305a5a1bso3891348a12.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 23:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698735371; x=1699340171;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TzrfrgA7fJcvJKS9N60Gep7PhGhJ3NE4YcDO0CiNs7g=;
 b=xCMb7zJYGYuGMoBqpBR7Vw4qh3dij8tJY0yA3gMVWC4QxkQP6dOzV2ch7o6jlpmkXC
 PFC5N4R1fndQLfTfJwWiNggS+WcPWeMPDTNdUvZHnWF4V5foJp1C1rQeGc0ZGi4T1I95
 uH0JQrW52hYu4BmA4OOLSGuLOU1DMvxsJstDEcjjJNjHv8aoAio5j5wT3TfZQulAlGYc
 5mefUJpERen1ni26cxURm/eX9SeLuz+Nj7t027FCGJsu4P8Zdr/MOhFYIwkUCgItR7WK
 lFzx87DQOOZ9rlNJ4Hx9PuaCBO9ZlycGFk1ZtV2wuJPO1Of10SGIliunPlzVFVAi+qZc
 AstQ==
X-Gm-Message-State: AOJu0Yx5HakE4hfoWDpdiu4LHw4vRy15OgwRK/onUl846NFf8W09MEZ0
 m4+WY5kIn6LPCOcg/9ZBo9y5HyV9BWeEhj1jS9NNkNZBL4by4SOXhXEvBUO0WHL6GkpeTlyDJA2
 ffqi4JtmiLrbqmKFw/G5n+mPRJSfKiGuopAZIXgnBAg==
X-Received: by 2002:a50:8e58:0:b0:543:4fdb:de84 with SMTP id
 24-20020a508e58000000b005434fdbde84mr2566635edx.7.1698735371628; 
 Mon, 30 Oct 2023 23:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZkjyo659LNIE2LbGkjURpJJb0HOBBts1uGTrqdVVHBZk8kmqJFTWaYgv25CVTFHtCAeO77JKTC1swM7jquGE=
X-Received: by 2002:a50:8e58:0:b0:543:4fdb:de84 with SMTP id
 24-20020a508e58000000b005434fdbde84mr2566628edx.7.1698735371357; Mon, 30 Oct
 2023 23:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231030133712.2822276-1-armbru@redhat.com>
 <20231030133712.2822276-4-armbru@redhat.com>
In-Reply-To: <20231030133712.2822276-4-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Oct 2023 10:55:59 +0400
Message-ID: <CAMxuvaw9s0oiL=h8z2GH_d-a=SKRNwnFjJaT0qz4LGDQxSWKFQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] dump: Recognize "fd:" protocols on Windows hosts
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> A few QMP command can work with named file descriptors.
>
> The only way to create a named file descriptor used to be QMP command
> getfd, which only works on POSIX hosts.  Thus, named file descriptors
> were actually usable only there.
>
> They became usable on Windows hosts when we added QMP command
> get-win32-socket (commit 4cda177c601 "qmp: add 'get-win32-socket'").
>
> Except in dump-guest-memory, because qmp_dump_guest_memory() compiles
> its named file descriptor code only #if !defined(WIN32).
>
> Compile it unconditionally, like we do for the other commands
> supporting them.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  dump/dump.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index d8ea364af2..a5e9a06ef1 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -2130,14 +2130,12 @@ void qmp_dump_guest_memory(bool paging, const cha=
r *protocol,
>          return;
>      }
>
> -#if !defined(WIN32)
>      if (strstart(protocol, "fd:", &p)) {
>          fd =3D monitor_get_fd(monitor_cur(), p, errp);
>          if (fd =3D=3D -1) {
>              return;
>          }
>      }
> -#endif
>
>      if  (strstart(protocol, "file:", &p)) {
>          fd =3D qemu_open_old(p, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,=
 S_IRUSR);
> --
> 2.41.0
>


