Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D60682D325
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 03:39:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPCrs-00083i-Jt; Sun, 14 Jan 2024 21:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPCrq-000836-33
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 21:38:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPCro-000673-Ls
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 21:38:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705286304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HXvC9BwQZli8S0INfrt3gp3E/Ldald2M6vJ4C1KxN0Y=;
 b=KpdunnFoZiYWbNOmc6oZBgJtlZ+wB0DQjx6v8NSYOp+JUgMJTboMMdKqLPWgkvqLsCpSue
 gxRVubgaw3E4EsGzKJBlIwzoBgiAoYAsP0zL5WQFkID65gUJ5rCE2PussbkJijTjNfDAUL
 Zwdt0uAyvfg6Z9zZyeb7XlIyqJ08434=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-OG7hycAzPRi9mhYNKEgMhA-1; Sun, 14 Jan 2024 21:38:22 -0500
X-MC-Unique: OG7hycAzPRi9mhYNKEgMhA-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3bd62751c67so2886957b6e.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 18:38:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705286302; x=1705891102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HXvC9BwQZli8S0INfrt3gp3E/Ldald2M6vJ4C1KxN0Y=;
 b=fdxfA9hZXiGl3aY4hnyI8mz29sD/uf7EVjVVGccpo+N46raeVc6tb8EskdIXJs2DVH
 OtQ1teRzxWNpq0Rt6Yxdv4t5OQZnLz3LmAtkdafzQbOofTkYnQIDCALGeGdH6hNtFy5j
 ElV/lQGrVUvQPp5UwZqJpclOK4vN0pYCBapgGSu3i3BSX+qXGVQT5/73bg2cTh7tYQiw
 C0wun3F7WiNWA91Fscgdwj/7eqKob1JD2y6mHcveeIf3oZMzrYqXcByHhqDiopEif5/d
 nwXp/y6bity9tmHcexFDSAt9uNoVerJw/Kej7rNARQiY1s2+vmxN6LnB6lr5htmQOuuG
 ykqQ==
X-Gm-Message-State: AOJu0Yz6uEiuzjK4+4TFWnkUJTWTqiEdClC3KVoFOgdGztzAvcsy3FSJ
 yVEpJu4A1TJjIEf8mdIggiQfqydtr0UlU+YlppNrIwz+/qwHpH8fLTai+t1VPB5HtdFTUzAkx6V
 mr7C61OVufRoJpXWhSKnUoR893GOZbdWzUC3LH08=
X-Received: by 2002:a05:6808:38c4:b0:3bd:685e:680f with SMTP id
 el4-20020a05680838c400b003bd685e680fmr5431575oib.0.1705286302061; 
 Sun, 14 Jan 2024 18:38:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqZOScVnrT1Zgn5qTxhYsWpIJTYcwqoeoXohdu9s8KK89lT7kKRLaQRQuPp0YFpG2MAgsyEro0Lo/DacaQeXE=
X-Received: by 2002:a05:6808:38c4:b0:3bd:685e:680f with SMTP id
 el4-20020a05680838c400b003bd685e680fmr5431567oib.0.1705286301850; Sun, 14 Jan
 2024 18:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20240102032901.3234-1-jasowang@redhat.com>
In-Reply-To: <20240102032901.3234-1-jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 10:38:10 +0800
Message-ID: <CACGkMEva2WJvsgLYUNTk5ZSy0PfntHWHUKUbk0K=Xj+WKOjpuw@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: correctly copy vnet header when flushing TX
To: mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: Xiao Lei <leixiao.nop@zju.edu.cn>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 qemu-stable@nongnu.org, Mauro Matteo Cascella <mcascell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jan 2, 2024 at 11:29=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> When HASH_REPORT is negotiated, the guest_hdr_len might be larger than
> the size of the mergeable rx buffer header. Using
> virtio_net_hdr_mrg_rxbuf during the header swap might lead a stack
> overflow in this case. Fixing this by using virtio_net_hdr_v1_hash
> instead.
>
> Reported-by: Xiao Lei <leixiao.nop@zju.edu.cn>
> Cc: Yuri Benditovich <yuri.benditovich@daynix.com>
> Cc: qemu-stable@nongnu.org
> Cc: Mauro Matteo Cascella <mcascell@redhat.com>
> Fixes: CVE-2023-6693
> Fixes: e22f0603fb2f ("virtio-net: reference implementation of hash report=
")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Queued.

Thanks


