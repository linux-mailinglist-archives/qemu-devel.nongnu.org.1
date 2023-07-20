Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8B675B967
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 23:16:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMayf-0006TN-DL; Thu, 20 Jul 2023 17:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qMayd-0006TD-5x
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 17:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qMayb-0008KL-NR
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 17:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689887660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=un6P1F0G9Zbvn2sUzWbntYA2ZrQWiTinPEXM8NiA8hE=;
 b=ItzTfPkUQrqHwWpqsSpCMpCdPHSJnd2yw8H9zzAWetpN1opYu4W0nwGRsfvs6WVRp2hChe
 V/7ShPZ93A3jQKkKcupsTCZ07qR/bI/zo3Kc/mSsflDF71YmqPdyJCjujz4DL7kX620lzj
 cq9fakuNUZwAjvf6fj1RMW4qFm6uxU4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-tZ_HUegOO7ajPgZzJKemrQ-1; Thu, 20 Jul 2023 17:14:18 -0400
X-MC-Unique: tZ_HUegOO7ajPgZzJKemrQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fbe356b8deso6927975e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 14:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689887657; x=1690492457;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=un6P1F0G9Zbvn2sUzWbntYA2ZrQWiTinPEXM8NiA8hE=;
 b=PaTTz0wibEAi5+jbOaEsCvu60kgjtOkzm1SbFOLKedC1CxXVZV02rR2tSVbLYCE8Fs
 BPOls9A937r6IC45uhN+fuwf+nqt/6ct0VKnfQIKDW8d5S5quKWadKaZa6Ag+h2oFSE8
 VKtWRlzR7sKV1mkub6QHQEifzqeuC5aIoZi1o8wqmwUPrm7Wkm17NpvBIuZ/WAtsO2QJ
 askoImriM/11xSxWK3lcXFKzvxpP4QD9dUak9ib9C3LDflpJSFAKimnamkRAnhrLQMer
 8RWZm1NGI0pogzQtcug/9ub60U/K55I5/1KDiGTkPQ8YtAsXN8w//szCsMDlvGKmIui5
 qmAA==
X-Gm-Message-State: ABy/qLbZ847DUZEkOyMSRhGIDYuXffAj2lrT2VoZqf/aBKUooCDUD1CE
 Xq2dJw4VMA7mcZ4KImGUkvpboWr9xAXEgpPIYiP+ZVO2T+B8+ATVSEOr57L5FsZHCmILRvpg60B
 x6jiI2sy6cdy6/mY=
X-Received: by 2002:a05:600c:2907:b0:3fc:1bd:95a6 with SMTP id
 i7-20020a05600c290700b003fc01bd95a6mr426wmd.31.1689887657456; 
 Thu, 20 Jul 2023 14:14:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxlCxXg4WKbNIgfHozaBrraPCVaOfXiMV8FVblJ5+C5h0e17/wboayhrcd+iIh1L9eZg4uxA==
X-Received: by 2002:a05:600c:2907:b0:3fc:1bd:95a6 with SMTP id
 i7-20020a05600c290700b003fc01bd95a6mr416wmd.31.1689887657109; 
 Thu, 20 Jul 2023 14:14:17 -0700 (PDT)
Received: from redhat.com ([2.52.16.41]) by smtp.gmail.com with ESMTPSA id
 o5-20020adfcf05000000b003172510d19dsm2306103wrj.73.2023.07.20.14.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 14:14:16 -0700 (PDT)
Date: Thu, 20 Jul 2023 17:14:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
 slp@redhat.com, marcandre.lureau@redhat.com,
 viresh.kumar@linaro.org, sgarzare@redhat.com,
 takahiro.akashi@linaro.org, erik.schilling@linaro.org,
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Subject: Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user
Message-ID: <20230720171321-mutt-send-email-mst@kernel.org>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
 <20230720195837.GJ210977@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230720195837.GJ210977@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Jul 20, 2023 at 03:58:37PM -0400, Stefan Hajnoczi wrote:
> On Thu, Jul 06, 2023 at 12:48:20PM -0400, Michael S. Tsirkin wrote:
> > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Bennée wrote:
> > > Currently QEMU has to know some details about the back-end to be able
> > > to setup the guest. While various parts of the setup can be delegated
> > > to the backend (for example config handling) this is a very piecemeal
> > > approach.
> > 
> > > This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
> > > which the back-end can advertise which allows a probe message to be
> > > sent to get all the details QEMU needs to know in one message.
> > 
> > The reason we do piecemeal is that these existing pieces can be reused
> > as others evolve or fall by wayside.
> > 
> > For example, I can think of instances where you want to connect
> > specifically to e.g. networking backend, and specify it
> > on command line. Reasons could be many, e.g. for debugging,
> > or to prevent connecting to wrong device on wrong channel
> > (kind of like type safety).
> > 
> > What is the reason to have 1 message? startup latency?
> > How about we allow pipelining several messages then?
> > Will be easier.
> 
> This flag effectively says that the back-end is a full VIRTIO device
> with a Device Status Register, Configuration Space, Virtqueues, the
> device type, etc. This is different from previous vhost-user devices
> which sometimes just offloaded certain virtqueues without providing the
> full VIRTIO device (parts were emulated in the VMM).
> 
> So for example, a vhost-user-net device does not support the controlq.
> Alex's "standalone" device is a mode where the vhost-user protocol is
> used but the back-end must implement a full virtio-net device.
> Standalone devices are like vDPA device in this respect.
> 
> I think it is important to have a protocol feature bit that advertises
> that this is a standalone device, since the semantics are different for
> traditional vhost-user-net devices.

Not sure what that would gain as compared to a feature bit per
message as we did previously.

> However, I think having a single message is inflexible and duplicates
> existing vhost-user protocol messages like VHOST_USER_GET_QUEUE_NUM. I
> would prefer VHOST_USER_GET_DEVICE_ID and other messages.
> 
> Stefan

Exactly.

-- 
MST


