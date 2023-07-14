Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1648B7531D3
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 08:13:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKC2x-00019Q-Nb; Fri, 14 Jul 2023 02:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKC2u-00017P-2b
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:12:52 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKC2s-0006Q0-Ns
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:12:51 -0400
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-6b9b427b4fcso795644a34.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 23:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689315169; x=1691907169;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c9U+Su4sugmUZHXUqW4zK/9aBe6zHdXWobby82IJFkM=;
 b=ILOH5Sn7+ggFGaqo5ebP+mah4Z2C+cTxf1qfnrNgjSUjFwLIkV/o+CXh3NzImn3zzJ
 XWXsjBxvBhynypI37P1E3t8C+RikqVwPgNoaCy3WJMnM64Uhmpt/Ecz7iTzg98iPOfAH
 YN50kCRc87px2ZarurGb6+CR81m/Cd0wDFcyRAHSsTxu8H1wFsNKcQ2QIjR0y8vVLoK9
 RUE1DIfrN/cKRqKFy02yNTotWbSsQLoEogYkE2VqNSVa9v6PQ9pyJ2x6K0YZB3tWJgk5
 63WLM1QIkHzN9Oy6OYppgk2e4CcN0FQyy/VvVVcCUtz3sN4JLMrcmEofpN+miUz2a2BV
 74YA==
X-Gm-Message-State: ABy/qLZiU7R5jyVodg00JI0OaTeC2TgI2kOdkc7LYLzCUvH5aJaWr6Hv
 sy4V456weV1thVr9Z1VFTm/XAV+IZJQ=
X-Google-Smtp-Source: APBJJlH0p+qMAWsNZug8XJYcT5z1kd8poKdBYv4Ajeh5eGmQ3LWu6cIKjI3pD+sEBQ67pfE6G1fizg==
X-Received: by 2002:a05:6830:1543:b0:6b9:a3fd:e345 with SMTP id
 l3-20020a056830154300b006b9a3fde345mr3751042otp.26.1689315169283; 
 Thu, 13 Jul 2023 23:12:49 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com.
 [209.85.210.51]) by smtp.gmail.com with ESMTPSA id
 z21-20020a05683010d500b006b89dafb721sm3513358oto.78.2023.07.13.23.12.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 23:12:48 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-6b5d7e60015so1236830a34.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 23:12:48 -0700 (PDT)
X-Received: by 2002:a05:6358:881f:b0:133:a55:7e26 with SMTP id
 hv31-20020a056358881f00b001330a557e26mr4563022rwb.7.1689315168227; Thu, 13
 Jul 2023 23:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230713171955.149236-1-stefanb@linux.ibm.com>
 <CA+E+eSA1O=39JRjWni1YnVg3uwWATpe2zw8EWgDEBbv+EPgU7w@mail.gmail.com>
In-Reply-To: <CA+E+eSA1O=39JRjWni1YnVg3uwWATpe2zw8EWgDEBbv+EPgU7w@mail.gmail.com>
From: Joelle van Dyne <j@getutm.app>
Date: Thu, 13 Jul 2023 23:12:37 -0700
X-Gmail-Original-Message-ID: <CA+E+eSC1O7Cj-UNUL58r8orAvRk5Q=J+E+0rEXwkKk_jjpHzUg@mail.gmail.com>
Message-ID: <CA+E+eSC1O7Cj-UNUL58r8orAvRk5Q=J+E+0rEXwkKk_jjpHzUg@mail.gmail.com>
Subject: Re: [PATCH] hw/tpm: TIS on sysbus: Remove unsupport ppi command line
 option
To: Joelle van Dyne <j@getutm.app>
Cc: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org, 
 marcandre.lureau@redhat.com, eric.auger@redhat.com, ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.210.50; envelope-from=osy86dev@gmail.com;
 helo=mail-ot1-f50.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jul 13, 2023 at 11:07=E2=80=AFPM Joelle van Dyne <j@getutm.app> wro=
te:
>
> On Thu, Jul 13, 2023 at 10:20=E2=80=AFAM Stefan Berger <stefanb@linux.ibm=
.com> wrote:
> >
> > The ppi command line option for the TIS device on sysbus never worked
> > and caused an immediate segfault. Remove support for it since it also
> > needs support in the firmware and needs testing inside the VM.
> >
> > Reproducer with the ppi=3Don option passed:
> >
> > qemu-system-aarch64 \
> >    -machine virt,gic-version=3D3 \
> >    -m 4G  \
> >    -nographic -no-acpi \
> >    -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> >    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> >    -device tpm-tis-device,tpmdev=3Dtpm0,ppi=3Don
> > [...]
> > Segmentation fault (core dumped)
> >
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>
> Do you need to add a VMSTATE_UNUSED_TEST in case a future QEMU version
> introduces a new field in the same position which will cause an issue
> when restoring from an older version?

Actually, ignore that last message. I misread the patch thinking it's
on the VMState.

