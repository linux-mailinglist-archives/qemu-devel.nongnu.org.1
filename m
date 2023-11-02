Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B05B87DF38A
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 14:19:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyXaz-0007ZG-S6; Thu, 02 Nov 2023 09:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qyXav-0007Z1-I8
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:18:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qyXat-0007Oe-GM
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698931122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMIj/hF5hAP1fkNBDfEw4wOlEx5Sw35cEC7GEjsufoM=;
 b=gEWMVJlbydTEOg+KHIysdIRb7Ixs6Qk4ecLS2MYvvRbQzw5CUwYN0nL0VSrgn3r8cKtXyU
 AixeAmwbtCjhQ9dXju5ZBH0I9tpO8w2H6S2yMaQd+X56dl9CvH+/LZjDlZ8ZldEO7PJMQq
 s8RneaJQxZH/uWLM1YWZhaj+IrQC2nY=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-QMLzNWxuOFaT4MpPh_pvgQ-1; Thu, 02 Nov 2023 09:18:41 -0400
X-MC-Unique: QMLzNWxuOFaT4MpPh_pvgQ-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1eb43ff49b2so1143750fac.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 06:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698931120; x=1699535920;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TMIj/hF5hAP1fkNBDfEw4wOlEx5Sw35cEC7GEjsufoM=;
 b=OjR762yJDs9H9lGLihjgzTU2+3tMyFaWFMcymZjp2tJzKEp9lcQufhNsRY1SOEY4gB
 /ryC4C5vlkqmCyZdHuuGvbGaM1hjPxvRHYWW6CIjMF3kuNe5pHUq3tTiMboqz+eTSKy3
 MYznVyr2pGTvX7YnCxktZfHadUeG1VTvA7kefV2PS6o1ZMe85p+uR4gIKmMmhf9rN8UJ
 s6MHgpAUYJi14S3Sd9qgUHToKxF25q6/6SekcQ/o0p3J0UF3E8hCEuy5IP005GuedHfV
 XTTkL4NAhLMwn4hWZzvawzVF08Gc5+4ZfidXEs8KadM2kYm0NPuD+atmQk5Jz2xRm8nE
 F2VA==
X-Gm-Message-State: AOJu0YwIu9B3L1a2yeVwUjQNO7Ec/1sBw5dC4znFoKK3mgygzC4ddQJ9
 Q3lE0++nciVK0U0SSouWSI5OZCWzq1sve9JPBcE24s0gORECnwbUoioIW/EaPFZN53RtOngltZX
 y8ioe95um+QgVeJI=
X-Received: by 2002:a05:6870:700e:b0:1e9:9469:a858 with SMTP id
 u14-20020a056870700e00b001e99469a858mr21269816oae.39.1698931120386; 
 Thu, 02 Nov 2023 06:18:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbFBwotZ6Fw5jebk8JVChBUNwa7tCXz3w5kac73S2tO50qZJLhu5/RG5IcItbgG+ANJwPHCQ==
X-Received: by 2002:a05:6870:700e:b0:1e9:9469:a858 with SMTP id
 u14-20020a056870700e00b001e99469a858mr21269804oae.39.1698931120079; 
 Thu, 02 Nov 2023 06:18:40 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:efc3:a5be:5586:34a6:1108])
 by smtp.gmail.com with ESMTPSA id
 j127-20020a0de085000000b00592236855cesm1191138ywe.61.2023.11.02.06.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 06:18:39 -0700 (PDT)
Date: Thu, 2 Nov 2023 09:18:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
Message-ID: <20231102091717-mutt-send-email-mst@kernel.org>
References: <d0db0fb1-0a58-45b7-a623-df6ee9096e2e@daynix.com>
 <20231101023805-mutt-send-email-mst@kernel.org>
 <39a02a4c-f8fa-437c-892f-caca84b8d85d@daynix.com>
 <20231101050838-mutt-send-email-mst@kernel.org>
 <e469b33b-c3f3-4d88-bdf2-508c4a35c827@daynix.com>
 <CAOEp5OcDMdKKPHSVd-GxT-GkBpvbWkMijSBgwihPsEnxmDR7eA@mail.gmail.com>
 <20231102053202-mutt-send-email-mst@kernel.org>
 <CAOEp5OefD2LN2MDnEkE=DOMSX0Jw8Z6gAiKAag4dtkecmr1Jgg@mail.gmail.com>
 <20231102072540-mutt-send-email-mst@kernel.org>
 <CAOEp5OdEudOFXuitG2NSBfuCQiwFJ72rYZsyvLFRfKR4kQvTDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOEp5OdEudOFXuitG2NSBfuCQiwFJ72rYZsyvLFRfKR4kQvTDg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

On Thu, Nov 02, 2023 at 02:00:46PM +0200, Yuri Benditovich wrote:
> 
> 
> On Thu, Nov 2, 2023 at 1:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Thu, Nov 02, 2023 at 12:20:39PM +0200, Yuri Benditovich wrote:
>     >
>     >
>     > On Thu, Nov 2, 2023 at 11:33 AM Michael S. Tsirkin <mst@redhat.com>
>     wrote:
>     >
>     >     On Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri Benditovich wrote:
>     >     > Probably we mix two different patches in this discussion.
>     >     > Focusing on the patch in the e-mail header:
>     >     >
>     >     > IMO it is not acceptable to fail QEMU run for one feature that we
>     can't
>     >     make
>     >     > active when we silently drop all other features in such a case.
>     >
>     >     If the feature is off by default then it seems more reasonable
>     >     and silent masking can be seen as a bug.
>     >     Most virtio features are on by default this is why it's
>     >     reasonable to mask them.
>     >
>     >
>     >
>     > If we are talking about RSS: setting it initially off is the development
>     time
>     > decision. 
>     > When it will be completely stable there is no reason to keep it off by
>     default,
>     > so this is more a question of time and of a readiness of libvirt. 
> 
>     Well when we flip the default we'll need compat machinery for sure ;)
> 
> 
> Of course, on the flip or default we'll need to keep compatibility to earlier
> machine types.
> But, because in the perspective it makes sense to make the RSS is on by
> default, I do not think we need _now_ to make qemu fail to start if the ebpf
> can't be loaded.
>  

Generally if user asks for something and we can't do it, we must fail.
If we can't apply a default we need a better default.
qemu has a bug in that it can't generally distinguish between default set
automatically and same default given on command line.

-- 
MST


