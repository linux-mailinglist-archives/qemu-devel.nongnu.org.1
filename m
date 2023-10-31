Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7055C7DC6C4
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 07:55:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxidz-0002O5-MM; Tue, 31 Oct 2023 02:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qxidx-0002Nj-5B
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 02:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qxidh-0000X9-La
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 02:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698735252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TCRA/VF3K3Ve3fS6RV0ElYL24IHGPnGgZX8flsRixf0=;
 b=ieBCzCj8tGl/hMStiS3VGmHquVDvJ5Q4wLnLHiqKkAAHm1YGYncHGbY2qs4toKLETK+NQf
 muvhIxuZCS4gFNFKyTbI9dudsM5Yszl1dbBtwxKACqtdHkF1cp/pQ4Eg9FRogj5uqZqQRE
 DWHDmffWb4wfubF8b0vjwFDKAu+a8Ec=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-pkPgZHH2MbWEM7qxnWo78g-1; Tue, 31 Oct 2023 02:54:05 -0400
X-MC-Unique: pkPgZHH2MbWEM7qxnWo78g-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-53fa5cd4480so4116654a12.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 23:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698735244; x=1699340044;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCRA/VF3K3Ve3fS6RV0ElYL24IHGPnGgZX8flsRixf0=;
 b=AThEQyulma8LBncH3EOAeMCb3eMvNHphVp2x6thkydDNoYE/VXQN0HFBX2vz7A6xla
 +1sCiqyQl92VEh2ceKFd6Js5gQMldoHvQ4Tl2TbXos6iGl+GaeudARfoJebI4GYSJvft
 sxOLu5Nx01KzGDBaqaKG9kxOO+Js2Aoi3od17ZV396EIpWSzd8RU9/8qDBN6oo4451xr
 R2AQ81ZvRx//7zNAyz+BapvB9MnDKkJSr5VAXhz1K8PUhd3D0AHPJf3KFOaPJU1Bif1G
 hHL+9HKpVC2eQm80hosiIC6RaPjQDIUp1Tlvq3RtDifOvIPvXDWfLT0I65yD9zD+F9zl
 A2Xw==
X-Gm-Message-State: AOJu0YyKr0i8vCJtn7umlN1qBXJBdY6JwX6MQzJwNwr+pwrvUZoxmbDP
 7dCzKI3ydOdZK4l8/tNx2Rrta63d9JDpR/qTw3dcMVnuHJVoeq8Ex6asQQvh0xfwGl6Yclqs60M
 nbVgTXbNiZ9gDh6SDl9p4MhkJwnLXMsk=
X-Received: by 2002:a05:6402:b52:b0:53d:b71d:34a7 with SMTP id
 bx18-20020a0564020b5200b0053db71d34a7mr9156608edb.6.1698735244319; 
 Mon, 30 Oct 2023 23:54:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjZ3ZxkqEeHV9dX2ClFWeR8rNv++EVrSKMtXa0ujyl6UhXavD759mdVBtuMqIMNF611WehgwNAlzwlWWHT5gM=
X-Received: by 2002:a05:6402:b52:b0:53d:b71d:34a7 with SMTP id
 bx18-20020a0564020b5200b0053db71d34a7mr9156600edb.6.1698735244034; Mon, 30
 Oct 2023 23:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231030133712.2822276-1-armbru@redhat.com>
 <20231030133712.2822276-3-armbru@redhat.com>
In-Reply-To: <20231030133712.2822276-3-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Oct 2023 10:53:52 +0400
Message-ID: <CAMxuvaxy_mwut2rH0cAOaOgiRTTeBBBCKprTS4bmetHqb7C8Ww@mail.gmail.com>
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
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Oct 30, 2023 at 5:37=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> When dump_init()'s check for non-zero @length fails, dump_cleanup()
> passes null s->string_table_buf to g_array_unref(), which spews "GLib:
> g_array_unref: assertion 'array' failed" to stderr.
>
> Guard the g_array_unref().
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  dump/dump.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index a1fad17f9c..d8ea364af2 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -100,7 +100,9 @@ static int dump_cleanup(DumpState *s)
>      memory_mapping_list_free(&s->list);
>      close(s->fd);
>      g_free(s->guest_note);
> -    g_array_unref(s->string_table_buf);
> +    if (s->string_table_buf) {
> +        g_array_unref(s->string_table_buf);
> +    }

or:
g_clear_pointer(&s->string_table_buf, g_array_unref)

>      s->guest_note =3D NULL;
>      if (s->resume) {
>          if (s->detached) {
> --
> 2.41.0
>


