Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9D972650C
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:51:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vRP-0001BF-QH; Wed, 07 Jun 2023 11:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q6vRN-0001B1-Ru
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q6vRM-0003v2-Ax
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686153071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7LAsMwOoRW9vxB/bJFrMJqDsO4El51/KsPZ21eyYmw=;
 b=EUoUM+gHoloqJ83Cur6wkr/34F1myQVpsPTi21OERDq5t69UnfDPeJ8euj8mbgiVDdVbaA
 W0H6kEXx3nIqtvQ38JQl7OGW3Vx4CN0nySE2MQfpo1R31RFM7HOe6xvMaarFj1OnQE8SzV
 NofgClVnjN+uPOi6IIVXfpVaI72nkgQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-PbKk-Gv0PiaIsDtrgHT3Tg-1; Wed, 07 Jun 2023 09:53:26 -0400
X-MC-Unique: PbKk-Gv0PiaIsDtrgHT3Tg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-568a8704f6dso112285997b3.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 06:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686146006; x=1688738006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q7LAsMwOoRW9vxB/bJFrMJqDsO4El51/KsPZ21eyYmw=;
 b=e28zzdwCu3BxYs9Tj+GGblgr9L6j4aoZ1/kKJCyjyRiLKdCptzeFqOtWXzzy924rqO
 No2+DT2TzuTk56qyr+Oc52g5pcSd+73v9Dg88t4dteEzLn4o48sNDeaCjyIF5DT4jPRt
 pBZY8pXTBjJDXq4QYJyaAC3tl8INNiJqNvI3qmDgj1WLlrJrRF6JrQyU6i/ZESy051R0
 Daw3LvNf6/tPm4tTbg3/gOhV4hLYw0WHklcb0dbaBI38UdWK1GSAiAP+HdQ9SF+AOSpx
 eDYDMMLrtLHHodz1Q4N0oCfrivjnziky0shEEZTFK8MJOgWMIa+pPRxZKug+Hc/dloMk
 yMJA==
X-Gm-Message-State: AC+VfDzzJGp3M+dsBQLnERYyRCdxUg8e72i2n97rrVtMP3/1CV0lJ28G
 iVnlkAUgiCVb/Iuo4820IKH6ev/5CDwTAjff17HjNIxhMJdJ4bbOJ5yOb5292anLUwp2N9kAW7X
 VgWpGAeUZnCJEnJsKqLFD/9bLpOvqw5M=
X-Received: by 2002:a81:4e44:0:b0:561:d6dd:bc84 with SMTP id
 c65-20020a814e44000000b00561d6ddbc84mr6462841ywb.48.1686146006062; 
 Wed, 07 Jun 2023 06:53:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ51EQwNL5cxvSrsf0xMynsnAx4JJEfLO9swPYVdSk3+2b8LZBGYjyLjPxEeFRK6K5jONtPzeXYWRJ71TS2VACw=
X-Received: by 2002:a81:4e44:0:b0:561:d6dd:bc84 with SMTP id
 c65-20020a814e44000000b00561d6ddbc84mr6462827ywb.48.1686146005778; Wed, 07
 Jun 2023 06:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230602173451.1917999-1-eperezma@redhat.com>
 <47527a58-039e-55e7-3541-bcd7ceb3296a@tls.msk.ru>
In-Reply-To: <47527a58-039e-55e7-3541-bcd7ceb3296a@tls.msk.ru>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 7 Jun 2023 15:52:49 +0200
Message-ID: <CAJaqyWeAsSJBhDtGkGTuf+uQsaEMOsNYMzhbwkJ6yAJ1-q+9pA@mail.gmail.com>
Subject: Re: [PATCH] vdpa: fix not using CVQ buffer in case of error
To: mjt@tls.msk.ru
Cc: qemu-devel@nongnu.org, Cindy Lu <lulu@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Lei Yang <leiyang@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Hawkins Jiawei <yin31149@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jun 7, 2023 at 12:11=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 02.06.2023 20:34, Eugenio P=C3=A9rez wrote:
> > Bug introducing when refactoring.  Otherway, the guest never received
> > the used buffer.
> >
> > Fixes: be4278b65fc1 ("vdpa: extract vhost_vdpa_net_cvq_add from vhost_v=
dpa_net_handle_ctrl_avail")
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >   net/vhost-vdpa.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
>
> Again, smells like a stable material, is it not?
>
> Please Cc: qemu-stable@nongnu.org for other changes you think should be
> applied to stable qemu series.
>

Sorry, I totally forgot. This one should go to stable, yes.

Thanks!


