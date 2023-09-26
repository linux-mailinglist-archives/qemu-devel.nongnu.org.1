Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 940127AE355
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 03:28:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkwr4-0001WI-TD; Mon, 25 Sep 2023 21:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qkwr2-0001Vv-9D
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 21:27:12 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qkwr0-0008Ti-Oa
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 21:27:12 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7ae0da3a692so37553241.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 18:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695691629; x=1696296429; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/SzKsgUxR7Pe1FKskKl1D+vE0ZLnO3slcIoAy6gY6g=;
 b=GC66kK1SUxhboRFmt2ROG8pWuQOQ/I7VwP961XwrNEo2rApOCK/QmG+jbq8yrYuFD0
 q3/ethsqnH0fIPZHl3opr1ftPW95upIVf+C2TjBGWjVU639CEECP0WpA8IHxnh+DjgSQ
 qs99K1XuAtwy9/G8m43r8aClrhIYt4TKJz8v8PvXQCleY8FBsG7nKjIH3bCvSKARbiDT
 vMPXZtOQmBNlJEsHsn0q3JubOXmyy2ZjeVQgHUbj3WL9xAN25YPIMiOyLtAiL26WLya/
 sF2CtCp97HodrWn+3tQ243JioXnnBvLOdYEQBNibzp28pHvFU3t9U402kHF6pPao3Bp5
 Hu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695691629; x=1696296429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/SzKsgUxR7Pe1FKskKl1D+vE0ZLnO3slcIoAy6gY6g=;
 b=Pl1W8ZyIyFjx+ZlsBmykIFMb39SjPIWF5Tl6lHjtjGifO///G1R6/AtRQhishilh2k
 jgMLDJeHyuyYPqdNAv2QfmWsr27xqpBSSMwVKmJaHo0XKHY18hhZ0FWykZAuuvDKj6tt
 95kBXeyAY6XhklnvPjDS7X0zp/pH4NOn4/+hCXKa7pdI+vbVx9yIvGK3cpnmDqFlba2F
 XBHhJ9yNjc4R+NiwdoENpUXDKMJDimN5cBTWGDjFg+JMdAXPWq9UotnU1nhxEc/nixrp
 d7EmltUzgmwxy6c+40hlxB0yy8SP1hePg6kkvVMoqsB7UdhI59ubHFjJQKg9eEvQpxtR
 jcZw==
X-Gm-Message-State: AOJu0Yzu7mwfRl94LOUSTKZ783xLLVnuh8HK6D7Xit5ysSSU24i6Wpvp
 SGDYyK/+KDNrF0eY/+YUtvbKvwMHphu50FcnV+w=
X-Google-Smtp-Source: AGHT+IGzJBuVXqYVeCijxKW0NvQ746k5wvtidoPctCQZfWdg2hwS40aLLcnJEuXiVG2K0w9OjaaBVjc4ZLN30bwpQ1I=
X-Received: by 2002:a05:6102:2450:b0:452:81b3:4b07 with SMTP id
 g16-20020a056102245000b0045281b34b07mr4170305vss.17.1695691629488; Mon, 25
 Sep 2023 18:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-6-vsementsov@yandex-team.ru>
In-Reply-To: <20230925194040.68592-6-vsementsov@yandex-team.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 Sep 2023 11:26:42 +1000
Message-ID: <CAKmqyKM6_2uxa7q9XmRZA8e6dc7D3rmZGW2yPt8c9andOR4hCQ@mail.gmail.com>
Subject: Re: [PATCH 05/12] device_tree: qmp_dumpdtb(): stronger assertion
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 Alistair Francis <alistair.francis@wdc.com>,
 David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 26, 2023 at 6:42=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Coverity mark this size, got from the buffer as untrasted value, it's

s/untrasted/untrusted/g

> not good to use it as length when writing to file. Make the assertion
> more strict to also check upper bound.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  softmmu/device_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/softmmu/device_tree.c b/softmmu/device_tree.c
> index 30aa3aea9f..adc4236e21 100644
> --- a/softmmu/device_tree.c
> +++ b/softmmu/device_tree.c
> @@ -660,7 +660,7 @@ void qmp_dumpdtb(const char *filename, Error **errp)
>
>      size =3D fdt_totalsize(current_machine->fdt);
>
> -    g_assert(size > 0);
> +    g_assert(size > 0 && size <=3D FDT_MAX_SIZE);
>
>      if (!g_file_set_contents(filename, current_machine->fdt, size, &err)=
) {
>          error_setg(errp, "Error saving FDT to file %s: %s",
> --
> 2.34.1
>
>

