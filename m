Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2AA7E6C19
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:08:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15dc-0007ZG-GJ; Thu, 09 Nov 2023 09:04:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15bS-0000Km-Iy; Thu, 09 Nov 2023 09:01:52 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15bP-0006Q6-0u; Thu, 09 Nov 2023 09:01:49 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3593931BD1;
 Thu,  9 Nov 2023 16:59:56 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3D2DE3450A;
 Thu,  9 Nov 2023 16:59:48 +0300 (MSK)
Received: (nullmailer pid 1462859 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 27/62] hw/display/ramfb: plug slight guest-triggerable
 leak on mode setting
Date: Thu,  9 Nov 2023 16:58:55 +0300
Message-Id: <20231109135933.1462615-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Laszlo Ersek <lersek@redhat.com>

The fw_cfg DMA write callback in ramfb prepares a new display surface in
QEMU; this new surface is put to use ("swapped in") upon the next display
update. At that time, the old surface (if any) is released.

If the guest triggers the fw_cfg DMA write callback at least twice between
two adjacent display updates, then the second callback (and further such
callbacks) will leak the previously prepared (but not yet swapped in)
display surface.

The issue can be shown by:

(1) starting QEMU with "-trace displaysurface_free", and

(2) running the following program in the guest UEFI shell:

> #include <Library/ShellCEntryLib.h>           // ShellAppMain()
> #include <Library/UefiBootServicesTableLib.h> // gBS
> #include <Protocol/GraphicsOutput.h>          // EFI_GRAPHICS_OUTPUT_PROTOCOL
>
> INTN
> EFIAPI
> ShellAppMain (
>   IN UINTN   Argc,
>   IN CHAR16  **Argv
>   )
> {
>   EFI_STATUS                    Status;
>   VOID                          *Interface;
>   EFI_GRAPHICS_OUTPUT_PROTOCOL  *Gop;
>   UINT32                        Mode;
>
>   Status = gBS->LocateProtocol (
>                   &gEfiGraphicsOutputProtocolGuid,
>                   NULL,
>                   &Interface
>                   );
>   if (EFI_ERROR (Status)) {
>     return 1;
>   }
>
>   Gop = Interface;
>
>   Mode = 1;
>   for ( ; ;) {
>     Status = Gop->SetMode (Gop, Mode);
>     if (EFI_ERROR (Status)) {
>       break;
>     }
>
>     Mode = 1 - Mode;
>   }
>
>   return 1;
> }

The symptom is then that:

- only one trace message appears periodically,

- the time between adjacent messages keeps increasing -- implying that
  some list structure (containing the leaked resources) keeps growing,

- the "surface" pointer is ever different.

> 18566@1695127471.449586:displaysurface_free surface=0x7f2fcc09a7c0
> 18566@1695127471.529559:displaysurface_free surface=0x7f2fcc9dac10
> 18566@1695127471.659812:displaysurface_free surface=0x7f2fcc441dd0
> 18566@1695127471.839669:displaysurface_free surface=0x7f2fcc0363d0
> 18566@1695127472.069674:displaysurface_free surface=0x7f2fcc413a80
> 18566@1695127472.349580:displaysurface_free surface=0x7f2fcc09cd00
> 18566@1695127472.679783:displaysurface_free surface=0x7f2fcc1395f0
> 18566@1695127473.059848:displaysurface_free surface=0x7f2fcc1cae50
> 18566@1695127473.489724:displaysurface_free surface=0x7f2fcc42fc50
> 18566@1695127473.969791:displaysurface_free surface=0x7f2fcc45dcc0
> 18566@1695127474.499708:displaysurface_free surface=0x7f2fcc70b9d0
> 18566@1695127475.079769:displaysurface_free surface=0x7f2fcc82acc0
> 18566@1695127475.709941:displaysurface_free surface=0x7f2fcc369c00
> 18566@1695127476.389619:displaysurface_free surface=0x7f2fcc32b910
> 18566@1695127477.119772:displaysurface_free surface=0x7f2fcc0d5a20
> 18566@1695127477.899517:displaysurface_free surface=0x7f2fcc086c40
> 18566@1695127478.729962:displaysurface_free surface=0x7f2fccc72020
> 18566@1695127479.609839:displaysurface_free surface=0x7f2fcc185160
> 18566@1695127480.539688:displaysurface_free surface=0x7f2fcc23a7e0
> 18566@1695127481.519759:displaysurface_free surface=0x7f2fcc3ec870
> 18566@1695127482.549930:displaysurface_free surface=0x7f2fcc634960
> 18566@1695127483.629661:displaysurface_free surface=0x7f2fcc26b140
> 18566@1695127484.759987:displaysurface_free surface=0x7f2fcc321700
> 18566@1695127485.940289:displaysurface_free surface=0x7f2fccaad100

We figured this wasn't a CVE-worthy problem, as only small amounts of
memory were leaked (the framebuffer itself is mapped from guest RAM, QEMU
only allocates administrative structures), plus libvirt restricts QEMU
memory footprint anyway, thus the guest can only DoS itself.

Plug the leak, by releasing the last prepared (not yet swapped in) display
surface, if any, in the fw_cfg DMA write callback.

Regarding the "reproducer", with the fix in place, the log is flooded with
trace messages (one per fw_cfg write), *and* the trace message alternates
between just two "surface" pointer values (i.e., nothing is leaked, the
allocator flip-flops between two objects in effect).

This issue appears to date back to the introducion of ramfb (995b30179bdc,
"hw/display: add ramfb, a simple boot framebuffer living in guest ram",
2018-06-18).

Cc: Gerd Hoffmann <kraxel@redhat.com> (maintainer:ramfb)
Cc: qemu-stable@nongnu.org
Fixes: 995b30179bdc
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230919131955.27223-1-lersek@redhat.com>
(cherry picked from commit e0288a778473ebd35eac6cc1924faca7d477d241)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 79b9754a58..c2b002d534 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -97,6 +97,7 @@ static void ramfb_fw_cfg_write(void *dev, off_t offset, size_t len)
 
     s->width = width;
     s->height = height;
+    qemu_free_displaysurface(s->ds);
     s->ds = surface;
 }
 
-- 
2.39.2


