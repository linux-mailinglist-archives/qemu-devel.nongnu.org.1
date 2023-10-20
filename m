Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5CC7D0B14
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:04:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtlP5-0003Ie-6c; Fri, 20 Oct 2023 05:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtlOx-0003IO-CP
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:02:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtlOv-0004NK-3h
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697792556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FsQ1rSjMAc72knYFxU23v6d1BM6b3+MXsfACDqYrJIc=;
 b=d+0wn4+HQKtuBAqOPh7NC2D8kMfY0O9AqVU6WS8Nnmo1PFUwFI0loa8PJZtU5aLoDCYgmb
 NEKx5OPYd5nt70iK/lShG0gB27iivYobayiJHMNo67u++8Bwjoa70aGnk2Ji0a6vO3P/kE
 MB0+PM6LNTCc+uM7o4wJSy68SStPTpw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-9KiJ1DRMMW6Xm6L8z48UiA-1; Fri, 20 Oct 2023 05:02:34 -0400
X-MC-Unique: 9KiJ1DRMMW6Xm6L8z48UiA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-313c930ee0eso256844f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 02:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697792553; x=1698397353;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FsQ1rSjMAc72knYFxU23v6d1BM6b3+MXsfACDqYrJIc=;
 b=JfYU97p1mUxy/71cHbjToXgixAhopS0Qp3IZWkQL/aMPLDN7C2qWZdiQaHX2J7xLV3
 EymWKrJkGzwtUczZP2W9gI3gGVeC6AyVcYOme4/V5RHItVdNK30br2GOvat6rNtaB8fw
 xYLk0wGt+oBGFGh+TbRfOCaQhLav8q7NDq6n83WzlUH8NuPDtEEnTOH9Jl9xWtc1gtkC
 6V+S8nHwrOMIt67ST3q3fKJQxZw/TBpTIyo1MmSvrlQPimrqQ2YgKyX3G2oVMDoIApb9
 baRCGLXhSynzLcBVWcfJ9UYkWn6iwDRZ6fBbL95st0KXLIAO0zyUt1AqkbPn4Z8MZh9O
 uh3w==
X-Gm-Message-State: AOJu0Yy5lQMQgD9rdUmZ0C3L/Vs6lLPuru7QXZXO5BevY9ioxJ5GzX6z
 TvfZ/JCY3w0B2l+HaQvK0k/XfNh2IRMhbtYysQlJnan8U8nAVtnET/h2Aaz2Bj/MMzR3w/J7s42
 C25GX0gk71DdPU4U=
X-Received: by 2002:a5d:4b07:0:b0:309:1532:8287 with SMTP id
 v7-20020a5d4b07000000b0030915328287mr853124wrq.19.1697792553462; 
 Fri, 20 Oct 2023 02:02:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcwWTL71X4oHYNhTvlS9jvQMJjJ3kDm8+MIBCKsaJ4qJX/uSde+QzekUJm4329RRPFPO2sow==
X-Received: by 2002:a5d:4b07:0:b0:309:1532:8287 with SMTP id
 v7-20020a5d4b07000000b0030915328287mr853092wrq.19.1697792553047; 
 Fri, 20 Oct 2023 02:02:33 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 w10-20020adfec4a000000b0032d2f09d991sm1234497wrn.33.2023.10.20.02.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 02:02:31 -0700 (PDT)
Date: Fri, 20 Oct 2023 05:02:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, qemu-devel@nongnu.org,
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
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v5 5/6] hw/virtio: add vhost-user-snd and virtio-snd-pci
 devices
Message-ID: <20231020050210-mutt-send-email-mst@kernel.org>
References: <20231019095610.2818087-1-alex.bennee@linaro.org>
 <20231019095610.2818087-6-alex.bennee@linaro.org>
 <20231020031407.xd4ykc4msfdmoav5@vireshk-i7>
 <878r7x90a0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878r7x90a0.fsf@linaro.org>
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

On Fri, Oct 20, 2023 at 09:16:03AM +0100, Alex Bennée wrote:
> 
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> > On 19-10-23, 10:56, Alex Bennée wrote:
> >> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> >> 
> >> Tested with rust-vmm vhost-user-sound daemon:
> >> 
> >>     RUST_LOG=trace cargo run --bin vhost-user-sound -- --socket /tmp/snd.sock --backend null
> >> 
> >> Invocation:
> >> 
> >>     qemu-system-x86_64  \
> >>             -qmp unix:./qmp-sock,server,wait=off  \
> >>             -m 4096 \
> >>             -numa node,memdev=mem \
> >>             -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on \
> >>             -D qemu.log \
> >>             -d guest_errors,trace:\*snd\*,trace:\*sound\*,trace:\*vhost\* \
> >>             -chardev socket,id=vsnd,path=/tmp/snd.sock \
> >>             -device vhost-user-snd-pci,chardev=vsnd,id=snd \
> >>             /path/to/disk
> >> 
> >> [AJB: imported from https://github.com/epilys/qemu-virtio-snd/commit/54ae1cdd15fef2d88e9e387a175f099a38c636f4.patch]
> >> 
> >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >
> > Missing SOB from Manos ?
> 
> oops, guess I need a respin then ;-)

Just ask Manos to send his S.O.B in a reply.


> >
> >> Message-Id: <20231009095937.195728-6-alex.bennee@linaro.org>
> 
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro


