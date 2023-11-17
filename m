Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 754207EF064
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 11:30:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3w6L-00047v-3X; Fri, 17 Nov 2023 05:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r3w6J-00047n-VY
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 05:29:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r3w6G-0008Dp-1w
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 05:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700216962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1gK3mQRlkoMymALNdcsbPhhfPohaZ7s1f0G11Yd+Qdw=;
 b=UuYZ37FPJ4CRwExI+OW14ZoEjuxy0JEFCq3Y0yEYzCgF2VG1gH3YjsjD0nd3EdVBGGc56m
 9MHuDvaOPBxGaZanSVezdrwm8Mo+TVuJ5DIWfdapfoK22t5eCUxWe3QgChz17tIMZPz9RW
 Ld/hvGE4DL51Sa2sG2qL2tg/lw/F6Wc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-JMQhMLYgPaWgBjrzVv3YcA-1; Fri, 17 Nov 2023 05:29:20 -0500
X-MC-Unique: JMQhMLYgPaWgBjrzVv3YcA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c5194d4e98so16027521fa.3
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 02:29:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700216958; x=1700821758;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gK3mQRlkoMymALNdcsbPhhfPohaZ7s1f0G11Yd+Qdw=;
 b=HVSgu7xy2hSZqMG06Oy2b2F0COzmjbhJt+r2csFmoOlnN/MTY2KKeztqAA2vyNDPcs
 fax+tm6rDXKBjtlQjG2c29O+5NPBjKziiZmxRAdQ1yFausc2a3U6usKTCMFwO9hThpxM
 0DmJ5DON7NWp+roAcD+2UW3Vb19iCf/PFFSZI0x6iAYAM1ZD9M4vkdi6ciNQl2pUSIey
 6jpK0v4xzZyvruwIZzYTH15nD2u0nu57e/8ltC9tqrG40YyZLjWcyqEHDCBkKS9CLwTG
 V3wiFRhLjvcywc1/BH6vpJATObNARkQiX9yfIIcMkljvHOPK6s/MAbSr6z4W5z66iROv
 cKBw==
X-Gm-Message-State: AOJu0Yydyz3HL/ArlGTLqncM2tw5f75F2uusTIJIFDv/EUs+m09pbn16
 R5E/PDYBC6XVs9uGV+TliKXcMXu39v0PrCzFMP8jZmXiX2rDPjP20XiaXlk18GEHpTieclIMjOm
 OKKx/7ydfCo4DWlSX4Yn3WW0=
X-Received: by 2002:a2e:7a14:0:b0:2c5:f54:2477 with SMTP id
 v20-20020a2e7a14000000b002c50f542477mr8228373ljc.40.1700216958581; 
 Fri, 17 Nov 2023 02:29:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMgXA8CBe0OX2HwMTSR2UVp8GUXZJDpeVOtInlHzD8w2F8Fl3Vqkcqi3fIP41so0Hwx971YA==
X-Received: by 2002:a2e:7a14:0:b0:2c5:f54:2477 with SMTP id
 v20-20020a2e7a14000000b002c50f542477mr8228359ljc.40.1700216958253; 
 Fri, 17 Nov 2023 02:29:18 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f7:1a37:81d:ec1e:4435:fcea])
 by smtp.gmail.com with ESMTPSA id
 o2-20020a05600c510200b0040a4835d2b2sm6812035wms.37.2023.11.17.02.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 02:29:17 -0800 (PST)
Date: Fri, 17 Nov 2023 05:29:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 0/2] vhost-user-test: Add negotiated features check
Message-ID: <20231117052838-mutt-send-email-mst@kernel.org>
References: <cover.1699793550.git.yong.huang@smartx.com>
 <CAK9dgmbjF__gwDn+oEehiyS0P2vSGh-onfFXCHsuOGZhzNhc+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK9dgmbjF__gwDn+oEehiyS0P2vSGh-onfFXCHsuOGZhzNhc+g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 16, 2023 at 09:01:28AM +0800, Yong Huang wrote:
> ping

Sit tight pls it's only been a couple of days.
But if you want to, address comments by Markus pls.


