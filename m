Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0EA7E3B5C
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 12:56:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Kfy-0001jS-Dh; Tue, 07 Nov 2023 06:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r0Kfq-0001gi-NW
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:55:15 -0500
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r0Kfo-0006Dd-Un
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:55:14 -0500
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-4abf8ba3e4fso1614095e0c.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 03:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699358110; x=1699962910; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxYUxGtFft/A/3qe+huwKZes40u0tV40jp/IW3/y1BE=;
 b=lGYDgfxRzFliQ78nCeZWrYbQxIr1w1tkDeny1oORQZ4NMEwW++BfXswdSsBZhIAMkr
 9QkqmSeIrKCdSJCEJV+0bsRj86oK1mAablm2wW2a+i/ZTEe+qlxqzHe6pXu/slyC+UN5
 f/HCzyb9jCb5ENM77XrwLIwDdk/7iK+GRHL92QcUKyqbtKGDzTF9w/xqO7Os85gzL1ua
 URGNUJnk+F/1B+AFIewlT7Qa6FmrLANXchyKHJvKezldbTjtbVRgqtrk6Qx8JbypfyT2
 5lI/QCKGSkG9lfpValsI6IsBD9Hnr8t1G3/BFrykJcJJwkfnFZprSERB7nWrT1mSSP2L
 jhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699358110; x=1699962910;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mxYUxGtFft/A/3qe+huwKZes40u0tV40jp/IW3/y1BE=;
 b=olclcCrieYslG+Sc00ga7++oCJrjXUk8ePWFak49elyrusH8j2n2EbUv2bZkY9fQjN
 plPvsbboZ+FnC5tW7lkYyVS83xVEf+4ICk6lfLbuUAMHPwx8FYduEcST20I4J5LlboRG
 vMbBZKdnFZB9MlyyNae8aqmiUHHSPtFKjDHc+7YweJnUEXJ9fQS5rJlj71mp2Sl97dr6
 WadMlXdKCCDgTsQRfNAaU8EOz3JEH2dOT+SWQfE+KWQ9/SUCp/RkZNfr5liJPtlAbqfs
 XelZdiX8HBm6jblVTs1LGWW/84kDjnJbiBLQGr4sY1fXQCOygDjG5wCW0uXSvQA6kZTU
 H7IA==
X-Gm-Message-State: AOJu0YxENOMZFXZWlnxweKFFtiNb6fpB8Jydaf1sLmQRdcnz5nzOBwqv
 bCm93vbGv+uksitj5PQSfRzCdzOyp+b2t7GmL3k=
X-Google-Smtp-Source: AGHT+IHaLXITv0gjfMHZsRALIhiJeeJuk20ih4HDGjKdzfejFAiPjCSflwwdo7AmKaHV4BMpqYbPCjIedR8dtsUBCS4=
X-Received: by 2002:a67:ab48:0:b0:45d:92e7:76d9 with SMTP id
 k8-20020a67ab48000000b0045d92e776d9mr10015086vsh.21.1699358109810; Tue, 07
 Nov 2023 03:55:09 -0800 (PST)
MIME-Version: 1.0
References: <20231107024417.585475-1-min_halo@163.com>
 <21eb4e0e-9828-4288-808e-a9ae3b2d417e@linaro.org>
In-Reply-To: <21eb4e0e-9828-4288-808e-a9ae3b2d417e@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 Nov 2023 15:54:58 +0400
Message-ID: <CAJ+F1CL1kj=yhuRNCLB_wQddR+qb+ZFk_SS4OZKd12ku9=3tfA@mail.gmail.com>
Subject: Re: [PATCH] dump:Add close fd on error return to avoid resource leak
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Zongmin Zhou <min_halo@163.com>, qemu-devel@nongnu.org, 
 Zongmin Zhou <zhouzongmin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-vk1-xa36.google.com
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

On Tue, Nov 7, 2023 at 3:48=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 7/11/23 03:44, Zongmin Zhou wrote:
> > Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
> > ---
> >   dump/dump.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/dump/dump.c b/dump/dump.c
> > index 1c304cadfd..ad5294e853 100644
> > --- a/dump/dump.c
> > +++ b/dump/dump.c
> > @@ -2160,6 +2160,7 @@ void qmp_dump_guest_memory(bool paging, const cha=
r *protocol,
> >           return;
> >       }
> >       if (kdump_raw && lseek(fd, 0, SEEK_CUR) =3D=3D (off_t) -1) {
> > +        close(fd);
> >           error_setg(errp, "kdump-raw formats require a seekable file")=
;
> >           return;
> >       }
>
> Since I'm preparing a PR, I'm queuing this patch, thanks!
>

ack, thanks

--=20
Marc-Andr=C3=A9 Lureau

