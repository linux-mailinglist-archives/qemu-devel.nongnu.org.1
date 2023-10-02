Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B10EF7B4BED
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 08:59:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnCrt-00073c-7w; Mon, 02 Oct 2023 02:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnCrq-00073S-6J
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnCro-0004iP-P0
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 02:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696229839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pxd36zTsT0PX2PtoMf5L2s0tJWW5bkpx+2TO+OQ0EE=;
 b=GFtjNzfk2nJOM5I07yxvOBm73fOfMZa9sK7XpcjBvC/t6dtphwEkzm9YZGSEZ/A5aX7CaU
 55z6V2kg1thm3RUIyfA/CUdv0GmDnZrl2dMoUMYYrWmswGDHGLv/eAka58VeCKIJHCQMeY
 I/mvhUaHWT06pb9cRmcOwD2mR+z/fk0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-H7UBK5WqPwGGnHp0cxVgTA-1; Mon, 02 Oct 2023 02:57:08 -0400
X-MC-Unique: H7UBK5WqPwGGnHp0cxVgTA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3217fdf913dso11989612f8f.3
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 23:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696229827; x=1696834627;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+pxd36zTsT0PX2PtoMf5L2s0tJWW5bkpx+2TO+OQ0EE=;
 b=dKE/IjxlTr1fyRIHZ5TR8k8NUq8ccQ0YLzHVzfTZKKtL6pJm0wa18kc/5JeSoUmJFM
 CNKtV3DO3KkRCa8T2DSdpYp65GEwWjbPTteDHNOMYEvlhA7spuTPhW2tFWiwobDH5oGW
 NRdBEJl40yaw6UhszFCD2TowcOFraO6nIFLlBFqmia5JloA/ggEq82jLr+TFqibq9fsj
 36sTpvgm3d24QzZC2TqLs+OYvjsRwo6MkXzHbmhf7mt6esRXHI6z+9o672RU/WEWk39J
 lzoxWlesrdXRC6xYL4Y1MvQsOVRkIpjYmSZJv1m/CkC6zjq0HAPgpEiiuAXhs+Y7cmS4
 jJkQ==
X-Gm-Message-State: AOJu0YwucFc2gu0yqGOLKbEM/OfuUxLjJ9GXLjL9eur3im274lrZ4saA
 vpntN4XB/iC3HYvzLbHpE24pFpSh3YV9OHXWubY6PBYbFsSJ/Kj2fEmWgkDzFLhDx5lyefnmv70
 04ifD4wzuKTlRndo=
X-Received: by 2002:adf:f307:0:b0:31f:a259:73c with SMTP id
 i7-20020adff307000000b0031fa259073cmr8902403wro.27.1696229827421; 
 Sun, 01 Oct 2023 23:57:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOyHEOaQGxURbKKTUinAZKqFkwasOUVrScWxFpl79c/Stifov5pifZNp0zUYBgE83oZL+Ycw==
X-Received: by 2002:adf:f307:0:b0:31f:a259:73c with SMTP id
 i7-20020adff307000000b0031fa259073cmr8902385wro.27.1696229827086; 
 Sun, 01 Oct 2023 23:57:07 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 p10-20020a5d59aa000000b00323287186aasm18569230wrr.32.2023.10.01.23.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 23:57:06 -0700 (PDT)
Date: Mon, 2 Oct 2023 02:57:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Message-ID: <20231002025001-mutt-send-email-mst@kernel.org>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
 <CAJSP0QVWSQ8F-A1ryGLtd1jb8Go1Pr_N7AcLb5W5kSFv8T8jTA@mail.gmail.com>
 <6d766ab4-b6b8-b64b-1f9d-60c558b56509@redhat.com>
 <CAJSP0QV9RO7bkkcVFibnTv4tixmO3wKohSY+ia1D-UZiRzh5QA@mail.gmail.com>
 <90e566a6-2ac9-5adf-233c-085df81526c0@redhat.com>
 <c1ed25c6-1493-a1e2-b539-664bdb7d4127@redhat.com>
 <20231001152422-mutt-send-email-mst@kernel.org>
 <20231001152519-mutt-send-email-mst@kernel.org>
 <2d361bac-9f8b-0a3a-ddd0-f66cd1294159@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d361bac-9f8b-0a3a-ddd0-f66cd1294159@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Oct 02, 2023 at 03:56:03AM +0200, Laszlo Ersek wrote:
> On 10/1/23 21:25, Michael S. Tsirkin wrote:
> > Not this actually - v2 of this.
> 
> Thank you, but:
> 
> - Stefan's question should be answered still IMO (although if you pick
> up this series, then that could be interpreted as "QEMU bug, not spec bug")
> 
> - I was supposed to update the commit message on 7/7 in v3; I didn't
> want to do it before Stefan's question was answered
> 
> Thanks!
> Laszlo

OK I just answered. I am fine with the patch but I think
virtiofsd should be fixed too.


-- 
MST


