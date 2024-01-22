Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE84F835A0A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 05:22:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRlnj-0002Wk-9N; Sun, 21 Jan 2024 23:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rRlnh-0002WU-17
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 23:20:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rRlnf-0005Dz-Er
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 23:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705897242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=addA1Ye3zqfydmMFp5T+cw+XCtworSeg7G31oH8XT64=;
 b=IGvMGHV5bWN5G2LVH3Fu/YkMV8zMOp8cUT/F5OVLa9jYUCVKCWpEmtwqLiPCWpi54MKCO7
 xPa0r20thUCFt8u70Y9Ypom4WAey5h3FG/gey+CQsudq3KulCQWzZ9+dwhiE2zuXr0lhx4
 7PnkDssC/ZxyEtWnFqFJ/wLGM7AX+Yc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-GuC6s0yWOUG2yD2tH73Dpw-1; Sun, 21 Jan 2024 23:20:40 -0500
X-MC-Unique: GuC6s0yWOUG2yD2tH73Dpw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-28c183f8205so3256734a91.3
 for <qemu-devel@nongnu.org>; Sun, 21 Jan 2024 20:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705897239; x=1706502039;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=addA1Ye3zqfydmMFp5T+cw+XCtworSeg7G31oH8XT64=;
 b=GSpmh/VoM3Nus0VMB1Zo1zC2KLY2SyxOXt/XTgCRVV+rIemkBhTyfiS0f0cuUsdV1C
 OF1sBTDu3DYB5aEIut5x7Cdn3JvI/JRXFwU9TqK30eaJnzQ4MA+MZyHiD+i6BYXQGBmD
 4SKx/5NFQVx1CjED43w0aAeT/+Hmu9g7sKRfJ3PKbkxYI/LtCX6kZyy5GlFxjwfecb/i
 EX0JUZMTKJwEAEmCBRZpAhSndsoU6aZyqGTwtZX2nyDMYGgatuiC0Q5byxpQjDe0eWl7
 +E86IboV0GaPmstjnA900fCMAHReUHUpMsmOR3z+DxwCdsX38mEQT4u4kkdc/i6tUQs9
 xgTg==
X-Gm-Message-State: AOJu0YyPAogHNfVAsicRsEBtuTOIKhwshID2SayBqF2LYLqxfzVvHS8I
 Jrpup9Ryko+nmOj2axfNiwMV6b9qK7GEuNUXLenG6m64H/nSM15jilgaNN45Cb+h6UZupcxb+aM
 DoK48hEezpQfF/7MxViKrzMB4ZOwLDKv3MV4KMPmQCf68G1T09MmL0b4kGUgZBKz+qXM2B70txU
 5wTAcUBNECrp8HaBEAYLUGzY4lhls=
X-Received: by 2002:a17:90a:c914:b0:28e:84e7:7804 with SMTP id
 v20-20020a17090ac91400b0028e84e77804mr1328396pjt.65.1705897239577; 
 Sun, 21 Jan 2024 20:20:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNlZJu0lE4327K0lbltxkctZWdSs8uZmWuiT8aRju6dWwJgLNWjMNKmypCv+jiBr6qtKMhtI6J9kN3qtqsU+E=
X-Received: by 2002:a17:90a:c914:b0:28e:84e7:7804 with SMTP id
 v20-20020a17090ac91400b0028e84e77804mr1328393pjt.65.1705897239344; Sun, 21
 Jan 2024 20:20:39 -0800 (PST)
MIME-Version: 1.0
References: <20240102032901.3234-1-jasowang@redhat.com>
 <6978eac1-96d8-4759-96f1-7edc6784ffa1@tls.msk.ru>
In-Reply-To: <6978eac1-96d8-4759-96f1-7edc6784ffa1@tls.msk.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 12:20:28 +0800
Message-ID: <CACGkMEve2EY2aFauD++amuUG_zr6xm-i94j=KqAYAWzgADxHvw@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: correctly copy vnet header when flushing TX
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: mst@redhat.com, qemu-devel@nongnu.org, Xiao Lei <leixiao.nop@zju.edu.cn>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-stable@nongnu.org, 
 Mauro Matteo Cascella <mcascell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, Jan 20, 2024 at 6:42=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 02.01.2024 06:29, Jason Wang :
> > When HASH_REPORT is negotiated, the guest_hdr_len might be larger than
> > the size of the mergeable rx buffer header. Using
> > virtio_net_hdr_mrg_rxbuf during the header swap might lead a stack
> > overflow in this case. Fixing this by using virtio_net_hdr_v1_hash
> > instead.
> >
> > Reported-by: Xiao Lei <leixiao.nop@zju.edu.cn>
> > Cc: Yuri Benditovich <yuri.benditovich@daynix.com>
> > Cc: qemu-stable@nongnu.org
> > Cc: Mauro Matteo Cascella <mcascell@redhat.com>
> > Fixes: CVE-2023-6693
> > Fixes: e22f0603fb2f ("virtio-net: reference implementation of hash repo=
rt")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> Hi!  Can we get this to master before Jan-27 please, so it's included in =
8.2.1?

I think it will be.

Thanks

>
> Thanks!
>
> /mjt
>


