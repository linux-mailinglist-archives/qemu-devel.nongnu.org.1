Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F13F7B68F3
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:28:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneUo-0005h7-Mq; Tue, 03 Oct 2023 08:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qneUm-0005go-HT
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:27:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qneUk-0006nw-Qo
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696336041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PMTJ2OjL9m3JI03LR23HaYlZ5AdliUlUpGDBvT9D2dc=;
 b=RbRED9cQF4iXaarwyW2i9yFcSESrb3ApYppC0ZKOX5baqEE/wvhmyx/SLxHqQInbMPVmvz
 Grx4ddr1HCc0vd8qKQxpksEFOQYCWWn3mdKgoUsKSGRWegTcd4Iu80y3d/IyHbuKtuBdd6
 BlY7Del8J2OyDLLQYIIIQ+T5JjdNyW8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-Ad7UYfbSN1eSzvau8GNh7w-1; Tue, 03 Oct 2023 08:27:03 -0400
X-MC-Unique: Ad7UYfbSN1eSzvau8GNh7w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-405535740d2so6515535e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696336022; x=1696940822;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PMTJ2OjL9m3JI03LR23HaYlZ5AdliUlUpGDBvT9D2dc=;
 b=rsCHNx+rymHIMZ4ilpLVNA7qsL6YQVn1r6oPbzJNIV+uRZKr72F2KTmv22mS+k/3IS
 Gh+I+u6n/cMGUvIYFXxR53zi9TqIy5RicFdZb3FVpYwKgDW4c6mCLnkchp2mlJN/NRIX
 Zxu2jT+UGWPmeAemak/+zcqWyc9jU6MwNhwq9Ce2Q0Gq889TXoiamyIicQOATOFUyCjj
 Mdqa0WGxJSmVu2nrCqjFUIiuPsfVM2cKWfuDUBAQ7pveHOUIblC60H4BoYWBRcQK875/
 zZ/BUHsNFssI/imdeFZCOH35sbh2TuzCIAfLVG2cqBPE3gJrrgW68sU7/o55t+QjFDrt
 pYMg==
X-Gm-Message-State: AOJu0YydUxDiIrKgm02tngEAezz6oheag8AqeQsCAiDk+MSSOHLiixg9
 OFqD6b6/cXkaRQkZ4MBQBSF6voBDvubBzhsNxXamt9eXbnFXybEOJne075Iv3qGskLaMVQxEAuU
 cFU0n1YHPhjfzalM=
X-Received: by 2002:a7b:cd95:0:b0:405:95ae:4a94 with SMTP id
 y21-20020a7bcd95000000b0040595ae4a94mr12005243wmj.5.1696336022583; 
 Tue, 03 Oct 2023 05:27:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoYdnzI/MOYbQRq2ipmfYmbk44iE/nrnuTjIDANOgKq2JJecWk4ly8y+tGgSnEl0vueNyDRg==
X-Received: by 2002:a7b:cd95:0:b0:405:95ae:4a94 with SMTP id
 y21-20020a7bcd95000000b0040595ae4a94mr12005224wmj.5.1696336022255; 
 Tue, 03 Oct 2023 05:27:02 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 p8-20020a1c7408000000b003fefcbe7fa8sm1183516wmc.28.2023.10.03.05.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 05:27:01 -0700 (PDT)
Date: Tue, 3 Oct 2023 08:26:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Message-ID: <20231002183627-mutt-send-email-mst@kernel.org>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
 <CAJSP0QVWSQ8F-A1ryGLtd1jb8Go1Pr_N7AcLb5W5kSFv8T8jTA@mail.gmail.com>
 <6d766ab4-b6b8-b64b-1f9d-60c558b56509@redhat.com>
 <CAJSP0QV9RO7bkkcVFibnTv4tixmO3wKohSY+ia1D-UZiRzh5QA@mail.gmail.com>
 <20231002015259-mutt-send-email-mst@kernel.org>
 <CAJSP0QXgWsULW_61-MScvuWAiE3c4brYRyFc6q_==Sj6aLE8SQ@mail.gmail.com>
 <CAJSP0QU3jzFGnJ35Zbabf70Tbf+rPA_fvrA_eNxZ8TxOXQxZXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QU3jzFGnJ35Zbabf70Tbf+rPA_fvrA_eNxZ8TxOXQxZXA@mail.gmail.com>
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

On Mon, Oct 02, 2023 at 05:13:26PM -0400, Stefan Hajnoczi wrote:
> One more question:
> 
> Why is the disabled state not needed by regular (non-vhost) virtio-net devices?

Tap does the same - it purges queued packets:

int tap_disable(NetClientState *nc)
{   
    TAPState *s = DO_UPCAST(TAPState, nc, nc);
    int ret;

    if (s->enabled == 0) {
        return 0;
    } else {
        ret = tap_fd_disable(s->fd);
        if (ret == 0) {
            qemu_purge_queued_packets(nc);
            s->enabled = false;
            tap_update_fd_handler(s);
        }
        return ret;
    }       
}       

what about non tap backends? I suspect they just aren't
used widely with multiqueue so no one noticed.

-- 
MST


