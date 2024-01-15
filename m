Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A03FE82D37B
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:49:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPDy1-0005zY-DH; Sun, 14 Jan 2024 22:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDxz-0005z8-IW
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:48:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDxy-0000dT-2B
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705290529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=un/QPyKFj6nxAT369C51fWYPwwGBK+EwrPpmzpyp1TA=;
 b=XwtX5WV408GxqxocUqyS1EaRQY+n4Yy4jiJ1920lYrbzq1a/3xTG7wyWqFhYP/f/O0wLr5
 2yLSQkQhw68v+nmLnm8W4LDrL4QTnxBrySYNmMtrmR7D4kpbzQCC1ZyupaplYkz5AVirbc
 4AX8uSAM2TcBcs8TZuujs4Mji/DKoUw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-onwVM9PEOm2hU_8Qh2wceA-1; Sun, 14 Jan 2024 22:48:47 -0500
X-MC-Unique: onwVM9PEOm2hU_8Qh2wceA-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6ddec7b52e7so6096023a34.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705290527; x=1705895327;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=un/QPyKFj6nxAT369C51fWYPwwGBK+EwrPpmzpyp1TA=;
 b=DGKMr7CTvNHpej0w6Nr2dc87Ah08I3hLOz0nopu2ij+RFXTcH9hVB8n8KkjI6oEGQI
 HTkAT4ag9GoWAnp6djxUiS2wXez2GU+TF37JXApjQDKCLQleyEPwfbrAc+rmCDzi+GS9
 8e6GZnvsle7TaaBH9dXDdgqji/j1c30qu0vzElU1g+sFLGhLyo2FtvHWE2BY2JgiHSBy
 pfPqaPlk1t+wHCdHnikpiYMfQUPnuMCyrdNqiYpTpeWvQHr+VD5J3c1AdVbbiucCvsmH
 dogbl7sUCQrgv6qevGunF6cGnIGHGVUBapIE3l7mpaaCp/NTnPgjUqYKpoYhOjcgr1aK
 sinw==
X-Gm-Message-State: AOJu0YzQdL9yrId8K9C3TUQFtUzJ5n0y2+Q0ZqwSJTbhfEe5Ceun14VX
 mOFXMFQkOp0ZfG+piKKYEaHdD9Dm+2izcdY1RrJ3UxHVB61tP6eMqHNorAhJNtg6d/Pwv6iQSXh
 xeyMz82IXhaKZqtd61TrxtPoccN0vvmnaXg6jqMM=
X-Received: by 2002:a9d:5609:0:b0:6dd:ebd1:4618 with SMTP id
 e9-20020a9d5609000000b006ddebd14618mr4209384oti.73.1705290527276; 
 Sun, 14 Jan 2024 19:48:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv127lcPmL+bAD65EK7s82AjifdtlOWLINRaMz3KiHjn685BuIOsDM1TptIwvkjf6Wewx3jAOtCRnHWyw0s1g=
X-Received: by 2002:a9d:5609:0:b0:6dd:ebd1:4618 with SMTP id
 e9-20020a9d5609000000b006ddebd14618mr4209377oti.73.1705290527098; Sun, 14 Jan
 2024 19:48:47 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-35-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-35-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 11:48:36 +0800
Message-ID: <CACGkMEuQaqU33McmowfmEMG59Qs0Jx_AUEk=HBBx6_10u_96qQ@mail.gmail.com>
Subject: Re: [PATCH 34/40] vdpa: fix network breakage after cancelling
 migration
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Dec 8, 2023 at 2:51=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Fix an issue where cancellation of ongoing migration ends up
> with no network connectivity.
>
> When canceling migration, SVQ will be switched back to the
> passthrough mode, but the right call fd is not programed to
> the device and the svq's own call fd is still used. At the
> point of this transitioning period, the shadow_vqs_enabled
> hadn't been set back to false yet, causing the installation
> of call fd inadvertently bypassed.
>
> Fixes: a8ac88585da1 ("vhost: Add Shadow VirtQueue call forwarding capabil=
ities")
> Cc: Eugenio P=C3=A9rez <eperezma@redhat.com>

Let's cc stable and post this as an independent patch.

>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


