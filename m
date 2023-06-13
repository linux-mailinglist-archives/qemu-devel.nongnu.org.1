Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7676F72E34B
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 14:47:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q93Ok-0005tV-UN; Tue, 13 Jun 2023 08:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q93Oi-0005su-9c
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 08:45:20 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q93Of-0000Pq-OM
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 08:45:20 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2b341f83493so1730951fa.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 05:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686660316; x=1689252316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NKYIQGzWB61jmJ/PDeHKsOOfzvihWAeWZYpxrv2491w=;
 b=sri2G1V2ZDswpgqko0np/U2RsL6ORwhWG/omIpfC6kW4KYgtI9LteSsp+CLlu038/8
 MN1ioeKAyWtOsxcdeT8+TuYL4RD/b/Y05URf5X3mGZdAuSX1G+MCAGNG36ZBAbYkISQs
 4tlgIy9uM0SyYc8uZLoWHLmyHK4U+ICUkEJWWBqg1uddY70V+5XwuaDipatK531ySXST
 yKSzEZpPq9oMf8jmICsBx3TgOyqtP/UGQo05LzV+ij+KtbgqiLKyUUMd6LuzB5s6/iJD
 UXve0fUZx6B2XruJBNhtCJhXbhV5Tko0Gzrb/tkvno1T0jixs9LccGKoh6CecmppHl3T
 CbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686660316; x=1689252316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NKYIQGzWB61jmJ/PDeHKsOOfzvihWAeWZYpxrv2491w=;
 b=Q0bCkJbaLLCRvVYIJKO3ICPv5/i33Wj7RoEEg5JeaRR7ON+O5NgNW4IIh4kZwtt/LV
 TZDeKEWuR70TeUeV+WDfumem7y8uYXwTxp+tnD+uw36U1IaOKz/Y3/hjnHuQDHzWzk0l
 A7WjZumHF5nDfN7EzZVRyeyg+JP8oHq8agHiwi+ukrwLcsw1wwPjBrGbbZiWWkX6Qkyk
 sY4n839el2iCzmqQQ/3Zk8Uw0ODQ5hQQbzmK90q8f/C95MiN3XdCI4pbrQAMJpkQO8sZ
 tio6vXBn3o8kQs2lox9974tG4qjZoTVPjv3llzd4ty2qLnbWJnmpgrGnnXwZhxqJXLxc
 Zh6g==
X-Gm-Message-State: AC+VfDzJqBmxy0LSCBfJqsa4RRmWtTI7Zwy95TYWFcX6/GW5YaUEWnf1
 3TnmDXEHgZoy5i8B4ncqCUy5WSPwNyp8jfQm/3YII1mkOGxIRw==
X-Google-Smtp-Source: ACHHUZ6wX6BpqYX4fNMHS07JcvFTjy0QvgHaa7sBLGpZzQKJYEX4oMOKoDUC4DZ2yTos6HI1q+B79hPPQrqDEDiHPBw=
X-Received: by 2002:a2e:998f:0:b0:2af:19dd:ecda with SMTP id
 w15-20020a2e998f000000b002af19ddecdamr4267403lji.45.1686660315696; Tue, 13
 Jun 2023 05:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230613104535.356842-1-belmouss@redhat.com>
In-Reply-To: <20230613104535.356842-1-belmouss@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 13 Jun 2023 14:44:59 +0200
Message-ID: <CAJ+F1C+=hJE2++vXAqte6Mewj-fUROKrfWNVfTUZznT51tN9rg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ui/touch: Move event handling to a common helper
To: Bilal Elmoussaoui <belmouss@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f9560405fe0234c6"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000f9560405fe0234c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bilal

On Tue, Jun 13, 2023 at 1:35=E2=80=AFPM Bilal Elmoussaoui <belmouss@redhat.=
com>
wrote:

> To share code between the GTK and DBus UI bakcends
> see the next commit for details
>
> Signed-off-by: Bilal Elmoussaoui <belmouss@redhat.com>
> ---
>  include/ui/console.h | 14 ++++++++++
>  ui/console.c         | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  ui/gtk.c             | 62 ++++--------------------------------------
>  3 files changed, 84 insertions(+), 57 deletions(-)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index ae5ec46..04d4317 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -5,6 +5,7 @@
>  #include "qom/object.h"
>  #include "qemu/notify.h"
>  #include "qapi/qapi-types-ui.h"
> +#include "ui/input.h"
>
>  #ifdef CONFIG_OPENGL
>  # include <epoxy/gl.h>
> @@ -95,6 +96,19 @@ bool kbd_put_qcode_console(QemuConsole *s, int qcode,
> bool ctrl);
>  void kbd_put_string_console(QemuConsole *s, const char *str, int len);
>  void kbd_put_keysym(int keysym);
>
> +/* Touch devices */
> +typedef struct touch_slot {
> +    int x;
> +    int y;
> +    int tracking_id;
> +} touch_slot;
> +
> +bool console_handle_touch_event(QemuConsole *con,
> +                                struct touch_slot
> touch_slots[INPUT_EVENT_SLOTS_MAX],
> +                                uint64_t num_slot,
> +                                int width, int height,
> +                                double x, double y,
> +                                InputMultiTouchType type);
>  /* consoles */
>
>  #define TYPE_QEMU_CONSOLE "qemu-console"
> diff --git a/ui/console.c b/ui/console.c
> index e173731..8bc6adb 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1635,6 +1635,71 @@ static bool console_compatible_with(QemuConsole
> *con,
>      return true;
>  }
>
> +bool console_handle_touch_event(QemuConsole *con,
> +                                struct touch_slot
> touch_slots[INPUT_EVENT_SLOTS_MAX],
> +                                uint64_t num_slot,
> +                                int width, int height,
> +                                double x, double y,
> +                                InputMultiTouchType type)
>

Better would be to use Error **errp.

+{
> +    struct touch_slot *slot;
> +    bool needs_sync =3D false;
> +    int update;
> +    int i;
> +
> +    if (num_slot >=3D INPUT_EVENT_SLOTS_MAX) {
> +        warn_report("unexpected touch slot number: % " PRId64" >=3D %d\n=
",
> +                    num_slot, INPUT_EVENT_SLOTS_MAX);
> +        return FALSE;
> +    }
> +
> +    slot =3D &touch_slots[num_slot];
> +    slot->x =3D x;
> +    slot->y =3D y;
> +
> +    if (type =3D=3D INPUT_MULTI_TOUCH_TYPE_BEGIN) {
> +        slot->tracking_id =3D num_slot;
> +    }
> +
> +    for (i =3D 0; i < INPUT_EVENT_SLOTS_MAX; ++i) {
> +        if (i =3D=3D num_slot) {
> +            update =3D type;
> +        } else {
> +            update =3D INPUT_MULTI_TOUCH_TYPE_UPDATE;
> +        }
> +
> +        slot =3D &touch_slots[i];
> +
> +        if (slot->tracking_id =3D=3D -1) {
> +            continue;
> +        }
> +
> +        if (update =3D=3D INPUT_MULTI_TOUCH_TYPE_END) {
> +            slot->tracking_id =3D -1;
> +            qemu_input_queue_mtt(con, update, i, slot->tracking_id);
> +            needs_sync =3D true;
> +        } else {
> +            qemu_input_queue_mtt(con, update, i, slot->tracking_id);
> +            qemu_input_queue_btn(con, INPUT_BUTTON_TOUCH, true);
> +            qemu_input_queue_mtt_abs(con,
> +                                    INPUT_AXIS_X, (int) slot->x,
> +                                    0, width,
> +                                    i, slot->tracking_id);
> +            qemu_input_queue_mtt_abs(con,
> +                                    INPUT_AXIS_Y, (int) slot->y,
> +                                    0, height,
> +                                    i, slot->tracking_id);
> +            needs_sync =3D true;
> +        }
> +    }
> +
> +    if (needs_sync) {
> +        qemu_input_event_sync();
> +    }
> +
> +    return TRUE;
> +}
> +
>  void qemu_console_set_display_gl_ctx(QemuConsole *con, DisplayGLCtx *gl)
>  {
>      /* display has opengl support */
> diff --git a/ui/gtk.c b/ui/gtk.c
> index e50f950..ebbd304 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -130,11 +130,6 @@ typedef struct VCChardev VCChardev;
>  DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
>                           TYPE_CHARDEV_VC)
>
> -struct touch_slot {
> -    int x;
> -    int y;
> -    int tracking_id;
> -};
>  static struct touch_slot touch_slots[INPUT_EVENT_SLOTS_MAX];
>
>  bool gtk_use_gl_area;
> @@ -1068,27 +1063,12 @@ static gboolean gd_touch_event(GtkWidget *widget,
> GdkEventTouch *touch,
>                                 void *opaque)
>  {
>      VirtualConsole *vc =3D opaque;
> -    struct touch_slot *slot;
>      uint64_t num_slot =3D GPOINTER_TO_UINT(touch->sequence);
> -    bool needs_sync =3D false;
> -    int update;
>      int type =3D -1;
> -    int i;
> -
> -    if (num_slot >=3D INPUT_EVENT_SLOTS_MAX) {
> -        warn_report("gtk: unexpected touch slot number: % " PRId64" >=3D
> %d\n",
> -                    num_slot, INPUT_EVENT_SLOTS_MAX);
> -        return FALSE;
> -    }
> -
> -    slot =3D &touch_slots[num_slot];
> -    slot->x =3D touch->x;
> -    slot->y =3D touch->y;
>
>      switch (touch->type) {
>      case GDK_TOUCH_BEGIN:
>          type =3D INPUT_MULTI_TOUCH_TYPE_BEGIN;
> -        slot->tracking_id =3D num_slot;
>          break;
>      case GDK_TOUCH_UPDATE:
>          type =3D INPUT_MULTI_TOUCH_TYPE_UPDATE;
> @@ -1099,45 +1079,13 @@ static gboolean gd_touch_event(GtkWidget *widget,
> GdkEventTouch *touch,
>          break;
>      default:
>          warn_report("gtk: unexpected touch event type\n");
> +        return FALSE;
>      }
>
> -    for (i =3D 0; i < INPUT_EVENT_SLOTS_MAX; ++i) {
> -        if (i =3D=3D num_slot) {
> -            update =3D type;
> -        } else {
> -            update =3D INPUT_MULTI_TOUCH_TYPE_UPDATE;
> -        }
> -
> -        slot =3D &touch_slots[i];
> -
> -        if (slot->tracking_id =3D=3D -1) {
> -            continue;
> -        }
> -
> -        if (update =3D=3D INPUT_MULTI_TOUCH_TYPE_END) {
> -            slot->tracking_id =3D -1;
> -            qemu_input_queue_mtt(vc->gfx.dcl.con, update, i,
> slot->tracking_id);
> -            needs_sync =3D true;
> -        } else {
> -            qemu_input_queue_mtt(vc->gfx.dcl.con, update, i,
> slot->tracking_id);
> -            qemu_input_queue_btn(vc->gfx.dcl.con, INPUT_BUTTON_TOUCH,
> true);
> -            qemu_input_queue_mtt_abs(vc->gfx.dcl.con,
> -                                     INPUT_AXIS_X, (int) slot->x,
> -                                     0, surface_width(vc->gfx.ds),
> -                                     i, slot->tracking_id);
> -            qemu_input_queue_mtt_abs(vc->gfx.dcl.con,
> -                                     INPUT_AXIS_Y, (int) slot->y,
> -                                     0, surface_height(vc->gfx.ds),
> -                                     i, slot->tracking_id);
> -            needs_sync =3D true;
> -        }
> -    }
> -
> -    if (needs_sync) {
> -        qemu_input_event_sync();
> -    }
> -
> -    return TRUE;
> +    return console_handle_touch_event(vc->gfx.dcl.con, touch_slots,
> +                                      num_slot, surface_width(vc->gfx.ds=
),
> +                                      surface_height(vc->gfx.ds),
> touch->x,
> +                                      touch->y, type);
>

Then we can call with &error_warn form here.

otherwise, lgtm

--=20
Marc-Andr=C3=A9 Lureau

--000000000000f9560405fe0234c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SGkgQmlsYWw8YnI+PC9kaXY+PGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24g
VHVlLCBKdW4gMTMsIDIwMjMgYXQgMTozNeKAr1BNIEJpbGFsIEVsbW91c3Nhb3VpICZsdDs8YSBo
cmVmPSJtYWlsdG86YmVsbW91c3NAcmVkaGF0LmNvbSI+YmVsbW91c3NAcmVkaGF0LmNvbTwvYT4m
Z3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxl
PSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQs
MjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+VG8gc2hhcmUgY29kZSBiZXR3ZWVuIHRoZSBHVEsg
YW5kIERCdXMgVUkgYmFrY2VuZHM8YnI+DQpzZWUgdGhlIG5leHQgY29tbWl0IGZvciBkZXRhaWxz
PGJyPg0KPGJyPg0KU2lnbmVkLW9mZi1ieTogQmlsYWwgRWxtb3Vzc2FvdWkgJmx0OzxhIGhyZWY9
Im1haWx0bzpiZWxtb3Vzc0ByZWRoYXQuY29tIiB0YXJnZXQ9Il9ibGFuayI+YmVsbW91c3NAcmVk
aGF0LmNvbTwvYT4mZ3Q7PGJyPg0KLS0tPGJyPg0KwqBpbmNsdWRlL3VpL2NvbnNvbGUuaCB8IDE0
ICsrKysrKysrKys8YnI+DQrCoHVpL2NvbnNvbGUuY8KgIMKgIMKgIMKgIMKgfCA2NSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKzxicj4NCsKgdWkvZ3RrLmPCoCDC
oCDCoCDCoCDCoCDCoCDCoHwgNjIgKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tPGJyPg0KwqAzIGZpbGVzIGNoYW5nZWQsIDg0IGluc2VydGlvbnMoKyksIDU3IGRlbGV0
aW9ucygtKTxicj4NCjxicj4NCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VpL2NvbnNvbGUuaCBiL2lu
Y2x1ZGUvdWkvY29uc29sZS5oPGJyPg0KaW5kZXggYWU1ZWM0Ni4uMDRkNDMxNyAxMDA2NDQ8YnI+
DQotLS0gYS9pbmNsdWRlL3VpL2NvbnNvbGUuaDxicj4NCisrKyBiL2luY2x1ZGUvdWkvY29uc29s
ZS5oPGJyPg0KQEAgLTUsNiArNSw3IEBAPGJyPg0KwqAjaW5jbHVkZSAmcXVvdDtxb20vb2JqZWN0
LmgmcXVvdDs8YnI+DQrCoCNpbmNsdWRlICZxdW90O3FlbXUvbm90aWZ5LmgmcXVvdDs8YnI+DQrC
oCNpbmNsdWRlICZxdW90O3FhcGkvcWFwaS10eXBlcy11aS5oJnF1b3Q7PGJyPg0KKyNpbmNsdWRl
ICZxdW90O3VpL2lucHV0LmgmcXVvdDs8YnI+DQo8YnI+DQrCoCNpZmRlZiBDT05GSUdfT1BFTkdM
PGJyPg0KwqAjIGluY2x1ZGUgJmx0O2Vwb3h5L2dsLmgmZ3Q7PGJyPg0KQEAgLTk1LDYgKzk2LDE5
IEBAIGJvb2wga2JkX3B1dF9xY29kZV9jb25zb2xlKFFlbXVDb25zb2xlICpzLCBpbnQgcWNvZGUs
IGJvb2wgY3RybCk7PGJyPg0KwqB2b2lkIGtiZF9wdXRfc3RyaW5nX2NvbnNvbGUoUWVtdUNvbnNv
bGUgKnMsIGNvbnN0IGNoYXIgKnN0ciwgaW50IGxlbik7PGJyPg0KwqB2b2lkIGtiZF9wdXRfa2V5
c3ltKGludCBrZXlzeW0pOzxicj4NCjxicj4NCisvKiBUb3VjaCBkZXZpY2VzICovPGJyPg0KK3R5
cGVkZWYgc3RydWN0IHRvdWNoX3Nsb3Qgezxicj4NCivCoCDCoCBpbnQgeDs8YnI+DQorwqAgwqAg
aW50IHk7PGJyPg0KK8KgIMKgIGludCB0cmFja2luZ19pZDs8YnI+DQorfSB0b3VjaF9zbG90Ozxi
cj4NCis8YnI+DQorYm9vbCBjb25zb2xlX2hhbmRsZV90b3VjaF9ldmVudChRZW11Q29uc29sZSAq
Y29uLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBzdHJ1Y3QgdG91Y2hfc2xvdCB0b3VjaF9zbG90c1tJTlBVVF9FVkVOVF9TTE9UU19NQVhdLDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1aW50
NjRfdCBudW1fc2xvdCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgaW50IHdpZHRoLCBpbnQgaGVpZ2h0LDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkb3VibGUgeCwgZG91YmxlIHksPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElucHV0TXVs
dGlUb3VjaFR5cGUgdHlwZSk7PGJyPg0KwqAvKiBjb25zb2xlcyAqLzxicj4NCjxicj4NCsKgI2Rl
ZmluZSBUWVBFX1FFTVVfQ09OU09MRSAmcXVvdDtxZW11LWNvbnNvbGUmcXVvdDs8YnI+DQpkaWZm
IC0tZ2l0IGEvdWkvY29uc29sZS5jIGIvdWkvY29uc29sZS5jPGJyPg0KaW5kZXggZTE3MzczMS4u
OGJjNmFkYiAxMDA2NDQ8YnI+DQotLS0gYS91aS9jb25zb2xlLmM8YnI+DQorKysgYi91aS9jb25z
b2xlLmM8YnI+DQpAQCAtMTYzNSw2ICsxNjM1LDcxIEBAIHN0YXRpYyBib29sIGNvbnNvbGVfY29t
cGF0aWJsZV93aXRoKFFlbXVDb25zb2xlICpjb24sPGJyPg0KwqAgwqAgwqByZXR1cm4gdHJ1ZTs8
YnI+DQrCoH08YnI+DQo8YnI+DQorYm9vbCBjb25zb2xlX2hhbmRsZV90b3VjaF9ldmVudChRZW11
Q29uc29sZSAqY29uLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBzdHJ1Y3QgdG91Y2hfc2xvdCB0b3VjaF9zbG90c1tJTlBVVF9FVkVOVF9TTE9U
U19NQVhdLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCB1aW50NjRfdCBudW1fc2xvdCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgaW50IHdpZHRoLCBpbnQgaGVpZ2h0LDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkb3VibGUgeCwgZG91Ymxl
IHksPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IElucHV0TXVsdGlUb3VjaFR5cGUgdHlwZSk8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2
PjxkaXY+QmV0dGVyIHdvdWxkIGJlIHRvIHVzZSBFcnJvciAqKmVycnAuPC9kaXY+PGRpdj48YnI+
PC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAw
cHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRp
bmctbGVmdDoxZXgiPg0KK3s8YnI+DQorwqAgwqAgc3RydWN0IHRvdWNoX3Nsb3QgKnNsb3Q7PGJy
Pg0KK8KgIMKgIGJvb2wgbmVlZHNfc3luYyA9IGZhbHNlOzxicj4NCivCoCDCoCBpbnQgdXBkYXRl
Ozxicj4NCivCoCDCoCBpbnQgaTs8YnI+DQorPGJyPg0KK8KgIMKgIGlmIChudW1fc2xvdCAmZ3Q7
PSBJTlBVVF9FVkVOVF9TTE9UU19NQVgpIHs8YnI+DQorwqAgwqAgwqAgwqAgd2Fybl9yZXBvcnQo
JnF1b3Q7dW5leHBlY3RlZCB0b3VjaCBzbG90IG51bWJlcjogJSAmcXVvdDsgUFJJZDY0JnF1b3Q7
ICZndDs9ICVkXG4mcXVvdDssPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIG51
bV9zbG90LCBJTlBVVF9FVkVOVF9TTE9UU19NQVgpOzxicj4NCivCoCDCoCDCoCDCoCByZXR1cm4g
RkFMU0U7PGJyPg0KK8KgIMKgIH08YnI+DQorPGJyPg0KK8KgIMKgIHNsb3QgPSAmYW1wO3RvdWNo
X3Nsb3RzW251bV9zbG90XTs8YnI+DQorwqAgwqAgc2xvdC0mZ3Q7eCA9IHg7PGJyPg0KK8KgIMKg
IHNsb3QtJmd0O3kgPSB5Ozxicj4NCis8YnI+DQorwqAgwqAgaWYgKHR5cGUgPT0gSU5QVVRfTVVM
VElfVE9VQ0hfVFlQRV9CRUdJTikgezxicj4NCivCoCDCoCDCoCDCoCBzbG90LSZndDt0cmFja2lu
Z19pZCA9IG51bV9zbG90Ozxicj4NCivCoCDCoCB9PGJyPg0KKzxicj4NCivCoCDCoCBmb3IgKGkg
PSAwOyBpICZsdDsgSU5QVVRfRVZFTlRfU0xPVFNfTUFYOyArK2kpIHs8YnI+DQorwqAgwqAgwqAg
wqAgaWYgKGkgPT0gbnVtX3Nsb3QpIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgdXBkYXRlID0g
dHlwZTs8YnI+DQorwqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAg
dXBkYXRlID0gSU5QVVRfTVVMVElfVE9VQ0hfVFlQRV9VUERBVEU7PGJyPg0KK8KgIMKgIMKgIMKg
IH08YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIHNsb3QgPSAmYW1wO3RvdWNoX3Nsb3RzW2ldOzxi
cj4NCis8YnI+DQorwqAgwqAgwqAgwqAgaWYgKHNsb3QtJmd0O3RyYWNraW5nX2lkID09IC0xKSB7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIGNvbnRpbnVlOzxicj4NCivCoCDCoCDCoCDCoCB9PGJy
Pg0KKzxicj4NCivCoCDCoCDCoCDCoCBpZiAodXBkYXRlID09IElOUFVUX01VTFRJX1RPVUNIX1RZ
UEVfRU5EKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHNsb3QtJmd0O3RyYWNraW5nX2lkID0g
LTE7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHFlbXVfaW5wdXRfcXVldWVfbXR0KGNvbiwgdXBk
YXRlLCBpLCBzbG90LSZndDt0cmFja2luZ19pZCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIG5l
ZWRzX3N5bmMgPSB0cnVlOzxicj4NCivCoCDCoCDCoCDCoCB9IGVsc2Ugezxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCBxZW11X2lucHV0X3F1ZXVlX210dChjb24sIHVwZGF0ZSwgaSwgc2xvdC0mZ3Q7
dHJhY2tpbmdfaWQpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBxZW11X2lucHV0X3F1ZXVlX2J0
bihjb24sIElOUFVUX0JVVFRPTl9UT1VDSCwgdHJ1ZSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IHFlbXVfaW5wdXRfcXVldWVfbXR0X2Ficyhjb24sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElOUFVUX0FYSVNfWCwgKGludCkgc2xv
dC0mZ3Q7eCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgMCwgd2lkdGgsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGksIHNsb3QtJmd0O3RyYWNraW5nX2lkKTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgcWVtdV9pbnB1dF9xdWV1ZV9tdHRfYWJzKGNvbiw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgSU5QVVRf
QVhJU19ZLCAoaW50KSBzbG90LSZndDt5LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAwLCBoZWlnaHQsPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGksIHNsb3QtJmd0O3Ry
YWNraW5nX2lkKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgbmVlZHNfc3luYyA9IHRydWU7PGJy
Pg0KK8KgIMKgIMKgIMKgIH08YnI+DQorwqAgwqAgfTxicj4NCis8YnI+DQorwqAgwqAgaWYgKG5l
ZWRzX3N5bmMpIHs8YnI+DQorwqAgwqAgwqAgwqAgcWVtdV9pbnB1dF9ldmVudF9zeW5jKCk7PGJy
Pg0KK8KgIMKgIH08YnI+DQorPGJyPg0KK8KgIMKgIHJldHVybiBUUlVFOzxicj4NCit9PGJyPg0K
Kzxicj4NCsKgdm9pZCBxZW11X2NvbnNvbGVfc2V0X2Rpc3BsYXlfZ2xfY3R4KFFlbXVDb25zb2xl
ICpjb24sIERpc3BsYXlHTEN0eCAqZ2wpPGJyPg0KwqB7PGJyPg0KwqAgwqAgwqAvKiBkaXNwbGF5
IGhhcyBvcGVuZ2wgc3VwcG9ydCAqLzxicj4NCmRpZmYgLS1naXQgYS91aS9ndGsuYyBiL3VpL2d0
ay5jPGJyPg0KaW5kZXggZTUwZjk1MC4uZWJiZDMwNCAxMDA2NDQ8YnI+DQotLS0gYS91aS9ndGsu
Yzxicj4NCisrKyBiL3VpL2d0ay5jPGJyPg0KQEAgLTEzMCwxMSArMTMwLDYgQEAgdHlwZWRlZiBz
dHJ1Y3QgVkNDaGFyZGV2IFZDQ2hhcmRldjs8YnI+DQrCoERFQ0xBUkVfSU5TVEFOQ0VfQ0hFQ0tF
UihWQ0NoYXJkZXYsIFZDX0NIQVJERVYsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgVFlQRV9DSEFSREVWX1ZDKTxicj4NCjxicj4NCi1zdHJ1Y3QgdG91Y2hfc2xv
dCB7PGJyPg0KLcKgIMKgIGludCB4Ozxicj4NCi3CoCDCoCBpbnQgeTs8YnI+DQotwqAgwqAgaW50
IHRyYWNraW5nX2lkOzxicj4NCi19Ozxicj4NCsKgc3RhdGljIHN0cnVjdCB0b3VjaF9zbG90IHRv
dWNoX3Nsb3RzW0lOUFVUX0VWRU5UX1NMT1RTX01BWF07PGJyPg0KPGJyPg0KwqBib29sIGd0a191
c2VfZ2xfYXJlYTs8YnI+DQpAQCAtMTA2OCwyNyArMTA2MywxMiBAQCBzdGF0aWMgZ2Jvb2xlYW4g
Z2RfdG91Y2hfZXZlbnQoR3RrV2lkZ2V0ICp3aWRnZXQsIEdka0V2ZW50VG91Y2ggKnRvdWNoLDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHZvaWQg
Km9wYXF1ZSk8YnI+DQrCoHs8YnI+DQrCoCDCoCDCoFZpcnR1YWxDb25zb2xlICp2YyA9IG9wYXF1
ZTs8YnI+DQotwqAgwqAgc3RydWN0IHRvdWNoX3Nsb3QgKnNsb3Q7PGJyPg0KwqAgwqAgwqB1aW50
NjRfdCBudW1fc2xvdCA9IEdQT0lOVEVSX1RPX1VJTlQodG91Y2gtJmd0O3NlcXVlbmNlKTs8YnI+
DQotwqAgwqAgYm9vbCBuZWVkc19zeW5jID0gZmFsc2U7PGJyPg0KLcKgIMKgIGludCB1cGRhdGU7
PGJyPg0KwqAgwqAgwqBpbnQgdHlwZSA9IC0xOzxicj4NCi3CoCDCoCBpbnQgaTs8YnI+DQotPGJy
Pg0KLcKgIMKgIGlmIChudW1fc2xvdCAmZ3Q7PSBJTlBVVF9FVkVOVF9TTE9UU19NQVgpIHs8YnI+
DQotwqAgwqAgwqAgwqAgd2Fybl9yZXBvcnQoJnF1b3Q7Z3RrOiB1bmV4cGVjdGVkIHRvdWNoIHNs
b3QgbnVtYmVyOiAlICZxdW90OyBQUklkNjQmcXVvdDsgJmd0Oz0gJWRcbiZxdW90Oyw8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgbnVtX3Nsb3QsIElOUFVUX0VWRU5UX1NMT1RT
X01BWCk7PGJyPg0KLcKgIMKgIMKgIMKgIHJldHVybiBGQUxTRTs8YnI+DQotwqAgwqAgfTxicj4N
Ci08YnI+DQotwqAgwqAgc2xvdCA9ICZhbXA7dG91Y2hfc2xvdHNbbnVtX3Nsb3RdOzxicj4NCi3C
oCDCoCBzbG90LSZndDt4ID0gdG91Y2gtJmd0O3g7PGJyPg0KLcKgIMKgIHNsb3QtJmd0O3kgPSB0
b3VjaC0mZ3Q7eTs8YnI+DQo8YnI+DQrCoCDCoCDCoHN3aXRjaCAodG91Y2gtJmd0O3R5cGUpIHs8
YnI+DQrCoCDCoCDCoGNhc2UgR0RLX1RPVUNIX0JFR0lOOjxicj4NCsKgIMKgIMKgIMKgIMKgdHlw
ZSA9IElOUFVUX01VTFRJX1RPVUNIX1RZUEVfQkVHSU47PGJyPg0KLcKgIMKgIMKgIMKgIHNsb3Qt
Jmd0O3RyYWNraW5nX2lkID0gbnVtX3Nsb3Q7PGJyPg0KwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+
DQrCoCDCoCDCoGNhc2UgR0RLX1RPVUNIX1VQREFURTo8YnI+DQrCoCDCoCDCoCDCoCDCoHR5cGUg
PSBJTlBVVF9NVUxUSV9UT1VDSF9UWVBFX1VQREFURTs8YnI+DQpAQCAtMTA5OSw0NSArMTA3OSwx
MyBAQCBzdGF0aWMgZ2Jvb2xlYW4gZ2RfdG91Y2hfZXZlbnQoR3RrV2lkZ2V0ICp3aWRnZXQsIEdk
a0V2ZW50VG91Y2ggKnRvdWNoLDxicj4NCsKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KwqAgwqAg
wqBkZWZhdWx0Ojxicj4NCsKgIMKgIMKgIMKgIMKgd2Fybl9yZXBvcnQoJnF1b3Q7Z3RrOiB1bmV4
cGVjdGVkIHRvdWNoIGV2ZW50IHR5cGVcbiZxdW90Oyk7PGJyPg0KK8KgIMKgIMKgIMKgIHJldHVy
biBGQUxTRTs8YnI+DQrCoCDCoCDCoH08YnI+DQo8YnI+DQotwqAgwqAgZm9yIChpID0gMDsgaSAm
bHQ7IElOUFVUX0VWRU5UX1NMT1RTX01BWDsgKytpKSB7PGJyPg0KLcKgIMKgIMKgIMKgIGlmIChp
ID09IG51bV9zbG90KSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHVwZGF0ZSA9IHR5cGU7PGJy
Pg0KLcKgIMKgIMKgIMKgIH0gZWxzZSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIHVwZGF0ZSA9
IElOUFVUX01VTFRJX1RPVUNIX1RZUEVfVVBEQVRFOzxicj4NCi3CoCDCoCDCoCDCoCB9PGJyPg0K
LTxicj4NCi3CoCDCoCDCoCDCoCBzbG90ID0gJmFtcDt0b3VjaF9zbG90c1tpXTs8YnI+DQotPGJy
Pg0KLcKgIMKgIMKgIMKgIGlmIChzbG90LSZndDt0cmFja2luZ19pZCA9PSAtMSkgezxicj4NCi3C
oCDCoCDCoCDCoCDCoCDCoCBjb250aW51ZTs8YnI+DQotwqAgwqAgwqAgwqAgfTxicj4NCi08YnI+
DQotwqAgwqAgwqAgwqAgaWYgKHVwZGF0ZSA9PSBJTlBVVF9NVUxUSV9UT1VDSF9UWVBFX0VORCkg
ezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBzbG90LSZndDt0cmFja2luZ19pZCA9IC0xOzxicj4N
Ci3CoCDCoCDCoCDCoCDCoCDCoCBxZW11X2lucHV0X3F1ZXVlX210dCh2Yy0mZ3Q7Z2Z4LmRjbC5j
b24sIHVwZGF0ZSwgaSwgc2xvdC0mZ3Q7dHJhY2tpbmdfaWQpOzxicj4NCi3CoCDCoCDCoCDCoCDC
oCDCoCBuZWVkc19zeW5jID0gdHJ1ZTs8YnI+DQotwqAgwqAgwqAgwqAgfSBlbHNlIHs8YnI+DQot
wqAgwqAgwqAgwqAgwqAgwqAgcWVtdV9pbnB1dF9xdWV1ZV9tdHQodmMtJmd0O2dmeC5kY2wuY29u
LCB1cGRhdGUsIGksIHNsb3QtJmd0O3RyYWNraW5nX2lkKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAg
wqAgcWVtdV9pbnB1dF9xdWV1ZV9idG4odmMtJmd0O2dmeC5kY2wuY29uLCBJTlBVVF9CVVRUT05f
VE9VQ0gsIHRydWUpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBxZW11X2lucHV0X3F1ZXVlX210
dF9hYnModmMtJmd0O2dmeC5kY2wuY29uLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoElOUFVUX0FYSVNfWCwgKGludCkgc2xvdC0m
Z3Q7eCw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAwLCBzdXJmYWNlX3dpZHRoKHZjLSZndDtnZnguZHMpLDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGksIHNsb3Qt
Jmd0O3RyYWNraW5nX2lkKTs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgcWVtdV9pbnB1dF9xdWV1
ZV9tdHRfYWJzKHZjLSZndDtnZnguZGNsLmNvbiw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBJTlBVVF9BWElTX1ksIChpbnQpIHNs
b3QtJmd0O3ksPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgMCwgc3VyZmFjZV9oZWlnaHQodmMtJmd0O2dmeC5kcyksPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaSwg
c2xvdC0mZ3Q7dHJhY2tpbmdfaWQpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBuZWVkc19zeW5j
ID0gdHJ1ZTs8YnI+DQotwqAgwqAgwqAgwqAgfTxicj4NCi3CoCDCoCB9PGJyPg0KLTxicj4NCi3C
oCDCoCBpZiAobmVlZHNfc3luYykgezxicj4NCi3CoCDCoCDCoCDCoCBxZW11X2lucHV0X2V2ZW50
X3N5bmMoKTs8YnI+DQotwqAgwqAgfTxicj4NCi08YnI+DQotwqAgwqAgcmV0dXJuIFRSVUU7PGJy
Pg0KK8KgIMKgIHJldHVybiBjb25zb2xlX2hhbmRsZV90b3VjaF9ldmVudCh2Yy0mZ3Q7Z2Z4LmRj
bC5jb24sIHRvdWNoX3Nsb3RzLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBudW1fc2xvdCwgc3VyZmFjZV93aWR0aCh2Yy0mZ3Q7
Z2Z4LmRzKSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgc3VyZmFjZV9oZWlnaHQodmMtJmd0O2dmeC5kcyksIHRvdWNoLSZndDt4
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCB0b3VjaC0mZ3Q7eSwgdHlwZSk7PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rp
dj48ZGl2PlRoZW4gd2UgY2FuIGNhbGwgd2l0aCAmYW1wO2Vycm9yX3dhcm4gZm9ybSBoZXJlLsKg
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5vdGhlcndpc2UsIGxndG08YnI+PC9kaXY+PC9kaXY+
PGJyPjxzcGFuIGNsYXNzPSJnbWFpbF9zaWduYXR1cmVfcHJlZml4Ij4tLSA8L3NwYW4+PGJyPjxk
aXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9zaWduYXR1cmUiPk1hcmMtQW5kcsOpIEx1cmVhdTxi
cj48L2Rpdj48L2Rpdj4NCg==
--000000000000f9560405fe0234c6--

