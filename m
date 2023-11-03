Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2297DFE3D
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 04:09:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qykY6-0005Qu-Nd; Thu, 02 Nov 2023 23:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qykY4-0005QT-Ix
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 23:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qykY2-0000fH-TY
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 23:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698980917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d1okX6rLO94QMDHPv1W2lNMISYjlmezNTUKMwze2R0E=;
 b=ebSXXx1dBgD5EbPaRJRjM8uk5EiofgBVO324zxIO3YE2RixfyurDjUdSXXGTyXAj7gJSyr
 CaPrjp3448+D2kskQH3wnZ/DHDoGLLeGaSRvzbfiIkXXzgMXK/EhPWHTPjT5yCbssEIFc5
 pLGEIOQyoKS6XSFym9xTe5QT3wlcmes=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-iAZ5SnWDNz-YGxqqRmET6Q-1; Thu, 02 Nov 2023 23:08:35 -0400
X-MC-Unique: iAZ5SnWDNz-YGxqqRmET6Q-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6b1f7baa5ceso1396998b3a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 20:08:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698980914; x=1699585714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d1okX6rLO94QMDHPv1W2lNMISYjlmezNTUKMwze2R0E=;
 b=VjJ/sSUz+Wg8Ifd0wl8rWYpMffxBXM2scU5r5x3TzOccuW4a1/CmI17QTmWPr/1BsI
 dBgo1rSLl1YFeDccknX26/svUxJjRTDPu9C+iOjJ1tSeLKfwAM6V/tzMBnbq5a+aEX6Q
 jptBrUXzQxpM2w98R7y5i2efG2qELvi1GSRXu40Yrmj8hkUlbZ2rM1jcNauaa44R1aLd
 iS9I5/GM1UlqbNnAieR/eFcd6J9cl9yqwjhZKdJ8naCVrLafXOiM7vWNodMzcXvQkAr5
 obiQuk14d/n9sFjEuopsrFSqz/jPL197Kuc/V/2j2PSAWkYq4JjsmTeexqxy2uH93JAq
 cZDQ==
X-Gm-Message-State: AOJu0YygyDqDoXPB8oDLCG08JcrOFZU4bMHs0pWX0uy/q8sgnz+SReUZ
 jQHBo3u+r09hE4WGqd9xEsHNGuu+ZIOto/of3F3jvbKULLjwQuFHvbk496W0scw08NPDhAv6COl
 /x49C6ojFIP0UedOUyPgVvW2GQR/nhRo=
X-Received: by 2002:a05:6a21:4881:b0:181:ed8b:4826 with SMTP id
 av1-20020a056a21488100b00181ed8b4826mr921949pzc.55.1698980914729; 
 Thu, 02 Nov 2023 20:08:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjvTJaYbQUtnprnUD8bqALB8yFUFd/p1OTJ707YzRAFW4HPGSyZG5Rm9WIXfL/AYpiyWmTZKzsHfKyPA+ic6w=
X-Received: by 2002:a05:6a21:4881:b0:181:ed8b:4826 with SMTP id
 av1-20020a056a21488100b00181ed8b4826mr921937pzc.55.1698980914403; Thu, 02 Nov
 2023 20:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231025092159.1782638-1-armbru@redhat.com>
 <20231025092159.1782638-2-armbru@redhat.com>
In-Reply-To: <20231025092159.1782638-2-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 2 Nov 2023 23:08:23 -0400
Message-ID: <CAFn=p-Y58FTVshF_y99bTOXJNRaec=_rGnJGrEtcRBMZbPq2LA@mail.gmail.com>
Subject: Re: [PATCH 1/1] sphinx/qapidoc: Tidy up pylint warning
 raise-missing-from
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Oct 25, 2023 at 6:10=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Pylint advises:
>
>     docs/sphinx/qapidoc.py:518:12: W0707: Consider explicitly re-raising =
using 'raise ExtensionError(str(err)) from err' (raise-missing-from)
>
> From its manual:
>
>     Python's exception chaining shows the traceback of the current
>     exception, but also of the original exception.  When you raise a
>     new exception after another exception was caught it's likely that
>     the second exception is a friendly re-wrapping of the first
>     exception.  In such cases `raise from` provides a better link
>     between the two tracebacks in the final error.
>
> Makes sense, so do it.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

In this case it probably doesn't make a difference because Sphinx has
its own formatting for displaying the errors, but it's good hygiene.

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  docs/sphinx/qapidoc.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 8f3b9997a1..658c288f8f 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -515,7 +515,7 @@ def run(self):
>          except QAPIError as err:
>              # Launder QAPI parse errors into Sphinx extension errors
>              # so they are displayed nicely to the user
> -            raise ExtensionError(str(err))
> +            raise ExtensionError(str(err)) from err
>
>      def do_parse(self, rstlist, node):
>          """Parse rST source lines and add them to the specified node
> --
> 2.41.0
>
>


