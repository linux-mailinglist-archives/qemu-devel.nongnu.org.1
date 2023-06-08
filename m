Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11015727832
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 09:08:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q79kT-0006W8-CK; Thu, 08 Jun 2023 03:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1q79kR-0006Vq-Oe
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 03:07:55 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1q79kP-00041s-J6
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 03:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686208073; x=1717744073;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=71e8FaxcO+9QEZHSgOZ+L4HTMENZXIhBjCFzq6J2Gus=;
 b=Ag0Oz7wvU+FIm7I8VswiSTJpuc9CQnH11R/JZIDp8cKjaeE4jYwZJupi
 dTGjJc2OlkWLx2LyrOJIrh53FcsF4ijYRqEgRM1rwGPEZ6E9X93Ugyrna
 79E+UqBtYNZJymOYw0E6t7NynBrTxRIwPZSQM+ra4QMC8t7YrFDwVJGm7
 LK90VY3jylNhhScDsuoYykfr67nOfXW2cDRZ3Pd/hrvhRIJ9lh4QS2aPD
 55DIMOCBog2XuW1wL4Wd6HV9r483v40tAlteWE6PU5ODdEuxdhu1NHw0+
 ro9cM99Up4lNZZIIq0TVVq9g11lvUaRAVoKQfnnnv/KiJO/T7lwlczdAh w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="443597089"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; d="scan'208";a="443597089"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 00:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="687283747"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; d="scan'208";a="687283747"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.254.213.116])
 ([10.254.213.116])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 00:07:48 -0700
Message-ID: <65fd10d6-2ede-3e91-4356-36623b53db5a@intel.com>
Date: Thu, 8 Jun 2023 15:07:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH] vdpa: dont check vhost_vdpa->suspended when unsupported
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
References: <20230607170842.488489-1-lingshan.zhu@intel.com>
 <CAJaqyWdQRDb=cev7LUXKiK9-gBhB2CY7fmcT-M+pdjgb29qDcw@mail.gmail.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CAJaqyWdQRDb=cev7LUXKiK9-gBhB2CY7fmcT-M+pdjgb29qDcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.43; envelope-from=lingshan.zhu@intel.com;
 helo=mga05.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/7/2023 9:51 PM, Eugenio Perez Martin wrote:
> On Wed, Jun 7, 2023 at 11:09 AM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>> When read the state of a virtqueue, vhost_vdpa need
>> to check whether the device is suspended.
>>
>> This commit verifies whether VHOST_BACKEND_F_SUSPEND is
>> negotiated when checking vhost_vdpa->suspended.
>>
> I'll add: Otherwise, qemu prints XXX error message.
>
> On second thought, not returning an error prevents the caller
> (vhost.c:vhost_virtqueue_stop) from recovering used idx from the
> guest.
>
> I'm not sure about the right fix for this, should we call
> virtio_queue_restore_last_avail_idx here? Communicate that the backend
> cannot suspend so vhost.c can print a better error message?
I agree it is better not to return an error.

Instead if neither the device does not support _F_SUSPEND nor failed to 
suspend,
I think vhost_vdpa should try to read the last_avail_idx from
the device anyway. We can print an error message here,
like: failed to suspend, the value may not reliable.

Thanks
>
> Thanks!
>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>>   hw/virtio/vhost-vdpa.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index b3094e8a8b..ae176c06dd 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -1397,7 +1397,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
>>           return 0;
>>       }
>>
>> -    if (!v->suspended) {
>> +    if ((dev->backend_cap & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) && (!v->suspended)) {
>>           /*
>>            * Cannot trust in value returned by device, let vhost recover used
>>            * idx from guest.
>> --
>> 2.39.1
>>


