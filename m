Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B922C75043A
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 12:15:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJWrh-0003jd-2Z; Wed, 12 Jul 2023 06:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJWrf-0003it-8x
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 06:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJWrd-0004mC-IE
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 06:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689156868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D/4n1T4Di9dqAOFGS+inlBrET7BRHhbAxPcO28uG01Q=;
 b=EwEHO/CMCDjPAbcLzht1SImzymCmQ+2QwnweO3fFiTSPK7qxZUN49Jua7OQaB1xqBHqNZU
 f0Jb0PZRXJBIWqk1XeKY3uwOZYjtS9Wc0wtENSXf09TBb/eKvGhTd4Uzkx4Q/kHGKRoUFa
 vhj2gk6WSCqRoUrTaQ13vFgN8NpsZyI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-Tzk1NdghMVWJkn6MHQkwvg-1; Wed, 12 Jul 2023 06:14:21 -0400
X-MC-Unique: Tzk1NdghMVWJkn6MHQkwvg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-635e664d2f8so64335096d6.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 03:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689156860; x=1691748860;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/4n1T4Di9dqAOFGS+inlBrET7BRHhbAxPcO28uG01Q=;
 b=dP7hosEHlqAkLJ1YqH60cMNPh7uwohT/OY0O0QIoH9ZG0H1CvylJ+V9oeqBd/+BPkr
 68Qba54+lkpb4ETdiEaRbupMmgOoBnps+gidFQ0Mk24eI4aDrvvhsxJ5AMohzLlcqeAw
 G0nNSQDFOSILQfEiovZy4uA3y1eeI8pwHbdQt3jzL9D0kbxBF5U9Ckm75+eI3yycasJN
 RTPeCnb1xJrRsXuxFXuqmCqB4XaEjY0AsqTmp0gehHrnSyrDwrXTlt5ezLaOMpphqtin
 e52CmbpIvEF0htEAs/q0edQo/0HDqKvVE/44v+E9k5dgfmTJAma11dI4IrjWdmbMhUnM
 GKtg==
X-Gm-Message-State: ABy/qLZvhdSCe9EwNbsqaOZLMHN+EXjihpEWJBy12E0FTDZoLaE6n8VJ
 kNlfv42AAjHpSaHsZ6ulSVyQ9rMLVWRhbAZP1fVco6LocOyHaPy071ADUgm4HWHT6EhOPkut0Nf
 s3TeuUFpkrmUtnCs=
X-Received: by 2002:ac8:5b0b:0:b0:403:9f48:7ce1 with SMTP id
 m11-20020ac85b0b000000b004039f487ce1mr17970969qtw.53.1689156860693; 
 Wed, 12 Jul 2023 03:14:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHlxbb8j7LshAiGKZNfsSGwJ4zTSF2mOzrqRvKk5LzC+D2tYuiNcSmvHeC6WLXDnQaz2YIMjw==
X-Received: by 2002:ac8:5b0b:0:b0:403:9f48:7ce1 with SMTP id
 m11-20020ac85b0b000000b004039f487ce1mr17970952qtw.53.1689156860434; 
 Wed, 12 Jul 2023 03:14:20 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-6.retail.telecomitalia.it.
 [82.53.134.6]) by smtp.gmail.com with ESMTPSA id
 c14-20020ac81e8e000000b0040331f93ee0sm2123644qtm.77.2023.07.12.03.14.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 03:14:20 -0700 (PDT)
Date: Wed, 12 Jul 2023 12:14:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, 
 Mark Kanda <mark.kanda@oracle.com>, linux-scsi@vger.kernel.org, 
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, 
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Message-ID: <bnitgwesvbjdkbrvnykltherzddi3zvms3ckd5yk3w4whdplu3@tv43e42wjl55>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
 <765f14c5-a938-ebd9-6383-4fe3d5c812ca@oracle.com>
 <10a3d00f-a3a2-91d1-0f94-9758cdc4b969@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <10a3d00f-a3a2-91d1-0f94-9758cdc4b969@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

On Wed, Jul 12, 2023 at 10:06:56AM +0200, Paolo Bonzini wrote:
>On 7/11/23 22:21, Mike Christie wrote:
>>What was the issue you are seeing?
>>
>>Was it something like you get the UA. We retry then on one of the
>>retries the sense is not setup correctly, so the scsi error handler
>>runs? That fails and the device goes offline?
>>
>>If you turn on scsi debugging you would see:
>>
>>
>>[  335.445922] sd 0:0:0:0: [sda] tag#15 Add. Sense: Reported luns data has changed
>>[  335.445922] sd 0:0:0:0: [sda] tag#16 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>[  335.445925] sd 0:0:0:0: [sda] tag#16 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>[  335.445929] sd 0:0:0:0: [sda] tag#17 Done: FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
>>[  335.445932] sd 0:0:0:0: [sda] tag#17 CDB: Write(10) 2a 00 00 db 4f c0 00 00 20 00
>>[  335.445934] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>[  335.445936] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>[  335.445938] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>[  335.445940] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>[  335.445942] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>[  335.445945] sd 0:0:0:0: [sda] tag#17 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>[  335.451447] scsi host0: scsi_eh_0: waking up 0/2/2
>>[  335.451453] scsi host0: Total of 2 commands on 1 devices require eh work
>>[  335.451457] sd 0:0:0:0: [sda] tag#16 scsi_eh_0: requesting sense
>
>Does this log come from internal discussions within Oracle?
>
>>I don't know the qemu scsi code well, but I scanned the code for my co-worker
>>and my guess was commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2 had a race in it.
>>
>>How is locking done? when it is a bus level UA but there are multiple devices
>>on the bus?
>
>No locking should be necessary, the code is single threaded.  However, 
>what can happen is that two consecutive calls to 
>virtio_scsi_handle_cmd_req_prepare use the unit attention ReqOps, and 
>then the second virtio_scsi_handle_cmd_req_submit finds no unit 
>attention (see the loop in virtio_scsi_handle_cmd_vq).  That can 
>definitely explain the log above.

Yes, this seems to be the case!
Thank you both for the help!

Following Paolo's advice, I'm preparing a series for QEMU to solve the
problem!

Stefano


