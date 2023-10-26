Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A84B7D7F6C
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 11:17:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvwTf-00088t-9e; Thu, 26 Oct 2023 05:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qvwTc-00088S-KW
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 05:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qvwTZ-00058D-Qq
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 05:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698311784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N6JIbw/fFxJWKlS2ED2UM1H+c4xRob9GrBo+DgHpjwU=;
 b=cywfqPqfd1pkolv4Pea0VBZL8RRq7shuFl2d6I6WQY+P620cXipxGko7McZr9qHEzrbzIo
 JRyTUCiNw1FbTYeOAhVU4RgvU4LIkT6OSeeM26Oi4nRz6WxmwNHBhEuk4B/wgSNAp0isGZ
 OPmT/+Jv0FlkVoFMi5C01YTbEhyJ4hQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-Mr4WSIm9PGORXcwe7ARykg-1; Thu, 26 Oct 2023 05:16:23 -0400
X-MC-Unique: Mr4WSIm9PGORXcwe7ARykg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50798a25ebaso400224e87.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 02:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698311781; x=1698916581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N6JIbw/fFxJWKlS2ED2UM1H+c4xRob9GrBo+DgHpjwU=;
 b=J5t7vniWQLkfotKNu/7q1+VJfXNB7SFbEcr2dXFwlFt16MLpp2ZymHI31wh0v7YScO
 a0ANWmSIOWyyoDUDEskiXodMxGrJD1mPwiUTqS966eQBczyez7VQh2ZjnlBxMgxc765d
 ckpwqMkH2PClQMHAZ6hzQkSudOo1bIT1vHDe6bYhc31qmYw+g+olE3YQFuoQ97jPrmch
 Cn5eJRGiKHUzZlgDF4qDBBuEJGEVumGTHrfp274bxS00HiIjW36YSt5Fy6ufoj+dx4yS
 Ue0Qc20Q4PDQMiDTzNjB0SXdD0vE791rSQ3O8nAyeQd18I3C9KeWkR/+myeWdb1UqBA8
 f90A==
X-Gm-Message-State: AOJu0YyuTg4G/AOijnwGu/qgnKJkvsZtEiwgCdyhl2WMFnYAZGJYMVMQ
 h0mhX90NyX+qbArsJRwJeLzuuaK7hLR0flgc8GZaahewmUK/7VwsF845VP+MlIpuoPBxeBxreCs
 ahwWbLRoAPqmJbtapZF2pGC9djCbsAwePr5lHh+W8MyOW
X-Received: by 2002:a05:6512:3054:b0:507:b87f:c634 with SMTP id
 b20-20020a056512305400b00507b87fc634mr716856lfb.28.1698311781163; 
 Thu, 26 Oct 2023 02:16:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnsr/ztQIheLOkZc4slI4+1cVTwnx/nRMa/PkfrlQPFIki9J54jC5w7Cin7BImP9oiTbbIbUl6ZA/J8qhHziI=
X-Received: by 2002:a05:6512:3054:b0:507:b87f:c634 with SMTP id
 b20-20020a056512305400b00507b87fc634mr716847lfb.28.1698311780805; Thu, 26 Oct
 2023 02:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231025140058.113376-1-alexander.ivanov@virtuozzo.com>
 <20231025140058.113376-6-alexander.ivanov@virtuozzo.com>
In-Reply-To: <20231025140058.113376-6-alexander.ivanov@virtuozzo.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 26 Oct 2023 12:16:09 +0300
Message-ID: <CAPMcbCp9696yH+u6bSX9ku7uLaaSxyNdC0RKAoQmjd00m8zAGg@mail.gmail.com>
Subject: Re: [PATCH 5/6] qga: Add timeout for fsfreeze
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, michael.roth@amd.com, 
 marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="00000000000069c51b06089b06d0"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--00000000000069c51b06089b06d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think it is better to check that timeout <=3D 10 sec in the case of Windo=
ws.
Anyway this is a VSS limitation and FS will be unfrozen earlier if timeout
> 10 sec,
this can cause some misunderstanding from a user.

timeout option sounds good in the guest-fsfreeze-freeze command.
In guest-fsfreeze-freeze-list, it looks strange to me. Command returns
list but takes timeout option. Can you explain timeout usage in this
command?

On Wed, Oct 25, 2023 at 5:01=E2=80=AFPM Alexander Ivanov <
alexander.ivanov@virtuozzo.com> wrote:

> In some cases it would be useful to thaw a filesystem by timeout after
> freezing this filesystem by guest-fsfreeze-freeze-list. Add an optional
> argument "timeout" to the command.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>  qga/commands-posix.c   | 21 ++++++++++++++++++---
>  qga/commands-win32.c   | 16 ++++++++++++++--
>  qga/guest-agent-core.h |  3 ++-
>  qga/main.c             | 19 ++++++++++++++++++-
>  qga/qapi-schema.json   |  9 ++++++++-
>  5 files changed, 60 insertions(+), 8 deletions(-)
>
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 26711a1a72..e8a79e0a41 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -707,13 +707,17 @@ GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error
> **errp)
>      return GUEST_FSFREEZE_STATUS_THAWED;
>  }
>
> -int64_t qmp_guest_fsfreeze_freeze(Error **errp)
> +int64_t qmp_guest_fsfreeze_freeze(bool has_timeout, int64_t timeout,
> +                                  Error **errp)
>  {
> -    return qmp_guest_fsfreeze_freeze_list(false, NULL, errp);
> +    return qmp_guest_fsfreeze_freeze_list(false, NULL, has_timeout,
> timeout,
> +                                          errp);
>  }
>
>  int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
>                                         strList *mountpoints,
> +                                       bool has_timeout,
> +                                       int64_t timeout,
>                                         Error **errp)
>  {
>      int ret;
> @@ -734,8 +738,11 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool
> has_mountpoints,
>          return -1;
>      }
>
> +    if (!has_timeout || timeout < 0) {
> +        timeout =3D 0;
> +    }
>      /* cannot risk guest agent blocking itself on a write in this state =
*/
> -    ga_set_frozen(ga_state);
> +    ga_set_frozen(ga_state, timeout);
>
>      ret =3D qmp_guest_fsfreeze_do_freeze_list(has_mountpoints, mountpoin=
ts,
>                                              mounts, errp);
> @@ -780,6 +787,12 @@ static void guest_fsfreeze_cleanup(void)
>          }
>      }
>  }
> +
> +gboolean ga_frozen_timeout_cb(gpointer data)
> +{
> +    guest_fsfreeze_cleanup();
> +    return G_SOURCE_REMOVE;
> +}
>  #endif
>
>  /* linux-specific implementations. avoid this if at all possible. */
> @@ -3119,6 +3132,8 @@ int64_t qmp_guest_fsfreeze_freeze(Error **errp)
>
>  int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
>                                         strList *mountpoints,
> +                                       bool has_timeout,
> +                                       int64_t timeout,
>                                         Error **errp)
>  {
>      error_setg(errp, QERR_UNSUPPORTED);
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 618d862c00..51fd6dcd58 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1221,13 +1221,16 @@ GuestFsfreezeStatus
> qmp_guest_fsfreeze_status(Error **errp)
>   * Freeze local file systems using Volume Shadow-copy Service.
>   * The frozen state is limited for up to 10 seconds by VSS.
>   */
> -int64_t qmp_guest_fsfreeze_freeze(Error **errp)
> +int64_t qmp_guest_fsfreeze_freeze(bool has_timeout, int64_t timeout,
> +                                  Error **errp)
>  {
>      return qmp_guest_fsfreeze_freeze_list(false, NULL, errp);
>  }
>
>  int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
>                                         strList *mountpoints,
> +                                       bool has_timeout,
> +                                       int64_t timeout,
>                                         Error **errp)
>  {
>      int i;
> @@ -1240,8 +1243,11 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool
> has_mountpoints,
>
>      slog("guest-fsfreeze called");
>
> +    if (!has_timeout || timeout < 0) {
> +        timeout =3D 0;
> +    }
>      /* cannot risk guest agent blocking itself on a write in this state =
*/
> -    ga_set_frozen(ga_state);
> +    ga_set_frozen(ga_state, timeout);
>
>      qga_vss_fsfreeze(&i, true, mountpoints, &local_err);
>      if (local_err) {
> @@ -1299,6 +1305,12 @@ static void guest_fsfreeze_cleanup(void)
>      vss_deinit(true);
>  }
>
> +gboolean ga_frozen_timeout_cb(gpointer data)
> +{
> +    guest_fsfreeze_cleanup();
> +    return G_SOURCE_REMOVE;
> +}
> +
>  /*
>   * Walk list of mounted file systems in the guest, and discard unused
>   * areas.
> diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
> index b4e7c52c61..d8d1bb9505 100644
> --- a/qga/guest-agent-core.h
> +++ b/qga/guest-agent-core.h
> @@ -39,8 +39,9 @@ void ga_enable_logging(GAState *s);
>  void G_GNUC_PRINTF(1, 2) slog(const gchar *fmt, ...);
>  void ga_set_response_delimited(GAState *s);
>  bool ga_is_frozen(GAState *s);
> -void ga_set_frozen(GAState *s);
> +void ga_set_frozen(GAState *s, int64_t timeout);
>  void ga_unset_frozen(GAState *s);
> +gboolean ga_frozen_timeout_cb(gpointer data);
>  const char *ga_fsfreeze_hook(GAState *s);
>  int64_t ga_get_fd_handle(GAState *s, Error **errp);
>  int ga_parse_whence(GuestFileWhence *whence, Error **errp);
> diff --git a/qga/main.c b/qga/main.c
> index 8668b9f3d3..6c7c7d68d8 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -94,6 +94,7 @@ struct GAState {
>          const char *pid_filepath;
>      } deferred_options;
>  #ifdef CONFIG_FSFREEZE
> +    guint frozen_timeout_id;
>      const char *fsfreeze_hook;
>  #endif
>      gchar *pstate_filepath;
> @@ -478,7 +479,7 @@ bool ga_is_frozen(GAState *s)
>      return s->frozen;
>  }
>
> -void ga_set_frozen(GAState *s)
> +void ga_set_frozen(GAState *s, int64_t timeout)
>  {
>      if (ga_is_frozen(s)) {
>          return;
> @@ -492,6 +493,15 @@ void ga_set_frozen(GAState *s)
>          g_warning("unable to create %s, fsfreeze may not function
> properly",
>                    s->state_filepath_isfrozen);
>      }
> +#ifdef CONFIG_FSFREEZE
> +    if (timeout) {
> +        s->frozen_timeout_id =3D g_timeout_add_seconds(timeout,
> +                                                     ga_frozen_timeout_c=
b,
> +                                                     NULL);
> +    } else {
> +        s->frozen_timeout_id =3D 0;
> +    }
> +#endif
>  }
>
>  void ga_unset_frozen(GAState *s)
> @@ -500,6 +510,13 @@ void ga_unset_frozen(GAState *s)
>          return;
>      }
>
> +#ifdef CONFIG_FSFREEZE
> +    /* remove timeout callback */
> +    if (s->frozen_timeout_id) {
> +        g_source_remove(s->frozen_timeout_id);
> +    }
> +#endif
> +
>      /* if we delayed creation/opening of pid/log files due to being
>       * in a frozen state at start up, do it now
>       */
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index e96d463639..29ad342f0a 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -440,6 +440,9 @@
>  # command succeeded, you may call @guest-fsfreeze-thaw later to
>  # unfreeze.
>  #
> +# @timeout: after this period in seconds filesystems will be thawed
> +#     (since 8.2)
> +#
>  # Note: On Windows, the command is implemented with the help of a
>  #     Volume Shadow-copy Service DLL helper.  The frozen state is
>  #     limited for up to 10 seconds by VSS.
> @@ -452,6 +455,7 @@
>  # Since: 0.15.0
>  ##
>  { 'command': 'guest-fsfreeze-freeze',
> +  'data':    { '*timeout': 'int' },
>    'returns': 'int' }
>
>  ##
> @@ -464,13 +468,16 @@
>  #     If omitted, every mounted filesystem is frozen.  Invalid mount
>  #     points are ignored.
>  #
> +# @timeout: after this period in seconds filesystems will be thawed
> +#     (since 8.2)
> +#
>  # Returns: Number of file systems currently frozen.  On error, all
>  #     filesystems will be thawed.
>  #
>  # Since: 2.2
>  ##
>  { 'command': 'guest-fsfreeze-freeze-list',
> -  'data':    { '*mountpoints': ['str'] },
> +  'data':    { '*mountpoints': ['str'], '*timeout': 'int' },
>    'returns': 'int' }
>
>  ##
> --
> 2.34.1
>
>

--00000000000069c51b06089b06d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div>I think it is better to ch=
eck that timeout &lt;=3D 10 sec in the case of Windows.</div><div>Anyway th=
is is a VSS limitation and FS will be unfrozen earlier if timeout &gt; 10 s=
ec,</div><div>this can cause some misunderstanding from a user.</div><div><=
br></div>timeout option sounds good in the guest-fsfreeze-freeze command.<b=
r><div>In guest-fsfreeze-freeze-list, it looks strange to me. Command retur=
ns=C2=A0</div><div>list but takes timeout option. Can you explain timeout u=
sage in this command?</div><div><br></div><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 25, 2023 at 5:01=E2=80=AFPM Ale=
xander Ivanov &lt;<a href=3D"mailto:alexander.ivanov@virtuozzo.com">alexand=
er.ivanov@virtuozzo.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">In some cases it would be useful to thaw a filesyste=
m by timeout after<br>
freezing this filesystem by guest-fsfreeze-freeze-list. Add an optional<br>
argument &quot;timeout&quot; to the command.<br>
<br>
Signed-off-by: Alexander Ivanov &lt;<a href=3D"mailto:alexander.ivanov@virt=
uozzo.com" target=3D"_blank">alexander.ivanov@virtuozzo.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix.c=C2=A0 =C2=A0| 21 ++++++++++++++++++---<br>
=C2=A0qga/commands-win32.c=C2=A0 =C2=A0| 16 ++++++++++++++--<br>
=C2=A0qga/guest-agent-core.h |=C2=A0 3 ++-<br>
=C2=A0qga/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 19 ++++++=
++++++++++++-<br>
=C2=A0qga/qapi-schema.json=C2=A0 =C2=A0|=C2=A0 9 ++++++++-<br>
=C2=A05 files changed, 60 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/qga/commands-posix.c b/qga/commands-posix.c<br>
index 26711a1a72..e8a79e0a41 100644<br>
--- a/qga/commands-posix.c<br>
+++ b/qga/commands-posix.c<br>
@@ -707,13 +707,17 @@ GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error *=
*errp)<br>
=C2=A0 =C2=A0 =C2=A0return GUEST_FSFREEZE_STATUS_THAWED;<br>
=C2=A0}<br>
<br>
-int64_t qmp_guest_fsfreeze_freeze(Error **errp)<br>
+int64_t qmp_guest_fsfreeze_freeze(bool has_timeout, int64_t timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return qmp_guest_fsfreeze_freeze_list(false, NULL, errp);<br=
>
+=C2=A0 =C2=A0 return qmp_guest_fsfreeze_freeze_list(false, NULL, has_timeo=
ut, timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 e=
rrp);<br>
=C2=A0}<br>
<br>
=C2=A0int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strList =
*mountpoints,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool has_=
timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t t=
imeout,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **=
errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
@@ -734,8 +738,11 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountp=
oints,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (!has_timeout || timeout &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout =3D 0;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0/* cannot risk guest agent blocking itself on a write i=
n this state */<br>
-=C2=A0 =C2=A0 ga_set_frozen(ga_state);<br>
+=C2=A0 =C2=A0 ga_set_frozen(ga_state, timeout);<br>
<br>
=C2=A0 =C2=A0 =C2=A0ret =3D qmp_guest_fsfreeze_do_freeze_list(has_mountpoin=
ts, mountpoints,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0mounts, errp);<br>
@@ -780,6 +787,12 @@ static void guest_fsfreeze_cleanup(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
+<br>
+gboolean ga_frozen_timeout_cb(gpointer data)<br>
+{<br>
+=C2=A0 =C2=A0 guest_fsfreeze_cleanup();<br>
+=C2=A0 =C2=A0 return G_SOURCE_REMOVE;<br>
+}<br>
=C2=A0#endif<br>
<br>
=C2=A0/* linux-specific implementations. avoid this if at all possible. */<=
br>
@@ -3119,6 +3132,8 @@ int64_t qmp_guest_fsfreeze_freeze(Error **errp)<br>
<br>
=C2=A0int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strList =
*mountpoints,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool has_=
timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t t=
imeout,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **=
errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0error_setg(errp, QERR_UNSUPPORTED);<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 618d862c00..51fd6dcd58 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -1221,13 +1221,16 @@ GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error=
 **errp)<br>
=C2=A0 * Freeze local file systems using Volume Shadow-copy Service.<br>
=C2=A0 * The frozen state is limited for up to 10 seconds by VSS.<br>
=C2=A0 */<br>
-int64_t qmp_guest_fsfreeze_freeze(Error **errp)<br>
+int64_t qmp_guest_fsfreeze_freeze(bool has_timeout, int64_t timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0return qmp_guest_fsfreeze_freeze_list(false, NULL, errp=
);<br>
=C2=A0}<br>
<br>
=C2=A0int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strList =
*mountpoints,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool has_=
timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int64_t t=
imeout,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Error **=
errp)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
@@ -1240,8 +1243,11 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_moun=
tpoints,<br>
<br>
=C2=A0 =C2=A0 =C2=A0slog(&quot;guest-fsfreeze called&quot;);<br>
<br>
+=C2=A0 =C2=A0 if (!has_timeout || timeout &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 timeout =3D 0;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0/* cannot risk guest agent blocking itself on a write i=
n this state */<br>
-=C2=A0 =C2=A0 ga_set_frozen(ga_state);<br>
+=C2=A0 =C2=A0 ga_set_frozen(ga_state, timeout);<br>
<br>
=C2=A0 =C2=A0 =C2=A0qga_vss_fsfreeze(&amp;i, true, mountpoints, &amp;local_=
err);<br>
=C2=A0 =C2=A0 =C2=A0if (local_err) {<br>
@@ -1299,6 +1305,12 @@ static void guest_fsfreeze_cleanup(void)<br>
=C2=A0 =C2=A0 =C2=A0vss_deinit(true);<br>
=C2=A0}<br>
<br>
+gboolean ga_frozen_timeout_cb(gpointer data)<br>
+{<br>
+=C2=A0 =C2=A0 guest_fsfreeze_cleanup();<br>
+=C2=A0 =C2=A0 return G_SOURCE_REMOVE;<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Walk list of mounted file systems in the guest, and discard unused=
<br>
=C2=A0 * areas.<br>
diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h<br>
index b4e7c52c61..d8d1bb9505 100644<br>
--- a/qga/guest-agent-core.h<br>
+++ b/qga/guest-agent-core.h<br>
@@ -39,8 +39,9 @@ void ga_enable_logging(GAState *s);<br>
=C2=A0void G_GNUC_PRINTF(1, 2) slog(const gchar *fmt, ...);<br>
=C2=A0void ga_set_response_delimited(GAState *s);<br>
=C2=A0bool ga_is_frozen(GAState *s);<br>
-void ga_set_frozen(GAState *s);<br>
+void ga_set_frozen(GAState *s, int64_t timeout);<br>
=C2=A0void ga_unset_frozen(GAState *s);<br>
+gboolean ga_frozen_timeout_cb(gpointer data);<br>
=C2=A0const char *ga_fsfreeze_hook(GAState *s);<br>
=C2=A0int64_t ga_get_fd_handle(GAState *s, Error **errp);<br>
=C2=A0int ga_parse_whence(GuestFileWhence *whence, Error **errp);<br>
diff --git a/qga/main.c b/qga/main.c<br>
index 8668b9f3d3..6c7c7d68d8 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -94,6 +94,7 @@ struct GAState {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *pid_filepath;<br>
=C2=A0 =C2=A0 =C2=A0} deferred_options;<br>
=C2=A0#ifdef CONFIG_FSFREEZE<br>
+=C2=A0 =C2=A0 guint frozen_timeout_id;<br>
=C2=A0 =C2=A0 =C2=A0const char *fsfreeze_hook;<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0gchar *pstate_filepath;<br>
@@ -478,7 +479,7 @@ bool ga_is_frozen(GAState *s)<br>
=C2=A0 =C2=A0 =C2=A0return s-&gt;frozen;<br>
=C2=A0}<br>
<br>
-void ga_set_frozen(GAState *s)<br>
+void ga_set_frozen(GAState *s, int64_t timeout)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0if (ga_is_frozen(s)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
@@ -492,6 +493,15 @@ void ga_set_frozen(GAState *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_warning(&quot;unable to create %s, fsfr=
eeze may not function properly&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;=
state_filepath_isfrozen);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+#ifdef CONFIG_FSFREEZE<br>
+=C2=A0 =C2=A0 if (timeout) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;frozen_timeout_id =3D g_timeout_add_seco=
nds(timeout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga_frozen_timeout_cb,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;frozen_timeout_id =3D 0;<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
=C2=A0}<br>
<br>
=C2=A0void ga_unset_frozen(GAState *s)<br>
@@ -500,6 +510,13 @@ void ga_unset_frozen(GAState *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+#ifdef CONFIG_FSFREEZE<br>
+=C2=A0 =C2=A0 /* remove timeout callback */<br>
+=C2=A0 =C2=A0 if (s-&gt;frozen_timeout_id) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_source_remove(s-&gt;frozen_timeout_id);<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* if we delayed creation/opening of pid/log files due =
to being<br>
=C2=A0 =C2=A0 =C2=A0 * in a frozen state at start up, do it now<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index e96d463639..29ad342f0a 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -440,6 +440,9 @@<br>
=C2=A0# command succeeded, you may call @guest-fsfreeze-thaw later to<br>
=C2=A0# unfreeze.<br>
=C2=A0#<br>
+# @timeout: after this period in seconds filesystems will be thawed<br>
+#=C2=A0 =C2=A0 =C2=A0(since 8.2)<br>
+#<br>
=C2=A0# Note: On Windows, the command is implemented with the help of a<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0Volume Shadow-copy Service DLL helper.=C2=A0 The=
 frozen state is<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0limited for up to 10 seconds by VSS.<br>
@@ -452,6 +455,7 @@<br>
=C2=A0# Since: 0.15.0<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-fsfreeze-freeze&#39;,<br>
+=C2=A0 &#39;data&#39;:=C2=A0 =C2=A0 { &#39;*timeout&#39;: &#39;int&#39; },=
<br>
=C2=A0 =C2=A0&#39;returns&#39;: &#39;int&#39; }<br>
<br>
=C2=A0##<br>
@@ -464,13 +468,16 @@<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0If omitted, every mounted filesystem is frozen.=
=C2=A0 Invalid mount<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0points are ignored.<br>
=C2=A0#<br>
+# @timeout: after this period in seconds filesystems will be thawed<br>
+#=C2=A0 =C2=A0 =C2=A0(since 8.2)<br>
+#<br>
=C2=A0# Returns: Number of file systems currently frozen.=C2=A0 On error, a=
ll<br>
=C2=A0#=C2=A0 =C2=A0 =C2=A0filesystems will be thawed.<br>
=C2=A0#<br>
=C2=A0# Since: 2.2<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-fsfreeze-freeze-list&#39;,<br>
-=C2=A0 &#39;data&#39;:=C2=A0 =C2=A0 { &#39;*mountpoints&#39;: [&#39;str&#3=
9;] },<br>
+=C2=A0 &#39;data&#39;:=C2=A0 =C2=A0 { &#39;*mountpoints&#39;: [&#39;str&#3=
9;], &#39;*timeout&#39;: &#39;int&#39; },<br>
=C2=A0 =C2=A0&#39;returns&#39;: &#39;int&#39; }<br>
<br>
=C2=A0##<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--00000000000069c51b06089b06d0--


