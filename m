Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 900FC7CE063
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:51:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7t8-0003wn-IQ; Wed, 18 Oct 2023 10:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt7t5-0003wW-Qh
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:51:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt7t0-0003Zf-Ro
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697640661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jLKEGJT+8WxybR9JfNG78kHzUE7TpLHv69cBuB9Io1s=;
 b=g49epNQ5MW/NzQX78PkMNdmmUjG19YQr4DZnESvsa6rcvSnt3XSI6J+3YV+rEiBMpM9rsC
 hHFKRByUe+Pkf3PkNxHPBYaZiDIYfcPeSQ0P60mScYZTgRnjD0bCDfPPW87z+fwMhRXxZ1
 ZeuqfCF4DM/6gYSPbyQviC06ooDCrO8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-6r6SiKnsPtOjdcjoL2SKHA-1; Wed, 18 Oct 2023 10:50:55 -0400
X-MC-Unique: 6r6SiKnsPtOjdcjoL2SKHA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40837aa4a58so8505075e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697640654; x=1698245454;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jLKEGJT+8WxybR9JfNG78kHzUE7TpLHv69cBuB9Io1s=;
 b=aH3yXj8VuKUgeRIFVRRjPHAHhAZ5tUkMHlma86vMXw7lFXmiWmb8VUkW+zwj66p1Cm
 BLW1/ccputwbfCgl3gsJ7US2R391JCuoh9aktPs6j+LNGTkcXhCiigVuScO9ce7ShHQ0
 kDJG5LwvBCnkKY05+MWA3qOp9IFMSTox8QtAQibe1iUpLqmDmssFvzw9oEmMNDzRJjBv
 TJsNqBWOiO3ad/EzveVTiCbyCueuDkFNuQkmhPCtA7ONxj6dDwERoA3pzV0MglK3TVqZ
 593hQGkvxYGO0rZyfrhZMT2K+a8XKGO/oZhPl8suOlXJZK5wiw955DWbEgeht54oixiO
 bIbg==
X-Gm-Message-State: AOJu0Yyxygc6j7FL1CdcPlfhZ48JbEGdXEHQcQxOtHzhXgzNiAE44AEt
 NZmQIers8v3oR6LXxLBEZUErFGGq9OoA3X4y7qFXrUltC5sBvWPje+Ad0Ify11rsXO0omnR3WdO
 glaVsUtH0/9uthh8=
X-Received: by 2002:a05:600c:1c84:b0:405:784a:d53e with SMTP id
 k4-20020a05600c1c8400b00405784ad53emr4551011wms.20.1697640653876; 
 Wed, 18 Oct 2023 07:50:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVRIvU4w6TckLtgvQsA893KVT9bpr4NWmCcXhJpIjpaH+lSnSW9bn+ABJZLdMr7iNVqKwB2g==
X-Received: by 2002:a05:600c:1c84:b0:405:784a:d53e with SMTP id
 k4-20020a05600c1c8400b00405784ad53emr4550991wms.20.1697640653557; 
 Wed, 18 Oct 2023 07:50:53 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 je6-20020a05600c1f8600b004063ea92492sm1897975wmb.22.2023.10.18.07.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 07:50:52 -0700 (PDT)
Date: Wed, 18 Oct 2023 10:50:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?=  <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Volker =?iso-8859-1?Q?R=FC?= melin <vr_qemu@t-online.de>,
 =?utf-8?B?S8WRIHbDoSBnw7MgLCBab2x0w6E=?= n <DirtY.iCE.hu@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9?= e <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v11 00/11] Add VIRTIO sound card
Message-ID: <20231018104939-mutt-send-email-mst@kernel.org>
References: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
 <2pvjw.psr1yjx1ztc1@linaro.org>
 <20231018050537-mutt-send-email-mst@kernel.org>
 <2q986.633fbwmm52y@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2q986.633fbwmm52y@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Oct 18, 2023 at 04:44:00PM +0300, Manos Pitsidianakis wrote:
> Hello Michael,
> 
> Thank you for your reply;
> 
> On Wed, 18 Oct 2023 12:08, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Oct 18, 2023 at 11:49:00AM +0300, Manos Pitsidianakis wrote:
> > > On Wed, 11 Oct 2023 17:34, Manos Pitsidianakis <manos.pitsidianakis@linaro.org> wrote:
> > > > This patch series adds an audio device implementing the recent virtio
> > > > sound spec (1.2) and a corresponding PCI wrapper device.
> > > > > v11 can be found online at:
> > > > > https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v11
> > > > > Ref 885b01fe272541fdab5583780d4c3a59bfd8e734
> > > > Hello Gerd, MAINTAINERS says you own the hw/audio subsystem, would
> > > you pull
> > > this in your tree if/when it is to be merged?
> > > 
> > > For context, the device was in hw/audio initially but in early list
> > > discussions we decided to move it with the rest of virtio devices.
> > 
> > Link to these discussions? virtio-gpu is under ./hw/display
> > seems inconsistent.
> 
> I agree that it is inconsistent, but I do not know if there is a general
> consensus on this. I am fine with placing it anywhere that is deemed
> appropriate.
> 
> <87a5xkde0c.fsf@linaro.org>
> https://lore.kernel.org/qemu-devel/87a5xkde0c.fsf@linaro.org/
> 
> > And you are asking Gerd to merge but
> > your MAINTAINERS patch wouldn't even let people know
> > he needs to be Cc'd on changes.
> 
> No, I didn't ask to merge this, I asked if Gerd would be the one merging it
> because I am not sure myself and wanted more information. What do you think
> should be the correct process?
> 
> --


I'd put it under audio and then you get an unambigous maintainer
to go through.


