Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 405617DDE33
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 10:14:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy7EY-0000Ba-OB; Wed, 01 Nov 2023 05:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qy7EV-00008n-Sn
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:09:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qy7EU-0008Ru-4i
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698829788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zyljAw343015hYEoeEMGm63ljx3DiOt5UDG1FNIarHE=;
 b=Vq88EwxSToDXz4u96DE9YWVGkRGub1w/qL1V7Bd3R6mLYXhDTJaV4hrVeKEaYH8MQB7a3S
 D2B/Hn4HDFfzMfngX9E5CCkEWeVQkSR5peDvCz4nmqgGzFXP18W/ORd9aoUBMt9KfWuydZ
 8gDTroOHjvMGl2vCq06ka/CZoi9taYc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-pV_qAZG-N3mWRX6kWW2J6Q-1; Wed, 01 Nov 2023 05:09:47 -0400
X-MC-Unique: pV_qAZG-N3mWRX6kWW2J6Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9c778321afdso479478566b.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 02:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698829785; x=1699434585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zyljAw343015hYEoeEMGm63ljx3DiOt5UDG1FNIarHE=;
 b=eiMNGnhEhXoNvd9LB52mvv3mTzQ/lrDEqfbN+r62UKYFQe14oLpsPKc92ttbN85qrg
 BoC50KqAc0kVD53g/wJL7+PbZM4WcTyIFaUws78LaV61eMRzBMNkvbHdjjbr/0fwjLom
 dSFWhRCcj1oUg4tIs+WXstq+G6MSf3uRw3lltIlUUVwKHPqXs4mMUJWk8jcdHRfqCenl
 9ZwDaCUgDLeOjeKxSr9emJFI1OMT9QbMMrFow0ylsfuBghaXkn1mPH9UYg2dziINGnsy
 UFf4wW+d88HKf1buxCLUFgkLUYObUN0a2vHZRbEfssG4BouuLYygQFSAY6xm70MELYmb
 4ROg==
X-Gm-Message-State: AOJu0YyihyARn8CD6bZlYfwvF+CNJV+aWyPFEcmx9KkOIbOfP26x/4Nl
 Wa6aqHTLO4Vh1606QYa77a1RkThnB5Obq+FhjwUOsa6AG+IAZLXAJm40uHRJpxHHAzrs+bEEv0d
 bZ73z3CleclryEHTOfqmFAOw=
X-Received: by 2002:a17:907:930a:b0:9a2:1e03:1572 with SMTP id
 bu10-20020a170907930a00b009a21e031572mr1541694ejc.19.1698829785654; 
 Wed, 01 Nov 2023 02:09:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnAdiskL8Th9uztV1crZQbwJHC2yqVoY2yCvbyaAB2t0nlywf2XkbIOXUTv3S/mDNJrau85A==
X-Received: by 2002:a17:907:930a:b0:9a2:1e03:1572 with SMTP id
 bu10-20020a170907930a00b009a21e031572mr1541678ejc.19.1698829785351; 
 Wed, 01 Nov 2023 02:09:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f7:e470:9af7:1504:1b35:8a09])
 by smtp.gmail.com with ESMTPSA id
 lg10-20020a170906f88a00b009b94fe3fc47sm2146941ejb.159.2023.11.01.02.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 02:09:44 -0700 (PDT)
Date: Wed, 1 Nov 2023 05:09:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
Message-ID: <20231101050838-mutt-send-email-mst@kernel.org>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-12-akihiko.odaki@daynix.com>
 <CAOEp5OdEEVcojjwCOU+9Z5yBKN+e5iNbAMOA5d-97D81N4Y0tw@mail.gmail.com>
 <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <CAOEp5Oern10jW8Pi-_mceU_ZJVD=a1f3tW8rB2O4efLX45-nvw@mail.gmail.com>
 <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
 <CACGkMEv=A0KS-LtgZmsMehdoUL=EuQzhkfNipKaV1kdUr2Y5Bw@mail.gmail.com>
 <d0db0fb1-0a58-45b7-a623-df6ee9096e2e@daynix.com>
 <20231101023805-mutt-send-email-mst@kernel.org>
 <39a02a4c-f8fa-437c-892f-caca84b8d85d@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39a02a4c-f8fa-437c-892f-caca84b8d85d@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

On Wed, Nov 01, 2023 at 05:35:50PM +0900, Akihiko Odaki wrote:
> On 2023/11/01 15:38, Michael S. Tsirkin wrote:
> > On Wed, Nov 01, 2023 at 01:50:00PM +0900, Akihiko Odaki wrote:
> > > We had another discussion regarding migration for patch "virtio-net: Do not
> > > clear VIRTIO_NET_F_HASH_REPORT". It does change the runtime behavior so we
> > > need to take migration into account. I still think the patch does not
> > > require a compatibility flag since it only exposes a new feature and does
> > > not prevent migrating from old QEMU that exposes less features. It instead
> > > fixes the case where migrating between hosts with different tap feature
> > > sets.
> > 
> > When in doubt, add a compat flag.
> 
> Personally I'm confident about the migration compatibility with patch
> "virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT". virtio-net already does
> the same thing when the tap implementation on the destination implements
> virtio-net header support while the counterpart of the source does not.

Trust me there's been so many times where we were very sure and
problems come up later. Just don't enable new functionality for
old machine types, problem solved. Why is this hard?

-- 
MST


