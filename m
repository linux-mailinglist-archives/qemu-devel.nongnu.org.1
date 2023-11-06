Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F104A7E1FF4
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:26:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxgY-00061A-Bj; Mon, 06 Nov 2023 06:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qzxgO-0005tN-OJ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:22:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qzxgM-0008Pl-1B
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699269727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zpMomuUvJppibAMWe/Ro5/EEi8rvCziO9UPlmPeugGA=;
 b=VXCbT+bP2lBqADsbhuhILlVRibRgzGYLnf+SFWp4E+461hBS3aQGovEeSaXvOxIP7sA/Ud
 O3bj6SdusX4VQ8qfy8/pGL2Ftf4wf3DFZBEOqg7OxFqbghv77BhG0u6k/cwR2ZpZfCXmlQ
 v4bQMVGF0ICE6CwHO0CXp2g0sE3mIlY=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-Rcy0ZZMEMo-b76tOFIIJ1A-1; Mon, 06 Nov 2023 06:22:05 -0500
X-MC-Unique: Rcy0ZZMEMo-b76tOFIIJ1A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507ee71fc4eso4384880e87.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699269724; x=1699874524;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zpMomuUvJppibAMWe/Ro5/EEi8rvCziO9UPlmPeugGA=;
 b=jWyqhmIWXDRRajNSLmLfQYhf0kacTsDQ60tMa99ylX4ScaRtuzZ1KQnfihrYTVdDsD
 FhAepMMcxRwQtkdAumeROwMDLFqHNYhC0harYjyYHWurOoGI//7LJKagdKu+ac0jZtSV
 x6RCIyP+pZObgYK9slz8OxWC2b4xNQAZqjFG4utsvIYip0sXNaCiBe2blgRa9jH3P3Z9
 EEcslthAiHGfC/uR6UJHxfI8pDvqPllLuYwKpBhM/FFa4t9NJgjqV4y8qZ3fh5mq/CQ6
 2AlZwzyHm/zT7gY4WcBo6Gepk4BSrhXY6FmwE2rts+1HJtIOa/62ajOlZyu5f7YTibpc
 l8tA==
X-Gm-Message-State: AOJu0YwCrMcY0MpxZcT4v44+cbY/DLjFlTkjtmCLmBavLa0hPLt1BXyH
 P5TNTin8k8Al4sXNQXry/AVo97OxsyIY6l5gYOsAsgQQfslXVpAuksfutevSAvTvPt8BB0JUaCo
 7SG3M352nc+p0C3Q=
X-Received: by 2002:a05:6512:e83:b0:509:47b9:63d0 with SMTP id
 bi3-20020a0565120e8300b0050947b963d0mr11602799lfb.61.1699269724340; 
 Mon, 06 Nov 2023 03:22:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPEslfnFO6Y9VGtZRga+KBlsQmixXFYv2EdCbIww9yWJQ7hBrpQ5nUeWwNWmLfOGrzRpa1xA==
X-Received: by 2002:a05:6512:e83:b0:509:47b9:63d0 with SMTP id
 bi3-20020a0565120e8300b0050947b963d0mr11602775lfb.61.1699269724018; 
 Mon, 06 Nov 2023 03:22:04 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 a18-20020a5d5092000000b0032d8354fb43sm9220726wrt.76.2023.11.06.03.22.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 03:22:03 -0800 (PST)
Date: Mon, 6 Nov 2023 06:21:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Volker =?iso-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>,
 =?utf-8?B?S8WRdsOhZ8OzIFpvbHTDoW4=?= <DirtY.iCE.hu@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v13 00/11] Add VIRTIO sound card
Message-ID: <20231106062140-mutt-send-email-mst@kernel.org>
References: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
 <20231101010813-mutt-send-email-mst@kernel.org>
 <87y1fbcern.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y1fbcern.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Mon, Nov 06, 2023 at 11:17:16AM +0000, Alex Bennée wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Mon, Oct 23, 2023 at 03:03:17PM +0300, Manos Pitsidianakis wrote:
> >> This patch series adds an audio device implementing the recent virtio
> >> sound spec (1.2) and a corresponding PCI wrapper device.
> >> 
> >> v13 can be found online at:
> >> 
> >> https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v13
> >> 
> >> Ref e7fb941cf7636fdff40cbdcdcd660dec5f15ca3c
> >> 
> >> Main differences with v12 patch series [^v12]:
> >> 
> >> - Fixed device aliases (thanks Volker Rümelin <vr_qemu@t-online.de>)
> >
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > to merge through the audio tree.
> 
> This hasn't been picked up yet and I'm worried we'll miss the
> soft-freeze. I guess this is the reason the entire audio stack is
> currently on "Odd Fixes".
> 
> Should we just re-spin with us as maintainers for virtio-sound and merge
> it through my tree?

Since there's no response I'll pick it up, don't worry.


