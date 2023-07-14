Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5A27531C6
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 08:09:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKByR-00085B-P0; Fri, 14 Jul 2023 02:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKByH-00081t-Eo
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:08:06 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKByF-00033z-Sy
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:08:05 -0400
Received: by mail-il1-f181.google.com with SMTP id
 e9e14a558f8ab-345d6dc271dso6711915ab.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 23:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689314882; x=1691906882;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C+ZjpgcwdVHBQ49UZJn/tM0JgyUHjYPM2m2j52gXvIA=;
 b=DaBUS98ajzo+lCWaNsS+iH6+UJVY6d8shjAWaXAhfjwuJBMe+ke/dHO4SMa7QwxjYf
 5IDtlsViErObuXw3XAmDcn+JWK9O53YjNywyK3uU/e6VN7IM+4oGb2Y0tR1gGw6pBTEA
 qui5eczAIBiHyLwlVFb+ED+FkgMkAHUQtP4e3W7FzXTN7Nf5U/07VVKUrp/bdqjMw3hk
 TeUhWB/++ThS0d5LACGcDjprZLEHfKV6O+peHQSIq7M+xkht1wjyWiakqF3G6WYVcXFk
 7k7ZUAxdaN2IOvcypjkIEEHUVwbm9jDYkqIA64g/y8ewpbVy5ITVscAjFRQSss9C8n6D
 m5UQ==
X-Gm-Message-State: ABy/qLYK5b8KOlz8FgadfUNkaXW8JkKN62em3qF7yi9FECm1FXBvn3j0
 C0buFHfc3V0JxIYVHCnbqilD9oVLzMI=
X-Google-Smtp-Source: APBJJlHoguandwdawmsr/7HmCBtWVk0Rf0faTHeIUTpslL2t92wNswrgKFp3j80C+EKm7gWcjI2cmA==
X-Received: by 2002:a05:6e02:80f:b0:345:ab32:11a with SMTP id
 u15-20020a056e02080f00b00345ab32011amr3609641ilm.12.1689314882071; 
 Thu, 13 Jul 2023 23:08:02 -0700 (PDT)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com.
 [209.85.166.171]) by smtp.gmail.com with ESMTPSA id
 cu5-20020a05663848c500b0042b28c6a8f4sm2244019jab.75.2023.07.13.23.08.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 23:08:01 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id
 e9e14a558f8ab-3457a3ada84so6671455ab.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 23:08:01 -0700 (PDT)
X-Received: by 2002:a92:c807:0:b0:346:4766:9f76 with SMTP id
 v7-20020a92c807000000b0034647669f76mr3349515iln.13.1689314881140; Thu, 13 Jul
 2023 23:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230713171955.149236-1-stefanb@linux.ibm.com>
In-Reply-To: <20230713171955.149236-1-stefanb@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Thu, 13 Jul 2023 23:07:50 -0700
X-Gmail-Original-Message-ID: <CA+E+eSA1O=39JRjWni1YnVg3uwWATpe2zw8EWgDEBbv+EPgU7w@mail.gmail.com>
Message-ID: <CA+E+eSA1O=39JRjWni1YnVg3uwWATpe2zw8EWgDEBbv+EPgU7w@mail.gmail.com>
Subject: Re: [PATCH] hw/tpm: TIS on sysbus: Remove unsupport ppi command line
 option
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, eric.auger@redhat.com, 
 ard.biesheuvel@linaro.org, j@getutm.app
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.166.181; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f181.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Jul 13, 2023 at 10:20=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.c=
om> wrote:
>
> The ppi command line option for the TIS device on sysbus never worked
> and caused an immediate segfault. Remove support for it since it also
> needs support in the firmware and needs testing inside the VM.
>
> Reproducer with the ppi=3Don option passed:
>
> qemu-system-aarch64 \
>    -machine virt,gic-version=3D3 \
>    -m 4G  \
>    -nographic -no-acpi \
>    -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
>    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
>    -device tpm-tis-device,tpmdev=3Dtpm0,ppi=3Don
> [...]
> Segmentation fault (core dumped)
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Do you need to add a VMSTATE_UNUSED_TEST in case a future QEMU version
introduces a new field in the same position which will cause an issue
when restoring from an older version?

