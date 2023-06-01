Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED95971F2C8
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 21:18:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4nnm-00038g-C3; Thu, 01 Jun 2023 15:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q4nnk-00038H-JQ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 15:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q4nni-0003j2-UM
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 15:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685647053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDNlZ2BU0kcrxY3KQfA58CsjR+aO3w9e8AMQwiT53YE=;
 b=OKetDwO239leW9+twKSzdyqUPdICxMzd9+3tudX2IlzHzKzGauP6JDUi9LdrO/HG0qUlzH
 PKT+466db6apaJaOnMlLeQPfO9XcmZZStwXps/vQdy+9YFW4DnS6UPutoixJxB4LzrKc0Z
 Wo1RqH+E4AHlX9qePEEHu8jQJw9+C+o=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-T_DmrLdfP6S8DzN6d1V01g-1; Thu, 01 Jun 2023 15:17:32 -0400
X-MC-Unique: T_DmrLdfP6S8DzN6d1V01g-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2568caac092so531879a91.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 12:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685647051; x=1688239051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDNlZ2BU0kcrxY3KQfA58CsjR+aO3w9e8AMQwiT53YE=;
 b=L8kgnnBvKcpO98Gx1hKV1F0al8p02naJMsCOrMlM1uJsOHsCTrKyCPL+pA5SgNHLSh
 27pc84obOhjpGcb5IoryYBSRi4Y6feOu3DNw87HTIk2pf2xEObnGAp6PpS6Elm57CYPp
 jCWFdT47vZqBFyYJ17MGCY4+wtlsktHrDIIIeT4SzCbSFFn+KeWSWAUe5NoDCrhka2kT
 sfvgvQbRH8LIGFifKkC+rargw7ZtnE3o07rzYm6D0CsXiSmf9I+cT+ayknYzjdQc3OTI
 EIL8rTpNYQiyzLa3Yv7oesKuFPreSNjpgGk0BKEkCITACi6igjASpqhhO0wCVTxeQkNW
 tZLA==
X-Gm-Message-State: AC+VfDynwCevsWw3wkXbR4675uYw1N0r5c0a8az0VpbeuJbAevPpKO+O
 NI5W2LbVbnxTc05ZICF8s9PnH3dUp4TFnFEYR1IfQsLbhgSI55lwF7iVnXVf3PgAmMewJH1c7KZ
 icbFTvnU63k1fPWCiskW7qK7prRixlrA=
X-Received: by 2002:a17:90a:5907:b0:255:8063:c8dd with SMTP id
 k7-20020a17090a590700b002558063c8ddmr279563pji.18.1685647051467; 
 Thu, 01 Jun 2023 12:17:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7RaiKKmX4PQXKVgBJ0Zidi9rwOwmnu2Pz1m2dzlGN/GWrs+qHtlkNZb22TQh/2Jwo/QaIg0UrJPXKal3lfgWE=
X-Received: by 2002:a17:90a:5907:b0:255:8063:c8dd with SMTP id
 k7-20020a17090a590700b002558063c8ddmr279546pji.18.1685647051074; Thu, 01 Jun
 2023 12:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230601134434.519805-1-nks@flawful.org>
In-Reply-To: <20230601134434.519805-1-nks@flawful.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 1 Jun 2023 15:17:19 -0400
Message-ID: <CAFn=p-bDmZmGyYrjij_5HtXEvyob8=yXYLZUNL4F9VHyYj0MGQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] misc AHCI cleanups
To: Niklas Cassel <nks@flawful.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jun 1, 2023 at 9:45=E2=80=AFAM Niklas Cassel <nks@flawful.org> wrot=
e:
>
> From: Niklas Cassel <niklas.cassel@wdc.com>
>
> Hello John,
>
> Here comes some misc AHCI cleanups.
>
> Most are related to error handling.
>
> Please review.
>
> (I'm also working on a second series which will add support for
> READ LOG EXT and READ LOG DMA EXT, but I will send that one out
> once it is ready. (It might take a couple of weeks still, since
> I've been a bit busy lately.))
>
>
> Changes since v1:
> -Picked up Reviewed-by tags.
>  (I did not convert your ACK to explicit Acked-by tags, since I assume
>  that the patches will go via your tree).

Guess so! I haven't been involved with IDE for a minute so I left the
ACKs in case I wandered off to signify that I hadn't reviewed them
thoroughly, but they *looked* good. Since I haven't wandered off,
guess I will actually take this and send an MR. I'll try to do this
Friday, June 2nd.

Thanks again for the very detailed commit messages, which make this easy. :=
)

--js

> -Rebased on master in order to fix a conflict in patch
>  "hw/ide/ahci: simplify and document PxCI handling".
> -Dropped patch "hw/ide/ahci: trigger either error IRQ or regular IRQ, not=
 both"
>  for now, as it caused a boot time regression in SeaBIOS.
>  This appears to be a bug in SeaBIOS, for more info see:
>  https://mail.coreboot.org/hyperkitty/list/seabios@seabios.org/thread/RIH=
V3FZ4EVMAJA4TEDPASKNYV7V72O4C/
>  I will resend the QEMU patch separately once the SeaBIOS patch has been
>  merged, and once QEMU has updated to a SeaBIOS tag that includes the fix=
.
>
>
> Kind regards,
> Niklas
>
> Niklas Cassel (8):
>   hw/ide/ahci: remove stray backslash
>   hw/ide/core: set ERR_STAT in unsupported command completion
>   hw/ide/ahci: write D2H FIS on when processing NCQ command
>   hw/ide/ahci: simplify and document PxCI handling
>   hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set
>   hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared
>   hw/ide/ahci: fix ahci_write_fis_sdb()
>   hw/ide/ahci: fix broken SError handling
>
>  hw/ide/ahci.c | 112 +++++++++++++++++++++++++++++++++++---------------
>  hw/ide/core.c |   2 +-
>  2 files changed, 81 insertions(+), 33 deletions(-)
>
> --
> 2.40.1
>


