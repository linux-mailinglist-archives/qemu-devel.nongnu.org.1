Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0613707432
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 23:27:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzOfN-0002Fl-02; Wed, 17 May 2023 17:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzOfL-0002Fd-Dz
 for qemu-devel@nongnu.org; Wed, 17 May 2023 17:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzOfH-00015O-J6
 for qemu-devel@nongnu.org; Wed, 17 May 2023 17:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684358790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ckfguxV11jLGFMsfJ7ffg4yBHuOa1JEDjq1sB4aAb80=;
 b=O4M9jxTWjV2WE3FmYAtUi641vxN2J74v1QcKvpRVmdEU7Gyd5KqzOBvYoVv35vkRhALjtp
 FcJhWi/3TOjcxOSINgPQ+oWiWc8IsDdVxfL716cT8QQ6iWz4J4wdMaEf6KP/HoKF6jvnvY
 XFn/3MAXIErQCCBSaG1Et1k8Zu5f7Qg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-jgVjto74Ps6kpI0foIvCow-1; Wed, 17 May 2023 17:26:29 -0400
X-MC-Unique: jgVjto74Ps6kpI0foIvCow-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1aaf311e517so2580325ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 14:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684358788; x=1686950788;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ckfguxV11jLGFMsfJ7ffg4yBHuOa1JEDjq1sB4aAb80=;
 b=Sp9wDfXDS4RabBKejKIn0MSuhJHMr9BBYmyJiFKKPHmq3SqbJyqxhVarZQGqgpu0iO
 rUJMEbXlClVA+edcpNNdi6sZN6uA9rEKhmzBWWk6guCOee9QvMyfyCT2W/xpfgUcEuUt
 t1n+aJYJhB/8QUVQvrtKHhG2zPP2+Fm4RQ3DqBToj0eF2jHN7cUc/8XeqAMYuc4zK3mt
 3QVDcbFneBoah8X/ndqtvettOzL0Brc/Hk4Mnr8cHSzyBg97e8KjNQGMrtuAVsgNYamz
 NbFoGu6DH2VUUWU/jZG6mGpg1UE6GVC6aSZ+1XyPLLqV9QnPAoyJJZQPn7KAxgE4QUcu
 2c9A==
X-Gm-Message-State: AC+VfDw4dtvQUeL8CoNq6FZ+qGqnTRzZyRRUzah1rozNHLwpdvdeRxFo
 7AY5F9+WsEj5DyMmC5F1DbRzkt7QyWlF4TS7SyJWiKlHnoutpWl0YxLaf9mUp6/JDqq60orZB9H
 qYhnt6jcZMzegbtcvEIRrwI+LsylaubY=
X-Received: by 2002:a17:90a:bd94:b0:23f:962e:825d with SMTP id
 z20-20020a17090abd9400b0023f962e825dmr29561pjr.1.1684358788373; 
 Wed, 17 May 2023 14:26:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/2dsbo5P5gOSPb5i9CgIJWJe5AgV+0bUqbEAX4QGeJwUeTxkaKkBqm/TFTrfm3hgi/MORl8QU6z+8WxQh1YQ=
X-Received: by 2002:a17:90a:bd94:b0:23f:962e:825d with SMTP id
 z20-20020a17090abd9400b0023f962e825dmr29547pjr.1.1684358788092; Wed, 17 May
 2023 14:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230428132124.670840-1-nks@flawful.org>
 <20230428132124.670840-10-nks@flawful.org>
In-Reply-To: <20230428132124.670840-10-nks@flawful.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 17 May 2023 17:26:17 -0400
Message-ID: <CAFn=p-YXdRWF4gd1sP=ZJHv-fvqwckVQsuKD5aVgtEM90WYzkA@mail.gmail.com>
Subject: Re: [PATCH 9/9] hw/ide/ahci: fix broken SError handling
To: Niklas Cassel <nks@flawful.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Apr 28, 2023 at 9:23=E2=80=AFAM Niklas Cassel <nks@flawful.org> wro=
te:
>
> From: Niklas Cassel <niklas.cassel@wdc.com>
>
> When encountering an NCQ error, you should not write the NCQ tag to the
> SError register. This is completely wrong.

Mea culpa ... !

>
> The SError register has a clear definition, where each bit represents a
> different error, see PxSERR definition in AHCI 1.3.1.
>
> If we write a random value (like the NCQ tag) in SError, e.g. Linux will
> read SError, and will trigger arbitrary error handling depending on the
> NCQ tag that happened to be executing.
>
> In case of success, ncq_cb() will call ncq_finish().
> In case of error, ncq_cb() will call ncq_err() (which will clear
> ncq_tfs->used), and then call ncq_finish(), thus using ncq_tfs->used is
> sufficient to tell if finished should get set or not.
>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

The bulk of this series looks good, I think I'd be happy to take it,
the commit messages are extremely well written so if a regression
happens to surface, we'll be able to track down what went awry.

Want to rebase and resend it?

--js

> ---
>  hw/ide/ahci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 4950d3575e..09a14408e3 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1011,7 +1011,6 @@ static void ncq_err(NCQTransferState *ncq_tfs)
>
>      ide_state->error =3D ABRT_ERR;
>      ide_state->status =3D READY_STAT | ERR_STAT;
> -    ncq_tfs->drive->port_regs.scr_err |=3D (1 << ncq_tfs->tag);
>      qemu_sglist_destroy(&ncq_tfs->sglist);
>      ncq_tfs->used =3D 0;
>  }
> @@ -1021,7 +1020,7 @@ static void ncq_finish(NCQTransferState *ncq_tfs)
>      /* If we didn't error out, set our finished bit. Errored commands
>       * do not get a bit set for the SDB FIS ACT register, nor do they
>       * clear the outstanding bit in scr_act (PxSACT). */
> -    if (!(ncq_tfs->drive->port_regs.scr_err & (1 << ncq_tfs->tag))) {
> +    if (ncq_tfs->used) {
>          ncq_tfs->drive->finished |=3D (1 << ncq_tfs->tag);
>      }
>
> --
> 2.40.0
>


