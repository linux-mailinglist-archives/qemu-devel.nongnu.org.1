Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D784373679C
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:24:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXZf-0002hg-Rf; Tue, 20 Jun 2023 05:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBXZa-0002hA-5P
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:22:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBXZW-0002ra-Dl
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687252965;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=gxqGRoFbsFcgWnZjQxoZ5jfuJ+/mWzkxy+ERFGIXwS8=;
 b=f7Ef0oRvEgB8naKSaI2Fr5SK1vckGn+7TGCKQpMHbmH+q61Nuy32pMCZJ4sq6CBGbyK86+
 K+W0TItVkj+GtenBFKHlZxZRK9g5UeMzD9VkOw3j2Lzrp9MCuhkFwJlh0dfH073dQsHbKB
 oMr2Crj1f9UNKHbtpvc3FIUAgzUT49o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-xPQFugDZNImLLteJXdOe3A-1; Tue, 20 Jun 2023 05:22:43 -0400
X-MC-Unique: xPQFugDZNImLLteJXdOe3A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EF0C101A52C;
 Tue, 20 Jun 2023 09:22:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 586924087C6A;
 Tue, 20 Jun 2023 09:22:41 +0000 (UTC)
Date: Tue, 20 Jun 2023 10:22:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Henrik Carlqvist <hc94@poolhem.se>
Cc: Henrik Carlqvist <hc981@poolhem.se>, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v7] Emulate dip switch language layout settings on SUN
 keyboard
Message-ID: <ZJFv4Hq8RMVOUum/@redhat.com>
References: <20230304220754.0c6ae562.hc981@poolhem.se>
 <ZCLzUyiDeKLfQqWT@redhat.com>
 <20230328191958.3e3eb5e4.hc981@poolhem.se>
 <ZCMq/imcAq0ApLQp@redhat.com>
 <20230328221608.328ab80f.hc981@poolhem.se>
 <20230430225533.1a57879a.hc981@poolhem.se>
 <20230608181439.7ea3a5c5.hc981@poolhem.se>
 <4e8f027a-ca00-c54f-ef2f-f0df1f5b2f9e@ilande.co.uk>
 <20230610122912.0fc157de.hc981@poolhem.se>
 <20230611014751.22f22674.hc94@poolhem.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230611014751.22f22674.hc94@poolhem.se>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Sun, Jun 11, 2023 at 01:47:51AM +0200, Henrik Carlqvist wrote:
> I have now changed the patch to instead use
> 
> -global escc.chnA-sunkbd-layout=
> 
> and documented in docs/system/keyboard.rst which I have linked from 
> target-sparc.rst. Unfortunately, I am not very used to these .rst files
> and have not found out how to create html files from them, so I don't know 
> for sure if my formatting is correct. Typing "make help" seems to indicate
> that it should be possible to type "make html", but that did not seem to work.

Assuming you have docutils installed, QEMU will build the manual by
default and print any issues on console during build. You can point
your browser to $BUILD/docs/manual/system/index.html to see the result.

For future reference, if you want to put some questions/notes in the
submission, it is best to keep them separate from the commit message
text, as the questions/notes shouldn't end up in git history. To
separate them, put questions  immediately after the '---' that separate
the commit message from the diffstat

> 
> SUN Type 4, 5 and 5c keyboards have dip switches to choose
> the language layout of the keyboard. Solaris makes an ioctl to query the
> value of the dipswitches and uses that value to select keyboard layout. Also
> the SUN bios like the one in the file ss5.bin uses this value to support at
> least some keyboard layouts. However, the OpenBIOS provided with qemu is
> hardcoded to always use an US keyboard layout.
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

....notes/questions go here....


>  docs/system/keyboard.rst     | 127 +++++++++++++++++++++++++++++++++++
>  docs/system/target-sparc.rst |   2 +-
>  hw/char/escc.c               |  76 ++++++++++++++++++++-
>  include/hw/char/escc.h       |   1 +
>  4 files changed, 204 insertions(+), 2 deletions(-)
>  create mode 100644 docs/system/keyboard.rst
> 
> diff --git a/docs/system/keyboard.rst b/docs/system/keyboard.rst
> new file mode 100644
> index 0000000000..b489c607f8
> --- /dev/null
> +++ b/docs/system/keyboard.rst
> @@ -0,0 +1,127 @@
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
> +"-global escc.chnA-sunkbd-layout=de"
> +
> +Depending on type of keyboard, the keyboard can have 6 or 5 dip-switches to
> +select keyboard layout, giving up to 64 different layouts. Not all
> +combinations are supported by Solaris and even less by Sun OpenBoot BIOS.
> +
> +The dip switch settings can be given as hexadecimal number, decimal number
> +or in some cases as a language string. Examples:
> +
> +-global escc.chnA-sunkbd-layout=0x2b
> +-global escc.chnA-sunkbd-layout=43
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
> index b55f8d09e9..d5418c32d0 100644
> --- a/docs/system/target-sparc.rst
> +++ b/docs/system/target-sparc.rst
> @@ -38,7 +38,7 @@ QEMU emulates the following sun4m peripherals:
>  -  Non Volatile RAM M48T02/M48T08
>  
>  -  Slave I/O: timers, interrupt controllers, Zilog serial ports,
> -   keyboard and power/reset logic
> +   :ref: `keyboard` and power/reset logic

You need to remove the space between :ref: and `keyboard`.

You'll also need to add it to a ToC (table of contents) otherwise
the build system complains.

I'd suggest putting the new file at docs/system/devices/keyboards.rst
and adding to the ToC in docs/system/device-emulation.rst


>  -  ESP SCSI controller with hard disk and CD-ROM support
>  
> diff --git a/hw/char/escc.c b/hw/char/escc.c
> index 17a908c59b..463b3d2e93 100644
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
> @@ -190,6 +192,7 @@
>  #define R_MISC1I 14
>  #define R_EXTINT 15
>  
> +static unsigned char sunkbd_layout_dip_switch(const char *sunkbd_layout);
>  static void handle_kbd_command(ESCCChannelState *s, int val);
>  static int serial_can_receive(void *opaque);
>  static void serial_receive_byte(ESCCChannelState *s, int ch);
> @@ -846,6 +849,75 @@ static QemuInputHandler sunkbd_handler = {
>      .event = sunkbd_handle_event,
>  };
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
>  static void handle_kbd_command(ESCCChannelState *s, int val)
>  {
>      trace_escc_kbd_command(val);
> @@ -867,7 +939,7 @@ static void handle_kbd_command(ESCCChannelState *s, int val)
>      case 0xf:
>          clear_queue(s);
>          put_queue(s, 0xfe);
> -        put_queue(s, 0x21); /*  en-us layout */
> +        put_queue(s, sunkbd_layout_dip_switch(s->sunkbd_layout));
>          break;
>      default:
>          break;
> @@ -976,6 +1048,8 @@ static Property escc_properties[] = {
>      DEFINE_PROP_UINT32("chnAtype",  ESCCState, chn[1].type, 0),
>      DEFINE_PROP_CHR("chrB", ESCCState, chn[0].chr),
>      DEFINE_PROP_CHR("chrA", ESCCState, chn[1].chr),
> +    DEFINE_PROP_STRING("chnA-sunkbd-layout", ESCCState,
> +		       chn[1].sunkbd_layout),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
> index 7e9482dee2..5669a5b811 100644
> --- a/include/hw/char/escc.h
> +++ b/include/hw/char/escc.h
> @@ -45,6 +45,7 @@ typedef struct ESCCChannelState {
>      ESCCChnType type;
>      uint8_t rx, tx;
>      QemuInputHandlerState *hs;
> +    char *sunkbd_layout;
>  } ESCCChannelState;
>  
>  struct ESCCState {
> -- 
> 2.30.4
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


