Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 049DE71FF9B
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 12:42:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q52DZ-0005DH-Is; Fri, 02 Jun 2023 06:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q52DY-0005D9-4I
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q52DW-00069u-BR
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 06:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685702468;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=khcPOw4CCNbeH6a7aBFVIKcWVrIhc2W1UZg0dPw4jno=;
 b=Dl7HYOCe4i2xLUUKMm+5mrIKz9jnBvMTeBhmvfMQVhSchpGddacItdDblqU+noAw0GkSGr
 2KFEFa+84sy+/LBUA/6A6WMsMNQU8ChGXUEAQqtJqCelE55MOCinpbqt/hIg4u8n+sC/qM
 NbjMuzII3FmXaHy52FA4EzCAhebzv9g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-hMseXeD9OQO03nHhIf-usg-1; Fri, 02 Jun 2023 06:41:07 -0400
X-MC-Unique: hMseXeD9OQO03nHhIf-usg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f725f64b46so10644165e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 03:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685702466; x=1688294466;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=khcPOw4CCNbeH6a7aBFVIKcWVrIhc2W1UZg0dPw4jno=;
 b=Qcm/S1Z2omB23KYgIfa+eQizXK15zzIopEYnBWSegD6/AQAArIjjedSdA+CYIRfCkh
 2M9NlXW2UJYTgkpbBGalFrJd8kTnit1+7qhWBxGbtuSyNq4QzxXDlzutFpb1CLSV201I
 uGDqIYJLHvse2MMd+RyiMynTI1W0rnMvPZF69N6JnR4UPl4K9MuMi2OiDnfrS6POd4Ek
 Q0YdljM6BvNJI+qPR1lPg3mwB2ppVG4XY+iMXq/S45ojH55VnbR1fE7gHSdDrw0rLR1l
 TtPSAO8eumouibOd+0Zu92pG5nHVcwRRcQVex5oH7FPUSRrxtmip/rXSTmaEV1HRh/BV
 3UDQ==
X-Gm-Message-State: AC+VfDw0ZXdmv0d2qPC4+wH7yRV0j93iX27ToAVtP9WAIMsc7KfIQJQb
 eFa2Tjci7IJu/O/Xp9Mo92wyE/jiWt4vIJpHsAzPGq1tT8tw5F2ox+Tbsi6ntwJyTGFuagFFGdE
 XafejUhd44VSJZ3KO/9+R/St7PA==
X-Received: by 2002:a1c:cc11:0:b0:3f6:eff:279a with SMTP id
 h17-20020a1ccc11000000b003f60eff279amr1682767wmb.9.1685702466095; 
 Fri, 02 Jun 2023 03:41:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5HojBllnSBwAecpGVAzWkGSsvP2ED05z9zzbxFZbxAmv6MNU7I1B7gehsczXaea2gAvMk4ow==
X-Received: by 2002:a1c:cc11:0:b0:3f6:eff:279a with SMTP id
 h17-20020a1ccc11000000b003f60eff279amr1682758wmb.9.1685702465817; 
 Fri, 02 Jun 2023 03:41:05 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 c12-20020a05600c0acc00b003f606869603sm5147232wmr.6.2023.06.02.03.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 03:41:05 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  Richard Henderson
 <rth@twiddle.net>
Subject: Re: Big TCG slowdown when using zstd with aarch64
In-Reply-To: <ZHnBAjY/B/rEQzTB@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 2 Jun 2023 11:14:26 +0100")
References: <87y1l2rixp.fsf@secure.mitica> <ZHnBAjY/B/rEQzTB@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 02 Jun 2023 12:41:04 +0200
Message-ID: <87edmup2nz.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> On Thu, Jun 01, 2023 at 11:06:42PM +0200, Juan Quintela wrote:
>>=20
>> Hi
>>=20
>> Before I continue investigating this further, do you have any clue what
>> is going on here.  I am running qemu-system-aarch64 on x86_64.
>
> FYI, the trigger for this behaviour appears to be your recent change
> to stats accounting in:
>
> commit cbec7eb76879d419e7dbf531ee2506ec0722e825 (HEAD)
> Author: Juan Quintela <quintela@redhat.com>
> Date:   Mon May 15 21:57:09 2023 +0200
>
>     migration/multifd: Compute transferred bytes correctly
>=20=20=20=20=20
>     In the past, we had to put the in the main thread all the operations
>     related with sizes due to qemu_file not beeing thread safe.  As now
>     all counters are atomic, we can update the counters just after the
>     do the write.  As an aditional bonus, we are able to use the right
>     value for the compression methods.  Right now we were assuming that
>     there were no compression at all.
>=20=20=20=20=20
>     Signed-off-by: Juan Quintela <quintela@redhat.com>
>     Reviewed-by: Peter Xu <peterx@redhat.com>
>     Message-Id: <20230515195709.63843-17-quintela@redhat.com>
>
>
>
> Before that commit the /aarch64/migration/multifd/tcp/plain/{none,zlib,zs=
td}
> tests all took 21 seconds eachs.
>
> After that commit the 'none' test takes about 3 seconds, and the zlib/zstd
> test take about 1 second, except when zstd is suddenly very slow.

Slowdown was reported by Fiona.

This series remove the slowdown (it is an intermediate state while I
switch from one counter to another.)

Subject: [PATCH v2 00/20] Next round of migration atomic counters

But to integrate it I have to fix the RDMA fixes that you pointed
yesterday and get the series reviewed (Hint, Hint).

Will try to get the RDMA bits fixed during the day.

Thanks for the report, Juan.


