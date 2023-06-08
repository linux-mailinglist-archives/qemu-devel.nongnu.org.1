Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EAA7284B2
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 18:16:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7IHv-00086D-51; Thu, 08 Jun 2023 12:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc981@poolhem.se>) id 1q7IHs-000853-Gc
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:15:00 -0400
Received: from mailout12.inleed.net ([2a0b:dc80:cafe:112::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc981@poolhem.se>) id 1q7IHl-0003mI-0A
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=poolhem.se; 
 s=x;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+wKvBz2NoOpCOzLmBcr0WXyNP2UtNswRI8WVcud5BHE=; b=AHu0cQETM2uBM2am9qT4VKzfXO
 Y9wv0Zw144ZgSlir59K/2IsAGGoRSls9WpL7+UBCYgGLgrr6T39jT8dXgAFZc9CA4UlLGjfbfGkcA
 7tkr2gpAOUcXOQkpug+vzDaf/RSvsFHOjGBCBGNQjvm3aMTZS7gdRcVCXrfHcndioU0R00wxw7S7Z
 t8Y5F3Y8emvK4QOgD5oeprHsrbZfwBE+O6kJ5RMULSUQ4jDJFMrzyTVgG9pGGPdJah2GUtwcgBOPR
 GaeTAz8gb/2OCT9PlW0e82cNsjmHM4lYoq7s9AUKhVpLTGjOpnYMTTOBbMIYM4oK5ehgkjqHEA1Uk
 tsoIYy1w==;
Received: from [213.115.245.47] (helo=balrog.lkp.se)
 by ns12.inleed.net with esmtpa (Exim 4.96-58-g4e9ed49f8)
 (envelope-from <hc981@poolhem.se>) id 1q7IHj-002TDC-2a;
 Thu, 08 Jun 2023 18:14:51 +0200
Date: Thu, 8 Jun 2023 18:14:39 +0200
From: Henrik Carlqvist <hc981@poolhem.se>
To: Henrik Carlqvist <hc981@poolhem.se>
Cc: berrange@redhat.com, mark.cave-ayland@ilande.co.uk, hc1245@poolhem.se,
 qemu-devel@nongnu.org
Subject: Ping: [PATCH v6] Emulate dip switch language layout settings on SUN
 keyboard
Message-Id: <20230608181439.7ea3a5c5.hc981@poolhem.se>
In-Reply-To: <20230430225533.1a57879a.hc981@poolhem.se>
References: <167305907804.10652.2746409341903316717-1@git.sr.ht>
 <d2850ef0-d825-bb03-09d4-0d1427cf6577@ilande.co.uk>
 <20230123200937.32eb19eb.hc981@poolhem.se>
 <20230304220754.0c6ae562.hc981@poolhem.se>
 <ZCLzUyiDeKLfQqWT@redhat.com>
 <20230328191958.3e3eb5e4.hc981@poolhem.se>
 <ZCMq/imcAq0ApLQp@redhat.com>
 <20230328221608.328ab80f.hc981@poolhem.se>
 <20230430225533.1a57879a.hc981@poolhem.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: henrik@poolhem.se
Received-SPF: none client-ip=2a0b:dc80:cafe:112::1;
 envelope-from=hc981@poolhem.se; helo=mailout12.inleed.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

I didn't get much response to my last version of the patch to implement
emulation of language selection dip switch on SUN keyboards. By request, I
changed the patch to listen for -global escc.sunkbd_layout= instead of using
the -k switch to select keyboard layout.

What do you think about this patch? Would you like to apply it as is, or do
you want any more changes?

Best regards Henrik

On Sun, 30 Apr 2023 22:55:33 +0200
Henrik Carlqvist <hc981@poolhem.se> wrote:

> I have now changed the patch to instead of using the -k switch use 
> 
> -global escc.sunkbd_layout=
> 
> to select keyboard layout. It would be nice to somehow document this. Yes,
> in the monitor, you can type "info qtree" and see something like:
> 
>   dev: escc, id ""
>     gpio-out "sysbus-irq" 2
>     frequency = 4915200 (0x4b0000)
>     it_shift = 1 (0x1)
>     bit_swap = false
>     disabled = 0 (0x0)
>     chnBtype = 2 (0x2)
>     chnAtype = 1 (0x1)
>     chrB = ""
>     chrA = ""
>     sunkbd_layout = "43"
>     mmio 0000000071000000/0000000000000008
>  
> but that information is not easy to find and it does not say anything about 
> possible values. What is the best way to document this kind of global 
> parameters?
> 
> Please cc me any reply as I am no longer subscribed to the mailing list.
> 
> best regards Henrik
> 
> SUN Type 4, 5 and 5c keyboards have dip switches to choose the language
> layout of the keyboard. Solaris makes an ioctl to query the value of the
> dipswitches and uses that value to select keyboard layout. Also the SUN bios
> like the one in the file ss5.bin uses this value to support at least some
> keyboard layouts. However, the OpenBIOS provided with qemu is hardcoded to
> always use an US keyboard layout.
> 
> Before this patch, qemu allways gave dip switch value 0x21 (US keyboard),
> this patch uses a command line switch like "-global escc.sunkbd_layout=de"
> to select dip switch value. A table is used to lookup values from arguments
> like:
> 
> -global escc.sunkbd_layout=fr
> -global escc.sunkbd_layout=es
> 
> But the patch also accepts numeric dip switch values directly to the -k
> switch:
> 
> -global escc.sunkbd_layout=0x2b
> -global escc.sunkbd_layout=43
> 
> Both values above are the same and select swedish keyboard as explained in
> table 3-15 at
> https://docs.oracle.com/cd/E19683-01/806-6642/new-43/index.html
> 
> Unless you want to do a full Solaris installation but happen to have
> access to a bios file, the easiest way to test that the patch works is to:
> 
> qemu-system-sparc -global escc.sunkbd_layout=sv -bios /path/to/ss5.bin
> 
> If you already happen to have a Solaris installation in a qemu disk image
> file you can easily try different keyboard layouts after this patch is
> applied.
> 
> Signed-off-by: Henrik Carlqvist <hc1245@poolhem.se>
> ---
>  hw/char/escc.c         | 81 +++++++++++++++++++++++++++++++++++++++---
>  include/hw/char/escc.h |  1 +
>  2 files changed, 78 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index 17a908c59b..0aac4f0f92 100644
> --- a/hw/char/escc.c
> +++ b/hw/char/escc.c
> @@ -31,6 +31,8 @@
>  #include "qemu/module.h"
>  #include "hw/char/escc.h"
>  #include "ui/console.h"
> +
> +#include "qemu/cutils.h"
>  #include "trace.h"
>  
>  /*
> @@ -190,7 +192,8 @@
>  #define R_MISC1I 14
>  #define R_EXTINT 15
>  
> -static void handle_kbd_command(ESCCChannelState *s, int val);
> +static unsigned char sun_keyboard_layout_dip_switch(const char
> *keyboard_layout);+static void handle_kbd_command(ESCCChannelState *s, int
> val, ESCCState *k);
>  static int serial_can_receive(void *opaque);
>  static void serial_receive_byte(ESCCChannelState *s, int ch);
>  
> @@ -657,7 +660,7 @@ static void escc_mem_write(void *opaque, hwaddr addr,
>                   */
>                  qemu_chr_fe_write_all(&s->chr, &s->tx, 1);
>              } else if (s->type == escc_kbd && !s->disabled) {
> -                handle_kbd_command(s, val);
> +                handle_kbd_command(s, val, serial);
>              }
>          }
>          s->rregs[R_STATUS] |= STATUS_TXEMPTY; /* Tx buffer empty */
> @@ -846,7 +849,76 @@ static QemuInputHandler sunkbd_handler = {
>      .event = sunkbd_handle_event,
>  };
>  
> -static void handle_kbd_command(ESCCChannelState *s, int val)
> +static unsigned char sun_keyboard_layout_dip_switch(const char
> *keyboard_layout)+{
> +    /* Return the value of the dip-switches in a SUN Type 5 keyboard */
> +    static unsigned char ret = 0xff;
> +
> +    if ((ret == 0xff) && keyboard_layout) {
> +        int i;
> +        struct layout_values {
> +            const char *lang;
> +            unsigned char dip;
> +        } languages[] =
> +    /* Dip values from table 3-16 Layouts for Type 4, 5, and 5c Keyboards
> */+            {
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
> +            if (!strcmp(keyboard_layout, languages[i].lang)) {
> +                ret = languages[i].dip;
> +                return ret;
> +            }
> +        }
> +        /* Found no known language code */
> +
> +        if ((keyboard_layout[0] >= '0') && (keyboard_layout[0] <= '9')) {
> +            unsigned int tmp;
> +            /* As a fallback we also accept numeric dip switch value */
> +            if (!qemu_strtoui(keyboard_layout, NULL, 0, &tmp)) {
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
> +static void handle_kbd_command(ESCCChannelState *s, int val, ESCCState *k)
>  {
>      trace_escc_kbd_command(val);
>      if (s->led_mode) { /* Ignore led byte */
> @@ -867,7 +939,7 @@ static void handle_kbd_command(ESCCChannelState *s, int
> val)
>      case 0xf:
>          clear_queue(s);
>          put_queue(s, 0xfe);
> -        put_queue(s, 0x21); /*  en-us layout */
> +        put_queue(s, sun_keyboard_layout_dip_switch(k->keyboard_layout));
>          break;
>      default:
>          break;
> @@ -976,6 +1048,7 @@ static Property escc_properties[] = {
>      DEFINE_PROP_UINT32("chnAtype",  ESCCState, chn[1].type, 0),
>      DEFINE_PROP_CHR("chrB", ESCCState, chn[0].chr),
>      DEFINE_PROP_CHR("chrA", ESCCState, chn[1].chr),
> +    DEFINE_PROP_STRING("sunkbd_layout", ESCCState, keyboard_layout),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
> index 7e9482dee2..2830876a17 100644
> --- a/include/hw/char/escc.h
> +++ b/include/hw/char/escc.h
> @@ -56,6 +56,7 @@ struct ESCCState {
>      MemoryRegion mmio;
>      uint32_t disabled;
>      uint32_t frequency;
> +    char *keyboard_layout;
>  };
>  
>  #endif
> -- 
> 2.30.4
> 

