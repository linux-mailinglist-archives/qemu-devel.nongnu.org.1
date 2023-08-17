Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 326D377F8D8
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 16:27:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWdxR-0007j2-M1; Thu, 17 Aug 2023 10:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qWdxP-0007gg-KP
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:26:39 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qWdxN-000667-Fw
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:26:39 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-4103cec468fso35195231cf.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 07:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692282396; x=1692887196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvFFvzsOt/Ve5KaE+Q7tUyags5tk8Ti2HgwMZ3I2yLY=;
 b=A2zM5I3Fg262+A9gb6wXaUVSFv3EmJYVEZUaQscK0MCl8CiC60GcTvfSmrhg41MFTc
 8tLgEJ8nxQwIVSvRqEZqpqI9WrwrJuBNCzImCD5pjQ/DV38SOqxg0Q4j8jzvz8VEZWsp
 fcd3A+94tH96u/i69ECtZmwvWOHBcETpQMTYbguypjl+YKC3wcvZobMxGlAsTKPXh/fE
 QU2OmnlU4atShFQdE88xHQHYtGkA48xI6nfP07gWoloSrlHiaRlLsG92u6Q5YeFA0m/P
 4mtfsn43rVBXrvBs3bmYKVZJepBTyd6kVKFvlfWH8INajuH5KdTdOCaA5gY4fO2If4U0
 kchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692282396; x=1692887196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gvFFvzsOt/Ve5KaE+Q7tUyags5tk8Ti2HgwMZ3I2yLY=;
 b=i+376Gfyy6Kh3iX8lGNsvIuEvWr78PA5hJ+CqRVKHFJ9BGeXxSghsEs2vFoh8EnDcQ
 QTxz0KZKh7IpWEbvdlXtlwWU+zcxPbwUZJlneOizZ4BxqBn/sjmi4zcFFkwtLdLHeWF8
 oOA4mBsbWRv4tE/xldcUNF5O5KwlhnbfuzPUgO+hcLbGKZDGcGfNwt+lS0+aCJjj5NxZ
 K2GQsuP3iRxFiR41+INy8jM1KQk8/8hN8XauMXbP2H9fbzKr+s7uPIk/fGwqleuhsyGU
 al8IwIj5c3kxKyoeAAl+MsuoSf6ArvIw4GGt4NAiuwsA9QKn30x6jXLeV4SZ9avrwM+0
 VWeQ==
X-Gm-Message-State: AOJu0YwrS+aIwJGyb3RDW6gwYLl7qlB5w4NZjAfPJtnEO6xzgZgqwwDE
 ztb9W73Cb57s2EtPS6xyudJ8c+/Evzm4ZO4clRs=
X-Google-Smtp-Source: AGHT+IFhq241i5a2dYbUPNe6DUxEolVai3wur0tnpE0wdwwc7VLyNjxadGYVM2LbUxlUQPecdBtIDjmwlAiFqeXm9Ns=
X-Received: by 2002:a05:622a:1210:b0:403:e895:155b with SMTP id
 y16-20020a05622a121000b00403e895155bmr6586951qtx.34.1692282396369; Thu, 17
 Aug 2023 07:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692281173.git.tugy@chinatelecom.cn>
 <71fd5a58fd09f10cdb35f167b2edb5669300116e.1692281173.git.tugy@chinatelecom.cn>
In-Reply-To: <71fd5a58fd09f10cdb35f167b2edb5669300116e.1692281173.git.tugy@chinatelecom.cn>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 17 Aug 2023 18:26:25 +0400
Message-ID: <CAJ+F1C+PtGHKqYTHe7tgf7cnVDK-eYXW_b=Ja=RCk-M2qRr5FQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ui/vdagent: call vdagent_disconnect() when agent
 connection is lost
To: tugy@chinatelecom.cn
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, dengpc12@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
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
> when the agent connection is lost, the input handler of the mouse
> doesn't deactivate, which results in unresponsive mouse events in
> VNC windows.
>
> To fix this issue, call vdagent_disconnect() to reset the state
> each time the frontend disconncect
>
> Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
> Signed-off-by: dengpengcheng <dengpc12@chinatelecom.cn>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  ui/vdagent.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/ui/vdagent.c b/ui/vdagent.c
> index 8a651492f0..4b9a1fb7c5 100644
> --- a/ui/vdagent.c
> +++ b/ui/vdagent.c
> @@ -870,8 +870,11 @@ static void vdagent_disconnect(VDAgentChardev *vd)
>
>  static void vdagent_chr_set_fe_open(struct Chardev *chr, int fe_open)
>  {
> +    VDAgentChardev *vd =3D QEMU_VDAGENT_CHARDEV(chr);
> +
>      if (!fe_open) {
>          trace_vdagent_close();
> +        vdagent_disconnect(vd);
>          /* To reset_serial, we CLOSED our side. Make sure the other end =
knows we
>           * are ready again. */
>          qemu_chr_be_event(chr, CHR_EVENT_OPENED);
> --
> 2.27.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

