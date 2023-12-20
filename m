Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C9A8197D1
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 05:31:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFoEI-0008KS-FM; Tue, 19 Dec 2023 23:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rFoE0-0008K7-RX
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 23:30:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rFoDw-0003mj-Er
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 23:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703046618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bVthK6+0CHN0/vzRY3sXTm6opundFyZmmQX0W6Rp6Bc=;
 b=d9lxpHKD0sIly591YVdIVFEvFkz13UWDfaC8UklNql3s2KX+xLY2Q+fwwlbqIPer2QzqYQ
 G+xHYiyZN6w3kwatVUtI9SaPgURGfPlhXQZjRO1gd3r4yerClVjb2p+JdxczoK56Lo9ylQ
 7FpWhO5GCufKH1klWdsd20k9yaVOjCQ=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-bVxfvHRcMl-PY8i7ARgYRw-1; Tue, 19 Dec 2023 23:30:16 -0500
X-MC-Unique: bVxfvHRcMl-PY8i7ARgYRw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d0908565f8so6365533b3a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 20:30:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703046615; x=1703651415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bVthK6+0CHN0/vzRY3sXTm6opundFyZmmQX0W6Rp6Bc=;
 b=rHmtPmcuuuqqtnCU/kHoEwh6Dii9izH6BTm3AnDt4DO8KbLDMf7pLtpVV4Pe8RswWo
 S2BUwShtFTnxILVC2KfQB4oUvurGEOjoRw8LmlXeahksp46JfVOFS01axpyWHN6m74gi
 q814tyJD3J8bA+gY5cspSMObWeYKG9MNTVaPdwSRrcMvYxUdAwAT1iJa/Ze3xCvQz4f3
 pgX0MzAAONHUdTJV1UC33+hv0KPfV2xoUxgl1Md+6jokRMxa9eaTRR8s3ZgcQZLciG+0
 6lclux5NU4FvVE3e8z070kOKMZsFqFjPzwLXYTbxIVCNZMETmTbt5G08Uocb3DHQ7oup
 8OUA==
X-Gm-Message-State: AOJu0YzfR0utg+PBjmJx0zKayRcb8+QmUEDAOcxi3VhoZMRNRncegRJ2
 6Izv6ieu/sLwvrbr1RfIzBB5m/l5BCUMi4y5njE7AenCUqxPeBK+m2mWmFjAh/hALaJh5NaTAGx
 OSzl0cleUTCAFJh3Bmug2AzyJSu0CwAY=
X-Received: by 2002:a05:6a00:1889:b0:6d5:c4cb:860b with SMTP id
 x9-20020a056a00188900b006d5c4cb860bmr6196822pfh.65.1703046615130; 
 Tue, 19 Dec 2023 20:30:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV4fBO8B0cBC1EHgsOnvFzm50iCQqUcuOOGixG+BrXPJWZeEbRhRrYRI6mY+msJ5h5pvGymnKreGTLGMJOiLI=
X-Received: by 2002:a05:6a00:1889:b0:6d5:c4cb:860b with SMTP id
 x9-20020a056a00188900b006d5c4cb860bmr6196810pfh.65.1703046614846; Tue, 19 Dec
 2023 20:30:14 -0800 (PST)
MIME-Version: 1.0
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-4-eperezma@redhat.com>
In-Reply-To: <20231215172830.2540987-4-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 12:30:03 +0800
Message-ID: <CACGkMEvWuii90xHsvn23JQuRfS7LZSZPBorYkuYtNib5JcCunw@mail.gmail.com>
Subject: Re: [PATCH for 9.0 03/12] vdpa: merge _begin_batch into
 _batch_begin_once
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 si-wei.liu@oracle.com, 
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

On Sat, Dec 16, 2023 at 1:28=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> There was only one call.  This way we can make the begin and end of the
> batch symmetrical.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


