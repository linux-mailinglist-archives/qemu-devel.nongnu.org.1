Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9557DFE55
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 04:21:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qykkk-0001d1-Vq; Thu, 02 Nov 2023 23:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qykkh-0001cA-El
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 23:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qykkf-0005sH-1G
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 23:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698981699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wq2ZZJcDXE3CFOIkY8wWEgeNMi91T/DC1lu0y/yqYfQ=;
 b=g7aE4QmKGCX4lEUlCtlTDZuH6jh8C5IzUwLEZ61MeuXtn1KKL92sjAawtCCDmeXWwGRx/p
 Rtw7zK/rzhBEdYasrhfqiYY5f2sKZQ7WZ05+NqhOYuH3iDA6rYs++ml/1IydxFFcyQ/T0g
 Jfu7rhDhvmjtyg0Do8foMPPHT14KSeQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-5bz5ayG6MtuKiyZxqpJU0A-1; Thu, 02 Nov 2023 23:21:38 -0400
X-MC-Unique: 5bz5ayG6MtuKiyZxqpJU0A-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5b87150242cso1290301a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 20:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698981697; x=1699586497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wq2ZZJcDXE3CFOIkY8wWEgeNMi91T/DC1lu0y/yqYfQ=;
 b=q1jNsgmnDfT36q0CSXoFJN2UqdUudcBGbWXWjDZKOpTjZQRexw/TP3lFA+vSxGgezn
 HghFO6JjPi1Pg8OxYsNsGk4k1OyVuKJySjftw7rVXqfGFwTEOm68SJgkzrLF65nt96J6
 Bsqa2pmL0lfyUijJK0k+vWMdKl61m1tjLeAho2MugpGcDpGr59hJA1ls7873jA8JV91C
 THfrx/Sz05KuNzqQUy3u5nejZOun1DCUmWo7qmZ9q1C0vynrqBCnb2efZwlNiwA0zOs7
 1H+9kTlDouDmUAQH3zLV4bqct6mCuFNLYhmsMBsxtYM5ZfcNPHxO35GW/b5u5XKyFt3P
 JlGA==
X-Gm-Message-State: AOJu0Yzw0J+UfqDIgtAn3aO5Slp8/udZRm+pzXZl8IOwEppo203MrXz8
 rVxHQkTBfhB45dRldzSzcHGjV7axb7XVACNppFN8dU44rpD8znZ+8O2+3PetDMRXlqc9nKuC8jv
 ZWbEAN1zxic6YWn0AwvRSRc5jqZb7Zss=
X-Received: by 2002:a05:6a21:71c7:b0:181:2de9:92be with SMTP id
 ay7-20020a056a2171c700b001812de992bemr7970966pzc.26.1698981696997; 
 Thu, 02 Nov 2023 20:21:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJWlv6dR2yZTYBWHUaF+P2htqU19VsJRg6F3vkqwuGPqd8eZhchOHMQ8rcTUrX1Zml3+OZq6VHvGk57wdUAGU=
X-Received: by 2002:a05:6a21:71c7:b0:181:2de9:92be with SMTP id
 ay7-20020a056a2171c700b001812de992bemr7970960pzc.26.1698981696737; Thu, 02
 Nov 2023 20:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231025092925.1785934-1-armbru@redhat.com>
In-Reply-To: <20231025092925.1785934-1-armbru@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Thu, 2 Nov 2023 23:21:25 -0400
Message-ID: <CAFn=p-YaMqsc8QT+ZxGJy5W1GpKZFD009thpKa-A1ercM04tvg@mail.gmail.com>
Subject: Re: [PATCH] tests/qapi-schema: Tidy up pylint warnings and advice
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 25, 2023 at 5:36=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Pylint warns:
>
>     tests/qapi-schema/test-qapi.py:139:13: W1514: Using open without expl=
icitly specifying an encoding (unspecified-encoding)
>     tests/qapi-schema/test-qapi.py:143:13: W1514: Using open without expl=
icitly specifying an encoding (unspecified-encoding)
>
> Add encoding=3D'utf-8'.

This one I think actually matters in some cases. Some esoteric cases
where the platform default isn't UTF-8. Might happen on Windows where
it wants to use UTF-16 or UCS-2 or whatever.

>
> Pylint advises:
>
>     tests/qapi-schema/test-qapi.py:143:13: R1732: Consider using 'with' f=
or resource-allocating operations (consider-using-with)
>
> Silence this by returning the value directly.

Smart!

>
> Pylint advises:
>
>     tests/qapi-schema/test-qapi.py:221:4: R1722: Consider using sys.exit(=
) (consider-using-sys-exit)
>     tests/qapi-schema/test-qapi.py:226:4: R1722: Consider using sys.exit(=
) (consider-using-sys-exit)
>
> Sure, why not.

I have no idea why this matters, but I habitually use the sys.exit() form .=
..

https://docs.python.org/3.11/library/constants.html#constants-added-by-the-=
site-module

Oh, that's weird. Well, Sure, why not.

>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  tests/qapi-schema/test-qapi.py | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
> index d58c31f539..14f7b62a44 100755
> --- a/tests/qapi-schema/test-qapi.py
> +++ b/tests/qapi-schema/test-qapi.py
> @@ -136,12 +136,11 @@ def test_frontend(fname):
>  def open_test_result(dir_name, file_name, update):
>      mode =3D 'r+' if update else 'r'
>      try:
> -        fp =3D open(os.path.join(dir_name, file_name), mode)
> +        return open(os.path.join(dir_name, file_name), mode, encoding=3D=
'utf-8')
>      except FileNotFoundError:
>          if not update:
>              raise
> -        fp =3D open(os.path.join(dir_name, file_name), 'w+')
> -    return fp
> +    return open(os.path.join(dir_name, file_name), 'w+', encoding=3D'utf=
-8')
>
>
>  def test_and_diff(test_name, dir_name, update):
> @@ -218,9 +217,9 @@ def main(argv):
>          test_name =3D os.path.splitext(base_name)[0]
>          status |=3D test_and_diff(test_name, dir_name, args.update)
>
> -    exit(status)
> +    sys.exit(status)
>
>
>  if __name__ =3D=3D '__main__':
>      main(sys.argv)
> -    exit(0)
> +    sys.exit(0)
> --
> 2.41.0
>
>


