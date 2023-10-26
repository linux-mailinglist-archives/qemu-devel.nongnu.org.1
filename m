Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC1F7D8690
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 18:16:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw31q-000879-Fd; Thu, 26 Oct 2023 12:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanmaynpatil105@gmail.com>)
 id 1qw31l-00085v-S7
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 12:16:09 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanmaynpatil105@gmail.com>)
 id 1qw31k-0003Fy-2m
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 12:16:09 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9be02fcf268so166714566b.3
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 09:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698336966; x=1698941766; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w68RtcZBaMYpoQ9tYqTi4yu4vAhC8iUIu9yVJgNFtQk=;
 b=iy5u33WFrN+rjE5ibltx82K+68alao39tTB/CDB/sEbwMUtzIc3RIn2mjBb9ak35SC
 WbrHSnIFV/jf98Uj6uKKFZGMbmcmHqaWea7qWm5tnKxwlVw4dOgwLOF191g646MalwV9
 0B0hx+AmdXjSQrMQ1+LVviqWD9lg2mNdft/20I+gEr4t18cmrSh0ZfxV2UCz6foOVU4G
 bfDBcU4TGJl4PZxhAcWvgU7QTtPT6Jz2F82BIRNT7sPiF4FBgurtbhFiofhYf91QOC/a
 VIEYHymoeHQWLrEGbQRLoHVtANikK4peDwLSA9l+IdUWiqo0EGzjwBw58ePOAp7jauAA
 xFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698336966; x=1698941766;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w68RtcZBaMYpoQ9tYqTi4yu4vAhC8iUIu9yVJgNFtQk=;
 b=oa9uq+dTB9mpYv/V5oFVCy6H/MFlLsj8wb2g8lgSZWtzvTWgi82V3C7eECGdw332bg
 1duIFXe9LADuvwjSlHjSYNrXbXq4NzgfqeWoHS5xKwedMYl8wwd00e7YG8wLYlc4w6Jd
 MVmsuQ7Tg4Tfd3/9j5hF66dGtPS/lLvlpBqbyWqA5EjF4hUenGPpBCMn9kXQ34fEzMME
 /frxMU7JFvbkGpG2IWjAZTHAtU/QGjbtKslbdcr2O/82kVm78cUDN8u3Lb2rpcR+u9Wg
 7bizi2eMbL/kZcKmN7OQfw8YGdGb2hyT63JMhpBarxj7Kujh+dqHEVvtLzNoZapdwrwI
 fpAg==
X-Gm-Message-State: AOJu0YxWfZaiC7FqclfnbavWmd0Cjt4y2X5FsikwKb+JpqZLIDMC7Dy6
 zgUFHCoErBzMrBWu8koTJYb5oTTgoAEimRF7ew1qCpU04zstVQ==
X-Google-Smtp-Source: AGHT+IEcPv3j7DC9NUF5fvExpBJAsD6S9nydToMIxgttdReWJZjDmdy7yHKWn0fna95gudb7DVi7zt0hI2bugmcsYso=
X-Received: by 2002:a17:907:2d2b:b0:9b2:a7db:9662 with SMTP id
 gs43-20020a1709072d2b00b009b2a7db9662mr166203ejc.12.1698336965562; Thu, 26
 Oct 2023 09:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHnsOnP-8PY=pZw3n2jPKeMmiFqsQwp-Dai+dADpe+hskO2kQA@mail.gmail.com>
In-Reply-To: <CAHnsOnP-8PY=pZw3n2jPKeMmiFqsQwp-Dai+dADpe+hskO2kQA@mail.gmail.com>
From: Tanmay <tanmaynpatil105@gmail.com>
Date: Thu, 26 Oct 2023 21:45:54 +0530
Message-ID: <CAHnsOnOjFJ2269nQPmBL1krBSy0Li5fjQjeU2NmHk2-aFPKxVg@mail.gmail.com>
Subject: Re: Replace calls to functions named cpu_physical_memory_* with
 address_space_*.
To: qemu-devel@nongnu.org
Cc: "jsnow@redhat.com" <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008a969b0608a0e39a"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=tanmaynpatil105@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--0000000000008a969b0608a0e39a
Content-Type: text/plain; charset="UTF-8"

Hi,

The above refactoring of functions was mentioned under API conversion at
https://wiki.qemu.org/Contribute/BiteSizedTasks .

Thanks,
Tanmay Patil

On Thu, 26 Oct 2023 at 15:54, Tanmay <tanmaynpatil105@gmail.com> wrote:

> Hi,
>
> I'm really interested in contributing to qemu. I wanted to work on the
> renaming API calls cpu_physical_memory_* to address_space_*. I couldn't
> find any related issues on the GItlab tracker. Can I work on this issue?
>
> Thanks,
> Tanmay Patil
>

--0000000000008a969b0608a0e39a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>The above refactoring of functions was mentione=
d under API conversion at=C2=A0<a href=3D"https://wiki.qemu.org/Contribute/=
BiteSizedTasks">https://wiki.qemu.org/Contribute/BiteSizedTasks</a> .<br><b=
r>Thanks,<div>Tanmay Patil</div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Thu, 26 Oct 2023 at 15:54, Tanmay &lt;<a=
 href=3D"mailto:tanmaynpatil105@gmail.com">tanmaynpatil105@gmail.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div di=
r=3D"ltr">Hi,<div><br></div><div>I&#39;m really interested in contributing =
to qemu. I wanted to work on the renaming API calls cpu_physical_memory_* t=
o address_space_*. I couldn&#39;t find any related issues on the GItlab tra=
cker. Can I work on this issue?<br><br>Thanks,<br>Tanmay Patil</div></div>
</blockquote></div>

--0000000000008a969b0608a0e39a--

