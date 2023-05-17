Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0C270650C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 12:24:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzEJp-0006lM-3n; Wed, 17 May 2023 06:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzEJm-0006iG-T5
 for qemu-devel@nongnu.org; Wed, 17 May 2023 06:23:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzEJh-0001FY-RS
 for qemu-devel@nongnu.org; Wed, 17 May 2023 06:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684319013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u1W04rxZnFh1oMgbiwgIsHAEA1fCq662yONDiQbcZpw=;
 b=M6AU2/oUdDCi6VWuLD/bIVDtR5FfgKOGpmzQVXk9MyU6bktBXUKR3Fnjk/+fk5rMo3/c8Y
 1R3L24bSLqHIM99D9eH3YUuSRPLvzm2anSXtVhmT/BWvD0m88FQbccDaYJnpARNXJ1o/kZ
 iNQ51ln0wp2HSZhNB2hOAzb3ASJ9B78=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-B6OnCwFhMRuqWtrxvjYK8Q-1; Wed, 17 May 2023 06:23:32 -0400
X-MC-Unique: B6OnCwFhMRuqWtrxvjYK8Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3078df8ae31so408944f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 03:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684319011; x=1686911011;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1W04rxZnFh1oMgbiwgIsHAEA1fCq662yONDiQbcZpw=;
 b=kljTecXjy/DrAvye2l0SCtL0cZ/2eghO2JVZ6dIQMrUEWOO81LelZpnBbb/VMAIq1E
 QmRNaPjaJykeHFcqKVeMg+Xv4ZJ8JXCdyNVliJsJVC6tA7QB6LSL19M5HR4KZILi5HS/
 0ljgqkDe5yy+DAm8SYR9j5XecwofQDKEKWglSTp4cifXS+gSWgI6N7xKBYdjI/pA8Yk6
 Z6wrOrbM9n+aG20IJSa17vk9con9BVL5GG9qc17n+iHUwkvIQf8YMVG1Trem4PhjFhj/
 u4sL3i1qljXO8uSjYjigNlJjBB3yPNBk51D+deVOx3g5lMeVYrBhH4t1lFE61VeSHrnH
 8amw==
X-Gm-Message-State: AC+VfDwm+wLU4Cxnlxyf/KxiXqZzVwdoaD3PFiFmVnEZc4DZv560B0R+
 I/yLqtvBbOSnJyK/wJBm1RtdIvryGWbGThWp90IGuydg9CqWsy2Cjgskay7xWkBjsMbS9y6G4S4
 Efytf3CnBbiSHTJZdP5SaKgE=
X-Received: by 2002:a05:6000:143:b0:309:5d9:bc81 with SMTP id
 r3-20020a056000014300b0030905d9bc81mr241868wrx.49.1684319010759; 
 Wed, 17 May 2023 03:23:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ59+uqJidDsHfpIxENFB61ENXCfFjfr+rudCZe34yGsaBwNe7yAEla4Zj9HqASdYH3xuBb+/Q==
X-Received: by 2002:a05:6000:143:b0:309:5d9:bc81 with SMTP id
 r3-20020a056000014300b0030905d9bc81mr241848wrx.49.1684319010395; 
 Wed, 17 May 2023 03:23:30 -0700 (PDT)
Received: from redhat.com ([2.52.6.43]) by smtp.gmail.com with ESMTPSA id
 w12-20020adfcd0c000000b002ffbf2213d4sm2372598wrm.75.2023.05.17.03.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 03:23:29 -0700 (PDT)
Date: Wed, 17 May 2023 06:23:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 2/3] migration/docs: How to migrate when hosts have
 different features
Message-ID: <20230517062128-mutt-send-email-mst@kernel.org>
References: <20230515083201.55060-1-quintela@redhat.com>
 <20230515083201.55060-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515083201.55060-3-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

yes, e.g. vhost features are exactly like this.


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

How do people know what to do?
How about a tool that will help you get data from hosts
and then tell you how to configure qemu to make them
compatible?


>  VMState
>  -------
> -- 
> 2.40.1


