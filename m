Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FE470741F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 23:22:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzOat-0000Qh-PJ; Wed, 17 May 2023 17:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzOaq-0000On-UG
 for qemu-devel@nongnu.org; Wed, 17 May 2023 17:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1pzOao-0008Of-Qw
 for qemu-devel@nongnu.org; Wed, 17 May 2023 17:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684358513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6NxqPrNiunR1N22HAV84oETohpAPzX1v46xAsVDBqKw=;
 b=HiTgn0keAfr2yxEET6oh+7h0RpX+LDvuVDoc46jg3uQAYDH8Nm728MW9p8+IRAqVR+P0jZ
 nau9rqB2dqUlnecx0xC2HIfFxFfoJic0VbShgdZAD4zJ2OM+5XUHHprmmPwnioEw+3Y1x0
 MxOjVY+kuYIM5CvqOmBJE2bmhKmiDTI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-guLyFj8-PmKXZgjE-tNTZQ-1; Wed, 17 May 2023 17:21:51 -0400
X-MC-Unique: guLyFj8-PmKXZgjE-tNTZQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1ae438721e2so8228505ad.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 14:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684358511; x=1686950511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6NxqPrNiunR1N22HAV84oETohpAPzX1v46xAsVDBqKw=;
 b=G7Mxmsz9ODuof6OqBxCguAYP45XuKI6cVW77BCuEtRtfDn0IPDXVMfL+AeOc27IRwR
 Mk/xZFlZGRWfzSLt/SS333lGpzl2EVWMLWOfMsFY4JMDgJRDEby7hX8EpUVrDmGkxRVO
 9VC/kF3TLpZSi1nta8xkGvWSQQNNOtbt1aYNLTii6ESidzF9hETuWeaTL/vXlmjyV0zO
 8FiVq+eQBeJslrmTj1iTbpzMF2wXOd7tU2LMWpM5KsWVjUktpdoj/VK06ruqnS7n83NC
 PNP27k/IrxVJ6HOmiii3pK+1UszLAj6eB/1/SgaAjNVe1fH6hgcRpfkEpugW7tfNby7h
 6ANA==
X-Gm-Message-State: AC+VfDyQt8pUmCYah8I5cTs+a7vdn1E5+ycWpQWx+HG+ATJv29C30k8y
 CAWKJPEmJiuPNDl46LZgd6FfjOXjT9/rFAmtaf3Zg6JshMJzMLmDvUWjjZK7cQnvsToZYHN+E2g
 +VBTGWb33H36lG0GcWak9ZagraqaxVKI=
X-Received: by 2002:a17:902:ec86:b0:1ad:e746:ca50 with SMTP id
 x6-20020a170902ec8600b001ade746ca50mr280658plg.2.1684358510909; 
 Wed, 17 May 2023 14:21:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RQJrKMM32jOlD2In9ZyyRSm2jlMKi3LBD4SmPQEnAEiwJMEe5c+JQWnmIXOqsHhgBkWRG0lfWXYwT13owpHk=
X-Received: by 2002:a17:902:ec86:b0:1ad:e746:ca50 with SMTP id
 x6-20020a170902ec8600b001ade746ca50mr280644plg.2.1684358510635; Wed, 17 May
 2023 14:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230428132124.670840-1-nks@flawful.org>
 <20230428132124.670840-7-nks@flawful.org>
In-Reply-To: <20230428132124.670840-7-nks@flawful.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 17 May 2023 17:21:39 -0400
Message-ID: <CAFn=p-bHgKnFXfsTVoP9XotnNEV_oQ=tAqzh2SUDsYxeZBWXKg@mail.gmail.com>
Subject: Re: [PATCH 6/9] hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST
 is cleared
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
> According to AHCI 1.3.1 definition of PxSACT:
> This field is cleared when PxCMD.ST is written from a '1' to a '0' by
> software. This field is not cleared by a COMRESET or a software reset.
>
> According to AHCI 1.3.1 definition of PxCI:
> This field is also cleared when PxCMD.ST is written from a '1' to a '0'
> by software.
>
> Clearing PxCMD.ST is part of the error recovery procedure, see
> AHCI 1.3.1, section "6.2 Error Recovery".
>
> If we don't clear PxCI on error recovery, the previous command will
> incorrectly still be marked as pending after error recovery.
>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

ACK.

> ---
>  hw/ide/ahci.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index 366929132b..2a59d0e0f5 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -329,6 +329,11 @@ static void ahci_port_write(AHCIState *s, int port, =
int offset, uint32_t val)
>          ahci_check_irq(s);
>          break;
>      case AHCI_PORT_REG_CMD:
> +        if ((pr->cmd & PORT_CMD_START) && !(val & PORT_CMD_START)) {
> +            pr->scr_act =3D 0;
> +            pr->cmd_issue =3D 0;
> +        }
> +
>          /* Block any Read-only fields from being set;
>           * including LIST_ON and FIS_ON.
>           * The spec requires to set ICC bits to zero after the ICC chang=
e
> --
> 2.40.0
>


