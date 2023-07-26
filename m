Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECFC763782
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 15:27:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOe7o-0001M2-I2; Wed, 26 Jul 2023 09:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOe7l-0001Lo-U3
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 09:00:17 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOe7k-0000FB-C1
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 09:00:17 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5222bc91838so5217612a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 06:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690376415; x=1690981215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+91LSY7Ui5q1L8GOYXaEYT5dvwZ4FxFQqxr/ni71gQ=;
 b=OFn4jms7/neC5Qk6DDnkrBiQ//29tjyvqaS53AJ5cfVEKQkrJxEtvFIO8AzJMeWqm3
 PZ4jZdO6VKMhuuAxPqhGMqaKg0xbZC205b2OpUW5YFWjx+z+mLZ9admdzhrW5yXhc7QN
 zdET37KzT7ubJONoYA4sTgfK7fRMbPf850Mdk0Flnnn7nmrcVT9M4rRrbKzoGFvWJDff
 7wjRmth5/H1KAtZ9+M3QaY8LAqqMrR+n1OsesShfKGKIHcXdZ6GMGYJll/gO+LubYLWY
 NHfyqEh3cZ/6URErYvRtYU30jPabLNyFZP9E3+PpK6t4AqW+CoFy0whkiAia1LBTOBRc
 MvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690376415; x=1690981215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+91LSY7Ui5q1L8GOYXaEYT5dvwZ4FxFQqxr/ni71gQ=;
 b=NCZUEP/PSCRkZiCILEjAWtEdnNLztXcMt4S1I8pQnrKmyGR3kqNOV/+nZLWb3txh8M
 nQxDrbdlFZhWymEv84LDPbhXZNXgcrTagdwBExe80/eEQ5s1fMC/92Uw1g41MT3pYLLO
 R+QpM+2sUOZrTHdZ+LVIwMkIg6QrvfEbzlbnfZNhMi0VQDgUyCwx4OYgrF3SHPS4SDjA
 8Adi9dh2KcNhZLpQ+gjANTTNQ6YD8xn19LWsCRdLLB6GH7nEz0nYodPD3yaYpBubVRhN
 0KtAvMnER0E6H7JmJPJS6HVFcRDmAkhFQLuRfMVysPswJ+I+dM0Evofy/d607B2Qofl7
 FKJg==
X-Gm-Message-State: ABy/qLZZGYe+6jpXzYaw5+yAuDpHqKSQKdwTg1KEeoLRDtLJkA4kqEPz
 rYdciMmCGS/IVdu5fhS+enKRNxPEgl/zCJVHkOOmYQ==
X-Google-Smtp-Source: APBJJlGSE4FoUEeeH32hR0bNo1LhHmml+J6BNNkN9j/RiC5XXcWXopxoO4ioCO0KGS1xDVlybSKMuOV0z5ckBJz2u+U=
X-Received: by 2002:aa7:d0c9:0:b0:522:4355:7030 with SMTP id
 u9-20020aa7d0c9000000b0052243557030mr1706147edo.27.1690376414758; Wed, 26 Jul
 2023 06:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <87fs5aho6e.fsf@secure.mitica>
In-Reply-To: <87fs5aho6e.fsf@secure.mitica>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Jul 2023 14:00:03 +0100
Message-ID: <CAFEAcA89zgd+ZFBcMasTZErH6eTknXJhnDaXyW_LWj_vAYKrnw@mail.gmail.com>
Subject: Re: How to tame CI?
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Daniel Berrange <berrange@redhat.com>, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 26 Jul 2023 at 13:06, Juan Quintela <quintela@redhat.com> wrote:
> To make things easier, this is the part that show how it breaks (this is
> the gcov test):
>
> 357/423 qemu:block / io-qcow2-copy-before-write                          =
  ERROR           6.38s   exit status 1
> >>> PYTHON=3D/builds/juan.quintela/qemu/build/pyvenv/bin/python3 MALLOC_P=
ERTURB_=3D44 /builds/juan.quintela/qemu/build/pyvenv/bin/python3 /builds/ju=
an.quintela/qemu/build/../tests/qemu-iotests/check -tap -qcow2 copy-before-=
write --source-dir /builds/juan.quintela/qemu/tests/qemu-iotests --build-di=
r /builds/juan.quintela/qemu/build/tests/qemu-iotests
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95
> stderr:
> --- /builds/juan.quintela/qemu/tests/qemu-iotests/tests/copy-before-write=
.out
> +++ /builds/juan.quintela/qemu/build/scratch/qcow2-file-copy-before-write=
/copy-before-write.out.bad
> @@ -1,5 +1,21 @@
> -....
> +...F
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +FAIL: test_timeout_break_snapshot (__main__.TestCbwError)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "/builds/juan.quintela/qemu/tests/qemu-iotests/tests/copy-before-=
write", line 210, in test_timeout_break_snapshot
> +    self.assertEqual(log, """\
> +AssertionError: 'wrot[195 chars]read 1048576/1048576 bytes at offset 0\n=
1 MiB,[46 chars]c)\n' !=3D 'wrot[195 chars]read failed: Permission denied\n=
'
> +  wrote 524288/524288 bytes at offset 0
> +  512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +  wrote 524288/524288 bytes at offset 524288
> +  512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> ++ read failed: Permission denied
> +- read 1048576/1048576 bytes at offset 0
> +- 1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +

This iotest failing is an intermittent that I've seen running
pullreqs on master. I tend to see it on the s390 host. I
suspect a race condition somewhere where it fails if the host
is heavily loaded.

-- PMM

