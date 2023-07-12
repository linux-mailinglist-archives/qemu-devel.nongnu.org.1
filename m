Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F84750461
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 12:26:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJX18-0006jI-NJ; Wed, 12 Jul 2023 06:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJX15-0006iT-E1
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 06:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJX12-0001ZS-Uq
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 06:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689157451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=16LsduwYFZpz+6uAILPKz1Rz7ytcW9Aohn733XoPS64=;
 b=hil4hFL5X8hOj0uw/kKBhNKMmSHPeofpRcBJQpsAs98EasDrdhoaLRRNoimkitY33Ma6mO
 Ldm5zGsCrxWvMIW8FjIaANBV2OBtFq2HICfTI9JyQraFCic8FtY8Y6glJCTMvZFSObpWA6
 wmWFwYAGzx1MP4CxOb0yNBVqfDoQhfw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-WpxT7PbWMa6JwplyeNv0Ow-1; Wed, 12 Jul 2023 06:24:10 -0400
X-MC-Unique: WpxT7PbWMa6JwplyeNv0Ow-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7659924cf20so661480985a.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 03:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689157449; x=1691749449;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=16LsduwYFZpz+6uAILPKz1Rz7ytcW9Aohn733XoPS64=;
 b=YUHnwzqpv5vTTzfPbYQ566aMHEu0mpZMKiv/vOPo/Dwt4cYqKuVpU66mXaZgXXaRbX
 Ga0nYre3AQPS1bmgRIMvDK+uwims55fcyg3cgxUzTPnWdRkta/nyge0QHmpgmf9nq3BP
 P9qc7N/mcYfmsmHFirvVWaxgx1QtWM5rg+Vk7/EYe6DjC21HBjvZQYj5Kurq/W2m1wHm
 Aa+Q4cXTKIbKfs2IAsMOmN86WHfyYWSVn3WxbT6UDfbCpcLxJch+2V6zI/MmJxWHsHQO
 Fhb5Cch91Drj7vliY90X/gbb1efmlbWBHN5Xg31W4G+Oeu/2udTEW+DJ7Xn2Qt0sscIk
 Brjg==
X-Gm-Message-State: ABy/qLb6BUX9djOA85H17hAnm/4dipP7ktt0J7CGrF3JVRciAjOi6H49
 ZULF9pfUbRrv3vMlEy8EUSRYE/DMSeLQjRghJs7aWU7Fc/iKC1cqk9G01q9EGq4WIqITVWe5yuR
 eYlvllE/A2t+cBqo=
X-Received: by 2002:a05:620a:4548:b0:75b:23a1:8e3a with SMTP id
 u8-20020a05620a454800b0075b23a18e3amr22098181qkp.11.1689157449681; 
 Wed, 12 Jul 2023 03:24:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEfqOsduTbhdiSYs6Y5PlmTPSCDqhCfSDijs7C3XZvcuWANMc6PF+7tyGF9W8eaGON9HkUJ7A==
X-Received: by 2002:a05:620a:4548:b0:75b:23a1:8e3a with SMTP id
 u8-20020a05620a454800b0075b23a18e3amr22098161qkp.11.1689157449453; 
 Wed, 12 Jul 2023 03:24:09 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-6.retail.telecomitalia.it.
 [82.53.134.6]) by smtp.gmail.com with ESMTPSA id
 p13-20020ae9f30d000000b007675bef6b0dsm2012163qkg.118.2023.07.12.03.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 03:24:08 -0700 (PDT)
Date: Wed, 12 Jul 2023 12:24:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, 
 qemu-stable@nongnu.org, Mark Kanda <mark.kanda@oracle.com>, 
 Jason Wang <jasowang@redhat.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 virtualization@lists.linux-foundation.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Message-ID: <jkzogg62ewin2oa7px6gakhjwny3zyeftivoiaiavbbmwcgraz@5nnhucfswyn7>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
 <1406de7f-106f-9b88-1ce9-f0aa1c034561@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1406de7f-106f-9b88-1ce9-f0aa1c034561@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jul 12, 2023 at 10:35:48AM +0200, Paolo Bonzini wrote:
>On 7/11/23 19:06, Stefano Garzarella wrote:
>>CCing `./scripts/get_maintainer.pl -f drivers/scsi/virtio_scsi.c`,
>>since I found a few things in the virtio-scsi driver...
>>
>>FYI we have seen that Linux has problems with a QEMU patch for the
>>virtio-scsi device (details at the bottom of this email in the revert
>>commit message and BZ).
>>
>>
>>This is what I found when I looked at the Linux code:
>>
>>In scsi_report_sense() in linux/drivers/scsi/scsi_error.c linux calls
>>scsi_report_lun_change() that set `sdev_target->expecting_lun_change =
>>1` when we receive a UNIT ATTENTION with REPORT LUNS CHANGED
>>(sshdr->asc == 0x3f && sshdr->ascq == 0x0e).
>>
>>When `sdev_target->expecting_lun_change = 1` is set and we call
>>scsi_check_sense(), for example to check the next UNIT ATTENTION, it
>>will return NEEDS_RETRY, that I think will cause the issues we are
>>seeing.
>>
>>`sdev_target->expecting_lun_change` is reset only in
>>scsi_decide_disposition() when `REPORT_LUNS` command returns with
>>SAM_STAT_GOOD.
>>That command is issued in scsi_report_lun_scan() called by
>>__scsi_scan_target(), called for example by scsi_scan_target(),
>>scsi_scan_host(), etc.
>>
>>So, checking QEMU, we send VIRTIO_SCSI_EVT_RESET_RESCAN during hotplug
>>and VIRTIO_SCSI_EVT_RESET_REMOVED during hotunplug. In both cases now we
>>send also the UNIT ATTENTION.
>>
>>In the virtio-scsi driver, when we receive VIRTIO_SCSI_EVT_RESET_RESCAN
>>(hotplug) we call scsi_scan_target() or scsi_add_device(). Both of them
>>will call __scsi_scan_target() at some points, sending `REPORT_LUNS`
>>command to the device. This does not happen for
>>VIRTIO_SCSI_EVT_RESET_REMOVED (hotunplug). Indeed if I remove the
>>UNIT ATTENTION from the hotunplug in QEMU, everything works well.
>>
>>So, I tried to add a scan also for VIRTIO_SCSI_EVT_RESET_REMOVED:
>
>The point of having the event queue is to avoid expensive scans of the 
>entire host, so I don't think this is the right thing to do.

I see. I'll follow your advice for QEMU changes ;-)

>
>On the Linux side, one change we might do is to remove the printk for 

Do you mean the "LUN assignments on this target have changed.
The Linux SCSI layer does not automatically remap LUN assignments."?

>adapters that do process hotplug/hotunplug, using a new flag in 
>scsi_host_template.  There are several callers of scsi_add_device() and 
>scsi_remove_device() in adapter code, so at least these should not 
>issue the printk:

I guess it makes sense since that message could be confusing in this
case. I'll try to send a patch for that.

>
>drivers/scsi/aacraid/commsup.c
>drivers/scsi/arcmsr/arcmsr_hba.c
>drivers/scsi/esas2r/esas2r_main.c
>drivers/scsi/hpsa.c
>drivers/scsi/ipr.c
>drivers/scsi/megaraid/megaraid_sas_base.c
>drivers/scsi/mvumi.c
>drivers/scsi/pmcraid.c
>drivers/scsi/smartpqi/smartpqi_init.c
>drivers/scsi/virtio_scsi.c
>drivers/scsi/vmw_pvscsi.c
>drivers/scsi/xen-scsifront.c
>

Thanks,
Stefano


