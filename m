Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E2B779FE8
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 14:10:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUnRA-00018F-Uc; Sat, 12 Aug 2023 08:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qUnR0-00017f-Sj
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 08:09:36 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qUnQy-0005v3-W6
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 08:09:34 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-56546b45f30so2201104a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Aug 2023 05:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691842171; x=1692446971;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SQDhS/SipcobMYrlaFJ4lgJ2suMMPryJ+VLuEQdLNmE=;
 b=MuB2u8NjVBgWC67/G0+d7Mn0x9B8aHUK08DzF6ucGqVRLvmn8FkLUOnrzngmr3AoLh
 aS+TMBAdksS2ufOWCnCLlHq2wtMcYaANt2qsNw75Q0zGphitloe1Ucd+MqT0Tmk2F6FS
 k3k7CJt2PxsKieCqk+ZVZUF70f2zNMRrU8y6cDzwHj+gxsEwBMd39ALFw9klbhDrSXTY
 DlP/bV1NtPDcMTbw4I+gu4rHHF0gM/8oxPhQW12YNjHQGAzHkFxWyq+8edL1Q62cF36K
 KF3yepVzZvHn4xqSngKhtIv9Odl2x+e57JWYCM/vBXtwSwEh/Islahl182JHU8mOvDqD
 1ZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691842171; x=1692446971;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SQDhS/SipcobMYrlaFJ4lgJ2suMMPryJ+VLuEQdLNmE=;
 b=d4EsPdPLgdRFXucontewzJbxbAcIjcdtLAQFAzyhjyEK7v8/1l63gym55kzvUGFxAx
 tXlDeO7abjrXUDfEDglzk9A/5U4nHu+kJJ3swPyhxElGniw94FLKEU7u1GlXtY967PDS
 1BifNLcuy48XAkcTdEqFIIoI8IOov4EvSMT3u+4KZmgkJucrR/edPFCNPYk1rJQ3j+d8
 mBIndR3LMnQWA5UWaBQGuvYWUZLskxW8NoNKeHFfHNvySapy9P9DnLyKAmAFbfIcDnTF
 bVY5BJ7ae3fEK1Sl3IXdEIA5J65V5DpVt5Vw8lFiTisI97cYu9c2eYfxv+MM9mpcMntM
 aUjQ==
X-Gm-Message-State: AOJu0YzN52nu6qLkLYrYwoiIxMHtsCRa43Rfur711AzNB+HHxEG1Vnx9
 OrKaudBtAx2eIEzsg+bgiO3Oayh8NfEqQwFbf1o=
X-Google-Smtp-Source: AGHT+IFfcQ7nIgdysforRdLoxkzPwUzbGwvg45Vcq2daryme0t2So9TehELVrYAUggiQxx8t1viOAw==
X-Received: by 2002:a17:90a:9e7:b0:268:52a6:103d with SMTP id
 94-20020a17090a09e700b0026852a6103dmr4070092pjo.9.1691842171183; 
 Sat, 12 Aug 2023 05:09:31 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 n32-20020a17090a2ca300b00262d9b4b527sm5167901pjd.52.2023.08.12.05.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Aug 2023 05:09:30 -0700 (PDT)
Message-ID: <fbc4b1e3-c504-4d79-b803-a23c866361e8@daynix.com>
Date: Sat, 12 Aug 2023 21:09:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Fix MESONINTROSPECT parsing
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <20230812061540.5398-1-akihiko.odaki@daynix.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230812061540.5398-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 2023/08/12 15:15, Akihiko Odaki wrote:
> The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
> must be parsed with shlex.split().
> 
> Fixes: cf60ccc330 ("cutils: Introduce bundle mechanism")
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   scripts/symlink-install-tree.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/symlink-install-tree.py b/scripts/symlink-install-tree.py
> index 8ed97e3c94..b72563895c 100644
> --- a/scripts/symlink-install-tree.py
> +++ b/scripts/symlink-install-tree.py
> @@ -4,6 +4,7 @@
>   import errno
>   import json
>   import os
> +import shlex
>   import subprocess
>   import sys
>   
> @@ -14,7 +15,7 @@ def destdir_join(d1: str, d2: str) -> str:
>       return str(PurePath(d1, *PurePath(d2).parts[1:]))
>   
>   introspect = os.environ.get('MESONINTROSPECT')
> -out = subprocess.run([*introspect.split(' '), '--installed'],
> +out = subprocess.run([*shlex.split(introspect), '--installed'],
>                        stdout=subprocess.PIPE, check=True).stdout
>   for source, dest in json.loads(out).items():
>       bundle_dest = destdir_join('qemu-bundle', dest)

Please do NOT merge this. This will break Windows builds. I'm putting 
this patch on hold.

The problem is that Meson uses a different logic for escaping arguments 
in MESONINTROSPECT on Windows. I'll wait till Meson maintainers figure 
out how MESONINTROSPECT should be used. For details, see:
https://github.com/mesonbuild/meson/pull/12115#issuecomment-1675863266

Regards,
Akihiko Odaki

