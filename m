Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EB37B54DD
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:22:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnJnG-0006cu-7j; Mon, 02 Oct 2023 10:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnJn8-0006c7-LU
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:20:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnJn5-0006DU-6L
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696256454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1rmVTAflamOBqxoZCIJBA3L/LiK4/fxU6CyaKjQgWBs=;
 b=gtHZO3OY/IWo0yMTir1NGy1tVkrAdndULCx6PliFKcZ5ZHqRQYqZpB+3Mv9I/yxJGl4gL8
 nyPvp3BzGLcZ0hMT//W9VS6j6Z4mcIg4Wnq3xmIFmPAxyE8LkBOPt9tHW1uLICWAjg1+yR
 NjTsJDKmXeArGnxwdG0BuhSkROg1lO4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-4OcGht46NiOFE8i_nzADRA-1; Mon, 02 Oct 2023 10:20:50 -0400
X-MC-Unique: 4OcGht46NiOFE8i_nzADRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4957085A5A8;
 Mon,  2 Oct 2023 14:20:50 +0000 (UTC)
Received: from [10.39.194.43] (unknown [10.39.194.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE9662156701;
 Mon,  2 Oct 2023 14:20:49 +0000 (UTC)
Message-ID: <a79e8798-f7e7-4af4-16d1-8cf468822a2a@redhat.com>
Date: Mon, 2 Oct 2023 16:20:48 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/5] ramfb: implement migration support
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org
Cc: kraxel@redhat.com
References: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
 <20231002111154.1002655-4-marcandre.lureau@redhat.com>
 <CAJ+F1CKzPOAPGc+cp=ytqARUWPq2bhi3vWE_b3MiZXebVTwJxg@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <CAJ+F1CKzPOAPGc+cp=ytqARUWPq2bhi3vWE_b3MiZXebVTwJxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lersek@redhat.com;
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

On 10/2/23 14:01, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Oct 2, 2023 at 3:12 PM <marcandre.lureau@redhat.com> wrote:
>>
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Implementing RAMFB migration is quite straightforward. One caveat is to
>> treat the whole RAMFBCfg as a blob, since that's what is exposed to the
>> guest directly. This avoid having to fiddle with endianness issues if we
>> were to migrate fields individually as integers.
>>
>> The following patches turns the migration only on machine >= 8.2.
>>
>> Fixes:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1859424
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>  hw/display/ramfb.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
>> index 79b9754a58..4aaaa7d653 100644
>> --- a/hw/display/ramfb.c
>> +++ b/hw/display/ramfb.c
>> @@ -12,6 +12,7 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "migration/vmstate.h"
>>  #include "qapi/error.h"
>>  #include "hw/loader.h"
>>  #include "hw/display/ramfb.h"
>> @@ -28,6 +29,8 @@ struct QEMU_PACKED RAMFBCfg {
>>      uint32_t stride;
>>  };
>>
>> +typedef struct RAMFBCfg RAMFBCfg;
>> +
>>  struct RAMFBState {
>>      DisplaySurface *ds;
>>      uint32_t width, height;
>> @@ -115,6 +118,23 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
>>      dpy_gfx_update_full(con);
>>  }
>>
>> +static int ramfb_post_load(void *opaque, int version_id)
>> +{
>> +    ramfb_fw_cfg_write(opaque, 0, 0);
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_ramfb = {
>> +    .name = "ramfb",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .post_load = ramfb_post_load,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_BUFFER_UNSAFE(cfg, RAMFBState, 0, sizeof(RAMFBCfg)),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>  RAMFBState *ramfb_setup(Error **errp)
>>  {
>>      FWCfgState *fw_cfg = fw_cfg_find();
>> @@ -127,6 +147,7 @@ RAMFBState *ramfb_setup(Error **errp)
>>
>>      s = g_new0(RAMFBState, 1);
>>
>> +    vmstate_register(NULL, 0, &vmstate_ramfb, s);
> 
> wip:
> I am going to make it attached to the actual device.

I'm really curious about that -- I think it's going to be better, and
it'll teach me stuff about migration!

Laszlo


