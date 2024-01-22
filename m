Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C588359E6
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 04:56:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRlPM-0003jx-Rk; Sun, 21 Jan 2024 22:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rRlPL-0003ji-81
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 22:55:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rRlPJ-0007BW-JL
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 22:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705895731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vFquFqu3fTOS/soOAd9VGV02yOhmVCuciU6uM1rISK4=;
 b=RAky2T3MY7rCs9RNc9zGUMWnNS2RaTXhfk/mRdoxx9KSxDIFlqTesGOYoP7yWvAh3rdmp1
 KKxNlT87X/v/sdyO2LDbV3FiVI81tO1tRjmysiBCFth/B/EP4/5Lc+U0HLAyQ1m4L8uuy3
 CAQf4TAEQ+QvEe2e/nQgjj3CVHGpelc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-RBtO0swzMeaFFP5sCwMABw-1; Sun, 21 Jan 2024 22:55:28 -0500
X-MC-Unique: RBtO0swzMeaFFP5sCwMABw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d9ba60e1c1so2038814b3a.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jan 2024 19:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705895727; x=1706500527;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vFquFqu3fTOS/soOAd9VGV02yOhmVCuciU6uM1rISK4=;
 b=fLXWOU/xWe0QE5uAFlVlhR6s3oYbBoJMZFh8bHHYwbChrpcwos8p/XpHlDRB1sWgKt
 G9OoLMhWQmOwCM2xGD9kM2DTc420Eu4eHG/fhRNtzEvap8N1c5QJqD/bad633DzST6ZM
 LJ/IEnv/1b95t25tS5jjqXETRdPg1fMolvF8zNunoaXOtA97ntVAxTfUChtojnYWApvw
 YZ2f7aorL1M+PehfmmxWMXNVVNrwubRSOH+2pGz+dyvC2pym9/mVjZBvvD4keLv6wB3x
 NT0SfcKNjJY1YKmeKhLIJA0jOltNZR+3XdA8RmiB0uhdUiJjlJ9NXzpuD9rmveWQM/6h
 erGw==
X-Gm-Message-State: AOJu0Yy4r+8Z9EO1/iOboJcZqXyY8XWrfKjlNrr6MEiBSPiMd3TP49cj
 cJX8mecmpbiB82UZCZDZnfmTom2tMksmIrSKDnxF5kFG4cyWtoukf8MlXvfZB8bQQgcq2jRNW+W
 OmYIamPF1PkGwngao8XrQHypPP986r1JFOhT+08QLFDMUtrgpwoGu5DLqp7jhvVRLzD60fi28oN
 MkM1dBETgUdW/XiIPWSiknokK0eJ4=
X-Received: by 2002:a05:6a20:411f:b0:19a:132:e893 with SMTP id
 y31-20020a056a20411f00b0019a0132e893mr1035568pze.63.1705895727793; 
 Sun, 21 Jan 2024 19:55:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaoRbVkzvAanfO1PQ6JnIfpzEeukJmvQ9amm0C4+xxE1JXlnkpD8744/W+Qo6HNVhdghgKIuTHaMq/eOqzPgY=
X-Received: by 2002:a05:6a20:411f:b0:19a:132:e893 with SMTP id
 y31-20020a056a20411f00b0019a0132e893mr1035563pze.63.1705895727543; Sun, 21
 Jan 2024 19:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20240118091035.48178-1-peterx@redhat.com>
In-Reply-To: <20240118091035.48178-1-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 11:55:15 +0800
Message-ID: <CACGkMEszynKON4nCSNaWF7-gLWarcsYXJSttp6YW+NXidMKPFw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Drop myself as VT-d maintainers
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>, eric.auger@redhat.com, 
 Alex Williamson <alex.williamson@redhat.com>, zhenzhong.duan@intel.com, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Jan 18, 2024 at 5:10=E2=80=AFPM <peterx@redhat.com> wrote:
>
> From: Peter Xu <peterx@redhat.com>
>
> Due to my own limitation on bandwidth, I noticed that unfortunately I won=
't
> have time to review VT-d patches at least in the near future.  Meanwhile =
I
> expect a lot of possibilities could actually happen in this area in the
> near future.
>
> To reflect that reality, I decided to drop myself from the VT-d role.  It
> shouldn't affect much since we still have Jason around like usual, and
> Michael on top.  But I assume it'll always be good if anyone would like t=
o
> fill this role up.
>
> I'll still work on QEMU.  So I suppose anyone can still copy me if one
> thinks essential.
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Thanks a lot for the work for vtd.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


