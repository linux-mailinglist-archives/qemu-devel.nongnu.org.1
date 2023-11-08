Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0937E50CB
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 08:07:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0cdV-0007ng-HS; Wed, 08 Nov 2023 02:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r0cdH-0007kb-A1
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 02:05:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r0cdD-0002fA-SW
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 02:05:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699427142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wvdmq0vAAAzdpbkM26Qeu0JmwfSFKZQ2jTvkARZCM6k=;
 b=Yv3Kk/EMgPQWwhKxTNVuMBOiKziZoQkAnJDkR3IPIfMg6VcayP7ZRzivnX5PwYqyJ/eYq8
 IczKWgRM07QyYAFr/OOYOp+FFCjCWyq+pOjicGdKlFrTPoLSKevioAeHjKvRYVYGhdiX89
 Bv7SK5YkQDBMWCpRN2DmcsDVggLQWg0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-ki7BD-PHMi2IkTguzjSPWQ-1; Wed, 08 Nov 2023 02:05:40 -0500
X-MC-Unique: ki7BD-PHMi2IkTguzjSPWQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-54455e2a5c8so3021722a12.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 23:05:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699427139; x=1700031939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wvdmq0vAAAzdpbkM26Qeu0JmwfSFKZQ2jTvkARZCM6k=;
 b=h/29xBjlEu3NJ2rQWd9uE467NFxgvGAvfGVmm1t7oitKyhYYhOYdXgW0xP2cTPQv02
 Ip2+GeZ+hOXQ/zhYpSyAkiRLZWnuBAmwg+UwoSnMpD+FQ9RMZWtRpaZP/b57GpItWZT9
 2hvC3za9VttqhFKDCkYg/VR7Eb3JG+l8jc1HigDYVoAUvIlHLcL5aqjwgHyHiX2BcNYi
 HQUhYrLja+2t0WtV+g8ZtC0W7qp0/Yt4ZAtc+oD5uquW905IhOpe0IFnigPnu4IS2Z5C
 9sxgf0fdyaxYRXWawJAhjlMX7pfsA8l8Xe6mEr1coRUcXl38azO5WybCCsKY9RanCgYN
 +PaQ==
X-Gm-Message-State: AOJu0YxDMBgzrh7eMfRHxsdR6ZMBzMph8LiDS+Ph0QDvsorsO/wF0BqK
 upyrYxibU201Su/h3bFrS0ZCTlupLV9vXM2zfoZf2ipPmNHdNfE/S8ihVbVUWg83wTnBHmcZ4Zn
 YonI92bg8YBW+H/PSfjbNHgz1WWAlSwk=
X-Received: by 2002:a50:bb66:0:b0:53e:7d60:58bb with SMTP id
 y93-20020a50bb66000000b0053e7d6058bbmr716320ede.27.1699427139165; 
 Tue, 07 Nov 2023 23:05:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcx40gX8LkcCwMfsCB4aATFmsvDopTAl/Yu+lH3yhvMzx7Aa7fVpXASKwHY3z/5gSwepit+ZNM4os4K4kmQ5U=
X-Received: by 2002:a50:bb66:0:b0:53e:7d60:58bb with SMTP id
 y93-20020a50bb66000000b0053e7d6058bbmr716304ede.27.1699427138832; Tue, 07 Nov
 2023 23:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20231108053731.112043-1-armbru@redhat.com>
 <20231108053731.112043-2-armbru@redhat.com>
In-Reply-To: <20231108053731.112043-2-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 8 Nov 2023 11:05:26 +0400
Message-ID: <CAMxuvaw6JyMTToERRng+beYwUjLOtbxvCBsbBT2GxqdrzKh57g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dump: Plug file descriptor leak on non-seekable file
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stephen.s.brennan@oracle.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi

On Wed, Nov 8, 2023 at 9:37=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> Fixes: e6549197f7ed (dump: Add command interface for kdump-raw formats)
> Fixes: CID 1523842
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  dump/dump.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/dump/dump.c b/dump/dump.c
> index 1c304cadfd..ad5294e853 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -2160,6 +2160,7 @@ void qmp_dump_guest_memory(bool paging, const char =
*protocol,
>          return;
>      }
>      if (kdump_raw && lseek(fd, 0, SEEK_CUR) =3D=3D (off_t) -1) {
> +        close(fd);
>          error_setg(errp, "kdump-raw formats require a seekable file");
>          return;
>      }
> --

already queued for merge in:
[PULL 75/75] dump: Add close fd on error return to avoid resource leak


