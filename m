Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E1B72D075
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 22:29:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8o9Y-0003U7-9S; Mon, 12 Jun 2023 16:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.chollet@free.fr>)
 id 1q8o9T-0003Tj-1t
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 16:28:35 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.chollet@free.fr>)
 id 1q8o9P-0000Qf-H7
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 16:28:34 -0400
Received: from [192.168.18.7] (unknown [198.16.176.181])
 (Authenticated sender: lucas.chollet@free.fr)
 by smtp4-g21.free.fr (Postfix) with ESMTPSA id E0E1019F73C;
 Mon, 12 Jun 2023 22:28:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1686601705;
 bh=oH6AXA/y/rWd4VV5UKzmcqlooQV4LzilzM8dV8Rf850=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ptY1Rmi38SMWbum8e+Q0KSQhBMSA4FhJ+4mpN3a9ZqnMwRdsHxxXO2spkTg6qn4aW
 89EFZDGoCfXbP6+agEOcRz3rbm0b5PgIkK4jGAtsfCmEHvkWfnjPL3SPciNW5llcMD
 NtKs0xrFQFALNmiCbPdO8s5ycWPhDeayM29+VQpNiZPyoRmknh8LL8DyTfIN+J+hSh
 O7RoJ85H5vx+MJ+nd+L+i8S4olFyhHlSwnmvaOc3IHstJ+wVq81nlbyBeyL3qt1rS9
 HzxOHNn7CqzaKPKvczTWltTWaUjFvFotao9z6kypMV9ZJrYGDp9u4jathubpLRMwxe
 7MyDB8OtKFzIw==
Content-Type: multipart/alternative;
 boundary="------------MKcUCPsQApC0xDsCgeDjyhJ0"
Message-ID: <6b6a15a8-5b24-0ef0-191b-ac0adec62c07@free.fr>
Date: Mon, 12 Jun 2023 16:28:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hw/i386/vmmouse: use the new input api
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
References: <20230608192345.708062-1-lucas.chollet@free.fr>
 <CAJ+F1CK2LE3z8ziTiuN5jEA-Ep-9fs7uRQPoda_ie525uUECWg@mail.gmail.com>
From: Lucas Chollet <lucas.chollet@free.fr>
In-Reply-To: <CAJ+F1CK2LE3z8ziTiuN5jEA-Ep-9fs7uRQPoda_ie525uUECWg@mail.gmail.com>
Received-SPF: pass client-ip=212.27.42.4; envelope-from=lucas.chollet@free.fr;
 helo=smtp4-g21.free.fr
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-0.096, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------MKcUCPsQApC0xDsCgeDjyhJ0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marc-André,

> Hi Lucas
>
> On Thu, Jun 8, 2023 at 9:49 PM Lucas Chollet <lucas.chollet@free.fr> 
> wrote:
>
>     No functional changes intended.
>
>     Signed-off-by: Lucas Chollet <lucas.chollet@free.fr>
>     ---
>      hw/i386/vmmouse.c | 95
>     +++++++++++++++++++++++++++++++++++------------
>      1 file changed, 71 insertions(+), 24 deletions(-)
>
>
> The patch diff isn't great, and there is a risk of regressions. I 
> wonder if input-legacy is really meant to be deprecated (after 10y it 
> is still around).

I had the same conclusion but as I'm not familiar with QEMU development, 
I thought that you guys would quickly tell me if it's not worth.

>
> Otherwise, the patch looks ok to me, except some question below:
>
>
>     diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
>     index a56c185f15..bdddbb64ac 100644
>     --- a/hw/i386/vmmouse.c
>     +++ b/hw/i386/vmmouse.c
>     @@ -24,7 +24,7 @@
>
>      #include "qemu/osdep.h"
>      #include "qapi/error.h"
>     -#include "ui/console.h"
>     +#include "ui/input.h"
>      #include "hw/i386/vmport.h"
>      #include "hw/input/i8042.h"
>      #include "hw/qdev-properties.h"
>     @@ -61,7 +61,10 @@ struct VMMouseState {
>          uint16_t nb_queue;
>          uint16_t status;
>          uint8_t absolute;
>     -    QEMUPutMouseEntry *entry;
>     +    int32_t last_x;
>     +    int32_t last_y;
>     +    int32_t last_buttons;
>     +    QemuInputHandlerState *entry;
>          ISAKBDState *i8042;
>      };
>
>     @@ -91,33 +94,72 @@ static uint32_t
>     vmmouse_get_status(VMMouseState *s)
>          return (s->status << 16) | s->nb_queue;
>      }
>
>     -static void vmmouse_mouse_event(void *opaque, int x, int y, int
>     dz, int buttons_state)
>     +static void vmmouse_mouse_event(DeviceState *dev, QemuConsole *src,
>     +                                InputEvent *evt)
>      {
>     -    VMMouseState *s = opaque;
>     -    int buttons = 0;
>     +    static const int bmap[INPUT_BUTTON__MAX] = {
>     +        [INPUT_BUTTON_LEFT]   = 0x20,
>     +        [INPUT_BUTTON_MIDDLE] = 0x08,
>     +        [INPUT_BUTTON_RIGHT]  = 0x10,
>     +    };
>     +
>     +    VMMouseState *s = VMMOUSE(dev);
>     +    InputMoveEvent *move;
>     +    InputBtnEvent *btn;
>     +
>     +    int32_t dz = 0;
>
>          if (s->nb_queue > (VMMOUSE_QUEUE_SIZE - 4))
>              return;
>
>     -    DPRINTF("vmmouse_mouse_event(%d, %d, %d, %d)\n",
>     -            x, y, dz, buttons_state);
>     +    switch (evt->type) {
>     +    case INPUT_EVENT_KIND_REL:
>     +        move = evt->u.rel.data;
>     +        if (move->axis == INPUT_AXIS_X) {
>     +            s->last_x += move->value;
>     +        } else if (move->axis == INPUT_AXIS_Y) {
>     +            s->last_y -= move->value;
>     +        }
>     +        break;
>
>     -    if ((buttons_state & MOUSE_EVENT_LBUTTON))
>     -        buttons |= 0x20;
>     -    if ((buttons_state & MOUSE_EVENT_RBUTTON))
>     -        buttons |= 0x10;
>     -    if ((buttons_state & MOUSE_EVENT_MBUTTON))
>     -        buttons |= 0x08;
>     +    case INPUT_EVENT_KIND_ABS:
>     +        move = evt->u.rel.data;
>     +        if (move->axis == INPUT_AXIS_X) {
>     +            s->last_x = move->value;
>     +        } else if (move->axis == INPUT_AXIS_Y) {
>     +            s->last_y = move->value;
>     +        }
>     +        break;
>
>     -    if (s->absolute) {
>     -        x <<= 1;
>     -        y <<= 1;
>     +    case INPUT_EVENT_KIND_BTN:
>     +        btn = evt->u.btn.data;
>     +        if (btn->down) {
>     +            s->last_buttons |= bmap[btn->button];
>     +            if (btn->button == INPUT_BUTTON_WHEEL_UP) {
>     +                dz--;
>     +            } else if (btn->button == INPUT_BUTTON_WHEEL_DOWN) {
>     +                dz++;
>     +            }
>     +
>     +        } else {
>     +          s->last_buttons &= ~bmap[btn->button];
>     +        }
>     +        break;
>     +
>     +    default:
>     +        /* keep gcc happy */
>     +        break;
>          }
>
>     -    s->queue[s->nb_queue++] = buttons;
>     -    s->queue[s->nb_queue++] = x;
>     -    s->queue[s->nb_queue++] = y;
>     +    s->queue[s->nb_queue++] = s->last_buttons;
>     +    s->queue[s->nb_queue++] = s->absolute ? s->last_x << 1 :
>     s->last_x;
>     +    s->queue[s->nb_queue++] = s->absolute ? s->last_y << 1 :
>     s->last_y;
>          s->queue[s->nb_queue++] = dz;
>     +}
>     +
>     +static void vmmouse_mouse_sync(DeviceState *dev)
>     +{
>     +    VMMouseState *s = VMMOUSE(dev);
>
>          /* need to still generate PS2 events to notify driver to
>             read from queue */
>     @@ -127,11 +169,18 @@ static void vmmouse_mouse_event(void
>     *opaque, int x, int y, int dz, int buttons_
>      static void vmmouse_remove_handler(VMMouseState *s)
>      {
>          if (s->entry) {
>     -        qemu_remove_mouse_event_handler(s->entry);
>     +        qemu_input_handler_unregister(s->entry);
>              s->entry = NULL;
>          }
>      }
>
>     +static QemuInputHandler vm_mouse_handler = {
>     +    .name  = "vmmouse",
>     +    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
>     +    .event = vmmouse_mouse_event,
>     +    .sync  = vmmouse_mouse_sync,
>     +};
>     +
>      static void vmmouse_update_handler(VMMouseState *s, int absolute)
>      {
>          if (s->status != 0) {
>     @@ -142,10 +191,8 @@ static void
>     vmmouse_update_handler(VMMouseState *s, int absolute)
>              vmmouse_remove_handler(s);
>          }
>          if (s->entry == NULL) {
>     -        s->entry = qemu_add_mouse_event_handler(vmmouse_mouse_event,
>     -                                                s, s->absolute,
>     -                                                "vmmouse");
>     -        qemu_activate_mouse_event_handler(s->entry);
>     +        s->entry = qemu_input_handler_register(DEVICE(s),
>     &vm_mouse_handler);
>
>
> You don't take "absolute" state into account anymore, so 
> vm_mouse_handler.mask is always with MASK_ABS. I think this may be 
> problematic as mouse_mode won't change properly from abs/rel.

Ohh you're right, I wonder what's the best solution here. We can either 
have both `QemuInputHandler vm_mouse_handler_rel` and `QemuInputHandler 
vm_mouse_handler_abs` or make `vm_mouse_handler` accept both type of events.

Still, I'm a bit surprised because I tested to remove the call to put 
the mouse in absolute mode in the guest kernel and it works.

>
>     +        qemu_input_handler_activate(s->entry);
>          }
>      }
>
>     -- 
>     2.39.2
>
>
>
>
> -- 
> Marc-André Lureau
--------------MKcUCPsQApC0xDsCgeDjyhJ0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Marc-André,</p>
    <blockquote type="cite"
cite="mid:CAJ+F1CK2LE3z8ziTiuN5jEA-Ep-9fs7uRQPoda_ie525uUECWg@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">Hi Lucas<br>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Thu, Jun 8, 2023 at
            9:49 PM Lucas Chollet &lt;<a
              href="mailto:lucas.chollet@free.fr" moz-do-not-send="true"
              class="moz-txt-link-freetext">lucas.chollet@free.fr</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">No functional changes
            intended.<br>
            <br>
            Signed-off-by: Lucas Chollet &lt;<a
              href="mailto:lucas.chollet@free.fr" target="_blank"
              moz-do-not-send="true" class="moz-txt-link-freetext">lucas.chollet@free.fr</a>&gt;<br>
            ---<br>
             hw/i386/vmmouse.c | 95
            +++++++++++++++++++++++++++++++++++------------<br>
             1 file changed, 71 insertions(+), 24 deletions(-)<br>
          </blockquote>
          <div><br>
          </div>
          <div>The patch diff isn't great, and there is a risk of
            regressions. I wonder if input-legacy is really meant to be
            deprecated (after 10y it is still around).</div>
        </div>
      </div>
    </blockquote>
    <p>I had the same conclusion but as I'm not familiar with QEMU
      development, I thought that you guys would quickly tell me if it's
      not worth.</p>
    <blockquote type="cite"
cite="mid:CAJ+F1CK2LE3z8ziTiuN5jEA-Ep-9fs7uRQPoda_ie525uUECWg@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><br>
          </div>
          <div>Otherwise, the patch looks ok to me, except some question
            below:<br>
          </div>
          <div> <br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <br>
            diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c<br>
            index a56c185f15..bdddbb64ac 100644<br>
            --- a/hw/i386/vmmouse.c<br>
            +++ b/hw/i386/vmmouse.c<br>
            @@ -24,7 +24,7 @@<br>
            <br>
             #include "qemu/osdep.h"<br>
             #include "qapi/error.h"<br>
            -#include "ui/console.h"<br>
            +#include "ui/input.h"<br>
             #include "hw/i386/vmport.h"<br>
             #include "hw/input/i8042.h"<br>
             #include "hw/qdev-properties.h"<br>
            @@ -61,7 +61,10 @@ struct VMMouseState {<br>
                 uint16_t nb_queue;<br>
                 uint16_t status;<br>
                 uint8_t absolute;<br>
            -    QEMUPutMouseEntry *entry;<br>
            +    int32_t last_x;<br>
            +    int32_t last_y;<br>
            +    int32_t last_buttons;<br>
            +    QemuInputHandlerState *entry;<br>
                 ISAKBDState *i8042;<br>
             };<br>
            <br>
            @@ -91,33 +94,72 @@ static uint32_t
            vmmouse_get_status(VMMouseState *s)<br>
                 return (s-&gt;status &lt;&lt; 16) | s-&gt;nb_queue;<br>
             }<br>
            <br>
            -static void vmmouse_mouse_event(void *opaque, int x, int y,
            int dz, int buttons_state)<br>
            +static void vmmouse_mouse_event(DeviceState *dev,
            QemuConsole *src,<br>
            +                                InputEvent *evt)<br>
             {<br>
            -    VMMouseState *s = opaque;<br>
            -    int buttons = 0;<br>
            +    static const int bmap[INPUT_BUTTON__MAX] = {<br>
            +        [INPUT_BUTTON_LEFT]   = 0x20,<br>
            +        [INPUT_BUTTON_MIDDLE] = 0x08,<br>
            +        [INPUT_BUTTON_RIGHT]  = 0x10,<br>
            +    };<br>
            +<br>
            +    VMMouseState *s = VMMOUSE(dev);<br>
            +    InputMoveEvent *move;<br>
            +    InputBtnEvent *btn;<br>
            +<br>
            +    int32_t dz = 0;<br>
            <br>
                 if (s-&gt;nb_queue &gt; (VMMOUSE_QUEUE_SIZE - 4))<br>
                     return;<br>
            <br>
            -    DPRINTF("vmmouse_mouse_event(%d, %d, %d, %d)\n",<br>
            -            x, y, dz, buttons_state);<br>
            +    switch (evt-&gt;type) {<br>
            +    case INPUT_EVENT_KIND_REL:<br>
            +        move = evt-&gt;u.rel.data;<br>
            +        if (move-&gt;axis == INPUT_AXIS_X) {<br>
            +            s-&gt;last_x += move-&gt;value;<br>
            +        } else if (move-&gt;axis == INPUT_AXIS_Y) {<br>
            +            s-&gt;last_y -= move-&gt;value;<br>
            +        }<br>
            +        break;<br>
            <br>
            -    if ((buttons_state &amp; MOUSE_EVENT_LBUTTON))<br>
            -        buttons |= 0x20;<br>
            -    if ((buttons_state &amp; MOUSE_EVENT_RBUTTON))<br>
            -        buttons |= 0x10;<br>
            -    if ((buttons_state &amp; MOUSE_EVENT_MBUTTON))<br>
            -        buttons |= 0x08;<br>
            +    case INPUT_EVENT_KIND_ABS:<br>
            +        move = evt-&gt;u.rel.data;<br>
            +        if (move-&gt;axis == INPUT_AXIS_X) {<br>
            +            s-&gt;last_x = move-&gt;value;<br>
            +        } else if (move-&gt;axis == INPUT_AXIS_Y) {<br>
            +            s-&gt;last_y = move-&gt;value;<br>
            +        }<br>
            +        break;<br>
            <br>
            -    if (s-&gt;absolute) {<br>
            -        x &lt;&lt;= 1;<br>
            -        y &lt;&lt;= 1;<br>
            +    case INPUT_EVENT_KIND_BTN:<br>
            +        btn = evt-&gt;u.btn.data;<br>
            +        if (btn-&gt;down) {<br>
            +            s-&gt;last_buttons |= bmap[btn-&gt;button];<br>
            +            if (btn-&gt;button == INPUT_BUTTON_WHEEL_UP) {<br>
            +                dz--;<br>
            +            } else if (btn-&gt;button ==
            INPUT_BUTTON_WHEEL_DOWN) {<br>
            +                dz++;<br>
            +            }<br>
            +<br>
            +        } else {<br>
            +          s-&gt;last_buttons &amp;= ~bmap[btn-&gt;button];<br>
            +        }<br>
            +        break;<br>
            +<br>
            +    default:<br>
            +        /* keep gcc happy */<br>
            +        break;<br>
                 }<br>
            <br>
            -    s-&gt;queue[s-&gt;nb_queue++] = buttons;<br>
            -    s-&gt;queue[s-&gt;nb_queue++] = x;<br>
            -    s-&gt;queue[s-&gt;nb_queue++] = y;<br>
            +    s-&gt;queue[s-&gt;nb_queue++] = s-&gt;last_buttons;<br>
            +    s-&gt;queue[s-&gt;nb_queue++] = s-&gt;absolute ?
            s-&gt;last_x &lt;&lt; 1 : s-&gt;last_x;<br>
            +    s-&gt;queue[s-&gt;nb_queue++] = s-&gt;absolute ?
            s-&gt;last_y &lt;&lt; 1 : s-&gt;last_y;<br>
                 s-&gt;queue[s-&gt;nb_queue++] = dz;<br>
            +}<br>
            +<br>
            +static void vmmouse_mouse_sync(DeviceState *dev)<br>
            +{<br>
            +    VMMouseState *s = VMMOUSE(dev);<br>
            <br>
                 /* need to still generate PS2 events to notify driver
            to<br>
                    read from queue */<br>
            @@ -127,11 +169,18 @@ static void vmmouse_mouse_event(void
            *opaque, int x, int y, int dz, int buttons_<br>
             static void vmmouse_remove_handler(VMMouseState *s)<br>
             {<br>
                 if (s-&gt;entry) {<br>
            -        qemu_remove_mouse_event_handler(s-&gt;entry);<br>
            +        qemu_input_handler_unregister(s-&gt;entry);<br>
                     s-&gt;entry = NULL;<br>
                 }<br>
             }<br>
            <br>
            +static QemuInputHandler vm_mouse_handler = {<br>
            +    .name  = "vmmouse",<br>
            +    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,<br>
            +    .event = vmmouse_mouse_event,<br>
            +    .sync  = vmmouse_mouse_sync,<br>
            +};<br>
            +<br>
             static void vmmouse_update_handler(VMMouseState *s, int
            absolute)<br>
             {<br>
                 if (s-&gt;status != 0) {<br>
            @@ -142,10 +191,8 @@ static void
            vmmouse_update_handler(VMMouseState *s, int absolute)<br>
                     vmmouse_remove_handler(s);<br>
                 }<br>
                 if (s-&gt;entry == NULL) {<br>
            -        s-&gt;entry =
            qemu_add_mouse_event_handler(vmmouse_mouse_event,<br>
            -                                                s,
            s-&gt;absolute,<br>
            -                                                "vmmouse");<br>
            -        qemu_activate_mouse_event_handler(s-&gt;entry);<br>
            +        s-&gt;entry =
            qemu_input_handler_register(DEVICE(s),
            &amp;vm_mouse_handler); <br>
          </blockquote>
          <div><br>
          </div>
          <div>You don't take "absolute" state into account anymore, so
            vm_mouse_handler.mask is always with MASK_ABS. I think this
            may be problematic as mouse_mode won't change properly from
            abs/rel.<br>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Ohh you're right, I wonder what's the best solution here. We can
      either have both `QemuInputHandler vm_mouse_handler_rel` and
      `QemuInputHandler vm_mouse_handler_abs` or make `vm_mouse_handler`
      accept both type of events.<br>
    </p>
    <p>Still, I'm a bit surprised because I tested to remove the call to
      put the mouse in absolute mode in the guest kernel and it works.<br>
    </p>
    <blockquote type="cite"
cite="mid:CAJ+F1CK2LE3z8ziTiuN5jEA-Ep-9fs7uRQPoda_ie525uUECWg@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            +        qemu_input_handler_activate(s-&gt;entry);<br>
                 }<br>
             }<br>
            <br>
            -- <br>
            2.39.2<br>
            <br>
            <br>
          </blockquote>
        </div>
        <br clear="all">
        <br>
        <span class="gmail_signature_prefix">-- </span><br>
        <div dir="ltr" class="gmail_signature">Marc-André Lureau<br>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------MKcUCPsQApC0xDsCgeDjyhJ0--

