Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1B07B5568
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:44:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnK9W-0002Hq-Im; Mon, 02 Oct 2023 10:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnK9U-0002Hd-G5
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnK9L-0001Y5-9w
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696257834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RVdvkNinbmFNbw94PUE9Rx1K7Fa68LwHasYl0egXM3Q=;
 b=Z0Vhk1BAwRqqVUufEBRgzmJCkakXtm2xR8PrThjVkE4TPOwudEWPS1OLJP7W0riOLbCtdO
 8DhZdDP00FSjVAqXoa4pKcj3dEEObqSaMhIgPDoHz57sn2xEl+Pw5PoqXyC0zwSy7weZgC
 95mXwDu+hrF+nJTk9Oeb6bzKfx6aeo8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-FE3Bevx9N-m7bMW8IMlMAQ-1; Mon, 02 Oct 2023 10:43:51 -0400
X-MC-Unique: FE3Bevx9N-m7bMW8IMlMAQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 129B51C09A40;
 Mon,  2 Oct 2023 14:43:51 +0000 (UTC)
Received: from [10.39.194.43] (unknown [10.39.194.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30E8840C2064;
 Mon,  2 Oct 2023 14:43:50 +0000 (UTC)
Message-ID: <6fe74632-7f4e-1193-2f93-fdd2b250de21@redhat.com>
Date: Mon, 2 Oct 2023 16:43:49 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] hw/display/ramfb: plug slight guest-triggerable leak on
 mode setting
Content-Language: en-US
From: Laszlo Ersek <lersek@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-stable@nongnu.org
References: <20230919131955.27223-1-lersek@redhat.com>
 <7ee37181-526e-2b6a-6b42-09340a9e70a9@redhat.com>
 <CAJ+F1CK0FaMfm-ZUz7KB0erFRLBWTa7yHMxhiX0+J0ZxNp34bw@mail.gmail.com>
 <4da39e48-c916-ed62-70ae-f0306845f01b@redhat.com>
In-Reply-To: <4da39e48-c916-ed62-70ae-f0306845f01b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/1/23 00:14, Laszlo Ersek wrote:
> On 9/29/23 13:17, Marc-André Lureau wrote:
>> Hi
>>
>> On Wed, Sep 27, 2023 at 7:46 PM Laszlo Ersek <lersek@redhat.com> wrote:
>>>
>>> On 9/19/23 15:19, Laszlo Ersek wrote:
>>>> The fw_cfg DMA write callback in ramfb prepares a new display surface in
>>>> QEMU; this new surface is put to use ("swapped in") upon the next display
>>>> update. At that time, the old surface (if any) is released.
>>>>
>>>> If the guest triggers the fw_cfg DMA write callback at least twice between
>>>> two adjacent display updates, then the second callback (and further such
>>>> callbacks) will leak the previously prepared (but not yet swapped in)
>>>> display surface.
>>>>
>>>> The issue can be shown by:
>>>>
>>>> (1) starting QEMU with "-trace displaysurface_free", and
>>>>
>>>> (2) running the following program in the guest UEFI shell:
>>>>
>>>>> #include <Library/ShellCEntryLib.h>           // ShellAppMain()
>>>>> #include <Library/UefiBootServicesTableLib.h> // gBS
>>>>> #include <Protocol/GraphicsOutput.h>          // EFI_GRAPHICS_OUTPUT_PROTOCOL
>>>>>
>>>>> INTN
>>>>> EFIAPI
>>>>> ShellAppMain (
>>>>>   IN UINTN   Argc,
>>>>>   IN CHAR16  **Argv
>>>>>   )
>>>>> {
>>>>>   EFI_STATUS                    Status;
>>>>>   VOID                          *Interface;
>>>>>   EFI_GRAPHICS_OUTPUT_PROTOCOL  *Gop;
>>>>>   UINT32                        Mode;
>>>>>
>>>>>   Status = gBS->LocateProtocol (
>>>>>                   &gEfiGraphicsOutputProtocolGuid,
>>>>>                   NULL,
>>>>>                   &Interface
>>>>>                   );
>>>>>   if (EFI_ERROR (Status)) {
>>>>>     return 1;
>>>>>   }
>>>>>
>>>>>   Gop = Interface;
>>>>>
>>>>>   Mode = 1;
>>>>>   for ( ; ;) {
>>>>>     Status = Gop->SetMode (Gop, Mode);
>>>>>     if (EFI_ERROR (Status)) {
>>>>>       break;
>>>>>     }
>>>>>
>>>>>     Mode = 1 - Mode;
>>>>>   }
>>>>>
>>>>>   return 1;
>>>>> }
>>>>
>>>> The symptom is then that:
>>>>
>>>> - only one trace message appears periodically,
>>>>
>>>> - the time between adjacent messages keeps increasing -- implying that
>>>>   some list structure (containing the leaked resources) keeps growing,
>>>>
>>>> - the "surface" pointer is ever different.
>>>>
>>>>> 18566@1695127471.449586:displaysurface_free surface=0x7f2fcc09a7c0
>>>>> 18566@1695127471.529559:displaysurface_free surface=0x7f2fcc9dac10
>>>>> 18566@1695127471.659812:displaysurface_free surface=0x7f2fcc441dd0
>>>>> 18566@1695127471.839669:displaysurface_free surface=0x7f2fcc0363d0
>>>>> 18566@1695127472.069674:displaysurface_free surface=0x7f2fcc413a80
>>>>> 18566@1695127472.349580:displaysurface_free surface=0x7f2fcc09cd00
>>>>> 18566@1695127472.679783:displaysurface_free surface=0x7f2fcc1395f0
>>>>> 18566@1695127473.059848:displaysurface_free surface=0x7f2fcc1cae50
>>>>> 18566@1695127473.489724:displaysurface_free surface=0x7f2fcc42fc50
>>>>> 18566@1695127473.969791:displaysurface_free surface=0x7f2fcc45dcc0
>>>>> 18566@1695127474.499708:displaysurface_free surface=0x7f2fcc70b9d0
>>>>> 18566@1695127475.079769:displaysurface_free surface=0x7f2fcc82acc0
>>>>> 18566@1695127475.709941:displaysurface_free surface=0x7f2fcc369c00
>>>>> 18566@1695127476.389619:displaysurface_free surface=0x7f2fcc32b910
>>>>> 18566@1695127477.119772:displaysurface_free surface=0x7f2fcc0d5a20
>>>>> 18566@1695127477.899517:displaysurface_free surface=0x7f2fcc086c40
>>>>> 18566@1695127478.729962:displaysurface_free surface=0x7f2fccc72020
>>>>> 18566@1695127479.609839:displaysurface_free surface=0x7f2fcc185160
>>>>> 18566@1695127480.539688:displaysurface_free surface=0x7f2fcc23a7e0
>>>>> 18566@1695127481.519759:displaysurface_free surface=0x7f2fcc3ec870
>>>>> 18566@1695127482.549930:displaysurface_free surface=0x7f2fcc634960
>>>>> 18566@1695127483.629661:displaysurface_free surface=0x7f2fcc26b140
>>>>> 18566@1695127484.759987:displaysurface_free surface=0x7f2fcc321700
>>>>> 18566@1695127485.940289:displaysurface_free surface=0x7f2fccaad100
>>>>
>>>> We figured this wasn't a CVE-worthy problem, as only small amounts of
>>>> memory were leaked (the framebuffer itself is mapped from guest RAM, QEMU
>>>> only allocates administrative structures), plus libvirt restricts QEMU
>>>> memory footprint anyway, thus the guest can only DoS itself.
>>>>
>>>> Plug the leak, by releasing the last prepared (not yet swapped in) display
>>>> surface, if any, in the fw_cfg DMA write callback.
>>>>
>>>> Regarding the "reproducer", with the fix in place, the log is flooded with
>>>> trace messages (one per fw_cfg write), *and* the trace message alternates
>>>> between just two "surface" pointer values (i.e., nothing is leaked, the
>>>> allocator flip-flops between two objects in effect).
>>>>
>>>> This issue appears to date back to the introducion of ramfb (995b30179bdc,
>>>> "hw/display: add ramfb, a simple boot framebuffer living in guest ram",
>>>> 2018-06-18).
>>>>
>>>> Cc: Gerd Hoffmann <kraxel@redhat.com> (maintainer:ramfb)
>>>> Cc: qemu-stable@nongnu.org
>>>> Fixes: 995b30179bdc
>>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>>> ---
>>>>  hw/display/ramfb.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
>>>> index 79b9754a5820..c2b002d53480 100644
>>>> --- a/hw/display/ramfb.c
>>>> +++ b/hw/display/ramfb.c
>>>> @@ -97,6 +97,7 @@ static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
>>>>
>>>>      s->width = width;
>>>>      s->height = height;
>>>> +    qemu_free_displaysurface(s->ds);
>>>>      s->ds = surface;
>>>>  }
>>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Incidentally I found the same issue:
>> https://patchew.org/QEMU/20230920082634.3349487-1-marcandre.lureau@redhat.com/
> 
> Which patch is better?
> 
> I certainly didn't think of g_clear_pointer(); is that more idiomatic?

FWIW, I'm happy to use g_clear_pointer() if that's deemed more
idiomatic, but I'd appreciate if my *commit message* (with the UEFI
reproducer) could land in the git history :)

Laszlo

> 
>>
>>
>> fwiw, my migration support patch is still unreviewed:
>> https://patchew.org/QEMU/20230920082651.3349712-1-marcandre.lureau@redhat.com/
>>
> 
> I don't have a copy of that patch (not subscribed, sorry...), but how
> simply you did it surprises me. I did expect to simulate an fw_cfg write
> in post_load, but I thought we'd approach the device (for the sake of
> including it in the migration stream) from the higher level device's
> vmstate descriptors (dc->vmsd) that set up / depend on ramfb in the
> first place. I didn't know that raw vmstate_register() was still accepted.
> 
> If it is, then, for that patch (with Gerd's comment addressed):
> 
> Acked-by: Laszlo Ersek <lersek@redhat.com>
> 
> BTW: can you please assign
> <https://bugzilla.redhat.com/show_bug.cgi?id=1859424> to yourself and
> link your patch into it? The reason we ended up duplicating work here is
> that noone took RHBZ 1859424 before.
> 
> ... Well, the ticket is RHEL-7478 in JIRA now, in fact. :/
> 
> Thanks!
> Laszlo


