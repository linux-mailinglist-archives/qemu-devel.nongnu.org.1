Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D41C3749B30
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:55:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHNYd-00025u-5J; Thu, 06 Jul 2023 07:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHNYb-00025X-9S
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHNYZ-0002gX-Fk
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688644433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G0os+kN4bZe4SfQH+vXx/HJh5UhcMsuNW8IKvBsb5N0=;
 b=Xz0z2QwiKXOHYikapwPfHMR3KEp2hkbDvLWvDxJ6JDhCBF/8DbWmBZ1d+1QBZmORbbJURu
 XzzmGMIUp9BrP5B3DqMI9IbNj/6MpSpvsgaPXyR1nKWUvLiamEnkP0eIDbaihjNofRRzjI
 Ey1VI2bQaNng8FBfa2cqAWiiXrC9FzE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-xqYO8imSPhWUMeFD_Qyo4A-1; Thu, 06 Jul 2023 07:53:51 -0400
X-MC-Unique: xqYO8imSPhWUMeFD_Qyo4A-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7672918d8a4so19144185a.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 04:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688644431; x=1691236431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G0os+kN4bZe4SfQH+vXx/HJh5UhcMsuNW8IKvBsb5N0=;
 b=caJPFFpws2uT0M2ManVy+9xj8zV0Pm/9udADMsi2s2xWmzJ5Jexjqu6q+a7aW857cb
 t44WG+st94gPLOEFekEu4pdPyE9Y67Ns78x972NSLcR6vMEL1jdYEenWnnuo9D0MLHdj
 dghMBKkn8qRB/Wrfd9R59+/ju3xQpiqnAGG5NWtrdRKCGoKmy8Xnc9sYJYx8FpWXTFJT
 mOcuMoFgqNuBY3IERIvESBUiPUUSR7Z6MVyicaIULmEIX0C+VFyExOdaLNYr6TR7ArBT
 qQXkn34ApIiinWYT+ja5cm5VyughM7cK3bmAkwvtCfFbWBQydBCRs78BpdrLam1vofIu
 +kAA==
X-Gm-Message-State: ABy/qLaHawsCNOgSRoDzxvlWa/AZ7n+c8LLJnmqUPUKNCb0WzDyobBwW
 1UIzQ+YeIDbVLNLXPJ2YQbVo2UuvR5ENaaP7C8hi4sPTO1AFjDyuFvAcztyqNHweoYA34ItcjmA
 tu0GkYNyPnIadCNI=
X-Received: by 2002:a05:620a:28cd:b0:765:58ac:9458 with SMTP id
 l13-20020a05620a28cd00b0076558ac9458mr1702990qkp.7.1688644431105; 
 Thu, 06 Jul 2023 04:53:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHvTIqjSdsRTGkthb34jWXbeqlNnjuAoaco3GgHjX54WBJNqPlEYKII4ufgBapizq/zICo2Hw==
X-Received: by 2002:a05:620a:28cd:b0:765:58ac:9458 with SMTP id
 l13-20020a05620a28cd00b0076558ac9458mr1702970qkp.7.1688644430801; 
 Thu, 06 Jul 2023 04:53:50 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 o11-20020ae9f50b000000b007675bef6b0dsm635112qkg.118.2023.07.06.04.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 04:53:50 -0700 (PDT)
Date: Thu, 6 Jul 2023 07:53:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH] docs/migration: Update postcopy bits
Message-ID: <ZKarTWisVKjpo+Wr@x1n>
References: <20230627200222.557529-1-peterx@redhat.com>
 <ddb293c6-2475-8fbb-7d84-f276ce17956a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ddb293c6-2475-8fbb-7d84-f276ce17956a@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Jul 06, 2023 at 12:15:47PM +0200, Laszlo Ersek wrote:
> One suggestion, to squash in:
> 
> diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
> index 6f65c23b47dc..3294679936b2 100644
> --- a/docs/devel/migration.rst
> +++ b/docs/devel/migration.rst
> @@ -594,8 +594,7 @@ Postcopy
>  'Postcopy' migration is a way to deal with migrations that refuse to converge
>  (or take too long to converge) its plus side is that there is an upper bound on
>  the amount of migration traffic and time it takes, the down side is that during
> -the postcopy phase, a failure of *either* side or the network connection causes
> -the guest to be lost.
> +the postcopy phase, a failure of *either* side causes the guest to be lost.
>  
>  In postcopy the destination CPUs are started before all the memory has been
>  transferred, and accesses to pages that are yet to be transferred cause
> 
> This removes "or the network connection" as a fatal failure.

Makes sense.

> 
> Acked-by: Laszlo Ersek <lersek@redhat.com>

Thanks!

-- 
Peter Xu


