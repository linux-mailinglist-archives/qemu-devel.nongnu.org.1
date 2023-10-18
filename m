Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 749657CD78F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:09:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt2XX-0008W5-GH; Wed, 18 Oct 2023 05:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt2XR-0008Vt-0T
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt2XN-0004LC-7N
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697620099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IXh9ZT6PuCnZUuEtXniq9r/0+b8K+f4RTJLdLFDWwbY=;
 b=EmiczJgWc1mO0f0ohnMISltCO13xos6IGoUNLdjUtcN9HocA37SH6OvH9qzGq+nn9ZI2Jb
 w+F5EjOHSd/RrbzoEjdYScZw8VZL34dtbNhkQsrPXJ7O/wvnu4/HWfIybDG6PWReQfRTW7
 fxspJbjsh9s1X+yLYtNPc4DigwePykE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-m3j2XQEGPsOm_VAo2MfY6w-1; Wed, 18 Oct 2023 05:08:17 -0400
X-MC-Unique: m3j2XQEGPsOm_VAo2MfY6w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9be601277c2so302802366b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 02:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697620096; x=1698224896;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IXh9ZT6PuCnZUuEtXniq9r/0+b8K+f4RTJLdLFDWwbY=;
 b=SX62kyDT8EIEpq8bAxaZhl+ookx0mndYImDqLp4UA5eL+8cVKR+OYeHO4uuAnsKQhD
 RylPnR7S6PZCNkA87NLaDlHahW0Ctl6kFHt1jejBVsJXk3uRhxi5/ptYWEl6FbS6wg/l
 de2Quh9BGdVc+cfntkeKc+/hUE2aiqouW85TCKLC/XIB5PxibwFzGCTGWI8B9fKiFxdC
 OuLhpFj2cyI4oaANq18CSINEzjZ5sBLWYeUhZn+KMTPrmo2Po0NaTO5x39EQlNQ4w0tK
 V8H0w61hhFXl6mtmhaqom/zNv2w/Je75DNt9o0KHdzngp8d7VtJpTrEyj7+VN2XAq4KY
 B8JA==
X-Gm-Message-State: AOJu0Ywi5TY8AH8ip1W0i2VFVffyLHn0LAPO+iTRCuAPCr6jeoVh03O1
 I0XmesHH2IKvICuS5BFTYJ2z75hsYAre4zB49WIdUucRaGYsGpvcMfkPbghCJDN1H7JkwWuPXVt
 Ai/sKxJ9xsByh11Q=
X-Received: by 2002:a17:907:9706:b0:9ae:5aa4:9fa with SMTP id
 jg6-20020a170907970600b009ae5aa409famr3823219ejc.42.1697620096487; 
 Wed, 18 Oct 2023 02:08:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKwMAq4i6clRCiVzvlunZAj62IGGbV1lgb9QIPjv01IMB2eQF7Yz0hUTtvi5+eO/M70UMywg==
X-Received: by 2002:a17:907:9706:b0:9ae:5aa4:9fa with SMTP id
 jg6-20020a170907970600b009ae5aa409famr3823194ejc.42.1697620096140; 
 Wed, 18 Oct 2023 02:08:16 -0700 (PDT)
Received: from redhat.com ([193.142.201.38]) by smtp.gmail.com with ESMTPSA id
 bn4-20020a170906c0c400b0099cb0a7098dsm1280525ejb.19.2023.10.18.02.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 02:08:15 -0700 (PDT)
Date: Wed, 18 Oct 2023 05:08:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Volker =?iso-8859-1?Q?R=FC?= melin <vr_qemu@t-online.de>,
 =?utf-8?B?S8WRIHbDoSBnw7MgLCBab2x0w6E=?= n <DirtY.iCE.hu@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9?= e <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v11 00/11] Add VIRTIO sound card
Message-ID: <20231018050537-mutt-send-email-mst@kernel.org>
References: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
 <2pvjw.psr1yjx1ztc1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2pvjw.psr1yjx1ztc1@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 18, 2023 at 11:49:00AM +0300, Manos Pitsidianakis wrote:
> On Wed, 11 Oct 2023 17:34, Manos Pitsidianakis <manos.pitsidianakis@linaro.org> wrote:
> > This patch series adds an audio device implementing the recent virtio
> > sound spec (1.2) and a corresponding PCI wrapper device.
> > 
> > v11 can be found online at:
> > 
> > https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v11
> > 
> > Ref 885b01fe272541fdab5583780d4c3a59bfd8e734
> > 
> Hello Gerd, MAINTAINERS says you own the hw/audio subsystem, would you pull
> this in your tree if/when it is to be merged?
> 
> For context, the device was in hw/audio initially but in early list
> discussions we decided to move it with the rest of virtio devices.

Link to these discussions? virtio-gpu is under ./hw/display
seems inconsistent. And you are asking Gerd to merge but
your MAINTAINERS patch wouldn't even let people know
he needs to be Cc'd on changes.


> At its current state it LGTM, if there's agreement that there are no issues
> we can merge this series.
> 
> All the best,
> 
> --
> Manos


