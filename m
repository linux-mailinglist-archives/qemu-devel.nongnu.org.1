Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1447455AA
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 08:55:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGDSf-0005l1-7x; Mon, 03 Jul 2023 02:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qGDSc-0005i0-2g
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qGDSa-00069z-9Z
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688367294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jeEnbjioriKjgNiO6ycPt5nP103ZmZbFBZXuULuCQbc=;
 b=BBGJtU5i0cLF6Xam893HotQWOEYDB2Ya3kwrZYLP1khQxBtSllkB3ay5FV9+qY3JeLa+JW
 I2DLQWvOc26slvE9Gx35r5xoZjbT9sOLgVnk0DzcOjgH4RfLEvbou6mNFMu5igOg+prlfL
 4UhMJqUkPg5ScQRFJj3vt/pBCQChfMA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232--vwlfvXANVaECFwBgJc5BA-1; Mon, 03 Jul 2023 02:54:52 -0400
X-MC-Unique: -vwlfvXANVaECFwBgJc5BA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-51df43db167so1559036a12.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 23:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688367291; x=1690959291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jeEnbjioriKjgNiO6ycPt5nP103ZmZbFBZXuULuCQbc=;
 b=H1A2zFx6DBk6po4d2sJvMGfBo82RndCgBVIv3sfXzsQbBsmO3jqQbVn17sXWB+5ds4
 GLAResFNJhJGt0cD/LcY/pRZdalrKVGkuO8Aova3kbZsc611O92r8bqnOmDgtOuMskbb
 3NOrjH9os+CqXymoAEGaXyE8RMoZy7nFOCzpyXEb1kdXCMygpjAXLzKEAOD4QF7CILTw
 /0ia97NjEpeYRRK74RPBWUxuyRrvHAUqh4167mMBA2ZLiWeUnoFdzhrnyrQHDuT1vzZl
 k2CnZyYUwTtnsnyxCtdkWVuNR9L6XVn7e9Lt5CFVIDcF+nbF7RK1TiBa+onRGXz4tfdk
 UNuQ==
X-Gm-Message-State: ABy/qLYEI7UYSkHE1LblbJ6mj3Rbwqbu1hHqGik2kav5t1Oyd6W0cG0x
 z2RWHhPNhozuOY7wtpScEe3IfqmxeQGxHNLZRLN9OaFCNOKaHo7o+xglm9+r1c4JxWmm+XazSQn
 ZRSOsk5kKv7tKJcBlIPMNSOu5qX0T0jQ=
X-Received: by 2002:aa7:d142:0:b0:51d:d5a1:a7f1 with SMTP id
 r2-20020aa7d142000000b0051dd5a1a7f1mr6370673edo.38.1688367291783; 
 Sun, 02 Jul 2023 23:54:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFg2uxN0fnvruJsIFSxmTYL1vIe8fWMiqR1RavqBWyfYQ3zWHy52+d22k2hmAQUKDRo2TODSIUSMiukmUZbShw=
X-Received: by 2002:aa7:d142:0:b0:51d:d5a1:a7f1 with SMTP id
 r2-20020aa7d142000000b0051dd5a1a7f1mr6370664edo.38.1688367291518; Sun, 02 Jul
 2023 23:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688130570.git.yin31149@gmail.com>
In-Reply-To: <cover.1688130570.git.yin31149@gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 3 Jul 2023 14:54:14 +0800
Message-ID: <CAPpAL=wLap_4p1NKh7tWse_+iKaCP8aqXrLO1hpzKr85taqGZw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] vdpa: Refactor vdpa_feature_bits array
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com, 
 philmd@linaro.org, qemu-devel@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

QE tested this series with regression tests and live migration test on
the vhost_vdpa device, there are no new problems.

Tested-by: Lei Yang <leiyang@redhat.com>


On Fri, Jun 30, 2023 at 9:27=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This patchset removes the duplicated VIRTIO_NET_F_RSS entry
> in vdpa_feature_bits array and sorts the vdpa_feature_bits array
> alphabetically in ascending order to avoid future duplicates.
>
> Changelog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> v3:
>   - sort array alphabetically suggested by Philippe
>
> v2: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg06764.htm=
l
>   - resolve conflicts with the master branch
>
> v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg01583.htm=
l
>
> Hawkins Jiawei (2):
>   vdpa: Delete duplicated VIRTIO_NET_F_RSS in vdpa_feature_bits
>   vdpa: Sort vdpa_feature_bits array alphabetically
>
>  net/vhost-vdpa.c | 40 +++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
>
> --
> 2.25.1
>
>


