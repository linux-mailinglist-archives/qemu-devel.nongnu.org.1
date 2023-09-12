Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D7879C6E3
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 08:29:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfwsN-000525-39; Tue, 12 Sep 2023 02:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qfwsK-00051i-Eu
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:27:52 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qfwsI-0000NH-0s
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:27:52 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-412137ae07aso32469121cf.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 23:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694500069; x=1695104869; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZzlgzm5eTYSHk3DJ+WwQurhXPMrb+lk6OvI5lP8x0M=;
 b=OYgrMqwV3xnEmP91lKqQdL7FnfNq2TOjys9Ui6sbMP0u/YikkTH/Y8xa+mxWscP+n6
 k2gimx9qW6LMbfHIiwzrqm+ff7zsW0FYoHAhSXVSH4QqdM8cRqtSIKp1m/spfnGVlqB6
 HoA4ez4qFvJXQwz2Jlj8sJgjgWpOsWBD0Nom6GVDrqzZDZW/ZcmLXwjAcwnmeXX9DqLC
 5a5FOQAS4fiW7m/oaWDSie474PBIEeOQXLfEx3rBsR86P89ZJjtHDkolxOuCQG+/8N+x
 eefEbLOQq1rDg9ioBR/WGJkNGzAu7MalJY7JEjUNxGLvQ5Nv7G9jgjSklf9cYnRBGQBA
 H1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694500069; x=1695104869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IZzlgzm5eTYSHk3DJ+WwQurhXPMrb+lk6OvI5lP8x0M=;
 b=H/BesB9EANY8BEVN/ok9GFTYia+MIQ6KS1UOQok+J+EGhIqbZPpJBDb84J+tr753zc
 K6fwwRJK19tNyCjEf7PZ3JvuJWSr3dvwMQumaEBRoSpQ/rxl3TbAAkXrsajFRxmHYv2f
 VjUHk31I6ZNa6Xfs5uX9/Pv2eNzEq7uVNZN8hxG8yNggRwYLvw+ERUWIqrWDYoVQOqNy
 VPDZXUrRT2969+vL71JFpL5KZbez2l4ZrEO3x4OTXZTw/oq3gypp0w0j04n3JErzSoX7
 i+iMsXDuvzAWCIrkZd/bPwsjMSJa3IDWhcjl+A5CpGHc0ik6ferZHyYwFN4Ulpc1OUhz
 JS8A==
X-Gm-Message-State: AOJu0YyOoxIXHIuS2rZMbVMRnUSL7Xy6Ew8KpiK0930HIWbfLBSHrvNN
 ydvZkS2CyOTOKQSgr1AtLOe/HryRO72YwscFaTY=
X-Google-Smtp-Source: AGHT+IFi6qHbGUe+0sKTL8p1aD/u3JPVXuYynoX7XSErHmownf4cQF5ZILdb7X5vsWRYfzPYwWj1n8WJfAm1L1D6sSY=
X-Received: by 2002:ac8:5bc5:0:b0:406:804b:e0f5 with SMTP id
 b5-20020ac85bc5000000b00406804be0f5mr12968790qtb.55.1694500068871; Mon, 11
 Sep 2023 23:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230911140638.1458156-1-marcandre.lureau@redhat.com>
 <CADSE00JJjgi8mdcHA304GAW=HxoKA4G-uBwasnUOZrREpXdWnQ@mail.gmail.com>
In-Reply-To: <CADSE00JJjgi8mdcHA304GAW=HxoKA4G-uBwasnUOZrREpXdWnQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 12 Sep 2023 10:27:37 +0400
Message-ID: <CAJ+F1C+_b1=LVyXNsh6UoazRCrUNO3yGwyp7BY6xpyFQwNFtVA@mail.gmail.com>
Subject: Re: [PATCH] ui: fix crash when there are no active_console
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x836.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Mon, Sep 11, 2023 at 6:44=E2=80=AFPM Albert Esteve <aesteve@redhat.com> =
wrote:
>
>
>
> On Mon, Sep 11, 2023 at 4:08=E2=80=AFPM <marcandre.lureau@redhat.com> wro=
te:
>>
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
>> 0x0000555555888630 in dpy_ui_info_supported (con=3D0x0) at ../ui/console=
.c:812
>> 812         return con->hw_ops->ui_info !=3D NULL;
>> (gdb) bt
>> #0  0x0000555555888630 in dpy_ui_info_supported (con=3D0x0) at ../ui/con=
sole.c:812
>> #1  0x00005555558a44b1 in protocol_client_msg (vs=3D0x5555578c76c0, data=
=3D0x5555581e93f0 <incomplete sequence \373>, len=3D24) at ../ui/vnc.c:2585
>> #2  0x00005555558a19ac in vnc_client_read (vs=3D0x5555578c76c0) at ../ui=
/vnc.c:1607
>> #3  0x00005555558a1ac2 in vnc_client_io (ioc=3D0x5555581eb0e0, condition=
=3DG_IO_IN, opaque=3D0x5555578c76c0) at ../ui/vnc.c:1635
>>
>> Fixes:
>> https://issues.redhat.com/browse/RHEL-2600
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  ui/console.c | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/ui/console.c b/ui/console.c
>> index 90ae4be602..0f31ecece6 100644
>> --- a/ui/console.c
>> +++ b/ui/console.c
>> @@ -808,6 +808,9 @@ bool dpy_ui_info_supported(QemuConsole *con)
>>      if (con =3D=3D NULL) {
>>          con =3D active_console;
>>      }
>> +    if (con =3D=3D NULL) {
>> +        return false;
>> +    }
>>
>>      return con->hw_ops->ui_info !=3D NULL;
>>  }
>> @@ -817,6 +820,9 @@ const QemuUIInfo *dpy_get_ui_info(const QemuConsole =
*con)
>>      if (con =3D=3D NULL) {
>>          con =3D active_console;
>>      }
>> +    if (con =3D=3D NULL) {
>> +        return NULL;
>> +    }
>>
>>      return &con->ui_info;
>>  }
>> @@ -826,6 +832,9 @@ int dpy_set_ui_info(QemuConsole *con, QemuUIInfo *in=
fo, bool delay)
>>      if (con =3D=3D NULL) {
>>          con =3D active_console;
>>      }
>> +    if (con =3D=3D NULL) {
>> +        return -1;
>> +    }
>>
>>      if (!dpy_ui_info_supported(con)) {
>>          return -1;
>> @@ -1401,6 +1410,10 @@ QEMUCursor *qemu_console_get_cursor(QemuConsole *=
con)
>>      if (con =3D=3D NULL) {
>>          con =3D active_console;
>>      }
>> +    if (con =3D=3D NULL) {
>> +        return NULL;
>> +    }
>> +
>>      return QEMU_IS_GRAPHIC_CONSOLE(con) ? QEMU_GRAPHIC_CONSOLE(con)->cu=
rsor : NULL;
>>  }
>>
>> @@ -1414,6 +1427,10 @@ bool qemu_console_is_graphic(QemuConsole *con)
>>      if (con =3D=3D NULL) {
>>          con =3D active_console;
>>      }
>> +    if (con =3D=3D NULL) {
>> +        return false;
>> +    }
>> +
>>      return con && QEMU_IS_GRAPHIC_CONSOLE(con);
>>  }
>>
>> @@ -1422,6 +1439,10 @@ bool qemu_console_is_fixedsize(QemuConsole *con)
>>      if (con =3D=3D NULL) {
>>          con =3D active_console;
>>      }
>> +    if (con =3D=3D NULL) {
>> +        return false;
>> +    }
>> +
>
>
> The "con" initialization condition is already checked in the line below (=
now unnecessarily).
> If the if block is preferred for consistency with other functions, we cou=
ld remove the con check from
> the condition below:
> ```
> return QEMU_IS_GRAPHIC_CONSOLE(con) || QEMU_IS_FIXED_TEXT_CONSOLE(con);
> ```
>
>>
>>      return con && (QEMU_IS_GRAPHIC_CONSOLE(con) || QEMU_IS_FIXED_TEXT_C=
ONSOLE(con));
>>  }
>>
>> @@ -1493,6 +1514,10 @@ int qemu_console_get_index(QemuConsole *con)
>>      if (con =3D=3D NULL) {
>>          con =3D active_console;
>>      }
>> +    if (con =3D=3D NULL) {
>> +        return -1;
>> +    }
>> +
>
>
> Same as before, here we could simply "return con->index;"
>
>>
>>      return con ? con->index : -1;
>>
>>  }
>>

You are right, the added checks are mostly redundant. I'll make the
patch touch only dpy_ui_info_supported(). And another patch for the
related precondition when calling dpy_get_ui_info().


--=20
Marc-Andr=C3=A9 Lureau

