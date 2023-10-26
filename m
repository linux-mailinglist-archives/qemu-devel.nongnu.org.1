Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B64E7D7E46
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:17:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvvY7-0007CW-UV; Thu, 26 Oct 2023 04:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qvvXy-0007CB-LZ
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:16:56 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qvvXw-0004CK-QF
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:16:54 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-41cbf8e1f77so4923201cf.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 01:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698308209; x=1698913009; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=62GnCP7RusF+66R1wetiy35tQ1sfJf18J6qkicsRZ1E=;
 b=XrA2hmqeJk9MzZUe6YfbMO3KYuTR8g7gxX+jX9tV96ZoGfbB6PIE2ry1ISBeoFkPVj
 J4WLnVIt5fytJFxPrGjDaET8rQpObksmsbXAXeOf1ppTGTZGxQJlcWCP5OQLfvaeEBtw
 fQJ82QdI5K5pXjXbi7XzPicySxksjHpId60hQ9XcrIpZ6/09MshBHiIgRQ50z1NBTAjO
 dSL+accDFkwdtmi1EzOEhxFjiUYEVmmoqfrug01Rq2/9cdrvlYvD/rliChSpeFl3k/l3
 9SxbOVy2soAcLaQRxoemWCXy/ah8y5h8I/PXXCdDLce4qrm3Euq+cCHs2YO7FPOLodUo
 FFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698308209; x=1698913009;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=62GnCP7RusF+66R1wetiy35tQ1sfJf18J6qkicsRZ1E=;
 b=CWli42CUxwS2kdaudsBD0m8idmJbjr/3sQSyelxXMCIbi9hWHJf+pm9xGrpxt5ZxeN
 NzJQEzTwdzOlenJNwu3eRjHZaBLheb0cbaiLrP6RlEe3pxfOEQJ3R7lZM265Jvy7ctay
 p5NngpZVxENpw8pkq/RLw1wX8o2I/p656vj1I51XGDN8hkcTJSdzcYSjhv+hf85FWnXX
 ri4XD5CHdoKL1VPlZuqm/6wVFl/UvNH9uPK5f+6s+4uPAeaDiDJphkWB8p/ta3Wo/+Qd
 vI5DaUj7sotRdDCc8aaerMNLA1kYHHzYV1eFfk6QaxDxU/jC/9ybzxiLDD1TKryj6S3L
 GJNQ==
X-Gm-Message-State: AOJu0YxQGVR6fAXcR5fQdmKgSVEQA/OfjFoh8/g72AL0r0KiXcfwbjfv
 sp7ftztmxtAZ+xpC5L+2rkDaf7uZDFi/YOgfj1l4JTqDvaU=
X-Google-Smtp-Source: AGHT+IFpAlKwVzcohZ3LhJF0lipzB0RyWTw32/ffRCY4ieieroE8J/dnzZzSvHEwkio3rKz0XTkZ/DweRaOeng2dQDM=
X-Received: by 2002:a05:622a:100f:b0:417:b545:e962 with SMTP id
 d15-20020a05622a100f00b00417b545e962mr17687235qte.7.1698308208908; Thu, 26
 Oct 2023 01:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230918233233.1431858-1-stephen.s.brennan@oracle.com>
 <CAJ+F1CLLgb=mYxf69gb+DpNQHrdOFY24Ax0eYfkVS4NxQ=NEgg@mail.gmail.com>
 <87h6mez5i1.fsf@oracle.com>
In-Reply-To: <87h6mez5i1.fsf@oracle.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 26 Oct 2023 12:16:36 +0400
Message-ID: <CAJ+F1CJuYex4vdprouSnMgUD86UZeQ7ds5zcEF9Y+OYCRNM7sA@mail.gmail.com>
Subject: Re: [PATCH v3 qemu 0/3] Allow dump-guest-memory to output standard
 kdump format
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org, 
 Omar Sandoval <osandov@osandov.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x831.google.com
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

Hi

On Thu, Oct 26, 2023 at 2:44=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
> Hello,
>
> Will this be queued for version 8.2? I see here[1] that the feature
> freeze is November 7. I'm not really familiar with QEMU development so I
> didn't know if there was a "linux-next" equivalent I could check.
>
> [1]: https://wiki.qemu.org/Planning/8.2

I'll prepare a PR.

thanks

--=20
Marc-Andr=C3=A9 Lureau

