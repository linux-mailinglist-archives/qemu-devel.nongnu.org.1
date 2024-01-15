Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C544B82D35E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:35:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPDkB-0000rJ-5X; Sun, 14 Jan 2024 22:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDk7-0000qc-7h
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:34:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDk4-0006kM-ON
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705289668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iUrXopHsU/G9irdTd3gEEOSS6KMgDcSP0Lx6xufz8Vg=;
 b=AcJfbnp+n0dIG9+0Jf6vwL3LJBUShHAV/GMawjtUgI+woJBWMJb1p9EhqynYGCIW9CPTBK
 2cdBAOTwAUmrgt4MCCmvUzwmg43ndseCBho4BhpQJ8x34S8DCOIDOTC6+hGzvlVvK0jSIh
 y1Qbme4hw9+h7mmX1UFJE3lmZKvnEFQ=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-uGxvyTrjMEGW0yofyHbu0Q-1; Sun, 14 Jan 2024 22:34:26 -0500
X-MC-Unique: uGxvyTrjMEGW0yofyHbu0Q-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6dde19a22b0so6877796a34.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705289666; x=1705894466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iUrXopHsU/G9irdTd3gEEOSS6KMgDcSP0Lx6xufz8Vg=;
 b=F3hLDb+7ZS0reqiX7c2Uz20Q4lAMAuPHcGoiQgaObWoCy+R1WSFKJHXyvjPyYB6I6z
 EdOb0rzXpFg8KkAs9Qwx7GuzLomEpi69h3qUJnoGiHL6VxcYK2vU1CACl7eP4QnCWgKo
 NZ7k9vzPk+fu6cUBtoWfPAO//jbr2APh6Xzs/9yU9xy9NUNjP/AbrKruweKXnWJgnYwi
 oOJwF1oeiF+wpkk5NPLDAU4aARt3fe+aZAbLh4CAvZ5t+mcParOFxJ/VICjCEHc64PWq
 c4FvjGOHAUQxX0WzoZ8/MkydhjdxZrZIS/6ucG9rk4+7N8Y17ubv0cNq4xnxx8Np/L9t
 qhrA==
X-Gm-Message-State: AOJu0Yx/bmOK6i4o6leWiX/MbeEa1R2W3OOAd7e8/em0aoF0675P1jL1
 MMnt1kNI5tGza7rJOvJP5tDOP9RI8e9ooGGYlPLNEoDEVe4gXqHmMT3pijVlfcqDq4KUTdZuTd2
 yAhwg+2Sqwn7Sor2pNsJWigYaacmEfEciZwP274g=
X-Received: by 2002:a05:6830:e15:b0:6df:b685:84b9 with SMTP id
 do21-20020a0568300e1500b006dfb68584b9mr5190922otb.32.1705289665997; 
 Sun, 14 Jan 2024 19:34:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEW0Cpr9WmXdd+wlvp4klAqX/9xoieiMS+dPt9gpGt6Obub5yZnGtDgVjXL5mWlF9J+WI45UHfG7m0pw/rzbCM=
X-Received: by 2002:a05:6830:e15:b0:6df:b685:84b9 with SMTP id
 do21-20020a0568300e1500b006dfb68584b9mr5190908otb.32.1705289665760; Sun, 14
 Jan 2024 19:34:25 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-32-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-32-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 11:34:14 +0800
Message-ID: <CACGkMEtoVKtSiFKkiN6nk88MoBEsr=oxMYXyPRhJeFrNGZCnLA@mail.gmail.com>
Subject: Re: [PATCH 31/40] vdpa: batch map and unmap around cvq svq start/stop
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
> Coalesce map or unmap operations to exact one DMA
> batch to reduce potential impact on performance.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


