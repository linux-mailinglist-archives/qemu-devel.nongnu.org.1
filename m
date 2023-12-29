Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAF681FE69
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 10:02:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ8kM-00031j-MF; Fri, 29 Dec 2023 04:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1rJ8kK-00031L-DR
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:01:36 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1rJ8kI-0005Uv-Lg
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:01:36 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d3ec3db764so18324645ad.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 01:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703840492; x=1704445292; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jSJ9OeOsxPlsol74Tx7eUH+7WxzBZUw5PDJ630ePXyg=;
 b=lAyKT/iQdSPBueWy/itDtcRqQFjD0vF00L6CSUO/KM8XqluENvlY3MUtsfgYm6ShGE
 g2eJuv7mYciHYDY1zG/wfp5s8pZOWawYm/hZiBy3fCr55nm4uMsl3Xb78hqKqqNeOhFF
 unufCeNcgpE/xaCuHbEB7xizxNbE5k8bHzEJeZJbOrLIut0Cb3eaaxpNLskRIbzUGyQ2
 G80vdWEzmKPtoDmAkqoTW8IzisSTOzmlhYl0lhCZozPv7p2+8OmgoNxEXikuWmQadgw8
 SXYNgpeSx6eWUwzSTC/7eApGvrCd8NMLeWi/3CZROt/NRHdTYApSbp7BwENq1CNfebYG
 TCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703840492; x=1704445292;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSJ9OeOsxPlsol74Tx7eUH+7WxzBZUw5PDJ630ePXyg=;
 b=NmOSv3Qi5/rOPJSKhS8qMus7o6Hi2Hnm/h5MSD2cDfhYHvsvoa6OtI1cw/xtcNMDcm
 JJ6gosvrbp1lb3SvyQC/WEBWwdxcK/q7U0t761Ap2WJRDJBqo+eL/C+Xs5Ft6w3xvDnQ
 nuDsCnuoP6PnNK8lfLXdkeZq9jRWH7cLUkbJAq3lwKaFR79JaILZU5MN5XB/jHzaU5jw
 2vCZd9Nl3E4aaCJtgTQREzKJIvq8I6q5anw0rgEc62LJOGrJmuB8e2YPlPyu9Qw4QFZT
 2SJII9N4pAlB1UCvsAixKjkrRGgVVSprDn7443HcLXuvSdvMLTWJ+18P1FRalad+4KI+
 /7tA==
X-Gm-Message-State: AOJu0Ywts5WLH0xrWLrrMihqU4DIsWl9z4071LyKN3A+e30Gfam6SE/o
 SbkoPXeHV6l4jQ/D2fkt6ppSDwu79BT44g==
X-Google-Smtp-Source: AGHT+IGIRPs4fAB3loRYltNWrxuXoBEr9M7e3EOXTM7VP8yhJMBLTKxod7UbLrkg5rfi5tAuJsYJYA==
X-Received: by 2002:a17:902:be14:b0:1d4:6486:b013 with SMTP id
 r20-20020a170902be1400b001d46486b013mr3470203pls.8.1703840492376; 
 Fri, 29 Dec 2023 01:01:32 -0800 (PST)
Received: from leoy-huanghe.lan (211-75-219-200.hinet-ip.hinet.net.
 [211.75.219.200]) by smtp.gmail.com with ESMTPSA id
 k8-20020a170902760800b001d4526d0039sm9397284pll.169.2023.12.29.01.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 01:01:31 -0800 (PST)
Date: Fri, 29 Dec 2023 17:01:26 +0800
From: Leo Yan <leo.yan@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v3 0/4] virtio: Refactor vhost input stub
Message-ID: <20231229090126.GA156812@leoy-huanghe.lan>
References: <20231120043721.50555-1-leo.yan@linaro.org>
 <20231225110608-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231225110608-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=leo.yan@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Michael,

On Mon, Dec 25, 2023 at 11:06:35AM -0500, Michael S. Tsirkin wrote:
> On Mon, Nov 20, 2023 at 12:37:17PM +0800, Leo Yan wrote:
> > This series is to refactor vhost stub vhost-user-input.
> > 
> > Since vhost input stub requires set_config() callback for communication
> > event configurations between the backend and the guest, patch 01 is a
> > preparison for support set_config() callback in vhost-user-base.
> > 
> > The patch 02 is to add documentation for vhost-user-input.
> > 
> > The patch 03 is to move virtio input stub from the input folder to the
> > virtio folder.
> 
> Thanks!
> Now the release is out I'd like to apply this - can you please rebase on latest master and
> repost?

Sure.  But I found it's not this patch series causing merging conflict.

Since my patch series is based on Alex's patch series "virtio: cleanup
vhost-user-generic and reduce c&p" [1], when applying Alex's patch
series on the master branch, I found the confliction with below commeits:

  91208dd297 ("virtio: i2c: Check notifier helpers for VIRTIO_CONFIG_IRQ_IDX")
  298d4f892e ("vhost-user: fix the reconnect error")

@Alex, could you rebase the patch set "virtio: cleanup
vhost-user-generic and reduce c&p" and then I will resend my patch set?

Thanks,
Leo

[1] https://lore.kernel.org/qemu-devel/20231107180752.3458672-1-alex.bennee@linaro.org/

> > The patch 04 derives vhost-user-input from vhost-user-base.  We reuse
> > the common code from vhhost-user-base as possible and the input stub is
> > simplized significantly.
> > 
> > This patch set has been tested with the backend daemon:
> > 
> >   # ./build/contrib/vhost-user-input/vhost-user-input \
> > 		     -p /dev/input/event20 -s /tmp/input.sock
> > 
> > The series is based on "[PATCH v8 0/7] virtio: cleanup
> > vhost-user-generic and reduce c&p" which introduces vhost-user-base.
> > Based-on: <20231107180752.3458672-1-alex.bennee@linaro.org>

