Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ADD79717C
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 12:32:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeCIo-00048X-LI; Thu, 07 Sep 2023 06:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1qeCIg-00042c-Hf
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1qeCId-0007GL-Rq
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694082704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVx2pK7HTr9ICUZyOYy8UOAD02imsiWTwjbVJyL9+KY=;
 b=ScqV58ltjhgqZLUNR/swxrbVq8ESzL93b2ZvUKRRBGb2r1GZl+0/nbuvc4RQLirNdNkg2d
 KX7HIkK898arWiob/QvcXGZiGgbiDOzrSZSC/Uoio5PCGT9IOszoDzTVfozvymXCBW3onv
 kJaCx30+8TwiD+7RhyIKGOw5TLIrknE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-ClAV3e1pPuKw6WaH8R97Jw-1; Thu, 07 Sep 2023 06:31:42 -0400
X-MC-Unique: ClAV3e1pPuKw6WaH8R97Jw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-500a9156daaso863889e87.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 03:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694082701; x=1694687501;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVx2pK7HTr9ICUZyOYy8UOAD02imsiWTwjbVJyL9+KY=;
 b=kMvaNMs40vdo2j9Sj1xLbbDK6gCPQN3gBxvnm16D4AsQAXIikpjI4ZT7zZBqr1EWte
 ok7e41JruFhoNbft8BC/G08RxrFpccHHeLyL7mvOBtyi0WT99QTB1h9T7LgjNhsppjd9
 iFWP3/ZQ8STz705g4fQMZtyJ3URXejJYVdoY4rbkxFgoBWqATWdgx3lH0/zZf8hXab2q
 WGVHRlIXnv1WJIWsbzNIKx8udr9QmAC8bnflT5BEXNkwX2X5sVuduhh9WU6vwyeprpro
 575T0aMz1DMDGmfdP+BkfZhc8w6PUdgdS1xZcWV32kaVjn68c7Sk8cZcv+QwtA25a/M3
 rFSg==
X-Gm-Message-State: AOJu0YzmF+OryQ1kPG7t2+Z/YtS7u9Xrz+m6lKsPH45tPWj1k54A9m+A
 YxDbk6G0iI2R1AwAdpmdqJBS2dbHkBBnQl5amC8weaCC3suMeu9KD99vYp3x2OeZutCHvDDWZiW
 5pQapII5I2oBtgjLv8/Tj3CApwthSapw=
X-Received: by 2002:a2e:9c94:0:b0:2bc:d607:4d07 with SMTP id
 x20-20020a2e9c94000000b002bcd6074d07mr3795129lji.11.1694082701281; 
 Thu, 07 Sep 2023 03:31:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdZ5GBC8jP0FEwsocLvccpUsZUf/axxicbBr9mxpGtH850U8w7zFwHlmZsxrlFfO6WLj+J7RqidfpTHwWxaBY=
X-Received: by 2002:a2e:9c94:0:b0:2bc:d607:4d07 with SMTP id
 x20-20020a2e9c94000000b002bcd6074d07mr3795116lji.11.1694082700975; Thu, 07
 Sep 2023 03:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230906120503.359863-1-david@redhat.com>
 <20230906120503.359863-8-david@redhat.com>
In-Reply-To: <20230906120503.359863-8-david@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Thu, 7 Sep 2023 12:31:30 +0200
Message-ID: <CAMXpfWu_AC87EkAHT-H5LaYNSEHsbjMfEN2PXrX5fN=QFcB+0A@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] softmmu/physmem: Never return directories from
 file_ram_open()
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series has been successfully tested by QE. Specify a directory
for the mem-path of a memory-backend-file object. Check the error
message has been improved without referring to a device, which can
lead to confusion.

Tested-by: Mario Casquero <mcasquer@redhat.com>






On Wed, Sep 6, 2023 at 2:07=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> open() does not fail on directories when opening them readonly (O_RDONLY)=
.
>
> Currently, we succeed opening such directories and fail later during
> mmap(), resulting in a misleading error message.
>
> $ ./qemu-system-x86_64 \
>     -object memory-backend-file,id=3Dram0,mem-path=3Dtmp,readonly=3Dtrue,=
size=3D1g
>  qemu-system-x86_64: unable to map backing store for guest RAM: No such d=
evice
>
> To identify directories and handle them accordingly in file_ram_open()
> also when readonly=3Dtrue was specified, detect if we just opened a direc=
tory
> using fstat() instead. Then, fail file_ram_open() right away, similarly
> to how we now fail if the file does not exist and we want to open the
> file readonly.
>
> With this change, we get a nicer error message:
>  qemu-system-x86_64: can't open backing store tmp for guest RAM: Is a dir=
ectory
>
> Note that the only memory-backend-file will end up calling
> memory_region_init_ram_from_file() -> qemu_ram_alloc_from_file() ->
> file_ram_open().
>
> Reported-by: Thiner Logoer <logoerthiner1@163.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  softmmu/physmem.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 138402b6cf..f1cd3ec28a 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -1299,6 +1299,25 @@ static int file_ram_open(const char *path,
>      for (;;) {
>          fd =3D open(path, readonly ? O_RDONLY : O_RDWR);
>          if (fd >=3D 0) {
> +            /*
> +             * open(O_RDONLY) won't fail with EISDIR. Check manually if =
we
> +             * opened a directory and fail similarly to how we fail ENOE=
NT
> +             * in readonly mode. Note that mkstemp() would imply O_RDWR.
> +             */
> +            if (readonly) {
> +                struct stat file_stat;
> +
> +                if (fstat(fd, &file_stat)) {
> +                    close(fd);
> +                    if (errno =3D=3D EINTR) {
> +                        continue;
> +                    }
> +                    return -errno;
> +                } else if (S_ISDIR(file_stat.st_mode)) {
> +                    close(fd);
> +                    return -EISDIR;
> +                }
> +            }
>              /* @path names an existing file, use it */
>              break;
>          }
> --
> 2.41.0
>
>


