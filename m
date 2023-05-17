Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E582707421
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 23:23:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzObt-0001CY-TL; Wed, 17 May 2023 17:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzObq-0001BQ-SS
 for qemu-devel@nongnu.org; Wed, 17 May 2023 17:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzObp-00005n-9l
 for qemu-devel@nongnu.org; Wed, 17 May 2023 17:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684358576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8AV0ew/yqwncql9ULAetFdGupKmGDn9jjOXcE5y7pQQ=;
 b=Rdcayr8f+1lKL4TK7p+kT7zTE2vTAftuGPNts3jGcvngioQYyuzK5+7YSnfqWUieEyLQXl
 zNJhSLZ+ZtnZit06tyVKXD9cybwp5sK/akvkj6E9FyZz5briyPxTv6QTrSJ4ocD8yi0Oc6
 XUu1/SCbJEf+N4pnmkC/RUqLIXPqmkk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-B6QoY1TpOaqlN25BnmZHiQ-1; Wed, 17 May 2023 17:22:54 -0400
X-MC-Unique: B6QoY1TpOaqlN25BnmZHiQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-528cb2ec137so718554a12.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 14:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684358573; x=1686950573;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8AV0ew/yqwncql9ULAetFdGupKmGDn9jjOXcE5y7pQQ=;
 b=a3uhMHQu6oRvfoxcb/rgz01TjRay8F3GlM5SDxAEwGGb1VpJyWVqCvgFcM/Bes8yqd
 aILZCbmSugQafz6/DgyxmpqQLHyQhvKY5mc74yByen1qz9GLSZeWIK7HbEJBm3VWe1V2
 Jvscdad/xJpVtbISWDiACVp3inleendkuikROtEFfhWTmwmoYwcbUYBHZ3nCIb2ALsTM
 WDdmXyeXiMjLAfpNgRvQ/PDc/6UiUq3lJNwme6BWqsVPdrPFLXP0QSTrL3vZ4KReRZ+Y
 /EE4+72tJOKrZKwAsD5jHha8INi8JOZnBsS5zxXKrVg9UD64AutDa3bsbSL3KtOfFetu
 Nn0A==
X-Gm-Message-State: AC+VfDz0EfpAuMDznHUyPGpnu7qSV3EuI8UQ5NS2jcqykFjWAu9ms02c
 UAJjl4gYMOlm6NT1udn3wXiiH4qPlfBUX7UbtLMYe/yL9xMexLYKN0uogFa30vVNpyVRvX98Vsr
 qNPi0eucN7ev0WSCZ2fhHW7trzsIcV5U=
X-Received: by 2002:a05:6a20:1447:b0:103:9d9b:1ec6 with SMTP id
 a7-20020a056a20144700b001039d9b1ec6mr31707946pzi.28.1684358573553; 
 Wed, 17 May 2023 14:22:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6MRtzcoFcveFoTQZ51x8m+ZEL/ZZu7LOBumEX2UTEQmiwZiPstaF5GtGdUIKn7G61PEceJz4cIESK4jbVNBg0=
X-Received: by 2002:a05:6a20:1447:b0:103:9d9b:1ec6 with SMTP id
 a7-20020a056a20144700b001039d9b1ec6mr31707928pzi.28.1684358573284; Wed, 17
 May 2023 14:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230428132124.670840-1-nks@flawful.org>
 <20230428132124.670840-8-nks@flawful.org>
In-Reply-To: <20230428132124.670840-8-nks@flawful.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 17 May 2023 17:22:42 -0400
Message-ID: <CAFn=p-aotARJsZ-F8zCa56CLq2fzYUCQGCQzTq63bLPEGr2_KQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] hw/ide/ahci: trigger either error IRQ or regular IRQ, 
 not both
To: Niklas Cassel <nks@flawful.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Apr 28, 2023 at 9:23=E2=80=AFAM Niklas Cassel <nks@flawful.org> wro=
te:
>
> From: Niklas Cassel <niklas.cassel@wdc.com>
>
> According to AHCI 1.3.1, 5.3.8.1 RegFIS:Entry, if ERR_STAT is set,
> we jump to state ERR:FatalTaskfile, which will raise a TFES IRQ
> unconditionally, regardless if the I bit is set in the FIS or not.
>
> Thus, we should never raise a normal IRQ after having sent an error
> IRQ.
>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

ACK - and thanks for the spec pointers.

> ---
>  hw/ide/ahci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 2a59d0e0f5..d88961b4c0 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -891,11 +891,10 @@ static bool ahci_write_fis_d2h(AHCIDevice *ad, bool=
 d2h_fis_i)
>      pr->tfdata =3D (ad->port.ifs[0].error << 8) |
>          ad->port.ifs[0].status;
>
> +    /* TFES IRQ is always raised if ERR_STAT is set, regardless of I bit=
. */
>      if (d2h_fis[2] & ERR_STAT) {
>          ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_TFES);
> -    }
> -
> -    if (d2h_fis_i) {
> +    } else if (d2h_fis_i) {
>          ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_DHRS);
>      }
>
> --
> 2.40.0
>


