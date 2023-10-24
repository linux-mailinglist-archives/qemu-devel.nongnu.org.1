Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEAE7D4E3A
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:48:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvEwa-0002RK-8Z; Tue, 24 Oct 2023 06:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvEwX-0002QQ-E0
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvEwS-0000Xj-8e
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698144438;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PoFRi2KGkyjOVMmAS8V2fkxIqZC7oKZuI2UrZ0jvSD0=;
 b=bl7m9KH2xFlGUsIL99gW4swj6cfV8TVvjY+hUuLjbL+Vi4bgyiOmM85Zi5z/LyUX8FvXxB
 mVu6PAbATkg1QD1tTIgsD2ajIWOAQKAEptgDBFl4DZ/95TWfP0jRCZwvj3/5b1Wm3vm7i6
 zUnCrdudHt+MxPE8VQ2ZJcXlNHs7bHw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-opnAFxjZNgeCTZU0SS5oEQ-1; Tue, 24 Oct 2023 06:47:17 -0400
X-MC-Unique: opnAFxjZNgeCTZU0SS5oEQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-408534c3ec7so23055805e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 03:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698144436; x=1698749236;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PoFRi2KGkyjOVMmAS8V2fkxIqZC7oKZuI2UrZ0jvSD0=;
 b=DnzHLEyi5hDrLXn7nEUB88AVRJQyQK7/BsnbhjZg1K4BC6P+98u7npiPgh4UHZYDK4
 3t5NnU+Qtn2SQd1u8cwKLd2C3jJFHf4+5OHQGb+w56AICtcv04A8ma4mdNooaBZpobv0
 leFS++kuVAcgf45vDr2Ov1ZCpxgW2T44G4sv8CvnlekdNEUREQuQrl8r1tpElCt9tqJx
 7l+tnRxxOt1rQtjnX9JWiRwoOPCJjlJhCMexw4H0XDtDImLUGaoCN4q2IGlWQf9Yl3T2
 0at8vUk3mYgAFy6SNvqABoUFpjjQ4gCITZDs9M4XJE/2xoUFNdrh4/oqzBSL71lXJiuv
 3LVQ==
X-Gm-Message-State: AOJu0YxZPbXw0N885ITag68E6eFXQFPBbU7f+EL73tpYAZZWIkwFcivl
 QUhnjufFF1JpJu3NC/7CjaT5uhxyCF9nexsLZn5no0qFDOaXnG4KKGelUgIV7A6sclsiXBqVFQ4
 JHBRBCqssxLAVQmQ=
X-Received: by 2002:a05:600c:4e8e:b0:408:ff28:a4ad with SMTP id
 f14-20020a05600c4e8e00b00408ff28a4admr4877607wmq.33.1698144436095; 
 Tue, 24 Oct 2023 03:47:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtl2TK9xyF42Qbrl0EnNubOumq3Jl9KXxxDk9kkffKX3mD2+lUk7Gvpf77pR0SzsrLZqQ4Dg==
X-Received: by 2002:a05:600c:4e8e:b0:408:ff28:a4ad with SMTP id
 f14-20020a05600c4e8e00b00408ff28a4admr4877585wmq.33.1698144435731; 
 Tue, 24 Oct 2023 03:47:15 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 o30-20020a05600c511e00b004063cd8105csm16587535wms.22.2023.10.24.03.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 03:47:15 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  John Snow
 <jsnow@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Samuel Thibault <samuel.thibault@ens-lyon.org>,
 qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,  Jason Wang
 <jasowang@redhat.com>
Subject: Re: [PATCH v2 9/9] docs/migration: reflect the changes about needed
 subsections
In-Reply-To: <20231024084043.2926316-10-marcandre.lureau@redhat.com>
 (marcandre lureau's message of "Tue, 24 Oct 2023 12:40:43 +0400")
References: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
 <20231024084043.2926316-10-marcandre.lureau@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 12:47:14 +0200
Message-ID: <87sf60z499.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  docs/devel/migration.rst | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index c3e1400c0c..50f313f178 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -240,17 +240,16 @@ a newer form of device, or adding that state that y=
ou previously
>  forgot to migrate.  This is best solved using a subsection.
>=20=20
>  A subsection is "like" a device vmstate, but with a particularity, it
> -has a Boolean function that tells if that values are needed to be sent
> -or not.  If this functions returns false, the subsection is not sent.
> -Subsections have a unique name, that is looked for on the receiving
> -side.
> +has a Boolean function that tells if that values are needed or not. If
> +this functions returns false, the subsection is not sent. Subsections
> +have a unique name, that is looked for on the receiving side.
>=20=20
>  On the receiving side, if we found a subsection for a device that we
> -don't understand, we just fail the migration.  If we understand all
> -the subsections, then we load the state with success.  There's no check
> -that a subsection is loaded, so a newer QEMU that knows about a subsecti=
on
> -can (with care) load a stream from an older QEMU that didn't send
> -the subsection.
> +don't understand, we just fail the migration. If we understand all the
> +subsections, then we load the state with success. There's no check
> +that an optional subsection is loaded, so a newer QEMU that knows
> +about a subsection can (with care) load a stream from an older QEMU
> +that didn't send the subsection.

Reviewed-by: Juan Quintela <quintela@redhat.com>

Just wondering.  What device propmted you to write this series?

Later, Juan.


