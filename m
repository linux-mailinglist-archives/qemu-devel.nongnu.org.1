Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB43814868
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 13:50:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE7da-0007zG-4L; Fri, 15 Dec 2023 07:49:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rE7dX-0007yt-6L
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:49:51 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rE7dU-0007Xg-Vn
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 07:49:50 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 839CF75A4BF;
 Fri, 15 Dec 2023 13:49:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id hhKuVWJreWr1; Fri, 15 Dec 2023 13:49:43 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9C7EE75A4B9; Fri, 15 Dec 2023 13:49:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9AFDB75607B;
 Fri, 15 Dec 2023 13:49:43 +0100 (CET)
Date: Fri, 15 Dec 2023 13:49:43 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
cc: Dongwon Kim <dongwon.kim@intel.com>, qemu-devel@nongnu.org, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH 2/3] ui/gtk: unblock pipeline only if fence hasn't been
 signaled yet
In-Reply-To: <CAJ+F1C+GR7gEO2SktenXpRUHtFAvF-ZrW_QGe0-nSErZESbjtQ@mail.gmail.com>
Message-ID: <ca6d1673-979b-9a1b-c7cf-9d9a63ac88b1@eik.bme.hu>
References: <20231204184051.16873-1-dongwon.kim@intel.com>
 <20231213202419.15459-1-dongwon.kim@intel.com>
 <20231213202419.15459-2-dongwon.kim@intel.com>
 <CAJ+F1C+GR7gEO2SktenXpRUHtFAvF-ZrW_QGe0-nSErZESbjtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-449158374-1702644583=:20721"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-449158374-1702644583=:20721
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 15 Dec 2023, Marc-André Lureau wrote:
> Hi
>
> On Thu, Dec 14, 2023 at 8:26 AM Dongwon Kim <dongwon.kim@intel.com> wrote:
>>
>> It is needed to unblock the pipeline only if there is an active dmabuf
>> to be rendered and the fence for it is not yet signaled.
>>
>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
>> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>> ---
>>  ui/gtk.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/ui/gtk.c b/ui/gtk.c
>> index ea8d07833e..073c9eadb8 100644
>> --- a/ui/gtk.c
>> +++ b/ui/gtk.c
>> @@ -597,10 +597,16 @@ void gd_hw_gl_flushed(void *vcon)
>>      VirtualConsole *vc = vcon;
>>      QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
>>
>> -    qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
>> -    close(dmabuf->fence_fd);
>> -    dmabuf->fence_fd = -1;
>> -    graphic_hw_gl_block(vc->gfx.dcl.con, false);
>> +    if (!dmabuf) {
>> +        return;
>> +    }
>
> When is this function called with dmabuf == NULL or fence_fd < 0?
>
>> +
>> +    if (dmabuf->fence_fd > 0) {
>
> this should be >= 0

There's another in line 102 already and one in gtk-gl-area.c too.

Regards,
BALATON Zoltan

>> +        qemu_set_fd_handler(dmabuf->fence_fd, NULL, NULL, NULL);
>> +        close(dmabuf->fence_fd);
>> +        dmabuf->fence_fd = -1;
>> +        graphic_hw_gl_block(vc->gfx.dcl.con, false);
>> +    }
>>  }
>>
>>  /** DisplayState Callbacks (opengl version) **/
>> --
>> 2.34.1
>>
>>
>
>
>
--3866299591-449158374-1702644583=:20721--

