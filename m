Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1205282D384
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:53:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPE2h-00007g-P8; Sun, 14 Jan 2024 22:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPE2f-00006m-25
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:53:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPE2d-0001Qd-GK
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:53:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705290818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o1ucEgltnbZgxlLtFPsvB8N/XTdBW9IT9kFKJmVZH0E=;
 b=cUIdfIohqQmD3gu2frpO0eij0OC2rkIEmux5AgW1A5PYGTiEFxlBSZAZ67v17v2Lldl6Z2
 +/OgGlkPpKo4nBsgxGL0qjQ8c/b+tBhDzRoLOXHJLzFPuWq4O6MmRGt3XumRqV1Rl+e1IW
 Im+CasXZhnfx1sEfTIoFvnBRkkypMQY=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-JfU_EyWgPfWYRpUKj_u7IQ-1; Sun, 14 Jan 2024 22:53:37 -0500
X-MC-Unique: JfU_EyWgPfWYRpUKj_u7IQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5ce8a3381a1so6754358a12.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:53:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705290816; x=1705895616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1ucEgltnbZgxlLtFPsvB8N/XTdBW9IT9kFKJmVZH0E=;
 b=iygtEbSjLO96DksMUQ0jCLpH7tYxHP/GdYNyjUnl/9BenWGQv+v4QkslOSLaIwOBWO
 Up4flaMmOrWodWSOEB60bETUqzTBozW7ANb6eYGu5Qm69xmV3vGByGk5JBf9z7T2pHkD
 kc5Rz1O0aIPaMHQXnf2dNnF2YCUIPgl/m1Fb8uYgU5BnpSm4DaHuXE2ibLZpLC4N3m5X
 KzE9GE+idvlh8RaOIKZTorA7BkfPQIKY2cKx64sjvCQr5wSJpUvA7NU0x/p2toSeZD/G
 hKj2ACoyLXuiMucWTwSXio0ym+2Q1wXZC5vH5n1ZaDJkg3K+Aob4W3Zlf9ZpCXSdQb8q
 JHPQ==
X-Gm-Message-State: AOJu0YzwjV3xXY8vJQtWgHg7bKBxUmuBFLh9aPjTJJqBMzWA65sAFgcI
 NBHjSasLiOewtOXZTWCgugpt9Neew8v8x3gS8UXrJAUp+4banPolR/yTnzRYJQg88bsj3sn+5oq
 jndACUOG7quPKXuOY0EWItWWEfBTQiCStvAM+EzQ=
X-Received: by 2002:a05:6a20:9c8b:b0:19a:e527:594 with SMTP id
 mj11-20020a056a209c8b00b0019ae5270594mr2385699pzb.106.1705290816150; 
 Sun, 14 Jan 2024 19:53:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGurYHkyMJH7LBxProOKI9JJQ3lg06GDfcvzQ0qcJAfaEF0CGvLMuGf1+qnv5Bs7WpO1TSXUeV/y5gMtWdI7Ck=
X-Received: by 2002:a05:6a20:9c8b:b0:19a:e527:594 with SMTP id
 mj11-20020a056a209c8b00b0019ae5270594mr2385688pzb.106.1705290815923; Sun, 14
 Jan 2024 19:53:35 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-38-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-38-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 11:53:24 +0800
Message-ID: <CACGkMEunbqOuPpBu9JQK9a+6-6a96iChPgJXT3Dn=7dRaWj95A@mail.gmail.com>
Subject: Re: [PATCH 37/40] vdpa: add vhost_vdpa_set_dev_vring_base trace for
 svq mode
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Fri, Dec 8, 2023 at 2:51=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> For better debuggability and observability.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


