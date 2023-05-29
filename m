Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B879A714775
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 11:53:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ZYS-0007wF-Cb; Mon, 29 May 2023 05:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q3ZYQ-0007vi-7z
 for qemu-devel@nongnu.org; Mon, 29 May 2023 05:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q3ZYO-0003OI-Mc
 for qemu-devel@nongnu.org; Mon, 29 May 2023 05:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685353959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwuk3XbFudx6gTGXIRjNA9EjwdNlo/TlIOsjbbP/qUU=;
 b=R79saFJkUYoYUI7Hrfi69zTQvbnkvzPa1X9Lg7BDdtQrmU0m+KqepprRsJ47X8EAe+l3el
 kl5v4ZteLtaRRJ7lfbJCSQ7BO8bRWPfX72ISgE+a+emAvPzbTIHlpxuMOXC/3tu9UTM/om
 ndBTHOWkmiKe/pei3eOA5CK6lF64Xg8=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-NyDJcyNfM2yImZun1jP9gg-1; Mon, 29 May 2023 05:52:38 -0400
X-MC-Unique: NyDJcyNfM2yImZun1jP9gg-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-4572aa34839so597584e0c.3
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 02:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685353958; x=1687945958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qwuk3XbFudx6gTGXIRjNA9EjwdNlo/TlIOsjbbP/qUU=;
 b=bA0nCNxbF77Aik252cTCvBs6Dtt+Ww0zWsmzNklpnUXTn5Vr5214/nBPkXyj8/POpZ
 jd606ZrYcy92fL7Dk649H9PPlKl8iD25TXj6mcyuMptx5F8YMOkNpJmi+34jeI3QF6c7
 +PBptaI1NjYX45AD/wb/+NaTfnxIlcpBOGkwFQRMz1HVf4JxaPBv3rBq2dbQBYJ5IKbG
 nG6avix+s45fr2ZW1GNvGCQLfBUqyI8zSe96Ue81mpTF05m5YjPoj9Kxn85TASu0ZEWx
 9LGZ2QA8oBzn8cWEA9XvKJ0GOk5M0n6tagYIRsQGf7uk1lX/JJKVQYWOuVJuj/Jv/20A
 //Qw==
X-Gm-Message-State: AC+VfDyM6uT4gK593CNmOySqhuk8pCJbfzseuVT9MMzv1fA/jA+/nv5+
 07vIqNKO28sgvzck7o/gfBEhB8OwgEbSkxY1nks8gyyOioE+lKK2Pnb0Pq59SZnjymt6aWjTmlP
 UXDCVIjIRiaFHRQtHGRD+2UYPZXNbv5Q=
X-Received: by 2002:a1f:ca01:0:b0:44f:f77f:f37 with SMTP id
 a1-20020a1fca01000000b0044ff77f0f37mr1975498vkg.11.1685353957875; 
 Mon, 29 May 2023 02:52:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ49N7hudmx8MNcFmjtL6b/HLNes0jQaWqQP6iK8jbRw3ll65M95VzGXLrG+22LZMEX+sbi1E+Ia2E6j4S10jiY=
X-Received: by 2002:a1f:ca01:0:b0:44f:f77f:f37 with SMTP id
 a1-20020a1fca01000000b0044ff77f0f37mr1975489vkg.11.1685353957622; Mon, 29 May
 2023 02:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230301142926.18686-1-yuval.shaia.ml@gmail.com>
 <810d20a1-4af7-ab16-0f38-a4b56dc27f97@msgid.tls.msk.ru>
In-Reply-To: <810d20a1-4af7-ab16-0f38-a4b56dc27f97@msgid.tls.msk.ru>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Mon, 29 May 2023 11:52:26 +0200
Message-ID: <CAA8xKjWT2enLtrWUb7TVW8rFaPzm+bKBN8T-scQ8TeYdStWCpQ@mail.gmail.com>
Subject: Re: [PATCH v1] hw/pvrdma: Protect against buggy or malicious guest
 driver
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>, qemu-devel@nongnu.org,
 soulchen8650@gmail.com, 
 qemu-security@nongnu.org, marcel.apfelbaum@gmail.com, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
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

On Mon, May 15, 2023 at 6:13=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 01.03.2023 17:29, Yuval Shaia wrote:
> > Guest driver allocates and initialize page tables to be used as a ring
> > of descriptors for CQ and async events.
> > The page table that represents the ring, along with the number of pages
> > in the page table is passed to the device.
> > Currently our device supports only one page table for a ring.
> >
> > Let's make sure that the number of page table entries the driver
> > reports, do not exceeds the one page table size.
> >
> > Reported-by: Soul Chen <soulchen8650@gmail.com>
> > Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
> > ---
> > v0 -> v1:
> >       * Take ring-state into account
> >       * Add Reported-by
> > ---
> >   hw/rdma/vmw/pvrdma_main.c | 16 +++++++++++++++-
> >   1 file changed, 15 insertions(+), 1 deletion(-)
>
> Fixes: CVE-2023-1544
>
> Ping ^2?

Ping ^3?

> Laurent, maybe you can take this one too?
> I understand the fact you picked up the previous one in this area
> does not make you pvrdma maintainer, but it is definitely being stuck.. :=
)
>
> /mjt
>


--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


