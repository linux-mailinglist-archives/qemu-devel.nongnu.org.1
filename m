Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A36E7D599C
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:18:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvL39-00079H-7H; Tue, 24 Oct 2023 13:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qvL2x-00071m-SJ
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 13:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qvL2u-0007oC-Gn
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 13:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698167903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JBM+PSBaLfeuHRpxvOaPGjk0bGny+GLEyyL49+HQe7U=;
 b=NK92rHz8HBzcuUJxlKSovJ621yCnSRGTYnQsgc3XD8LL6oOaRm5pNV1ppPQJNeD8xbyajL
 dN7/zzhRduRmgDszkZ3XVB+0DgBTb5L38VTqD0OPTnVS1JPfe2l899XBpPgmma1tRv3r0S
 jMlFU2mXePXKItLVs1CQI9Kznkscs1s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-KOD56xo0P7iqui1hQSuZrg-1; Tue, 24 Oct 2023 13:18:21 -0400
X-MC-Unique: KOD56xo0P7iqui1hQSuZrg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-402cd372b8bso32752775e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 10:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698167900; x=1698772700;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JBM+PSBaLfeuHRpxvOaPGjk0bGny+GLEyyL49+HQe7U=;
 b=azpLmsKk45HmPVWsAqGp7byuBN2/JjQl0lHNvewMBnlIvivEPN5EW4PSWzfUGutE8E
 Es4xJ0ZAMIE4CQgBUgJ7fK3KfnPgfLr6ABfMWQOQMvhZGtLMwmPfxuvW4gi1h8HnMKiz
 6u1tglTIP0D+eHDLCl+znvM3OZ5PUs/yBVkkODHpSndM0/pE6qQJLtd3OrpbceXc3ztR
 J1nPfL6OTim35LvA336vMxKzva6UmoVhBhZHDH38ldkqa8I8o/eVr6rQsOzAZnd2mUVb
 zObWt+tcy0iCk+QC/8qPfo17XhCrKlykSZjJUIGgX6xaIWFIbr12BsSa34dGl8DeqnM/
 ijdA==
X-Gm-Message-State: AOJu0YxbduRc6FJJZncl7GU8ycoxo9wd89l5+/zoZjEZF2hkkr7RP977
 lZb+wiMpv/iffVjD11QYZ1MXgdnHCIAxjXd6PNzUS9c83caPVNXs6Eb1Yu+leaeKYJD0jX0WrYV
 Uvm9nqrNfndMlaOQ=
X-Received: by 2002:a5d:5248:0:b0:32d:8e6f:ecb3 with SMTP id
 k8-20020a5d5248000000b0032d8e6fecb3mr7788988wrc.65.1698167900267; 
 Tue, 24 Oct 2023 10:18:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb2JgG4sir1iSt95rAbCVbEsruVfgytR51IBg9pNSaDDx9Ygedtxhc7OjIBu3sETU8rj7A/Q==
X-Received: by 2002:a5d:5248:0:b0:32d:8e6f:ecb3 with SMTP id
 k8-20020a5d5248000000b0032d8e6fecb3mr7788959wrc.65.1698167899889; 
 Tue, 24 Oct 2023 10:18:19 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f1:7547:f72e:6bd0:1eb2:d4b5])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a5d49cd000000b003176c6e87b1sm10196680wrs.81.2023.10.24.10.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 10:18:19 -0700 (PDT)
Date: Tue, 24 Oct 2023 13:18:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 virtio-fs@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Fam Zheng <fam@euphon.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH v5 0/6] virtio: cleanup vhost-user-generic and reduce c&p
Message-ID: <20231024131734-mutt-send-email-mst@kernel.org>
References: <20231019095610.2818087-1-alex.bennee@linaro.org>
 <878r7s0wnz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878r7s0wnz.fsf@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 24, 2023 at 06:14:36PM +0100, Alex Bennée wrote:
> 
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
> > A lot of our vhost-user stubs are large chunks of boilerplate that do
> > (mostly) the same thing. This series continues the cleanups by
> > splitting the vhost-user-base and vhost-user-generic implementations.
> > After adding a new vq_size property the rng, gpio and i2c vhost-user
> > devices become simple specialisations of the common base defining the
> > ID, number of queues and potentially the config handling.
> >
> > I've also added Manos' vhost-user-sound while I was at it.
> 
> Ping MST. Any more comments or happy to take as is?

It's tagged already.

> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro


