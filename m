Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C2175204B
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 13:44:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJujZ-0003K2-7a; Thu, 13 Jul 2023 07:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJujW-0003Jb-Lp
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:43:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJujO-0006fL-Eq
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689248600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+qE5mbuahelVo0JYqul+5Ce1sr3x6+m407H4SspW+E0=;
 b=HQJ1kSDFfQMXJeqTOKUVZHZOSpBqEcRd+JHmskAszDBZLQIDj6pzqKj6ZNu5SgbAEY6Cn+
 iHdQ9e8r+IqMov3CF4YUjCvDe75in2edZxXdtP+Z7ptSAqPBWejac5AE5Trhoc624faIDA
 JLsqZVb94zxxxrWaxt/B4bSWThaVyj4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-HtQImLbEPJ6H2Pwnj3yfJg-1; Thu, 13 Jul 2023 07:43:18 -0400
X-MC-Unique: HtQImLbEPJ6H2Pwnj3yfJg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-992e684089aso42640866b.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 04:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689248597; x=1691840597;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+qE5mbuahelVo0JYqul+5Ce1sr3x6+m407H4SspW+E0=;
 b=MaZJmCndwjI1f4odDe2Mhuouqerqn299qRBCbuC61VBZ9XBTZ2+7NlJmv7ri2qgKiT
 uHW9bajPDYywAQX7+TetM3M338sv1sGgLN45TcMh8IgN6NqzD35NS8+0GeEyaoPGvfZ6
 t4KYRHQz6jJOkNB91f6rfaTd406cwPpi/ZNOJuDwAGoSRTbXOOlywUGxMoYysenvj54f
 RJfZzJKfeyARrzQ+oh6tVzshaVhDSQN5Uiwo4FLcc1wk5DcyuvAU8XMWmOHuFni00HQ7
 Sb6D0F4GpMFIj3FigbUaW58nbdOfcOoU/7EZNnYU9fLsulaH1BFtU20e2Oo76mv7xJuo
 97PA==
X-Gm-Message-State: ABy/qLb1rLgC283uhealGsYkJTW8My1gYbSEWcRWmYlLMwOWa0TrlQDm
 XogGrfQR+tH9onxhuXlSw4OrO5Pd3FwZ4ZV8teNdx1qWTPtF7FkGJgKUJlgWUwYEXhV8jzO25YN
 eim037a6OG9flQUU=
X-Received: by 2002:a17:906:5c:b0:993:f349:c98c with SMTP id
 28-20020a170906005c00b00993f349c98cmr1299149ejg.4.1689248597579; 
 Thu, 13 Jul 2023 04:43:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHmsKl2x24OtK13d07rOOBpBqhvuYUfsM2+VMXD/BQAEBVjbpTg8VI2ZiOygyIgNaVQvkYpJQ==
X-Received: by 2002:a17:906:5c:b0:993:f349:c98c with SMTP id
 28-20020a170906005c00b00993f349c98cmr1299136ejg.4.1689248597227; 
 Thu, 13 Jul 2023 04:43:17 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-94.retail.telecomitalia.it.
 [79.46.200.94]) by smtp.gmail.com with ESMTPSA id
 ss25-20020a170907039900b0098921e1b064sm3857947ejb.181.2023.07.13.04.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 04:43:16 -0700 (PDT)
Date: Thu, 13 Jul 2023 13:43:14 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Mike Christie <michael.christie@oracle.com>, 
 Stefan Hajnoczi <stefanha@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 1/3] scsi: fetch unit attention when creating the request
Message-ID: <osf4lhgyhpsxajrn2jzz25y6vegjurf7lyxohwh2qout5usun5@vwko2nat3eih>
References: <20230712134352.118655-1-sgarzare@redhat.com>
 <20230712134352.118655-2-sgarzare@redhat.com>
 <602625fe-f971-8843-88b6-a63dbe52befe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <602625fe-f971-8843-88b6-a63dbe52befe@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Wed, Jul 12, 2023 at 06:38:14PM +0200, Paolo Bonzini wrote:
>On 7/12/23 15:43, Stefano Garzarella wrote:
>>Commit 1880ad4f4e ("virtio-scsi: Batched prepare for cmd reqs") split
>>calls to scsi_req_new() and scsi_req_enqueue() in the virtio-scsi device.
>>This had no drawback, until commit 8cc5583abe ("virtio-scsi: Send
>
>More precisely, it was pretty hard to trigger it; it might be possible 
>using a CD-ROM, as it can report a MEDIUM_CHANGED unit attention.  I 
>will change "This had no drawback" to "No ill effect was reported"

Yep, agree!

>
>>"REPORTED LUNS CHANGED" sense data upon disk hotplug events") added a
>>bus unit attention.
>
>... that was fairly easy to trigger via SCSI device hotplug/hot-unplug.
>
>Queued the series, thanks for the tests and for applying the cleanups 
>on top.

Thanks for queueing!

>
>>Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
>
>Heh, I basically only wrote the "if (req->init_req)" statement so 
>that's pretty generous, but I'll keep it anyway. :)

Your help was invaluable ;-)

Thanks,
Stefano


