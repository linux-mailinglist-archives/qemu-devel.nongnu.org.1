Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC328706ED7
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:55:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKR5-0008HH-He; Wed, 17 May 2023 12:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzKR2-0008Gv-RV
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzKR1-0002WN-3m
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684342530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sjqpwHZx2lyvxrVxSL/WoIB+/eVWIlUfP/kNVgGLeZk=;
 b=MF97Ti6o+B1W+BxiNK3LkIuoMsVeydmVTVIBNb9Ze3K8i2R2a+uKVh6prg0bN8pZLg0BYx
 ux3Bx9YK0N4DgzkmNqvGUG6aT7KivNsFs9VNSIeODFrAUtkUoiNrp+aGPdLZjfFMlNGwcU
 adEBYG8unWzDTXn54o+EqHydJ7Yxfn0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-bJH-z2p5OrO_YI7jfT_-tQ-1; Wed, 17 May 2023 12:55:29 -0400
X-MC-Unique: bJH-z2p5OrO_YI7jfT_-tQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-25338b76f79so676780a91.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 09:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684342528; x=1686934528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sjqpwHZx2lyvxrVxSL/WoIB+/eVWIlUfP/kNVgGLeZk=;
 b=NdyAASF6rjuPK/sHg5NyoU16hQWafqqlw3X8ssjBgq0JNSObyA+lMovxTEuY+KElMU
 P1Xm1YR/Jjq1vLVFz30GnERm/sdPu2GXFXmRBp8TLTdrkj24pS+7eY8hDpadS6qGct91
 ZW9eIUxFs9tKzgv4VEk4hW9LbyW86vGdDe1P92ZuMldcpckLt4BN0fKo3+Cji7LRwKBN
 5sRS8AdnnyigLCnC6gS+dmKAATloRdmB3/RDcqNsNlpmIhRTtvuuPxHvmOqmHfz1w9vk
 U+WxRCTwX/WQOaMIBA+6R9XsBD86Rp1JC2AwU8H8I0GrVXWdBsFJMGcf1YVTK2mnEfYI
 vz4A==
X-Gm-Message-State: AC+VfDxzIB/RFlrkBEhj0tIaQ7H/IftvC6/pYfZU9rJL7S7AiIddmxM0
 HWYNje/H5R8iqVRBv0x2TXep7kj9jVwcQEbVWZU3qy/njtW7qR7BR2MRGVjCWA+teWhqyvelWgP
 vjzxmUeeCd26PLVWDVuDHeH+6+A3TS5I=
X-Received: by 2002:a17:90a:7506:b0:252:e7e2:fefe with SMTP id
 q6-20020a17090a750600b00252e7e2fefemr379482pjk.2.1684342528164; 
 Wed, 17 May 2023 09:55:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4DPnLtIvhEh2Gl+8Q+ZxIvXKP7UcR9sctuoCnHRB9ilUQYa5Y2jh7ljTRPJ4qcn80NyQQjCoHL9BxNxrtbQAo=
X-Received: by 2002:a17:90a:7506:b0:252:e7e2:fefe with SMTP id
 q6-20020a17090a750600b00252e7e2fefemr379458pjk.2.1684342527790; Wed, 17 May
 2023 09:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230504211101.1386-1-mat.krawczuk@gmail.com>
In-Reply-To: <20230504211101.1386-1-mat.krawczuk@gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 17 May 2023 12:55:16 -0400
Message-ID: <CAFn=p-aKy7onDCH7bQyvcS3jXngcQAF0K_zrkZorePxdA4s1xA@mail.gmail.com>
Subject: Re: [PATCH v2] Add information how to fix common build error on
 Windows in symlink-install-tree
To: Mateusz Krawczuk <mat.krawczuk@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, May 4, 2023 at 5:11=E2=80=AFPM Mateusz Krawczuk <mat.krawczuk@gmail=
.com> wrote:
>
> By default, Windows doesn't allow to create soft links for user account a=
nd only administrator is allowed to do this. To fix this problem you have t=
o raise your permissions or enable Developer Mode, which available since Wi=
ndows 10. Additional explanation when build fails will allow developer to f=
ix the problem on his computer faster.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1386
> Signed-off-by: Mateusz Krawczuk <mat.krawczuk@gmail.com>
>
> v2:
>   Removed unnecessary newlines to be consistent with QEMU coding styles.

I don't think you actually did this, but it's maybe fine. If you
wanted to be careful about it, you could use pylint and flake8 to
check the formatting of this script, though it isn't perfect to start:

jsnow@scv ~/s/q/scripts (python-socket-connect)> pylint symlink-install-tre=
e.py
************* Module symlink-install-tree
symlink-install-tree.py:1:0: C0114: Missing module docstring
(missing-module-docstring)
symlink-install-tree.py:1:0: C0103: Module name "symlink-install-tree"
doesn't conform to snake_case naming style (invalid-name)
symlink-install-tree.py:10:0: C0116: Missing function or method
docstring (missing-function-docstring)
symlink-install-tree.py:10:17: C0103: Argument name "d1" doesn't
conform to snake_case naming style (invalid-name)
symlink-install-tree.py:10:26: C0103: Argument name "d2" doesn't
conform to snake_case naming style (invalid-name)
symlink-install-tree.py:29:11: W0703: Catching too general exception
BaseException (broad-except)
symlink-install-tree.py:30:41: E1101: Instance of 'BaseException' has
no 'errno' member (no-member)

jsnow@scv ~/s/q/scripts (python-socket-connect) [22]> flake8
symlink-install-tree.py
symlink-install-tree.py:10:1: E302 expected 2 blank lines, found 1
symlink-install-tree.py:16:1: E305 expected 2 blank lines after class
or function definition, found 1

jsnow@scv ~/s/q/scripts (python-socket-connect) [1]> isort -c
symlink-install-tree.py
ERROR: /home/jsnow/src/qemu/scripts/symlink-install-tree.py Imports
are incorrectly sorted and/or formatted.

As long as you don't make the spacing *worse*, it's fine - but any
fixes to existing code should go in its own patch.

> Signed-off-by: Mateusz Krawczuk <mat.krawczuk@gmail.com>
> ---
>  scripts/symlink-install-tree.py | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/symlink-install-tree.py b/scripts/symlink-install-tr=
ee.py
> index 67cb86dd52..62fd609f32 100644
> --- a/scripts/symlink-install-tree.py
> +++ b/scripts/symlink-install-tree.py
> @@ -7,12 +7,14 @@
>  import subprocess
>  import sys
>
> +
>  def destdir_join(d1: str, d2: str) -> str:
>      if not d1:
>          return d2
>      # c:\destdir + c:\prefix must produce c:\destdir\prefix
>      return str(PurePath(d1, *PurePath(d2).parts[1:]))
>
> +
>  introspect =3D os.environ.get('MESONINTROSPECT')
>  out =3D subprocess.run([*introspect.split(' '), '--installed'],
>                       stdout=3Dsubprocess.PIPE, check=3DTrue).stdout
> @@ -28,5 +30,8 @@ def destdir_join(d1: str, d2: str) -> str:
>          os.symlink(source, bundle_dest)
>      except BaseException as e:
>          if not isinstance(e, OSError) or e.errno !=3D errno.EEXIST:
> +            if os.name =3D=3D 'nt':
> +                print('Please enable Developer Mode to support soft link=
 '
> +                      'without Administrator permission')

Use file=3Dsys.stderr here, too, though. If you resubmitted a patch that
omitted all whitespace changes and fixed this part, I think that'd be
sufficient. Thanks for the patch!

--js

>              print(f'error making symbolic link {dest}', file=3Dsys.stder=
r)
>              raise e
> --
> 2.40.1
>


