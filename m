Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8FB7F12C8
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 13:08:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r532o-0006Ob-Fe; Mon, 20 Nov 2023 07:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r532l-0006NN-Bt
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 07:06:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r532i-0004pg-VJ
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 07:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700481979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6XLWUqVklO1ML116TC66kDyGQKNcnn/uVGLPKtUhcO8=;
 b=VF+3Fp9QI7rPnL8l3zTfbwTydE8sQ6pfeKc6/jIDiw28TdQ+rB01UIz4Aatky7lDNWXUUf
 MwEEfIjHfEA0mBNXaeILpK4HvOnBZwO9i5/y8yUXPRtOEGzVJLK54j16aToM57FWqJwR4K
 C5kdPRZhrg/hLUGoLjaEwBZlhyWJcxU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-2Bd8zcJDMJqhweUo5MKymQ-1; Mon, 20 Nov 2023 07:06:17 -0500
X-MC-Unique: 2Bd8zcJDMJqhweUo5MKymQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-54366567af4so5632581a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 04:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700481977; x=1701086777;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6XLWUqVklO1ML116TC66kDyGQKNcnn/uVGLPKtUhcO8=;
 b=lF3nrZfIgw//ymDGO4499SEE8vNYM34M+VO6dj2M/QVwm6PbBBkubLPj67Mdi7iFfk
 W/m66VhcCg2picNxOpQYCykBo6OeXzx+bpb/sK/m6Mdn7gLeowbUyVSYMykrrVhLyZg0
 iZlfDTQCPyhdQhNme0y2Gx9WBU1TqpGZWxHtIIYyNzylHDkw5KtyS/9BIyOO5rvxoxys
 +TU/Z5uDbYDH5/40RN4/7OMHEyGEt7c2mX/XvOWztFDwlna3DanGviHebQz4nCDxGsRz
 QCNmXNSbcc4pQdareKh594X0xfhbyKnIdq1llsqI7FP16A3zgsoR7TDsCS8tWjrRQlc1
 VB9w==
X-Gm-Message-State: AOJu0YwIbUDc0pTftBHzDtsdKw9I+6uKS89onAIck7ijgH4//c0fQZkn
 6tYuVgxSx77u1ketdGIDj3MkoyDLM1mocCXjz3Lm/EGXX8iQ2My/vbezmjvOxxwJSHKj9wIK4di
 fQAgwPhL3CJG+Q9RPpxCoY5ZK9Rt6F08=
X-Received: by 2002:a05:6402:323:b0:53e:e623:6a47 with SMTP id
 q3-20020a056402032300b0053ee6236a47mr1748322edw.4.1700481976838; 
 Mon, 20 Nov 2023 04:06:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE1zRGfImKvZgo1TEMhAcjUccereJhicFAbMjE8/MVs4wOp4jNuIxwNait/VG8YRND+73YE4sjxvcczUGBG0g=
X-Received: by 2002:a05:6402:323:b0:53e:e623:6a47 with SMTP id
 q3-20020a056402032300b0053ee6236a47mr1748312edw.4.1700481976588; Mon, 20 Nov
 2023 04:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20231116115354.228678-1-npiggin@gmail.com>
 <20231116115354.228678-2-npiggin@gmail.com>
In-Reply-To: <20231116115354.228678-2-npiggin@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 20 Nov 2023 16:06:04 +0400
Message-ID: <CAMxuvawXTrQ3Mu-aGbELnQyBRU4W9kuMQo-XM_zm4FbRymHkqA@mail.gmail.com>
Subject: Re: [PATCH 2/3] chardev: report blocked write to chardev backend
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

On Thu, Nov 16, 2023 at 3:54=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com>=
 wrote:
>
> If a chardev socket is not read, it will eventually fill and QEMU
> can block attempting to write to it. A difficult bug in avocado
> tests where the console socket was not being read from caused this
> hang.
>
> warn if a chardev write is blocked for 100ms.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> This is not necessary for the fix but it does trigger in the
> failing avocado test without the previous patch applied. Maybe
> it would be helpful?
>
> Thanks,
> Nick
>
>  chardev/char.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 996a024c7a..7c375e3cc4 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -114,6 +114,8 @@ static int qemu_chr_write_buffer(Chardev *s,
>  {
>      ChardevClass *cc =3D CHARDEV_GET_CLASS(s);
>      int res =3D 0;
> +    int nr_retries =3D 0;
> +
>      *offset =3D 0;
>
>      qemu_mutex_lock(&s->chr_write_lock);
> @@ -126,6 +128,10 @@ static int qemu_chr_write_buffer(Chardev *s,
>              } else {
>                  g_usleep(100);
>              }
> +            if (++nr_retries =3D=3D 1000) { /* 100ms */
> +                warn_report("Chardev '%s' write blocked for > 100ms, "
> +                            "socket buffer full?", s->label);
> +            }

That shouldn't happen, the frontend should poll and only write when it
can. What is the qemu command being used here?
I think this change can be worth for debugging though.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


