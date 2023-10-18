Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2857CD9B5
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:52:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt49d-0003gZ-Ai; Wed, 18 Oct 2023 06:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt49b-0003bg-Bp
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt49Y-0007A5-28
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697626311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ky8S2VrF4gmpu+BSPvFMvLj6/JP3yAM2tK+aIbSWzMc=;
 b=ilOGj59Fn11dCZDqpedMkrveRI7eWul9Tjk5ek5UT+DA5ZJF67mMpisN2rSkvGOMWFnyNQ
 wBcMDA3XNPWCmaRiDr6nI5HjkMmzoUo4RcsFtb4N+M3jfqWldtOdZpMfWDDiKHXN+xKecy
 9gyEmMzIm4gbEPUf+YQ0/1hDObckW8Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-lioU959jOVGXUyh195JrOQ-1; Wed, 18 Oct 2023 06:51:49 -0400
X-MC-Unique: lioU959jOVGXUyh195JrOQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9ae0bf9c0b4so506497066b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 03:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697626308; x=1698231108;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ky8S2VrF4gmpu+BSPvFMvLj6/JP3yAM2tK+aIbSWzMc=;
 b=HL7S4eHjPHpQQazQjHbmdEQ6h4TW8/RZxga4OqKEtycYEhDPnoTTu0EKKrQZBJ267n
 Qr+eB418NpvPGOusitRgJ5nCvd4WmVj0hmM8wplWPvtgLFTCzWJtj02mdGODh8PCLd/t
 DbAx4SPNY9R8LHSmKASTD4QXraUiMKrHzWiVPmiQER0hmuHUzu0wV7QPQ1dRAfk0cqiK
 XwmNQDrG1uqX92a17sdw/eH8LCxMUl1523IwnRdZZ1WFhrWHEODooSyhNiLFGEsr1t+M
 9+wzFgrcrlWJ6BsvyvyvKpw7C32Cg5078woYewqMq6Wz9yGu1dEnpayGL/uo15KPFj6+
 q/fQ==
X-Gm-Message-State: AOJu0Yy9IRKsfxSVYuiFk3ImqGwkZfko2RG5YyhKE45ZQga9pN88QF3F
 TXLK4mXMCw+qlsI+I1Nk53CfGA54F98M0B82Y69pHj8M8grfGB9v7hIUTsPx/zgziwxULN0piS2
 Nhe8AYUfHDTV4i1k=
X-Received: by 2002:a17:907:3f04:b0:9bf:2d82:53b9 with SMTP id
 hq4-20020a1709073f0400b009bf2d8253b9mr3756761ejc.59.1697626308692; 
 Wed, 18 Oct 2023 03:51:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkf3ey4XjvjL7JIHH0POHs9hoET5HpOUnUWLXsqw+gLp0Mr3QKS7KS5vc6zLs9RyC8pFB7cQ==
X-Received: by 2002:a17:907:3f04:b0:9bf:2d82:53b9 with SMTP id
 hq4-20020a1709073f0400b009bf2d8253b9mr3756736ejc.59.1697626308344; 
 Wed, 18 Oct 2023 03:51:48 -0700 (PDT)
Received: from redhat.com ([193.142.201.38]) by smtp.gmail.com with ESMTPSA id
 p4-20020a170906b20400b009c7518b131dsm706171ejz.196.2023.10.18.03.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 03:51:47 -0700 (PDT)
Date: Wed, 18 Oct 2023 06:51:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, eblake@redhat.com,
 dave@treblig.org, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 raphael.norwitz@nutanix.com, yc-core@yandex-team.ru,
 den-plotnikov@yandex-team.ru, daniil.tatianin@yandex.ru
Subject: Re: [PATCH 4/4] qapi: introduce CONFIG_READ event
Message-ID: <20231018064912-mutt-send-email-mst@kernel.org>
References: <20231006202045.1161543-1-vsementsov@yandex-team.ru>
 <20231006202045.1161543-5-vsementsov@yandex-team.ru>
 <87sf692t0i.fsf@pond.sub.org>
 <ae494c44-1bd6-435e-8bd8-0ec2ba9ceaa6@yandex-team.ru>
 <877cnkzasr.fsf@pond.sub.org>
 <a55e8b57-3411-4587-affd-3bc0635af4fe@yandex-team.ru>
 <878r80tdyd.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878r80tdyd.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Wed, Oct 18, 2023 at 12:36:10PM +0200, Markus Armbruster wrote:
> > x- seems safer for management tool that doesn't know about "unstable" properties..
> 
> Easy, traditional, and unreliable :)

> > But on the other hand, changing from x- to no-prefix is already done when the feature is stable, and thouse who use it already use the latest version of interface, so, removing the prefix is just extra work.
> 
> Exactly.
> 

I think "x-" is still better for command line use of properties - we
don't have an API to mark things unstable there, do we?

-- 
MST


