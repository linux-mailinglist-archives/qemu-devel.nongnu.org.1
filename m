Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B4C7D7E6D
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:25:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvvfJ-0008Su-CP; Thu, 26 Oct 2023 04:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qvvfE-0008Sd-5a
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qvvfC-0007Cu-0V
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698308660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2sG2mpAELY+ByqgBtr74+SvNRWvupaZrHcYCeXVlTrQ=;
 b=NyeC0fJ+l3+0xR5gcobX6OHR49RJkjwTqNsG7RW65t2txXKLwryW+THGZjbKJBJWZm21WX
 q2+G+OwfPYOAy7VLRuNOlewt7YVzejrvHhv0cDAeJg/Z3ig61Xfo60A9mOU+NK+Tn1vntx
 NSgZ212unR3dvFI7jOKzrFGPy33Wotw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-U0lHQYn8Pl6-luWTsJFHyQ-1; Thu, 26 Oct 2023 04:24:18 -0400
X-MC-Unique: U0lHQYn8Pl6-luWTsJFHyQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507a3ae32b2so639575e87.2
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 01:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698308656; x=1698913456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2sG2mpAELY+ByqgBtr74+SvNRWvupaZrHcYCeXVlTrQ=;
 b=w/th15pRSQdHr6EDawbCOr1Gp1P2OvU7o9SFM+43F9HUVVxtzdtPgy9YlNxR7k8gI5
 OsKxMKT7MBDSp850tsT7Q/R5MyCoQhyUw+fHLZYZXZVrNWNeLaOvgsqXa0nu+WESJH8K
 fAn1T0NFKlEgJ+4FhFCZM8tOQCtmQFgqG9wGE21qTEE/rZqcIm6kq4gv2hpuIMoP3YUq
 0zftttzWeAzMpZch2edVbgOB7DDrFkk+x6CBtZuUzsZQkGo2FJ6yVLVcv9SZB6eD4foI
 Pj30TDG1GJFJegKQfnOZJtv2QfA5z/y9rNTzFCsll2u5kM2JG4yM+bmSZkntlPrxVX9f
 zZ8Q==
X-Gm-Message-State: AOJu0YwkcDHvllFNEbhr8c0a4thmIDrXJMfR5jRyTQ/0IG5p1qmmPKLU
 jKPKcx9KuanPV0ofTfWXqWNQg82RJOFvqfhwucMvjBjufdbDneVb9d4qi5rISEuL6NJWGrknkcj
 nsjX7w3s0IDLGlxNJ54PdfhS9cI0+Vqk=
X-Received: by 2002:a05:6512:108e:b0:508:1857:91f3 with SMTP id
 j14-20020a056512108e00b00508185791f3mr3816902lfg.62.1698308656398; 
 Thu, 26 Oct 2023 01:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE98A726VNMbsH3pY3samYhiSXiyLRrqPx1oSLqE+vu0fmdDvYk6pxEY99QP90zoyAxAtrYQ4NY98p+zFLouWc=
X-Received: by 2002:a05:6512:108e:b0:508:1857:91f3 with SMTP id
 j14-20020a056512108e00b00508185791f3mr3816885lfg.62.1698308656027; Thu, 26
 Oct 2023 01:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231025140058.113376-1-alexander.ivanov@virtuozzo.com>
 <20231025140058.113376-2-alexander.ivanov@virtuozzo.com>
In-Reply-To: <20231025140058.113376-2-alexander.ivanov@virtuozzo.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Thu, 26 Oct 2023 11:24:04 +0300
Message-ID: <CAPMcbCoJ94bMHat5FjXFoxfNBfaQMjcAnXUQsOV2Fbw+ovS1BQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] qga: Add process termination functionality
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, michael.roth@amd.com, 
 marcandre.lureau@gmail.com
Content-Type: multipart/alternative; boundary="00000000000029704706089a4ca9"
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

--00000000000029704706089a4ca9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 5:01=E2=80=AFPM Alexander Ivanov <
alexander.ivanov@virtuozzo.com> wrote:

> We need to terminate processes executed with guest-exec command. Add
> guest-exec-terminate command for process termination by PID.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>  qga/commands-common.h |  2 ++
>  qga/commands-win32.c  | 64 +++++++++++++++++++++++++++++++++++++++++++
>  qga/commands.c        | 34 +++++++++++++++++++++++
>  qga/qapi-schema.json  | 13 +++++++++
>  4 files changed, 113 insertions(+)
>
> diff --git a/qga/commands-common.h b/qga/commands-common.h
> index 8c1c56aac9..34b9a22578 100644
> --- a/qga/commands-common.h
> +++ b/qga/commands-common.h
> @@ -80,4 +80,6 @@ GuestFileRead *guest_file_read_unsafe(GuestFileHandle
> *gfh,
>   */
>  char *qga_get_host_name(Error **errp);
>
> +int kill_process_tree(int64_t pid);
> +
>  #endif
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 697c65507c..5aa43a9ed7 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -27,6 +27,7 @@
>  #include <lm.h>
>  #include <wtsapi32.h>
>  #include <wininet.h>
> +#include <tlhelp32.h>
>
>  #include "guest-agent-core.h"
>  #include "vss-win32.h"
> @@ -2522,3 +2523,66 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error
> **errp)
>      error_setg(errp, QERR_UNSUPPORTED);
>      return NULL;
>  }
> +
> +int kill_process_tree(int64_t pid)
> +{
> +    PROCESSENTRY32 proc_entry;
> +    HANDLE snapshot, process;
> +    GList *pid_entry, *pid_list =3D NULL;
> +    bool added, success;
> +    int res =3D 0;
> +
> +    snapshot =3D CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
> +    if (snapshot =3D=3D INVALID_HANDLE_VALUE) {
> +        return GetLastError();
> +    }
> +
> +    pid_list =3D g_list_append(pid_list, GUINT_TO_POINTER(pid));
> +
> +    proc_entry.dwSize =3D sizeof(PROCESSENTRY32);
> +    do {
> +        added =3D false;
> +        for (success =3D Process32First(snapshot, &proc_entry);
> +             success; success =3D Process32Next(snapshot, &proc_entry)) =
{
> +            gpointer ppid_p, pid_p;
> +            ppid_p =3D GUINT_TO_POINTER(proc_entry.th32ParentProcessID);
> +            pid_p =3D GUINT_TO_POINTER(proc_entry.th32ProcessID);
> +            if (g_list_find(pid_list, ppid_p) && !g_list_find(pid_list,
> pid_p)) {
> +                pid_list =3D g_list_append(pid_list, pid_p);
> +                added =3D true;
> +            }
> +        }
> +    } while (added);
>
+
> +    for (success =3D Process32First(snapshot, &proc_entry);
> +         success; success =3D Process32Next(snapshot, &proc_entry)) {
> +        if (g_list_find(pid_list,
> GUINT_TO_POINTER(proc_entry.th32ProcessID))) {
> +            g_debug("killing pid=3D%u ppid=3D%u name=3D%s",
> +                (guint)proc_entry.th32ProcessID,
> +                (guint)proc_entry.th32ParentProcessID,
> +                proc_entry.szExeFile);
> +        }
> +    }
> +
>


Why do we need to store these processes before termination?
I understand that we need to enumerate all processes to find children
but why we can't terminate it on the fly?


> +    CloseHandle(snapshot);
> +
> +    for (pid_entry =3D pid_list; pid_entry; pid_entry =3D pid_entry->nex=
t) {
> +        pid =3D GPOINTER_TO_UINT(pid_entry->data);
> +        process =3D OpenProcess(PROCESS_TERMINATE, FALSE, pid);
> +        if (process =3D=3D INVALID_HANDLE_VALUE) {
> +            if (!res) {
> +                res =3D GetLastError();
> +                if (res =3D=3D ERROR_FILE_NOT_FOUND) {
> +                    res =3D 0;
> +                }
> +            }
> +            continue;
> +        }
> +        TerminateProcess(process, 255);
> +        CloseHandle(process);
> +    }
> +
> +    g_list_free(pid_list);
> +
> +    return res;
> +}
> diff --git a/qga/commands.c b/qga/commands.c
> index ce172edd2d..af8459c587 100644
> --- a/qga/commands.c
> +++ b/qga/commands.c
> @@ -529,6 +529,40 @@ done:
>      return ge;
>  }
>
> +void qmp_guest_exec_terminate(int64_t pid, Error **errp)
> +{
> +    GuestExecInfo *gei;
> +
> +    slog("guest-exec-terminate called, pid: %u", (uint32_t)pid);
> +
> +    gei =3D guest_exec_info_find(pid);
> +    if (gei =3D=3D NULL) {
> +        error_setg(errp, QERR_INVALID_PARAMETER, "pid");
> +        return;
> +    }
> +
> +    if (gei->finished) {
> +        return;
> +    }
> +
> +#ifdef G_OS_WIN32
> +    char buf[32];
> +    int res;
> +
> +    res =3D kill_process_tree(pid);
> +    if (res !=3D 0) {
> +        snprintf(buf, sizeof(buf), "win32 err %d", res);
> +        error_setg(errp, QERR_QGA_COMMAND_FAILED, buf);
> +    }
> +#else
> +    if (kill(pid, SIGKILL) < 0) {
> +        if (errno !=3D ESRCH) {
> +            error_setg(errp, QERR_QGA_COMMAND_FAILED, strerror(errno));
> +        }
> +    }
> +#endif
> +}
> +
>  /* Convert GuestFileWhence (either a raw integer or an enum value) into
>   * the guest's SEEK_ constants.  */
>  int ga_parse_whence(GuestFileWhence *whence, Error **errp)
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 876e2a8ea8..b39be4cdc2 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1326,6 +1326,19 @@
>                 '*input-data': 'str', '*capture-output':
> 'GuestExecCaptureOutput' },
>    'returns': 'GuestExec' }
>
> +##
> +# @guest-exec-terminate:
> +#
> +# Terminate process associated with PID retrieved via guest-exec.
> +#
> +# @pid: pid returned from guest-exec
> +#
> +# Returns: Nothing on success.
> +#
> +# Since: 8.2
> +##
> +{ 'command': 'guest-exec-terminate',
> +  'data':    { 'pid': 'int' } }
>
>  ##
>  # @GuestHostName:
> --
> 2.34.1
>
>

--00000000000029704706089a4ca9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 25, 2023 at 5:01=E2=80=AF=
PM Alexander Ivanov &lt;<a href=3D"mailto:alexander.ivanov@virtuozzo.com">a=
lexander.ivanov@virtuozzo.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">We need to terminate processes executed with g=
uest-exec command. Add<br>
guest-exec-terminate command for process termination by PID.<br>
<br>
Signed-off-by: Alexander Ivanov &lt;<a href=3D"mailto:alexander.ivanov@virt=
uozzo.com" target=3D"_blank">alexander.ivanov@virtuozzo.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-common.h |=C2=A0 2 ++<br>
=C2=A0qga/commands-win32.c=C2=A0 | 64 +++++++++++++++++++++++++++++++++++++=
++++++<br>
=C2=A0qga/commands.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 34 ++++++++++++++++++++++=
+<br>
=C2=A0qga/qapi-schema.json=C2=A0 | 13 +++++++++<br>
=C2=A04 files changed, 113 insertions(+)<br>
<br>
diff --git a/qga/commands-common.h b/qga/commands-common.h<br>
index 8c1c56aac9..34b9a22578 100644<br>
--- a/qga/commands-common.h<br>
+++ b/qga/commands-common.h<br>
@@ -80,4 +80,6 @@ GuestFileRead *guest_file_read_unsafe(GuestFileHandle *gf=
h,<br>
=C2=A0 */<br>
=C2=A0char *qga_get_host_name(Error **errp);<br>
<br>
+int kill_process_tree(int64_t pid);<br>
+<br>
=C2=A0#endif<br>
diff --git a/qga/commands-win32.c b/qga/commands-win32.c<br>
index 697c65507c..5aa43a9ed7 100644<br>
--- a/qga/commands-win32.c<br>
+++ b/qga/commands-win32.c<br>
@@ -27,6 +27,7 @@<br>
=C2=A0#include &lt;lm.h&gt;<br>
=C2=A0#include &lt;wtsapi32.h&gt;<br>
=C2=A0#include &lt;wininet.h&gt;<br>
+#include &lt;tlhelp32.h&gt;<br>
<br>
=C2=A0#include &quot;guest-agent-core.h&quot;<br>
=C2=A0#include &quot;vss-win32.h&quot;<br>
@@ -2522,3 +2523,66 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **er=
rp)<br>
=C2=A0 =C2=A0 =C2=A0error_setg(errp, QERR_UNSUPPORTED);<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
+<br>
+int kill_process_tree(int64_t pid)<br>
+{<br>
+=C2=A0 =C2=A0 PROCESSENTRY32 proc_entry;<br>
+=C2=A0 =C2=A0 HANDLE snapshot, process;<br>
+=C2=A0 =C2=A0 GList *pid_entry, *pid_list =3D NULL;<br>
+=C2=A0 =C2=A0 bool added, success;<br>
+=C2=A0 =C2=A0 int res =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 snapshot =3D CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)=
;<br>
+=C2=A0 =C2=A0 if (snapshot =3D=3D INVALID_HANDLE_VALUE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return GetLastError();<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 pid_list =3D g_list_append(pid_list, GUINT_TO_POINTER(pid));=
<br>
+<br>
+=C2=A0 =C2=A0 proc_entry.dwSize =3D sizeof(PROCESSENTRY32);<br>
+=C2=A0 =C2=A0 do {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 added =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (success =3D Process32First(snapshot, &amp=
;proc_entry);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0success; success =3D Proce=
ss32Next(snapshot, &amp;proc_entry)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpointer ppid_p, pid_p;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ppid_p =3D GUINT_TO_POINTER(proc=
_entry.th32ParentProcessID);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pid_p =3D GUINT_TO_POINTER(proc_=
entry.th32ProcessID);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_list_find(pid_list, ppid_p=
) &amp;&amp; !g_list_find(pid_list, pid_p)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pid_list =3D g_lis=
t_append(pid_list, pid_p);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 added =3D true;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 } while (added); <br></blockquote><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 for (success =3D Process32First(snapshot, &amp;proc_entry);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0success; success =3D Process32Next(snaps=
hot, &amp;proc_entry)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_list_find(pid_list, GUINT_TO_POINTER(pro=
c_entry.th32ProcessID))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_debug(&quot;killing pid=3D%u p=
pid=3D%u name=3D%s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (guint)proc_entry.=
th32ProcessID,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (guint)proc_entry.=
th32ParentProcessID,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 proc_entry.szExeFi=
le);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br></blockquote><div><br></div><div><div><br></div><div>Why do we need to=
 store these processes before termination? <br></div><div>I understand that=
 we need to enumerate all processes to find children</div><div>but why we c=
an&#39;t terminate it on the fly? <br></div></div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 CloseHandle(snapshot);<br>
+<br>
+=C2=A0 =C2=A0 for (pid_entry =3D pid_list; pid_entry; pid_entry =3D pid_en=
try-&gt;next) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pid =3D GPOINTER_TO_UINT(pid_entry-&gt;data);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 process =3D OpenProcess(PROCESS_TERMINATE, FAL=
SE, pid);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (process =3D=3D INVALID_HANDLE_VALUE) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!res) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D GetLastErr=
or();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (res =3D=3D ERR=
OR_FILE_NOT_FOUND) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =
=3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TerminateProcess(process, 255);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseHandle(process);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 g_list_free(pid_list);<br>
+<br>
+=C2=A0 =C2=A0 return res;<br>
+}<br>
diff --git a/qga/commands.c b/qga/commands.c<br>
index ce172edd2d..af8459c587 100644<br>
--- a/qga/commands.c<br>
+++ b/qga/commands.c<br>
@@ -529,6 +529,40 @@ done:<br>
=C2=A0 =C2=A0 =C2=A0return ge;<br>
=C2=A0}<br>
<br>
+void qmp_guest_exec_terminate(int64_t pid, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestExecInfo *gei;<br>
+<br>
+=C2=A0 =C2=A0 slog(&quot;guest-exec-terminate called, pid: %u&quot;, (uint=
32_t)pid);<br>
+<br>
+=C2=A0 =C2=A0 gei =3D guest_exec_info_find(pid);<br>
+=C2=A0 =C2=A0 if (gei =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_INVALID_PARAMETER, &quot=
;pid&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (gei-&gt;finished) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+#ifdef G_OS_WIN32<br>
+=C2=A0 =C2=A0 char buf[32];<br>
+=C2=A0 =C2=A0 int res;<br>
+<br>
+=C2=A0 =C2=A0 res =3D kill_process_tree(pid);<br>
+=C2=A0 =C2=A0 if (res !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 snprintf(buf, sizeof(buf), &quot;win32 err %d&=
quot;, res);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_QGA_COMMAND_FAILED, buf)=
;<br>
+=C2=A0 =C2=A0 }<br>
+#else<br>
+=C2=A0 =C2=A0 if (kill(pid, SIGKILL) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D ESRCH) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, QERR_QGA_COMMAN=
D_FAILED, strerror(errno));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+#endif<br>
+}<br>
+<br>
=C2=A0/* Convert GuestFileWhence (either a raw integer or an enum value) in=
to<br>
=C2=A0 * the guest&#39;s SEEK_ constants.=C2=A0 */<br>
=C2=A0int ga_parse_whence(GuestFileWhence *whence, Error **errp)<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 876e2a8ea8..b39be4cdc2 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1326,6 +1326,19 @@<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;*input-data&#3=
9;: &#39;str&#39;, &#39;*capture-output&#39;: &#39;GuestExecCaptureOutput&#=
39; },<br>
=C2=A0 =C2=A0&#39;returns&#39;: &#39;GuestExec&#39; }<br>
<br>
+##<br>
+# @guest-exec-terminate:<br>
+#<br>
+# Terminate process associated with PID retrieved via guest-exec.<br>
+#<br>
+# @pid: pid returned from guest-exec<br>
+#<br>
+# Returns: Nothing on success.<br>
+#<br>
+# Since: 8.2<br>
+##<br>
+{ &#39;command&#39;: &#39;guest-exec-terminate&#39;,<br>
+=C2=A0 &#39;data&#39;:=C2=A0 =C2=A0 { &#39;pid&#39;: &#39;int&#39; } }<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestHostName:<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--00000000000029704706089a4ca9--


