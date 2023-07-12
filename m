Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1437875017E
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 10:29:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJVCr-00037I-Ut; Wed, 12 Jul 2023 04:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJVCl-00034o-UR
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:28:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJVCk-0005sr-1U
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689150488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ft77lorj+s2P25VAIDS7kNl8SOhboxm+h8Bgo4H0PZo=;
 b=Pf34cqWXaDsHPzQ6ljhVlphEdcnt68AFclWH+VrBAvtW8NMNk6RdMSm6WzDfQBoLiusICE
 WIKAWaKIYJrjqicMQB3rWi7yXSQ0JMyBKwRwFLMQJm3Xkd7jIv4ecZxaXRH7tMKfvVoQpJ
 +K7CeUvzQVDCrn2uq3RMDhtQUgHX3Cg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-K0p6cNZOMvKI2BdvPvVEgg-1; Wed, 12 Jul 2023 04:28:07 -0400
X-MC-Unique: K0p6cNZOMvKI2BdvPvVEgg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-765de3a3404so886691785a.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 01:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689150487; x=1691742487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ft77lorj+s2P25VAIDS7kNl8SOhboxm+h8Bgo4H0PZo=;
 b=JR5iWOxpxcicUfGNe5Pk7e2+cINwZi03MfwcMRAbjmTzRmKjYAt7P7/rlviEdAMQhB
 e+zCCEuHctjWHzQkBl2ejTBmVlWvqculX4TODULqYRRhkT2G3cqewMlQjhMTsm0/KTCY
 ylATqgR7v+O6Co64dN5L9yofwXRX5tzrsbNHwC9Nsb68Gv4Ex4cyWuWxCTtIWhLvxRFo
 /utLqujLZuVBTlQs9fumawfIy5hQltSfhucF6V6iAa9/NAFRwCEgKZVSTWcjL2vzFOZ9
 +Lr4t8p1zkKhN0u3KkUWOhVPGk9Dsh3YIBLECMAEuzDevo+93Yjm+c6yJrhrVr92d+Fn
 3osA==
X-Gm-Message-State: ABy/qLbG5mDwUAGUdcffO0aYRWBF7jCKqb1PeiebWF2AR6asghr8XbLZ
 MTlOxBTYbWdPHK+wNF7fmEpD9wi9x6V5+7QBwkbPiTF9irosaiVzq5hhQGaxB4NI5KqgCyD5ePI
 1qDm+om5jQQYiAU8=
X-Received: by 2002:a37:2c81:0:b0:767:29c9:c647 with SMTP id
 s123-20020a372c81000000b0076729c9c647mr15297895qkh.28.1689150487016; 
 Wed, 12 Jul 2023 01:28:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHCMxGd3FqAHhYi1J0QB6yKcMGoqDkeMZFSBQlJdK2/+s7Yle4fe+XU3U2z7dv77pMeVxMJ6g==
X-Received: by 2002:a37:2c81:0:b0:767:29c9:c647 with SMTP id
 s123-20020a372c81000000b0076729c9c647mr15297866qkh.28.1689150486449; 
 Wed, 12 Jul 2023 01:28:06 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-6.retail.telecomitalia.it.
 [82.53.134.6]) by smtp.gmail.com with ESMTPSA id
 x21-20020a05620a01f500b007678ee16016sm1975987qkn.45.2023.07.12.01.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 01:28:04 -0700 (PDT)
Date: Wed, 12 Jul 2023 10:28:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>, 
 Mark Kanda <mark.kanda@oracle.com>, linux-scsi@vger.kernel.org, 
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, 
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Message-ID: <v6xzholcgdem3c2jkkuhqtmhzo4wflvkh53nohcgtjpgkh5y2e@bb7vliper2f3>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
 <CAJSP0QX5bf1Gp6mnQ0620FS61n=cY6n_ca7O-cAcH7pYCV2frw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJSP0QX5bf1Gp6mnQ0620FS61n=cY6n_ca7O-cAcH7pYCV2frw@mail.gmail.com>
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

On Tue, Jul 11, 2023 at 01:41:31PM -0400, Stefan Hajnoczi wrote:
>On Tue, 11 Jul 2023 at 13:06, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> CCing `./scripts/get_maintainer.pl -f drivers/scsi/virtio_scsi.c`,
>> since I found a few things in the virtio-scsi driver...
>>
>> FYI we have seen that Linux has problems with a QEMU patch for the
>> virtio-scsi device (details at the bottom of this email in the revert
>> commit message and BZ).
>>
>>
>> This is what I found when I looked at the Linux code:
>>
>> In scsi_report_sense() in linux/drivers/scsi/scsi_error.c linux calls
>> scsi_report_lun_change() that set `sdev_target->expecting_lun_change =
>> 1` when we receive a UNIT ATTENTION with REPORT LUNS CHANGED
>> (sshdr->asc == 0x3f && sshdr->ascq == 0x0e).
>>
>> When `sdev_target->expecting_lun_change = 1` is set and we call
>> scsi_check_sense(), for example to check the next UNIT ATTENTION, it
>> will return NEEDS_RETRY, that I think will cause the issues we are
>> seeing.
>>
>> `sdev_target->expecting_lun_change` is reset only in
>> scsi_decide_disposition() when `REPORT_LUNS` command returns with
>> SAM_STAT_GOOD.
>> That command is issued in scsi_report_lun_scan() called by
>> __scsi_scan_target(), called for example by scsi_scan_target(),
>> scsi_scan_host(), etc.
>>
>> So, checking QEMU, we send VIRTIO_SCSI_EVT_RESET_RESCAN during hotplug
>> and VIRTIO_SCSI_EVT_RESET_REMOVED during hotunplug. In both cases now we
>> send also the UNIT ATTENTION.
>>
>> In the virtio-scsi driver, when we receive VIRTIO_SCSI_EVT_RESET_RESCAN
>> (hotplug) we call scsi_scan_target() or scsi_add_device(). Both of them
>> will call __scsi_scan_target() at some points, sending `REPORT_LUNS`
>> command to the device. This does not happen for
>> VIRTIO_SCSI_EVT_RESET_REMOVED (hotunplug). Indeed if I remove the
>> UNIT ATTENTION from the hotunplug in QEMU, everything works well.
>>
>> So, I tried to add a scan also for VIRTIO_SCSI_EVT_RESET_REMOVED:
>>
>> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
>> index bd5633667d01..c57658a63097 100644
>> --- a/drivers/scsi/virtio_scsi.c
>> +++ b/drivers/scsi/virtio_scsi.c
>> @@ -291,6 +291,7 @@ static void virtscsi_handle_transport_reset(struct virtio_scsi *vscsi,
>>                  }
>>                  break;
>>          case VIRTIO_SCSI_EVT_RESET_REMOVED:
>> +               scsi_scan_host(shost);
>>                  sdev = scsi_device_lookup(shost, 0, target, lun);
>>                  if (sdev) {
>>                          scsi_remove_device(sdev);
>>
>> This somehow helps, now linux only breaks if the plug/unplug frequency
>> is really high. If I put a 5 second sleep between plug/unplug events, it
>> doesn't break (at least for the duration of my test which has been
>> running for about 30 minutes, before it used to break after about a
>> minute).
>>
>> Another thing I noticed is that in QEMU maybe we should set the UNIT
>> ATTENTION first and then send the event on the virtqueue, because the
>> scan should happen after the unit attention, but I don't know if in any
>> case the unit attention is processed before the virtqueue.
>>
>> I mean something like this:
>>
>> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
>> index 45b95ea070..13db40f4f3 100644
>> --- a/hw/scsi/virtio-scsi.c
>> +++ b/hw/scsi/virtio-scsi.c
>> @@ -1079,8 +1079,8 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>           };
>>
>>           virtio_scsi_acquire(s);
>> -        virtio_scsi_push_event(s, &info);
>>           scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
>> +        virtio_scsi_push_event(s, &info);
>>           virtio_scsi_release(s);
>>       }
>>   }
>> @@ -1111,8 +1111,8 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>
>>       if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
>>           virtio_scsi_acquire(s);
>> -        virtio_scsi_push_event(s, &info);
>>           scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
>> +        virtio_scsi_push_event(s, &info);
>>           virtio_scsi_release(s);
>>       }
>>   }
>
>That is racy. It's up to the guest whether the event virtqueue or the
>UNIT ATTENTION will be processed first.

Yep, agree. I wrote above that UA could be processed in a different
order. It was just another potential problem.

>
>If the device wants to ensure ordering then it must withhold the event
>until the driver has responded to the UNIT ATTENTION. That may not be
>a good idea though.
>
>I'd like to understand the root cause before choosing a solution.

This last patch is not the solution.

I think the root cause is in the Linux driver and SCSI subsystem.
When the SCSI code receive an UA with REPORTED LUN CHANGED, it seems
it expects that `REPORT_LUNS` command is issued (I tried to describe it
in the first part).

The problem is that the SCSI stack does not send this command, so we
should do it in the driver. In fact we do it for
VIRTIO_SCSI_EVT_RESET_RESCAN (hotplug), but not for
VIRTIO_SCSI_EVT_RESET_REMOVED (hotunplug).

I think that's where the problem is, but I don't know if that's what the
specification expects, I haven't found much information on that :-(

>
>> At this point I think the problem is on the handling of the
>> VIRTIO_SCSI_EVT_RESET_REMOVED event in the virtio-scsi driver, where
>> somehow we have to redo the bus scan, but scsi_scan_host() doesn't seem
>> to be enough when the event rate is very high.
>
>Why is it necessary to rescan the whole bus instead of removing just
>the device that has been unplugged?

I hope I covered in the previous answer.

>
>> I don't know if along with this fix, we also need to limit the rate in
>> QEMU somehow.
>
>Why is a high rate problematic?

Could be related on the race that you mention before (also without that
untested diff there should be the race)

>
>> Sorry for the length of this email, but I'm not familiar with SCSI and
>> wanted some suggestions on how to proceed.
>>
>> Paolo, Stefan, Linux SCSI maintainers, any suggestion?
>
>I don't know the Linux SCSI code well enough to say, sorry. I think we
>need input from someone familiar with the code.

Thank you very much for the suggestions!
I will try to ping the SCSI maintainers.

>
>However, QEMU is not at liberty to make changes that break existing
>guests. So even if it turns out the specs allow something or there is
>an existing bug in virtio_scsi.ko, we still can't break existing
>guests.

Yes, I can see that. We need to revert or somehow fix the device in
QEMU.

Thanks,
Stefano


