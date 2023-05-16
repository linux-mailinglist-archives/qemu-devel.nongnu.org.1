Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E51705B7E
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 01:51:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz4Rq-0005PP-NG; Tue, 16 May 2023 19:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pz4Ro-0005Oq-4B
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pz4Rm-0007Le-3D
 for qemu-devel@nongnu.org; Tue, 16 May 2023 19:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684281073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P8zJ2X79j9lr9cLFcBS6ceffx4XwhVU40APwvTvXmy4=;
 b=FPSXaTPaazYg3UL0WUpymh9jshBhbxRdMmIK3t1+2AQQ3l9pWjN1U+FnmtOoznjfBwEpX5
 H88F6J7ruUC9m9tNas48iwglyK4P6xDm/sawGnfhu0VWj01ecFlzn2w4sNjF613FZBj63Z
 DFTrpw2JxZ5cY+lqfMoialy7jSPgTaY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-YKebpDQvO3qLv80saKtFqA-1; Tue, 16 May 2023 19:51:11 -0400
X-MC-Unique: YKebpDQvO3qLv80saKtFqA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-621189941cdso168616d6.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 16:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684281071; x=1686873071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8zJ2X79j9lr9cLFcBS6ceffx4XwhVU40APwvTvXmy4=;
 b=hgAY2sCwv4CQ2XKVbjiXlaOAouksflH52/FF/semz1eylKLPKulUL46aPHdAWOuMXL
 YKUbqQsjJGH56F5AB9onhQRPwwjDxYt/Dv727UizysJnNa0xJo4pAYpos3YwpkRaX5pZ
 1iR5pGSFXaOlpyNqkEZfenAaMt1KquffswqMyrZZJBQ30p09PtSvOHoLliirVCS4VTq8
 2RzpnSYGeScmo922CG36lIkmmE2Nny4Jybzl6W+eDBpvgCAXkxD1St3C6ZCUiqGfNZpB
 xM5Y4DFmQBFLCF33B1bOgL3T3qRft5M1VcBMy8h3nah1ba4krNnknWlWHiDZSCPA2jJX
 hz4w==
X-Gm-Message-State: AC+VfDzw2VcGHkPggsNW114fJV8kmy+jDiFY7xCTJUoGMdKNBwhqAUeL
 gDwNZXt3EOiLfeJ4yZynAqoeAwsTmOhnJ9nJDER3oBaVRjID6wGZX1q1XYmRR7WZBISayAWKwzU
 nMHTtJEfaIcUp9+Y=
X-Received: by 2002:a05:6214:cc8:b0:61b:6b8e:16e0 with SMTP id
 8-20020a0562140cc800b0061b6b8e16e0mr2099090qvx.1.1684281071224; 
 Tue, 16 May 2023 16:51:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46vKfoOtVaC1EceicOfIDV1SCnBWxDh3H8hxq2d6Ghb4xyMz8VVoXuxR5xBQKmOuF6tFJPTw==
X-Received: by 2002:a05:6214:cc8:b0:61b:6b8e:16e0 with SMTP id
 8-20020a0562140cc800b0061b6b8e16e0mr2099066qvx.1.1684281070955; 
 Tue, 16 May 2023 16:51:10 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 c21-20020ac85a95000000b003ef33e02eb9sm6580177qtc.83.2023.05.16.16.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 16:51:10 -0700 (PDT)
Date: Tue, 16 May 2023 19:51:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v3 2/3] migration/docs: How to migrate when hosts have
 different features
Message-ID: <ZGQW7W8i+y9/KpO1@x1n>
References: <20230515083201.55060-1-quintela@redhat.com>
 <20230515083201.55060-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230515083201.55060-3-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, May 15, 2023 at 10:32:00AM +0200, Juan Quintela wrote:
> Sometimes devices have different features depending of things outside
> of qemu.  For instance the kernel.  Document how to handle that cases.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> ---
> 
> If you have some example to put here, I am all ears.  I guess that
> virtio-* with some features that are on qemu but not on all kernel
> would do the trick, but I am not a virtio guru myself.  Patches
> welcome.
> ---
>  docs/devel/migration.rst | 93 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index b4c4f3ec35..95e797ee60 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -357,6 +357,99 @@ machine types to have the right value: ::
>           ...
>       };
>  
> +A device with diferent features on both sides
> +---------------------------------------------
> +
> +Let's assume that we are using the same QEMU binary on both sides,
> +just to make the things easier.  But we have a device that has
> +different features on both sides of the migration.  That can be
> +because the devices are different, because the kernel driver of both
> +devices have different features, whatever.
> +
> +How can we get this to work with migration.  The way to do that is
> +"theoretically" easy.  You have to get the features that the device
> +has in the source of the migration.  The features that the device has
> +on the target of the migration, you get the intersection of the
> +features of both sides, and that is the way that you should launch
> +qemu.
> +
> +Notice that this is not completely related to qemu.  The most
> +important thing here is that this should be handle by the managing
> +application that launches qemu.  If qemu is configured correctly, the
> +migration will suceeed.
> +
> +Once that we have defined that, doing this is complicated.  Almost all
> +devices are bad at being able to be launched with only some features
> +enabled.  With one big exception: cpus.
> +
> +You can read the documentation for QEMU x86 cpu models here:
> +
> +https://qemu-project.gitlab.io/qemu/system/qemu-cpu-models.html
> +
> +See when they talk about migration they recommend that one chooses the
> +newest cpu model that is supported for all cpus.
> +
> +Let's say that we have:
> +
> +Host A:
> +
> +Device X has the feature Y
> +
> +Host B:
> +
> +Device X has not the feature Y
> +
> +If we try to migrate without any care from host A to host B, it will
> +fail because when migration tries to load the feature Y on
> +destination, it will find that the hardware is not there.
> +
> +Doing this would be the equivalent of doing with cpus:
> +
> +Host A:
> +
> +$ qemu-system-x86_64 -cpu host
> +
> +Host B:
> +
> +$ qemu-system-x86_64 -cpu host
> +
> +When both hosts have different cpu features this is waranteed to fail.
> +Especially if Host B has less features than host A.  If host A has
> +less features than host B, sometimes it works.  Important word of last
> +sentence is "sometimes".
> +
> +So, forgetting about cpu models and continuing with the -cpu host
> +example, let's see that the differences of the cpus is that Host A and
> +B have the following features:
> +
> +Features:   'pcid'  'stibp' 'taa-no'
> +Host A:        X       X
> +Host B:                        X
> +
> +And we want to migrate between them, the way configure both qemu cpu
> +will be:
> +
> +Host A:
> +
> +$ qemu-system-x86_64 -cpu host,pcid=off,stibp=off
> +
> +Host B:
> +
> +$ qemu-system-x86_64 -cpu host,taa-no=off

Since we're using cpu as example, shall we at least mention at the end that
we don't suggest using -cpu host if migration is needed?

> +
> +And you would be able to migrate between them.  It is responsability
> +of the management application or of the user to make sure that the
> +configuration is correct.  QEMU don't know how to look at this kind of
> +features in general.
> +
> +Other devices have worse control about individual features.  If they
> +want to be able to migrate between hosts that show different features,
> +the device needs a way to configure which ones it is going to use.
> +
> +In this section we have considered that we are using the same QEMU
> +binary in both sides of the migration.  If we use different QEMU
> +versions process, then we need to have into account all other
> +differences and the examples become even more complicated.

Mostly good to me.  What I worry is how much help this will bring to
developers - I'd assume developers working on these will be aware of this.
But I guess it's always good to have any documentation than nothing.

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


