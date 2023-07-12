Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5967500BD
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 10:08:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJUsT-0000v4-AY; Wed, 12 Jul 2023 04:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qJUsR-0000uZ-2L
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:07:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qJUsO-0002on-Sl
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689149228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O59WCKxUbMfNmDOivxXW/OE1WeT+hJiPQK1AgImH5r8=;
 b=auUlN1RrAJknTbapptR1B15ksZmkXvFzjs6+eBDkrSRxhEFM5gntsAZH30IC1MbM8WN1ag
 Za8cf52spa5pkTfHV2Zta3eF4hbEkWtlymFNtV67X6SGOM6VBEKqcaD6udWt2OzlgeP490
 j0fpixcJ5klOHb5PY1o2jy0ZEEd2VDI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-KNhjHSXNOtqLNLiVzwj9PQ-1; Wed, 12 Jul 2023 04:07:00 -0400
X-MC-Unique: KNhjHSXNOtqLNLiVzwj9PQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-993eeb3a950so260725366b.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 01:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689149219; x=1691741219;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O59WCKxUbMfNmDOivxXW/OE1WeT+hJiPQK1AgImH5r8=;
 b=HUSiGxaZ7gFnUzhWtqT08/nUlMMXvkGWVXLfEkFtOMqfSbnoMB982/D2lQfVlEnZMF
 btqIdmVBs2K1p1AYUCmh9YqTvoLVHCe5GGNpJwk6Do5eJ7omUh+sE68f4syQFuHlDYOr
 Ao99u+KqZOkS2Bvlu56MYwVPSLgfdgwtA47W6GGMdqcAmeIBngLFwSNJGPE1OBBs1j6n
 E50D8Ps0ZURZGmtFevH3BlY3EllmT/tc+/EDAC/obP8NI7hjUaprmtu+Pb1//3xWFWk1
 rCwMe8tIN23kebjpCRdhn/jANfX5sB9+YoGdJgahPpaNUqUNUY3ur4Q6RS7UaEPJUJkF
 5DYQ==
X-Gm-Message-State: ABy/qLZH3zaLhp+VHFXUf6r9ANQ98T/ulNsB3C6Itwq/pVHCDiqqmRQX
 /DwLbZw4lK5Hm++Ky0DAjlnKA3ULoEL2o+2+6pHdf/dn4BHao/nhLBiTvM7FYvjjK7IyjsO25Ym
 6ARLz9rQVE5Anrf8=
X-Received: by 2002:a17:906:74d6:b0:993:e860:f20 with SMTP id
 z22-20020a17090674d600b00993e8600f20mr11896935ejl.19.1689149219545; 
 Wed, 12 Jul 2023 01:06:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGuq7PuqcFm5S8HFkqYTOvb4nN21xQh/cSvepQEY3PNGwe/jmsaBmcKV8FXkw8sNp4Dce30IQ==
X-Received: by 2002:a17:906:74d6:b0:993:e860:f20 with SMTP id
 z22-20020a17090674d600b00993e8600f20mr11896899ejl.19.1689149219068; 
 Wed, 12 Jul 2023 01:06:59 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 e22-20020a170906249600b00992dcae806bsm2197356ejb.5.2023.07.12.01.06.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 01:06:57 -0700 (PDT)
Message-ID: <10a3d00f-a3a2-91d1-0f94-9758cdc4b969@redhat.com>
Date: Wed, 12 Jul 2023 10:06:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
 <765f14c5-a938-ebd9-6383-4fe3d5c812ca@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <765f14c5-a938-ebd9-6383-4fe3d5c812ca@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/11/23 22:21, Mike Christie wrote:
> What was the issue you are seeing?
> 
> Was it something like you get the UA. We retry then on one of the
> retries the sense is not setup correctly, so the scsi error handler
> runs? That fails and the device goes offline?
> 
> If you turn on scsi debugging you would see:
> 
> 
> [  335.445922] sd 0:0:0:0: [sda] tag#15 Add. Sense: Reported luns data has changed
> [  335.445922] sd 0:0:0:0: [sda] tag#16 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  335.445925] sd 0:0:0:0: [sda] tag#16 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  335.445929] sd 0:0:0:0: [sda] tag#17 Done: FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> [  335.445932] sd 0:0:0:0: [sda] tag#17 CDB: Write(10) 2a 00 00 db 4f c0 00 00 20 00
> [  335.445934] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  335.445936] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  335.445938] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  335.445940] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  335.445942] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  335.445945] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [  335.451447] scsi host0: scsi_eh_0: waking up 0/2/2
> [  335.451453] scsi host0: Total of 2 commands on 1 devices require eh work
> [  335.451457] sd 0:0:0:0: [sda] tag#16 scsi_eh_0: requesting sense

Does this log come from internal discussions within Oracle?

> I don't know the qemu scsi code well, but I scanned the code for my co-worker
> and my guess was commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2 had a race in it.
> 
> How is locking done? when it is a bus level UA but there are multiple devices
> on the bus?

No locking should be necessary, the code is single threaded.  However, 
what can happen is that two consecutive calls to 
virtio_scsi_handle_cmd_req_prepare use the unit attention ReqOps, and 
then the second virtio_scsi_handle_cmd_req_submit finds no unit 
attention (see the loop in virtio_scsi_handle_cmd_vq).  That can 
definitely explain the log above.

Paolo


