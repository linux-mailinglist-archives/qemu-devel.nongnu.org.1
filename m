Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CF57B6F50
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:12:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnivd-0007ag-36; Tue, 03 Oct 2023 13:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnivb-0007aV-U3
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:11:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qniva-0003Ah-90
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:11:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696353081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pOyT0yLGwU1l+x166JxschO5fTXg3dj6zubnWBYl5mY=;
 b=PFkp0DfTGOAYGTWgCa3YxIKD4UGBgUWDudpMfwtCBOx25wzLZI6jEpAa3wHQhAYz0ilg08
 Tlx2UPu7CsYnJQ4wRCIXqkBdBey1oGxmvJI2mnMyaamCiS11aM7esA8zYLdrHPfgpYImKw
 /gFmbkttuLtexjZQqGXNtw1JXWf3jkk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-VZbAU9L5PbSMMd3QZ5ta0Q-1; Tue, 03 Oct 2023 13:11:20 -0400
X-MC-Unique: VZbAU9L5PbSMMd3QZ5ta0Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso880943f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696353079; x=1696957879;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pOyT0yLGwU1l+x166JxschO5fTXg3dj6zubnWBYl5mY=;
 b=cdlPI7QZdLYymXJ6SCIfSMTCNgO8HEnJwY1rRMassNj4d7AVFUxOotfK8Uxkaw/jon
 tmJJnAXKNnV0SVLXpU/jVLe5yVnaWI6gb6vmP472NvkebenVLTpcHRJUrJKcx7KIuMvD
 PnDK9lXxDUy8a3snV1pjaRE5wSmg4dg2u3cUMsdgLra3xPKI8UGfZHcJRRFPMDybTOaQ
 aSjEa5RFVdr5SVBQGYXglnsU5Rp2GFWGfDN0nNN/lC+RQRNVQEsGHGaJ3iiwgIukqb3t
 5ZXelrKQBkosJS2lSIBXaLM417Z6LRTWuWlWiwEfYGfZmnzoC1NlHk4EosZWcnV7iKk2
 EL2w==
X-Gm-Message-State: AOJu0YxhOzXC3w/fNI1q004Y5NHau04nsUXcJ7ClJVyjAlkZZbi9ICPl
 eEm5egGRv/oinWw+S7UbwyFaO/S6C4LydVUAqjEQKZw4NnEua2m9PTP/xqPCCF/GynZly2A2mHo
 B1zlF+0/QvuW5r2M=
X-Received: by 2002:a5d:6111:0:b0:321:4b47:d1c0 with SMTP id
 v17-20020a5d6111000000b003214b47d1c0mr11942365wrt.71.1696353079118; 
 Tue, 03 Oct 2023 10:11:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8TgcAOHFNAjOVJdL9JarRqEWGbcwQKHXFrhyJvVeyARsmPcddcFB5lNck/kw1T94YGPoMiw==
X-Received: by 2002:a5d:6111:0:b0:321:4b47:d1c0 with SMTP id
 v17-20020a5d6111000000b003214b47d1c0mr11942340wrt.71.1696353078722; 
 Tue, 03 Oct 2023 10:11:18 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 c6-20020a5d4cc6000000b00325c7295450sm2005175wrt.3.2023.10.03.10.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:11:18 -0700 (PDT)
Date: Tue, 3 Oct 2023 13:10:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?=  <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Volker =?iso-8859-1?Q?R=FC?= melin <vr_qemu@t-online.de>,
 =?utf-8?B?S8WRIHbDoSBnw7MgLCBab2x0w6E=?= n <DirtY.iCE.hu@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9?= e <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v10 00/11] Add VIRTIO sound card
Message-ID: <20231003130917-mutt-send-email-mst@kernel.org>
References: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
 <20231003101002-mutt-send-email-mst@kernel.org>
 <1ynzs.rzef353l0yhq@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ynzs.rzef353l0yhq@linaro.org>
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

On Tue, Oct 03, 2023 at 07:09:14PM +0300, Manos Pitsidianakis wrote:
> On Tue, 03 Oct 2023 17:10, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > I hope you are also fixing the linux driver to fix this in a robust
> > way, yes?
> 
> Hello Michael,
> 
> You can find pertinent discussion on the virtio-comment list here:
> 
> https://lists.oasis-open.org/archives/virtio-comment/202309/threads.html#00175
> 
> Fixing it is on our radar but it may prove non-trivial if it requires
> changing how the virtio-snd driver interacts with the kernel alsa API.

That is worrying. If spec can not be implemented spec has to change.

> Meanwhile AFAIK the qemu device conforms to the virtio spec in this case
> both with the previous version behavior and the current one. The change was
> made to compensate for the linux driver's behavior, not because it was
> previously incorrect.
> 
> Manos

It's hardly robust though, right? I.e. I think it's broken if there's
bounce buffering.

-- 
MST


