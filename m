Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D93F7DEEFB
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 10:33:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyU56-0004Fr-Gh; Thu, 02 Nov 2023 05:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qyU4z-0004Eb-82
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 05:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qyU4x-0005wy-JC
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 05:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698917610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IhhdRZqdXNt5pXUOztWtuy7vbeTrCeZFKhRzcxuk3EY=;
 b=L7Vj4yx5VnPQUdkt4je7fmbyUHzeiucouxt+tRHun4oLmOJ2/ZpLux+6DjmOt9CpgwNkxG
 MBvaaBWRn/i0FEDMQAAZkwPsD/Hqtuyy9PU3ysUVLBQVqAYxnCI9VO+RUUyqiRNadrWHz+
 ZfCf+VhkM6AfV/WXO+BNb+M01ONaveA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-G3tj2jPANV6vhHLCQpFLwA-1; Thu, 02 Nov 2023 05:33:28 -0400
X-MC-Unique: G3tj2jPANV6vhHLCQpFLwA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4090181eec2so4744925e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 02:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698917607; x=1699522407;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IhhdRZqdXNt5pXUOztWtuy7vbeTrCeZFKhRzcxuk3EY=;
 b=iW7+AY/XIxbdkLu7DcwNGl7SS7+rBQGzN09c4RYkHrD9GgOR1u4LJlE0UxC0vIpR4d
 i4RyS81ML+imtxGHTupybUgvxcYTec9CqsdR2zxWRjTcmxBE53ifYFuD5LbmP8FpwNdS
 mAiwNsD2Gm7EglnZ4jgkOi+nbs6gndg45zR1bqHj2ndUO8R5+gLGc2StBP14CKtzJFOo
 uNytgLF0P/obDgbGYvhavCgnQCdKfp/yVeWE8tPFiWkvu4hQ+mv9k5tyzvc+XUZ7bV0I
 jKXJ2i8VeJuKLkXdHqVa+euQXC0ypC6FBBbxY3tRGzWLr+13r+AU9MGHYabT9FudvTP8
 lAhQ==
X-Gm-Message-State: AOJu0YwDqy83ahKi3DHXIj9wEH3F0J7T3JXKB+oAIqFuKdFGe00Uesl7
 30Ti60ZFeLHVRs/9Xt09i+hzI9qroMrg302KyqmcAr4em0JxS3pKXS9hCTdz7x3TSwRAw1/tvsX
 qDgw5vkLmk3BXiNk=
X-Received: by 2002:a05:600c:46cf:b0:406:52f1:7e6f with SMTP id
 q15-20020a05600c46cf00b0040652f17e6fmr15820398wmo.12.1698917607503; 
 Thu, 02 Nov 2023 02:33:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE+cDiW+jVVfix/hB5LuRk2ZphmT9rsIeCFFODvJi0LGvWpLeihQf77nDReAVCX1ovbGe6XA==
X-Received: by 2002:a05:600c:46cf:b0:406:52f1:7e6f with SMTP id
 q15-20020a05600c46cf00b0040652f17e6fmr15820385wmo.12.1698917607128; 
 Thu, 02 Nov 2023 02:33:27 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:efc3:a5be:5586:34a6:1108])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a05600c0a4300b003fe1fe56202sm2249771wmq.33.2023.11.02.02.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 02:33:26 -0700 (PDT)
Date: Thu, 2 Nov 2023 05:33:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
Message-ID: <20231102053202-mutt-send-email-mst@kernel.org>
References: <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <CAOEp5Oern10jW8Pi-_mceU_ZJVD=a1f3tW8rB2O4efLX45-nvw@mail.gmail.com>
 <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
 <CACGkMEv=A0KS-LtgZmsMehdoUL=EuQzhkfNipKaV1kdUr2Y5Bw@mail.gmail.com>
 <d0db0fb1-0a58-45b7-a623-df6ee9096e2e@daynix.com>
 <20231101023805-mutt-send-email-mst@kernel.org>
 <39a02a4c-f8fa-437c-892f-caca84b8d85d@daynix.com>
 <20231101050838-mutt-send-email-mst@kernel.org>
 <e469b33b-c3f3-4d88-bdf2-508c4a35c827@daynix.com>
 <CAOEp5OcDMdKKPHSVd-GxT-GkBpvbWkMijSBgwihPsEnxmDR7eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOEp5OcDMdKKPHSVd-GxT-GkBpvbWkMijSBgwihPsEnxmDR7eA@mail.gmail.com>
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

On Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri Benditovich wrote:
> Probably we mix two different patches in this discussion.
> Focusing on the patch in the e-mail header:
> 
> IMO it is not acceptable to fail QEMU run for one feature that we can't make
> active when we silently drop all other features in such a case.

If the feature is off by default then it seems more reasonable
and silent masking can be seen as a bug.
Most virtio features are on by default this is why it's
reasonable to mask them.

-- 
MST


