Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8EA80CFDA
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 16:43:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCiRX-0006VR-Dc; Mon, 11 Dec 2023 10:43:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rCiRV-0006Tg-GM
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 10:43:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rCiRT-0008R5-O8
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 10:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702309414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EZzv2D5M80dhyCVlbU1FfjpFyDb2CrO4x3Eklyb8abM=;
 b=c0w09A5ZWIrjPTDsCS7Y+OMqbfGu2obDfVluCzxjB+I3g014dPWYRfrqahtrQSSCwY0smQ
 BbfSRtFsNQB7N5cHGkGLdnc9Ru3MA1i0DnKhYP1iIPgRGFwfj+JAcdi1AWhbUdzAWg23ht
 fdNMkS7sHz+BhSdknIoclZW8Di4ADWQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-Ifjea4LhMC2fzKaKKYBp-w-1; Mon, 11 Dec 2023 10:43:32 -0500
X-MC-Unique: Ifjea4LhMC2fzKaKKYBp-w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40c2c144e60so30247995e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 07:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702309411; x=1702914211;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EZzv2D5M80dhyCVlbU1FfjpFyDb2CrO4x3Eklyb8abM=;
 b=daM9EhqttVsqlB+ZoqjJaYDMsRs1fzXc4yFpqJ+y3DBe3UpaylaXcSJLm36M5WTF7C
 SQTQoeM1+ZeJ06sywYlA3NlrQpuu1I1J2JbO7Ytp5BZ4CoxBLQBnp7SGQCCm+eEw6Oq1
 V/WL2bXtHV5hNTleiS6luQb6/TOcXW8s/raTEfyQvdrZkcDEFECAlN7za76jz7cqNIv0
 Wr20EqtEtZa5POQMoo0VleGRg6aHLqEQPnXQFuEE7Tu2S50iUCVobkVcV0Kk5FwAf1Z/
 VesqPR9z2D6uL46LeXnHyA/gD3zkbsCv58N4RexBxDDCFLYgX4xI6mdZqmj+Itpfk6/q
 6MBw==
X-Gm-Message-State: AOJu0YwgiGlwha+flvt7H7hnTxEokSWVEsnBjguKTTPxV4CQFfPSzAPY
 Qx20XTtzBknExZcdCSbXvx4zqc59CKERFw/RXfdcqCL7Y89XCCyU16curmpQrNa7fCvFE0+0CIV
 jUWisgYuYMTnteqQ=
X-Received: by 2002:a05:600c:1d19:b0:40c:27a4:96af with SMTP id
 l25-20020a05600c1d1900b0040c27a496afmr2511351wms.126.1702309411479; 
 Mon, 11 Dec 2023 07:43:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUFWN0kcr9Ng/hcet+pyuYp9QMjQokTZYGS8/2HHQSE3F14AOvL0aY2G+1N9gbU6n8XB33sg==
X-Received: by 2002:a05:600c:1d19:b0:40c:27a4:96af with SMTP id
 l25-20020a05600c1d1900b0040c27a496afmr2511344wms.126.1702309411130; 
 Mon, 11 Dec 2023 07:43:31 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ff:4f00:b091:120e:5537:ac67])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5d4ccb000000b00334b29127c9sm8861785wrt.51.2023.12.11.07.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 07:43:30 -0800 (PST)
Date: Mon, 11 Dec 2023 10:43:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, qemu-devel@nongnu.org,
 "Zhang, Chen" <chen.zhang@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH v8 00/19] virtio-net RSS/hash report fixes and improvements
Message-ID: <20231211104224-mutt-send-email-mst@kernel.org>
References: <20231210-rss-v8-0-9553ee714d38@daynix.com>
 <CAOEp5Ofj+a2rqGWw=oLXBqrXqUj6XRc=Je3ScaE5sxZFzaAOdA@mail.gmail.com>
 <431e5902-970b-4fd5-8302-dcc9c4c76bd7@daynix.com>
 <CAOEp5OcW1xrr8EVeiRqQ5OnecxB6xtKJt6hLCqz6GgmSg7CctQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOEp5OcW1xrr8EVeiRqQ5OnecxB6xtKJt6hLCqz6GgmSg7CctQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Dec 11, 2023 at 02:34:56PM +0200, Yuri Benditovich wrote:
> https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg05859.html

It's from August, I think it's fair to say it's not going upstream
unless there's some activity. Yuri did you review that series then?
Care to ack?

-- 
MST


