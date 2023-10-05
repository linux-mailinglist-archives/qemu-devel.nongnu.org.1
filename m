Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2408F7B9CDA
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 13:58:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoMyk-0005aA-5P; Thu, 05 Oct 2023 07:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoMyi-0005Zc-6X
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 07:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoMyd-0002g8-U7
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 07:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696507030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+/N5B4S6L0a9eEYKUi1Gw/lFxaPashkLcSCEvR/v+24=;
 b=UU6Mu6owullw2AKVSzEYbGVZ/8v07777jVyL2JZx6ii4vAswc/0OeZRl/73V5r3SvJAO3j
 xHHSG0w/63A0953fn8fJNya1BJWhzN0eT20JKwZptNB8VO44GfFVC/BBD8uDeTKFxKhmkn
 YJhKyO1ZNuJWXLy7Gmd7mT4pDLgYRjk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-ghBZ_yRWP7izY42Tpex4Dg-1; Thu, 05 Oct 2023 07:57:07 -0400
X-MC-Unique: ghBZ_yRWP7izY42Tpex4Dg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 978EA85A5BF;
 Thu,  5 Oct 2023 11:57:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 381EE2026D4B;
 Thu,  5 Oct 2023 11:57:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 26B5221E6904; Thu,  5 Oct 2023 13:57:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,  qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Konstantin
 Kostiuk <kkostiuk@redhat.com>
Subject: Re: [RFC PATCH v2 21/22] qapi: Inline and remove QERR_UNSUPPORTED
 definition
References: <20231005045041.52649-1-philmd@linaro.org>
 <20231005045041.52649-22-philmd@linaro.org>
Date: Thu, 05 Oct 2023 13:57:05 +0200
In-Reply-To: <20231005045041.52649-22-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Oct 2023 06:50:38
 +0200")
Message-ID: <87lech46zy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Address the comment added in commit 4629ed1e98
> ("qerror: Finally unused, clean up"), from 2015:
>
>   /*
>    * These macros will go away, please don't use
>    * in new code, and do not add new ones!
>    */
>
> Mechanical transformation using:
>
>   $ sed -i -e 's/QERR_UNSUPPORTED/"this feature or command is not current=
ly supported"/' \
>     $(git grep -wl QERR_UNSUPPORTED)
>
> then manually removing the definition in include/qapi/qmp/qerror.h.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> RFC: Not sure what is the best way to change the comment
>      in qga/qapi-schema.json...
> ---
>  qga/qapi-schema.json      |  5 +++--
>  include/qapi/qmp/qerror.h |  3 ---
>  qga/commands-bsd.c        |  8 +++----
>  qga/commands-posix.c      | 46 +++++++++++++++++++--------------------
>  qga/commands-win32.c      | 22 +++++++++----------
>  5 files changed, 41 insertions(+), 43 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index b720dd4379..51683f4dc2 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -6,8 +6,9 @@
   ##
   # =3D General note concerning the use of guest agent interfaces
>  #
>  # "unsupported" is a higher-level error than the errors that
>  # individual commands might document.  The caller should always be
> -# prepared to receive QERR_UNSUPPORTED, even if the given command
> -# doesn't specify it, or doesn't document any failure mode at all.
> +# prepared to receive the "this feature or command is not currently supp=
orted"
> +# message, even if the given command doesn't specify it, or doesn't docu=
ment
> +# any failure mode at all.
>  ##
>=20=20
>  ##

The comment is problematic before the patch.  It's a doc comment,
i.e. it goes into the "QEMU Guest Agent Protocol Reference" manual,
where QERR_UNSUPPORTED is meaningless.  Back when the comment was added
(commit 9481ecd737b "qga schema: document generic QERR_UNSUPPORTED"), it
was still internal documentation, where QERR_UNSUPPORTED made sense.  It
became external documentation four years later (commit 56e8bdd46a8
"build-sys: add qapi doc generation targets")

I'm not sure how useful the comment is.

I guess we could instead simply point out that clients should always be
prepared for errors, even when the command doesn't document any, simply
because commands need not exist in all versions or builds of qemu-ga.

> diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
> index 840831cc6a..7606f4525d 100644
> --- a/include/qapi/qmp/qerror.h
> +++ b/include/qapi/qmp/qerror.h
> @@ -17,7 +17,4 @@
>   * add new ones!
>   */
>=20=20
> -#define QERR_UNSUPPORTED \
> -    "this feature or command is not currently supported"
> -
>  #endif /* QERROR_H */
> diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
> index 17bddda1cf..11536f148f 100644
> --- a/qga/commands-bsd.c
> +++ b/qga/commands-bsd.c
> @@ -152,25 +152,25 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)
>=20=20
>  GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
>  GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
>  GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
>  GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }

These are all commands that are not supported by this build of qemu-ga.
We could use the opportunity to improve the error message: scratch
"feature or ".  Or maybe change the message to "this command is not
supported in this version of qemu-ga".

More of the same below, marked [*].

Taking a step back...  Do we really need to make this a failure of its
own?  Why not fail exactly as if the command didn't exist?  Why would a
client ever care for the difference between "command doesn't exist in
this build of qemu-ga (but it does in other builds of this version of
qemu-ga)" and "command doesn't exist in this build of qemu-ga (and it
won't in any build of this version of qemu-ga)"?

If clients don't care, we could instead unregister these commands,
i.e. undo qmp_register_command().  The command will then fail exactly
like any other unknown command.  We still need to provide the functions
to make the linker happy (unless we play with weak symbols), but they
can simply abort().

Michael and/or Konstantin, do you have comments as maintainers?  A
preference even?

Hmm, there's yet another mechanism to disable commands:
qmp_disable_command() & friends.  Looks like its purpose is letting
guest system administrators disable commands, and also to disable a
bunch of commands in "frozen state", whatever that is.  Alright, I
didn't see that, lalala.

>  #endif /* CONFIG_FSFREEZE */
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 6169bbf7a0..f510add366 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -165,7 +165,7 @@ void qmp_guest_set_time(bool has_time, int64_t time_n=
s, Error **errp)
>      }
>=20=20
>      if (!hwclock_available) {
> -        error_setg(errp, QERR_UNSUPPORTED);
> +        error_setg(errp, "this feature or command is not currently suppo=
rted");
>          return;
>      }
>=20=20

!hwclock_available means /sbin/hwclock grants execute permission for the
process's real UID and GID.  I'm not sure why we bother to check that.
Why not let execl() fail, and report that error?  Oh, we don't:

           /* Use '/sbin/hwclock -w' to set RTC from the system time,
            * or '/sbin/hwclock -s' to set the system time from RTC. */
           execl(hwclock_path, "hwclock", has_time ? "-w" : "-s", NULL);
           _exit(EXIT_FAILURE);

This is wrong.  We should error_setg_errno(errp, errno, ...); return
instead.  Not your patch's problem.

Until we do that: [*]

> @@ -1540,7 +1540,7 @@ GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
>=20=20
>  GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }

Command not supported by this build of qemu-qa: [*].

>=20=20
> @@ -2235,7 +2235,7 @@ void qmp_guest_set_user_password(const char *userna=
me,
>                                   bool crypted,
>                                   Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>  }
>  #endif /* __linux__ || __FreeBSD__ */
>=20=20
> @@ -2751,47 +2751,47 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error *=
*errp)
>=20=20
>  void qmp_guest_suspend_disk(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>  }
>=20=20
>  void qmp_guest_suspend_ram(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>  }
>=20=20
>  void qmp_guest_suspend_hybrid(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>  }
>=20=20
>  GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
>  int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **er=
rp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return -1;
>  }
>=20=20
>  GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
>  GuestMemoryBlockResponseList *
>  qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
>  GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
> @@ -3056,7 +3056,7 @@ error:
>=20=20
>  GuestNetworkInterfaceList *qmp_guest_network_get_interfaces(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
> @@ -3066,20 +3066,20 @@ GuestNetworkInterfaceList *qmp_guest_network_get_=
interfaces(Error **errp)
>=20=20
>  GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
>  GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>=20=20
>      return 0;
>  }
>=20=20
>  int64_t qmp_guest_fsfreeze_freeze(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>=20=20
>      return 0;
>  }
> @@ -3088,33 +3088,33 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_m=
ountpoints,
>                                         strList *mountpoints,
>                                         Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>=20=20
>      return 0;
>  }
>=20=20
>  int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>=20=20
>      return 0;
>  }
>=20=20
>  GuestDiskInfoList *qmp_guest_get_disks(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
>  GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
>  GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
> @@ -3124,7 +3124,7 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **e=
rrp)
>  GuestFilesystemTrimResponse *
>  qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>  #endif
> @@ -3243,7 +3243,7 @@ GuestUserList *qmp_guest_get_users(Error **errp)
>=20=20
>  GuestUserList *qmp_guest_get_users(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
> @@ -3386,7 +3386,7 @@ GuestOSInfo *qmp_guest_get_osinfo(Error **errp)
>=20=20
>  GuestDeviceInfoList *qmp_guest_get_devices(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>=20=20
>      return NULL;
>  }

Commands not supported by this build of qemu-qa: [*].

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index aa8c9770d4..5c9f8e0923 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -1213,7 +1213,7 @@ GuestFilesystemInfoList *qmp_guest_get_fsinfo(Error=
 **errp)
>  GuestFsfreezeStatus qmp_guest_fsfreeze_status(Error **errp)
>  {
>      if (!vss_initialized()) {
> -        error_setg(errp, QERR_UNSUPPORTED);
> +        error_setg(errp, "this feature or command is not currently suppo=
rted");
>          return 0;
>      }
>=20=20
> @@ -1241,7 +1241,7 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mou=
ntpoints,
>      Error *local_err =3D NULL;
>=20=20
>      if (!vss_initialized()) {
> -        error_setg(errp, QERR_UNSUPPORTED);
> +        error_setg(errp, "this feature or command is not currently suppo=
rted");
>          return 0;
>      }
>=20=20
> @@ -1276,7 +1276,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
>      int i;
>=20=20
>      if (!vss_initialized()) {
> -        error_setg(errp, QERR_UNSUPPORTED);
> +        error_setg(errp, "this feature or command is not currently suppo=
rted");
>          return 0;
>      }
>=20=20

!vss_initialized() means qga-vss.dll failed to load and initialize.

Another [*].

> @@ -1509,7 +1509,7 @@ out:
>=20=20
>  void qmp_guest_suspend_hybrid(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>  }
>=20=20
>  static IP_ADAPTER_ADDRESSES *guest_get_adapters_addresses(Error **errp)
> @@ -1877,7 +1877,7 @@ GuestLogicalProcessorList *qmp_guest_get_vcpus(Erro=
r **errp)
>=20=20
>  int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **er=
rp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return -1;
>  }
>=20=20

Commands not supported by this build of qemu-qa: [*].

> @@ -1938,7 +1938,7 @@ void qmp_guest_set_user_password(const char *userna=
me,
>      GError *gerr =3D NULL;
>=20=20
>      if (crypted) {
> -        error_setg(errp, QERR_UNSUPPORTED);
> +        error_setg(errp, "this feature or command is not currently suppo=
rted");
>          return;
>      }

Command does not support "crypted": true in this build of qemu-ga.  The
error message is crap.  Better would be some variation of "this machine
supports only clear-text passwords".

>=20=20
> @@ -1983,20 +1983,20 @@ done:
>=20=20
>  GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
>  GuestMemoryBlockResponseList *
>  qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
>  GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
> @@ -2522,12 +2522,12 @@ char *qga_get_host_name(Error **errp)
>=20=20
>  GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }
>=20=20
>  GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
>  {
> -    error_setg(errp, QERR_UNSUPPORTED);
> +    error_setg(errp, "this feature or command is not currently supported=
");
>      return NULL;
>  }

Commands not supported by this build of qemu-qa: [*].

Summary of my review:

* You're unsure about your change to the "General note concerning the
  use of guest agent interfaces".  I suggested a way to rewrite it.

* Error messages could use improvement.  Since your patch doesn't change
  any, feel free to leave that for another day.

* How we do compiled-out commands could use improvement.  Feel even more
  free to leave for another day.  I'd like to hear the maintainers'
  opinion, though.


