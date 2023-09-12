Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D20779D721
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 19:04:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg6ms-0007xF-Cj; Tue, 12 Sep 2023 13:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg6me-0007w8-H8
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 13:02:43 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg6mX-0003tK-7W
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 13:02:39 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52a1ce52ef4so7521577a12.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694538149; x=1695142949; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zb86YH1NQUnflFtGXj0uCFy9lZOn7NaN8cIN/CXOJRc=;
 b=wqVHa96N2KkOJHZFTirukT4kDyyie6DtVaYFi32GDLg2LKpRfPS/uVPKWWGtFMvMM/
 LJBdGslDmkVbJ1DLJHVDkOUQtZ7ZDyhnuzHVtow9HdQbirL3yuyDoQ6UYQ3jvbFiTp9v
 i4ezjjUmG2+mC6A4akHRud9ob0Eknzi3+Dl22A/UanLjuVSMpY7FxHVgail/M7I3k2Ca
 rb0I9EAtKVZafdnWr1vR4LXwuiuCs4+Jfv8okMMB6lsDf/I82J3Hhxg9obqhQkUjTjeP
 +XC9kwEgwciOSR0GjdZYob6goFAD2hstH7RfOi4hNJb7Zpw1PG5o5sHDuuEA+j319CIb
 2bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694538149; x=1695142949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zb86YH1NQUnflFtGXj0uCFy9lZOn7NaN8cIN/CXOJRc=;
 b=pOf1vBD/5V27OzIWKViq2iju5pbVfhilfs6bMk/+7PDpaceczpAOqbyj24Oudy/SDR
 CKXaIW8+fgv/Aqb/yKen/y8+AVGNneuBQxzJjo5kni+kSQBfy+3Mm01FmU6JiuFBlPRP
 78KCbiczPTJ0PMoDRgu3Pk8YZmTIwj/a/GhCb9iBgtG3AIxBBqqIlFqRaBZqGKtr9IUD
 VIZUMlNOEnBmfp5/jFKWsN0H6GudDvTXzTCcAQjHJ2btGiQ1dIpWaxIUSJUR8q2IxMh/
 0zfLtLmo0l/XigaZ5jMoXb7GVH20T5iHu3EK0zu6+2lCy9ybZI9WnE16E6sAKn99QN+n
 6EuQ==
X-Gm-Message-State: AOJu0Yx5N/K9Tzkw9sSiLQwWyjY/8y947wg4DCQeWHyTRJmVDy5NBh0p
 usE3+vypvACJfry+TnH0OHXSlI9l5xYKFOJOi7zc7A==
X-Google-Smtp-Source: AGHT+IFwbIag5cOI98pPqWEWp6j4XJRVqllF3Zrdq19gRdjJEIP327F3bcSpmg8w03UTj+bCpSge892iEaotgi+L6Lg=
X-Received: by 2002:a05:6402:1617:b0:52f:3051:f7dd with SMTP id
 f23-20020a056402161700b0052f3051f7ddmr155120edv.35.1694538149584; Tue, 12 Sep
 2023 10:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230905115000.53587-1-thuth@redhat.com>
 <20230905115000.53587-5-thuth@redhat.com>
In-Reply-To: <20230905115000.53587-5-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2023 18:02:18 +0100
Message-ID: <CAFEAcA9iGMXUXpB=H-mWWdmq0pduTf_vJ5peAB8+DcAOagKPCg@mail.gmail.com>
Subject: Re: [risu PATCH v2 4/4] s390x: Update the configure script for s390x
 support
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 5 Sept 2023 at 12:50, Thomas Huth <thuth@redhat.com> wrote:
>
> Auto-detect s390x hosts and add s390x information to the help text.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index ca2d7db..2f7c580 100755
> --- a/configure
> +++ b/configure
> @@ -58,6 +58,8 @@ guess_arch() {
>          ARCH=3D"m68k"
>      elif check_define __powerpc64__ ; then
>          ARCH=3D"ppc64"
> +    elif check_define __s390x__ ; then
> +        ARCH=3D"s390x"
>      else
>          echo "This cpu is not supported by risu. Try -h. " >&2
>          exit 1
> @@ -139,7 +141,7 @@ Some influential environment variables:
>                 prefixed with the given string.
>
>    ARCH         force target architecture instead of trying to detect it.
> -               Valid values=3D[arm|aarch64|ppc64|ppc64le|m68k]
> +               Valid values=3D[arm|aarch64|m68k|ppc64|ppc64le|s390x]
>
>    CC           C compiler command
>    CFLAGS       C compiler flags
> --
> 2.39.3

You could also add s390 to the list of archs that
build-all-archs handles:

diff --git a/build-all-archs b/build-all-archs
index e5dcfc8..e89851b 100755
--- a/build-all-archs
+++ b/build-all-archs
@@ -91,7 +91,8 @@ program_exists() {
 for triplet in i386-linux-gnu i686-linux-gnu x86_64-linux-gnu \
                    aarch64-linux-gnu arm-linux-gnueabihf \
                    m68k-linux-gnu \
-                   powerpc64le-linux-gnu powerpc64-linux-gnu ; do
+                   powerpc64le-linux-gnu powerpc64-linux-gnu \
+                   s390x-linux-gnu ; do

     if ! program_exists "${triplet}-gcc"; then
         echo "Skipping ${triplet}: no compiler found"


(That script checks that all the architectures can at least
build, and that risugen on the foo.risu file works.)

thanks
-- PMM

