Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AAA7313B4
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 11:27:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9jGK-00052Q-44; Thu, 15 Jun 2023 05:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q9jGI-00052I-23
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 05:27:26 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q9jGF-0003WP-MA
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 05:27:25 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f762b3227dso727242e87.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jun 2023 02:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686821241; x=1689413241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L+Z2E/QmeiB5PJ7zmC1zfEoPAFJRo7QusDKduLK77iM=;
 b=aS1hTb2ujmDEvz/jOyo7z74cCZbkEMxHyN4IL4izR0111TCaMT05Gq1kI9ASpDoMCm
 ZWnGENXWELB3KLxPhMMfCXlUxBeDH4LeEaw5zCzui4OxJ5Ap/4beJJZpM6bPWKtF5Dap
 X1C/Xp2s4bxBjQeWi8Fcu7PGC2ZQXtoicecC9YRO+PUjNFBOG/T2jlMHuVpVChqqAh7W
 E89YbN5Y/KeOPZcyaYGYubNF6VmJJZSKZoiGmDduJ77D/F6DuayXWijQo2/HWyfYXLf5
 H/nGEaOwIvprq3D/mvzlbpZkGWfHlnZuBDhQIvzjtzGBovpGCUNEe5EGjmImxXPF520Z
 8WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686821241; x=1689413241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L+Z2E/QmeiB5PJ7zmC1zfEoPAFJRo7QusDKduLK77iM=;
 b=IZcwZIDUq1XBuFE/Nv66+F2/nB16+LWxZsaZVGTapDcNcV57ORvebxY2SAAQQImhrA
 1D9WqYMt33I919NnlNLbKXw7/J6DxXmGA4FKsAqdWIWr3PagM8ss35CALPkOWDnUQpVS
 8eWstcVakC2IWhlL/JlWBJisr6SyqiRZt1S1vSsRT3pKeupjyVa0SvFRK3Pml9QASPUo
 scSvfw+4cUXBPPFU6GVzLHCVf/sMcQUzC/2loLdpSHsyCEnVhtKLXxgluFFZUC1pYf9W
 1v5JafcgZawXDyc+sqf7rO0B+vsttvMbdZRJmWGJ5SdNsLl9ZffJOYfSSBB6rvJJjJle
 nJLA==
X-Gm-Message-State: AC+VfDzPWQJh4t+scT3ShGuAss3FZFW1d7A2OndviJPJZF9XbokPNcLo
 4utJauBSHdSZVyHZ6qKI4PaJQMTmYxbVkzr2aQY=
X-Google-Smtp-Source: ACHHUZ61yP66Thw9Z0L6fVsO6mLH4g5eu7VVG6V8ognmNx7f3y7NTn5xj0CDiwOeEK3SurnPlTRYTqAfCi4OOCmZ2R4=
X-Received: by 2002:a05:6512:536:b0:4f6:55:7d73 with SMTP id
 o22-20020a056512053600b004f600557d73mr1410713lfc.25.1686821241106; Thu, 15
 Jun 2023 02:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230615090635.160734-1-belmouss@redhat.com>
In-Reply-To: <20230615090635.160734-1-belmouss@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 15 Jun 2023 11:27:01 +0200
Message-ID: <CAJ+F1CKWTK+wm-ezoWUv87GEEZnepyO49BtZkz1EuMwFWsvAjg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ui/touch: Move event handling to a common helper
To: Bilal Elmoussaoui <belmouss@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e03b1905fe27ac85"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lf1-x129.google.com
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

--000000000000e03b1905fe27ac85
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 11:07=E2=80=AFAM Bilal Elmoussaoui <belmouss@redhat=
.com>
wrote:

> To share code between the GTK and DBus UI bakcends
> see the next commit for details
>
> Signed-off-by: Bilal Elmoussaoui <belmouss@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  include/ui/console.h | 15 ++++++++++
>  ui/console.c         | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  ui/gtk.c             | 61 ++++-------------------------------------
>  3 files changed, 85 insertions(+), 56 deletions(-)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index ae5ec46..2093e2a 100644
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
> @@ -95,6 +96,20 @@ bool kbd_put_qcode_console(QemuConsole *s, int qcode,
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
> +void console_handle_touch_event(QemuConsole *con,
> +                                struct touch_slot
> touch_slots[INPUT_EVENT_SLOTS_MAX],
> +                                uint64_t num_slot,
> +                                int width, int height,
> +                                double x, double y,
> +                                InputMultiTouchType type,
> +                                Error **errp);
>  /* consoles */
>
>  #define TYPE_QEMU_CONSOLE "qemu-console"
> diff --git a/ui/console.c b/ui/console.c
> index e173731..63e952e 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1635,6 +1635,71 @@ static bool console_compatible_with(QemuConsole
> *con,
>      return true;
>  }
>
> +void console_handle_touch_event(QemuConsole *con,
> +                                struct touch_slot
> touch_slots[INPUT_EVENT_SLOTS_MAX],
> +                                uint64_t num_slot,
> +                                int width, int height,
> +                                double x, double y,
> +                                InputMultiTouchType type,
> +                                Error **errp)
> +{
> +    struct touch_slot *slot;
> +    bool needs_sync =3D false;
> +    int update;
> +    int i;
> +
> +    if (num_slot >=3D INPUT_EVENT_SLOTS_MAX) {
> +        error_setg(errp,
> +                   "Unexpected touch slot number: % " PRId64" >=3D %d",
> +                   num_slot, INPUT_EVENT_SLOTS_MAX);
> +        return;
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
> +}
> +
>  void qemu_console_set_display_gl_ctx(QemuConsole *con, DisplayGLCtx *gl)
>  {
>      /* display has opengl support */
> diff --git a/ui/gtk.c b/ui/gtk.c
> index e50f950..e09e164 100644
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
> @@ -1099,44 +1079,13 @@ static gboolean gd_touch_event(GtkWidget *widget,
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
> +    console_handle_touch_event(vc->gfx.dcl.con, touch_slots,
> +                               num_slot, surface_width(vc->gfx.ds),
> +                               surface_height(vc->gfx.ds), touch->x,
> +                               touch->y, type, &error_warn);
>      return TRUE;
>  }
>
> --
> 2.40.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000e03b1905fe27ac85
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFRodSwgSnVu
IDE1LCAyMDIzIGF0IDExOjA34oCvQU0gQmlsYWwgRWxtb3Vzc2FvdWkgJmx0OzxhIGhyZWY9Im1h
aWx0bzpiZWxtb3Vzc0ByZWRoYXQuY29tIj5iZWxtb3Vzc0ByZWRoYXQuY29tPC9hPiZndDsgd3Jv
dGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0
KTtwYWRkaW5nLWxlZnQ6MWV4Ij5UbyBzaGFyZSBjb2RlIGJldHdlZW4gdGhlIEdUSyBhbmQgREJ1
cyBVSSBiYWtjZW5kczxicj4NCnNlZSB0aGUgbmV4dCBjb21taXQgZm9yIGRldGFpbHM8YnI+DQo8
YnI+DQpTaWduZWQtb2ZmLWJ5OiBCaWxhbCBFbG1vdXNzYW91aSAmbHQ7PGEgaHJlZj0ibWFpbHRv
OmJlbG1vdXNzQHJlZGhhdC5jb20iIHRhcmdldD0iX2JsYW5rIj5iZWxtb3Vzc0ByZWRoYXQuY29t
PC9hPiZndDs8YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+UmV2aWV3ZWQtYnk6
IE1hcmMtQW5kcsOpIEx1cmVhdSAmbHQ7PGEgaHJlZj0ibWFpbHRvOm1hcmNhbmRyZS5sdXJlYXVA
cmVkaGF0LmNvbSI+bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPC9hPiZndDs8L2Rpdj48ZGl2
PsKgPGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdp
bjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0
KTtwYWRkaW5nLWxlZnQ6MWV4Ij4NCi0tLTxicj4NCsKgaW5jbHVkZS91aS9jb25zb2xlLmggfCAx
NSArKysrKysrKysrPGJyPg0KwqB1aS9jb25zb2xlLmPCoCDCoCDCoCDCoCDCoHwgNjUgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKys8YnI+DQrCoHVpL2d0ay5jwqAg
wqAgwqAgwqAgwqAgwqAgwqB8IDYxICsrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tPGJyPg0KwqAzIGZpbGVzIGNoYW5nZWQsIDg1IGluc2VydGlvbnMoKyksIDU2IGRlbGV0
aW9ucygtKTxicj4NCjxicj4NCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VpL2NvbnNvbGUuaCBiL2lu
Y2x1ZGUvdWkvY29uc29sZS5oPGJyPg0KaW5kZXggYWU1ZWM0Ni4uMjA5M2UyYSAxMDA2NDQ8YnI+
DQotLS0gYS9pbmNsdWRlL3VpL2NvbnNvbGUuaDxicj4NCisrKyBiL2luY2x1ZGUvdWkvY29uc29s
ZS5oPGJyPg0KQEAgLTUsNiArNSw3IEBAPGJyPg0KwqAjaW5jbHVkZSAmcXVvdDtxb20vb2JqZWN0
LmgmcXVvdDs8YnI+DQrCoCNpbmNsdWRlICZxdW90O3FlbXUvbm90aWZ5LmgmcXVvdDs8YnI+DQrC
oCNpbmNsdWRlICZxdW90O3FhcGkvcWFwaS10eXBlcy11aS5oJnF1b3Q7PGJyPg0KKyNpbmNsdWRl
ICZxdW90O3VpL2lucHV0LmgmcXVvdDs8YnI+DQo8YnI+DQrCoCNpZmRlZiBDT05GSUdfT1BFTkdM
PGJyPg0KwqAjIGluY2x1ZGUgJmx0O2Vwb3h5L2dsLmgmZ3Q7PGJyPg0KQEAgLTk1LDYgKzk2LDIw
IEBAIGJvb2wga2JkX3B1dF9xY29kZV9jb25zb2xlKFFlbXVDb25zb2xlICpzLCBpbnQgcWNvZGUs
IGJvb2wgY3RybCk7PGJyPg0KwqB2b2lkIGtiZF9wdXRfc3RyaW5nX2NvbnNvbGUoUWVtdUNvbnNv
bGUgKnMsIGNvbnN0IGNoYXIgKnN0ciwgaW50IGxlbik7PGJyPg0KwqB2b2lkIGtiZF9wdXRfa2V5
c3ltKGludCBrZXlzeW0pOzxicj4NCjxicj4NCisvKiBUb3VjaCBkZXZpY2VzICovPGJyPg0KK3R5
cGVkZWYgc3RydWN0IHRvdWNoX3Nsb3Qgezxicj4NCivCoCDCoCBpbnQgeDs8YnI+DQorwqAgwqAg
aW50IHk7PGJyPg0KK8KgIMKgIGludCB0cmFja2luZ19pZDs8YnI+DQorfSB0b3VjaF9zbG90Ozxi
cj4NCis8YnI+DQordm9pZCBjb25zb2xlX2hhbmRsZV90b3VjaF9ldmVudChRZW11Q29uc29sZSAq
Y29uLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBzdHJ1Y3QgdG91Y2hfc2xvdCB0b3VjaF9zbG90c1tJTlBVVF9FVkVOVF9TTE9UU19NQVhdLDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1aW50
NjRfdCBudW1fc2xvdCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgaW50IHdpZHRoLCBpbnQgaGVpZ2h0LDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBkb3VibGUgeCwgZG91YmxlIHksPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIElucHV0TXVs
dGlUb3VjaFR5cGUgdHlwZSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgRXJyb3IgKiplcnJwKTs8YnI+DQrCoC8qIGNvbnNvbGVzICovPGJyPg0K
PGJyPg0KwqAjZGVmaW5lIFRZUEVfUUVNVV9DT05TT0xFICZxdW90O3FlbXUtY29uc29sZSZxdW90
Ozxicj4NCmRpZmYgLS1naXQgYS91aS9jb25zb2xlLmMgYi91aS9jb25zb2xlLmM8YnI+DQppbmRl
eCBlMTczNzMxLi42M2U5NTJlIDEwMDY0NDxicj4NCi0tLSBhL3VpL2NvbnNvbGUuYzxicj4NCisr
KyBiL3VpL2NvbnNvbGUuYzxicj4NCkBAIC0xNjM1LDYgKzE2MzUsNzEgQEAgc3RhdGljIGJvb2wg
Y29uc29sZV9jb21wYXRpYmxlX3dpdGgoUWVtdUNvbnNvbGUgKmNvbiw8YnI+DQrCoCDCoCDCoHJl
dHVybiB0cnVlOzxicj4NCsKgfTxicj4NCjxicj4NCit2b2lkIGNvbnNvbGVfaGFuZGxlX3RvdWNo
X2V2ZW50KFFlbXVDb25zb2xlICpjb24sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0cnVjdCB0b3VjaF9zbG90IHRvdWNoX3Nsb3RzW0lOUFVU
X0VWRU5UX1NMT1RTX01BWF0sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIHVpbnQ2NF90IG51bV9zbG90LDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpbnQgd2lkdGgsIGludCBoZWlnaHQsPGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGRvdWJs
ZSB4LCBkb3VibGUgeSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgSW5wdXRNdWx0aVRvdWNoVHlwZSB0eXBlLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBFcnJvciAqKmVycnApPGJyPg0KK3s8
YnI+DQorwqAgwqAgc3RydWN0IHRvdWNoX3Nsb3QgKnNsb3Q7PGJyPg0KK8KgIMKgIGJvb2wgbmVl
ZHNfc3luYyA9IGZhbHNlOzxicj4NCivCoCDCoCBpbnQgdXBkYXRlOzxicj4NCivCoCDCoCBpbnQg
aTs8YnI+DQorPGJyPg0KK8KgIMKgIGlmIChudW1fc2xvdCAmZ3Q7PSBJTlBVVF9FVkVOVF9TTE9U
U19NQVgpIHs8YnI+DQorwqAgwqAgwqAgwqAgZXJyb3Jfc2V0ZyhlcnJwLDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZxdW90O1VuZXhwZWN0ZWQgdG91Y2ggc2xvdCBudW1iZXI6
ICUgJnF1b3Q7IFBSSWQ2NCZxdW90OyAmZ3Q7PSAlZCZxdW90Oyw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBudW1fc2xvdCwgSU5QVVRfRVZFTlRfU0xPVFNfTUFYKTs8YnI+DQor
wqAgwqAgwqAgwqAgcmV0dXJuOzxicj4NCivCoCDCoCB9PGJyPg0KKzxicj4NCivCoCDCoCBzbG90
ID0gJmFtcDt0b3VjaF9zbG90c1tudW1fc2xvdF07PGJyPg0KK8KgIMKgIHNsb3QtJmd0O3ggPSB4
Ozxicj4NCivCoCDCoCBzbG90LSZndDt5ID0geTs8YnI+DQorPGJyPg0KK8KgIMKgIGlmICh0eXBl
ID09IElOUFVUX01VTFRJX1RPVUNIX1RZUEVfQkVHSU4pIHs8YnI+DQorwqAgwqAgwqAgwqAgc2xv
dC0mZ3Q7dHJhY2tpbmdfaWQgPSBudW1fc2xvdDs8YnI+DQorwqAgwqAgfTxicj4NCis8YnI+DQor
wqAgwqAgZm9yIChpID0gMDsgaSAmbHQ7IElOUFVUX0VWRU5UX1NMT1RTX01BWDsgKytpKSB7PGJy
Pg0KK8KgIMKgIMKgIMKgIGlmIChpID09IG51bV9zbG90KSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIHVwZGF0ZSA9IHR5cGU7PGJyPg0KK8KgIMKgIMKgIMKgIH0gZWxzZSB7PGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIHVwZGF0ZSA9IElOUFVUX01VTFRJX1RPVUNIX1RZUEVfVVBEQVRFOzxicj4N
CivCoCDCoCDCoCDCoCB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoCBzbG90ID0gJmFtcDt0b3Vj
aF9zbG90c1tpXTs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgIGlmIChzbG90LSZndDt0cmFja2lu
Z19pZCA9PSAtMSkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBjb250aW51ZTs8YnI+DQorwqAg
wqAgwqAgwqAgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqAgaWYgKHVwZGF0ZSA9PSBJTlBVVF9N
VUxUSV9UT1VDSF9UWVBFX0VORCkgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBzbG90LSZndDt0
cmFja2luZ19pZCA9IC0xOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCBxZW11X2lucHV0X3F1ZXVl
X210dChjb24sIHVwZGF0ZSwgaSwgc2xvdC0mZ3Q7dHJhY2tpbmdfaWQpOzxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCBuZWVkc19zeW5jID0gdHJ1ZTs8YnI+DQorwqAgwqAgwqAgwqAgfSBlbHNlIHs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcWVtdV9pbnB1dF9xdWV1ZV9tdHQoY29uLCB1cGRhdGUs
IGksIHNsb3QtJmd0O3RyYWNraW5nX2lkKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgcWVtdV9p
bnB1dF9xdWV1ZV9idG4oY29uLCBJTlBVVF9CVVRUT05fVE9VQ0gsIHRydWUpOzxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCBxZW11X2lucHV0X3F1ZXVlX210dF9hYnMoY29uLDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBJTlBVVF9BWElT
X1gsIChpbnQpIHNsb3QtJmd0O3gsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDAsIHdpZHRoLDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpLCBzbG90LSZndDt0cmFja2lu
Z19pZCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIHFlbXVfaW5wdXRfcXVldWVfbXR0X2Ficyhj
b24sPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIElOUFVUX0FYSVNfWSwgKGludCkgc2xvdC0mZ3Q7eSw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMCwgaGVpZ2h0LDxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBp
LCBzbG90LSZndDt0cmFja2luZ19pZCk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIG5lZWRzX3N5
bmMgPSB0cnVlOzxicj4NCivCoCDCoCDCoCDCoCB9PGJyPg0KK8KgIMKgIH08YnI+DQorPGJyPg0K
K8KgIMKgIGlmIChuZWVkc19zeW5jKSB7PGJyPg0KK8KgIMKgIMKgIMKgIHFlbXVfaW5wdXRfZXZl
bnRfc3luYygpOzxicj4NCivCoCDCoCB9PGJyPg0KK308YnI+DQorPGJyPg0KwqB2b2lkIHFlbXVf
Y29uc29sZV9zZXRfZGlzcGxheV9nbF9jdHgoUWVtdUNvbnNvbGUgKmNvbiwgRGlzcGxheUdMQ3R4
ICpnbCk8YnI+DQrCoHs8YnI+DQrCoCDCoCDCoC8qIGRpc3BsYXkgaGFzIG9wZW5nbCBzdXBwb3J0
ICovPGJyPg0KZGlmZiAtLWdpdCBhL3VpL2d0ay5jIGIvdWkvZ3RrLmM8YnI+DQppbmRleCBlNTBm
OTUwLi5lMDllMTY0IDEwMDY0NDxicj4NCi0tLSBhL3VpL2d0ay5jPGJyPg0KKysrIGIvdWkvZ3Rr
LmM8YnI+DQpAQCAtMTMwLDExICsxMzAsNiBAQCB0eXBlZGVmIHN0cnVjdCBWQ0NoYXJkZXYgVkND
aGFyZGV2Ozxicj4NCsKgREVDTEFSRV9JTlNUQU5DRV9DSEVDS0VSKFZDQ2hhcmRldiwgVkNfQ0hB
UkRFViw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBUWVBFX0NI
QVJERVZfVkMpPGJyPg0KPGJyPg0KLXN0cnVjdCB0b3VjaF9zbG90IHs8YnI+DQotwqAgwqAgaW50
IHg7PGJyPg0KLcKgIMKgIGludCB5Ozxicj4NCi3CoCDCoCBpbnQgdHJhY2tpbmdfaWQ7PGJyPg0K
LX07PGJyPg0KwqBzdGF0aWMgc3RydWN0IHRvdWNoX3Nsb3QgdG91Y2hfc2xvdHNbSU5QVVRfRVZF
TlRfU0xPVFNfTUFYXTs8YnI+DQo8YnI+DQrCoGJvb2wgZ3RrX3VzZV9nbF9hcmVhOzxicj4NCkBA
IC0xMDY4LDI3ICsxMDYzLDEyIEBAIHN0YXRpYyBnYm9vbGVhbiBnZF90b3VjaF9ldmVudChHdGtX
aWRnZXQgKndpZGdldCwgR2RrRXZlbnRUb3VjaCAqdG91Y2gsPGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgdm9pZCAqb3BhcXVlKTxicj4NCsKgezxi
cj4NCsKgIMKgIMKgVmlydHVhbENvbnNvbGUgKnZjID0gb3BhcXVlOzxicj4NCi3CoCDCoCBzdHJ1
Y3QgdG91Y2hfc2xvdCAqc2xvdDs8YnI+DQrCoCDCoCDCoHVpbnQ2NF90IG51bV9zbG90ID0gR1BP
SU5URVJfVE9fVUlOVCh0b3VjaC0mZ3Q7c2VxdWVuY2UpOzxicj4NCi3CoCDCoCBib29sIG5lZWRz
X3N5bmMgPSBmYWxzZTs8YnI+DQotwqAgwqAgaW50IHVwZGF0ZTs8YnI+DQrCoCDCoCDCoGludCB0
eXBlID0gLTE7PGJyPg0KLcKgIMKgIGludCBpOzxicj4NCi08YnI+DQotwqAgwqAgaWYgKG51bV9z
bG90ICZndDs9IElOUFVUX0VWRU5UX1NMT1RTX01BWCkgezxicj4NCi3CoCDCoCDCoCDCoCB3YXJu
X3JlcG9ydCgmcXVvdDtndGs6IHVuZXhwZWN0ZWQgdG91Y2ggc2xvdCBudW1iZXI6ICUgJnF1b3Q7
IFBSSWQ2NCZxdW90OyAmZ3Q7PSAlZFxuJnF1b3Q7LDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBudW1fc2xvdCwgSU5QVVRfRVZFTlRfU0xPVFNfTUFYKTs8YnI+DQotwqAgwqAg
wqAgwqAgcmV0dXJuIEZBTFNFOzxicj4NCi3CoCDCoCB9PGJyPg0KLTxicj4NCi3CoCDCoCBzbG90
ID0gJmFtcDt0b3VjaF9zbG90c1tudW1fc2xvdF07PGJyPg0KLcKgIMKgIHNsb3QtJmd0O3ggPSB0
b3VjaC0mZ3Q7eDs8YnI+DQotwqAgwqAgc2xvdC0mZ3Q7eSA9IHRvdWNoLSZndDt5Ozxicj4NCjxi
cj4NCsKgIMKgIMKgc3dpdGNoICh0b3VjaC0mZ3Q7dHlwZSkgezxicj4NCsKgIMKgIMKgY2FzZSBH
REtfVE9VQ0hfQkVHSU46PGJyPg0KwqAgwqAgwqAgwqAgwqB0eXBlID0gSU5QVVRfTVVMVElfVE9V
Q0hfVFlQRV9CRUdJTjs8YnI+DQotwqAgwqAgwqAgwqAgc2xvdC0mZ3Q7dHJhY2tpbmdfaWQgPSBu
dW1fc2xvdDs8YnI+DQrCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCsKgIMKgIMKgY2FzZSBHREtf
VE9VQ0hfVVBEQVRFOjxicj4NCsKgIMKgIMKgIMKgIMKgdHlwZSA9IElOUFVUX01VTFRJX1RPVUNI
X1RZUEVfVVBEQVRFOzxicj4NCkBAIC0xMDk5LDQ0ICsxMDc5LDEzIEBAIHN0YXRpYyBnYm9vbGVh
biBnZF90b3VjaF9ldmVudChHdGtXaWRnZXQgKndpZGdldCwgR2RrRXZlbnRUb3VjaCAqdG91Y2gs
PGJyPg0KwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQrCoCDCoCDCoGRlZmF1bHQ6PGJyPg0KwqAg
wqAgwqAgwqAgwqB3YXJuX3JlcG9ydCgmcXVvdDtndGs6IHVuZXhwZWN0ZWQgdG91Y2ggZXZlbnQg
dHlwZVxuJnF1b3Q7KTs8YnI+DQorwqAgwqAgwqAgwqAgcmV0dXJuIEZBTFNFOzxicj4NCsKgIMKg
IMKgfTxicj4NCjxicj4NCi3CoCDCoCBmb3IgKGkgPSAwOyBpICZsdDsgSU5QVVRfRVZFTlRfU0xP
VFNfTUFYOyArK2kpIHs8YnI+DQotwqAgwqAgwqAgwqAgaWYgKGkgPT0gbnVtX3Nsb3QpIHs8YnI+
DQotwqAgwqAgwqAgwqAgwqAgwqAgdXBkYXRlID0gdHlwZTs8YnI+DQotwqAgwqAgwqAgwqAgfSBl
bHNlIHs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgdXBkYXRlID0gSU5QVVRfTVVMVElfVE9VQ0hf
VFlQRV9VUERBVEU7PGJyPg0KLcKgIMKgIMKgIMKgIH08YnI+DQotPGJyPg0KLcKgIMKgIMKgIMKg
IHNsb3QgPSAmYW1wO3RvdWNoX3Nsb3RzW2ldOzxicj4NCi08YnI+DQotwqAgwqAgwqAgwqAgaWYg
KHNsb3QtJmd0O3RyYWNraW5nX2lkID09IC0xKSB7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIGNv
bnRpbnVlOzxicj4NCi3CoCDCoCDCoCDCoCB9PGJyPg0KLTxicj4NCi3CoCDCoCDCoCDCoCBpZiAo
dXBkYXRlID09IElOUFVUX01VTFRJX1RPVUNIX1RZUEVfRU5EKSB7PGJyPg0KLcKgIMKgIMKgIMKg
IMKgIMKgIHNsb3QtJmd0O3RyYWNraW5nX2lkID0gLTE7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKg
IHFlbXVfaW5wdXRfcXVldWVfbXR0KHZjLSZndDtnZnguZGNsLmNvbiwgdXBkYXRlLCBpLCBzbG90
LSZndDt0cmFja2luZ19pZCk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIG5lZWRzX3N5bmMgPSB0
cnVlOzxicj4NCi3CoCDCoCDCoCDCoCB9IGVsc2Ugezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBx
ZW11X2lucHV0X3F1ZXVlX210dCh2Yy0mZ3Q7Z2Z4LmRjbC5jb24sIHVwZGF0ZSwgaSwgc2xvdC0m
Z3Q7dHJhY2tpbmdfaWQpOzxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBxZW11X2lucHV0X3F1ZXVl
X2J0bih2Yy0mZ3Q7Z2Z4LmRjbC5jb24sIElOUFVUX0JVVFRPTl9UT1VDSCwgdHJ1ZSk7PGJyPg0K
LcKgIMKgIMKgIMKgIMKgIMKgIHFlbXVfaW5wdXRfcXVldWVfbXR0X2Ficyh2Yy0mZ3Q7Z2Z4LmRj
bC5jb24sPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgSU5QVVRfQVhJU19YLCAoaW50KSBzbG90LSZndDt4LDxicj4NCi3CoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDAsIHN1cmZh
Y2Vfd2lkdGgodmMtJmd0O2dmeC5kcyksPGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaSwgc2xvdC0mZ3Q7dHJhY2tpbmdfaWQpOzxi
cj4NCi3CoCDCoCDCoCDCoCDCoCDCoCBxZW11X2lucHV0X3F1ZXVlX210dF9hYnModmMtJmd0O2dm
eC5kY2wuY29uLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoElOUFVUX0FYSVNfWSwgKGludCkgc2xvdC0mZ3Q7eSw8YnI+DQotwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAwLCBz
dXJmYWNlX2hlaWdodCh2Yy0mZ3Q7Z2Z4LmRzKSw8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpLCBzbG90LSZndDt0cmFja2luZ19p
ZCk7PGJyPg0KLcKgIMKgIMKgIMKgIMKgIMKgIG5lZWRzX3N5bmMgPSB0cnVlOzxicj4NCi3CoCDC
oCDCoCDCoCB9PGJyPg0KLcKgIMKgIH08YnI+DQotPGJyPg0KLcKgIMKgIGlmIChuZWVkc19zeW5j
KSB7PGJyPg0KLcKgIMKgIMKgIMKgIHFlbXVfaW5wdXRfZXZlbnRfc3luYygpOzxicj4NCi3CoCDC
oCB9PGJyPg0KLTxicj4NCivCoCDCoCBjb25zb2xlX2hhbmRsZV90b3VjaF9ldmVudCh2Yy0mZ3Q7
Z2Z4LmRjbC5jb24sIHRvdWNoX3Nsb3RzLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoG51bV9zbG90LCBzdXJmYWNlX3dpZHRoKHZjLSZndDtnZngu
ZHMpLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHN1cmZhY2VfaGVpZ2h0KHZjLSZndDtnZnguZHMpLCB0b3VjaC0mZ3Q7eCw8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB0b3VjaC0mZ3Q7eSwgdHlw
ZSwgJmFtcDtlcnJvcl93YXJuKTs8YnI+DQrCoCDCoCDCoHJldHVybiBUUlVFOzxicj4NCsKgfTxi
cj4NCjxicj4NCi0tIDxicj4NCjIuNDAuMTxicj4NCjxicj4NCjxicj4NCjwvYmxvY2txdW90ZT48
L2Rpdj48YnIgY2xlYXI9ImFsbCI+PGJyPjxzcGFuIGNsYXNzPSJnbWFpbF9zaWduYXR1cmVfcHJl
Zml4Ij4tLSA8L3NwYW4+PGJyPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9zaWduYXR1cmUi
Pk1hcmMtQW5kcsOpIEx1cmVhdTxicj48L2Rpdj48L2Rpdj4NCg==
--000000000000e03b1905fe27ac85--

