Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A58257284CF
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 18:23:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7IPE-0004OQ-VT; Thu, 08 Jun 2023 12:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q7IPD-0004O8-0s
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q7IPA-0005Gb-TZ
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686241351;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+Sd4Dqrp0+XgegTCF/3M6gDC/aytTe3a3BhTB6v0lH8=;
 b=NtJZUyiHlYSdOnuDc2wxOaZmYya4y5roblWbLQ2ZYNcZRSOE+Vtmiz7UD1QdKVEb2Hx1Vr
 yjwyYbPS8kzTCpnRE9ieeufjaD/9aOicH6rss9mgvjjsi+6VyARJ57DkUzFkAzqdxwcGsH
 0GMy1yFzKpOnbmMnCAclwTE0fnoUEWo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-q2ZqESC9M4ql14ZN659Dng-1; Thu, 08 Jun 2023 12:22:29 -0400
X-MC-Unique: q2ZqESC9M4ql14ZN659Dng-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD85A3C11CDD;
 Thu,  8 Jun 2023 16:22:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B62BD492B00;
 Thu,  8 Jun 2023 16:22:27 +0000 (UTC)
Date: Thu, 8 Jun 2023 17:22:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Henrik Carlqvist <hc981@poolhem.se>
Cc: mark.cave-ayland@ilande.co.uk, hc1245@poolhem.se, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] Emulate dip switch language layout settings on SUN
 keyboard
Message-ID: <ZIIAPz/HOqPXjKIs@redhat.com>
References: <167305907804.10652.2746409341903316717-1@git.sr.ht>
 <d2850ef0-d825-bb03-09d4-0d1427cf6577@ilande.co.uk>
 <20230123200937.32eb19eb.hc981@poolhem.se>
 <20230304220754.0c6ae562.hc981@poolhem.se>
 <ZCLzUyiDeKLfQqWT@redhat.com>
 <20230328191958.3e3eb5e4.hc981@poolhem.se>
 <ZCMq/imcAq0ApLQp@redhat.com>
 <20230328221608.328ab80f.hc981@poolhem.se>
 <20230430225533.1a57879a.hc981@poolhem.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230430225533.1a57879a.hc981@poolhem.se>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

On Sun, Apr 30, 2023 at 10:55:33PM +0200, Henrik Carlqvist wrote:
> I have now changed the patch to instead of using the -k switch use 
> 
> -global escc.sunkbd_layout=
> 
> to select keyboard layout. It would be nice to somehow document this. Yes, in 
> the monitor, you can type "info qtree" and see something like:
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

You can put it in docs/system/sparc.rst (or sparc64.rst whichever is best?)

Alternatively create a docs/system/devices/escc.rst and link it from
device-emulation.rst

> 
> Please cc me any reply as I am no longer subscribed to the mailing list.
> 
> best regards Henrik
> 
> SUN Type 4, 5 and 5c keyboards have dip switches to choose the language layout 
> of the keyboard. Solaris makes an ioctl to query the value of the dipswitches 
> and uses that value to select keyboard layout. Also the SUN bios like the one 
> in the file ss5.bin uses this value to support at least some keyboard layouts. 
> However, the OpenBIOS provided with qemu is hardcoded to always use an 
> US keyboard layout.
> 
> Before this patch, qemu allways gave dip switch value 0x21 (US keyboard),
> this patch uses a command line switch like "-global escc.sunkbd_layout=de" to
> select dip switch value. A table is used to lookup values from arguments like:
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
> -static void handle_kbd_command(ESCCChannelState *s, int val)
> +static unsigned char sun_keyboard_layout_dip_switch(const char *keyboard_layout)
> +{
> +    /* Return the value of the dip-switches in a SUN Type 5 keyboard */
> +    static unsigned char ret = 0xff;
> +
> +    if ((ret == 0xff) && keyboard_layout) {
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

Simpify to

      i < ARRAY_SIZE(languages);

at which point you can fit the for(;;) on one line.

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


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


