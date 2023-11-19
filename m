Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D17FC7F0864
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 19:54:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4mvt-0001Y2-Ma; Sun, 19 Nov 2023 13:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r4mvr-0001XV-Gi
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 13:54:11 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r4mvq-0003zD-1p
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 13:54:11 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1f4e17c1edfso2127284fac.0
 for <qemu-devel@nongnu.org>; Sun, 19 Nov 2023 10:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700420048; x=1701024848; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qa5oM3yTig0cJ2VRlfTAOL9mObbfkuL2y2jzn0LIBec=;
 b=S+gCbIbM/6rJVDxxt0UuwGFF2OoAfKAz72TVmmZ1ueO6vSYnmmn1WmwUsREvG+vzYf
 /hBTJa2hvGR4CHXON/O0j6Hqgz3tTvsH307jBNK/c8sBN0gvctp6xdJDC/GUog9bhxWh
 cu056DlR8ID0ZeLcJOalD3xn4sv9zNBb5LHiD0FNH3GGqDOf5i6pTOuhHdZg1WmKVe99
 b4qc0hYu7krhYh1Kh8bYpJPtnv8BfRabgIrK+xVZ17FCB0ydcN/S3KLuGkIw5iUxjSTr
 f48qbCtoFN/vk0N8L3I6ip61l/1cLEhbLfvr6CfHRzi8MSxtPD0i/xuG1kKTQJNwZD5/
 rVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700420048; x=1701024848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qa5oM3yTig0cJ2VRlfTAOL9mObbfkuL2y2jzn0LIBec=;
 b=gHr7I/uR2cQGfeWBW5sELYyDUa08s+m+1biSyxhQlDn6pFxqUlauNgIgpzoe17GGJq
 NYXW5VjU81c3YRIU4bE2kOgOQg+4IavtujmBjgiQhuvLFjgxgNXcCKvLAS9oem4SsL7p
 C92Wx34qDjuaI+qwtwGF8UwFQVmzYuGzpcy10PFgm2z5Nk98Oci31zWs6BJvDaNxpjZ8
 C5n0RcpjmDNaYPpCUrxtiFCz89VYn9r/6fAvQK8nM8k+UKBXjAMvaxELsBTRWoeAK+qI
 b4Ql8IkbR2sby3BSGu8GjLFP96n68tsx9jCZO4XiiHRrZzjP2DEpwQMYOZdk2RPf06Cq
 7IwA==
X-Gm-Message-State: AOJu0YzjjFrxRIl9tt7UUlXu/1utfc77X0KUf3PfEClykJoe211eUJJP
 4ogb//SdMNgznsbmimNZ6M1NA8DUpwRI8XWa1G80WKZE
X-Google-Smtp-Source: AGHT+IGN2KJ4H0K/eHdepMyU6ECyZmq5llQId4gPfuPuLrKxRvvD4r1ur4r7xuQNvHGiK3wx/1poUzlfuDYJL/CLMVA=
X-Received: by 2002:a05:6870:2c87:b0:1ef:b8c2:5541 with SMTP id
 oh7-20020a0568702c8700b001efb8c25541mr6869896oab.47.1700420048277; Sun, 19
 Nov 2023 10:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20231119185138.838278-1-jcmvbkbc@gmail.com>
In-Reply-To: <20231119185138.838278-1-jcmvbkbc@gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 19 Nov 2023 10:53:57 -0800
Message-ID: <CAMo8BfLz2NX5aiPnhTh2sQNADiCr7kZeJrqt5kmpLVkAJGkKow@mail.gmail.com>
Subject: Re: [PULL] target/xtensa fixes for v8.2
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Sun, Nov 19, 2023 at 10:52=E2=80=AFAM Max Filippov <jcmvbkbc@gmail.com> =
wrote:
>
> The following changes since commit b411438aa4ecaf4bbde90e20283e5899fec10f=
58:
>
>   target/xtensa: Use tcg_gen_sextract_i32 (2023-10-21 19:17:28 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/OSLL/qemu-xtensa.git tags/20231119-xtensa
>
> for you to fetch changes up to 79cc6538fba73b3c071d76d912486e96540df98f:
>
>   linux-user: xtensa: fix signal delivery in FDPIC (2023-11-19 10:38:07 -=
0800)
>
> ----------------------------------------------------------------
> target/xtensa updates for v8.2:
>
> - fix signal delivery in FDPIC
>
> ----------------------------------------------------------------
> Max Filippov (1):
>       linux-user: xtensa: fix signal delivery in FDPIC
>
>  linux-user/xtensa/signal.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)

Sorry, wrong tag, please ignore.

--=20
Thanks.
-- Max

