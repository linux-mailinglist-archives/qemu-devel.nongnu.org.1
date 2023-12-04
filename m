Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EBC8029E8
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 02:33:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9xpf-0001jY-Mt; Sun, 03 Dec 2023 20:33:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r9xpe-0001jP-HU
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 20:33:10 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r9xpc-0003xK-UT
 for qemu-devel@nongnu.org; Sun, 03 Dec 2023 20:33:10 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50bbb4de875so5205692e87.0
 for <qemu-devel@nongnu.org>; Sun, 03 Dec 2023 17:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701653586; x=1702258386; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jk7+Kv+Iw1BO5hM5zDSfLXcpyi9X+DmLNEZSoYTmBGc=;
 b=d4DiaV67W0e68kIaI9+kWA116TDciOyBIkTv0TEi0Of0B9sCcwfBH4OzHeNUML4Y5t
 hmPEmpnOO8N5oGH3542+gAovXh7Mcg9FIqZkaaf6kjVuFoi2STM0lX2efA4HTiw5n/SH
 F4aHGwPuhgOzxCkxQSpMips2XQaDk5GMVBnL+/G/GUjSpTnC8+WUQ4KRw1rwSNWboKQu
 3dQqMEUapJC05auhsLd3sdWVyAoIAC28B0LpaGH5uSFGG4el+qvtKlzN9a7xtk4Zl1KQ
 +unUZYKEOGpu1huA3LU1aCfKI0uqwXXFUZZd3dnZsWikFzV5SMNI3rkWm66nyCEznsFO
 knaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701653586; x=1702258386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jk7+Kv+Iw1BO5hM5zDSfLXcpyi9X+DmLNEZSoYTmBGc=;
 b=s8ClxCsm10XN7GxdadQvLuBJfsHDpEl10e8aVneRR0FaaVBrvh9vF71rIRiyxe8W0u
 CT6vi3PgRb7zK6n3SVW0g+o+14cqK8gcXlpQfVta/vs7CRZiekOMBmDdlW8j5GzcMjwd
 nzt2ErCw0EY8qGLoPBtZww8wNnTFRBoZ6uwaCuK2eg7/LgIf3sukLEeKcG88coAitj6w
 ZMQknLPAaqZFtMgb1cFc9GRs/BA1OzWeNT7DUP/j9vDDnqJrq0uzEJkoHVEEH+nXNWyB
 94HIAwr/Hug0SnMWnkIs9lqcXZ2YhN+Y38lYjEtr50Trwze4Pf9JhpvfDa57oYwcUORH
 lJ3A==
X-Gm-Message-State: AOJu0YxCdgpsG7P8yk3oPOUcohjfTxR122XiX8YwFIYYyjZx3GaD4NYU
 IUENeoW6VqrMJOSpTd9pKlXULQLebL7WHF8ldMc=
X-Google-Smtp-Source: AGHT+IFEwjkW44hNmiGx0599EVyXw8W7fF5EBZeBDpSuO6B/dxy6Bi4KzhbI4/eNVkZGqfv6SefxpSRzk7bOq+fpCqQ=
X-Received: by 2002:a05:6512:50c:b0:50b:e4ba:b07d with SMTP id
 o12-20020a056512050c00b0050be4bab07dmr1016034lfb.75.1701653585982; Sun, 03
 Dec 2023 17:33:05 -0800 (PST)
MIME-Version: 1.0
References: <20231122053800.1531799-1-alistair.francis@wdc.com>
 <cea2dbdc-6bb2-4380-ac85-466f61fdd545@tls.msk.ru>
In-Reply-To: <cea2dbdc-6bb2-4380-ac85-466f61fdd545@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 4 Dec 2023 11:32:38 +1000
Message-ID: <CAKmqyKMPxO8U5ZaZ8bthPa5e6CdydKVvfbr6GDtowQocvgeNUQ@mail.gmail.com>
Subject: Re: [PULL 0/6] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=alistair23@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Nov 26, 2023 at 7:08=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 22.11.2023 08:37, Alistair Francis wrote:
> ..> ----------------------------------------------------------------
> > Fourth RISC-V PR for 8.2
> >
> > This is a few bug fixes for the 8.2 release
> >
> > * Add Zicboz block size to hwprobe
> > * Creat the virt machine FDT before machine init is complete
> > * Don't verify ISA compatibility for zicntr and zihpm
> > * Fix SiFive E CLINT clock frequency
> > * Fix invalid exception on MMU translation stage
> > * Fix mxr bit behavior
>
>  From this list, is there anything which is not suitable for stable?
> It seems all 6 changes should be picked for stable (8.1 and some
> even for 7.2).  Maybe only "ISA compatibility for zicntr and zihpm"
> should be omitted?

These should all be fine for backporting. Sorry for the delay, I've
been sick for the last week

Alistair

>
> Thanks!
>
> /mjt

