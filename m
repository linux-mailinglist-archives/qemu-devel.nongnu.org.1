Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6707501BA
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 10:37:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJVKI-0007gT-IM; Wed, 12 Jul 2023 04:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qJVKG-0007gB-IF
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qJVKE-00080f-Gx
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689150953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DRRA7uwSqVT0ybFJFNJzYJd//yk6hfID3A52J+ii9UA=;
 b=Wo9uX7vHH1BScK+NQUbA37S3IiBn9CZQqOdRzb4p7GW70GxQmWrBZJjuno6lJD/Pwls5r3
 s2NYrqhEo/XeMK8Urgs2yhqCZrACZtEOkyALmQQRkNbJph/fSF3yU9GBkYfb0Gk6lgPcz4
 FbWSTwefytMnTQIfVc3q60RsbOfT+I8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-LlGUNYbMPCOfyCkv1n3pSQ-1; Wed, 12 Jul 2023 04:35:52 -0400
X-MC-Unique: LlGUNYbMPCOfyCkv1n3pSQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-98843cc8980so436409766b.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 01:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689150951; x=1691742951;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DRRA7uwSqVT0ybFJFNJzYJd//yk6hfID3A52J+ii9UA=;
 b=FkvXhFI5nA5qjE8IKGjYyg3XQUueoNzuxHbXpqqBaSaUWHZnXZQN01bpO8hJYTFw3i
 TUnaaugIhjCD/w2zor+j1qX8UWJ3dhafIVkzbm7t9vKWunScN0Jh6jCVJBRIyt1bOQO4
 p2fXRDIlGVzDLVwP83gFO7dOpMpMvh7GRfafdIVyjbrqsYQ5teXGd/T1Kb0hL//p2vQ6
 GILt+xhod55JyvOeU9KKEovswQA17II4cUtwvZ+tt+2z9oG0+asOxBRqJvzaezA29dOM
 IjQlITUCYSYPbS2mDeH1qaWaY1AhmALE+vyIZW0LLPx+fFQ+txMIMk9JWbi40k2lUdnX
 tZMg==
X-Gm-Message-State: ABy/qLa7ZZvKz9vbE7x/HLAl+YFTXkFA6IUuxH6mnMkVNI0OknAXrlpG
 atZUwmKIfNiN42trEcq6OzL0vYyjhVcHuJHAIBASqh49ThAWVEQKd8Bnd01+tTZ8tGfeaYHyHKf
 V4oAUwC04dUu2o+M=
X-Received: by 2002:a17:906:944b:b0:992:462d:e2af with SMTP id
 z11-20020a170906944b00b00992462de2afmr18362710ejx.75.1689150951017; 
 Wed, 12 Jul 2023 01:35:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFxmOCKfcxU+sa40AB3CXOpJcXiX1gpM//Mk4EDLbxqoaBdaF2uMMjWzx0KoxEoR/On1S3Amw==
X-Received: by 2002:a17:906:944b:b0:992:462d:e2af with SMTP id
 z11-20020a170906944b00b00992462de2afmr18362696ejx.75.1689150950667; 
 Wed, 12 Jul 2023 01:35:50 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 la16-20020a170906ad9000b0098d2261d189sm2279004ejb.19.2023.07.12.01.35.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 01:35:49 -0700 (PDT)
Message-ID: <1406de7f-106f-9b88-1ce9-f0aa1c034561@redhat.com>
Date: Wed, 12 Jul 2023 10:35:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Content-Language: en-US
To: Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 qemu-stable@nongnu.org, Mark Kanda <mark.kanda@oracle.com>,
 Jason Wang <jasowang@redhat.com>, "James E.J. Bottomley"
 <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 virtualization@lists.linux-foundation.org, linux-scsi@vger.kernel.org
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/11/23 19:06, Stefano Garzarella wrote:
> CCing `./scripts/get_maintainer.pl -f drivers/scsi/virtio_scsi.c`,
> since I found a few things in the virtio-scsi driver...
> 
> FYI we have seen that Linux has problems with a QEMU patch for the
> virtio-scsi device (details at the bottom of this email in the revert
> commit message and BZ).
> 
> 
> This is what I found when I looked at the Linux code:
> 
> In scsi_report_sense() in linux/drivers/scsi/scsi_error.c linux calls
> scsi_report_lun_change() that set `sdev_target->expecting_lun_change =
> 1` when we receive a UNIT ATTENTION with REPORT LUNS CHANGED
> (sshdr->asc == 0x3f && sshdr->ascq == 0x0e).
> 
> When `sdev_target->expecting_lun_change = 1` is set and we call
> scsi_check_sense(), for example to check the next UNIT ATTENTION, it
> will return NEEDS_RETRY, that I think will cause the issues we are
> seeing.
> 
> `sdev_target->expecting_lun_change` is reset only in
> scsi_decide_disposition() when `REPORT_LUNS` command returns with
> SAM_STAT_GOOD.
> That command is issued in scsi_report_lun_scan() called by
> __scsi_scan_target(), called for example by scsi_scan_target(),
> scsi_scan_host(), etc.
> 
> So, checking QEMU, we send VIRTIO_SCSI_EVT_RESET_RESCAN during hotplug
> and VIRTIO_SCSI_EVT_RESET_REMOVED during hotunplug. In both cases now we
> send also the UNIT ATTENTION.
> 
> In the virtio-scsi driver, when we receive VIRTIO_SCSI_EVT_RESET_RESCAN
> (hotplug) we call scsi_scan_target() or scsi_add_device(). Both of them
> will call __scsi_scan_target() at some points, sending `REPORT_LUNS`
> command to the device. This does not happen for
> VIRTIO_SCSI_EVT_RESET_REMOVED (hotunplug). Indeed if I remove the
> UNIT ATTENTION from the hotunplug in QEMU, everything works well.
> 
> So, I tried to add a scan also for VIRTIO_SCSI_EVT_RESET_REMOVED:

The point of having the event queue is to avoid expensive scans of the 
entire host, so I don't think this is the right thing to do.

On the Linux side, one change we might do is to remove the printk for 
adapters that do process hotplug/hotunplug, using a new flag in 
scsi_host_template.  There are several callers of scsi_add_device() and 
scsi_remove_device() in adapter code, so at least these should not issue 
the printk:

drivers/scsi/aacraid/commsup.c
drivers/scsi/arcmsr/arcmsr_hba.c
drivers/scsi/esas2r/esas2r_main.c
drivers/scsi/hpsa.c
drivers/scsi/ipr.c
drivers/scsi/megaraid/megaraid_sas_base.c
drivers/scsi/mvumi.c
drivers/scsi/pmcraid.c
drivers/scsi/smartpqi/smartpqi_init.c
drivers/scsi/virtio_scsi.c
drivers/scsi/vmw_pvscsi.c
drivers/scsi/xen-scsifront.c

Paolo

> Another thing I noticed is that in QEMU maybe we should set the UNIT
> ATTENTION first and then send the event on the virtqueue, because the
> scan should happen after the unit attention, but I don't know if in any
> case the unit attention is processed before the virtqueue.
> 
> I mean something like this:
> 
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 45b95ea070..13db40f4f3 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -1079,8 +1079,8 @@ static void virtio_scsi_hotplug(HotplugHandler 
> *hotplug_dev, DeviceState *dev,
>           };
> 
>           virtio_scsi_acquire(s);
> -        virtio_scsi_push_event(s, &info);
>           scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
> +        virtio_scsi_push_event(s, &info);
>           virtio_scsi_release(s);
>       }
>   }
> @@ -1111,8 +1111,8 @@ static void virtio_scsi_hotunplug(HotplugHandler 
> *hotplug_dev, DeviceState *dev,
> 
>       if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
>           virtio_scsi_acquire(s);
> -        virtio_scsi_push_event(s, &info);
>           scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
> +        virtio_scsi_push_event(s, &info);
>           virtio_scsi_release(s);
>       }
>   }
> 
> At this point I think the problem is on the handling of the
> VIRTIO_SCSI_EVT_RESET_REMOVED event in the virtio-scsi driver, where
> somehow we have to redo the bus scan, but scsi_scan_host() doesn't seem
> to be enough when the event rate is very high.
> 
> I don't know if along with this fix, we also need to limit the rate in
> QEMU somehow.
> 
> Sorry for the length of this email, but I'm not familiar with SCSI and
> wanted some suggestions on how to proceed.
> 
> Paolo, Stefan, Linux SCSI maintainers, any suggestion?
> 
> 
> Thanks,
> Stefano
> 
> On Wed, Jul 05, 2023 at 09:15:23AM +0200, Stefano Garzarella wrote:
>> This reverts commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2.
>>
>> That commit causes several problems in Linux as described in the BZ.
>> In particular, after a while, other devices on the bus are no longer
>> usable even if those devices are not affected by the hotunplug.
>> This may be a problem in Linux, but we have not been able to identify
>> it so far. So better to revert this patch until we find a solution.
>>
>> Also, Oracle, which initially proposed this patch for a problem with
>> Solaris, seems to have already reversed it downstream:
>>    https://linux.oracle.com/errata/ELSA-2023-12065.html
>>
>> Suggested-by: Thomas Huth <thuth@redhat.com>
>> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2176702
>> Cc: qemu-stable@nongnu.org
>> Cc: Mark Kanda <mark.kanda@oracle.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> include/hw/scsi/scsi.h |  1 -
>> hw/scsi/scsi-bus.c     | 18 ------------------
>> hw/scsi/virtio-scsi.c  |  2 --
>> 3 files changed, 21 deletions(-)
>>
>> diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
>> index e2bb1a2fbf..7c8adf10b1 100644
>> --- a/include/hw/scsi/scsi.h
>> +++ b/include/hw/scsi/scsi.h
>> @@ -198,7 +198,6 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus 
>> *bus, BlockBackend *blk,
>>                                       BlockdevOnError rerror,
>>                                       BlockdevOnError werror,
>>                                       const char *serial, Error **errp);
>> -void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense);
>> void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
>>
>> SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
>> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
>> index f80f4cb4fc..42a915f8b7 100644
>> --- a/hw/scsi/scsi-bus.c
>> +++ b/hw/scsi/scsi-bus.c
>> @@ -1617,24 +1617,6 @@ static int scsi_ua_precedence(SCSISense sense)
>>     return (sense.asc << 8) | sense.ascq;
>> }
>>
>> -void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense)
>> -{
>> -    int prec1, prec2;
>> -    if (sense.key != UNIT_ATTENTION) {
>> -        return;
>> -    }
>> -
>> -    /*
>> -     * Override a pre-existing unit attention condition, except for a 
>> more
>> -     * important reset condition.
>> -     */
>> -    prec1 = scsi_ua_precedence(bus->unit_attention);
>> -    prec2 = scsi_ua_precedence(sense);
>> -    if (prec2 < prec1) {
>> -        bus->unit_attention = sense;
>> -    }
>> -}
>> -
>> void scsi_device_set_ua(SCSIDevice *sdev, SCSISense sense)
>> {
>>     int prec1, prec2;
>> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
>> index 45b95ea070..1f56607100 100644
>> --- a/hw/scsi/virtio-scsi.c
>> +++ b/hw/scsi/virtio-scsi.c
>> @@ -1080,7 +1080,6 @@ static void virtio_scsi_hotplug(HotplugHandler 
>> *hotplug_dev, DeviceState *dev,
>>
>>         virtio_scsi_acquire(s);
>>         virtio_scsi_push_event(s, &info);
>> -        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
>>         virtio_scsi_release(s);
>>     }
>> }
>> @@ -1112,7 +1111,6 @@ static void virtio_scsi_hotunplug(HotplugHandler 
>> *hotplug_dev, DeviceState *dev,
>>     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
>>         virtio_scsi_acquire(s);
>>         virtio_scsi_push_event(s, &info);
>> -        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
>>         virtio_scsi_release(s);
>>     }
>> }
>> -- 
>> 2.41.0
>>
> 
> 


