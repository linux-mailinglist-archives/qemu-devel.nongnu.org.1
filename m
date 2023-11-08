Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECF97E51AB
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 09:08:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0dbj-0005iB-Il; Wed, 08 Nov 2023 03:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r0dbh-0005ff-MT
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 03:08:13 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r0dbe-0006vn-UA
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 03:08:13 -0500
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-41ea8debcdaso26307561cf.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 00:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699430890; x=1700035690; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=847TtZnj/STbWnjwuk8/68HaCnVou++Ajcyk7pZkRyo=;
 b=S7D6alKtnN3aJ0vNAXIgEYY3Yb+3Z9iS8YOnor+pe2j1n6H54PbsRFVN7uK7oPXTsP
 zH8WWMyjccubLHGsENrYXXNDqZ7N0DrAuYtZAkWDg+yAvImyntgDf17fMzqugoOIUHFl
 oUz7xAZQDErnDWkBqlTmEg84D7Px/4FTeL9ymrH/V2J/BPyEKbW7Ho8M3qfkMGrxP0a/
 DyQTeZSP+BkE/xLscfZk2kThLYmx4RxCaXDRnH8Y/579nzLiktoxscltPBow5zHC9KAV
 Axzm/xudmBR2rgjVrUSatMeqGTsUxD21CXioLww3X3J45TklHyDCK7N6SRSH2DPA1Oio
 5hLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699430890; x=1700035690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=847TtZnj/STbWnjwuk8/68HaCnVou++Ajcyk7pZkRyo=;
 b=YYTZAqf5Otpz6QmQL6P/sFPe2lQwyJZqo0HtoiarBIaXoR2pAz1XPWWL3jjm0ZUpvl
 HB0BQnsV+ldAElGSc781PF5fo6DPJyMZ1lUZa2HrBfY2IhTkeW3TD8fFJ9dJHfvaqs4t
 CQKbRhrP8nnLQJzrpBBD859sVuuepSLojW8JdSZTpHig7GqcvOANzymx76scTSj3FQYu
 jGd87svM0+Xg90LYGdMqsFLjk0gARlKD2wHB1MLNf9kQ83V0fVWql8+BOG24dszDMMhz
 iDdFngcJai2QMethUiLBDIqhMpVsvDz0z7HVVD5xl6EzQh96YEeRuG8AIxzW96vHHDRu
 IZhg==
X-Gm-Message-State: AOJu0YwlOFCzpR8zYo0EO7K+l45FJ63Wd07uNR8Q9O7Lsgjmm1rUIAvs
 SzpWHPsbiJNE/kQA0O4NmEa/hhR+Vh+EeBu2I4Z6uOavWGs0HQ==
X-Google-Smtp-Source: AGHT+IHeJmHt/Y9qGaS3yXDhXYxjLe4vw3NwHB1dv4xwQNyg/RYHweTgVPmYeS5DH/Xg/lGPOzCTHDMZUBpfjFPfGaM=
X-Received: by 2002:ac8:7dc4:0:b0:418:152d:bf4 with SMTP id
 c4-20020ac87dc4000000b00418152d0bf4mr1317342qte.51.1699430889778; Wed, 08 Nov
 2023 00:08:09 -0800 (PST)
MIME-Version: 1.0
References: <20231108053731.112043-1-armbru@redhat.com>
 <20231108053731.112043-3-armbru@redhat.com>
In-Reply-To: <20231108053731.112043-3-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 8 Nov 2023 12:07:58 +0400
Message-ID: <CAJ+F1C+NCXqhwY7Sj0BZAm3G-BCexqK_Ozot6FWnwhhd+cFoSw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dump: Fix HMP dump-guest-memory -z without -R
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, stephen.s.brennan@oracle.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
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

On Wed, Nov 8, 2023 at 9:38=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
> -z without -R has no effect: the dump format remains @elf.  Fix the
> logic error so it becomes @kdump-zlib.
>
> Fixes: e6549197f7ed (dump: Add command interface for kdump-raw formats)
> Fixes: CID 1523841
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  dump/dump-hmp-cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dump/dump-hmp-cmds.c b/dump/dump-hmp-cmds.c
> index b428ec33df..d9340427c3 100644
> --- a/dump/dump-hmp-cmds.c
> +++ b/dump/dump-hmp-cmds.c
> @@ -41,7 +41,7 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict *q=
dict)
>          dump_format =3D DUMP_GUEST_MEMORY_FORMAT_WIN_DMP;
>      }
>
> -    if (zlib && raw) {
> +    if (zlib) {
>          if (raw) {
>              dump_format =3D DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_ZLIB;
>          } else {
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

