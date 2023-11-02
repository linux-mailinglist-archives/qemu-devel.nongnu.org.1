Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A55767DED02
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 07:59:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyReE-0005xq-Cz; Thu, 02 Nov 2023 02:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1qyReA-0005xP-7R
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 02:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1qyRe8-000567-LN
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 02:57:41 -0400
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-sp9s8s3sO3m4sdBGhRW0kQ-1; Thu, 02 Nov 2023 02:57:37 -0400
X-MC-Unique: sp9s8s3sO3m4sdBGhRW0kQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c5161838d8so5693401fa.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 23:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698908256; x=1699513056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3M0XG6ioQ4Qv0Wqab4rvarpRja8on2E/7dEMS36aHYA=;
 b=MtgZC9gEUX+FCdTBCilZY2oxaE8mhSzlzJKCBqccwFtAa1Q+x7ufcVz/CN6EUeRF6W
 q3z85TeR/PlA9SE7nGUpBlhmYMJRzEL5dhexxLOpO0D5wj6jriP6sQmEFK4BoSqzTcgP
 EhY+CCZh9MYjdoG+elHwQ3X7izmFEHmCZgjNLRUx2cTbfr+8kxMTqZ3AuxYTcrXdXc7t
 u5qcgoHZ7Y+zEDHava0biucAMfSL/Z+5bDRUa1EE1CEnNxSsGKzQ9jTDSeKzJU2AipZY
 89Ku/19g5oYiJdCXIWSEQ/JTGsi5EqMGYNK9IMtJhsmxasGWgYGRN8I9k8XeEveFkWO6
 icsw==
X-Gm-Message-State: AOJu0YzIa5lxyZcku7bMbdYH5920Vm7hrvCEw7dPPbesqsDk5qMwpbhK
 rTsaHWQng5cZGhMq9mkeiAFE+ICSrhWk6hdlFPifAz1E3cNFW0PETA1mppzE/YsTKc8FNkQsSf4
 Xb2BXkHowdVCVouLyGZJuYuRpsWA2/3U=
X-Received: by 2002:a2e:2e12:0:b0:2c5:582:fd8d with SMTP id
 u18-20020a2e2e12000000b002c50582fd8dmr14527793lju.30.1698908255986; 
 Wed, 01 Nov 2023 23:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjGUGq4HX6AGV/XOHNuofy+bKxnTQZM92ieNgaIuuFZH/E8BZkhtp7SnVh0+g4H+OGx24JeP1dpFb0X3ciqSE=
X-Received: by 2002:a2e:2e12:0:b0:2c5:582:fd8d with SMTP id
 u18-20020a2e2e12000000b002c50582fd8dmr14527781lju.30.1698908255662; Wed, 01
 Nov 2023 23:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231031111059.3407803-1-armbru@redhat.com>
 <20231031111059.3407803-7-armbru@redhat.com>
In-Reply-To: <20231031111059.3407803-7-armbru@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Thu, 2 Nov 2023 07:57:24 +0100
Message-ID: <CAMXpfWvtFyaHWW19YQs0LwLCByq9BP+LR1VfxLZeyto_UZxDNA@mail.gmail.com>
Subject: Re: [PATCH 6/7] balloon: Fix a misleading error message
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, npiggin@gmail.com, 
 danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au, 
 harshpb@linux.ibm.com, dave@treblig.org, jasowang@redhat.com, 
 michael.roth@amd.com, kkostiuk@redhat.com, mst@redhat.com, david@redhat.com, 
 kraxel@redhat.com, marcandre.lureau@redhat.com, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This patch has been successfully tested by QE. Start a VM with a
virtio-balloon device and resize it to an invalid value. Check in the
expected error message that now makes reference to 'value' instead of
'target'.

Tested-by: Mario Casquero <mcasquer@redhat.com>

On Tue, Oct 31, 2023 at 12:12=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> The error message
>
>     {"execute": "balloon", "arguments":{"value": -1}}
>     {"error": {"class": "GenericError", "desc": "Parameter 'target' expec=
ts a size"}}
>
> points to 'target' instead of 'value'.  Fix:
>
>     {"error": {"class": "GenericError", "desc": "Parameter 'value' expect=
s a size"}}
>
> Root cause: qmp_balloon()'s parameter is named @target.  Rename it to
> @value to match the QAPI schema.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  system/balloon.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/system/balloon.c b/system/balloon.c
> index e0e8969a4b..fda7af832e 100644
> --- a/system/balloon.c
> +++ b/system/balloon.c
> @@ -90,17 +90,17 @@ BalloonInfo *qmp_query_balloon(Error **errp)
>      return info;
>  }
>
> -void qmp_balloon(int64_t target, Error **errp)
> +void qmp_balloon(int64_t value, Error **errp)
>  {
>      if (!have_balloon(errp)) {
>          return;
>      }
>
> -    if (target <=3D 0) {
> -        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "target", "a size=
");
> +    if (value <=3D 0) {
> +        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "value", "a size"=
);
>          return;
>      }
>
> -    trace_balloon_event(balloon_opaque, target);
> -    balloon_event_fn(balloon_opaque, target);
> +    trace_balloon_event(balloon_opaque, value);
> +    balloon_event_fn(balloon_opaque, value);
>  }
> --
> 2.41.0
>
>


