Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C7977F8D9
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 16:27:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWdxb-0007q3-1u; Thu, 17 Aug 2023 10:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qWdxY-0007pB-TR
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:26:48 -0400
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qWdxW-00067n-6H
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:26:48 -0400
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-76cab6fe9c0so654816285a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692282405; x=1692887205;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZownqIMunb2OLPzndhbUxhNG7vc1b84XwFELRFS1IF8=;
 b=XQosjBPCYWJ8eYfR0eFLBwjmxhg6g5YGvuWGO4KiYcRG5Xdx5bY5fmReDYDpqYj7PC
 epbvBAfBAq6o9CMjT79z8PGoa9+HZilm6W7S0D1hQC4KGl+fdjUyFh8xnz+MyVLhFBKD
 d1fwX0AFOMIo7+m9TXWHvzE3PxODmWDpHGVh4dGFfd558p6dcjEjal7er5od+Je4eMKr
 vKVJop9xmX28+vhiDJ/z+T7UobWIsX6aYyJp0KAPEUGjACSoPLa7wr9tVzKPdhQ0OFOJ
 pXtz1aUwH8kRouE5D6FzD5tr27BOzDCdNZnx+aKbcrX3cUyGGMAqAV8FKjlTaehAUQcs
 Ap7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692282405; x=1692887205;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZownqIMunb2OLPzndhbUxhNG7vc1b84XwFELRFS1IF8=;
 b=h1aYAZUxr74iY4SWdwmBCEc1jC2ZlPBX3TkDeB32vOahfqu0DRu+3FrLztTWLbXpxG
 sA/ODFygv1Z5vXnKHXXFpRMDH8g9LxvVhdpFh0fZdlcwfZSXo7fD2OU0o1KtL79nIkA9
 1X/HG/o9YLpacW6XXps8MDwM18fZfmtDKdwcz82yWbyitbIbdIcy7qERsjNuvarHGfrc
 YTuGUSctrCKYewODcucVVsOBoXHw1yg44rg0zWMvLVT9tXOj5M8tvp57qHpc1x3jFeVN
 +GO8hBintSzv0MjA5yWA1/vI8fTXj600z7EdSjBzZD3iuCbgO56zJrq1mj8T9hFzgUI5
 khzQ==
X-Gm-Message-State: AOJu0Ywk2AwGvK8ufa7b2JLDrLdQ+2nrZrCv7HnFcxyYlGPFFcCLebOZ
 Y2B5dcb0MOtQykWu1iFysMq28qjOFuPCMtIMqEI=
X-Google-Smtp-Source: AGHT+IH4utKSpAKVqlC9u+I8L4Z4qzJneDfR9SrtI1W38a4jyLGMP1NLop21EDUqRh2tdMgjM8DWQc2CCiEj4r5mM0w=
X-Received: by 2002:a05:622a:1883:b0:40f:2230:efc with SMTP id
 v3-20020a05622a188300b0040f22300efcmr6224895qtc.55.1692282405201; Thu, 17 Aug
 2023 07:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692281173.git.tugy@chinatelecom.cn>
 <e7f5e172abf797d454e00a4bbe53af83e4aa4497.1692281173.git.tugy@chinatelecom.cn>
In-Reply-To: <e7f5e172abf797d454e00a4bbe53af83e4aa4497.1692281173.git.tugy@chinatelecom.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 17 Aug 2023 18:26:34 +0400
Message-ID: <CAJ+F1C+vDZisncoBpv+NqostpxUk8v2cM00qSJtgM=cOx1L=+A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ui/vdagent: Unregister input handler of mouse
 during finalization
To: tugy@chinatelecom.cn
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, dengpc12@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Aug 17, 2023 at 6:24=E2=80=AFPM <tugy@chinatelecom.cn> wrote:
>
> From: Guoyi Tu <tugy@chinatelecom.cn>
>
> Input handler resource should be released when
> VDAgentChardev object finalize
>
> Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
> Signed-off-by: dengpengcheng <dengpc12@chinatelecom.cn>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/vdagent.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index 4b9a1fb7c5..00d36a8677 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -926,6 +926,9 @@ static void vdagent_chr_fini(Object *obj)
>
>      migrate_del_blocker(vd->migration_blocker);
>      vdagent_disconnect(vd);
> +    if (vd->mouse_hs) {
> +        qemu_input_handler_unregister(vd->mouse_hs);
> +    }
>      buffer_free(&vd->outbuf);
>      error_free(vd->migration_blocker);
>  }
> --
> 2.27.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

