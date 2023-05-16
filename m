Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 810547051CA
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 17:15:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pywOd-0006Hu-No; Tue, 16 May 2023 11:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pywOa-0006Du-Q6
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pywOW-0004aD-M2
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684250119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a3JXF2DFKy4bpAq6R9EGgb4KNHEigIeAWcX6kxRrOp8=;
 b=HSP1MMGndgG/3Npi34gy1u4nuoZ4+3ioEtOpg7nC0TRYaqYdPpeonXtQWld6KkbLdQJQsK
 3zKJ4kknmmVKKghUg9JN31M1jlEad3w58BTyklLJxILU1vC7J5RBx7TARK0BKvI9rWOTGz
 02iFcQXm9AdX53jE/rDa0utt5j+l0ac=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-9YLNAz8hN-O081yj7-_9Ow-1; Tue, 16 May 2023 11:15:18 -0400
X-MC-Unique: 9YLNAz8hN-O081yj7-_9Ow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DECDB1C0759C;
 Tue, 16 May 2023 15:15:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A200814171C0;
 Tue, 16 May 2023 15:15:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 937D621E66E3; Tue, 16 May 2023 17:15:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 2/6] ui: add the infrastructure to support MT events
References: <20230509095345.42600-1-slp@redhat.com>
 <20230509095345.42600-3-slp@redhat.com>
Date: Tue, 16 May 2023 17:15:16 +0200
In-Reply-To: <20230509095345.42600-3-slp@redhat.com> (Sergio Lopez's message
 of "Tue, 9 May 2023 11:53:41 +0200")
Message-ID: <87ilcsnw8r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Sergio Lopez <slp@redhat.com> writes:

> Add the required infrastructure to support generating multitouch events.
>
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/ui/input.h    |  3 +++
>  qapi/ui.json          | 58 ++++++++++++++++++++++++++++++++++++-------
>  replay/replay-input.c | 18 ++++++++++++++
>  ui/input.c            |  6 +++++
>  ui/trace-events       |  1 +
>  5 files changed, 77 insertions(+), 9 deletions(-)
>
> diff --git a/include/ui/input.h b/include/ui/input.h
> index c86219a1c1..2a3dffd417 100644
> --- a/include/ui/input.h
> +++ b/include/ui/input.h
> @@ -8,9 +8,12 @@
>  #define INPUT_EVENT_MASK_BTN   (1<<INPUT_EVENT_KIND_BTN)
>  #define INPUT_EVENT_MASK_REL   (1<<INPUT_EVENT_KIND_REL)
>  #define INPUT_EVENT_MASK_ABS   (1<<INPUT_EVENT_KIND_ABS)
> +#define INPUT_EVENT_MASK_MTT   (1<<INPUT_EVENT_KIND_MTT)
>=20=20
>  #define INPUT_EVENT_ABS_MIN    0x0000
>  #define INPUT_EVENT_ABS_MAX    0x7FFF
> +#define INPUT_EVENT_SLOTS_MIN  0x0
> +#define INPUT_EVENT_SLOTS_MAX  0xa
>=20=20
>  typedef struct QemuInputHandler QemuInputHandler;
>  typedef struct QemuInputHandlerState QemuInputHandlerState;
> diff --git a/qapi/ui.json b/qapi/ui.json
> index b5650974fc..d38143bbe1 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1014,7 +1014,7 @@

Doc part is missing:

   # @touch: bla bla (since 8.1)

>  ##
>  { 'enum'  : 'InputButton',
>    'data'  : [ 'left', 'middle', 'right', 'wheel-up', 'wheel-down', 'side=
',
> -  'extra', 'wheel-left', 'wheel-right' ] }
> +  'extra', 'wheel-left', 'wheel-right', 'touch' ] }
>=20=20
>  ##
>  # @InputAxis:
> @@ -1026,6 +1026,17 @@
>  { 'enum'  : 'InputAxis',
>    'data'  : [ 'x', 'y' ] }
>=20=20
> +##
> +# @InputMultiTouchType:
> +#
> +# Type of a multi-touch event.
> +#
> +# Since: 8.1
> +##
> +{ 'enum'  : 'InputMultiTouchType',
> +  'data'  : [ 'begin', 'update', 'end', 'cancel', 'data' ] }
> +
> +
>  ##
>  # @InputKeyEvent:
>  #
> @@ -1069,13 +1080,38 @@
>    'data'  : { 'axis'    : 'InputAxis',
>                'value'   : 'int' } }
>=20=20
> +##
> +# @InputMultiTouchEvent:
> +#
> +# MultiTouch input event.
> +#
> +# @slot: Which slot has generated the event.
> +# @tracking-id: ID to correlate this event with previously generated eve=
nts.
> +# @axis: Which axis is referenced by @value.
> +# @value: Contact position.

Please format like

   # @slot: Which slot has generated the event.
   #
   # @tracking-id: ID to correlate this event with previously generated
   #     events.
   #
   # @axis: Which axis is referenced by @value.
   #
   # @value: Contact position.

to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
to conform to current conventions).

The blank lines help with catching certain errors.  rST loves to
surprise...

> +#
> +# Since: 8.1
> +##
> +{ 'struct'  : 'InputMultiTouchEvent',
> +  'data'  : { 'type'       : 'InputMultiTouchType',
> +              'slot'       : 'int',
> +              'tracking-id': 'int',
> +              'axis'       : 'InputAxis',
> +              'value'      : 'int' } }
> +
>  ##
>  # @InputEventKind:
>  #
> +# @key: a keyboard input event
> +# @btn: a pointer button input event
> +# @rel: a relative pointer motion input event
> +# @abs: an absolute pointer motion input event
> +# @mtt: a multi-touch input event

Please format like

   # @key: a keyboard input event
   #
   # @btn: a pointer button input event
   #
   # @rel: a relative pointer motion input event
   #
   # @abs: an absolute pointer motion input event
   #
   # @mtt: a multi-touch input event

> +#
>  # Since: 2.0
>  ##
>  { 'enum': 'InputEventKind',
> -  'data': [ 'key', 'btn', 'rel', 'abs' ] }
> +  'data': [ 'key', 'btn', 'rel', 'abs', 'mtt' ] }
>=20=20
>  ##
>  # @InputKeyEventWrapper:
> @@ -1101,17 +1137,20 @@
>  { 'struct': 'InputMoveEventWrapper',
>    'data': { 'data': 'InputMoveEvent' } }
>=20=20
> +##
> +# @InputMultiTouchEventWrapper:
> +#
> +# Since: 8.1
> +##
> +{ 'struct': 'InputMultiTouchEventWrapper',
> +  'data': { 'data': 'InputMultiTouchEvent' } }
> +
>  ##
>  # @InputEvent:
>  #
>  # Input event union.
>  #
> -# @type: the input type, one of:
> -#
> -#        - 'key': Input event of Keyboard
> -#        - 'btn': Input event of pointer buttons
> -#        - 'rel': Input event of relative pointer motion
> -#        - 'abs': Input event of absolute pointer motion
> +# @type: the type of input event
>  #
>  # Since: 2.0
>  ##
> @@ -1121,7 +1160,8 @@
>    'data'  : { 'key'     : 'InputKeyEventWrapper',
>                'btn'     : 'InputBtnEventWrapper',
>                'rel'     : 'InputMoveEventWrapper',
> -              'abs'     : 'InputMoveEventWrapper' } }
> +              'abs'     : 'InputMoveEventWrapper',
> +              'mtt'     : 'InputMultiTouchEventWrapper' } }
>=20=20
>  ##
>  # @input-send-event:

With these minor doc improvements
Reviewed-by: Markus Armbruster <armbru@redhat.com>

[...]


