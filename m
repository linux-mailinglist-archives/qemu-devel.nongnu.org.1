Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9B97C7B3F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 03:39:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr78L-0003Rv-I4; Thu, 12 Oct 2023 21:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qr78J-0003RV-DQ
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 21:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qr78H-0007iu-UO
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 21:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697161108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yi0ntr1CcXzqa1t4zXBUpQxzf1HFj8vLoK5ZHDOq3Cw=;
 b=Z5typ0dSL6uTiLlAmG0MSIgdv3hmDYXDnz4dp0uYIewd5BH/wfnFhyrl40kNSJYKYEDpb9
 KwwPBlhzMn7nq47H1vdJQTzAe4MxAXyl2WxY1MmkLSzEGjFDIJezuQ/Fv85urbyoYWn2kX
 iKEnwazss+y5LhGvd4L/GP65N2KR5yA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-pNlLlbYOOSSlzu5pNGOGRA-1; Thu, 12 Oct 2023 21:38:26 -0400
X-MC-Unique: pNlLlbYOOSSlzu5pNGOGRA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5042eca54a4so1666622e87.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 18:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697161105; x=1697765905;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yi0ntr1CcXzqa1t4zXBUpQxzf1HFj8vLoK5ZHDOq3Cw=;
 b=av3IWJQb5AMp8CLpQaZ8zi6WQXUeG6KDwoGiTXqTma5u+ESSeiku7kWoh0f3rTUPo8
 OB7gKhHbGxMFSPS0eiqdZC2ld+1/F3C6/lByvWU8/GIxRWwjBYLVSKHsf7PqPK1wf6l1
 JyeA1Md2VEjEG2u+Qj7tnAOtc79NXEv7VEvKrkxNXO0atyzTaWa2/kdTOTZ9dxVtjwTw
 KQHML5D9p9yrkemh9arXqGroVfj6YlGeXrXiGRurglZTtgDVx7liRl00zUOzFn56J/5X
 EjDgd4hyXNbWvmHTqP43l1jHihmgFWNxy0MQQDgT3XZjNvF31WOILboAmQmqJ2Im3MDj
 F4+Q==
X-Gm-Message-State: AOJu0YycO1j7Wi+IUAWM0xeU4yu1Dto33NqEer/sweEWY5c5ID1Y3Qej
 M81KF5BRM5H3OCFmBtHXw5kt6FSJcvK4VX1Xl4tbCovX9gO0/ygf0LXgchzb30psKtwmuo+Dp22
 G26jVRwdPkp1PaunVFa7zCjgU/gJiYpw=
X-Received: by 2002:a05:6512:2821:b0:502:f2a8:d391 with SMTP id
 cf33-20020a056512282100b00502f2a8d391mr29877803lfb.45.1697161105060; 
 Thu, 12 Oct 2023 18:38:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAk1GXjAcwrx3447pfABBpWx9t+QYnmBrR/+YFFrFBgYNI03tM8eTqmuIOm7uDK5J4PEF5bYJa0pF2P/oB7rA=
X-Received: by 2002:a05:6512:2821:b0:502:f2a8:d391 with SMTP id
 cf33-20020a056512282100b00502f2a8d391mr29877795lfb.45.1697161104870; Thu, 12
 Oct 2023 18:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231011153944.39572-1-akihiko.odaki@daynix.com>
 <20231011153944.39572-2-akihiko.odaki@daynix.com>
In-Reply-To: <20231011153944.39572-2-akihiko.odaki@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Oct 2023 09:38:14 +0800
Message-ID: <CACGkMEt-kR5EVozeO+Zcx9kxdLLggBM8V98YUKQKutb28TvgCQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] tap: Remove tap_probe_vnet_hdr_len()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 11, 2023 at 11:40=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> It was necessary since an Linux older than 2.6.35 may implement the
> virtio-net header but may not allow to change its length. Remove it
> since such an old Linux is no longer supported.

Where can I see this agreement?

Thanks


