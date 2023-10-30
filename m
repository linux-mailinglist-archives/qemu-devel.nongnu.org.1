Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A97287DBF1F
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 18:39:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxWD6-0007H4-M3; Mon, 30 Oct 2023 13:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qxWD5-0007Gu-4z
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qxWCz-00087F-7r
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698687455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Y2s7yx+3mdZXvWHV0JFiyEwj2meBvGmyqS8qDVtuPo=;
 b=aXLzpDZ211y/S9XemBugV3AZ+MabG6mugalv3Um1JhGqpQLKzbbgo3+wSoXmoPtN+GZ2Pb
 N9zyUNecuBub3V2ruKybEcegZT+UNQB70/CYlZ/NASQ9ZxQcPRssvmd0SfUUWX7mJ98bqk
 N+XMKOiUGK5qKoqMWFDh6JkIa88OPZk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-YUR_9bDzOHCbX1KvHihJkw-1; Mon, 30 Oct 2023 13:37:18 -0400
X-MC-Unique: YUR_9bDzOHCbX1KvHihJkw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5079630993dso5278629e87.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 10:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698687437; x=1699292237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Y2s7yx+3mdZXvWHV0JFiyEwj2meBvGmyqS8qDVtuPo=;
 b=p33Wq4oNMjpb5mvrU5vOQ5Vq/q2eSpK/4Wum/Pjng86spQEcqXVv71AcQ0g+H+mMQ8
 WQaOUS40H7Yi/1ScX3lKRepQUxB1wWR1rgdg5GhgvVspKQzoROV1CPU0A+zaynP/Cp2Q
 cvMwqD8bZYdJmph8vPjwWg+/bqAoEsSmPx6tsMdEYyXC90j9zWJRUCsIXRrthijAMKmN
 mK5ATVm4NW4epRKC5bCFkl2VHa+d3P1B0v9sdGjunRPI648rMmqc2kJCQL4WyFhtQwrX
 euQDAym1UbvHdnDF21YfVamdhFlXifjkjYGWEiHtYCWhyQjsruYn3+origYvwaN9pip5
 znXQ==
X-Gm-Message-State: AOJu0YwhEq/t1hw5QwDIaKTA3aGp14zNv2qT1P4rXEp9JscodxTfVpmu
 PixTwxER9THQqEYnPE97G8q0cNiLVv5HS7uVIMmeIWylVWUgBFW18/I49ya7nm4VKb4X4tusJZy
 UbqwRuIYU1pbqnN+OER1Y4ZdZW2ClHzc=
X-Received: by 2002:ac2:4579:0:b0:507:b4b7:a198 with SMTP id
 k25-20020ac24579000000b00507b4b7a198mr7274225lfm.57.1698687437210; 
 Mon, 30 Oct 2023 10:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXXg78oIob9Szhf9xzedrfJ0pdTmCcHT7GnlVOs8NNCQZmm6dy2t3jXLsIYuL+n0bunjWB7oH/SNpGIEpjy60=
X-Received: by 2002:ac2:4579:0:b0:507:b4b7:a198 with SMTP id
 k25-20020ac24579000000b00507b4b7a198mr7274215lfm.57.1698687436860; Mon, 30
 Oct 2023 10:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231025140058.113376-1-alexander.ivanov@virtuozzo.com>
 <20231025140058.113376-6-alexander.ivanov@virtuozzo.com>
 <CAPMcbCp9696yH+u6bSX9ku7uLaaSxyNdC0RKAoQmjd00m8zAGg@mail.gmail.com>
 <72a77154-a8b5-4b22-af7b-6be36fcbe033@virtuozzo.com>
In-Reply-To: <72a77154-a8b5-4b22-af7b-6be36fcbe033@virtuozzo.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 30 Oct 2023 19:37:05 +0200
Message-ID: <CAPMcbCrSXvjXugzQ3w+JQfGNEWJ-iWxh0tD-9fkKa_G_Vd678Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] qga: Add timeout for fsfreeze
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, michael.roth@amd.com, 
 marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="0000000000004242120608f27d01"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000004242120608f27d01
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 6:32=E2=80=AFPM Alexander Ivanov <
alexander.ivanov@virtuozzo.com> wrote:

>
>
> On 10/26/23 11:16, Konstantin Kostiuk wrote:
> >
> > I think it is better to check that timeout <=3D 10 sec in the case of
> > Windows.
> > Anyway this is a VSS limitation and FS will be unfrozen earlier if
> > timeout > 10 sec,
> > this can cause some misunderstanding from a user.
> Thank you, will pay attention.
> >
> > timeout option sounds good in the guest-fsfreeze-freeze command.
> > In guest-fsfreeze-freeze-list, it looks strange to me. Command returns
> > list but takes timeout option. Can you explain timeout usage in this
> > command?
> The second command doesn't return a list, it takes a list of mountpoints.
> Both of the commands freeze local guest filesystems. The first one
> freezes all the FS,
> the second one freeze only FS from the given list.
>

Oh, sorry, my mistake.
Just comment about VSS limitation.


Best Regards,
Konstantin Kostiuk.


> >
> > On Wed, Oct 25, 2023 at 5:01=E2=80=AFPM Alexander Ivanov
> > <alexander.ivanov@virtuozzo.com> wrote:
> >
> >     In some cases it would be useful to thaw a filesystem by timeout
> after
> >     freezing this filesystem by guest-fsfreeze-freeze-list. Add an
> >     optional
> >     argument "timeout" to the command.
> >
> >     Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> >     ---
> >      qga/commands-posix.c   | 21 ++++++++++++++++++---
> >      qga/commands-win32.c   | 16 ++++++++++++++--
> >      qga/guest-agent-core.h |  3 ++-
> >      qga/main.c             | 19 ++++++++++++++++++-
> >      qga/qapi-schema.json   |  9 ++++++++-
> >      5 files changed, 60 insertions(+), 8 deletions(-)
> >
> >     diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> >     index 26711a1a72..e8a79e0a41 100644
> >     --- a/qga/commands-posix.c
> >     +++ b/qga/commands-posix.c
> >     @@ -707,13 +707,17 @@ GuestFsfreezeStatus
> >     qmp_guest_fsfreeze_status(Error **errp)
> >          return GUEST_FSFREEZE_STATUS_THAWED;
> >      }
> >
> >     -int64_t qmp_guest_fsfreeze_freeze(Error **errp)
> >     +int64_t qmp_guest_fsfreeze_freeze(bool has_timeout, int64_t timeou=
t,
> >     +                                  Error **errp)
> >      {
> >     -    return qmp_guest_fsfreeze_freeze_list(false, NULL, errp);
> >     +    return qmp_guest_fsfreeze_freeze_list(false, NULL,
> >     has_timeout, timeout,
> >     +                                          errp);
> >      }
> >
> >      int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
> >                                             strList *mountpoints,
> >     +                                       bool has_timeout,
> >     +                                       int64_t timeout,
> >                                             Error **errp)
> >      {
> >          int ret;
> >     @@ -734,8 +738,11 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool
> >     has_mountpoints,
> >              return -1;
> >          }
> >
> >     +    if (!has_timeout || timeout < 0) {
> >     +        timeout =3D 0;
> >     +    }
> >          /* cannot risk guest agent blocking itself on a write in this
> >     state */
> >     -    ga_set_frozen(ga_state);
> >     +    ga_set_frozen(ga_state, timeout);
> >
> >          ret =3D qmp_guest_fsfreeze_do_freeze_list(has_mountpoints,
> >     mountpoints,
> >                                                  mounts, errp);
> >     @@ -780,6 +787,12 @@ static void guest_fsfreeze_cleanup(void)
> >              }
> >          }
> >      }
> >     +
> >     +gboolean ga_frozen_timeout_cb(gpointer data)
> >     +{
> >     +    guest_fsfreeze_cleanup();
> >     +    return G_SOURCE_REMOVE;
> >     +}
> >      #endif
> >
> >      /* linux-specific implementations. avoid this if at all possible. =
*/
> >     @@ -3119,6 +3132,8 @@ int64_t qmp_guest_fsfreeze_freeze(Error **err=
p)
> >
> >      int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
> >                                             strList *mountpoints,
> >     +                                       bool has_timeout,
> >     +                                       int64_t timeout,
> >                                             Error **errp)
> >      {
> >          error_setg(errp, QERR_UNSUPPORTED);
> >     diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> >     index 618d862c00..51fd6dcd58 100644
> >     --- a/qga/commands-win32.c
> >     +++ b/qga/commands-win32.c
> >     @@ -1221,13 +1221,16 @@ GuestFsfreezeStatus
> >     qmp_guest_fsfreeze_status(Error **errp)
> >       * Freeze local file systems using Volume Shadow-copy Service.
> >       * The frozen state is limited for up to 10 seconds by VSS.
> >       */
> >     -int64_t qmp_guest_fsfreeze_freeze(Error **errp)
> >     +int64_t qmp_guest_fsfreeze_freeze(bool has_timeout, int64_t timeou=
t,
> >     +                                  Error **errp)
> >      {
> >          return qmp_guest_fsfreeze_freeze_list(false, NULL, errp);
> >      }
> >
> >      int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
> >                                             strList *mountpoints,
> >     +                                       bool has_timeout,
> >     +                                       int64_t timeout,
> >                                             Error **errp)
> >      {
> >          int i;
> >     @@ -1240,8 +1243,11 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool
> >     has_mountpoints,
> >
> >          slog("guest-fsfreeze called");
> >
> >     +    if (!has_timeout || timeout < 0) {
> >     +        timeout =3D 0;
> >     +    }
> >          /* cannot risk guest agent blocking itself on a write in this
> >     state */
> >     -    ga_set_frozen(ga_state);
> >     +    ga_set_frozen(ga_state, timeout);
> >
> >          qga_vss_fsfreeze(&i, true, mountpoints, &local_err);
> >          if (local_err) {
> >     @@ -1299,6 +1305,12 @@ static void guest_fsfreeze_cleanup(void)
> >          vss_deinit(true);
> >      }
> >
> >     +gboolean ga_frozen_timeout_cb(gpointer data)
> >     +{
> >     +    guest_fsfreeze_cleanup();
> >     +    return G_SOURCE_REMOVE;
> >     +}
> >     +
> >      /*
> >       * Walk list of mounted file systems in the guest, and discard
> unused
> >       * areas.
> >     diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
> >     index b4e7c52c61..d8d1bb9505 100644
> >     --- a/qga/guest-agent-core.h
> >     +++ b/qga/guest-agent-core.h
> >     @@ -39,8 +39,9 @@ void ga_enable_logging(GAState *s);
> >      void G_GNUC_PRINTF(1, 2) slog(const gchar *fmt, ...);
> >      void ga_set_response_delimited(GAState *s);
> >      bool ga_is_frozen(GAState *s);
> >     -void ga_set_frozen(GAState *s);
> >     +void ga_set_frozen(GAState *s, int64_t timeout);
> >      void ga_unset_frozen(GAState *s);
> >     +gboolean ga_frozen_timeout_cb(gpointer data);
> >      const char *ga_fsfreeze_hook(GAState *s);
> >      int64_t ga_get_fd_handle(GAState *s, Error **errp);
> >      int ga_parse_whence(GuestFileWhence *whence, Error **errp);
> >     diff --git a/qga/main.c b/qga/main.c
> >     index 8668b9f3d3..6c7c7d68d8 100644
> >     --- a/qga/main.c
> >     +++ b/qga/main.c
> >     @@ -94,6 +94,7 @@ struct GAState {
> >              const char *pid_filepath;
> >          } deferred_options;
> >      #ifdef CONFIG_FSFREEZE
> >     +    guint frozen_timeout_id;
> >          const char *fsfreeze_hook;
> >      #endif
> >          gchar *pstate_filepath;
> >     @@ -478,7 +479,7 @@ bool ga_is_frozen(GAState *s)
> >          return s->frozen;
> >      }
> >
> >     -void ga_set_frozen(GAState *s)
> >     +void ga_set_frozen(GAState *s, int64_t timeout)
> >      {
> >          if (ga_is_frozen(s)) {
> >              return;
> >     @@ -492,6 +493,15 @@ void ga_set_frozen(GAState *s)
> >              g_warning("unable to create %s, fsfreeze may not function
> >     properly",
> >                        s->state_filepath_isfrozen);
> >          }
> >     +#ifdef CONFIG_FSFREEZE
> >     +    if (timeout) {
> >     +        s->frozen_timeout_id =3D g_timeout_add_seconds(timeout,
> >     +  ga_frozen_timeout_cb,
> >     +                                                     NULL);
> >     +    } else {
> >     +        s->frozen_timeout_id =3D 0;
> >     +    }
> >     +#endif
> >      }
> >
> >      void ga_unset_frozen(GAState *s)
> >     @@ -500,6 +510,13 @@ void ga_unset_frozen(GAState *s)
> >              return;
> >          }
> >
> >     +#ifdef CONFIG_FSFREEZE
> >     +    /* remove timeout callback */
> >     +    if (s->frozen_timeout_id) {
> >     +        g_source_remove(s->frozen_timeout_id);
> >     +    }
> >     +#endif
> >     +
> >          /* if we delayed creation/opening of pid/log files due to bein=
g
> >           * in a frozen state at start up, do it now
> >           */
> >     diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> >     index e96d463639..29ad342f0a 100644
> >     --- a/qga/qapi-schema.json
> >     +++ b/qga/qapi-schema.json
> >     @@ -440,6 +440,9 @@
> >      # command succeeded, you may call @guest-fsfreeze-thaw later to
> >      # unfreeze.
> >      #
> >     +# @timeout: after this period in seconds filesystems will be thawe=
d
> >     +#     (since 8.2)
> >     +#
> >      # Note: On Windows, the command is implemented with the help of a
> >      #     Volume Shadow-copy Service DLL helper.  The frozen state is
> >      #     limited for up to 10 seconds by VSS.
> >     @@ -452,6 +455,7 @@
> >      # Since: 0.15.0
> >      ##
> >      { 'command': 'guest-fsfreeze-freeze',
> >     +  'data':    { '*timeout': 'int' },
> >        'returns': 'int' }
> >
> >      ##
> >     @@ -464,13 +468,16 @@
> >      #     If omitted, every mounted filesystem is frozen. Invalid moun=
t
> >      #     points are ignored.
> >      #
> >     +# @timeout: after this period in seconds filesystems will be thawe=
d
> >     +#     (since 8.2)
> >     +#
> >      # Returns: Number of file systems currently frozen.  On error, all
> >      #     filesystems will be thawed.
> >      #
> >      # Since: 2.2
> >      ##
> >      { 'command': 'guest-fsfreeze-freeze-list',
> >     -  'data':    { '*mountpoints': ['str'] },
> >     +  'data':    { '*mountpoints': ['str'], '*timeout': 'int' },
> >        'returns': 'int' }
> >
> >      ##
> >     --
> >     2.34.1
> >
>
> --
> Best regards,
> Alexander Ivanov
>
>

--0000000000004242120608f27d01
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Oct 30, 2023 at 6:32=E2=80=AF=
PM Alexander Ivanov &lt;<a href=3D"mailto:alexander.ivanov@virtuozzo.com">a=
lexander.ivanov@virtuozzo.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><br>
<br>
On 10/26/23 11:16, Konstantin Kostiuk wrote:<br>
&gt;<br>
&gt; I think it is better to check that timeout &lt;=3D 10 sec in the case =
of <br>
&gt; Windows.<br>
&gt; Anyway this is a VSS limitation and FS will be unfrozen earlier if <br=
>
&gt; timeout &gt; 10 sec,<br>
&gt; this can cause some misunderstanding from a user.<br>
Thank you, will pay attention.<br>
&gt;<br>
&gt; timeout option sounds good in the guest-fsfreeze-freeze command.<br>
&gt; In guest-fsfreeze-freeze-list, it looks strange to me. Command returns=
<br>
&gt; list but takes timeout option. Can you explain timeout usage in this <=
br>
&gt; command?<br>
The second command doesn&#39;t return a list, it takes a list of mountpoint=
s.<br>
Both of the commands freeze local guest filesystems. The first one <br>
freezes all the FS,<br>
the second one freeze only FS from the given list.<br></blockquote><div><br=
></div><div>Oh, sorry, my mistake. <br></div><div>Just comment about VSS li=
mitation. <br></div><div><br></div><div><br clear=3D"all"><div><div dir=3D"=
ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div><di=
v>Konstantin Kostiuk.</div></div></div></div></div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; On Wed, Oct 25, 2023 at 5:01=E2=80=AFPM Alexander Ivanov <br>
&gt; &lt;<a href=3D"mailto:alexander.ivanov@virtuozzo.com" target=3D"_blank=
">alexander.ivanov@virtuozzo.com</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0In some cases it would be useful to thaw a filesyst=
em by timeout after<br>
&gt;=C2=A0 =C2=A0 =C2=A0freezing this filesystem by guest-fsfreeze-freeze-l=
ist. Add an<br>
&gt;=C2=A0 =C2=A0 =C2=A0optional<br>
&gt;=C2=A0 =C2=A0 =C2=A0argument &quot;timeout&quot; to the command.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Alexander Ivanov &lt;<a href=3D"mail=
to:alexander.ivanov@virtuozzo.com" target=3D"_blank">alexander.ivanov@virtu=
ozzo.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0qga/commands-posix.c=C2=A0 =C2=A0| 21 +++++++=
+++++++++++---<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0qga/commands-win32.c=C2=A0 =C2=A0| 16 +++++++=
+++++++--<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0qga/guest-agent-core.h |=C2=A0 3 ++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 19 ++++++++++++++++++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0qga/qapi-schema.json=C2=A0 =C2=A0|=C2=A0 9 ++=
++++++-<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A05 files changed, 60 insertions(+), 8 deletion=
s(-)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/qga/commands-posix.c b/qga/commands-po=
six.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 26711a1a72..e8a79e0a41 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/qga/commands-posix.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/qga/commands-posix.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -707,13 +707,17 @@ GuestFsfreezeStatus<br>
&gt;=C2=A0 =C2=A0 =C2=A0qmp_guest_fsfreeze_status(Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0return GUEST_FSFREEZE_STATUS_TH=
AWED;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-int64_t qmp_guest_fsfreeze_freeze(Error **errp)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+int64_t qmp_guest_fsfreeze_freeze(bool has_timeout=
, int64_t timeout,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error=
 **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 return qmp_guest_fsfreeze_freeze_lis=
t(false, NULL, errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 return qmp_guest_fsfreeze_freeze_lis=
t(false, NULL,<br>
&gt;=C2=A0 =C2=A0 =C2=A0has_timeout, timeout,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0int64_t qmp_guest_fsfreeze_freeze_list(bool h=
as_mountpoints,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 strList *mountpoints,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bool has_timeout,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int64_t timeout,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -734,8 +738,11 @@ int64_t qmp_guest_fsfreeze_fre=
eze_list(bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0has_mountpoints,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (!has_timeout || timeout &lt; 0) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0/* cannot risk guest agent bloc=
king itself on a write in this<br>
&gt;=C2=A0 =C2=A0 =C2=A0state */<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 ga_set_frozen(ga_state);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ga_set_frozen(ga_state, timeout);<br=
>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0ret =3D qmp_guest_fsfreeze_do_f=
reeze_list(has_mountpoints,<br>
&gt;=C2=A0 =C2=A0 =C2=A0mountpoints,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mounts, errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -780,6 +787,12 @@ static void guest_fsfreeze_cle=
anup(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+gboolean ga_frozen_timeout_cb(gpointer data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+{<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 guest_fsfreeze_cleanup();<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 return G_SOURCE_REMOVE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+}<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#endif<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0/* linux-specific implementations. avoid this=
 if at all possible. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -3119,6 +3132,8 @@ int64_t qmp_guest_fsfreeze_fr=
eeze(Error **errp)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0int64_t qmp_guest_fsfreeze_freeze_list(bool h=
as_mountpoints,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 strList *mountpoints,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bool has_timeout,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int64_t timeout,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0error_setg(errp, QERR_UNSUPPORT=
ED);<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/qga/commands-win32.c b/qga/commands-wi=
n32.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 618d862c00..51fd6dcd58 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/qga/commands-win32.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/qga/commands-win32.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -1221,13 +1221,16 @@ GuestFsfreezeStatus<br>
&gt;=C2=A0 =C2=A0 =C2=A0qmp_guest_fsfreeze_status(Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 * Freeze local file systems using Volume Sha=
dow-copy Service.<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 * The frozen state is limited for up to 10 s=
econds by VSS.<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0-int64_t qmp_guest_fsfreeze_freeze(Error **errp)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+int64_t qmp_guest_fsfreeze_freeze(bool has_timeout=
, int64_t timeout,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error=
 **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0return qmp_guest_fsfreeze_freez=
e_list(false, NULL, errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0int64_t qmp_guest_fsfreeze_freeze_list(bool h=
as_mountpoints,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 strList *mountpoints,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bool has_timeout,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int64_t timeout,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Error **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -1240,8 +1243,11 @@ int64_t qmp_guest_fsfreeze_f=
reeze_list(bool<br>
&gt;=C2=A0 =C2=A0 =C2=A0has_mountpoints,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0slog(&quot;guest-fsfreeze calle=
d&quot;);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (!has_timeout || timeout &lt; 0) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0/* cannot risk guest agent bloc=
king itself on a write in this<br>
&gt;=C2=A0 =C2=A0 =C2=A0state */<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 ga_set_frozen(ga_state);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 ga_set_frozen(ga_state, timeout);<br=
>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0qga_vss_fsfreeze(&amp;i, true, =
mountpoints, &amp;local_err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (local_err) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -1299,6 +1305,12 @@ static void guest_fsfreeze_c=
leanup(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0vss_deinit(true);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+gboolean ga_frozen_timeout_cb(gpointer data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+{<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 guest_fsfreeze_cleanup();<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 return G_SOURCE_REMOVE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 * Walk list of mounted file systems in the g=
uest, and discard unused<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 * areas.<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/qga/guest-agent-core.h b/qga/guest-age=
nt-core.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0index b4e7c52c61..d8d1bb9505 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/qga/guest-agent-core.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/qga/guest-agent-core.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -39,8 +39,9 @@ void ga_enable_logging(GAState *s=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0void G_GNUC_PRINTF(1, 2) slog(const gchar *fm=
t, ...);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0void ga_set_response_delimited(GAState *s);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0bool ga_is_frozen(GAState *s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0-void ga_set_frozen(GAState *s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+void ga_set_frozen(GAState *s, int64_t timeout);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0void ga_unset_frozen(GAState *s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+gboolean ga_frozen_timeout_cb(gpointer data);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0const char *ga_fsfreeze_hook(GAState *s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0int64_t ga_get_fd_handle(GAState *s, Error **=
errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0int ga_parse_whence(GuestFileWhence *whence, =
Error **errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/qga/main.c b/qga/main.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 8668b9f3d3..6c7c7d68d8 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/qga/main.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/qga/main.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -94,6 +94,7 @@ struct GAState {<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *pid_f=
ilepath;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0} deferred_options;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#ifdef CONFIG_FSFREEZE<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 guint frozen_timeout_id;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0const char *fsfreeze_hook;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0gchar *pstate_filepath;<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -478,7 +479,7 @@ bool ga_is_frozen(GAState *s)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0return s-&gt;frozen;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0-void ga_set_frozen(GAState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+void ga_set_frozen(GAState *s, int64_t timeout)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0if (ga_is_frozen(s)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -492,6 +493,15 @@ void ga_set_frozen(GAState *s)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_warning(&quot;u=
nable to create %s, fsfreeze may not function<br>
&gt;=C2=A0 =C2=A0 =C2=A0properly&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0s-&gt;state_filepath_isfrozen);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#ifdef CONFIG_FSFREEZE<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (timeout) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;frozen_timeout_i=
d =3D g_timeout_add_seconds(timeout,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ =C2=A0ga_frozen_timeout_cb,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;frozen_timeout_i=
d =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0void ga_unset_frozen(GAState *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -500,6 +510,13 @@ void ga_unset_frozen(GAState *=
s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#ifdef CONFIG_FSFREEZE<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 /* remove timeout callback */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (s-&gt;frozen_timeout_id) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_source_remove(s-&gt;=
frozen_timeout_id);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0/* if we delayed creation/openi=
ng of pid/log files due to being<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 * in a frozen state at start u=
p, do it now<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/qga/qapi-schema.json b/qga/qapi-schema=
.json<br>
&gt;=C2=A0 =C2=A0 =C2=A0index e96d463639..29ad342f0a 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/qga/qapi-schema.json<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/qga/qapi-schema.json<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -440,6 +440,9 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0# command succeeded, you may call @guest-fsfr=
eeze-thaw later to<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0# unfreeze.<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#<br>
&gt;=C2=A0 =C2=A0 =C2=A0+# @timeout: after this period in seconds filesyste=
ms will be thawed<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#=C2=A0 =C2=A0 =C2=A0(since 8.2)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0# Note: On Windows, the command is implemente=
d with the help of a<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#=C2=A0 =C2=A0 =C2=A0Volume Shadow-copy Servi=
ce DLL helper.=C2=A0 The frozen state is<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#=C2=A0 =C2=A0 =C2=A0limited for up to 10 sec=
onds by VSS.<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -452,6 +455,7 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0# Since: 0.15.0<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0##<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{ &#39;command&#39;: &#39;guest-fsfreeze-free=
ze&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 &#39;data&#39;:=C2=A0 =C2=A0 { &#39;*timeou=
t&#39;: &#39;int&#39; },<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0&#39;returns&#39;: &#39;int&#39; }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0##<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -464,13 +468,16 @@<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#=C2=A0 =C2=A0 =C2=A0If omitted, every mounte=
d filesystem is frozen. Invalid mount<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#=C2=A0 =C2=A0 =C2=A0points are ignored.<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#<br>
&gt;=C2=A0 =C2=A0 =C2=A0+# @timeout: after this period in seconds filesyste=
ms will be thawed<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#=C2=A0 =C2=A0 =C2=A0(since 8.2)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+#<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0# Returns: Number of file systems currently f=
rozen.=C2=A0 On error, all<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#=C2=A0 =C2=A0 =C2=A0filesystems will be thaw=
ed.<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0#<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0# Since: 2.2<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0##<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0{ &#39;command&#39;: &#39;guest-fsfreeze-free=
ze-list&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 &#39;data&#39;:=C2=A0 =C2=A0 { &#39;*mountp=
oints&#39;: [&#39;str&#39;] },<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 &#39;data&#39;:=C2=A0 =C2=A0 { &#39;*mountp=
oints&#39;: [&#39;str&#39;], &#39;*timeout&#39;: &#39;int&#39; },<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0&#39;returns&#39;: &#39;int&#39; }<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0##<br>
&gt;=C2=A0 =C2=A0 =C2=A0-- <br>
&gt;=C2=A0 =C2=A0 =C2=A02.34.1<br>
&gt;<br>
<br>
-- <br>
Best regards,<br>
Alexander Ivanov<br>
<br>
</blockquote></div></div>

--0000000000004242120608f27d01--


