Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A9C745CC5
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:03:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJCZ-0007IM-S3; Mon, 03 Jul 2023 09:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGJCX-0007Hm-CJ; Mon, 03 Jul 2023 09:02:45 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGJCU-0003NN-Sc; Mon, 03 Jul 2023 09:02:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b89cfb4571so3963935ad.3; 
 Mon, 03 Jul 2023 06:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688389361; x=1690981361;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eEN4xcCbXQotyhUuiqRnwuEMFuXm4weCQVS7+1xmoUY=;
 b=Jly0gIjQw2uvL2OY7JPKKMC8bixVfZz+Mkb514QQ4S7azCPt99NB5KgyA3lBc0liU0
 S2rQISpMgsBRtMc7AhUWAcyQRAmgtJRtHMI2wliykV0ER9EnyydrVBFD4KLU//spTBA+
 szEaf5mNBF1YqMKqwdVwBxF7Ee0H9XSRt/ktL858ZkTIkMkxhZFtKu8Y5CILmLfmX4Uz
 ktctcltIoaW9jQQr8k4baMOQzGUo+6ztmzJo+Cq8eV4fvHqQh9U9hFHm3drDkTwk7EDb
 L5Lmm+6Cq3ihHXzfca8M0KceEQ52rIujMhU7EV2wZYIX4Dtcn7ysduGrcg+WFlK+83/J
 ZSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688389361; x=1690981361;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eEN4xcCbXQotyhUuiqRnwuEMFuXm4weCQVS7+1xmoUY=;
 b=C+wHvLwoKnKT3GsVHXtDyGtv/459tYsPivltZYoaqC2cP+1Xn38VNmvq1dHNC3wlSI
 ipWAfP1nBo4G/5wF+lDROyCH5imWGoUxoKIZv7QY+m3DsANLjUiA/sBxhCcJukQIjEAV
 2OKZj6ZDHjg5nm399pkiLvlskMGma5lj8ju7v6fL7PQtcJqwpVe73l3SS5Zs3v3N/3P0
 eUMymfW9qdAO7ZZ0AY58aBPrAQx8KJTRiXHsqpg38BfY4ES9ziTp7ndcpwXRspnEYPi2
 It16VsWLaFnSGSBvsR+fMX5s7QfnJC7c496WDiidcB5KzZQUYfX5C1gRU1kr1TPfvKM0
 qTSA==
X-Gm-Message-State: ABy/qLbejv0dZw9uAdRowKgcZkYpUU/jhgPekhcs97FG17bPSYkimp70
 8BHBmIZ4vP1cZoZC8rDyJiY=
X-Google-Smtp-Source: APBJJlEMX4gJbhOx877b+BmjkG05zSWwS1SUjdO2ib7mW7xPDJDxV4YobFiQXtliSu0CPzTTTSdgqg==
X-Received: by 2002:a17:902:ecc9:b0:1b8:4515:8be4 with SMTP id
 a9-20020a170902ecc900b001b845158be4mr13610802plh.56.1688389360597; 
 Mon, 03 Jul 2023 06:02:40 -0700 (PDT)
Received: from localhost ([118.210.96.60]) by smtp.gmail.com with ESMTPSA id
 l13-20020a170902d34d00b001b895a18472sm1980400plk.117.2023.07.03.06.02.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 06:02:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Jul 2023 23:02:33 +1000
Message-Id: <CTSK2PDNHZ98.36LT1B3KQ4WFE@wheely>
To: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>, "David
 Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>, "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH 1/4] target/ppc: Add LPAR-per-core vs per-thread mode flag
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20230703101700.24064-1-npiggin@gmail.com>
 <20230703101700.24064-2-npiggin@gmail.com>
 <c22ac567-27b9-5a52-106c-876f027943fb@gmail.com>
In-Reply-To: <c22ac567-27b9-5a52-106c-876f027943fb@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon Jul 3, 2023 at 10:23 PM AEST, Daniel Henrique Barboza wrote:
> Hi,
>
> I'm afraid this patch breaks two Gitlab runners in different manners.
>
>
> - the 'tsan-build' runner:
>
> https://gitlab.com/danielhb/qemu/-/jobs/4583483251
>
> [2170/3531] Compiling C object libqemu-ppc64-softmmu.fa.p/target_ppc
> _translate.c.o
> FAILED: libqemu-ppc64-softmmu.fa.p/target_ppc_translate.c.o
> clang -m64 -mcx16 -Ilibqemu-ppc64-softmmu.fa.p -I. -I.. -Itarget/ppc -I..=
/target/ppc -Iqapi -Itrace -Iui -Iui/shader -I/usr/include/pixman-1 -I/usr/=
include/capstone -I/usr/include/spice-server -I/usr/include/spice-1 -I/usr/=
include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fcolor-diagn=
ostics -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g -fsanitize=3Dthread =
-fstack-protector-strong -Wundef -Wwrite-strings -Wmissing-prototypes -Wstr=
ict-prototypes -Wredundant-decls -Wold-style-definition -Wtype-limits -Wfor=
mat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-body -Wn=
ested-externs -Wendif-labels -Wexpansion-to-defined -Wmissing-format-attrib=
ute -Wno-initializer-overrides -Wno-missing-include-dirs -Wno-shift-negativ=
e-value -Wno-string-plus-int -Wno-typedef-redefinition -Wno-tautological-ty=
pe-limit-compare -Wno-psabi -Wno-gnu-variable-sized-type-not-at-end -Wthrea=
d-safety -isystem /builds/danielhb/qemu/linux-headers -isystem linux-header=
s -iquote . -iquote /builds/danielhb/qemu -iquote /builds/danielhb/qemu/inc=
lude -iquote /builds/danielhb/qemu/host/include/x86_64 -iquote /builds/dani=
elhb/qemu/host/include/generic -iquote /builds/danielhb/qemu/tcg/i386 -pthr=
ead -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-=
aliasing -fno-common -fwrapv -fPIE -isystem../linux-headers -isystemlinux-h=
eaders -DNEED_CPU_H '-DCONFIG_TARGET=3D"ppc64-softmmu-config-target.h"' '-D=
CONFIG_DEVICES=3D"ppc64-softmmu-config-devices.h"' -MD -MQ libqemu-ppc64-so=
ftmmu.fa.p/target_ppc_translate.c.o -MF libqemu-ppc64-softmmu.fa.p/target_p=
pc_translate.c.o.d -o libqemu-ppc64-softmmu.fa.p/target_ppc_translate.c.o -=
c ../target/ppc/translate.c
> ../target/ppc/translate.c:249:20: error: unused function 'gen_serialize_c=
ore' [-Werror,-Wunused-function]
> static inline bool gen_serialize_core(DisasContext *ctx)
>                     ^
> 1 error generated.
>
> And in fact, after this patch, gen_serialize_core() is now unused:

Sorry Daniel :( I keep losing my test config. I'll have to set up
something a bit more permanent and reliable. Will resubmit.

Thanks,
Nick

