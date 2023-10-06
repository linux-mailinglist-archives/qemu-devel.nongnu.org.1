Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCADC7BBB16
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 17:01:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qomIo-0000s3-NI; Fri, 06 Oct 2023 10:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qomIh-0000n0-C7
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 10:59:37 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qomIf-0001vr-TU
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 10:59:35 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3512740906dso9134695ab.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 07:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696604372; x=1697209172; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=v4ComNysIFGxNy5ZPB6wNyL/49/S5KbmuI6HeAZVc8I=;
 b=nLQrAwip8r6Rh5AQnCBAaPWZQScmFakL31P7tqgc+HOtwpRs7bKGgSA1byv2Q3oLzT
 qHIm4ezwUDpGncFuElEoiIOPLbMXCEd5oJJkQMudKpoI1Wjs0MFLiyM6gp1xUVvzmg7q
 TXvZowT6hneKKad7TK2wNw7PVSjA97L0g9Ru1BshKRE9X8mimb99Br+WeI0b1sOobVk8
 2iewrsbP7gEQRN02WX58mQX46k3lTpvCPVQjmp65cwnlyanUAaWVtI06iRAOyF/DMrH4
 YRLH+zFnJfypbSKpf7YeTrJJIy5y0L7njx7BEPYYSga3RCXbZtCjoRhWvuM4ojY8AD9R
 uTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696604372; x=1697209172;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v4ComNysIFGxNy5ZPB6wNyL/49/S5KbmuI6HeAZVc8I=;
 b=FCFcWxLExbVHzBqZdJ6ocr7/zDgCPB0lGW13AFElz2v/KV9sj+gz2qBnFSxkvtj24e
 lC7tvowR6rWhQjrbuydpofzy+OZv5Agm8F4VunVDLyndEpbqaWLFvW0stJKY4klvQ9cy
 1jc0hOWthW/Cq8kcJu0rDnY5zh7/UDmfgC7AfF4vTWRaeCmsbH7uUXKt5kialuJ5Gjt5
 ytPErArhCRHu6hxyCotyls5NOUx3T370Q2w6X1Mhgz/vsFFmEVsK8INWTc4z2uheDkbl
 Uk+796xpqmt8eNi1Vj4FV7RhHBZKCYfy6fLZqQyMPDyyaxZKIeCBseExbq/yIcUHQU1E
 jpmg==
X-Gm-Message-State: AOJu0YwXvfVFeKSLY+TFp18VvPAHmfk9RTDzUfT8Kwso4y79sCvZupWC
 e5xdzIceQGCj72qHsLE8L3Q=
X-Google-Smtp-Source: AGHT+IESazpzdA06dUXbkoG+V2c7I6ea/+PzRCE0ONOMNAFzW3KB0FrweWaJw3UgcLFtHOXY5QBYEg==
X-Received: by 2002:a05:6e02:2165:b0:34b:af03:e2a with SMTP id
 s5-20020a056e02216500b0034baf030e2amr9473024ilv.31.1696604372364; 
 Fri, 06 Oct 2023 07:59:32 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2601:284:8201:81c0:582b:6312:c6b:a6f0])
 by smtp.gmail.com with ESMTPSA id
 br13-20020a05663846cd00b0042b62a31349sm449984jab.146.2023.10.06.07.59.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Oct 2023 07:59:30 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <bcain@quicinc.com>,
	<qemu-devel@nongnu.org>
Cc: <armbru@redhat.com>, <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <peter.maydell@linaro.org>, <quic_mathbern@quicinc.com>,
 <stefanha@redhat.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>
References: <20231005222206.2784853-1-bcain@quicinc.com>
 <20231005222206.2784853-3-bcain@quicinc.com>
In-Reply-To: <20231005222206.2784853-3-bcain@quicinc.com>
Subject: RE: [PATCH v2 2/3] target/hexagon: fix some occurrences of
 -Wshadow=local
Date: Fri, 6 Oct 2023 08:59:29 -0600
Message-ID: <312a01d9f865$b5c0d840$214288c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJv0F5Exw0TPnXaZfUwlO9P/EDe8gJbdiv2rv5Ox9A=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x129.google.com
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



> -----Original Message-----
> From: Brian Cain <bcain@quicinc.com>
> Sent: Thursday, October 5, 2023 4:22 PM
> To: qemu-devel@nongnu.org
> Cc: bcain@quicinc.com; armbru@redhat.com; =
richard.henderson@linaro.org;
> philmd@linaro.org; peter.maydell@linaro.org; =
quic_mathbern@quicinc.com;
> stefanha@redhat.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com
> Subject: [PATCH v2 2/3] target/hexagon: fix some occurrences of -
> Wshadow=3Dlocal
>=20
> Of the changes in this commit, the changes in
> `HELPER(commit_hvx_stores)()` are less obvious.  They are required =
because
> of some macro invocations like SCATTER_OP_WRITE_TO_MEM().
>=20
> e.g.:
>=20
>     In file included from ../target/hexagon/op_helper.c:31:
>     ../target/hexagon/mmvec/macros.h:205:18: error: declaration of =
=E2=80=98i=E2=80=99
> shadows a previous local [-Werror=3Dshadow=3Dcompatible-local]
>       205 |         for (int i =3D 0; i < sizeof(MMVector); i +=3D =
sizeof(TYPE)) { \
>           |                  ^
>     ../target/hexagon/op_helper.c:157:17: note: in expansion of macro
> =E2=80=98SCATTER_OP_WRITE_TO_MEM=E2=80=99
>       157 |                 SCATTER_OP_WRITE_TO_MEM(uint16_t);
>           |                 ^~~~~~~~~~~~~~~~~~~~~~~
>     ../target/hexagon/op_helper.c:135:9: note: shadowed declaration is =
here
>       135 |     int i;
>           |         ^
>     In file included from ../target/hexagon/op_helper.c:31:
>     ../target/hexagon/mmvec/macros.h:204:19: error: declaration of =
=E2=80=98ra=E2=80=99
> shadows a previous local [-Werror=3Dshadow=3Dcompatible-local]
>       204 |         uintptr_t ra =3D GETPC(); \
>           |                   ^~
>     ../target/hexagon/op_helper.c:160:17: note: in expansion of macro
> =E2=80=98SCATTER_OP_WRITE_TO_MEM=E2=80=99
>       160 |                 SCATTER_OP_WRITE_TO_MEM(uint32_t);
>           |                 ^~~~~~~~~~~~~~~~~~~~~~~
>     ../target/hexagon/op_helper.c:134:15: note: shadowed declaration =
is here
>       134 |     uintptr_t ra =3D GETPC();
>           |               ^~
>=20
> Reviewed-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> ---
>  target/hexagon/imported/alu.idef | 6 +++---
>  target/hexagon/mmvec/macros.h    | 6 +++---
>  target/hexagon/op_helper.c       | 9 +++------
>  target/hexagon/translate.c       | 9 ++++-----
>  4 files changed, 13 insertions(+), 17 deletions(-)

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



