Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D745F73F495
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 08:36:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE2IE-0002Hu-5m; Tue, 27 Jun 2023 02:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qE2IA-0002HM-Rf
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:35:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qE2I7-0005JB-BU
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z3aZI8JWkoVX0JKbqeBUpxxfu2rqy4cRj2KcbBsKdCY=; b=T9PWTfrbnaTZiADECO7+HiTfNu
 62s6Q5zpDtXpBM51navYc/1+BkwSmtKR6YUsLrSBS76UlvuF0NQSx/q4SfC8glFwBzKTkM1h6QE7P
 j0ovhzxUlpG6ClIo2s52HWhKwLblt8Es1bFhTu3+8cu8+tqFpLG9OXIuaESod3aNtT66CZhaZU6uR
 Yn9qFfjq3zK9pgafH6YMR9NeurNSL5KLVuc9mDxtCLn8vZychhfxUsbQEArsHwXVtiCV0NSneFrGl
 kBzv5FKm4zVGnjy9OnSLb9EOxzvpbuTTzd30GsCz+i9FPDIyF6skPORezeJ8uZNCB1ev9mgvdW5/i
 u2wISKPZrOyBezxxtwhbmDgh2lcWDXVUrmZUJKsyr0filr97WXZCBMbGtjQk8OCVPrKhQwg4XsYsx
 ny5jqfv9/ZVtBY1HPPhFKGzSIRXttf/EOywVeNgME6If3kpxbdsAxo/EG9jYpgiWgclr0L+c7JJv8
 Z5paNYUb6iM97QkEir6GrgmRUypLMD0K2aZUp9rd7rEXEvHrC1e7FC1p3daXc2ltcwoMSIXA+9CXk
 lEdVc3gEeu1c1dLIQz92wBX6kBQmzXbJYjj+F/rJRcDB8jIte4FgLdViP0XAerIDMqezCgmNO/mHE
 GfFOFZJ7AMbJwE7iDT7F0noJ0+mJ0D1qhfWew1CG0=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qE2Ho-0001xF-HE; Tue, 27 Jun 2023 07:34:52 +0100
Message-ID: <ac53e898-a50c-bbde-4232-541547d1ec82@ilande.co.uk>
Date: Tue, 27 Jun 2023 07:33:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Henrik Carlqvist <hc981@poolhem.se>, berrange@redhat.com,
 qemu-devel@nongnu.org
References: <20230328191958.3e3eb5e4.hc981@poolhem.se>
 <ZCMq/imcAq0ApLQp@redhat.com> <20230328221608.328ab80f.hc981@poolhem.se>
 <20230430225533.1a57879a.hc981@poolhem.se>
 <20230608181439.7ea3a5c5.hc981@poolhem.se>
 <4e8f027a-ca00-c54f-ef2f-f0df1f5b2f9e@ilande.co.uk>
 <20230610122912.0fc157de.hc981@poolhem.se>
 <20230611014751.22f22674.hc94@poolhem.se> <ZJFv4Hq8RMVOUum/@redhat.com>
 <20230620215043.6124c450.hc94@poolhem.se> <ZJKiGBJNQa5Kx+Dg@redhat.com>
 <20230621201447.712ec73a.hc94@poolhem.se>
 <20230623203007.56d3d182.hc981@poolhem.se>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230623203007.56d3d182.hc981@poolhem.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v8] Emulate dip switch language layout settings on SUN
 keyboard
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 23/06/2023 19:30, Henrik Carlqvist wrote:

> SUN Type 4, 5 and 5c keyboards have dip switches to choose the language layout
> of the keyboard. Solaris makes an ioctl to query the value of the dipswitches
> and uses that value to select keyboard layout.  Also the SUN bios like the one
> in the file ss5.bin uses this value to support at least some keyboard layouts.
> However, the OpenBIOS provided with qemu is hardcoded to always use an US
> keyboard layout.
> 
> Before this patch, qemu allways gave dip switch value 0x21 (US keyboard),
> this patch uses a command line switch like
> "-global escc.chnA-sunkbd-layout=de" to select dip switch value. A table is
> used to lookup values from arguments like:
> 
> -global escc.chnA-sunkbd-layout=fr
> -global escc.chnA-sunkbd-layout=es
> 
> But the patch also accepts numeric dip switch values directly:
> 
> -global escc.chnA-sunkbd-layout=0x2b
> -global escc.chnA-sunkbd-layout=43
> 
> Both values above are the same and select swedish keyboard as explained in
> table 3-15 at
> https://docs.oracle.com/cd/E19683-01/806-6642/new-43/index.html
> 
> Unless you want to do a full Solaris installation but happen to have
> access to a Sun bios file, the easiest way to test that the patch works
> is to:
> 
> qemu-system-sparc -global escc.chnA-sunkbd-layout=sv -bios /path/to/ss5.bin
> 
> If you already happen to have a Solaris installation in a qemu disk image
> file you can easily try different keyboard layouts after this patch is
> applied.
> 
> Signed-off-by: Henrik Carlqvist <hc1245@poolhem.se>
> ---
> 
> In this version 8 of my patch I have fixed and moved some .rst files as
> suggested.
> 
> Best regards Henrik
> 
>   docs/system/device-emulation.rst |   1 +
>   docs/system/devices/keyboard.rst | 129 +++++++++++++++++++++++++++++++
>   docs/system/target-sparc.rst     |   2 +-
>   hw/char/escc.c                   |  76 +++++++++++++++++-
>   include/hw/char/escc.h           |   1 +
>   5 files changed, 207 insertions(+), 2 deletions(-)
>   create mode 100644 docs/system/devices/keyboard.rst
> 
> diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
> index 8d4a1821fa..4491c4cbf7 100644
> --- a/docs/system/device-emulation.rst
> +++ b/docs/system/device-emulation.rst
> @@ -86,6 +86,7 @@ Emulated Devices
>      devices/ccid.rst
>      devices/cxl.rst
>      devices/ivshmem.rst
> +   devices/keyboard.rst
>      devices/net.rst
>      devices/nvme.rst
>      devices/usb.rst
> diff --git a/docs/system/devices/keyboard.rst b/docs/system/devices/keyboard.rst
> new file mode 100644
> index 0000000000..84ea660d50
> --- /dev/null
> +++ b/docs/system/devices/keyboard.rst
> @@ -0,0 +1,129 @@
> +.. _keyboard:
> +
> +Sparc32 keyboard
> +----------------
> +SUN Type 4, 5 and 5c keyboards have dip switches to choose the language layout
> +of the keyboard. Solaris makes an ioctl to query the value of the dipswitches
> +and uses that value to select keyboard layout. Also the SUN bios like the one
> +in the file ss5.bin uses this value to support at least some keyboard layouts.
> +However, the OpenBIOS provided with qemu is hardcoded to always use an
> +US keyboard layout.
> +
> +With the escc.chnA-sunkbd-layout driver property it is possible to select
> +keyboard layout. Example:
> +
> +-global escc.chnA-sunkbd-layout=de
> +
> +Depending on type of keyboard, the keyboard can have 6 or 5 dip-switches to
> +select keyboard layout, giving up to 64 different layouts. Not all
> +combinations are supported by Solaris and even less by Sun OpenBoot BIOS.
> +
> +The dip switch settings can be given as hexadecimal number, decimal number
> +or in some cases as a language string. Examples:
> +
> +-global escc.chnA-sunkbd-layout=0x2b
> +
> +-global escc.chnA-sunkbd-layout=43
> +
> +-global escc.chnA-sunkbd-layout=sv
> +
> +The above 3 examples all select a swedish keyboard layout. Table 3-15 at
> +https://docs.oracle.com/cd/E19683-01/806-6642/new-43/index.html explains which
> +keytable file is used for different dip switch settings. The information
> +in that table can be summarized in this table:
> +
> +.. list-table:: Language selection values for escc.chnA-sunkbd-layout
> +   :widths: 10 10 10
> +   :header-rows: 1
> +
> +   * - Hexadecimal value
> +     - Decimal value
> +     - Language code
> +   * - 0x21
> +     - 33
> +     - en-us
> +   * - 0x23
> +     - 35
> +     - fr
> +   * - 0x24
> +     - 36
> +     - da
> +   * - 0x25
> +     - 37
> +     - de
> +   * - 0x26
> +     - 38
> +     - it
> +   * - 0x27
> +     - 39
> +     - nl
> +   * - 0x28
> +     - 40
> +     - no
> +   * - 0x29
> +     - 41
> +     - pt
> +   * - 0x2a
> +     - 42
> +     - es
> +   * - 0x2b
> +     - 43
> +     - sv
> +   * - 0x2c
> +     - 44
> +     - fr-ch
> +   * - 0x2d
> +     - 45
> +     - de-ch
> +   * - 0x2e
> +     - 46
> +     - en-gb
> +   * - 0x2f
> +     - 47
> +     - ko
> +   * - 0x30
> +     - 48
> +     - tw
> +   * - 0x31
> +     - 49
> +     - ja
> +   * - 0x32
> +     - 50
> +     - fr-ca
> +   * - 0x33
> +     - 51
> +     - hu
> +   * - 0x34
> +     - 52
> +     - pl
> +   * - 0x35
> +     - 53
> +     - cz
> +   * - 0x36
> +     - 54
> +     - ru
> +   * - 0x37
> +     - 55
> +     - lv
> +   * - 0x38
> +     - 56
> +     - tr
> +   * - 0x39
> +     - 57
> +     - gr
> +   * - 0x3a
> +     - 58
> +     - ar
> +   * - 0x3b
> +     - 59
> +     - lt
> +   * - 0x3c
> +     - 60
> +     - nl-be
> +   * - 0x3c
> +     - 60
> +     - be
> +
> +Not all dip switch values have a corresponding language code and both "be" and
> +"nl-be" correspond to the same dip switch value. By default, if no value is
> +given to escc.chnA-sunkbd-layout 0x21 (en-us) will be used.
> diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
> index b55f8d09e9..9ec8c90c14 100644
> --- a/docs/system/target-sparc.rst
> +++ b/docs/system/target-sparc.rst
> @@ -38,7 +38,7 @@ QEMU emulates the following sun4m peripherals:
>   -  Non Volatile RAM M48T02/M48T08
>   
>   -  Slave I/O: timers, interrupt controllers, Zilog serial ports,
> -   keyboard and power/reset logic
> +   :ref:`keyboard` and power/reset logic
>   
>   -  ESP SCSI controller with hard disk and CD-ROM support
>   
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index 17a908c59b..463b3d2e93 100644
> --- a/hw/char/escc.c
> +++ b/hw/char/escc.c
> @@ -31,6 +31,8 @@
>   #include "qemu/module.h"
>   #include "hw/char/escc.h"
>   #include "ui/console.h"
> +
> +#include "qemu/cutils.h"
>   #include "trace.h"
>   
>   /*
> @@ -190,6 +192,7 @@
>   #define R_MISC1I 14
>   #define R_EXTINT 15
>   
> +static unsigned char sunkbd_layout_dip_switch(const char *sunkbd_layout);
>   static void handle_kbd_command(ESCCChannelState *s, int val);
>   static int serial_can_receive(void *opaque);
>   static void serial_receive_byte(ESCCChannelState *s, int ch);
> @@ -846,6 +849,75 @@ static QemuInputHandler sunkbd_handler = {
>       .event = sunkbd_handle_event,
>   };
>   
> +static unsigned char sunkbd_layout_dip_switch(const char *kbd_layout)
> +{
> +    /* Return the value of the dip-switches in a SUN Type 5 keyboard */
> +    static unsigned char ret = 0xff;
> +
> +    if ((ret == 0xff) && kbd_layout) {
> +        int i;
> +        struct layout_values {
> +            const char *lang;
> +            unsigned char dip;
> +        } languages[] =
> +    /* Dip values from table 3-16 Layouts for Type 4, 5, and 5c Keyboards */
> +            {
> +                {"en-us", 0x21}, /* U.S.A. (US5.kt) */
> +                                 /* 0x22 is some other US (US_UNIX5.kt)*/
> +                {"fr",    0x23}, /* France (France5.kt) */
> +                {"da",    0x24}, /* Denmark (Denmark5.kt) */
> +                {"de",    0x25}, /* Germany (Germany5.kt) */
> +                {"it",    0x26}, /* Italy (Italy5.kt) */
> +                {"nl",    0x27}, /* The Netherlands (Netherland5.kt) */
> +                {"no",    0x28}, /* Norway (Norway.kt) */
> +                {"pt",    0x29}, /* Portugal (Portugal5.kt) */
> +                {"es",    0x2a}, /* Spain (Spain5.kt) */
> +                {"sv",    0x2b}, /* Sweden (Sweden5.kt) */
> +                {"fr-ch", 0x2c}, /* Switzerland/French (Switzer_Fr5.kt) */
> +                {"de-ch", 0x2d}, /* Switzerland/German (Switzer_Ge5.kt) */
> +                {"en-gb", 0x2e}, /* Great Britain (UK5.kt) */
> +                {"ko",    0x2f}, /* Korea (Korea5.kt) */
> +                {"tw",    0x30}, /* Taiwan (Taiwan5.kt) */
> +                {"ja",    0x31}, /* Japan (Japan5.kt) */
> +                {"fr-ca", 0x32}, /* Canada/French (Canada_Fr5.kt) */
> +                {"hu",    0x33}, /* Hungary (Hungary5.kt) */
> +                {"pl",    0x34}, /* Poland (Poland5.kt) */
> +                {"cz",    0x35}, /* Czech (Czech5.kt) */
> +                {"ru",    0x36}, /* Russia (Russia5.kt) */
> +                {"lv",    0x37}, /* Latvia (Latvia5.kt) */
> +                {"tr",    0x38}, /* Turkey-Q5 (TurkeyQ5.kt) */
> +                {"gr",    0x39}, /* Greece (Greece5.kt) */
> +                {"ar",    0x3a}, /* Arabic (Arabic5.kt) */
> +                {"lt",    0x3b}, /* Lithuania (Lithuania5.kt) */
> +                {"nl-be", 0x3c}, /* Belgium (Belgian5.kt) */
> +                {"be",    0x3c}, /* Belgium (Belgian5.kt) */
> +            };
> +
> +        for (i = 0;
> +             i < sizeof(languages) / sizeof(struct layout_values);
> +             i++) {
> +            if (!strcmp(kbd_layout, languages[i].lang)) {
> +                ret = languages[i].dip;
> +                return ret;
> +            }
> +        }
> +        /* Found no known language code */
> +
> +        if ((kbd_layout[0] >= '0') && (kbd_layout[0] <= '9')) {
> +            unsigned int tmp;
> +            /* As a fallback we also accept numeric dip switch value */
> +            if (!qemu_strtoui(kbd_layout, NULL, 0, &tmp)) {
> +                ret = (unsigned char)tmp;
> +            }
> +        }
> +    }
> +    if (ret == 0xff) {
> +        /* Final fallback if keyboard_layout was not set or recognized */
> +        ret = 0x21; /* en-us layout */
> +    }
> +    return ret;
> +}
> +
>   static void handle_kbd_command(ESCCChannelState *s, int val)
>   {
>       trace_escc_kbd_command(val);
> @@ -867,7 +939,7 @@ static void handle_kbd_command(ESCCChannelState *s, int val)
>       case 0xf:
>           clear_queue(s);
>           put_queue(s, 0xfe);
> -        put_queue(s, 0x21); /*  en-us layout */
> +        put_queue(s, sunkbd_layout_dip_switch(s->sunkbd_layout));
>           break;
>       default:
>           break;
> @@ -976,6 +1048,8 @@ static Property escc_properties[] = {
>       DEFINE_PROP_UINT32("chnAtype",  ESCCState, chn[1].type, 0),
>       DEFINE_PROP_CHR("chrB", ESCCState, chn[0].chr),
>       DEFINE_PROP_CHR("chrA", ESCCState, chn[1].chr),
> +    DEFINE_PROP_STRING("chnA-sunkbd-layout", ESCCState,
> +		       chn[1].sunkbd_layout),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
> index 7e9482dee2..5669a5b811 100644
> --- a/include/hw/char/escc.h
> +++ b/include/hw/char/escc.h
> @@ -45,6 +45,7 @@ typedef struct ESCCChannelState {
>       ESCCChnType type;
>       uint8_t rx, tx;
>       QemuInputHandlerState *hs;
> +    char *sunkbd_layout;
>   } ESCCChannelState;
>   
>   struct ESCCState {

I think this is about ready to merge: the only thing I'd like to change is to swap 
unsigned char to uint8_t in the signature of sunkbd_layout_dip_switch(), but I can 
fix that up myself and queue it to my qemu-sparc branch.

Thanks for your patience with this patchset!


ATB,

Mark.


